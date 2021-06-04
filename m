Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FDB39BA2F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFDNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFDNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:50:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45DCC061766;
        Fri,  4 Jun 2021 06:48:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h8so9365828wrz.8;
        Fri, 04 Jun 2021 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ETfAoIBNBhINJTqR6UlwOrmE8UtRJyCzl+e5YsJXcc=;
        b=Y5/sBVP4cbz/fEpeuSjzALWFMDmPwCOJA2mrvlid/bj813TELrIGMRjj9XpNeivBb2
         QK39A6Py1ovExQSub5qCZ5gmUIOYgwYypLND7gfApU27fuAlHEzhuYmZTrCfX1q4QhfF
         7jYnGI1PpXxizM+hAMTGEF+vMv4vm8deD7ciqEKNt2S+2mxDTyZ93iCpVzqzirEoTKv0
         FIm36+DdDGoMNwa23pgs9njH+oRUEzqFECh48sCqvegW8s4RhK/+6Zu0CqaCLT11d3Ec
         NmszZBNjycldLPijoFtNT7Z5+cHCPSqifhZVONuyehMFoDxpudaTW3ctop2vqXrR1iVV
         thtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ETfAoIBNBhINJTqR6UlwOrmE8UtRJyCzl+e5YsJXcc=;
        b=HMhoxyj65enoLSyDEfV4j7TrQurI96fM82hYWmASmxkHTM0m3UXd7Sh/hoTHl/F4Hk
         JibXWlQ4IecOkvc7utsFNdMp0uxhy8iQkaPi3eKGi6QNdM8z8XrYfpCztpP25Jaeh/a7
         Pi4W2+NSqEdDlyBpP/NUOQnaWyOSTeOyh16Valo26QtNtEi1++wCIJQWyHViVA4lsYZk
         A1PC3a4nhnmGpJATluWRjIYAIP5MBXSusY6d6BoIBnQKRcw5f7lxe8HH0VUu6c4N8SdE
         z+0TPEbFnhKAqXwNqLSYJrAj5Bq0yTWyt0e3y0trkZaTfzN5VHgORkdZMGEuQF/JQg5R
         YMZw==
X-Gm-Message-State: AOAM533PwvP3fOeJrMWmwk4SegU8rKdmp/BhfIWcV9cg6isYlNy322Zr
        jnoqqMSi7jSb9x173ym9DUg=
X-Google-Smtp-Source: ABdhPJzKDX8t3tlny7tVWmgjExSH7DIyCceDeOv5GRO6mA5GkblNzyi8SJarKHBzbvqXoWr6qY7t7Q==
X-Received: by 2002:a5d:4848:: with SMTP id n8mr4195817wrs.70.1622814499242;
        Fri, 04 Jun 2021 06:48:19 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:18 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] platform/surface: aggregator: Allow registering notifiers without enabling events
Date:   Fri,  4 Jun 2021 15:47:49 +0200
Message-Id: <20210604134755.535590-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, each SSAM event notifier is directly tied to one group of
events. This makes sense as registering a notifier will automatically
take care of enabling the corresponding event group and normally drivers
only need notifications for a very limited number of events, associated
with different callbacks for each group.

However, there are rare cases, especially for debugging, when we want to
get notifications for a whole event target category instead of just a
single group of events in that category. Registering multiple notifiers,
i.e. one per group, may be infeasible due to two issues: a) we might not
know every event enable/disable specification as some events are
auto-enabled by the EC and b) forwarding this to the same callback will
lead to duplicate events as we might not know the full event
specification to perform the appropriate filtering.

This commit introduces observer-notifiers, which are notifiers that are
not tied to a specific event group and do not attempt to manage any
events. In other words, they can be registered without enabling any
event group or incrementing the corresponding reference count and just
act as silent observers, listening to all currently/previously enabled
events based on their match-specification.

Essentially, this allows us to register one single notifier for a full
event target category, meaning that we can process all events of that
target category in a single callback without duplication. Specifically,
this will be used in the cdev debug interface to forward events to
user-space via a device file from which the events can be read.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v2:
 - None

---
 .../platform/surface/aggregator/controller.c  | 69 +++++++++++--------
 include/linux/surface_aggregator/controller.h | 17 +++++
 2 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index a06964aa96e7..cd3a6b77f48d 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2127,9 +2127,15 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
  * @ctrl: The controller to register the notifier on.
  * @n:    The event notifier to register.
  *
- * Register an event notifier and increment the usage counter of the
- * associated SAM event. If the event was previously not enabled, it will be
- * enabled during this call.
+ * Register an event notifier. Increment the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the event is not
+ * marked as an observer and is currently not enabled, it will be enabled
+ * during this call. If the notifier is marked as an observer, no attempt will
+ * be made at enabling any event and no reference count will be modified.
+ *
+ * Notifiers marked as observers do not need to be associated with one specific
+ * event, i.e. as long as no event matching is performed, only the event target
+ * category needs to be set.
  *
  * Return: Returns zero on success, %-ENOSPC if there have already been
  * %INT_MAX notifiers for the event ID/type associated with the notifier block
@@ -2138,11 +2144,10 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
  * for the specific associated event, returns the status of the event-enable
  * EC-command.
  */
-int ssam_notifier_register(struct ssam_controller *ctrl,
-			   struct ssam_event_notifier *n)
+int ssam_notifier_register(struct ssam_controller *ctrl, struct ssam_event_notifier *n)
 {
 	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
-	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_refcount_entry *entry = NULL;
 	struct ssam_nf_head *nf_head;
 	struct ssam_nf *nf;
 	int status;
@@ -2155,29 +2160,32 @@ int ssam_notifier_register(struct ssam_controller *ctrl,
 
 	mutex_lock(&nf->lock);
 
-	entry = ssam_nf_refcount_inc(nf, n->event.reg, n->event.id);
-	if (IS_ERR(entry)) {
-		mutex_unlock(&nf->lock);
-		return PTR_ERR(entry);
-	}
+	if (!(n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)) {
+		entry = ssam_nf_refcount_inc(nf, n->event.reg, n->event.id);
+		if (IS_ERR(entry)) {
+			mutex_unlock(&nf->lock);
+			return PTR_ERR(entry);
+		}
 
-	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
-		 n->event.reg.target_category, n->event.id.target_category,
-		 n->event.id.instance, entry->refcount);
+		ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+			 n->event.reg.target_category, n->event.id.target_category,
+			 n->event.id.instance, entry->refcount);
+	}
 
 	status = ssam_nfblk_insert(nf_head, &n->base);
 	if (status) {
-		entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
-		if (entry->refcount == 0)
-			kfree(entry);
+		if (entry) {
+			entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
+			if (entry->refcount == 0)
+				kfree(entry);
+		}
 
 		mutex_unlock(&nf->lock);
 		return status;
 	}
 
-	if (entry->refcount == 1) {
-		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id,
-					       n->event.flags);
+	if (entry && entry->refcount == 1) {
+		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id, n->event.flags);
 		if (status) {
 			ssam_nfblk_remove(&n->base);
 			kfree(ssam_nf_refcount_dec(nf, n->event.reg, n->event.id));
@@ -2188,7 +2196,7 @@ int ssam_notifier_register(struct ssam_controller *ctrl,
 
 		entry->flags = n->event.flags;
 
-	} else if (entry->flags != n->event.flags) {
+	} else if (entry && entry->flags != n->event.flags) {
 		ssam_warn(ctrl,
 			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
 			  n->event.flags, entry->flags, n->event.reg.target_category,
@@ -2205,17 +2213,16 @@ EXPORT_SYMBOL_GPL(ssam_notifier_register);
  * @ctrl: The controller the notifier has been registered on.
  * @n:    The event notifier to unregister.
  *
- * Unregister an event notifier and decrement the usage counter of the
- * associated SAM event. If the usage counter reaches zero, the event will be
- * disabled.
+ * Unregister an event notifier. Decrement the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the usage counter
+ * reaches zero, the event will be disabled.
  *
  * Return: Returns zero on success, %-ENOENT if the given notifier block has
  * not been registered on the controller. If the given notifier block was the
  * last one associated with its specific event, returns the status of the
  * event-disable EC-command.
  */
-int ssam_notifier_unregister(struct ssam_controller *ctrl,
-			     struct ssam_event_notifier *n)
+int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_notifier *n)
 {
 	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
 	struct ssam_nf_refcount_entry *entry;
@@ -2236,6 +2243,13 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl,
 		return -ENOENT;
 	}
 
+	/*
+	 * If this is an observer notifier, do not attempt to disable the
+	 * event, just remove it.
+	 */
+	if (n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)
+		goto remove;
+
 	entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
 	if (WARN_ON(!entry)) {
 		/*
@@ -2260,8 +2274,7 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl,
 	}
 
 	if (entry->refcount == 0) {
-		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id,
-						n->event.flags);
+		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id, n->event.flags);
 		kfree(entry);
 	}
 
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 0806796eabcb..cf4bb48a850e 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -795,6 +795,20 @@ enum ssam_event_mask {
 #define SSAM_EVENT_REGISTRY_REG \
 	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_REG, 0x02, 0x01, 0x02)
 
+/**
+ * enum ssam_event_notifier_flags - Flags for event notifiers.
+ * @SSAM_EVENT_NOTIFIER_OBSERVER:
+ *	The corresponding notifier acts as observer. Registering a notifier
+ *	with this flag set will not attempt to enable any event. Equally,
+ *	unregistering will not attempt to disable any event. Note that a
+ *	notifier with this flag may not even correspond to a certain event at
+ *	all, only to a specific event target category. Event matching will not
+ *	be influenced by this flag.
+ */
+enum ssam_event_notifier_flags {
+	SSAM_EVENT_NOTIFIER_OBSERVER = BIT(0),
+};
+
 /**
  * struct ssam_event_notifier - Notifier block for SSAM events.
  * @base:        The base notifier block with callback function and priority.
@@ -803,6 +817,7 @@ enum ssam_event_mask {
  * @event.id:    ID specifying the event.
  * @event.mask:  Flags determining how events are matched to the notifier.
  * @event.flags: Flags used for enabling the event.
+ * @flags:       Notifier flags (see &enum ssam_event_notifier_flags).
  */
 struct ssam_event_notifier {
 	struct ssam_notifier_block base;
@@ -813,6 +828,8 @@ struct ssam_event_notifier {
 		enum ssam_event_mask mask;
 		u8 flags;
 	} event;
+
+	unsigned long flags;
 };
 
 int ssam_notifier_register(struct ssam_controller *ctrl,
-- 
2.31.1

