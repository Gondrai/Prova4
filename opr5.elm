module Main exposing (..)
import Html exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

--Definindo tipos da msg
--Definindo modelos dos tipos
-- MODEL
type alias Model = { a : String, resultado : String }

init : Model
init = Model "" ""

-- UPDATE
type Msg = A String
         | Calcular
         | Resultado String
         
split : String -> List String
split = String.split ""

toint : List (Maybe Int) -> List Int
toint = List.map fromMaybe

tomaybe : List String -> List (Maybe Int)
tomaybe = List.map String.toInt   

fromMaybe : Maybe Int -> Int
fromMaybe maybe =
  case maybe of
    Nothing -> 0
    Just numero -> numero

last : List Int -> Int
last lista =
    case lista of
    [] -> 0
    [x] -> x
    x::xs -> x*0 + (last xs)
    
vdd : Int -> Int -> String
vdd x y = if x == y then "RG Válido" else "RG Inválido"

listmult : List Int -> Int
listmult lista =
    let
        n = 8
    in
    case lista of
    [] -> 0
    [x] -> 0
    x::xs -> remainderBy 11 ((x*n + (listmult xs))//11) 

update : Msg -> Model -> Model
update msg model =
  case msg of
    A x1 -> { model | a = x1}
    Calcular -> {model | resultado =vdd (listmult(toint(tomaybe(split model.a)))) (last(toint(tomaybe(split model.a))))}
    Resultado result -> {model | resultado = result} 

-- VIEW
view : Model -> Html Msg
view model =
  div [style "background-color" "#66CDAA", style "padding" "10% 10%"][
  div [style "padding" "12% 30%", style "margin" "50px", style "background-color" "#123e3b" ] 
      [ h1 [style "color" "#bf2f80"] [text "Validador de RG"]
      , div []
      [p []
      [ input [ placeholder "Insira o RG aqui", value model.a, onInput A ] []
      , p [] [
      button [onClick Calcular] [text "Validar"]]
      , div [] [text (model.resultado)]
      ]]
      , p [] [text "Obs.: Mesmo que o RG seja inválido ele pode existir pois os municípios tem total liberdade de seguir ou não o Dígito verificador"]]
  ]