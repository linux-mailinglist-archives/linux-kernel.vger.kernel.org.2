Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D450B32CF3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhCDJDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhCDJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:03:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF98C061760
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id do6so47918758ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH5i/Doj3qYar7VrbSA66dTewYhBnt7d/9ntJ1/mTDo=;
        b=o4/pU1awgdPYGCdfBJiJH6+HRw8aW0sL+sykk1LzvXD1WZYKENfVCQ/aABA1kSvkPI
         H9bJmhgzdT5DIURLap7Px7gC26GfVhQEznWht5GOEvITuFpdFy8tKMailc32OYnSvLhV
         OG4jF3xCKkRmjalS4+E6ipIoex68kU6uH8RrAW/H/nfUXLWTe/XjV+YsvfSxUnA4+Yul
         03QLKwcBRpkySkcHbotS9YYqtNLizdifuJSz+DFEbXWUaAsL0H9LEKrQtCts6Xu3wN+7
         nzplqZZf6LhwtxgCnt317m0sGRRpFQvAltc+J/56coFXXm4AqmLelWhYfiwGlF1tj+f3
         2xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH5i/Doj3qYar7VrbSA66dTewYhBnt7d/9ntJ1/mTDo=;
        b=bxoDtPGtlv5+PI29rCed8/zfkl7oF+wO6syfh+PjIN2iT88J1rnMZGaA9oT/sUXLLH
         V/ptIjEPm1rQtVNaPOahr7ComiKtjLIlrlsoSaNPBGSbI1lPqUdgwWOwEe12VVKrc5MV
         TdiHKMmoBCNu3EPJrFRcZieajmLHiduFxvBHkzlEOJFOH1bjfU0pwOhaDHsC6ItNx/kH
         shcStu+VV/2NjkULEDFRnDal89kD8oCzyD2as9jrs/Wz4a+VULRTlLb14I1Faytk4gzj
         zBY1jb0z1fewCzbDefsnWc47EoTjCbNQtnipbBkBi6CJHXamDNlmkNpcKwkEecZN09qG
         dtgA==
X-Gm-Message-State: AOAM533Kk8aBVSBYieLSY/NAgui/BnigMi1V+VpIeS3vRfXFeG0KYj3l
        O3XuRTQGcwrfWTy/LSJKrB9Sj6zMy9vB3g==
X-Google-Smtp-Source: ABdhPJzdqev3Of4xN2Do9C+6XxwlKVaQOlAM93/fLGEXTsVOcQM86v0FJfe0r58rDpj5S+Ahn31TrQ==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr3022835eju.511.1614848538242;
        Thu, 04 Mar 2021 01:02:18 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:17 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 1/5] tracing: Define new ftrace event "func_repeats"
Date:   Thu,  4 Mar 2021 11:01:37 +0200
Message-Id: <20210304090141.207309-2-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304090141.207309-1-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
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
 kernel/trace/trace_entries.h | 16 +++++++++++++
 kernel/trace/trace_output.c  | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a6446c03cfbc..2be4a56879de 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -45,6 +45,7 @@ enum trace_type {
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_RAW_DATA,
+	TRACE_FUNC_REPEATS,
 
 	__TRACE_LAST_TYPE,
 };
@@ -441,6 +442,8 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
+		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
+			  TRACE_FUNC_REPEATS);				\
 		__ftrace_bad_type();					\
 	} while (0)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4547ac59da61..8007f9b6417f 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,19 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+FTRACE_ENTRY(func_repeats, func_repeats_entry,
+
+	TRACE_FUNC_REPEATS,
+
+	F_STRUCT(
+		__field(	unsigned long,	ip	)
+		__field(	unsigned long,	pip	)
+		__field(	unsigned long,	count	)
+	),
+
+	F_printk(" %ps <-%ps\t(repeats:%lu)",
+		 (void *)__entry->ip,
+		 (void *)__entry->pip,
+		 __entry->count)
+);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 61255bad7e01..af6b066972e9 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1373,6 +1373,49 @@ static struct trace_event trace_raw_data_event = {
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
+	trace_seq_printf(s, "%lu %lu %li\n",
+			 field->pip,
+			 field->ip,
+			 field->count);
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
+	seq_print_ip_sym(s, field->pip, flags);
+	trace_seq_printf(s, " (repeats: %li)\n", field->count);
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
@@ -1385,6 +1428,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_print_event,
 	&trace_hwlat_event,
 	&trace_raw_data_event,
+	&trace_func_repeats_event,
 	NULL
 };
 
-- 
2.25.1

