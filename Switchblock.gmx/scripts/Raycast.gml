///Raycast(angle, length, increment, object, precise, [out], [startX], [startY])
///Casts a line from the calling object to check for collisions
///returns collision id or noone
///can output to a vector
var angle = argument[0];
var length = argument[1];
var increment = argument[2];
var object = argument[3];
var precise = argument[4];
var out = noone;
if(argument_count > 5)
{
    out = argument[5];
}
var xStart = x;
if(argument_count > 6)
{
    xStart = argument[6];
}
var yStart = y;
if(argument_count > 7)
{
    yStart = argument[7];
}

//var angle = arctan2(yDir, xDir);

var xEnd = xStart + (length * cos(angle));
var yEnd = yStart - (length * sin(angle));

var xVal = xStart;
var yVal = yStart;


var steps = length/increment;

var xStep = increment * cos(angle);
var yStep = increment * sin(angle);


for(var i = 0; i < steps; i++)
{    
    if(xVal > room_width || xVal < 0 || yVal > room_height || yVal < 0)
    {
        if(out != noone)
        {
            out.x = xVal;
            out.y = yVal;
        }
        return 0;
    }
    
    var collision = collision_point(xVal, yVal, object, false, true);
    if(collision != noone)
    {
        
        points = GetBlockPoints(collision);
        
        var xMin = ds_list_find_value(points, 0);
        var xMax = ds_list_find_value(points, 2);
        var yMin = ds_list_find_value(points, 1);
        var yMax = ds_list_find_value(points, 5);
        
        //cast to other edges
        /*if((xVal <= xMin && xStep > 0) && (yVal >= yMin && yVal <= yMax))
        {
            while(xVal < xMax)
            {
                xVal++;
                yVal -= sign(yStep);
                yVal = clamp(yVal, yMin, yMax);
            }    
        }
        else if((xVal >= xMax && xStep < 0) && (yVal >= yMin && yVal <= yMax))
        {
            while(xVal > xMin)
            {
                xVal--;
                yVal -= sign(yStep);
                yVal = clamp(yVal, yMin, yMax);
            }
        }
        else if((yVal <= yMin && yStep > 0) && (xVal >= xMin && xVal <= xMax))
        {
            while(yVal < yMax)
            {
                xVal += sign(xStep);
                yVal++;
                xVal = clamp(xVal, xMin, xMax);
            }
        }
        else if((yVal >= yMax && yStep < 0) && (xVal >= xMin && xVal <= xMax))
        {
            while(yVal > yMin)
            {
                xVal += sign(xStep);
                yVal--;
                xVal = clamp(xVal, xMin, xMax);
            }
        }
        */
        //cast beyond corner
        //if(!((xVal <= xMin || xVal >= xMin) && (yVal <= yMin || yVal >= yMax)))
        //{
            if(out != noone)
            {
                out.x = xVal;
                out.y = yVal;
            }
            if(precise)
            {
                return Raycast(angle, length, 1, object, false, out, xVal - xStep, yVal + yStep);
            }
            else
            {
                return collision;
            }
        //}
        
        
        
        ds_list_destroy(points);
        
        /*if(point_in_rectangle(xVal, yVal, ds_list_find_value(points, 0), ds_list_find_value(points, 1), ds_list_find_value(points, 6), ds_list_find_value(points, 7)))
        {
            if(out != noone)
            {
                out.x = xVal;
                out.y = yVal;
            }
            if(precise)
            {
                return Raycast(angle, length, 1, object, false, out, xVal - xStep, yVal + yStep);
            }
            else
            {
                return collision;
            }
        }*/
    }
    xVal += xStep;
    yVal -= yStep;
}

if(out != noone)
{
    out.x = xEnd;
    out.y = yEnd;
}
return noone;

