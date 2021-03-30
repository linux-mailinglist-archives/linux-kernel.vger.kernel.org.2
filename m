Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87034E6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhC3LwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhC3LwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:52:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:52:09 -0700 (PDT)
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:2d37:13aa:2f32:9c00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5F1C01F45450;
        Tue, 30 Mar 2021 12:52:07 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        enric.balletbo@collabora.com, laurent.pinchart@ideasonboard.com
Subject: [PATCH] drm: bridge: rename the function drm_bridge_hpd_notify to drm_bridge_hpd_cb
Date:   Tue, 30 Mar 2021 13:52:00 +0200
Message-Id: <20210330115200.26006-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_bridge_funcs has a function called 'hpd_notify'.
The function drm_bridge_hpd_notify does not call
'hpd_notify' but it calls 'hpd_cb'. This is rather
confusing. Rename the function to fix this confusion.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c        | 2 +-
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
 drivers/gpu/drm/bridge/display-connector.c          | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c          | 8 ++++----
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           | 2 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c               | 2 +-
 drivers/gpu/drm/drm_bridge.c                        | 8 ++++----
 include/drm/drm_bridge.h                            | 8 ++++----
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 76555ae64e9c..748f82910f4f 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -449,7 +449,7 @@ static void adv7511_hpd_work(struct work_struct *work)
 				cec_phys_addr_invalidate(adv7511->cec_adap);
 			drm_kms_helper_hotplug_event(adv7511->connector.dev);
 		} else {
-			drm_bridge_hpd_notify(&adv7511->bridge, status);
+			drm_bridge_hpd_cb(&adv7511->bridge, status);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index d0c65610ebb5..682da288ff6d 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -794,7 +794,7 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 		if (mhdp->connector.dev)
 			drm_kms_helper_hotplug_event(mhdp->bridge.dev);
 		else
-			drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
+			drm_bridge_hpd_cb(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 	}
 }
 
@@ -2314,7 +2314,7 @@ static irqreturn_t cdns_mhdp_irq_handler(int irq, void *data)
 			else
 				drm_kms_helper_hotplug_event(mhdp->bridge.dev);
 		} else {
-			drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
+			drm_bridge_hpd_cb(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 		}
 	}
 
diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 05eb759da6fc..8ccd69d7fe34 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -98,7 +98,7 @@ static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
 	struct display_connector *conn = arg;
 	struct drm_bridge *bridge = &conn->bridge;
 
-	drm_bridge_hpd_notify(bridge, display_connector_detect(bridge));
+	drm_bridge_hpd_cb(bridge, display_connector_detect(bridge));
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index fee27952ec6d..58f61b5da605 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -175,10 +175,10 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 		connected = lt9611uxc->hdmi_connected;
 		mutex_unlock(&lt9611uxc->ocm_lock);
 
-		drm_bridge_hpd_notify(&lt9611uxc->bridge,
-				      connected ?
-				      connector_status_connected :
-				      connector_status_disconnected);
+		drm_bridge_hpd_cb(&lt9611uxc->bridge,
+				  connected ?
+				  connector_status_connected :
+				  connector_status_disconnected);
 	}
 }
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index dda4fa9a1a08..984ab5c4bc71 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3026,7 +3026,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 
 		if (hdmi->bridge.dev) {
 			drm_helper_hpd_irq_event(hdmi->bridge.dev);
-			drm_bridge_hpd_notify(&hdmi->bridge, status);
+			drm_bridge_hpd_cb(&hdmi->bridge, status);
 		}
 	}
 
diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index e0e015243a60..2f079b6f51bc 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -103,7 +103,7 @@ static irqreturn_t tpd12s015_hpd_isr(int irq, void *data)
 	struct tpd12s015_device *tpd = data;
 	struct drm_bridge *bridge = &tpd->bridge;
 
-	drm_bridge_hpd_notify(bridge, tpd12s015_detect(bridge));
+	drm_bridge_hpd_cb(bridge, tpd12s015_detect(bridge));
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 64f0effb52ac..653761a0d5f9 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1173,7 +1173,7 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
 /**
- * drm_bridge_hpd_notify - notify hot plug detection events
+ * drm_bridge_hpd_cb - notify hot plug detection events
  * @bridge: bridge control structure
  * @status: output connection status
  *
@@ -1183,15 +1183,15 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
  *
  * This function shall be called in a context that can sleep.
  */
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status)
+void drm_bridge_hpd_cb(struct drm_bridge *bridge,
+		       enum drm_connector_status status)
 {
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
 		bridge->hpd_cb(bridge->hpd_data, status);
 	mutex_unlock(&bridge->hpd_mutex);
 }
-EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
+EXPORT_SYMBOL_GPL(drm_bridge_hpd_cb);
 
 #ifdef CONFIG_OF
 /**
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 2195daa289d2..ab54715eda8b 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -605,7 +605,7 @@ struct drm_bridge_funcs {
 	 * @hpd_enable:
 	 *
 	 * Enable hot plug detection. From now on the bridge shall call
-	 * drm_bridge_hpd_notify() each time a change is detected in the output
+	 * drm_bridge_hpd_cb() each time a change is detected in the output
 	 * connection status, until hot plug detection gets disabled with
 	 * @hpd_disable.
 	 *
@@ -620,7 +620,7 @@ struct drm_bridge_funcs {
 	 * @hpd_disable:
 	 *
 	 * Disable hot plug detection. Once this function returns the bridge
-	 * shall not call drm_bridge_hpd_notify() when a change in the output
+	 * shall not call drm_bridge_hpd_cb() when a change in the output
 	 * connection status occurs.
 	 *
 	 * This callback is optional and shall only be implemented by bridges
@@ -878,8 +878,8 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 				      enum drm_connector_status status),
 			   void *data);
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status);
+void drm_bridge_hpd_cb(struct drm_bridge *bridge,
+		       enum drm_connector_status status);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
-- 
2.17.1

