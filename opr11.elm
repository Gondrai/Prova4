module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = { a : String, resultado : String }

init : Model
init = Model "" ""

-- UPDATE
type Msg
    = A String
    | Calcular
    | Resultado String

parastr : List String -> List (Maybe Int)
parastr = List.map String.toInt

separa : String -> List String
separa = String.split "" 

cpf : List (Maybe Int) -> List Int 
cpf = List.map fromMaybe

fromMaybe : Maybe Int -> Int
fromMaybe maybe =
  case maybe of
    Nothing -> -0
    Just numero -> numero

valida : List Int -> Int
valida list =
    case list of
    [] -> 0
    x::xs -> x + (valida xs)

true : Int -> String
true x = if List.member x [11,12,21,22,23,32,33,34,43,44,45,
                 54,55,56,65,66,67,76,77,78,87,88]
    then " CPF verdadeiro" else "CPF falso"
    
update : Msg -> Model -> Model
update msg model =
  case msg of
    A x1 -> { model | a = x1}
    Calcular -> {model | resultado = true(valida(cpf(parastr(separa model.a ))))}
    Resultado result -> {model | resultado = result}

-- VIEW
view : Model -> Html Msg
view model =
 div[style "background-color" "#66CDAA", style "padding" "10% 10%" ][
  div [style "padding" "12% 30%", style "margin" "50px", style "background-color" "#123e3b" ] 
      [ h1 [style "color" "#bf2f80"] [text "Validador de CPF"]
      , div []
      [p []
      [ input [ placeholder "Insira o CPF aqui", value model.a, onInput A ] []
      , p [] [
      button [onClick Calcular] [text "Validar"]]
      , div [] [ text  (model.resultado) ]
      ]]]]