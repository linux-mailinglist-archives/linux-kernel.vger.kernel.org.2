Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D6132CF3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhCDJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhCDJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:03:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69335C061763
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dx17so20286042ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0G6CjvHclW//LpDCf+tDPu2/tIHhMhu0kmCrwXfNY8I=;
        b=jhljYura/F87CYx8r/d4TsLAUCEqaT3Xmj//8RiCcLDZFY76HltcM1w0LXiEPRK3oB
         Il3ICvs4Ss6PC7Vm4QwTWYegLa8oWx/zsfL5UqoUWVGlvQsuD5/lV5Ui8jRY6bSrqi3S
         RyMC+aXD6HOzl55d2B3a7ma1jSK90wzNdMF5sYNil+am51c/oNEG/8poK4KSukJTWsr1
         hQv7z+YHniUH0luB+qhpEQGGXdp/pMjq0AxADIXAwN+LvYt+W1Wk04B7jeRz1wfw/F6F
         uOIq+598UjNIfYFxPsERtUIXN4WwbVFVZTW2E8HpJI8mpbnlR2XEAPTkNoPJVn04Ezs/
         yz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G6CjvHclW//LpDCf+tDPu2/tIHhMhu0kmCrwXfNY8I=;
        b=I9rhH5TxQemgdPmJ8S39i8LCe97VZ18B9KFQCmSpiAQvrSkbQ13CnVEGdHws64PPKd
         xY/u62d3qVRBnX7kFNVL8iKrHOm3ZkbzoBSQOU1DSHeCCsIQDRZa/OcbEuyI/n5Lrymr
         KdmvKNi39lL1/2xAWw5xDfB5cZ09cFEsO0vtDDNdakd8O0f1qXx+7WvD9h1lwYToRcrL
         YY/34IaguzI4bhmKip3pzrvlJS3JQacSaFYF5k14FpWA47/8UkcG4SrT3FEfKr3WUeQ2
         +VZVLiJLY9iycWwYSXZ0VvZHxbQrOShFyQqo9BlD6uuA714Lh2XKlncbCsVxVOPQGn1P
         kDFw==
X-Gm-Message-State: AOAM531UPKWANSziy0ZgGOJ8+A5BpUAv7+16R740C7MFJiRKf8tGK27m
        Q1YdI1W9rCQ/LNHsqxTs9e790bv/3ykmUQ==
X-Google-Smtp-Source: ABdhPJx9GwQnvzlOa15RFKtih3Zo1gZo0KsvynU5q7SE9kP3RW2qht6j3bS+NlN8zMv+fUIhf+AN4g==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr3023159eju.511.1614848541941;
        Thu, 04 Mar 2021 01:02:21 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:21 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 4/5] tracing: Unify the logic for function tracing options
Date:   Thu,  4 Mar 2021 11:01:40 +0200
Message-Id: <20210304090141.207309-5-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304090141.207309-1-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
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

