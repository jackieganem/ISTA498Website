import * as React from 'react';
import Iframe from 'react-iframe'
import PropTypes from 'prop-types';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import './App.css';
function TabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Box sx={{ p: 3 }}>
          <Typography>{children}</Typography>
        </Box>
      )}
    </div>
  );
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.number.isRequired,
  value: PropTypes.number.isRequired,
};

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    'aria-controls': `simple-tabpanel-${index}`,
  };
}

export default function App() {
  const [value, setValue] = React.useState(0);

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <div>
    <div className='header'>
      <img src = {"./podsearch192.png"} width = {"150px"}></img>
      <div> 
        <p className = 'title'> Podsearch </p>
        <p className = 'subtext'> You tell us, we answer! </p>
      </div>
    <Box sx={{ width: '100%' }}>
      <Box sx={{ borderBottom: 1, borderColor: 'divider' }} className = 'navbar'>
        <Tabs value={value} onChange={handleChange} aria-label="basic tabs example" textColor="white" indicatorColor = "secondary" borderColor = "secondary">
          <Tab label="Dashboard" {...a11yProps(0)} className = "tab" />
          <Tab label="Visualizations" {...a11yProps(1)} />
          <Tab label="Description" {...a11yProps(2)} />
          <Tab label="About Us" {...a11yProps(2)} />
        </Tabs>
      </Box>
      </Box>
      </div>
      <TabPanel value={value} index={0}>
      <Iframe url="https://rbalderas.shinyapps.io/PodSearchOne/"
        width="1390px"
        height="1000px"
        id=""
        className=""
        display="block"
        position="relative"/>
      </TabPanel>
      <TabPanel value={value} index={1}>
      <Iframe url="https://rbalderas.shinyapps.io/podsearch_visualiztions_v2/"
        width="1390px"
        height="1000px"
        id=""
        className=""
        display="block"
        position="relative"/>
      </TabPanel>
      <TabPanel value={value} index={2}>
        <h2> Introduction </h2>
        <p> Welcome to PodSearch! This interactive dashboard lets the uesr find podcasts based upon their personal specifications and preferences!</p>
        <p>With PodSearch, we wanted to re-imagine podcast recommendation services for our peers to make it easier for them to find podcasts they enjoy.
        <p>Recommendations were going to be personalized by the users preferences: explicitness, amount of episodes available, and categories.</p> 
        The idea was novel for mimicking 'dating app' functionality ('right or left' buttons, directing users to new matches or podcast show links).</p>
        <h2> Methods </h2>
        <p> We created our website using website design languages and tools such as React, JavaScript, and HTML to host and design the website. 
        <p> We designed graphical elements for the website to make it more interactive and engaging for our users, and so they could clearly see the recommendations given to them based on their preferences</p>
      <p> Web-scraping was heavily used in our project using tools and languages such as Python and R scripts that gathered information on episode lengths, publish dates, etc.
      We went through the data collected, and cleaned and engineered new data and published data on reviews and ratings (Podcast Reviews by Thought Vector on Kaggle)</p>
      </p>
        <p>With PodSearch, we wanted to re-imagine podcast recommendation services for our peers to make it easier for them to find podcasts they enjoy.
        <p>Recommendations were going to be personalized by the users preferences: explicitness, amount of episodes available, and categories.
          </p> 
        The idea was novel for mimicking 'dating app' functionality ('right or left' buttons, directing users to new matches or podcast show links).</p>
        <h2> Results </h2>
        <p> We believe that our group delivered a fun, interactive platform for users seeking podcast recommendations.</p>
        <p>We used over 500 podcasts in our data and these podcasts were analyzed to create a robust dataset. This work was done to make sure that each user would obtain a podcast recommendation within their interests.
        <p>The platform is based upon both user preference and data engineering to provide the user with the best possible recommendations. </p> 
        </p>
      </TabPanel>
      <TabPanel value={value} index={3}>
        <h2> Sydney Brandt</h2>
        <p>Sydney Brandt is a senior at the University of Arizona graduating with a Bachelor of Science in Information Science. </p>
        <p>Sydney wrote and ran scripts in R that web-scraped RSS files for information on podcasts. From there, she worked to create an R Shiny dashboard where users could filter the dataset and find podcasts that intrigued them.</p>
        <h2> Brendan Bertone</h2>
        <p>Brendan Bertone is a Senior at the University of Arizona graduating in May of 2023</p>
        <p>For the Podcast project, Brendan was in charge of the data engineering side specifically working with the Kaggle Data. Brendan helped with converting the JSON data from Kaggle into R, filtering and cleaning the data, and lastly building a web scrapper that would take the podcast titles and retrieve the associated RSS feed links for them. Lastly, he helped integrate and combine the Kaggle and RSS data so it could be used for the dashboard and website.</p>
        <h2> Roberto Balderas</h2>
        <p>Roberto Balderas is a Senior at the University of Arizona graduating with a Bachelor of Arts in Information Science.</p>
        <p>Roberto came up with the overall aesthetic of PodSearch, choosing color palettes, designing logos, and designing the overall layout of the R shiny apps. He also aided in the development of both the dating and visualization R shiny apps, creating filters, cleaning data, and also the zodiac images displayed with each result.</p>
        <h2> Jackie Ganem</h2>
        <p>Jackie Ganem is a Senior at the University of Arizona graduating in May of 2023. </p>
        <p>For the Podsearch project, Jackie was in charge of creating and designing the website to be hosted by AWS. Jackie implemented the RShiny dashboards, including the main dashboard and the visualizations dashboard, into the React website. She also published the website to AWS so more people could access the project.
        </p>
      </TabPanel>
    </div>
  );
}