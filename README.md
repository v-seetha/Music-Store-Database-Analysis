# Music-Store-Database-Analysis

## Dataset Overview
This dataset contains information about a digital music store, including:
- Artists and albums
- Tracks and media types
- Customers and their purchase history
- Employees (sales support representatives)
- Invoices and invoice lines
- Playlists and genres

## Key Tables and Relationships

The database schema consists of these primary tables:
- `artist` - Music artists
- `album` - Albums linked to artists
- `track` - Individual songs linked to albums
- `customer` - Customer information
- `employee` - Staff information
- `invoice` - Purchase transactions
- `invoice_line` - Individual items in purchases
- `genre` - Music genres
- `media_type` - File formats
- `playlist` - Collections of tracks
- `playlist_track` - Junction table linking playlists and tracks

## Analysis Queries

### Revenue Analysis

1. **Top Selling Artists by Revenue**
   - Identifies the 10 highest-grossing artists
   - Includes metrics: invoices, tracks sold, and total revenue
   - Grouped by artist with descending revenue order

2. **Sales Trends Over Time**
   - Analyzes sales patterns by month and year
   - Shows invoice count, items sold, and total revenue
   - Chronologically ordered for trend analysis

3. **Geographic Sales Distribution**
   - Analyzes sales by country
   - Includes invoice count, customer count, total revenue
   - Calculates revenue per customer by country

4. **Media Type Popularity and Revenue**
   - Evaluates which media types (file formats) generate the most revenue
   - Shows items sold, total revenue, and average price
   - Helps understand format preferences

5. **Price Elasticity Analysis**
   - Examines how sales volume varies with price points
   - Shows units sold, invoices, unique tracks, and revenue
   - Useful for pricing strategy decisions

### Customer Analysis

1. **Customer Spending Analysis**
   - Analyzes spending patterns by customer
   - Includes purchase count, total spent, average invoice value
   - Records last purchase date for recency analysis

2. **Customer Lifetime Value (CLV) Analysis**
   - Calculates total value and engagement for each customer
   - Includes first/last purchase dates, days as customer
   - Calculates purchase frequency and average purchase value

3. **Customer Genre Preferences**
   - Analyzes each customer's preferred music genres
   - Shows tracks purchased and percentage of purchases by genre
   - Useful for personalized recommendations

4. **Customer Segmentation by Purchase Behavior**
   - Segments customers based on recency, frequency, and monetary value
   - Categories: High-Value Active, Active, Recent, Lapsed, Inactive
   - Essential for targeted marketing campaigns

5. **Advanced Cohort Analysis**
   - Analyzes spending patterns based on first purchase date
   - Groups customers into cohorts by year and month
   - Tracks revenue from each cohort over time (0-2 months)

### Product Analysis

1. **Genre Performance Analysis**
   - Identifies the most lucrative music genres
   - Shows tracks sold, albums represented, total revenue
   - Calculates average revenue per track by genre

2. **Popular Tracks Analysis**
   - Identifies the 20 top-selling tracks
   - Includes artist name, album title, and genre
   - Shows times sold and total revenue

3. **Album Performance Analysis**
   - Evaluates commercial performance of albums
   - Includes total tracks, tracks sold, total revenue
   - Calculates average track price and revenue per track

4. **Track Length Analysis by Genre**
   - Analyzes track length patterns across genres
   - Shows average, minimum, and maximum track lengths
   - Includes track count by genre

5. **Playlist Popularity and Composition**
   - Analyzes the composition and popularity of playlists
   - Shows track count, genre count, genres included
   - Calculates average track length per playlist

### Advanced Analytics

1. **Employee Sales Performance**
   - Evaluates performance of sales support representatives
   - Shows customers supported, invoices generated, revenue
   - Useful for staff performance evaluation

2. **Cross-selling Analysis**
   - Identifies album pairs often purchased together
   - Shows top 20 album combinations by frequency
   - Valuable for recommendation systems

3. **Customer Purchase Pattern Evolution**
   - Analyzes how customer preferences evolve over time
   - Tracks top artist by quarter for each customer
   - Calculates percentage of quarterly spend on favorite artists

4. **Customer Support Rep Performance with Track Complexity**
   - Correlates support rep effectiveness with music complexity
   - Includes metrics like average track length and genre diversity
   - Helps understand if certain reps handle more complex customer needs

5. **Predictive Next Purchase Analysis**
   - Provides insights for recommendation systems
   - Identifies potential genres to recommend
   - Based on similar customers' purchase patterns

## Usage Recommendations

These queries can support business decisions in several areas:

1. **Marketing Strategy**
   - Use customer segmentation for targeted campaigns
   - Leverage genre preferences for personalized promotions
   - Analyze geographic distribution for region-specific offerings

2. **Inventory Management**
   - Focus on stocking high-performing genres and artists
   - Consider expanding offerings in popular media types
   - Adjust inventory based on sales trends

3. **Pricing Strategy**
   - Use price elasticity analysis to optimize pricing
   - Consider special bundling for frequently co-purchased albums
   - Adjust pricing by media type based on popularity

4. **Customer Retention**
   - Target lapsed customers with personalized recommendations
   - Recognize high-value customers for loyalty programs
   - Provide support reps with insights for personalized service

5. **Product Development**
   - Use track length analysis to guide new content acquisition
   - Focus on expanding popular playlist categories
   - Consider customer genre evolution when acquiring new content

These analyses provide a comprehensive view of business performance across multiple dimensions, enabling data-driven decision making for the music store.
