class PetsController < ApplicationController

  set :views, 'app/views/pets'

  get '/pets' do
    @pets = Pet.all
    erb :index
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :new
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name])
    # binding.pry
    if params[:owner_name].empty?
      @owner = Owner.find(params[:owner_id])
    else
      @owner = Owner.create(name: params[:owner_name])
    end
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :show
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :edit
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if params[:owner][:name].empty?
      @owner = Owner.find(params[:owner][:id])
    else
      @owner = Owner.create(name: params[:owner][name])
    end
    @pet.update(name: params[:pet_name],
                owner: @owner)
    @pet.owner.update(name: params[:owner_name]) unless params[:owner_name].empty?
    redirect to "pets/#{@pet.id}"
  end
end