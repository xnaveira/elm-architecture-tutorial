import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char exposing (isDigit, isLower, isUpper)
import String exposing (any)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
         if String.length model.password > 8 then
            if String.any Char.isUpper model.password &&
               String.any Char.isLower model.password &&
               String.any Char.isDigit model.password then
                  ("green", "OK")
            else
                  ("red", "Should contain 1 upper, 1 lower, 1 digit")
         else
            ("red", "Password should be longer than 8 chars")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]
