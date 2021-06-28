Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9233B5A43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhF1IJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhF1IJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:09:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4692C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:07:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y13so8461554plc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7QJLE4fkljxkN37Egfdtln0RvPnuuwHSkXWilmvZ8oc=;
        b=hD0726oQlaF68LVrCictW5Txlo2BHPXfVq/2V+4Wa2L31DgX6jewp98INIg5RfPQ8s
         k/rZ0OVg76QhhEjiXnN5xGS0t2LXvXhm7xpFvs6/BNy3wknKkccBF2QEHuvazrxWfDHi
         a6KA+giXRUs7M/j7+xyUTaYVIfkDswU/8yDpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QJLE4fkljxkN37Egfdtln0RvPnuuwHSkXWilmvZ8oc=;
        b=doY3H88+5m9x36CXD2v0ynOHgIHICW1EUHUr2+h5RkIO4ZQpq7TyDczZCEKije3NxP
         xtNPbV2AQQ6kbjF4od8uP706aCbkmPMzN25GrlKzxNUFJZtR8eKO3JsE4Py9vl6qByDg
         73ySaZbxenstuDv7roYIN81US7u+2nAqhgxyIhYxhvV+lIIMwdELNwbD2eyhARQF6TVV
         x/9Xjm61UsWP/HnNLfhbQa1e1UMnHXPTFOXoxxw0vTCL/DpwqlSmvlgUC90zVcOvZ2o7
         FcfJ2QSd/1ZZj9vMgIozRaHzTKRB569w3XDB7jsT/pgow1kA5Vcw8hTTlAHu5c8WI0qy
         RFjQ==
X-Gm-Message-State: AOAM5333/JKqYi7pN9epZwdvrwnisnV2BbKakUAhNKrL6QJyxgAfvNIJ
        vC6QYwbDLxXP4pN//aE70YoYBGRXo69eqA==
X-Google-Smtp-Source: ABdhPJzeI42Np1WjFehbE4amFF2q1Kj0fdaP8LFESNKPVIvylS39XsjtFLQDbt87MaDb77owHSBtIw==
X-Received: by 2002:a17:90a:af85:: with SMTP id w5mr36515142pjq.37.1624867646157;
        Mon, 28 Jun 2021 01:07:26 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:d9cf:d433:6a82:6f81])
        by smtp.gmail.com with UTF8SMTPSA id t6sm18892211pjo.4.2021.06.28.01.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 01:07:25 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Lyude Paul <lyude@redhat.com>,
        Sam McNally <sammc@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 3/3] drm_dp_cec: add MST support
Date:   Mon, 28 Jun 2021 18:06:43 +1000
Message-Id: <20210628180604.v6.3.If7fc06fd679af0665ada9ff0524291c61dd35d24@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210628180604.v6.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
References: <20210628180604.v6.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DP v2.0 errata E5, CEC tunneling can be supported through an MST
topology.

When tunneling CEC through an MST port, CEC IRQs are delivered via a
sink event notify message; when a sink event notify message is received,
trigger CEC IRQ handling - ESI1 is not used for remote CEC IRQs so its
value is not checked.

Register and unregister for all MST connectors, ensuring their
drm_dp_aux_cec struct won't be accessed uninitialized.

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sam McNally <sammc@chromium.org>
---

Changes in v6:
- Removed superfluous #include <drm/drm_dp_mst_helper.h>
- Removed spurious added newlines

Changes in v4:
- Removed use of work queues
- Updated checks of aux.transfer to accept aux.is_remote

Changes in v3:
- Fixed whitespace in drm_dp_cec_mst_irq_work()
- Moved drm_dp_cec_mst_set_edid_work() with the other set_edid functions

Changes in v2:
- Used aux->is_remote instead of aux->cec.is_mst, removing the need for
  the previous patch in the series
- Added a defensive check for null edid in the deferred set_edid work,
  in case the edid is no longer valid at that point

 drivers/gpu/drm/drm_dp_cec.c          | 17 +++++++++++++----
 drivers/gpu/drm/drm_dp_mst_topology.c | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
index 3ab2609f9ec7..61c59e2c4b3e 100644
--- a/drivers/gpu/drm/drm_dp_cec.c
+++ b/drivers/gpu/drm/drm_dp_cec.c
@@ -245,13 +245,22 @@ void drm_dp_cec_irq(struct drm_dp_aux *aux)
 	int ret;
 
 	/* No transfer function was set, so not a DP connector */
-	if (!aux->transfer)
+	if (!aux->transfer && !aux->is_remote)
 		return;
 
 	mutex_lock(&aux->cec.lock);
 	if (!aux->cec.adap)
 		goto unlock;
 
+	if (aux->is_remote) {
+		/*
+		 * For remote connectors, CEC IRQ is triggered by an explicit
+		 * message so ESI1 is not involved.
+		 */
+		drm_dp_cec_handle_irq(aux);
+		goto unlock;
+	}
+
 	ret = drm_dp_dpcd_readb(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1,
 				&cec_irq);
 	if (ret < 0 || !(cec_irq & DP_CEC_IRQ))
@@ -307,7 +316,7 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 	u8 cap;
 
 	/* No transfer function was set, so not a DP connector */
-	if (!aux->transfer)
+	if (!aux->transfer && !aux->is_remote)
 		return;
 
 #ifndef CONFIG_MEDIA_CEC_RC
@@ -383,7 +392,7 @@ EXPORT_SYMBOL(drm_dp_cec_set_edid);
 void drm_dp_cec_unset_edid(struct drm_dp_aux *aux)
 {
 	/* No transfer function was set, so not a DP connector */
-	if (!aux->transfer)
+	if (!aux->transfer && !aux->is_remote)
 		return;
 
 	cancel_delayed_work_sync(&aux->cec.unregister_work);
@@ -428,7 +437,7 @@ void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
 				   struct drm_connector *connector)
 {
 	WARN_ON(aux->cec.adap);
-	if (WARN_ON(!aux->transfer))
+	if (WARN_ON(!aux->transfer && !aux->is_remote))
 		return;
 	aux->cec.connector = connector;
 	INIT_DELAYED_WORK(&aux->cec.unregister_work,
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1cc1a58cfa8b..b58c884fe67b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2362,6 +2362,8 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
 int drm_dp_mst_connector_late_register(struct drm_connector *connector,
 				       struct drm_dp_mst_port *port)
 {
+	drm_dp_cec_register_connector(&port->aux, connector);
+
 	drm_dbg_kms(port->mgr->dev, "registering %s remote bus for %s\n",
 		    port->aux.name, connector->kdev->kobj.name);
 
@@ -2385,6 +2387,8 @@ void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
 	drm_dbg_kms(port->mgr->dev, "unregistering %s remote bus for %s\n",
 		    port->aux.name, connector->kdev->kobj.name);
 	drm_dp_aux_unregister_devnode(&port->aux);
+
+	drm_dp_cec_unregister_connector(&port->aux);
 }
 EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
 
@@ -2662,6 +2666,21 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 		queue_work(system_long_wq, &mstb->mgr->work);
 }
 
+static void
+drm_dp_mst_handle_sink_event(struct drm_dp_mst_branch *mstb,
+			    struct drm_dp_sink_event_notify *sink_event)
+{
+	struct drm_dp_mst_port *port;
+
+	if (sink_event->event_id & DP_SINK_EVENT_CEC_IRQ_EVENT) {
+		port = drm_dp_get_port(mstb, sink_event->port_number);
+		if (port) {
+			drm_dp_cec_irq(&port->aux);
+			drm_dp_mst_topology_put_port(port);
+		}
+	}
+}
+
 static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_dp_mst_topology_mgr *mgr,
 							       u8 lct, u8 *rad)
 {
@@ -4177,6 +4196,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
 		hotplug = true;
+	} else if (msg->req_type == DP_SINK_EVENT_NOTIFY) {
+		drm_dp_mst_handle_sink_event(mstb, &msg->u.sink_event);
 	}
 
 	drm_dp_mst_topology_put_mstb(mstb);
@@ -4369,6 +4390,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 		break;
 	}
 out:
+	if (ret != connector_status_connected)
+		drm_dp_cec_unset_edid(&port->aux);
 	drm_dp_mst_topology_put_port(port);
 	return ret;
 }
@@ -4399,6 +4422,7 @@ struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_
 		edid = drm_get_edid(connector, &port->aux.ddc);
 	}
 	port->has_audio = drm_detect_monitor_audio(edid);
+	drm_dp_cec_set_edid(&port->aux, edid);
 	drm_dp_mst_topology_put_port(port);
 	return edid;
 }
-- 
2.32.0.93.g670b81a890-goog

