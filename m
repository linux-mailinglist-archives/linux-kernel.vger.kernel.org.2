Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5350835A559
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhDISLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhDISLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D3C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so10055828ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rd+KQGSQMRoX9Wl6ZAjqbgNO+Rophku4GQjzMQGkis8=;
        b=M2ABGqp5DVLqVu6iX+hdGL4YIufFsCpOehR8QoZW1IDwf7eKPwe2oZ+WnGl1V9FGjp
         oSl3hEFQndIe1rYOouK8NadCekOgwyLL0+XxdLHpRRaKb1KM6e05+4reyoauN5qAPfgB
         Bdj4+/tZfqbVa5u2tTH7gaw4tT7JpsawJTcoferVU4+R0l0qbweOEZmaplINYfILtXqk
         /btiUj3VU+sMCBnN4Uo+mI7S4vX6qWb6ShFPnI1Nv9yyvFe1Nxg6BS3uLpXOsMRr+h1p
         Uz5q9EQ+Txn3PBWRenpOY1BHYm2jWvvXiE+c3FHForfZLpZ1WSKCudsZ6TNn9AY2vM2D
         xySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rd+KQGSQMRoX9Wl6ZAjqbgNO+Rophku4GQjzMQGkis8=;
        b=tApLOihhtcXoSKHkX+1amAyroS/e2W7BVRIaV8rIB44SV4OG5TkUwFpRqeJcxZCv3j
         Sqe8pfhtrlSJQ+FVh455eRr0KHwU/WhZi7EWDLOknWLM4gXDoS7xHYFtl6abcg06E7BB
         uToDFpk6PHqHAgeDUt4JF6LajLz1ZyxK8YK4jcn1KKGfuk+fz9UOlPD73OQY2nttonqn
         00gQmza92TNOUl9/an97Q5F8TNTg95N/fNfOLjokTXweEbs6YnOfFePzEQKa8AGrKct8
         3PZ5EFjPcqB+2xOyk0OpPtaUIalP3BfZ+BlB01vE8I09L4hZWK2MDLXB7rUoSLyTbre2
         tUJw==
X-Gm-Message-State: AOAM531Vb3Wv9at2xLjRJZt9z1fVdQDFkYF445sLq5eggpbsZHBq65PV
        MV346GNPNpGJzGksUxZJrfjRoUFSy62qJg==
X-Google-Smtp-Source: ABdhPJzqwt8P/kdtky2VB/F+kqcaNXiknVyVpqpXm51haiwERhpu4A4sAP60BAspYLPfkWML9YGmkg==
X-Received: by 2002:a17:907:3c08:: with SMTP id gh8mr3629412ejc.439.1617991847898;
        Fri, 09 Apr 2021 11:10:47 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:47 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 3/5] tracing: Add method for recording "func_repeats" events
Date:   Fri,  9 Apr 2021 21:10:29 +0300
Message-Id: <20210409181031.26772-4-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409181031.26772-1-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
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
 kernel/trace/trace.c         | 26 ++++++++++++++++++++++++++
 kernel/trace/trace.h         |  4 ++++
 kernel/trace/trace_entries.h |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 82833be07c1e..bbc57cf3bda4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3117,6 +3117,32 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 
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
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fdd022a7aecf..5e9dc56af4b1 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -342,6 +342,12 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 #define FUNC_REPEATS_GET_DELTA_TS(entry)			\
 (((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)	\
 
+#define FUNC_REPEATS_SET_DELTA_TS(entry, delta)			\
+	do {							\
+		entry->bottom_delta_ts = delta & U32_MAX;	\
+		entry->top_delta_ts = (delta >> 32);		\
+	} while (0);						\
+
 FTRACE_ENTRY(func_repeats, func_repeats_entry,
 
 	TRACE_FUNC_REPEATS,
-- 
2.25.1

