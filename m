Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7141D3611F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhDOSTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhDOSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8CC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o20so2939267edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmecfFFFxrnk/yTNHYSDnpq8PX/J0+4kqxnhlh1oZFI=;
        b=QxzKKtjvTvdKQi2NrcGqTtAoY1Y2AnS2IfGSzBdwvkMAI2NAMF6EZ62OVXM6SmZFRH
         EbUrylkUnTvadK9RD48wey24hu0hNnj7Qe97GX3dJAGh8JoAn3DTvE6ngiNlFOHhVRcq
         A+dOqb4/1JtG9OwpzYuA1YjvcamVCSYJbw6y3A2IzgRMZA6tvVzdOzXTcJtM9ZJxz7Pa
         +Ed93NDcRKCuHtciJl7kNAQZWaiuEGL8gW6JbNc8EzV6A3ltDwx7pKiy2J+9a200Lzko
         yJ3gkYy3Iz+2bBKzmy5AjGAMGFDCl3H2zyngTYjGeBrZQyla+3OX4zBZPWME14kx9WUJ
         sJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmecfFFFxrnk/yTNHYSDnpq8PX/J0+4kqxnhlh1oZFI=;
        b=Iau8v03Z/340lCAVaTwt8omzQHSJgTbLu67DXUuZit/5OkC7qgrfujOmeiWd0r72Lm
         7vNOy9xSvDqLonMOV2nPc97zXWUvZvDBmQaMmLfSgNzrGHfvXg88P/v3LvQXBcQhZiK+
         YEl6hGoj4x03IYj7IYyyfRzrlRGXKmphwUqI+XJVIqjvBLNkcy/Jz5aoUSUQomwZ4piJ
         jRBFv4Sj0zhA7FWOfOcxIpsjbM2I3GnyHE4K5GWxN3wfpJVEWruzoBdRSSuIQdREZXk6
         Oa/Vc0MoYnuqF8Z0W4v64t2S5xfzePiNE1CT5Eu550ViGCEnefD1/4/LJpQBQNFStwDp
         H6Nw==
X-Gm-Message-State: AOAM532a9yWeoc1sY5HDfDjBZ24NPiVaah/yHV0s1QEcjnCwlfyfzMiy
        TzJtNbhdn52DSPew3ofPUJM2H6OTQ6E=
X-Google-Smtp-Source: ABdhPJzUFWvKSfpau3yBZTcykSRQ0OVAzTX42myBYFoIrnNN7H4r/Dsampj/o6kGRz5OkPmROTqiGw==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr5857595edu.350.1618510751770;
        Thu, 15 Apr 2021 11:19:11 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:11 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 2/6] tracing: Define new ftrace event "func_repeats"
Date:   Thu, 15 Apr 2021 21:18:50 +0300
Message-Id: <20210415181854.147448-3-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
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
 kernel/trace/trace_output.c  | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

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
index 4547ac59da61..251c819cf0c5 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,25 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+#define FUNC_REPEATS_GET_DELTA_TS(entry)				\
+	(((u64)(entry)->top_delta_ts << 32) | (entry)->bottom_delta_ts)	\
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
+	F_printk(" %ps <-%ps\t(repeats:%u  delta: -%llu)",
+		 (void *)__entry->ip,
+		 (void *)__entry->parent_ip,
+		 __entry->count,
+		 FUNC_REPEATS_GET_DELTA_TS(__entry))
+);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 333233d45596..3037f0c88f90 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1381,6 +1381,53 @@ static struct trace_event trace_raw_data_event = {
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
+	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
+	trace_print_time(s, iter,
+			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
+	trace_seq_puts(s, ")\n");
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
@@ -1393,6 +1440,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_print_event,
 	&trace_hwlat_event,
 	&trace_raw_data_event,
+	&trace_func_repeats_event,
 	NULL
 };
 
-- 
2.25.1

