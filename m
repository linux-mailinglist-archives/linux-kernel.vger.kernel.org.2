Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2139BA30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhFDNuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:50:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1744C061767;
        Fri,  4 Jun 2021 06:48:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h8so9365881wrz.8;
        Fri, 04 Jun 2021 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfHKxaz7aWTGDT2RfXcawOt0jx58xz6euWl0ucInBZM=;
        b=oLQjHEFGaBGigH28CcW5TC+n4EsStcYe/XLTm4DJP6tLx6B3hiQtf4889N1IQpKvy+
         k8B7XJFth7vVU3BLyRGAIyGCcF/o4QQvrbbRSmsLDYdPV9T+/fot8VG2NghTrYGlEYzh
         nirzCHuOHYvLtktbqIsjOlVM8S3n1mJeggPC8bgZLZFxQ0iJ8VfkBtt71x3Mh6mdsah8
         lbUcj4qe7tfXOceeynGudvuhnzcLZM5H8BCHYCRqJN+8T1ZuPFXX72+lnwGY00ogp9qO
         ZD2uF9tK/U0lc4IwJOrfZVzd5EdeIMPFZ8R2bu7mcNakpff/nmnYyy64h8bf0m14hJ9E
         YBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfHKxaz7aWTGDT2RfXcawOt0jx58xz6euWl0ucInBZM=;
        b=YgxObRL+Wj+1Y/Ho+UCmczN7W8jhfyvx+5XMojgdJRrH0fxmRzTFUQ+iE6+dltNlsu
         wscTc/YwDwDDE68Bd07V+ebNvDa3YjXtV5mHglKw4kbz6PlJYDi8a+hXxZaMBkoHzE9K
         w98ggCne5i7+mqiyqF/+yb8GmdcMrOiby4MDAsBuLJazykkfc30nWa1dvYHRGTzlZObf
         IQupR0adASsqQuFWf8u7PsNqQQ8ehusaVt1i6AHTQLwWpTwGzKebYlg5PmrjVBM3URdn
         g/iC0L/9VXUaVbPguMHDl+6/4rDBd88LFchp/3KRakdLUN+NL8Ncl2NaUAh0NUp2rQjU
         NEGA==
X-Gm-Message-State: AOAM531B1GQYo4AFZqR3sXye4ZfQCI1xTecIhx1CqWJKoq/fGBjxLABw
        l6+WOGQxvGPGSvEciTbP/9Q=
X-Google-Smtp-Source: ABdhPJxQwfGwS3xNf6dYFl+0qX5Kn1MWYofgxTAvHqoBv57B9TBKYWvDE41YwNiaR1L8KYUUibTNfQ==
X-Received: by 2002:a05:6000:1849:: with SMTP id c9mr4153989wri.140.1622814500329;
        Fri, 04 Jun 2021 06:48:20 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:19 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] platform/surface: aggregator: Allow enabling of events without notifiers
Date:   Fri,  4 Jun 2021 15:47:50 +0200
Message-Id: <20210604134755.535590-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can already enable and disable SAM events via one of two ways: either
via a (non-observer) notifier tied to a specific event group, or a
generic event enable/disable request. In some instances, however,
neither method may be desirable.

The first method will tie the event enable request to a specific
notifier, however, when we want to receive notifications for multiple
event groups of the same target category and forward this to the same
notifier callback, we may receive duplicate events, i.e. one event per
registered notifier. The second method will bypass the internal
reference counting mechanism, meaning that a disable request will
disable the event regardless of any other client driver using it, which
may break the functionality of that driver.

To address this problem, add new functions that allow enabling and
disabling of events via the event reference counting mechanism built
into the controller, without needing to register a notifier.

This can then be used in combination with observer notifiers to process
multiple events of the same target category without duplication in the
same callback function.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Remove unused variable
 - Avoid code duplication

---
 .../platform/surface/aggregator/controller.c  | 293 +++++++++++++++---
 include/linux/surface_aggregator/controller.h |   8 +
 2 files changed, 253 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index cd3a6b77f48d..c673aa8309c8 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -407,6 +407,31 @@ ssam_nf_refcount_dec(struct ssam_nf *nf, struct ssam_event_registry reg,
 	return NULL;
 }
 
+/**
+ * ssam_nf_refcount_dec_free() - Decrement reference-/activation-count of the
+ * given event and free its entry if the reference count reaches zero.
+ * @nf:  The notifier system reference.
+ * @reg: The registry used to enable/disable the event.
+ * @id:  The event ID.
+ *
+ * Decrements the reference-/activation-count of the specified event, freeing
+ * its entry if it reaches zero.
+ *
+ * Note: ``nf->lock`` must be held when calling this function.
+ */
+static void ssam_nf_refcount_dec_free(struct ssam_nf *nf,
+				      struct ssam_event_registry reg,
+				      struct ssam_event_id id)
+{
+	struct ssam_nf_refcount_entry *entry;
+
+	lockdep_assert_held(&nf->lock);
+
+	entry = ssam_nf_refcount_dec(nf, reg, id);
+	if (entry && entry->refcount == 0)
+		kfree(entry);
+}
+
 /**
  * ssam_nf_refcount_empty() - Test if the notification system has any
  * enabled/active events.
@@ -2122,6 +2147,109 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
 
 /* -- Top-level event registry interface. ----------------------------------- */
 
+/**
+ * ssam_nf_refcount_enable() - Enable event for reference count entry if it has
+ * not already been enabled.
+ * @ctrl:  The controller to enable the event on.
+ * @entry: The reference count entry for the event to be enabled.
+ * @flags: The flags used for enabling the event on the EC.
+ *
+ * Enable the event associated with the given reference count entry if the
+ * reference count equals one, i.e. the event has not previously been enabled.
+ * If the event has already been enabled (i.e. reference count not equal to
+ * one), check that the flags used for enabling match and warn about this if
+ * they do not.
+ *
+ * This does not modify the reference count itself, which is done with
+ * ssam_nf_refcount_inc() / ssam_nf_refcount_dec().
+ *
+ * Note: ``nf->lock`` must be held when calling this function.
+ *
+ * Return: Returns zero on success. If the event is enabled by this call,
+ * returns the status of the event-enable EC command.
+ */
+static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
+				   struct ssam_nf_refcount_entry *entry, u8 flags)
+{
+	const struct ssam_event_registry reg = entry->key.reg;
+	const struct ssam_event_id id = entry->key.id;
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	int status;
+
+	lockdep_assert_held(&nf->lock);
+
+	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 reg.target_category, id.target_category, id.instance, entry->refcount);
+
+	if (entry->refcount == 1) {
+		status = ssam_ssh_event_enable(ctrl, reg, id, flags);
+		if (status)
+			return status;
+
+		entry->flags = flags;
+
+	} else if (entry->flags != flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  flags, entry->flags, reg.target_category, id.target_category,
+			  id.instance);
+	}
+
+	return 0;
+}
+
+/**
+ * ssam_nf_refcount_enable() - Disable event for reference count entry if it is
+ * no longer in use and free the corresponding entry.
+ * @ctrl:  The controller to disable the event on.
+ * @entry: The reference count entry for the event to be disabled.
+ * @flags: The flags used for enabling the event on the EC.
+ *
+ * If the reference count equals zero, i.e. the event is no longer requested by
+ * any client, the event will be disabled and the corresponding reference count
+ * entry freed. The reference count entry must not be used any more after a
+ * call to this function.
+ *
+ * Also checks if the flags used for disabling the event match the flags used
+ * for enabling the event and warns if they do not (regardless of reference
+ * count).
+ *
+ * This does not modify the reference count itself, which is done with
+ * ssam_nf_refcount_inc() / ssam_nf_refcount_dec().
+ *
+ * Note: ``nf->lock`` must be held when calling this function.
+ *
+ * Return: Returns zero on success. If the event is disabled by this call,
+ * returns the status of the event-enable EC command.
+ */
+static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
+					 struct ssam_nf_refcount_entry *entry, u8 flags)
+{
+	const struct ssam_event_registry reg = entry->key.reg;
+	const struct ssam_event_id id = entry->key.id;
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	int status;
+
+	lockdep_assert_held(&nf->lock);
+
+	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 reg.target_category, id.target_category, id.instance, entry->refcount);
+
+	if (entry->flags != flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  flags, entry->flags, reg.target_category, id.target_category,
+			  id.instance);
+	}
+
+	if (entry->refcount == 0) {
+		status = ssam_ssh_event_disable(ctrl, reg, id, flags);
+		kfree(entry);
+	}
+
+	return status;
+}
+
 /**
  * ssam_notifier_register() - Register an event notifier.
  * @ctrl: The controller to register the notifier on.
@@ -2166,41 +2294,26 @@ int ssam_notifier_register(struct ssam_controller *ctrl, struct ssam_event_notif
 			mutex_unlock(&nf->lock);
 			return PTR_ERR(entry);
 		}
-
-		ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
-			 n->event.reg.target_category, n->event.id.target_category,
-			 n->event.id.instance, entry->refcount);
 	}
 
 	status = ssam_nfblk_insert(nf_head, &n->base);
 	if (status) {
-		if (entry) {
-			entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
-			if (entry->refcount == 0)
-				kfree(entry);
-		}
+		if (entry)
+			ssam_nf_refcount_dec_free(nf, n->event.reg, n->event.id);
 
 		mutex_unlock(&nf->lock);
 		return status;
 	}
 
-	if (entry && entry->refcount == 1) {
-		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id, n->event.flags);
+	if (entry) {
+		status = ssam_nf_refcount_enable(ctrl, entry, n->event.flags);
 		if (status) {
 			ssam_nfblk_remove(&n->base);
-			kfree(ssam_nf_refcount_dec(nf, n->event.reg, n->event.id));
+			ssam_nf_refcount_dec_free(nf, n->event.reg, n->event.id);
 			mutex_unlock(&nf->lock);
 			synchronize_srcu(&nf_head->srcu);
 			return status;
 		}
-
-		entry->flags = n->event.flags;
-
-	} else if (entry && entry->flags != n->event.flags) {
-		ssam_warn(ctrl,
-			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
-			  n->event.flags, entry->flags, n->event.reg.target_category,
-			  n->event.id.target_category, n->event.id.instance);
 	}
 
 	mutex_unlock(&nf->lock);
@@ -2247,35 +2360,20 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 	 * If this is an observer notifier, do not attempt to disable the
 	 * event, just remove it.
 	 */
-	if (n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)
-		goto remove;
-
-	entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
-	if (WARN_ON(!entry)) {
-		/*
-		 * If this does not return an entry, there's a logic error
-		 * somewhere: The notifier block is registered, but the event
-		 * refcount entry is not there. Remove the notifier block
-		 * anyways.
-		 */
-		status = -ENOENT;
-		goto remove;
-	}
-
-	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
-		 n->event.reg.target_category, n->event.id.target_category,
-		 n->event.id.instance, entry->refcount);
-
-	if (entry->flags != n->event.flags) {
-		ssam_warn(ctrl,
-			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
-			  n->event.flags, entry->flags, n->event.reg.target_category,
-			  n->event.id.target_category, n->event.id.instance);
-	}
+	if (!(n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)) {
+		entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
+		if (WARN_ON(!entry)) {
+			/*
+			 * If this does not return an entry, there's a logic
+			 * error somewhere: The notifier block is registered,
+			 * but the event refcount entry is not there. Remove
+			 * the notifier block anyways.
+			 */
+			status = -ENOENT;
+			goto remove;
+		}
 
-	if (entry->refcount == 0) {
-		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id, n->event.flags);
-		kfree(entry);
+		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags);
 	}
 
 remove:
@@ -2287,6 +2385,105 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 }
 EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
 
+/**
+ * ssam_controller_event_enable() - Enable the specified event.
+ * @ctrl:  The controller to enable the event for.
+ * @reg:   The event registry to use for enabling the event.
+ * @id:    The event ID specifying the event to be enabled.
+ * @flags: The SAM event flags used for enabling the event.
+ *
+ * Increment the event reference count of the specified event. If the event has
+ * not been enabled previously, it will be enabled by this call.
+ *
+ * Note: In general, ssam_notifier_register() with a non-observer notifier
+ * should be preferred for enabling/disabling events, as this will guarantee
+ * proper ordering and event forwarding in case of errors during event
+ * enabling/disabling.
+ *
+ * Return: Returns zero on success, %-ENOSPC if the reference count for the
+ * specified event has reached its maximum, %-ENOMEM if the corresponding event
+ * entry could not be allocated. If this is the first time that this event has
+ * been enabled (i.e. the reference count was incremented from zero to one by
+ * this call), returns the status of the event-enable EC-command.
+ */
+int ssam_controller_event_enable(struct ssam_controller *ctrl,
+				 struct ssam_event_registry reg,
+				 struct ssam_event_id id, u8 flags)
+{
+	u16 rqid = ssh_tc_to_rqid(id.target_category);
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	struct ssam_nf_refcount_entry *entry;
+	int status;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	mutex_lock(&nf->lock);
+
+	entry = ssam_nf_refcount_inc(nf, reg, id);
+	if (IS_ERR(entry)) {
+		mutex_unlock(&nf->lock);
+		return PTR_ERR(entry);
+	}
+
+	status = ssam_nf_refcount_enable(ctrl, entry, flags);
+	if (status) {
+		ssam_nf_refcount_dec_free(nf, reg, id);
+		mutex_unlock(&nf->lock);
+		return status;
+	}
+
+	mutex_unlock(&nf->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ssam_controller_event_enable);
+
+/**
+ * ssam_controller_event_disable() - Disable the specified event.
+ * @ctrl:  The controller to disable the event for.
+ * @reg:   The event registry to use for disabling the event.
+ * @id:    The event ID specifying the event to be disabled.
+ * @flags: The flags used when enabling the event.
+ *
+ * Decrement the reference count of the specified event. If the reference count
+ * reaches zero, the event will be disabled.
+ *
+ * Note: In general, ssam_notifier_register()/ssam_notifier_unregister() with a
+ * non-observer notifier should be preferred for enabling/disabling events, as
+ * this will guarantee proper ordering and event forwarding in case of errors
+ * during event enabling/disabling.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given event has not been
+ * enabled on the controller. If the reference count of the event reaches zero
+ * during this call, returns the status of the event-disable EC-command.
+ */
+int ssam_controller_event_disable(struct ssam_controller *ctrl,
+				  struct ssam_event_registry reg,
+				  struct ssam_event_id id, u8 flags)
+{
+	u16 rqid = ssh_tc_to_rqid(id.target_category);
+	struct ssam_nf *nf = &ctrl->cplt.event.notif;
+	struct ssam_nf_refcount_entry *entry;
+	int status = 0;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	mutex_lock(&nf->lock);
+
+	entry = ssam_nf_refcount_dec(nf, reg, id);
+	if (!entry) {
+		mutex_unlock(&nf->lock);
+		return -ENOENT;
+	}
+
+	status = ssam_nf_refcount_disable_free(ctrl, entry, flags);
+
+	mutex_unlock(&nf->lock);
+	return status;
+}
+EXPORT_SYMBOL_GPL(ssam_controller_event_disable);
+
 /**
  * ssam_notifier_disable_registered() - Disable events for all registered
  * notifiers.
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index cf4bb48a850e..7965bdc669c5 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -838,4 +838,12 @@ int ssam_notifier_register(struct ssam_controller *ctrl,
 int ssam_notifier_unregister(struct ssam_controller *ctrl,
 			     struct ssam_event_notifier *n);
 
+int ssam_controller_event_enable(struct ssam_controller *ctrl,
+				 struct ssam_event_registry reg,
+				 struct ssam_event_id id, u8 flags);
+
+int ssam_controller_event_disable(struct ssam_controller *ctrl,
+				  struct ssam_event_registry reg,
+				  struct ssam_event_id id, u8 flags);
+
 #endif /* _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H */
-- 
2.31.1

