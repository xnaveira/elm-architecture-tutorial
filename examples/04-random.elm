import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace : (Int, Int)
  }


init : (Model, Cmd Msg)
init =
  (Model (1, 1), Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace ( Random.pair (Random.int 1 6) (Random.int 1 6) ))

    NewFace newFace ->
      (Model newFace, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW

assignImage : Int -> String
assignImage x =
   let
      a =
         case x of
            1 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2FQ%2Fs%2FJ%2FJ%2Fs%2FK%2Fnumber-1-hi.png&f=1"
            2 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2Fh%2FY%2Fi%2FC%2FY%2FW%2Fred-rounded-square-with-number-2-hi.png&f=1"
            3 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2Fx%2FB%2Fx%2FY%2FR%2FL%2Fnumber-3-hi.png&f=1"
            4 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2FG%2FR%2Fw%2F9%2Fq%2Fd%2Fred-rounded-with-number-4-hi.png&f=1"
            5 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2Fu%2Fb%2FG%2Fk%2Fo%2Fj%2Fnumber-5-hi.png&f=1"
            6 ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.clker.com%2Fcliparts%2Fg%2Fq%2Fz%2FR%2FK%2Fz%2Fnumber-6-hi.png&f=1"
            _ ->
               "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fi0.kym-cdn.com%2Fphotos%2Fimages%2Fnewsfeed%2F000%2F003%2F309%2Fi-dunno-lol.jpg%3F1244616130&f=1"
   in
      a

showImage : (Int, Int) -> Html Msg
showImage dieFace =
   let
      ( i, j ) = dieFace
      a = assignImage i
      b = assignImage j
   in
      div [] [ img [ src a ] [], img [ src b ] [] ]


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , showImage model.dieFace
    , button [ onClick Roll ] [ text "Roll" ]
    ]
