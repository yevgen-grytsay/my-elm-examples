module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, Attribute, div, text, select, option)
import Html.App as Html
import Html.Events exposing (on)
import Html.Attributes exposing (..)
import Json.Decode as Json


main : Program Never
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type Msg
    = BandChange String


type alias Option =
    ( String, String )


type alias OptionSet =
    Dict String String


type alias Model =
    { name : String, bands : OptionSet }


model : Model
model =
    { name = "Default", bands = Dict.fromList [ ( "1", "Dire Straits" ), ( "2", "Iron Maiden" ) ] }


update : Msg -> Model -> Model
update msg model =
    case msg of
        BandChange val ->
            { model | name = val }


onChange : (String -> msg) -> Attribute msg
onChange handler =
    on "change" <| Json.map handler <| Json.at [ "target", "value" ] Json.string


viewOptions : OptionSet -> List (Html Msg)
viewOptions options =
    List.map
        viewOption
        (Dict.toList options)


viewOption : Option -> Html Msg
viewOption data =
    option [ value (fst data), selected (fst data == "1") ] [ data |> snd |> text ]


view : Model -> Html Msg
view model =
    div []
        [ text model.name
        , select
            [ onChange BandChange ]
            (viewOptions model.bands)
        ]
