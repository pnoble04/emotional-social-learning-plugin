console.log($('.emotionContainer'))

fillAllEmotionContainers = ->
    fillInvididualEmotionContainers()
    fillCommunityEmotionContainers()

fillInvididualEmotionContainers = ->
    emotionContainerHTML = 
        "<div class='oneEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />
            </div>
        <div class='emotionSlider'></div>
        </div>
        <div class='oneEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />
            </div>
            <div class='emotionSlider'></div>
        </div>
        "
    $('.emotionContainer').html(emotionContainerHTML)

fillCommunityEmotionContainers = ->
    emotionContainerHTML = 
        "<div class='communityEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />
            </div>
        </div>
        <div class='communityEmotion'>
            <div class='emotionPictures'>
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />
                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />
            </div>
        </div>
        "
    $('.communityEmotionContainer').html(emotionContainerHTML)

addSlidersToEmotionContainers = ->
    $('.emotionSlider').slider({
        min: 0,
        max: 10
        })

setupSlidersToChangePicturesOnChange = ->
    $( ".emotionSlider" ).on( "slide slidechange", (event, ui) ->
        emotionPictures = getTwoCorrespondingPicturesOfSlider(ui.handle)
        setSizeOfEmotionPictures(emotionPictures, ui.value)
    )
    $('.emotionSlider').slider("option", "value", 5);

getTwoCorrespondingPicturesOfSlider = (sliderElement) ->
    return $(sliderElement).parent().parent().find('.emotionPictures img')

setSizeOfEmotionPictures = (emotionPictures, sliderValue) ->
    firstOpacity = 1 - (sliderValue / 10)
    secondOpacity = sliderValue / 10
    $(emotionPictures).filter('.firstEmotion').css('opacity', firstOpacity)
    $(emotionPictures).filter('.secondEmotion').css('opacity', secondOpacity)

sendEmotionsOnSubmitButtonClick = ->
    $('#submitFeelings').click(sendEmotions)

sendEmotions = ->
    console.log("send emotions")
    emotionStateArray = getEmotionStateArray()
    sendEmotionStateArray(emotionStateArray)

getEmotionStateArray = ->
    emotionPictures = $('.oneEmotion .emotionPictures img.firstEmotion')
    opacityArray = []
    for emotionPicture in emotionPictures
        opacityArray.push(parseFloat($(emotionPicture).css('opacity')))
    console.log(opacityArray)
    return opacityArray

sendEmotionStateArray = (emotionStateArray) ->
    $.ajax ({
            url: 'http://zukunfts-management.de/emotional-social-learning/php/submitEmotionState.php'
            data: {
                emotionState: JSON.stringify(emotionStateArray)
            }
            dataType: "jsonp"
        }
    # jsonp resposne will call emotion state updated with emotion state array :)
    )

window.emotionStateUpdated = (newEmotionState) ->
    console.log("received")
    window.showEmotionState(newEmotionState)

getEmotionStateOfEverybodyAndShowIt = ->
    $.ajax ({
            url: 'http://zukunfts-management.de/emotional-social-learning/php/getEmotionState.php'
            dataType: "jsonp"
        }
    ) 
    # jsonp resposne will call showEmotionState with emotion state array :) 
    
window.showEmotionState = (emotionStateObject) ->
    emotionStateArray = emotionStateObject.emotionStateArray
    numberOfSubmissions = emotionStateObject.numberOfSubmissions
    emotionPictures = $('.communityEmotion img')
    emotionPictures.each( (index, element) ->
        firstEmotionOpacity = (emotionStateArray[Math.floor(index / 2)] / numberOfSubmissions)
        if ($(element).is('.firstEmotion'))
            opacity = firstEmotionOpacity
        else 
            opacity = 1 - firstEmotionOpacity
        $(element).css('opacity', opacity)
    )

fillAllEmotionContainers()
addSlidersToEmotionContainers()
setupSlidersToChangePicturesOnChange()
sendEmotionsOnSubmitButtonClick()
getEmotionStateOfEverybodyAndShowIt()