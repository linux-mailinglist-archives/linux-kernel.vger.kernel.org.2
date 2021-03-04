Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C889132CF3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhCDJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbhCDJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:03:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD8C061764
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b7so20231905edz.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+VumHbtB3xRlh6eg9Gbi5YIc1p7o3b2d1Im2ltjp/s=;
        b=aDkosZ9wqpwIYlhcyQZjiX9WntCe3U8w5keKT6OMmEjS+jg+opI9orRD2DfLibnOim
         nEyoHv9577EdGNL1Sjh9Z0ueC1snRTBaNerXE8n1CVnGljwEIHgw72dXgfkf1AyEnu9X
         IIhwtv1REoYR6tKnKNnpyQoHt3LifWhbk7UUgMDKLQ5HYiv4IOiaFS2aI4YQtRz26eLa
         eIrhlov8wlfCvTNnMy9lPuWt3wvkN5uWYrIvYANmx0BNgC6fFkSwg/uktu+aLPP011kW
         cmya4SOVxnmH07aO+rujw8gJbthLp5QnVtsIuePx2EaM/c4iRzV4Ck5yfLyKkwK4aj3b
         cz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+VumHbtB3xRlh6eg9Gbi5YIc1p7o3b2d1Im2ltjp/s=;
        b=stDcc9OgK2IEKm5IPnemwXojzLh/Wk5fRkLlAWLqzrxz+fw4I2fWLSYlkse5t81Ywd
         lNoUhPqjxGClXVtFyTLnseRcvV0Edeqe4z9MMroir0q3ftvWy3HwMoiFxITq3MiJ4i/e
         EuwHUcUDu0fv+j8Ln8Iyhkq9sVPtqzlLNN89XasEoqWccsBmCg3a+T0m1RbzZm7Qu3te
         ahCjLtT7ITB5YtiU9yDtwFAQSFqECU/QFR1Ea+tkHkasf07mPPPhVy1utQAAlFAx3ZWD
         mPa5Xg5uaeYmqPy9XijKCSwq3vuytse3SGWp/2Qz3D7qY4ZWLrYuBvBw5IIlyI2+lWs+
         Lu9Q==
X-Gm-Message-State: AOAM530QMQr6zyFVxfd6gVAOR8rxOE65DT1vXUwpaNmSVTD/EWhtXsd9
        TT9MFqC7WhJnKbWbJ4BzbfDfUB0CNuAjEg==
X-Google-Smtp-Source: ABdhPJwkmxOAMtjG9PcmS3bq391DCdFoVwCbMcJFOEYQCS6USYn9patQJ0TFPyd2x8QytpkChUmHFQ==
X-Received: by 2002:a05:6402:3083:: with SMTP id de3mr3171490edb.241.1614848543152;
        Thu, 04 Mar 2021 01:02:23 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:22 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 5/5] tracing: Add "func_no_repeats" option for function tracing
Date:   Thu,  4 Mar 2021 11:01:41 +0200
Message-Id: <20210304090141.207309-6-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304090141.207309-1-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the option is activated the function tracing record gets
consolidated in the cases when a single function is called number
of times consecutively. Instead of having an identical record for
each call of the function we will record only the first call
following by event showing the number of repeats.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>

fix last
---
 kernel/trace/trace_functions.c | 157 ++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 6c912eb0508a..fbf60ff93ffb 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -27,16 +27,28 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
+function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
+function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+				     struct ftrace_ops *op,
+				     struct ftrace_regs *fregs);
 static ftrace_func_t select_trace_function(u32 flags_val);
 static struct tracer_flags func_flags;
 
 /* Our option */
 enum {
-	TRACE_FUNC_NO_OPTS	= 0x0, /* No flags set. */
-	TRACE_FUNC_OPT_STACK	= 0x1,
+
+	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
+	TRACE_FUNC_OPT_STACK		= 0x1,
+	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
+
+	/* Update this to next highest bit. */
+	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
 };
 
-#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_STACK)
+#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
 
 int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 {
@@ -90,6 +102,17 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 	ftrace_free_ftrace_ops(tr);
 }
 
+static bool handle_func_repeats(struct trace_array *tr, u32 flags_val)
+{
+	if (!tr->last_func_repeats &&
+	    (flags_val & TRACE_FUNC_OPT_NO_REPEATS)) {
+		if (!tracer_alloc_func_repeats(tr))
+			return false;
+	}
+
+	return true;
+}
+
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -105,6 +128,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!func)
 		return -EINVAL;
 
+	if (!handle_func_repeats(tr, func_flags.val))
+		return -ENOMEM;
+
 	ftrace_init_array_ops(tr, func);
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
@@ -206,6 +232,123 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	local_irq_restore(flags);
 }
 
+static inline bool is_repeat(struct trace_func_repeats *last_info,
+			     unsigned long ip, unsigned long parent_ip)
+{
+	if (last_info->ip == ip &&
+	    last_info->parent_ip == parent_ip) {
+		last_info->count++;
+		return true;
+	}
+
+	return false;
+}
+
+static inline void process_repeats(struct trace_array *tr,
+				   unsigned long ip, unsigned long parent_ip,
+				   struct trace_func_repeats *last_info,
+				   unsigned int trace_ctx)
+{
+	if (last_info->count) {
+		trace_last_func_repeats(tr, last_info, trace_ctx);
+		last_info->count = 0;
+	}
+
+	last_info->ip = ip;
+	last_info->parent_ip = parent_ip;
+}
+
+static void
+function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op,
+			       struct ftrace_regs *fregs)
+{
+	struct trace_func_repeats *last_info;
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned int trace_ctx;
+	unsigned long flags;
+	int bit;
+	int cpu;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
+
+	cpu = smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	if (atomic_read(&data->disabled))
+		goto out;
+
+	/*
+	 * An interrupt may happen at any place here. But as far as I can see,
+	 * the only damage that this can cause is to mess up the repetition
+	 * counter without valuable data being lost.
+	 * TODO: think about a solution that is better than just hoping to be
+	 * lucky.
+	 */
+	last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
+	if (is_repeat(last_info, ip, parent_ip))
+		goto out;
+
+	local_save_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
+	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
+
+	trace_function(tr, ip, parent_ip, trace_ctx);
+
+out:
+	ftrace_test_recursion_unlock(bit);
+	preempt_enable_notrace();
+}
+
+static void
+function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+				     struct ftrace_ops *op,
+				     struct ftrace_regs *fregs)
+{
+	struct trace_func_repeats *last_info;
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned long flags;
+	long disabled;
+	int cpu;
+	unsigned int trace_ctx;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	/*
+	 * Need to use raw, since this must be called before the
+	 * recursive protection is performed.
+	 */
+	local_irq_save(flags);
+	cpu = raw_smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	disabled = atomic_inc_return(&data->disabled);
+
+	if (likely(disabled == 1)) {
+		last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
+		if (is_repeat(last_info, ip, parent_ip))
+			goto out;
+
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
+
+		trace_function(tr, ip, parent_ip, trace_ctx);
+		__trace_stack(tr, trace_ctx, STACK_SKIP);
+	}
+
+ out:
+	atomic_dec(&data->disabled);
+	local_irq_restore(flags);
+}
+
 static ftrace_func_t select_trace_function(u32 flags_val)
 {
 	switch (flags_val & TRACE_FUNC_OPT_MASK) {
@@ -213,6 +356,10 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 		return function_trace_call;
 	case TRACE_FUNC_OPT_STACK:
 		return function_stack_trace_call;
+	case TRACE_FUNC_OPT_NO_REPEATS:
+		return function_no_repeats_trace_call;
+	case TRACE_FUNC_OPT_STACK | TRACE_FUNC_OPT_NO_REPEATS:
+		return function_stack_no_repeats_trace_call;
 	default:
 		return NULL;
 	}
@@ -222,6 +369,7 @@ static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
+	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
 	{ } /* Always set a last empty entry */
 };
 
@@ -270,6 +418,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (tr->ops->func == func)
 		return 0;
 
+	if (!handle_func_repeats(tr, new_flags_val))
+		return -ENOMEM;
+
 	unregister_ftrace_function(tr->ops);
 	tr->ops->func = func;
 	register_ftrace_function(tr->ops);
-- 
2.25.1

