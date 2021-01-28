Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5273073D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhA1Ket (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhA1Kef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:34:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CEC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:33:51 -0800 (PST)
Date:   Thu, 28 Jan 2021 11:33:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611830029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5pHuoWSZjOLTdufeFYOmsBEk1PwfBG3TDEuL5/MCSg=;
        b=DQdAlutRICYa0pASrih2b2QglbUvMvbPUtcqRVuHb+3z49eYvUwK+IUjYQvQSSRq5S2sww
        fRCfXMartzoFpSE+7CHv4roCzZa1+2c/hDIR+EqJYiFbH92PjUwW+Hpp/uAKAiLWFp8MXh
        0tEgKC8at8jVzakXkfp3xG5irff6jyLXo7gMyXw/zmkx8MwjVHOxc02cf43XTKCE4ibkpr
        LKkmDeoSa+1jASBCAIXxw1RMKRhei42zDrfAsxAFblRp3HYtPmaNoEtFjX9NfrDGUs5dPL
        nSWoSmZC9YNeiE+UOMI9b8DXOXauDmnabM3HyECxH1R2EPYnL4ADAlndSC/suA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611830029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5pHuoWSZjOLTdufeFYOmsBEk1PwfBG3TDEuL5/MCSg=;
        b=lOISdF49BEEMjwucw0audgxzwavAXa7Fpylcd+UJ+aUZ5m9Bv8g40cHzoiSVd6oX7tZZU1
        wZOc2OsvhIDhTpCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] kernel/smp: Split call_single_queue into 3 queues
Message-ID: <20210128103348.rtbtffmvt7mwjohx@linutronix.de>
References: <20210128065506.618426-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128065506.618426-1-leobras.c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 03:55:06 [-0300], Leonardo Bras wrote:
> Currently, during flush_smp_call_function_queue():
> - All items are transversed once, for inverting.
> - The SYNC items are transversed twice.
> - The ASYNC & IRQ_WORK items are transversed tree times.
> - The TTWU items are transversed four times;.
> 
> Also, a lot of extra work is done to keep track and remove the items
> already processed in each step.
> 
> By using three queues, it's possible to avoid all this work, and
> all items in list are transversed only twice: once for inverting,
> and once for processing..
> 
> In exchange, this requires 2 extra llist_del_all() in the beginning
> of flush_smp_call_function_queue(), and some extra logic to decide
> the correct queue to add the desired csd.
> 
> This is not supposed to cause any change in the order the items are
> processed, but will change the order of printing (cpu offlining)
> to the order the items will be proceessed.
> 
> (The above transversed count ignores the cpu-offlining case, in
> which all items would be transversed again, in both cases.)

Numbers would be good. Having three queues increases the memory foot
print from one pointer to three but we still remain in one cache line.
One difference your patch makes is this hunk:

> +	if (smp_add_to_queue(cpu, node))
>  		send_call_function_single_ipi(cpu);

Previously only the first addition resulted in sending an IPI. With this
change you could send two IPIs, one for adding to two independent queues.

A quick smoke test ended up
          <idle>-0       [005] d..h1..   146.255996: flush_smp_call_function_queue: A1 S2 I0 T0 X3

with the patch at the bottom of the mail. This shows that in my
smoke test at least, the number of items in the individual list is low.

diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb0..3acce385b9f97 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -336,6 +336,11 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	struct llist_node *entry, *prev;
 	struct llist_head *head;
 	static bool warned;
+	int num_async = 0;
+	int num_sync = 0;
+	int num_irqw = 0;
+	int num_twu = 0;
+	int total = 0;
 
 	lockdep_assert_irqs_disabled();
 
@@ -343,6 +348,33 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	entry = llist_del_all(head);
 	entry = llist_reverse_order(entry);
 
+	llist_for_each_entry(csd, entry, node.llist) {
+		switch (CSD_TYPE(csd)) {
+			case CSD_TYPE_ASYNC:
+				num_async++;
+				break;
+			case CSD_TYPE_SYNC:
+				num_sync++;
+				break;
+
+			case CSD_TYPE_IRQ_WORK:
+				num_irqw++;
+				break;
+
+			case CSD_TYPE_TTWU:
+				num_twu++;
+				break;
+
+			default:
+				pr_warn("hmmmm\n");
+				break;
+		}
+	}
+	total = num_async + num_sync + num_irqw + num_twu;
+	if (total > 2)
+		trace_printk("A%d S%d I%d T%d X%d\n", num_async, num_sync, num_irqw, num_twu,
+			     total);
+
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
 		     !warned && !llist_empty(head))) {

Sebastian
