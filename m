Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1839AED4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhFCXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:48:41 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:45624 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:48:40 -0400
Received: by mail-wm1-f46.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so336940wmg.4;
        Thu, 03 Jun 2021 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEhd2JIVnEi/+Epm1rky2qOq6YPm+V27d0RLFZVEOBU=;
        b=ZxmyOK9uEmovmY4Za5mXppXj/tTIovO45GVAOhjsfq1ywnEJ9F+TVy4xaaaOi6/KrJ
         KAmPqUbSXTwdcAPdikjgXGB3v7sJqcvRhVVEov3kUJBxsqn/OWLgWgSr+R9xD72TlBfm
         /d3X0M+9fmwpXG3lFeTU4X3C/cLf1zqSuF3WxRWGoVdtp9n0KHp2mbbsZqmP8Y2xFyZj
         0iiV0Cs0bBaLn+y5vMRClEDvmH2NnK4n8PVwhgzTXyv2wL4W1q+bLYftByycRPillKAx
         8kyoQJkhKowO+FUkZZ+CuMaXCRzrojtpzRcqDv75uU/L+07KrIdXnoSsQUEfbZPE5pTA
         8LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEhd2JIVnEi/+Epm1rky2qOq6YPm+V27d0RLFZVEOBU=;
        b=tFdZLLvR/VAOvk7RM7q5Sqsnigl6HWIsS/X7dyPQ9y8f+RlETjrXyUma70GOXDuvhF
         a2EHXJO80ctrx/k+UeP8fxAY3MxNi5C+Y0KTu4mf9rDJeHpb6OHugGcIF9vCxrvSoFLd
         0apYC/o1nJpKX25e7nYxH4w/WLXRxBedsNF8jDkXoLKJOgrsU9CBzEAzLLYxNS5Lhp3R
         Snaibzv0s3/IF0r2cZNorxA5TMqY2koFWH1nyqwV2Mve5vDTyOYYcF/OWIqwzlqL1YE7
         xXGlgyAlFwDmNPgCH0zYrT6APcztPt+PVbUmgMmNIBs/je/6NhchIEvvDWy04OIPWp4e
         50SQ==
X-Gm-Message-State: AOAM533PAggtg2Lj29uOYXavYHiLfqyuR68oNDDrw12jA5D22pBt4BeT
        RN6862txv4BM1Ths44t1REU=
X-Google-Smtp-Source: ABdhPJxU7MILRLV2PZGkn5S6pcw2NeGK92Ystc6GanPBphMv1oUP9iGPyHcLdRQx3GsM6BZMUH4w2g==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr768841wmh.115.1622763943815;
        Thu, 03 Jun 2021 16:45:43 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:43 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] platform/surface: aggregator: Allow registering notifiers without enabling events
Date:   Fri,  4 Jun 2021 01:45:20 +0200
Message-Id: <20210603234526.2503590-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
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

