Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48B35A55B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhDISLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbhDISLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892CC061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so10019039ejz.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9A8VXiUxAaTcXhW6u866dvf4G4xzVUGwqxkLkahQZM0=;
        b=aypDJiQMFBj0wiE04X9J6ApfIbPSy6IqMs9lWbrcIaBM/kTlpUYbhbUbImyWdZMZgC
         prznJcieJEzB0pCB7GrKcczwUeqwJhTQCq7W74I5YnicyTKeMsDdz8AD5lR9NyB7KmFt
         4vkv1dig/iyPBC1HBEVoOqxUXYYvEOc297mT9SpJMWuHCdU6yD+SihfX7cDauBYDLHws
         fVUSQrK9OMq8adt7hs7snBo5jfIIFzmz/eGMFDYE0c+KLSvPeP4LCZ/avdO/QfJi7ZCa
         Je2HHsFwN84pcEsY8YXPkpxv0Gp14081jQmrYwRuCHCDtXaL4YuEq2Q1AK8jobTmN37w
         m5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A8VXiUxAaTcXhW6u866dvf4G4xzVUGwqxkLkahQZM0=;
        b=YpNCdxbnNMIS+yoFir+CR/HUit67yMLeES2eH80XkkGxXBWtSg4PcVnPLTV2j7fcb0
         olRY4a+AU+WnNO9iCF33YBNDXwSIZhyQ9o7cf5rGPmQ6FmvECT83KSBKv6LN1adiISOe
         K5o0IEZGnXpb2YQI/1+f75p33n3iK1rPp5qA3W+XCGGeHJfWZEv9F27+seSSEK98UMwK
         TbBS+059Uz5OZsqX4D9ULXzhzsC1F+uso9ypRIo9h4xiWVkpGaYofg8i2YapyCB8tPqV
         lzx21UwE513epAYcvmdOYgq9qnU90E/cul1n+p1P5iOE5LpTW9qQzeT801IlBOtXjTut
         BBiQ==
X-Gm-Message-State: AOAM530I3ToX4Esf9nmmqazKnDg4g3ft1fWffGjItmbJ1BxuxV7pvXC/
        K37wudlLfR+4YIhQyTjUQIsEXeMJWWv1vw==
X-Google-Smtp-Source: ABdhPJwcLWJ2shEp2y9jEx6znCUZQ7RIeMFA/EEu8IFpcTAjQ8iuo6RFawb2FVoHs+0C8y3DAGw33Q==
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr3353191ejc.443.1617991850699;
        Fri, 09 Apr 2021 11:10:50 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:50 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 5/5] tracing: Add "func_no_repeats" option for function tracing
Date:   Fri,  9 Apr 2021 21:10:31 +0300
Message-Id: <20210409181031.26772-6-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409181031.26772-1-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
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
---
 kernel/trace/trace_functions.c | 161 ++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f37f73a9b1b8..9a3cbdbfd1f7 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -27,15 +27,27 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
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
@@ -96,11 +108,26 @@ static ftrace_func_t select_trace_function(u32 flags_val)
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
@@ -116,6 +143,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!func)
 		return -EINVAL;
 
+	if (!handle_func_repeats(tr, func_flags.val))
+		return -ENOMEM;
+
 	ftrace_init_array_ops(tr, func);
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
@@ -217,10 +247,132 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
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
 static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
+	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
 	{ } /* Always set a last empty entry */
 };
 
@@ -267,6 +419,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (tr->ops->func == func)
 		return 0;
 
+	if (!handle_func_repeats(tr, new_flags))
+		return -ENOMEM;
+
 	unregister_ftrace_function(tr->ops);
 	tr->ops->func = func;
 	register_ftrace_function(tr->ops);
-- 
2.25.1

