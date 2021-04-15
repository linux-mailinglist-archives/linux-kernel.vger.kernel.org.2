Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1693611FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhDOSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhDOSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B822DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so38323220ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PqbqWfdg20x+owT9zu6vsX1RTHS/rsPqJzoP1vJhvk=;
        b=b7SxeApSb+oOMwN48cWg8N5oqiitHIhgQVQeFQMBCsdilHDLQAmJGKWdhwIhY4WvoL
         iXUZvgWojojIVLIJ0RYnXqf86leadLLRoAfwYyf8CIlSWRsSPS64jdNDMmJv2u6QF+fY
         iUd/CicCdQHxHgsHuYQpfdvHOtbd1QU9MD5x4lRHU0Qe8TTg5vVTQev/6jzpYzcmRySf
         QGzEeYk7ZG2dA2lb1JX6BGOrUQ2/ZqxGMVJebnoUdXTujZS6F4k3SptXyAFJ1/huFNlB
         0aIK/dgXJPISO0zaCAVb0pRCZEyA0tN221VCLqf6qgOC2tie5SzB+NnBt36X8I3VxrrJ
         2SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PqbqWfdg20x+owT9zu6vsX1RTHS/rsPqJzoP1vJhvk=;
        b=o9v2t1ngtZWsNhCVeW9jZEIJkZeB/QoFG8T9i3CICEibY9LfPaYXuboSUuaa5yY1aY
         uxb1rpulMANkfwDktHvp/ag8Rfga7AcZg2XWRynqIiDnPYTNQVp7e5AF8qGVFEh0dUPt
         sV5LFWXW6ol10akEHvrj5Zdf+W/SMmCJn9eDWMtV7b6LOidJ2x6My1vuQe1CqrJbdmb/
         t5ZmEMgQM3qwOIbtzRj48Mas3znX7sTA+xVkBPa0wBXtCD92ijYGLvJ4SSLXnEDiKQD0
         +Aa0hFis5iR5niEM8wYeHGT8eAOdGqlozTq4vhMZ73qunp3mqNSqTdxnknV1ZvGu7cym
         fDWg==
X-Gm-Message-State: AOAM531Dx0wOjdcS5dMitdiJT2yjng87dPAMxgTJ+bzIYs6tsSkOOW9M
        Mci6WaIUYgHKFHyqTHdqBReAKkGsYAE=
X-Google-Smtp-Source: ABdhPJyAcU/WLDMq5maxVY1fyjwgGHC5zvZFWwrltQOsc4HoR1wgEwlWr6oB0XsHQASsFafc0M8ZYQ==
X-Received: by 2002:a17:906:55d1:: with SMTP id z17mr4640589ejp.164.1618510754325;
        Thu, 15 Apr 2021 11:19:14 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:13 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 4/6] tracing: Add method for recording "func_repeats" events
Date:   Thu, 15 Apr 2021 21:18:52 +0300
Message-Id: <20210415181854.147448-5-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
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
 kernel/trace/trace.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 82833be07c1e..66a4ad93b5e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3117,6 +3117,40 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 
 #endif /* CONFIG_STACKTRACE */
 
+static inline void
+func_repeats_set_delta_ts(struct func_repeats_entry *entry,
+			  unsigned long long delta)
+{
+	entry->bottom_delta_ts = delta & U32_MAX;
+	entry->top_delta_ts = (delta >> 32);
+}
+
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
+	func_repeats_set_delta_ts(entry, delta);
+
+	__buffer_unlock_commit(buffer, event);
+}
+
 /* created for use with alloc_percpu */
 struct trace_buffer_struct {
 	int nesting;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a4f1b66049fd..cd80d046c7a5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -695,6 +695,10 @@ static inline void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
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

