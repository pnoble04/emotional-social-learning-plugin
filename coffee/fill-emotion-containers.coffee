console.log($('.emotionContainer'))

fillAllEmotionContainers = ->
    emotionContainerHTML = 
        "<div class='oneEmotion'>
            <div class='emotionTexts'>
                <span class='negative'>bored</span>
                <span class='positive'>fascinated</span>
            </div>
        <div class='emotionSlider'></div>
        </div>
        <div class='oneEmotion'>
            <div class='emotionTexts'>
                <span class='negative'>overwhelmed</span>
                <span class='positive'>unchallenged</span>
            </div>
            <div class='emotionSlider'></div>
        </div>
        "
    $('.emotionContainer').html(emotionContainerHTML)

addSlidersToEmotionContainers = ->
    $('.emotionSlider').slider({
        min: 8,
        max: 28
        })

setupSlidersToChangeTextOnChange = ->
    $( ".emotionSlider" ).on( "slide slidechange", (event, ui) ->
        emotionTextElements = getTwoCorrespondingTextsOfSlider(ui.handle)
        console.log("emotext", emotionTextElements)
        setSizeOfEmotionTexts(emotionTextElements, ui.value)
        console.log("slider changed!:) to #{ui.value}")
        console.log(ui.handle)
    )
    $('.emotionSlider').slider("option", "value", 18);

getTwoCorrespondingTextsOfSlider = (sliderElement) ->
    return $(sliderElement).parent().parent().find('.emotionTexts span')

setSizeOfEmotionTexts = (emotionTextElements, sliderValue) ->
    positiveTextSize = sliderValue
    negativeTextSize = 28 - sliderValue + 8
    $(emotionTextElements).filter('.positive').css('font-size', positiveTextSize)
    $(emotionTextElements).filter('.negative').css('font-size', negativeTextSize)

fillAllEmotionContainers()
addSlidersToEmotionContainers()
setupSlidersToChangeTextOnChange()