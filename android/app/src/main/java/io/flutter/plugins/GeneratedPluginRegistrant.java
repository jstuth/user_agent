package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import de.parallax3d.user_agent.UserAgentPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    UserAgentPlugin.registerWith(registry.registrarFor("de.parallax3d.user_agent.UserAgentPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
