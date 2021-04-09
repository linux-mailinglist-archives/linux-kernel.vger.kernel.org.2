Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDA35A556
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhDISLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhDISLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F7C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g17so7279361ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvlgCI1ISSNUmFdiWubc5OLQ7C7MPljgIz8NbwSgOJA=;
        b=ovRyfjD3/kdvZPEE+65LeB1xPyxaX/cgUqBNIPsAfCwhkpE/X9xkjFtsO5pYacCVmr
         tBNArlayrwOf0cde5vQ+ehoehM7b6nSa0LUmtEIvJonOyoI/iYlgXXD9Q+f/iec2+IWN
         RAKw/bJsMUBEITS20jaftXjbtrPVRz8aAEXKZOO9Qp60Rn7mPYaOp3oTxeen9Vgb3L8D
         ex7JjENquUelKg76WOQupO9eN9jYlMbk2Ond+X6yt6bsDRqPqQDTxNHhoHgQHK3ACzRN
         VyjJFWl9urRIPE+KBrBLdts4Wgde/3zy0By8jV1+1kw0ri0w73ZywHOl5H7jRmCjp/s4
         76YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvlgCI1ISSNUmFdiWubc5OLQ7C7MPljgIz8NbwSgOJA=;
        b=TX1ENcqrw52D4LNkFgv1wFSlfiuLMmYNNkMQHFa3ElPYk6uZGwWUZVs6IItZY0YJyR
         pA8LLvhXBk80baaGTslPK6W96NS2LSxsPMfLjXLswEZCAf/1jrPY4DUhtXTrMJ6IHIe0
         Z0qwG+e9mprCpaKsCc9m/Z+7pGhgw/Otw4+EcrD2oEuknbTBQhuzZ/MfrhGDZbDQJ2zq
         rkz1nAr5YH7dedXawzG+uQPMj2P/oLaUHJcQ0ZRUuytLUbAbfc1NyfsjRsebhmUKtKrv
         vUj3Xxq02ZMVf/XLwMVUJ0ZMfKyxafMjTzFp0V3v7PSDSCFgBrERIbwi9ELGFJ1k8zG/
         IEZQ==
X-Gm-Message-State: AOAM531VYytDlZg5xlBSAIfMMHlnFbuQb7PeK0WcxuHN9x9+siYpmG2n
        ND4ScXB3UothceB42FOxS5FXbVjCfVGmUQ==
X-Google-Smtp-Source: ABdhPJxAbHb60QCYpb+viBPHCETnJhfwREoxLSxaRn4KHKc1EkOoa9j+dANZDv+3cUrR/9i7KnVlgg==
X-Received: by 2002:a17:906:b191:: with SMTP id w17mr17471539ejy.200.1617991845937;
        Fri, 09 Apr 2021 11:10:45 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:45 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 1/5] tracing: Define new ftrace event "func_repeats"
Date:   Fri,  9 Apr 2021 21:10:27 +0300
Message-Id: <20210409181031.26772-2-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409181031.26772-1-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event aims to consolidate the function tracing record in the cases
when a single function is called number of times consecutively.

	while (cond)
		do_func();

This may happen in various scenarios (busy waiting for example).
The new ftrace event can be used to show repeated function events with
a single event and save space on the ring buffer

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace.h         |  3 +++
 kernel/trace/trace_entries.h | 22 +++++++++++++++++
 kernel/trace/trace_output.c  | 47 ++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5506424eae2a..6a5b4c2a0fa7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -45,6 +45,7 @@ enum trace_type {
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_RAW_DATA,
+	TRACE_FUNC_REPEATS,
 
 	__TRACE_LAST_TYPE,
 };
@@ -442,6 +443,8 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
+		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
+			  TRACE_FUNC_REPEATS);				\
 		__ftrace_bad_type();					\
 	} while (0)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4547ac59da61..fdd022a7aecf 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,25 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+#define FUNC_REPEATS_GET_DELTA_TS(entry)			\
+(((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)	\
+
+FTRACE_ENTRY(func_repeats, func_repeats_entry,
+
+	TRACE_FUNC_REPEATS,
+
+	F_STRUCT(
+		__field(	unsigned long,	ip		)
+		__field(	unsigned long,	parent_ip	)
+		__field(	u16	,	count		)
+		__field(	u16	,	top_delta_ts	)
+		__field(	u32	,	bottom_delta_ts	)
+	),
+
+	F_printk(" %ps <-%ps\t(repeats:%u  delta_ts: -%llu)",
+		 (void *)__entry->ip,
+		 (void *)__entry->parent_ip,
+		 __entry->count,
+		 FUNC_REPEATS_GET_DELTA_TS(__entry))
+);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0146e1fffdf..55b08e146afc 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1373,6 +1373,52 @@ static struct trace_event trace_raw_data_event = {
 	.funcs		= &trace_raw_data_funcs,
 };
 
+static enum print_line_t
+trace_func_repeats_raw(struct trace_iterator *iter, int flags,
+			 struct trace_event *event)
+{
+	struct func_repeats_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "%lu %lu %u %llu\n",
+			 field->ip,
+			 field->parent_ip,
+			 field->count,
+			 FUNC_REPEATS_GET_DELTA_TS(field));
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+trace_func_repeats_print(struct trace_iterator *iter, int flags,
+			 struct trace_event *event)
+{
+	struct func_repeats_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	seq_print_ip_sym(s, field->ip, flags);
+	trace_seq_puts(s, " <-");
+	seq_print_ip_sym(s, field->parent_ip, flags);
+	trace_seq_printf(s, " (repeats: %u, delta_ts: -%llu)\n",
+			 field->count,
+			 FUNC_REPEATS_GET_DELTA_TS(field));
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_func_repeats_funcs = {
+	.trace		= trace_func_repeats_print,
+	.raw		= trace_func_repeats_raw,
+};
+
+static struct trace_event trace_func_repeats_event = {
+	.type	 	= TRACE_FUNC_REPEATS,
+	.funcs		= &trace_func_repeats_funcs,
+};
 
 static struct trace_event *events[] __initdata = {
 	&trace_fn_event,
@@ -1385,6 +1431,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_print_event,
 	&trace_hwlat_event,
 	&trace_raw_data_event,
+	&trace_func_repeats_event,
 	NULL
 };
 
-- 
2.25.1

