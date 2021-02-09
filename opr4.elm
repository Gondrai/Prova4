module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


--Definindo tipos da msg
--Definindo modelos dos tipos
type alias Model = {i1 : Float, i2 : Float, resultado : Float}
type Msg = Input1 String | Input2 String | AreaTriangulo


padraoI : String -> Float
padraoI input = 
    Maybe.withDefault 0 ( String.toFloat input )

-- MAIN
init : Model
init = {i1 = 0, i2 = 0, resultado = 0}
main =
  Browser.sandbox
  {
    init = init,
    update = update,
    view = view
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    Input1 valor -> {model | i1 = (padraoI valor)}
    Input2 valor -> {model | i2 = (padraoI valor)}
    AreaTriangulo -> {model | resultado = ((model.i1) * (model.i2))/2}
                
buttonStyle : List (Attribute msg) 
buttonStyle = [ style "color" "#bf2f80" , style "width" "150px" , style "font-weight" "bold" , style "font-size" ""]
view : Model -> Html Msg
view model =
  div [style "background-color" "#66CDAA", style "padding" "10% 10%" ]
    [div [style "padding" "12% 30%", style "margin" "50px", style "background-color" "#123e3b" ]
        [ h1 [style "color" "#bf2f80"] [text "Calcular área do triângulo"]
        , div []
        [p []
        [ text "Informe os valores de base e altura para calcular:"]  
        , p []
        [input [type_ "number", onInput Input1, style "width" "180px"] [], text " < Base "
        , input [type_ "number", onInput Input2, style "width" "180px"] [], text " < Altura "]
        , p [][
        button [onClick AreaTriangulo] [text "Calcular"]]
        , div []
        [text "A área do triângulo é:"
        ] , div []
        [text (String.fromFloat(model.resultado))]
        ]]]




