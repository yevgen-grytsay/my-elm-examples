module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App as App
import Mouse exposing (..)
import String


-- Commands and Subscriptions https://guide.elm-lang.org/architecture/effects/
-- Mouse http://package.elm-lang.org/packages/elm-lang/mouse/1.0.0/Mouse
-- Anonymous Functions https://guide.elm-lang.org/types/reading_types.html


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    ( Int, Int )


init : ( Model, Cmd Msg )
init =
    ( ( 0, 0 ), Cmd.none )



-- UPDATE


type Msg
    = Position Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Position x y ->
            ( ( x, y ), Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves (\{ x, y } -> Position x y)
        ]



-- VIEW


printModel : Model -> String
printModel model =
    String.concat
        [ "("
        , toString (fst model)
        , "; "
        , toString (snd model)
        , ")"
        ]


view : Model -> Html Msg
view model =
    div [] [ text (printModel model) ]
