Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5049234D0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC2NF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhC2NFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ce10so19347909ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pvqz1IZcEhNYW5KtfunT/YvDlLyq9XhrKgRvBcOU9wg=;
        b=fFQpboySNbMc6q8OQKVEmmKm8x3X/dITahQiPw6TfM1FNE5DWH+qzxxajE2K+zKClE
         TiIC6zLOMZKCjHwI2Q17ygmMtF0saMcl/ZSe/8nZ1Vb3/cR8pbkjPpW25lXht52JoBf+
         Vfyl/71gyOyU90Nm32Eq1+br54rkAZOgTcwhtc7urQDJF8mIOOLUDkkZ4+ACYr8KDgFQ
         YhRF1ob4GhnjwxKWdOTeviLE10lvVnAlBl8bTb7hjtAgJbHpPURmM/G3MQxMldx3AVaf
         E4bQ5rvynpRj6KeulWt/bxJDMqANrFYf6z2f/eUxhXqaGwakgq7qYd+KxTT81dHFwt6o
         6ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pvqz1IZcEhNYW5KtfunT/YvDlLyq9XhrKgRvBcOU9wg=;
        b=MaVwADbud18PRKllX6fyaYFjUF6RQPzmxWcQyhY3m04eBA19Is0LJOg/HHrEqmzvWE
         sdaYnaEgRmD4sTxTXiVe5HOp/1x3ckJNfWTgqxKtCI+HE9UyIcEPWoTVD5UHUxMfaeNZ
         Y77b+KPVdSuwmhPc7g2VDAkJEU9IOpgc7gJSQC29WPlGoGJdQAbySk4f6dXFNVc5OKS+
         190Qbd7snLdYpccoE5oj7x8Q2XcXmu0eGR7cCq3segX9J7RDqP/sEh7l04iJyYEUzqFA
         rgNti2rKVfa0aj3c+DyvuJvHkzy6Z6kq0l76nbZTalD8Pp/bsS5L5wMV8Hklv1HrC/UI
         tmuA==
X-Gm-Message-State: AOAM532Ur7UCUfj9J5ah5vWNqFDc/qa0MAKpxpngjCF/t8l+Unmdl43N
        D4Qb9bn18PkskAfFzG3a0Q3mjmyukBdeOA==
X-Google-Smtp-Source: ABdhPJygigs/zoP4Aa/aVKLW8JqVwEBOC8sJRWJ6wkcMNndAue1pl9VD8J5ckRvoDY9SBJf2TQ9xGQ==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr27872063ejc.2.1617023146924;
        Mon, 29 Mar 2021 06:05:46 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:46 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 1/5] tracing: Define new ftrace event "func_repeats"
Date:   Mon, 29 Mar 2021 16:05:29 +0300
Message-Id: <20210329130533.199507-2-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130533.199507-1-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
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
 kernel/trace/trace_entries.h | 39 ++++++++++++++++++++++++++++++
 kernel/trace/trace_output.c  | 47 ++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

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
index 4547ac59da61..6f98c3b4e4fa 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,42 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+#define FUNC_REPEATS_GET_DELTA_TS(entry)					\
+(((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)			\
+
+#define FUNC_REPEATS_SET_DELTA_TS(entry, delta)					\
+	do {									\
+		if (likely(!((u64)delta >> 32))) {				\
+			entry->bottom_delta_ts = delta;				\
+			entry->top_delta_ts = 0;				\
+		} else {							\
+			if (likely(!((u64)delta >> 48))) {			\
+				entry->bottom_delta_ts = delta & U32_MAX;	\
+				entry->top_delta_ts = (delta >> 32);		\
+			} else {						\
+				/* Timestamp overflow. Set to max. */		\
+				entry->bottom_delta_ts = U32_MAX;		\
+				entry->top_delta_ts = U16_MAX;			\
+			}							\
+		}								\
+	} while (0);								\
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

