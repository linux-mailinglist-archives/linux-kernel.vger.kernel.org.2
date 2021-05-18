Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408343878EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349265AbhERMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349254AbhERMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:37:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFF2C061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:36:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m124so6896022pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPL8zKWxN/QMsIpoZTe6I/f+o4e19YjDxONkebyd5xk=;
        b=oK8aaCGKbPvcz6r//KEvpLbhVBoc70yh+9ohwoxddL7kNq6fhioflGHUEhLhhmPdYU
         LZQ8e1aWeq+08kAgquukPEoeDqHrmV8ZF63eU8yf12SpLjTDeHGfOyZdQXLU1+pVSV7F
         2k53/HVjvDngeWJr+IEZmKm3UPQGCCEYZ1xmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPL8zKWxN/QMsIpoZTe6I/f+o4e19YjDxONkebyd5xk=;
        b=hWrT6tBSCSx/ps4qhDNSdlryGJiKuGjXS2tJC9Y1Wmh/ZB5acigvuOVDj02R8+Ir0b
         Zn2bm6Dn9fhU2QtwTOMQhjLoSsMHK3/J+RAlzrLUNpCI6efjExIXp84OHWLGjePTT/aF
         vhVaj7KI1ZP/l6+10FHBe4pZhKgzx78+/+ZQHSW++VETrI3ActwkBp1LJ0krlLVTr1f9
         azyg4LT4sqSs41bqMS94vw9RZVagzSU8XkF/qyZWKJ3/e4jLLA2lBoFlJhM17dQ2viwA
         EGp7+fKPgnMQszDzdsiY3OVWCFRo5oOBw3Kuvu5b0f7RutW+tocaNAGi6Frm9EgJ0t2o
         RPSQ==
X-Gm-Message-State: AOAM5337klthvUIZ3U9DQmiZnSXFGgu6z5uOnheJ5cUxivP1FYCysjIc
        qIajglb0JAhhubm/6nSlKY3CKT+pz5+ojQ==
X-Google-Smtp-Source: ABdhPJxHWtW1pff22GHTjUZ8eVUF2c/c5V6+GhO0ZkewieedwQfOgxJWeOu8mece2gmSi9hw1jIOag==
X-Received: by 2002:aa7:931a:0:b029:2d9:4602:5957 with SMTP id 26-20020aa7931a0000b02902d946025957mr4778708pfj.45.1621341372823;
        Tue, 18 May 2021 05:36:12 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:d4a6:9a84:c26c:6e50])
        by smtp.gmail.com with UTF8SMTPSA id x19sm10810341pgj.66.2021.05.18.05.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 05:36:12 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Lyude Paul <lyude@redhat.com>,
        Sam McNally <sammc@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/3] drm_dp_cec: add MST support
Date:   Tue, 18 May 2021 22:35:30 +1000
Message-Id: <20210518223508.v4.3.If7fc06fd679af0665ada9ff0524291c61dd35d24@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518223508.v4.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
References: <20210518223508.v4.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
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
Signed-off-by: Sam McNally <sammc@chromium.org>
---

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

 drivers/gpu/drm/drm_dp_cec.c          | 20 ++++++++++++++++----
 drivers/gpu/drm/drm_dp_mst_topology.c | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
index 3ab2609f9ec7..1abd3f4654dc 100644
--- a/drivers/gpu/drm/drm_dp_cec.c
+++ b/drivers/gpu/drm/drm_dp_cec.c
@@ -14,6 +14,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_dp_mst_helper.h>
 
 /*
  * Unfortunately it turns out that we have a chicken-and-egg situation
@@ -245,13 +246,22 @@ void drm_dp_cec_irq(struct drm_dp_aux *aux)
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
@@ -307,7 +317,7 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 	u8 cap;
 
 	/* No transfer function was set, so not a DP connector */
-	if (!aux->transfer)
+	if (!aux->transfer && !aux->is_remote)
 		return;
 
 #ifndef CONFIG_MEDIA_CEC_RC
@@ -375,6 +385,7 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 unlock:
 	mutex_unlock(&aux->cec.lock);
 }
+
 EXPORT_SYMBOL(drm_dp_cec_set_edid);
 
 /*
@@ -383,7 +394,7 @@ EXPORT_SYMBOL(drm_dp_cec_set_edid);
 void drm_dp_cec_unset_edid(struct drm_dp_aux *aux)
 {
 	/* No transfer function was set, so not a DP connector */
-	if (!aux->transfer)
+	if (!aux->transfer && !aux->is_remote)
 		return;
 
 	cancel_delayed_work_sync(&aux->cec.unregister_work);
@@ -393,6 +404,7 @@ void drm_dp_cec_unset_edid(struct drm_dp_aux *aux)
 		goto unlock;
 
 	cec_phys_addr_invalidate(aux->cec.adap);
+
 	/*
 	 * We're done if we want to keep the CEC device
 	 * (drm_dp_cec_unregister_delay is >= NEVER_UNREG_DELAY) or if the
@@ -428,7 +440,7 @@ void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
 				   struct drm_connector *connector)
 {
 	WARN_ON(aux->cec.adap);
-	if (WARN_ON(!aux->transfer))
+	if (WARN_ON(!aux->transfer && !aux->is_remote))
 		return;
 	aux->cec.connector = connector;
 	INIT_DELAYED_WORK(&aux->cec.unregister_work,
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 29aad3b6b31a..5612caf9fb49 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2359,6 +2359,8 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
 int drm_dp_mst_connector_late_register(struct drm_connector *connector,
 				       struct drm_dp_mst_port *port)
 {
+	drm_dp_cec_register_connector(&port->aux, connector);
+
 	drm_dbg_kms(port->mgr->dev, "registering %s remote bus for %s\n",
 		    port->aux.name, connector->kdev->kobj.name);
 
@@ -2382,6 +2384,8 @@ void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
 	drm_dbg_kms(port->mgr->dev, "unregistering %s remote bus for %s\n",
 		    port->aux.name, connector->kdev->kobj.name);
 	drm_dp_aux_unregister_devnode(&port->aux);
+
+	drm_dp_cec_unregister_connector(&port->aux);
 }
 EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
 
@@ -2682,6 +2686,21 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
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
@@ -4170,6 +4189,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
 		hotplug = true;
+	} else if (msg->req_type == DP_SINK_EVENT_NOTIFY) {
+		drm_dp_mst_handle_sink_event(mstb, &msg->u.sink_event);
 	}
 
 	drm_dp_mst_topology_put_mstb(mstb);
@@ -4362,6 +4383,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 		break;
 	}
 out:
+	if (ret != connector_status_connected)
+		drm_dp_cec_unset_edid(&port->aux);
 	drm_dp_mst_topology_put_port(port);
 	return ret;
 }
@@ -4392,6 +4415,7 @@ struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_
 		edid = drm_get_edid(connector, &port->aux.ddc);
 	}
 	port->has_audio = drm_detect_monitor_audio(edid);
+	drm_dp_cec_set_edid(&port->aux, edid);
 	drm_dp_mst_topology_put_port(port);
 	return edid;
 }
-- 
2.31.1.751.gd2f1c929bd-goog

