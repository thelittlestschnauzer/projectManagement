<template>
<draggable class="row">

    <div v-for="(list, index) in lists" class="col-3">
      <h6>{{ list.name }}</h6>
      <hr />

      <div v-for="(card, index) in list.cards" class="card card-body">
        {{ card.name }}
      </div>

      <div class="card card-body">
      <textarea v-model="messages[list.id]" class="form-control"></textarea>
        <button v-on:click="submitMessages(list.id)" class="btn">Add</button>
      </div>   
    </div>
  
  </draggable>
</template>

<script>
import draggable from 'vuedraggable'

export default {
  components: { draggable },
  
  props: ["original_lists"],
  data: function() {
    return {
      messages: {}, 
      lists: this.original_lists,
    }
  }, 

  methods: {
    submitMessages: function(list_id) {
      
      var data = new FormData 

      data.append("card[list_id]", list_id)
      data.append("card[name]", this.messages[list_id])

      Rails.ajax({  
        url: "/cards",
        type: "POST",
        data: data, 
        dataType: "json",
        success: (data) => { 
          const index = this.lists.findIndex(item => item.id == list_id) 
          this.lists[index].cards.push(data)
          this.messages[list_id] = undefined 
        }
      })
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
