import {Socket} from "phoenix"

const Chat = {
    init() {
        let socket = new Socket("/socket")
        socket.connect()

    let channel = socket.channel("lobby", {})
    let list = document.querySelector('#message-list')
    let message = document.querySelector('#message')
    let name = document.querySelector('#name')

    message.addEventListener('keypress', event => {
        if(event.key === 'Enter') {
            console.log('Sending message:', name.value, message.value)
            channel.push('new_message', {name: name.value, body: message.value})
            message.value = ''
        }
    })

    channel.on('new_message', payload => {
        console.log('Received message:', payload)
        let li = document.createElement('li')
        li.textContent = `${payload.name}: ${payload.body}`
        list.appendChild(li)
    })

    channel.join()
    .receive("ok", resp => console.log("Joined successfully", resp))
    .receive("error", resp => console.log("Unable to join", resp))
    }
}

export default Chat