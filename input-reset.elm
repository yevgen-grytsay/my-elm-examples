module Main exposing (..)

import String
import Html exposing (Html, div, text, input, button)
import Html.App as Html
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


main : Program Never
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { name : String }


model : Model
model =
    { name = "" }



-- UPDATE


type Msg
    = Reset
    | Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            updateName "" model

        Change something ->
            updateName something model


updateName : String -> Model -> Model
updateName msg model =
    { model | name = msg }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Enter your name", onInput Change, value model.name ] []
        , button [ onClick Reset ] [ text "Reset" ]
        , displayResult model
        ]


displayResult : Model -> Html Msg
displayResult model =
    let
        message =
            if String.length model.name > 0 then
                "Your name is: " ++ model.name
            else
                "Please provide your name"
    in
        div [] [ text message ]
