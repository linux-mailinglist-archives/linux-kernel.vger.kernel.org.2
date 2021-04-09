Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C835A55A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhDISLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhDISLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68615C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g5so3357048ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDazpAQzDXA/AXtm7b5UhjI5FNf1M0oDFlmbQAyoOe0=;
        b=eqDt/acNL8o+/9u9PCGBlGyOHYU66+erkotaSWYzwRFXffBrjodDMB3kPxDJNfMnSh
         6FnTDIdvJSNTna84dFJIHtEYmVuJ1ppfJgUqcdD7gKOtnl9sopca3fW6lAyDV1jCQLNc
         d8cRUrzhsWkdElW5o0M2bgqmRbtZ1BYeiBcbL21vBhJ5UMNA/rXpqPzOy5Qlw92QjhOn
         U+B08kDSugSF//srLMp+Y/jMnBd1LTciwAw2m7EtJRN28i+WUfR66Pa6brLBEIbptgK8
         I84qWE3ATp/T/H6taaXfPcg4Fd9L6pIEbQtRTSV33zfir2fhGZyYN3YzsnR04ZAR917O
         7P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDazpAQzDXA/AXtm7b5UhjI5FNf1M0oDFlmbQAyoOe0=;
        b=XRpy5SAap6hPmSKyJsIs5czmyJxJMTqWgeYGHhv4buJXURpze9tLUBKI63Ake8Z7gr
         +9h3uKoDh8bAEhqSGjua2wHZi+mT2P4BTwkEL36VRBEKXjoPswwQyojeqeT46u/QxFYa
         Iqqvt2rOOwWIg5hg+XERQQt9mxFuOi5icdNQBDOGZ4ltkT28lgmL+apMhjOzdeyCVKzP
         HSq9bunMvuTsFfKh2lUxCPCOzUae1fXWV0v0ub+v4s0PxvN4XML1vn3wTYS10Kf66PJY
         Tm4Gy5TZSYTM3+Tw2kG5AwZ7FOABxR5VJ5rkdDUrbYHghT7q3x8jaaG1Wwpe/qxO8j+O
         9WYA==
X-Gm-Message-State: AOAM532oW7dts/QBkUSCa2ljSijZtW3ieN5kRm2CvC67CzETtYs12GLY
        ipm+/ukMZIAmEWflrEBK/gUDqIn4PZgCmA==
X-Google-Smtp-Source: ABdhPJxemuIlUFi54WY1aYid5XQVvvXsXhCiAwOZ+rEeT6hFiFoyTC+aKxOrPCoUGCmVdDVQoXWajA==
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr17508713eje.472.1617991849887;
        Fri, 09 Apr 2021 11:10:49 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:49 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 4/5] tracing: Unify the logic for function tracing options
Date:   Fri,  9 Apr 2021 21:10:30 +0300
Message-Id: <20210409181031.26772-5-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409181031.26772-1-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
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
 kernel/trace/trace_functions.c | 65 ++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f93723ca66bc..f37f73a9b1b8 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -31,9 +31,12 @@ static struct tracer_flags func_flags;
 
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
@@ -86,6 +89,18 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 	ftrace_free_ftrace_ops(tr);
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
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -97,12 +112,9 @@ static int function_trace_init(struct trace_array *tr)
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
 
@@ -213,7 +225,7 @@ static struct tracer_opt func_opts[] = {
 };
 
 static struct tracer_flags func_flags = {
-	.val = 0, /* By default: all flags disabled */
+	.val = TRACE_FUNC_NO_OPTS, /* By default: all flags disabled */
 	.opts = func_opts
 };
 
@@ -235,30 +247,29 @@ static struct tracer function_trace;
 static int
 func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-	switch (bit) {
-	case TRACE_FUNC_OPT_STACK:
-		/* do nothing if already set */
-		if (!!set == !!(func_flags.val & TRACE_FUNC_OPT_STACK))
-			break;
-
-		/* We can change this flag when not running. */
-		if (tr->current_trace != &function_trace)
-			break;
+	ftrace_func_t func;
+	u32 new_flags;
 
-		unregister_ftrace_function(tr->ops);
+	/* Do nothing if already set. */
+	if (!!set == !!(func_flags.val & bit))
+		return 0;
 
-		if (set) {
-			tr->ops->func = function_stack_trace_call;
-			register_ftrace_function(tr->ops);
-		} else {
-			tr->ops->func = function_trace_call;
-			register_ftrace_function(tr->ops);
-		}
+	/* We can change this flag only when not running. */
+	if (tr->current_trace != &function_trace)
+		return 0;
 
-		break;
-	default:
+	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);
+	func = select_trace_function(new_flags);
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

