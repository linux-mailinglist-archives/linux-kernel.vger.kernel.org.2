Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE942361202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhDOST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhDOSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v6so36985624ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SztlAV/YfnqmHBOW8ikxSmDuCs88c4ttCIhWcFSUdx4=;
        b=ewqd2Le55AjULE5Cay//an6366ux89LSE9CjAKQPr/zBY9nREZMrzH1NFON6fKWE72
         oDfINXj/1KMNPblOYpIOdwt2rATJE+9LEosZtqICuEuJTC7kZDDvCf/dcGf1qOzOznKn
         AHRpYSOWtR/O/GExOhPJ4uFApgpO1B29Oi5OAlmuhZ1uW+mZH1fEzq7Qf49TwqfcQGAO
         VJt2FVfSKnYto8XYj1Pjw/JFvHR//bqrQQ0ZPqj6fOBj5YbRcyY2CScNC/ATrvk7sh2N
         hkfnF+ET4ekZfJlFvLeto/+SBH1p4NMpyywJ9QdUpCsoYej07C+Y5B1Eh7gL0NcdMiWf
         JnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SztlAV/YfnqmHBOW8ikxSmDuCs88c4ttCIhWcFSUdx4=;
        b=gaRiWN2+hr0aZaW0+8uNxuH62nhMB2/snWbKYIUfwjD9AYIWAcsuy0QRBJPBaLgAkL
         M5X/7J7+OfbAYzFX8Mq3ZXIqM8UXH47PYIgxrFFWo+Ovw5jVHmACeuwR81XEdt1zSkW9
         FyEnahzmP89GAvo8k6tWtKWBV29j+pZU6yQZSo2yqizzA+5gJfR/3hvHfHDy1vcOspod
         mLinc3VQxUf54z5l229SHsz2pNarbHuAD1oJY6iyXHe0khLfb0ALRaVHn5Cp4I1k8Qkb
         pip6LT2K8RNhoYFHUEhRRT1Xki2r9vgcnvnUbcaRWGhhkDfSX0qMiwY63n4QEL+4qDJZ
         U6Yg==
X-Gm-Message-State: AOAM531dDMIhPZFh2ZjLfn0mbDZJ2WwpIEgImyVY2asKSCc0Yq4GQUES
        /5xtfDtcB4ozZAPVbNb9CJmVix+TQlA=
X-Google-Smtp-Source: ABdhPJwsZvY7JNNSqgpm7z/sIaUn2lJWJWmsrZVvthrBRC6ymq7ODDJlNDTOJObNDpJXMnFwwhBFkg==
X-Received: by 2002:a17:907:2485:: with SMTP id zg5mr4772183ejb.43.1618510756010;
        Thu, 15 Apr 2021 11:19:16 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:15 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 6/6] tracing: Add "func_no_repeats" option for function tracing
Date:   Thu, 15 Apr 2021 21:18:54 +0300
Message-Id: <20210415181854.147448-7-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
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
 kernel/trace/trace_functions.c | 162 ++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f37f73a9b1b8..1f0e63f5d1f9 100644
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
@@ -96,11 +108,27 @@ static ftrace_func_t select_trace_function(u32 flags_val)
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
+		tr->last_func_repeats = alloc_percpu(struct trace_func_repeats);
+		if (!tr->last_func_repeats)
+			return false;
+	}
+
+	return true;
+}
+
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -116,6 +144,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!func)
 		return -EINVAL;
 
+	if (!handle_func_repeats(tr, func_flags.val))
+		return -ENOMEM;
+
 	ftrace_init_array_ops(tr, func);
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
@@ -217,10 +248,132 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
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
 
@@ -267,6 +420,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
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

