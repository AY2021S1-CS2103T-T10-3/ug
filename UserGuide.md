








<a name="ListRecipeCommand"></a>
#### 5.4.2&ensp;Listing Recipes --- **`list`**`recipes`
This command shows a list of all recipes in ChopChop. You can use this to switch panes (between recipes and ingredients) without using the mouse, as well as to clear any filters that might have been applied due to previous commands (eg. `find` and `filter`).

**Usage**: `list recipes`

<div markdown="span" class="alert alert-primary">
:bulb: **Tip:** For convenience, you can use either `list recipes` or `list recipe`.
</div>

Executing this command simply brings you back to the recipe list view:

<a name="Figure-7-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/list_recipes.png" width="75%" /> <br />
Figure 7: <i>The recipe list view</i>
</div>





<a name="AddRecipeCommand"></a>
#### 5.4.3&ensp;Adding Recipes --- **`add`**`recipe`
This command adds a recipe to ChopChop, and you can specify zero or more ingredients, each with an optional quantity, and zero or more steps. After a recipe is added, you will be able to see it immediately.

**Usage**:
```
add recipe <name>
  [/ingredient <ingredient-name> [/qty <quantity>]]...
  [/step <step>]...
  [/tag <tag-name>]...
```

Constraints:
- Recipe name must not be empty
- Ingredient names must not be empty
- Steps must not be empty
- Tag names must not be empty
- Quantities (`/qty`) must only appear after an `/ingredient`

If an ingredient is specified without a quantity, it is treated *as if* you used `/qty 1`. This works for counted ingredients (eg. eggs), but it will cause errors for other ingredients (eg. volume of milk).

If the ingredient does not <i>currently</i> exist in ChopChop, it is still okay to add a recipe using it (you might add it later). Recipes are only checked for correctness when you try to [`make`](#MakeRecipeCommand) them.

For example, suppose you wanted to add a recipe for pancakes using flour, eggs, and milk, you would type this:
```
add recipe Pancakes
/ingredient flour /qty 400g
/ingredient egg /qty 3
/ingredient milk /qty 250ml
/step Mix ingredients together
/step Bake for 30 minutes at 400 celsius
/step Pour syrup and serve
```
(note that this is displayed on separate lines for clarity, but you should type this in one go)

<a name="Figure-8-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_recipe_1.png" width="75%" /> <br />
Figure 8.1: <i>The add recipe command</i>
</div>

After pressing <kbd>enter</kbd>, you will see this view, showing your newly created recipe:

<a name="Figure-8-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_recipe_2.png" width="75%" /> <br />
Figure 8.2: <i>The recipe detail view</i>
</div>

If you go back to the main recipe view (either by clicking on the tab at the bottom, or by using `list recipes`, you can see the new recipe in the list (ChopChop won't actually highlight it, but we do here for clarity):

<a name="Figure-8-3"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_recipe_3.png" width="75%" /> <br />
Figure 8.3: <i>The newly created recipe in the recipe list</i>
</div>











<a name="EditRecipeCommand"></a>
#### 5.4.4&ensp;Editing Recipes --- **`edit`**`recipe`

This command edits a specific recipe in ChopChop, letting you perform different actions on the name, ingredients, steps, and tags, as specified below.

To accommodate the various different kinds of editing operations, ChopChop has special syntax for editing, known as *edit-arguments*, eg. `/step:add`. The component following the colon is the *ACTION*, which can take these values:

- For ingredients and steps, it can either be `add`, `edit`, or `delete`.
- For tags, it can be either `add` or `delete`.



<h4>Name</h4>
If you want to edit a recipe's name, simply use `/name`, for example `/name new recipe name`.


<h4>Ingredients</h4>
If you want to edit a recipe's ingredients, use `/ingredient` with the corresponding action (eg. `/ingredient:add`).

When adding or editing ingredients, a `/qty` *must* be specified after the ingredient. Here are some examples:

- `/ingredient:add milk /qty 500ml` <br />
  This makes the recipe require 500ml of milk; if the recipe already used milk, then an error is displayed --- here, you should use `/ingredient:edit` instead.

- `/ingredient:edit beef /qty 200g` <br />
  This changes the quantity of beef used in the recipe from its previous value to 200 grams. If the recipe did not use beef as an ingredient, an error is displayed --- here, you should use `/ingredient:add` instead.

- `/ingredient:delete carrot` <br />
  This removes carrots from the recipe entirely. If the recipe did not use carrots, then an error is displayed.


<h4>Tags</h4>
If you want to edit the tags for a recipe, use `/tag` with the corresponding action, which are either `add` or `delete`. For example:

- `/tag:add vegetarian` <br />
  This adds the 'vegetarian' tag to the recipe. If the recipe already contains this tag, an error is displayed.

- `/tag:delete cold` <br />
  This removes the 'cold' tag from the recipe. If the recipe did not have this tag, an error is displayed.



<h4>Steps</h4>
Since steps have a fixed ordering in a recipe, editing them is slightly more involved; when editing or deleting steps, you are required to provide the step number as an additional component in the *edit-argument*. For example, `/step:edit:3` edits the third step in the recipe.

When adding a step, the step number is optional; if not specified, the new step will be added as the last step. If it is specified, then the new step will be inserted at the corresponding position, and the following steps will be re-numbered.

For example:

- `/step:add Bake for 80 minutes at 400 C` <br />
  This adds a new step as the last step of the recipe.

- `/step:edit:4 Bake for 50 minutes at 250 C` <br />
  This changes the content of step number 4.

- `/step:delete:1` <br />
  This deletes the first step of the recipe.

Note that steps must be added sequentially; for instance, you cannot add step 5 to a recipe with only 2 steps.


<h4>Usage</h4>

Except `/name` (which can only appear once), all of the edit operations described above can appear multiple times, in any order, in a single `edit recipe` command. Each operation is processed sequentially from left-to-right, so if two operations modify the same item, then the second one will take precedence.

(As an example, `/step:edit:3 Bake ... /step:edit:3 Fry` will cause step 3 to be 'Fry')

**Usage**:
```
edit recipe <#REF>
  [/name <new-recipe-name>]
  [/ingredient:<action> <ingredient-name> [/qty <quantity>]]...
  [/step:<action>[:<index>] <step>]...
  [/tag:<action> <tag-name>]...
```

Examples:
- `edit recipe #4 /name soup` <br/>
	This changes the name of the fourth recipe in the recipe list to 'soup'.

- `edit recipe pancakes /ingredient:add syrup /qty 500ml` <br/>
	This edits the recipe named 'pancakes' by adding 500ml of syrup to its ingredient list.

- `edit recipe risotto /step:edit:1 In a saucepan, warm the broth over low heat` <br/>
  This edits the recipe named 'risotto' by changing the 1st step to the text above.

- `edit recipe beef curry /ingredient:delete apple /step:delete:4` <br/>
  This edits the recipe named 'beef curry' to remove both the ingredient 'apple' as well as the 4th step.

To illustrate how to use this powerful command, let us recreate the Pancake recipe from above, starting from a blank recipe instead. First, we make the empty recipe using `add recipe Pancakes`:

<!-- to editors: don't mind the image names, i cut out some steps for brevity and i'm lazy to rename the files. -->
<a name="Figure-9-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_1.png" width="75%" /> <br />
Figure 9.1: <i>The empty recipe</i>
</div>

Now, let's add our ingredients, using `/ingredient:add`; first, 400 grams of flour:

<a name="Figure-9-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_2.png" width="75%" /> <br />
Figure 9.2: <i>The command to add a new ingredient to the recipe</i>
</div>

Next, adding the eggs and milk in one go:

<a name="Figure-9-3"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_3.png" width="75%" /> <br />
Figure 9.3: <i>The edit command supports multiple operations at once</i>
</div>

Oops, that's too many eggs, so let's edit the quantity using `/ingredient:edit`:

<a name="Figure-9-4"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_4.png" width="75%" /> <br />
Figure 9.4: <i>Editing an ingredient to change its quantity</i>
</div>

<a name="Figure-9-5"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_5.png" width="75%" /> <br />
Figure 9.5: <i>The recipe now uses only 3 eggs</i>
</div>

Now let's add the steps with `/step:add`:

<a name="Figure-9-6"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_6.png" width="75%" /> <br />
Figure 9.6: <i>Multiple steps can be added at the same time</i>
</div>

<a name="Figure-9-7"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_7.png" width="75%" /> <br />
Figure 9.7: <i>The finished recipe</i>
</div>

Wait, we forgot to mix the ingredients together! Let's fix it by inserting a new step 2 with `/step:add:2`:

<a name="Figure-9-8"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_8.png" width="75%" /> <br />
Figure 9.8: <i>Adding a new step in the second position</i>
</div>

Oh no, we also forgot the most important thing --- syrup! So let's modify the last step (4) to include syrup with `/step:edit:4`:

<a name="Figure-9-9"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_9.png" width="75%" /> <br />
Figure 9.9: <i>Editing the last step</i>
</div>

And now the pancake recipe is complete!

<a name="Figure-9-10"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/edit_recipe_10.png" width="75%" /> <br />
Figure 9.10: <i>The finished recipe</i>
</div>










<a name="DeleteRecipeCommand"></a>
#### 5.4.5&ensp;Deleting Recipes --- **`delete`**`recipe`

This command deletes a specific recipe from ChopChop. Don't worry if you did this accidentally, because commands can be undone! (see: [undo](#UndoCommand)).

**Usage**: `delete recipe <#REF>`

Examples:
- `delete recipe #4` <br />
	This deletes the fourth recipe in the recipe list.
- `delete recipe pancakes` <br />
	This deletes the recipe named 'pancakes'. Note that the name here is case insensitive.

In this example, both `delete recipe #7` and `delete recipe pancakes` will delete the **Pancakes** recipe:

<a name="Figure-10-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/delete_recipe_1.png" width="75%" /> <br />
Figure 10: <i>The pancakes recipe can be referred to either by name or by number</i>
</div>





<a name="FindRecipeCommand"></a>
#### 5.4.6&ensp;Finding Recipes --- **`find`**`recipe`

This command finds all recipes containing the given keywords in the name.

**Usage**: `find recipe <keyword> [<keyword>]...`

Constraints:
- At least one search keyword must be given

Only the recipe name is searched, and only full words are matched, case-insensitively. In the case of multiple search keywords, recipes containing <b>any</b> of those words will be returned.

Examples:
- `find recipe cake` will match **Chocolate Cake** and **Strawberry Cake**, but *not* **Pancakes**.
- `find recipe milk cake` will match **Milk Tea** and **Carrot Cake**.

To illustrate, suppose you want to search for recipes with names containing 'cake', you would use `find recipe cake`:
<a name="Figure-11-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/find_recipe_1.png" width="75%" /> <br />
Figure 11.1: <i>The initial list of recipes</i>
</div>

After executing the command, note how the recipe list has changed, showing only the matching recipes, and that the item numbers in the corners have changed as well. As explained above, the 'Pancakes' recipe was not included in this list:

<a name="Figure-11-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/find_recipe_2.png" width="75%" /> <br />
Figure 11.2: <i>The recipes containing 'cake'</i>
</div>

To go back to the full recipe view (resetting the search filter), you can either click the Recipes button at the bottom, or run the `list recipes` command:

<a name="Figure-11-3"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/find_recipe_3.png" width="75%" /> <br />
Figure 11.3: <i>Back to the main recipe list</i>
</div>








<a name="FilterRecipeCommand"></a>
#### 5.4.7&ensp;Filtering Recipes --- **`filter`**`recipe`

This command filters all recipes and lists those containing the given name, tag and ingredient keywords. Unlike the [`find recipe`](#FindRecipeCommand) command, the search terms here have to <b>all</b> match a recipe for it to be found.

**Usage**:
```
filter recipe
  [/name <name-keywords>...]...
  [/tag <tag-keywords>...]...
  [/ingredient <ingredient-keywords>...]...
```

- Keywords do not have to be complete to match the 'name', 'tag' or 'ingredient' names.
- Multiple search terms from the same category are allowed. e.g. `/tag movie /tag family`
- Search terms can be placed in any order.
- The filtering is case-insensitive and allows spaces between keywords in a single search term. e.g. `/tag family favourite` is allowed.

Constraints:
- At least one search term must be given, and they should be either `/name`, `/tag` or `/ingredient`.
- Search terms must not be empty.

Examples:
- `filter recipe /name ginger`<br />
  This matches **Gingerbread Man** and **Ginger Chicken Soup**, the only recipes whose names include **ginger**.

- `filter recipe /name sweet /name cake`<br />
  This matches **Sweet Choco Cake** and **Sweet Caramel Cake**, the only recipes whose names include <i>both</i> **sweet** and **cake**.

- `filter recipe /tag family reunion`<br />
  This matches **Spring Rolls** and **Hot Pot**, the only recipes tagged **family reunion**.

- `filter recipe /tag snacks /tag sweet` <br />
  This matches **Chocolate Cookie** and **Gummy Bears**, the only recipes tagged <i>both</i> **snacks** and **sweet**.

- `filter recipe /ingredient eggs` <br />
  This matches **Egg Tart** and **Scrambled Eggs**, assuming they are the only recipes using **eggs**.

- `filter recipe /ingredient chicken /ingredient cheese /ingredient pineapple` <br />
  This matches **Chicken Quesadilla**, assuming it is the only recipe using **chicken**, **cheese**, and **pineapple**.

- `filter recipe /tag local dish /name chicken /ingredient chicken /ingredient white rice /tag family favourite /name rice` <br />
  This matches **Chicken Rice**, assuming it is the only recipe that matches all the criteria specified.

To illustrate, suppose you had the following two recipes:

<a name="Figure-12-1"></a>
<div style="text-align: center; padding-bottom: 2em">
  <img src="images/ug/filter_recipe_1.png" width="35%" style="margin-right: 20px;" />
  <img src="images/ug/filter_recipe_2.png" width="35%" style="margin-left: 20px;" /> <br /> <br />
  Figure 12.1: <i>The starting recipes</i>
</div>

Then, if you wanted to search for recipes with tags **christmas** and **baked**, using ingredients **honey**, **ginger root**, and **molasses**, and whose names contain keywords **men** and **bread**, you would use this command (separated into lines for clarity):
```
filter recipe
  /name men /name bread
  /tag christmas /tag baked
  /ingredient honey /ingredient ginger /ingredient molasses
```

After executing the command, similar to the effect of [`find recipe`](#FindRecipeCommand) command, the recipe list has changed, showing only the matching recipe, **Gingerbread Men**:

<a name="Figure-12-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/filter_recipe_3.png" width="75%" /> <br />
Figure 12.2: <i>Only one recipe matched all the provided criteria</i>
</div>

Note the following:
- `ginger` found the ingredient <b>ginger root</b>
- `baked` found the tag <b>home baked</b>
- `men` and `bread` found the name <b>Gingerbread Men</b>

To reset the search filter or go back to the full recipe view, you can click the Recipes button or run the `list recipes` command.






<a name="MakeRecipeCommand"></a>
#### 5.4.8&ensp;Making Recipes --- **`make`**`recipe`
This command allows you to <i>make</i> a recipe, which will add it to the statistics tracker, and deduct the appropriate amounts from ChopChop's internal ingredient inventory.

If you do not have sufficient ingredients to make the recipe, an error message is shown. After the recipe is made, you will be brought to the ingredient list showing the updated ingredient amounts.

**Usage**: `make recipe <#REF>`

Examples:
- `make recipe pancakes` <br />
  This makes the recipe named 'pancakes'. Note that the name here is case insensitive.

To illustrate suppose you wanted to make the pancakes here, you would use `make recipe pancakes`. You can run this command from any view (not necessarily from the recipe detail view):
<a name="Figure-13-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/make_recipe_1.png" width="75%" /> <br />
Figure 13.1: <i>Making pancakes</i>
</div>

After pressing <kbd>enter</kbd>, ChopChop will open up the recipe that you've just made:

<a name="Figure-13-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/make_recipe_2.png" width="75%" /> <br />
Figure 13.2: <i>The detailed recipe view</i>
</div>

If there are ingredients that are missing, or that you have insufficient amounts of, ChopChop will display this message in the command output window:

<a name="Figure-13-3"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/make_recipe_3.png" width="55%" /> <br />
Figure 13.3: <i>Insufficient ingredients to make the pancakes</i>
</div>

Furthermore, if the recipe used ingredients having incompatible units with existing ingredients (eg. you have Butter in grams, but the recipe wants Butter in tablespoons), then an error is also shown. In this situation, you should [edit the recipe](#EditRecipeCommand) so that it uses the correct units.














<br/>
<hr/>


<a name="GroupIngredientCommands"></a>
### 5.5&ensp;Ingredient Commands

These commands allow you to add, delete, and edit ingredients.

<a name="ListIngredientCommand"></a>
#### 5.5.1&ensp;Listing Ingredients --- **`list`**`ingredients`
This command shows a list of all recipes in ChopChop. As with the `list recipes` command, you can use this command to switch between panes without clicking, or to reset any filters.

**Usage**: `list ingredients`

<div markdown="span" class="alert alert-primary">
:bulb: **Tip:** For convenience, you can use either `list ingredients` or `list ingredient`.
</div>

<a name="Figure-14-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/list_ingredients.png" width="75%" /> <br />
Figure 14: <i>The ingredient list view</i>
</div>





<a name="AddIngredientCommand"></a>
#### 5.5.2&ensp;Adding Ingredients --- **`add`**`ingredient`
This command adds an ingredient to ChopChop, with an optional quantity and expiry date:
- If the quantity is not specified, ChopChop will infer <b>1</b> of a counted quantity, like eggs.
- If the expiry date is not specified, it is assumed that the ingredient (eg. salt) does not expire.

As mentioned in the [overview above](#OverviewIngredients), an ingredient can consist of multiple sets; the `add ingredient` command will intelligently *combine* ingredients as appropriate.

<div markdown="span" class="alert alert-primary">
:information_source: **Note:** Ingredients need to have compatible units in order to be combined; see [this section](#QuantitiesAndUnits) for how it works.
</div>

If the new ingredient has `/tag` options that are not present in the existing ingredient, then they are added as well.

**Usage**:
```
add ingredient <name>
  [/qty <quantity>]
  [/expiry <expiry-date>]
  [/tag <tag-name>]...
```

Examples:
- `add ingredient milk /qty 1l /expiry 2020-11-09` adds one litre of milk that expires on the 9th of November.
- `add ingredient egg /expiry 2020-12-25` adds <b>one</b> egg that expires on Christmas day.

Suppose you just finished a grocery run, and want to add the items to ChopChop. First, you have 2 cartons of milk:

<a name="Figure-15-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_ingredient_1.png" width="75%" /> <br />
Figure 15.1: <i>Adding 2 litres of milk</i>
</div>

Since ChopChop did not know about 'milk' previously, a new ingredient entry is created for it:

<a name="Figure-15-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_ingredient_2.png" width="75%" /> <br />
Figure 15.2: <i>The newly added milk ingredient</i>
</div>

Next, suppose you also bought 24 blueberries:

<a name="Figure-15-3"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_ingredient_3.png" width="75%" /> <br />
Figure 15.3: <i>Adding 24 blueberries</i>
</div>

This time, since ChopChop already knew about blueberries, our previous 19 blueberries now become 43:

<a name="Figure-15-4"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_ingredient_4.png" width="75%" /> <br />
Figure 15.4: <i>You now have 43 blueberries</i>
</div>

If you try to add an ingredient with incompatible quantities (for example, suppose you did not want to count the blueberries individually, and you only know that you bought a 400 gram box), ChopChop will display an error message, and not update the ingredient:

<a name="Figure-15-5"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/add_ingredient_5.png" width="45%" /> <br />
Figure 15.5: <i>Ingredients must have compatible units to be combined</i>
</div>








<a name="DeleteIngredientCommand"></a>
#### 5.5.3&ensp;Deleting Ingredients --- **`delete`**`ingredient`

This command deletes a specific ingredient from ChopChop. Similar to the `add ingredient` command, this command also allows you to delete quantities of ingredients instead of the whole ingredient. In this scenario, ChopChop will intelligently remove the earliest-expiring ingredients first.

If `/qty` is not specified, then the behaviour of this command is to completely remove the ingredient from ChopChop. Worry not: if you accidentally delete something, you can always [`undo`](#UndoCommand) it.

<div markdown="span" class="alert alert-primary">
:information_source: **Note:** If specified, the quantity needs to have compatible units with the existing ingredient; see [this section](#QuantitiesAndUnits) for how it works.
</div>

**Usage**: `delete ingredient <#REF> [/qty <quantity>]`

Examples:
- `delete ingredient #4` <br />
	This deletes the fourth ingredient currently shown in the recipe list.
- `delete ingredient milk /qty 500ml` <br />
	This removes 500ml of milk from ChopChop's inventory.

To illustrate, suppose that you poured yourself a glass of cold milk to drink, without making a recipe. To tell ChopChop that there is less milk in the fridge, you would use this command:

<a name="Figure-16-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/delete_ingredient_1.png" width="75%" /> <br />
Figure 16.1: <i>Removing 350ml of milk</i>
</div>

Notice how the amount of milk decreased from 2 litres to 1.65 litres:

<a name="Figure-16-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/delete_ingredient_2.png" width="75%" /> <br />
Figure 16.2: <i>You now only have 1.65 litres of milk left</i>
</div>










<a name="FindIngredientCommand"></a>
#### 5.5.4&ensp;Finding Ingredients --- **`find`**`ingredient`
This command finds all ingredients containing the given keywords in the name, and it works identically to the [`find recipe`](#FindRecipeCommand) command above.

Constraints:
- At least one search keyword must be given

**Usage**: `find ingredient <keyword> [<keyword>]...`

For example, suppose you wanted to find all ingredients containing fish (not in the literal sense, but only in their name):

<a name="Figure-17-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/find_ingredient_1.png" width="75%" /> <br />
Figure 17.1: <i>The complete ingredient list</i>
</div>

Now, only the matching ingredients are shown:

<a name="Figure-17-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/find_ingredient_2.png" width="75%" /> <br />
Figure 17.2: <i>Only ingredients containing 'fish' in their name are shown</i>
</div>

To clear the search filter, you can either click the Ingredients button, or use `list ingredients` to return to the list of ingredients.








<a name="FilterIngredientCommand"></a>
#### 5.5.5&ensp;Filtering Ingredients --- **`filter`**`ingredient`

This command filters all ingredients and lists those matching the name keywords, tags, and expiry dates specified in the command. Except for the changes in the search fields, this feature works identically to the [`filter recipe`](#FilterRecipeCommand) command above. Notably, <b>all</b> the search terms have to match an ingredient before it is found.

**Usage**:
```
filter ingredient
  [/name <name-keywords>...]...
  [/tag <tag-keywords>...]...
  [/expiry <expiry-date>]
```

- Keywords following `/tag` and `/name` do not have to be complete to match the tag or the ingredient's name.
- `/expiry <expiry-date>` filters the ingredients and only lists those that expire before the date provided.
- When there are multiple expiry dates specified, only the earliest one will be considered.

Constraints:
- At least one search term must be given, and they should be either `/name`, `/expiry` or `/tag`.
- Search terms must not be empty.

Examples:
- `filter ingredient /name dark chocolate` <br />
  This matches **dark chocolate** and **dark chocolate syrup**, assuming they are the only ingredients whose names contain **dark chocolate**.

- `filter ingredient /name dark chocolate /name syrup` <br />
  This matches **dark chocolate syrup**, assuming it is the only ingredient whose name contains both **dark chocolate** and **syrup**.

- `filter ingredient /tag bitter taste` <br />
  This matches **bitter melon** and **dark chocolate**, assuming they are the only ingredients tagged with **bitter taste**.

- `filter ingredient /tag frequently used /tag sweet` <br />
  This matches **sugar**, if it is the only ingredient tagged <i>both</i> **frequently used** and **sweet**.

- `filter ingredient /expiry 2020-12-01 /expiry 2020-10-31 /expiry 2023-01-01` <br />
  This matches **apple**, if it is the only ingredient expiring before **2020-10-31**. Note that only the earliest date is considered here (in this case, 31st October 2020), and the rest are ignored.

- `filter ingredient /tag powdery /expiry 2020-12-31 /tag bakery /name soda` <br />
  This matches **baking soda**, assuming it is the only ingredient that matches all the specified criteria.

To illustrate, suppose you want to search for ingredients tagged both **bakery** and **sweet**, expiring before **2021-12-31** and containing **sugar** in the name; you can use `filter ingredient /tag bakery /expiry 2021-12-31 /tag sweet /name sugar`:

<a name="Figure-18-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/filter_ingredient_1.png" width="75%" /> <br />
Figure 18.1: <i>The initial list of ingredients</i>
</div>

After executing the command, similar to the effect of **filter recipe** command, the ingredient list has changed, showing the only matching ingredients, **Brown Sugar** and **Granulated Sugar**:

<a name="Figure-18-2"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/filter_ingredient_2.png" width="75%" /> <br />
Figure 18.2: <i>The ingredients matching all the provided criteria</i>
</div>

Note that **Honey**, which was also tagged **bakery** and **sweet** and would expire before **2021-12-31**, was not included because its name does not contain **sugar**.

To reset the search filter or go back to the full ingredient view, you can click the Ingredients button or run the `list ingredients` command.




<a name="EditIngredientCommand"></a>
#### 5.5.6&ensp;Editing Ingredients --- **`edit`**`ingredient`

This command edits the given ingredient, in a similar fashion to the [`edit recipe`](#EditRecipeCommand) command. However, currently its functionality is limited to only editing the tags of an ingredient (more features coming soon!).

Do refer to the documention on the [`edit recipe`](#EditRecipeCommand) command above to find out how edit-descriptors work; this command currently only supports `/tag:add` and `/tag:delete`.

It is an error to delete a tag from an ingredient that did not contain that tag, and similarly to add a duplicate tag to an ingredient.

**Usage**:
```
edit ingredient <#REF>
  [/tag:<action> <tag-name>]...
```

Examples:
- `edit ingredient #4 /tag:add frozen` <br/>
  This tags the fourth ingredient currently shown in the ingerdient list with **frozen**.

- `edit ingredient sprinkles /tag:delete fridge` <br/>
  This removes the tag **fridge** from the ingredient named 'sprinkles'.











<br/>
<hr/>

<a name="GroupStatsCommands"></a>

### 5.6&ensp;Statistics Commands

Whenever you make a recipe or consume an ingredient, ChopChop makes a record, which you can view with the commands below. The output of these statistics commands are shown in the [statistics box](#StatisticsBox) on the right side of ChopChop's interface.


<a name="StatsRecipeTopCommand"></a>
#### 5.6.1&ensp;Listing Top Recipes --- **`stats`**`recipe top`

This command shows a list of recipes that were made the most, in descending order (the recipe listed first was made the most number of times).

Note that, even if a recipe was deleted (with [`delete recipe`](#DeleteRecipeCommand)), its cooking records will still exist in ChopChop. To remove these statistics, you can use [`stats recipe clear`](#StatsRecipeClearCommand) to clear them for all recipes.

**Usage**: `stats recipe top`

For example, here is the output for someone who really really loves pancakes:

<a name="Figure-19-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/stats_recipe_top.png" width="45%" /> <br />
Figure 19: <i>No pancakes were sacrificed for this picture</i>
</div>


<a name="StatsRecipeRecentCommand"></a>
#### 5.6.2&ensp;Listing Recent Recipes --- **`stats`**`recipe recent`

This command shows a list of the 10 most recently-made recipes, with the most recent one at the top of the list. As with the other statistics commands, deleting a recipe from ChopChop does not delete it from this list.

Note that this is also the view that is displayed by default when no statistics commands have been used yet.

**Usage**: `stats recipe recent`

<a name="Figure-20-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/stats_recipe_recent.png" width="45%" /> <br />
Figure 20: <i>The recently-made recipes view</i>
</div>



<a name="StatsRecipeMadeCommand"></a>
#### 5.6.3&ensp;Listing Recipes within a Time Frame --- **`stats`**`recipe made`

This command shows a list of recipes that were made within the given time frame, arranged in descending chronological order. You can specify the lower bound (earliest date/time), upper bound (latest date/time), both, or neither.

**Usage**: `stats recipe made [/before <date-time>] [/after <date-time>]`

The format of `<date-time>` is as such: `yyyy-mm-dd [hh:mm]`, where `yyyy-mm-dd` is the [familiar date format](#DateFormats), and `hh:mm` is the optional time in 24-hour format (eg. `18:30` for 6.30pm).

If the time component is omitted, it is assumed to be midnight of the given day. If both `/before` and `/after` are omitted, then ChopChop shows recipes made on the current day, ie. from midnight to 23:59.

Examples:
- `stats recipe made` <br />
  This shows all recipes made since the beginning of the current day

- `stats recipe made /after 2020-04-15` <br />
  This shows all recipes made after the 15th of April, 2020

- `stats recipe made /before 2020-12-25` <br />
  This shows all recipes made before the 25th of December, 2020

- `stats recipe made /after 2020-04-15 /before 2020-12-25` <br />
  This shows all recipes made between the 15th of April and 25th of December

- `stats recipe made /after 2020-01-01 08:00 /before 2020-01-01 23:00` <br />
  This shows all recipes made between 8am and 11pm on the 1st of January


For example, `stats recipe made /after 2020-11-02 /before 2020-11-04 23:00` shows this output:

<a name="Figure-21-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/stats_recipe_made_1.png" width="45%" /> <br />
Figure 21.1: <i>Showing the recipes made between a date range</i>
</div>

Meanwhile, just executing `stats recipe made` only shows the recipes made on the current day:

<a name="Figure-22-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/stats_recipe_made_2.png" width="45%" /> <br />
Figure 21.2: <i>Showing the recipes made on the current day</i>
</div>




<a name="StatsRecipeClearCommand"></a>
#### 5.6.4&ensp;Clearing Recipe History --- **`stats`**`recipe clear`

This command clears the history of the recipes that you've made from ChopChop. If you did this accidentally, don't worry, because you can [undo](#UndoCommand) this.

**Usage**: `stats recipe clear`





<a name="StatsIngredientRecentCommand"></a>
#### 5.6.5&ensp;Listing Recent Ingredients --- **`stats`**`ingredient recent`

This command shows a list of the 10 most recently-used ingredients consumed by [`make`](#MakeRecipeCommand)-ing recipes. It is similar to the [`stats recipe recent`](#StatsRecipeRecentCommand) command as discussed above, except it deals with ingredients.

**Usage**: `stats ingredient recent`

For example, after having just made <i>Scrambled Eggs</i>, these will be the recently-used ingredients:

<a name="Figure-23-1"></a>
<div style="text-align: center; padding-bottom: 2em">
<img src="images/ug/stats_ingredient_recent.png" width="45%" /> <br />
Figure 22: <i>The recently used ingredients view</i>
</div>



<a name="StatsIngredientUsedCommand"></a>
#### 5.6.6&ensp;Listing Ingredients within a Time Frame --- **`stats`**`ingredient used`

This command shows a list of ingredients that were used within the given time frame, arranged in descending chronological order. You can specify the lower bound (earliest date/time), upper bound (latest date/time), both, or neither.

This command behaves similarly to [`stats recipe made`](#StatsRecipeMadeCommand) as discussed above, except that `made` is replaced with `used` instead. Otherwise, the arguments (`/before`, `/after`) function identically.

**Usage**: `stats ingredient used`



<a name="StatsIngredientClearCommand"></a>
#### 5.6.7&ensp;Clearing Ingredient History --- **`stats`**`ingredient clear`

This command clears the history of the ingredients that you've used in ChopChop. If you did this accidentally, don't worry, because you can [undo](#UndoCommand) this.

**Usage**: `stats ingredient clear`






<a name="CommandSummary"></a>
### 5.7&ensp;Command Summary

For easy reference, here are the commands that ChopChop supports, listed in alphabetical order. You can click on the name of the command to go to its section in the User Guide.

<!-- why is this table in html? because markdown is the WORST of both worlds. -->
<!-- you can't put line breaks in code blocks inside markdown table cells. sucks to be you. -->
<!-- &lt; and &gt; all day every day. -->
<table style="width: 100%">
<thead>
  <tr>
    <th>Command</th>
    <th>Description</th>
    <th>Syntax Summary</th>
    <th>Undo</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><a href="#AddIngredientCommand">add ingredient</a></td>
    <td>Adds a new ingredient, or increases the quantity of an existing ingredient</td>
    <td><pre>
add ingredient &lt;name&gt;
  [/qty &lt;quantity&gt;]
  [/expiry &lt;expiry-date&gt;]
  [/tag &lt;tag-name&gt;]...
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#AddRecipeCommand">add recipe</a></td>
    <td>Adds a new recipe</td>
    <td><pre>
add recipe &lt;name&gt;
  [/ingredient &lt;name&gt;
    [/qty &lt;quantity&gt;]]...
  [/step &lt;step&gt;]...
  [/tag &lt;tag-name&gt;]...
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#DeleteIngredientCommand">delete ingredient</a></td>
    <td>Completely deletes an ingredient, or removes some quantity of it</td>
    <td><pre>
delete ingredient &lt;#REF&gt;
  [/qty &lt;quantity&gt;]
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#DeleteRecipeCommand">delete recipe</a></td>
    <td>Completely deletes a recipe</td>
    <td><pre>
delete recipe &lt;#REF&gt;
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#EditIngredientCommand">edit ingredient</a></td>
    <td>Edits an existing ingredient</td>
    <td><pre>
edit ingredient &lt;#REF&gt;
  [/tag:&lt;action&gt;
    &lt;tag-name&gt;]...
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#EditRecipeCommand">edit recipe</a></td>
    <td>Edits an existing recipe</td>
    <td><pre>
edit recipe &lt;#REF&gt;
  [/name &lt;new-recipe-name&gt;]
  [/ingredient:&lt;action&gt;
    &lt;ingredient-name&gt;
    [/qty &lt;quantity&gt;]
  ]...
  [/step:&lt;action&gt;[:&lt;index&gt;]
    &lt;step&gt;]...
  [/tag:&lt;action&gt;
    &lt;tag-name&gt;]...
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#FilterIngredientCommand">filter ingredient</a></td>
    <td>Searches for ingredients by one or more filtering criteria</td>
    <td><pre>
filter ingredient
  [/name &lt;name-keywords&gt;...]...
  [/expiry &lt;expiry-date&gt;]
  [/tag &lt;tag-keywords&gt;...]...
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#FilterRecipeCommand">filter recipe</a></td>
    <td>Searches for recipes by one or more filtering criteria</td>
    <td><pre>
filter recipe
  [/name &lt;name-keywords&gt;...]...
  [/tag &lt;tag-keywords&gt;...]...
  [/ingredient
    &lt;ingr-keywords&gt;...]...
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#FindIngredientCommand">find ingredient</a></td>
    <td>Searches for ingredients by their name</td>
    <td><pre>
find ingredient &lt;keyword&gt;
  [&lt;keyword&gt;]...
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#FindRecipeCommand">find recipe</a></td>
    <td>Searches for recipes by their name</td>
    <td><pre>
find recipe &lt;keyword&gt;
  [&lt;keyword&gt;]...
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#HelpCommand">help</a></td>
    <td>Shows help in general, or help for specific commands</td>
    <td><pre>
help [&lt;command-name&gt;
  [&lt;command-target&gt;]]
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#ListIngredientCommand">list ingredient</a></td>
    <td>Shows the main ingredient list, and clears any search filters</td>
    <td><pre>
list ingredients
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#ListRecipeCommand">list recipe</a></td>
    <td>Shows the main recipe list, and clears any search filters</td>
    <td><pre>
list recipes
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#MakeRecipeCommand">make recipe</a></td>
    <td>Makes a recipe, consuming ingredients and recording statistics</td>
    <td><pre>
make recipe &lt;#REF&gt;
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#QuitCommand">quit</a></td>
    <td>Exits ChopChop</td>
    <td><pre>
quit
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#RedoCommand">redo</a></td>
    <td>Redoes a command that was previously undone</td>
    <td><pre>
redo
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#StatsRecipeClearCommand">stats recipe clear</a></td>
    <td>Clear cooked recipe history</td>
    <td><pre>
stats recipe clear
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#StatsRecipeMadeCommand">stats recipe made</a></td>
    <td>Shows recipes made within a given time frame</td>
    <td><pre>
stats recipe made
  [/after &lt;date-time&gt;]
  [/before &lt;date-time&gt;]
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#StatsRecipeRecentCommand">stats recipe recent</a></td>
    <td>Shows recently made recipes</td>
    <td><pre>
stats recipe recent
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#StatsRecipeTopCommand">stats recipe top</a></td>
    <td>Shows the top recipes</td>
    <td><pre>
stats recipe top
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#StatsIngredientClearCommand">stats ingredient clear</a></td>
    <td>Clear ingredient usage history</td>
    <td><pre>
stats ingredient clear
</pre></td>
    <td>&#x2714;</td>
  </tr><tr>
    <td><a href="#StatsIngredientRecentCommand">stats ingredient recent</a></td>
    <td>Shows recently used ingredients</td>
    <td><pre>
stats ingredient recent
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#StatsIngredientUsedCommand">stats ingredient used</a></td>
    <td>Shows ingredients used within a given time frame</td>
    <td><pre>
stats ingredient used
  [/after &lt;date-time&gt;]
  [/before &lt;date-time&gt;]
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#UndoCommand">undo</a></td>
    <td>Undoes a command that was previously executed</td>
    <td><pre>
undo
</pre></td>
    <td>&#x2718;</td>
  </tr><tr>
    <td><a href="#ViewRecipeCommand">view</a></td>
    <td>Opens the detailed view for a recipe</td>
    <td><pre>
view recipe &lt;#REF&gt;
</pre></td>
    <td>&#x2718;</td>
  </tr>
</tbody></table>





-------------------------
<a name="QuantitiesAndUnits"></a>
## 6&ensp;Quantities and Units

In order to keep track of ingredients correctly, ChopChop needs to know about their amounts. Currently, there are 3 'kinds' of units supported; volume, mass (weight), and counts. Specifically, these are the supported units:

- `ml`, `mL` --- millilitres
- `l`, `L` --- litres (1000 ml)
- `cup`, `cups` --- metric cup (250 ml)
- `tsp` --- metric teaspoon (5 ml)
- `tbsp` --- metric tablespoon (15 ml)
- `g` --- gram
- `mg` --- milligram (0.001 g)
- `kg` --- kilogram (1000 g)

Quantities without a unit are assumed to be dimensionless 'counts'; for example, **3** eggs. They do not need to be whole numbers, so that a recipe can use **2.5** apples, for example.


### 6.1&ensp;Ingredient Combining

As mentioned above, ChopChop will combine ingredients when you `add` them, provided they have compatible units. Combining works as you would expect, and is rather flexible; adding `3 cups` of milk to an existing stock of `400ml` will yield `1.15l`.

However you cannot, for example, add `300g` of blueberries to `4` blueberries, as grams and counts are incompatible units.







--------------------------
<a name="FAQ"></a>
## 7&ensp;Frequently Asked Questions

Here are some frequently asked questions about ChopChop:

<b>Q:</b> How do I save my changes? <br/>
<b>A:</b> ChopChop saves your changes automatically whenever a change is made, so you do not need to worry about doing it manually.

<b>Q:</b> How do I transfer my data to another computer? <br/>
<b>A:</b> Simply copy the folder named `data` that you will find next to `chopchop.jar` to the new computer, and all your recipes and ingredients will be copied over as well.

<b>Q:</b> How can I rename an ingredient? <br/>
<b>A:</b> Currently, ingredients cannot be renamed.

<b>Q:</b> Why is ChopChop telling me that there are incompatible ingredients? <br/>
<b>A:</b> Due to the way quantities are handled, recipes need to use the same <i>kind</i> of unit as the ingredient you have in storage. For example, if <b>Butter</b> was recorded as <i>mass</i> (in grams), you can only refer to it in recipes using grams/milligrams/kilograms, but not <i>volumes</i> (tablespoons/cups, etc.).

<b>Q:</b> How can I use a unit like `oz`? <br/>
<b>A:</b> Currently custom units are not supported in ChopChop, though they are coming in a future version! We only support metric units for now.





--------------------------
<a name="Glossary"></a>
## 8&ensp;Glossary

Here are some terms you might be unfamiliar with in this document, and their associated meanings:

| Word/Phrase     | Meaning                                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------------------|
| Case Insensitive| Capitalisation is not considered, eg. `aAaAaAaA` and `aaaaaaaa` are the same when comparing case insensitively        |
| Command         | A series of text you type into the [Command Box](#CommandBox) in order to perform an action in ChopChop               |
| GUI             | A <i>graphical user interface</i>, which is the visual display that you see in ChopChop                               |
| Index           | A number that you can use to refer to an ingredient or recipe in a command; it appears in the top left corner of items|
| Ingredient      | A food item (eg. salt, butter) that you keep in stock; needed to make recipes                                         |
| Recipe          | A dish that can be made using some ingredients; has a list steps to make it, and a list of ingredients used           |
| Tag             | A word or short phrase (eg. `sweet`, `simple recipe`) that you can attach to ingredients and recipes to identify them |

