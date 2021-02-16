Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A131CE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBPQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:33:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52860C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQUTkY1oq1agJ9hryvP+SMygbLHZkeBCm/G5cT/kGuo=; b=L9UNtrPvySnvc93doqa6NJBqkt
        1Z/lUKkPgg5l3xrMVnFrH8OvSv6WmaAB5vjFrL+1qLrCSTbhvWwa5HkIpwoJdrULyM08G7xCUHvvX
        cVcNOAwEVZI+/iKz4IyeTFz+Krz2GgWvdGkJENhQnw4zaI77+BIYJUjAC19zozAYs5/OvzjfpWywR
        75BECY3zrlvxcAabJU2Zgr2bgAu4jWmPpTQDV9FWpLx73KCCnOsNVaTM24jn77vFo/bHX88AXRxIw
        0i2DoIXQ1T2CH0tbgEr8kSpnIb6+Z2tbBGOXrpq7cm+xgYco4VXzxTaTx/LiPrxg44zAo2Yln+oYe
        SpCP9PGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lC3HW-0003Ew-3U; Tue, 16 Feb 2021 16:32:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA06A3035D4;
        Tue, 16 Feb 2021 17:32:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5EFC2BC42A1E; Tue, 16 Feb 2021 17:32:52 +0100 (CET)
Date:   Tue, 16 Feb 2021 17:32:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, on_each_cpu() and similar functions do not exploit the
> potential of concurrency: the function is first executed remotely and
> only then it is executed locally. Functions such as TLB flush can take
> considerable time, so this provides an opportunity for performance
> optimization.
> 
> To do so, modify smp_call_function_many_cond(), to allows the callers to
> provide a function that should be executed (remotely/locally), and run
> them concurrently. Keep other smp_call_function_many() semantic as it is
> today for backward compatibility: the called function is not executed in
> this case locally.
> 
> smp_call_function_many_cond() does not use the optimized version for a
> single remote target that smp_call_function_single() implements. For
> synchronous function call, smp_call_function_single() keeps a
> call_single_data (which is used for synchronization) on the stack.
> Interestingly, it seems that not using this optimization provides
> greater performance improvements (greater speedup with a single remote
> target than with multiple ones). Presumably, holding data structures
> that are intended for synchronization on the stack can introduce
> overheads due to TLB misses and false-sharing when the stack is used for
> other purposes.
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Kernel-CI is giving me a regression that's most likely this patch:

  https://kernelci.org/test/case/id/602bdd621c979f83faaddcc6/

I'm not sure I can explain it yet. It did get me looking at
on_each_cpu() and it appears that wants to be converted too, something
like the below perhaps.


--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -848,14 +848,7 @@ void __init smp_init(void)
  */
 void on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
-	unsigned long flags;
-
-	preempt_disable();
-	smp_call_function(func, info, wait);
-	local_irq_save(flags);
-	func(info);
-	local_irq_restore(flags);
-	preempt_enable();
+	on_each_cpu_mask(cpu_online_mask, func, info, wait);
 }
 EXPORT_SYMBOL(on_each_cpu);
 
@@ -878,15 +871,7 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	unsigned int scf_flags;
-
-	scf_flags = SCF_RUN_LOCAL;
-	if (wait)
-		scf_flags |= SCF_WAIT;
-
-	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
-	preempt_enable();
+	on_each_cpu_cond_mask(NULL, func, info, wait, mask);
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
@@ -912,6 +897,13 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait)
+{
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
+}
+EXPORT_SYMBOL(on_each_cpu_cond);
+
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
@@ -926,13 +918,6 @@ void on_each_cpu_cond_mask(smp_cond_func
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait)
-{
-	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
-}
-EXPORT_SYMBOL(on_each_cpu_cond);
-
 static void do_nothing(void *unused)
 {
 }
~
