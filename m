Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD97334D0EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhC2NGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhC2NFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39373C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so19357085ejv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfmWstfgWnCbHg9rnkjek9riYg3fM66wKs6w8SPlE0w=;
        b=l0flWtEPyaNMs2+bA5mjia5N67GOVC71pNOdwbh0m6r837ccqGc4byP1fFS6NDhCFd
         Cq9pYFO8yBmY/B0ZR6mvWxfX1RyxM8PXq/tI4SNY55EqZW6cMHBY4Znlk72E6YyRt4k2
         Q7OCYsDdYk3PoRHFAgwqcmfwaPPqNxkJ1Tv/cd6GeD8kdIIGu28kRJ5GPCsqj4SczEYk
         kRUMterWcvRx017EYBD/CTAT0ZT86mFFSK1Xb5KBsJPYkZjv7edCLSbUrUbKjKPe6lNc
         dC/T7AwKhxeJO92VDwgU5huFlheyyZN0g2F4ZxE6TAzJ4rcZAhXP8Y1bYQI5c7fNCc6y
         OnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfmWstfgWnCbHg9rnkjek9riYg3fM66wKs6w8SPlE0w=;
        b=Lci/TdK+qDKCQBfoiVQBEyvKjRBPuYT9ftHVQdLv3A0QC7zIdDC7I3MEc0zz/SWhrB
         WlxfPQE5eHKVs8K7/hif96bT5HDWOw+Syk9vwOBte882jS/5SS2mc+oyx0e8WT4apLnt
         lGhLvTIEcDNqu318mi5vs/SjEu409/qS64ZIuhbda4IlCLaP4Eu0nBg98EnIOE5T+HIs
         NgM83WeR6ZYphKQ+z4nd+7SP+3YR74Tnd6UiXC6oIsINugVLKQ1NzziRz8PjJX/VYqgJ
         gere5mUO37fwXcydo5QVhuDqLFMNVOBhAPIcF2Hyd03kRLNZ2hr91+aNmc3t6+bFmX+b
         M+2A==
X-Gm-Message-State: AOAM530Axv15xRCLtGPrzDJzL2aaIkybarjPhIk3HToTBrJ0Srwa2zXt
        6YCQ4JL5plvaHCXCGJyueU6NiSc7j2HB3w==
X-Google-Smtp-Source: ABdhPJxUStgOO/r7L6nhd5/NKdeg5ZUmn7iFVviYZ1BMGBZ8xjWQb4k4F6qnHHBhu8EgZnQp/g7qeQ==
X-Received: by 2002:a17:906:3b41:: with SMTP id h1mr27493506ejf.506.1617023150510;
        Mon, 29 Mar 2021 06:05:50 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:50 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 5/5] tracing: Add "func_no_repeats" option for function tracing
Date:   Mon, 29 Mar 2021 16:05:33 +0300
Message-Id: <20210329130533.199507-6-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130533.199507-1-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
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
 kernel/trace/trace_functions.c | 161 ++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 6c912eb0508a..72d2e07dc103 100644
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
@@ -206,6 +232,127 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	local_irq_restore(flags);
 }
 
+static inline bool is_repeat_check(struct trace_array *tr,
+				   struct trace_func_repeats *last_info,
+				   unsigned long ip, unsigned long parent_ip)
+{
+	if (last_info->ip == ip &&
+	    last_info->parent_ip == parent_ip &&
+	    last_info->count < U16_MAX) {
+		last_info->ts_last_call =
+			ring_buffer_time_stamp(tr->array_buffer.buffer);
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
+	if (is_repeat_check(tr, last_info, ip, parent_ip))
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
+		if (is_repeat_check(tr, last_info, ip, parent_ip))
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
@@ -213,6 +360,10 @@ static ftrace_func_t select_trace_function(u32 flags_val)
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
@@ -222,6 +373,7 @@ static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
+	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
 	{ } /* Always set a last empty entry */
 };
 
@@ -270,6 +422,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
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

