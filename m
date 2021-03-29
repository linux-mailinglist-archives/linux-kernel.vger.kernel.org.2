Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1784634D0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhC2NGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhC2NFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A38C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ce10so19348168ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0G6CjvHclW//LpDCf+tDPu2/tIHhMhu0kmCrwXfNY8I=;
        b=uvg6N/hKfUGIrUfcuso86PEbeHeOTY6ChMcpKOds7eGKdFGqRSen0T35kEm/iuDr2U
         opCBycm32G+Hta8IGG9y6ov9bR53kZeqsy36EW3Yfo3cUATSWPB82tbUYJh95oFz9Orl
         CDrwIqGUa7VBDObFF5S/H6xN7eKe1Ck4TAQNfuTWrK7R4Mdan9mz/k/1nRgZWEjZlGZd
         XQrqADR1GLNEq/YB9IY2d52AmiWgXvgLpljyRwHpSSpCW/2McOs6m7LFTpwggzy7A9Sw
         PALGUdmLs3a4wTZrVRB9A2r0/usyZEBKY4C4d6AUarxk/5mTnMlnYhisr43e9rHdUYyJ
         tdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G6CjvHclW//LpDCf+tDPu2/tIHhMhu0kmCrwXfNY8I=;
        b=DT99MZiCXM6peoDKJfLqoekUdQHVwYVCE2GH7Icysk3IfUeFSkhfXLc2aQZe04VmAl
         dz5CDj39iAfu0fLZRHFT2KKonh88JDmstCB2+jI8BCk9G6qiv9O7ukt3f1MftJr6DjaK
         Nf9smsnkKajzEkaBBXyEQMdTDjK98cc2M6ruf6J+PL+I3+Dc9dOx4gfiwMVFG+Z5sPlT
         PJkCGk1CerJE8jegudTW06pgOLJ4mmLlJXEET5Qrc/YrO8pTZ52SAroJqaw+tqEF+twe
         7WF00JGmEnMwYbXiQoiJQjMZI0CwHgZNSqDJtKwREz2+PiBAH5PaNZlf9Kom0N2G5Vvs
         /qow==
X-Gm-Message-State: AOAM533eRruq5YWz8vQAGdafYUOI8WKocPXUJomWJBNW5N0thT4ByCRT
        ZgdQV5bd9MwErhztqktUpzV/bNYKHgYBeg==
X-Google-Smtp-Source: ABdhPJxZhxpE++gZMx8hQGvdv0HqTsWVnssvmA8d3cLCDPlH2FzMdKwuiffBhQ85S8VZI8SLNh5p4A==
X-Received: by 2002:a17:906:8593:: with SMTP id v19mr28429539ejx.32.1617023149606;
        Mon, 29 Mar 2021 06:05:49 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:49 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 4/5] tracing: Unify the logic for function tracing options
Date:   Mon, 29 Mar 2021 16:05:32 +0300
Message-Id: <20210329130533.199507-5-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130533.199507-1-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the logic for dealing with the options for function tracing
has two different implementations. One is used when we set the flags
(in "static int func_set_flag()") and another used when we initialize
the tracer (in "static int function_trace_init()"). Those two
implementations are meant to do essentially the same thing and they
are both not very convenient for adding new options. In this patch
we add a helper function that provides a single implementation of
the logic for dealing with the options and we make it such that new
options can be easily added.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace_functions.c | 66 ++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f93723ca66bc..6c912eb0508a 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -27,13 +27,17 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *fregs);
+static ftrace_func_t select_trace_function(u32 flags_val);
 static struct tracer_flags func_flags;
 
 /* Our option */
 enum {
+	TRACE_FUNC_NO_OPTS	= 0x0, /* No flags set. */
 	TRACE_FUNC_OPT_STACK	= 0x1,
 };
 
+#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_STACK)
+
 int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 {
 	struct ftrace_ops *ops;
@@ -97,12 +101,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!tr->ops)
 		return -ENOMEM;
 
-	/* Currently only the global instance can do stack tracing */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL &&
-	    func_flags.val & TRACE_FUNC_OPT_STACK)
-		func = function_stack_trace_call;
-	else
-		func = function_trace_call;
+	func = select_trace_function(func_flags.val);
+	if (!func)
+		return -EINVAL;
 
 	ftrace_init_array_ops(tr, func);
 
@@ -205,6 +206,18 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	local_irq_restore(flags);
 }
 
+static ftrace_func_t select_trace_function(u32 flags_val)
+{
+	switch (flags_val & TRACE_FUNC_OPT_MASK) {
+	case TRACE_FUNC_NO_OPTS:
+		return function_trace_call;
+	case TRACE_FUNC_OPT_STACK:
+		return function_stack_trace_call;
+	default:
+		return NULL;
+	}
+}
+
 static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
@@ -213,7 +226,7 @@ static struct tracer_opt func_opts[] = {
 };
 
 static struct tracer_flags func_flags = {
-	.val = 0, /* By default: all flags disabled */
+	.val = TRACE_FUNC_NO_OPTS, /* By default: all flags disabled */
 	.opts = func_opts
 };
 
@@ -235,30 +248,31 @@ static struct tracer function_trace;
 static int
 func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-	switch (bit) {
-	case TRACE_FUNC_OPT_STACK:
-		/* do nothing if already set */
-		if (!!set == !!(func_flags.val & TRACE_FUNC_OPT_STACK))
-			break;
+	ftrace_func_t func;
+	u32 new_flags_val;
 
-		/* We can change this flag when not running. */
-		if (tr->current_trace != &function_trace)
-			break;
+	/* Do nothing if already set. */
+	if (!!set == !!(func_flags.val & bit))
+		return 0;
 
-		unregister_ftrace_function(tr->ops);
+	/* We can change this flag only when not running. */
+	if (tr->current_trace != &function_trace)
+		return 0;
 
-		if (set) {
-			tr->ops->func = function_stack_trace_call;
-			register_ftrace_function(tr->ops);
-		} else {
-			tr->ops->func = function_trace_call;
-			register_ftrace_function(tr->ops);
-		}
+	new_flags_val = (func_flags.val & ~(1UL << (bit - 1)));
+	new_flags_val |= (set << (bit - 1));
 
-		break;
-	default:
+	func = select_trace_function(new_flags_val);
+	if (!func)
 		return -EINVAL;
-	}
+
+	/* Check if there's anything to change. */
+	if (tr->ops->func == func)
+		return 0;
+
+	unregister_ftrace_function(tr->ops);
+	tr->ops->func = func;
+	register_ftrace_function(tr->ops);
 
 	return 0;
 }
-- 
2.25.1

