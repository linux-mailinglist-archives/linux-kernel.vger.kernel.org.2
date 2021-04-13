Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848DD35D691
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 06:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhDMEmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 00:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhDMEl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 00:41:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3904C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i9so16697346qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLJEW+6AuBOUkShrJODeG39KMTrkWaelxhXJtPtu+iA=;
        b=WwMG4FmahRXolayDxo/JJ63A4S3D04Bjuo43IS/Rqs3dgj4rxpc5T/5qM7qqKYNbf/
         snSoEd1V6z/GNRs8gT7ZI0+cM8z/pOn4DQwOVsN7C12lDvuUtyKW7R+WThFtX7C0yQdb
         1yQYylE3+4+P2++0HD6BxaLW8Z6dkpqACmjAWTyxVt/IvD8U3E5MoI+Bo4tYJ0QgV3mv
         xLRPklwYcVEvl13bBD4wm7KuywA10+G0xVjazT30rPp8vYZBQelYuP60D6+lULoysuS8
         2tFP5/Qk1jjwGQkvAV9DfAAaZf464C/t9VCcMNKae0ppAa9/QbiKjOwdjQedcpJdT182
         Ww8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qLJEW+6AuBOUkShrJODeG39KMTrkWaelxhXJtPtu+iA=;
        b=j0+6DmlhTZioaGEeUOunZt1jQJDdMtGXgUMdDyrLNsl/kea3enSFenyWA7fz11J1or
         cnafKTroA/eP2I1alTyPVRodRkzJerdTECrrCKWiWTZC0MswzyxzwKr5OCZInjvKxvVK
         UZ9JfPmfUz4MpkMHwPAhHRIBZqZe1BsgOca3f1Hhosl6+NSdHUYBf+FEeqJ+IJg8+YPq
         JEawqQ/8pVkbGwpWaF1K20FH2CpdR0/mRYwXk+/MsjJCGr1oN6Of0ZQKN1xk+RNA51dg
         veMRNglEgkCum9oUdiyCl2uROUN4g0AocGvYqhq+TPx95WyUwBv/phbUAE3L7netgEE6
         R1HA==
X-Gm-Message-State: AOAM530FTIGk/P2Ef/4MRwkq1oR4CQBHecZiCazRoLPXuzETV0SjB78B
        YjwHcOkUpVOlXArEbkWt50FOYbZIy6jnwg==
X-Google-Smtp-Source: ABdhPJyJux7SyQTlJr6AWK8cPN5WDv7U7odifoeYVu+//NG6Y5fn4dOKCecs3635LP28ZZZ5im/Y1A==
X-Received: by 2002:ae9:e005:: with SMTP id m5mr29292264qkk.61.1618288900022;
        Mon, 12 Apr 2021 21:41:40 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id j6sm9543991qkl.84.2021.04.12.21.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 21:41:39 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 2/2] perf/core: Support reading group events with shared cgroups
Date:   Mon, 12 Apr 2021 21:41:33 -0700
Message-Id: <20210413044133.617921-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413044133.617921-1-namhyung@kernel.org>
References: <20210413044133.617921-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables reading event group's counter values together with a
PERF_EVENT_IOC_READ_CGROUP command like we do in the regular read().
Users should give a correct size of buffer to be read which includes
the total buffer size and the cgroup id.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 120 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c6b3848a61f..d483b4b42fe2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2232,13 +2232,24 @@ static void perf_add_cgrp_node_list(struct perf_event *event,
 {
 	struct list_head *cgrp_ctx_list = this_cpu_ptr(&cgroup_ctx_list);
 	struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
+	struct perf_event *sibling;
 	bool is_first;
 
 	lockdep_assert_irqs_disabled();
 	lockdep_assert_held(&ctx->lock);
 
+	/* only group leader can be added directly */
+	if (event->group_leader != event)
+		return;
+
+	if (!event_has_cgroup_node(event))
+		return;
+
 	is_first = list_empty(&ctx->cgrp_node_list);
+
 	list_add_tail(&event->cgrp_node_entry, &ctx->cgrp_node_list);
+	for_each_sibling_event(sibling, event)
+		list_add_tail(&sibling->cgrp_node_entry, &ctx->cgrp_node_list);
 
 	if (is_first)
 		list_add_tail(&ctx->cgrp_ctx_entry, cgrp_ctx_list);
@@ -2250,15 +2261,25 @@ static void perf_del_cgrp_node_list(struct perf_event *event,
 				    struct perf_event_context *ctx)
 {
 	struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
+	struct perf_event *sibling;
 
 	lockdep_assert_irqs_disabled();
 	lockdep_assert_held(&ctx->lock);
 
+	/* only group leader can be deleted directly */
+	if (event->group_leader != event)
+		return;
+
+	if (!event_has_cgroup_node(event))
+		return;
+
 	update_cgroup_node(event, cgrp->css.cgroup);
 	/* to refresh delta when it's enabled */
 	event->cgrp_node_count = 0;
 
 	list_del(&event->cgrp_node_entry);
+	for_each_sibling_event(sibling, event)
+		list_del(&sibling->cgrp_node_entry);
 
 	if (list_empty(&ctx->cgrp_node_list))
 		list_del(&ctx->cgrp_ctx_entry);
@@ -2333,7 +2354,7 @@ static int perf_event_attach_cgroup_node(struct perf_event *event, u64 nr_cgrps,
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
-	if (is_first && enabled)
+	if (is_first && enabled && event->group_leader == event)
 		event_function_call(event, perf_attach_cgroup_node, NULL);
 
 	return 0;
@@ -2370,8 +2391,8 @@ static void __perf_read_cgroup_node(struct perf_event *event)
 	}
 }
 
-static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
-				       u64 cgrp_id, char __user *buf)
+static int perf_event_read_cgrp_node_one(struct perf_event *event, u64 cgrp_id,
+					 char __user *buf)
 {
 	struct perf_cgroup_node *cgrp;
 	struct perf_event_context *ctx = event->ctx;
@@ -2406,6 +2427,92 @@ static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
 
 	return n * sizeof(u64);
 }
+
+static int perf_event_read_cgrp_node_sibling(struct perf_event *event,
+					     u64 read_format, u64 cgrp_id,
+					     u64 *values)
+{
+	struct perf_cgroup_node *cgrp;
+	int n = 0;
+
+	cgrp = find_cgroup_node(event, cgrp_id);
+	if (cgrp == NULL)
+		return (read_format & PERF_FORMAT_ID) ? 2 : 1;
+
+	values[n++] = cgrp->count;
+	if (read_format & PERF_FORMAT_ID)
+		values[n++] = primary_event_id(event);
+	return n;
+}
+
+static int perf_event_read_cgrp_node_group(struct perf_event *event, u64 cgrp_id,
+					   char __user *buf)
+{
+	struct perf_cgroup_node *cgrp;
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_event *sibling;
+	u64 read_format = event->attr.read_format;
+	unsigned long flags;
+	u64 *values;
+	int n = 1;
+	int ret;
+
+	values = kzalloc(event->read_size, GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	values[0] = 1 + event->nr_siblings;
+
+	/* update event count and times (possibly run on other cpu) */
+	(void)perf_event_read(event, true);
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+
+	cgrp = find_cgroup_node(event, cgrp_id);
+	if (cgrp == NULL) {
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+		kfree(values);
+		return -ENOENT;
+	}
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		values[n++] = cgrp->time_enabled;
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		values[n++] = cgrp->time_running;
+
+	values[n++] = cgrp->count;
+	if (read_format & PERF_FORMAT_ID)
+		values[n++] = primary_event_id(event);
+
+	for_each_sibling_event(sibling, event) {
+		n += perf_event_read_cgrp_node_sibling(sibling, read_format,
+						       cgrp_id, &values[n]);
+	}
+
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+	ret = copy_to_user(buf, values, n * sizeof(u64));
+	kfree(values);
+	if (ret)
+		return -EFAULT;
+
+	return n * sizeof(u64);
+}
+
+static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
+				       u64 cgrp_id, char __user *buf)
+{
+	u64 read_format = event->attr.read_format;
+
+	/* buf = bufsize + cgroup_id + read_buffer */
+	if (read_size < 2 * sizeof(u64) + event->read_size)
+		return -EINVAL;
+
+	if (read_format & PERF_FORMAT_GROUP)
+		return perf_event_read_cgrp_node_group(event, cgrp_id, buf);
+
+	return perf_event_read_cgrp_node_one(event, cgrp_id, buf);
+}
 #else  /* !CONFIG_CGROUP_PERF */
 static inline bool event_can_attach_cgroup(struct perf_event *event)
 {
@@ -2511,6 +2618,7 @@ static void perf_group_detach(struct perf_event *event)
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
 				list_add_tail(&sibling->active_list, get_event_list(sibling));
 		}
+		perf_add_cgrp_node_list(sibling, event->ctx);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
@@ -2654,6 +2762,9 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_group_detach(event);
 	list_del_event(event, ctx);
 
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_del_cgrp_node_list(event, ctx);
+
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
 		ctx->rotate_necessary = 0;
@@ -3112,6 +3223,9 @@ static int  __perf_install_in_context(void *info)
 		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
 					event->cgrp->css.cgroup);
 	}
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_add_cgrp_node_list(event, ctx);
 #endif
 
 	if (reprogram) {
-- 
2.31.1.295.g9ea45b61b8-goog

