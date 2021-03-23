Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E866D3464F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhCWQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhCWQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:22:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:22:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v3so12235328pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2aKlt1oTKPEOchksKjyqfH80mOs+PY4O1scPbblavM=;
        b=oIFIO0Qu0ORBNUnO7gGllt0chY4a67lHZ8v4ywt7e5VEVgCERbXZaUk81fsxUPUwer
         UNXW0moYgPFSKoX8ujPcpEk8H0UidlC9aMD6kK4XO3ENZx/EB6NK07v0e5PdL7vQRrXA
         U4h97dmB5KumDV6BgiJ2GCYIoClizMWC9AS7NwPtAXLyoMWx/C5NoMFml1UxGlvConUV
         JsYU4wl5B+NygejDDj8lI+HxOO8PIBJsbflMtQiO6MKYCLUwuRCbKf3ePajbpW0k/X97
         wBcKGToZEpmBTtYYeXL1+LTG5O6QWwIvk/51UYBLIS/S0jQPONQZQDDM30QJv9YA4uoL
         0Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=K2aKlt1oTKPEOchksKjyqfH80mOs+PY4O1scPbblavM=;
        b=NUqgvEY0+3QGQuJJxaxGwgUgPEz68sVj4qC1yaB86GsPLOYVpUT2k/bgUbDMnodKAH
         bLhne7b3o608F3QM5/ZgoGPiB6+P76Mdg5NRx4NgOIAuFQtI7CQFeBaBrVjydOBc+gYr
         7imdAEwOuP9hza/VnSbaTaiNycReot5OKEg1n5Pj6oFHJ8lPSW9DrSXoR0jWC6I6kpuB
         PYoPgLXgJJtNAAkxEozoo8IDPik3ovyUvu1iCWhLP9d388ZU/8YJ/pNGVk3xUmEwVZAy
         MT+VGjlao6zbfsTL8DJ79mnCCIrPbY7U3v+qXdSDrzPWEeTZKLKgmOSaGz2p1EBtsHD8
         pI3w==
X-Gm-Message-State: AOAM530YzRSzcwfZxODWhO2CYUOy6G9g8iCYSYSRN2NoUPuknRGTsN/E
        W3XuitFxEFotALdiOiQjZwY=
X-Google-Smtp-Source: ABdhPJzgEaz1uzWDkxtO8e+YOjc/StdI2209bhOFnpYE03KsKA7HKpkPn3iAvAyPfuaEKRePnv34KQ==
X-Received: by 2002:a17:903:208a:b029:e6:20c3:2300 with SMTP id d10-20020a170903208ab02900e620c32300mr6518973plc.47.1616516530296;
        Tue, 23 Mar 2021 09:22:10 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id e6sm5615766pfc.159.2021.03.23.09.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:22:09 -0700 (PDT)
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
Subject: [PATCH 2/2] perf/core: Support reading group events with shared cgroups
Date:   Wed, 24 Mar 2021 01:21:56 +0900
Message-Id: <20210323162156.1340260-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210323162156.1340260-1-namhyung@kernel.org>
References: <20210323162156.1340260-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables reading event group's counter values together with a
PERF_EVENT_IOC_READ_CGROUP command like we do in the regular read().
Users should give a correct size of buffer to be read.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 119 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 38c26a23418a..3225177e54d5 100644
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
@@ -2406,6 +2427,91 @@ static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
 
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
+	if (read_size < event->read_size + 2 * sizeof(u64))
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
@@ -2511,6 +2617,7 @@ static void perf_group_detach(struct perf_event *event)
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
 				list_add_tail(&sibling->active_list, get_event_list(sibling));
 		}
+		perf_add_cgrp_node_list(sibling, event->ctx);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
@@ -2654,6 +2761,9 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_group_detach(event);
 	list_del_event(event, ctx);
 
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_del_cgrp_node_list(event, ctx);
+
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
 		ctx->rotate_necessary = 0;
@@ -3112,6 +3222,9 @@ static int  __perf_install_in_context(void *info)
 		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
 					event->cgrp->css.cgroup);
 	}
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_add_cgrp_node_list(event, ctx);
 #endif
 
 	if (reprogram) {
-- 
2.31.0.rc2.261.g7f71774620-goog

