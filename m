Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217BA361200
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhDOSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhDOSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A4FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so38277442ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDazpAQzDXA/AXtm7b5UhjI5FNf1M0oDFlmbQAyoOe0=;
        b=K/hGz4dUnD+KEzg3QrXupvqyz9wdqOZX8Fm75wmfyveKWOWglutD2+8lIzUtGXOf5f
         ua/AqUPrECex/wNKMt6wEv0KIa/Iw82h4Bnt+RSGUd/BTmQbVnktCxdj468/aj5Y8JVv
         XKDuDpaAQaTkAqLPDzUT16qNBX2YPjhSk7fKmqFGOrWAyZaH7kfYjGXOdQV/TndEPDyr
         +cqGWoWEM8wSQWFMTYmgQG+RdINh8QhHQ9JBbiXLqoMaeg+tEBEQnilmO9wcMq64Jhbg
         2oNcAUtQg/7qTRv17WX5OTIi51XDQ5vang+YU0y6Fo6SWFxnetxCaMVP8p33GHBC7EAX
         v2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDazpAQzDXA/AXtm7b5UhjI5FNf1M0oDFlmbQAyoOe0=;
        b=GY7jf80kTT/97vlK8Kynu8wLt6odCF6J5Hy9IHfyM2ucnmWqq7X2jE3pBEK3Y0JPKi
         MxoL3ZxFuClRIktcx21o/Wi0HwW/7pMd4MF0u2OKdLkI0XLloxZ7Bf4/hTM7JlQ0KfxH
         Y3kCWVjsa+kW0aJ6bHL0yUcmG7I+lGGI39sZnMrhOqokDkT57z0IksPQ72ObWf0BLBb1
         iOUTEuu5YeOe0ENkZXhMHL+RE6rv7lAAdhqW8hvD0tjHxptO/Hqa9dCJeZnIkhYtUyjt
         97ygUlpxwc0tyuL4g1eJfOHpS9ZDlAg2+PUz+0eSeS9m40//TeXdkkzxPSKRGoejd76D
         FR9A==
X-Gm-Message-State: AOAM53213/UG9UQHKY0Dj1W8d2diUmLvwj9J3fVarcKleIGHHKdiz+8C
        N0cV7SVOQlfcf+hWjJHVKjoT4Tw9ilk=
X-Google-Smtp-Source: ABdhPJy//W88zI7CRWF4vqikcT7ObZ05MdXRPmNXcHzrN0eNNLLsfTPo+VhwgeUH8r7vzOaeLmIG/w==
X-Received: by 2002:a17:906:3e89:: with SMTP id a9mr4619403ejj.405.1618510755085;
        Thu, 15 Apr 2021 11:19:15 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:14 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 5/6] tracing: Unify the logic for function tracing options
Date:   Thu, 15 Apr 2021 21:18:53 +0300
Message-Id: <20210415181854.147448-6-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
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

