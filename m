Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD235E33B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhDMPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346269AbhDMPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:54:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:53:44 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 30so8271092qva.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srYayyHuSub6LMjzzqHK1ueWo2DijHI1fvIk8QXMnBQ=;
        b=XxNuvKZjwg89jgHmoe3PcR8ZtbctB4QufOSSxSSPUqD09AGN1YXymDn/9HaHL86ycO
         1e5tRvvq0+ijEBpdxSV8NAvPao5ZRPS8kw5qYMr0nf6tkAdpL3WQoS6O9oK2bVfUZoxT
         6xiY2KNvGX58eoPs2+j4TYZ3aqiEtUIZgN+78d04abzpq/RipbR8gEpn10ow+gwfYmuW
         Dxjh5UwyAR1o74RZ1OYIJRRykaxE9R3IAliO3rLx+HZYFEfBaEytx48Nl9Wu1wEH21Wc
         MUViEDFxkvcpFfvt4ZIjzvvSnrbavcjhf8dxbDcoDRF00jbCDwuFezOqKTSogScojzBd
         yxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=srYayyHuSub6LMjzzqHK1ueWo2DijHI1fvIk8QXMnBQ=;
        b=rGg8IA/Yzvfe015DBgatCzjESYaVl2VcQugmg8RQE7VNRn0ATu+0iil509tzZFtGpk
         JjATyxNhNy4OSf9ldVZKlNZHKOD/bRCuIfonBxeFGPwyguG6K3HEzbw3ji3dtPy+DIDF
         u76MxHyioVnBZKdAiFnxYKoEyosbWE439PlCs+zMg6dKlPdbSh7YExAbxphLRwC17BdK
         jn9EjQBTHOH4dcgjsYS64rcPPxp/XYfmBiAEGOMK7cz7SFTMTXfRK8ljP3jftjLa7RMl
         SHe65y8jAkUX9Qeqt/+Y5l5g+8dzlLOZ/KRr6Konrs0ej6gLG0gLExPIsPV3KclUwdjT
         bWZA==
X-Gm-Message-State: AOAM530LK0ybl7FA1mSaMQG8IEoZgOEzaOIofQgYzWUW1BhNipTjLpLL
        cz8aRbGyJtjfJ4GNXSSnD+o=
X-Google-Smtp-Source: ABdhPJzyQvLLBNsBmU60n4MDUX3Mr+Ban4zMRpM91/LuPGumRDluveUaI4t/4ojb+ynf3ZxkxlzV0Q==
X-Received: by 2002:a0c:db82:: with SMTP id m2mr23351938qvk.37.1618329224228;
        Tue, 13 Apr 2021 08:53:44 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id f202sm262298qke.9.2021.04.13.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:53:43 -0700 (PDT)
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
Subject: [PATCH v3 2/2] perf/core: Support reading group events with shared cgroups
Date:   Tue, 13 Apr 2021 08:53:37 -0700
Message-Id: <20210413155337.644993-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413155337.644993-1-namhyung@kernel.org>
References: <20210413155337.644993-1-namhyung@kernel.org>
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
index bcf51c0b7855..7440857d680e 100644
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
@@ -2512,6 +2619,7 @@ static void perf_group_detach(struct perf_event *event)
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
 				list_add_tail(&sibling->active_list, get_event_list(sibling));
 		}
+		perf_add_cgrp_node_list(sibling, event->ctx);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
@@ -2655,6 +2763,9 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_group_detach(event);
 	list_del_event(event, ctx);
 
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_del_cgrp_node_list(event, ctx);
+
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
 		ctx->rotate_necessary = 0;
@@ -3113,6 +3224,9 @@ static int  __perf_install_in_context(void *info)
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

