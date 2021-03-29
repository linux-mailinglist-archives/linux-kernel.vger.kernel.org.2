Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C096C34D0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2NF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhC2NFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF22C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u5so19346851ejn.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TViJ7SE5R90odfzRBnnvVIw5vnuAodunwkoluO1S3A=;
        b=S4JWnbe8m/f5kUz+20WWyFWoqliHZrzU2+SBIg71qcaX/yOSNsja8dYiDdXtHYPJNm
         EXLQ7ADyCYbmQ3iwyVd+lakWt1I8IZhIvJplvLReZodMYLBb9nkHdPnDkwAtNyhrGNT2
         P9wF9K3g9e+K0C0YZL6SAFo7I+lL+fE09z0MELKkvQYJHLo0ps0un3IdQraZhx74uOPb
         ywAKpaZYk7l2RLoKBi1bFVNOEPaLgWxzwLIw/mrcpvFBIDu+D5Ji8Tz0ZDEG/7V5iJI6
         7gaHyZVSP5uFVeQ4qAUV3Ia3/yoVwH8sbr49MHQ/wB4TE9p8eqZLJjvyQnnmEcIYZP0g
         C8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TViJ7SE5R90odfzRBnnvVIw5vnuAodunwkoluO1S3A=;
        b=j6nQrFkP8+1W4q4fhQO1Qw39VSeDIM+yPs0uMcGQ97oXpguiLCQY0vG4rz8D0hw11w
         6/0mnAuuYck7eoalrOSf3NtAxJklTxiaBzGEoFIgau2Y+T8ZIxKEmLK8K1/JVZGx6qW/
         qwW4xldFCRlU2p7xIYfEDSFhzWqzLXjMqvvXjuE83y/mbcesyHCxdnwZCpE5LtksApq9
         OpqXSiRMDtlOGRWYCmV/0YDO7PPUviyGc8NiMxrAUdR8yY4ivIo/zfFMTZWPTMqPUWb8
         msftBagpEeDnskHyGY9h8TcypQaI7myUGLeEiqake6Ww+V8+81sjsRfJyltj3CaKDiB+
         4CCA==
X-Gm-Message-State: AOAM531BRnpmpctokfnAy4fr7fOVTlV6h5Fbc1siFIwleG0qedoggx33
        vDtq5ioEIqa9AMjfAErXMH/6E0awmrsV3w==
X-Google-Smtp-Source: ABdhPJyWInp8VA3LCdQAqlwxx3eS8nVmWVte8zbr44J5CvhVCb7rJ6J886W3mbZoCWaZ3x0uDWthfg==
X-Received: by 2002:a17:906:f296:: with SMTP id gu22mr27894329ejb.20.1617023148821;
        Mon, 29 Mar 2021 06:05:48 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:48 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 3/5] tracing: Add method for recording "func_repeats" events
Date:   Mon, 29 Mar 2021 16:05:31 +0300
Message-Id: <20210329130533.199507-4-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130533.199507-1-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only provides the implementation of the method.
Later we will used it in a combination with a new option for
function tracing.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace.c | 26 ++++++++++++++++++++++++++
 kernel/trace/trace.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6fcc159c34a8..0d3d14112f50 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3116,6 +3116,32 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 
 #endif /* CONFIG_STACKTRACE */
 
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx)
+{
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct func_repeats_entry *entry;
+	struct ring_buffer_event *event;
+	u64 delta;
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_FUNC_REPEATS,
+					    sizeof(*entry), trace_ctx);
+	if (!event)
+		return;
+
+	delta = ring_buffer_event_time_stamp(buffer, event) -
+		last_info->ts_last_call;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip = last_info->ip;
+	entry->parent_ip = last_info->parent_ip;
+	entry->count = last_info->count;
+	FUNC_REPEATS_SET_DELTA_TS(entry, delta)
+
+	__buffer_unlock_commit(buffer, event);
+}
+
 /* created for use with alloc_percpu */
 struct trace_buffer_struct {
 	int nesting;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1cd4da7ba769..e1f34119c036 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -701,6 +701,10 @@ static inline void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 }
 #endif /* CONFIG_STACKTRACE */
 
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx);
+
 extern u64 ftrace_now(int cpu);
 
 extern void trace_find_cmdline(int pid, char comm[]);
-- 
2.25.1

