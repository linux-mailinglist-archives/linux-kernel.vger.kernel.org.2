Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1230239AED2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFCXse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:48:34 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:45622 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:48:31 -0400
Received: by mail-wm1-f43.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so336949wmg.4;
        Thu, 03 Jun 2021 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3I7Z3IpYgIYjLPyzXTfQAdZXADJUQoUkUspFp+drRA=;
        b=KZAM+A4loSh0JysndBSJ72GE6LaT3HPWf12hXAiI0M+tTtsgeNxr98beIQq+ar9Enh
         7apS6MNEYcXZF+bM/Y1REo9SViEyYk4rQ/MSdd8HTBreQU/KhMJQjg5+KuICxYvN1/0w
         emXVj7HZtTtPANDfCKPkNq1DyE/2Ycsp26VOplNzKd0pa4c6pzs5HPaEg8ubbiuW5svA
         o0IBDJOZNio8LQa4T5KJr0IUvnTNtZfLZ1e802FS6ihnsP7gMoA54pnZaP+Mq1BBHB9z
         ax5fPZ9o3Pzxz3bFUy62zJ9i5erZaaYUJYNOgRCG6ACiZuEogNKUD55rb6CtAU07eZLZ
         LaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3I7Z3IpYgIYjLPyzXTfQAdZXADJUQoUkUspFp+drRA=;
        b=YvoER+EaPsSNLI/AOTVsl/jIUH89dI7SzNQjEzKyHshFZaiLrewosQz4LoloxvAb0r
         Gh+UpLErEcmx5v5xLbUWrOFayN0fnLQQTzvlSW2YVM2v2gx9ljh6VwBEpqLjOWiw5Xy3
         k3QaKZ3qWUxJ9bTVgIGws2CaX/psSr6ostBa4mFEajhqH4BW3tnJd+xXi03/1G5WRIcD
         VW/exXl/x06791LN7qbvm2K8551TpIj6nsO2juKoSZcYQBrpP+Y8zdA+ScJzAKKzEgR2
         k3tWPBpzoYbsG6L3+SU+v7nDHidWOAggpf64QXFbofuyTUSNBkBw9LX779ifnMo2g8Kn
         Uxww==
X-Gm-Message-State: AOAM53268frcWjXDHKZkiGcbql8HqXGtw0dFIEUlM3CpYRDaPSgcKw8V
        R1t7CPRSAGvks/FfVjOmNSY=
X-Google-Smtp-Source: ABdhPJxWcyDMjU0QBHePxiRnwZ8dA9Dk8sTLlahJBH1FRNAawoB75MV30rbGdwq9a97qBUXnyZM94w==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr789432wmj.128.1622763944805;
        Thu, 03 Jun 2021 16:45:44 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:44 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] platform/surface: aggregator: Allow enabling of events without notifiers
Date:   Fri,  4 Jun 2021 01:45:21 +0200
Message-Id: <20210603234526.2503590-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
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
 .../platform/surface/aggregator/controller.c  | 135 ++++++++++++++++++
 include/linux/surface_aggregator/controller.h |   8 ++
 2 files changed, 143 insertions(+)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index cd3a6b77f48d..49edddea417e 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2287,6 +2287,141 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
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
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_head *nf_head;
+	struct ssam_nf *nf;
+	int status;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	nf = &ctrl->cplt.event.notif;
+	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
+
+	mutex_lock(&nf->lock);
+
+	entry = ssam_nf_refcount_inc(nf, reg, id);
+	if (IS_ERR(entry)) {
+		mutex_unlock(&nf->lock);
+		return PTR_ERR(entry);
+	}
+
+	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 reg.target_category, id.target_category, id.instance,
+		 entry->refcount);
+
+	if (entry->refcount == 1) {
+		status = ssam_ssh_event_enable(ctrl, reg, id, flags);
+		if (status) {
+			kfree(ssam_nf_refcount_dec(nf, reg, id));
+			mutex_unlock(&nf->lock);
+			return status;
+		}
+
+		entry->flags = flags;
+
+	} else if (entry->flags != flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  flags, entry->flags, reg.target_category,
+			  id.target_category, id.instance);
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
+	struct ssam_nf_refcount_entry *entry;
+	struct ssam_nf_head *nf_head;
+	struct ssam_nf *nf;
+	int status = 0;
+
+	if (!ssh_rqid_is_event(rqid))
+		return -EINVAL;
+
+	nf = &ctrl->cplt.event.notif;
+	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
+
+	mutex_lock(&nf->lock);
+
+	entry = ssam_nf_refcount_dec(nf, reg, id);
+	if (WARN_ON(!entry)) {
+		mutex_unlock(&nf->lock);
+		return -ENOENT;
+	}
+
+	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 reg.target_category, id.target_category, id.instance,
+		 entry->refcount);
+
+	if (entry->flags != flags) {
+		ssam_warn(ctrl,
+			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
+			  flags, entry->flags, reg.target_category,
+			  id.target_category, id.instance);
+	}
+
+	if (entry->refcount == 0) {
+		status = ssam_ssh_event_disable(ctrl, reg, id, flags);
+		kfree(entry);
+	}
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

