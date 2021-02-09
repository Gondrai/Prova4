module RandomNumber exposing (Model)

import Html exposing (..)
import Html.Events exposing (..)
import Random
import Html.Attributes exposing (..)
import Browser
-- MAIN
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
--Definindo tipos da msg
--Definindo modelos dos tipos
type alias Model =
    Int

type Msg
    = GenerateRandomNumber | NewRandomNumber Int    

init : () -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )

initialModel : Model
initialModel =
    0

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateRandomNumber ->
            ( model, Random.generate NewRandomNumber (Random.int 99999999 999999999) )
        NewRandomNumber number ->
            ( number, Cmd.none )

view : Model -> Html Msg
view model =
  div [style "background-color" "#66CDAA", style "padding" "10% 10%"][
    div [style "padding" "12% 30%", style "margin" "50px", style "background-color" "#123e3b" ]
        [ h1 [style "color" "#bf2f80"] [text "Gerar RG aleatório"]
        , div []
        [p []
        [ text "Informe os valores para calcular:"]  
        , p [][]
        , div[style "margin-top" "10%"][textarea[ style "background" "whitesmoke", style "width" "100px", style "height" "25px",style "color" "rgb(29, 29, 29)", style "margin-left" "10%", style "resize" "none"][text (String.fromInt(model))]],   
          div []
        [ button [style "margin-top" "50px", style "margin-left" "10%", onClick GenerateRandomNumber]
            [ text "Gerar RG" ]
        ]
    ]
  ]]
              