import React from 'react';
import 'react-native-gesture-handler';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import ScannerScreen from './src/ScannerScreen';
import ResultsScreen from './src/ResultsScreen';

const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerStyle: { backgroundColor: '#f8fafc' },
          headerTintColor: '#0f172a',
          headerTitleStyle: { fontSize: 18, fontWeight: '700' },
          headerShadowVisible: false,
          cardStyle: { backgroundColor: '#f8fafc' },
        }}
      >
        <Stack.Screen
          name="Scanner"
          component={ScannerScreen}
          options={{ title: 'Scan Product' }}
        />
        <Stack.Screen
          name="Results"
          component={ResultsScreen}
          options={{ title: 'Best Prices' }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

