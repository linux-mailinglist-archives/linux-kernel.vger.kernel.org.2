Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE98A41302A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhIUIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhIUIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:30:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EEAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3pGj8C8pWUiQBpKJtGVzknsFdRDfba8Mc0AV+KNc0rs=; b=lj3fL5TA/SHrtjjBNRJLFNmF+r
        ApEI0NEfHknyBJuuqWRBOpq3IUCjYhRNG1iMmW4H9+KeW1m+2T7sIPbkGQY5y7Nz23k74qcp62ezp
        E4ILAOwxrDfVl0C88TY4pOY2hpzbWDUjNt1UqdViBmSMyCa0pTXr4SVD7jeAMKZTxWJs1+UK6TnX/
        3Xk0DGp8rheZZ1w7uFMACeKPdrqynr5hwUjL1A4svkkgPKpNa8u1Qpm1uj6GwgkcB0t29T9OSjUd9
        QCK/yhOpoevqRgJvBfe5PzdJQ1BKgc3mvum6RljFYCF3T30fHkgfYdC6Yl2G7VVWKFtJ/uO4E1zsG
        z1kNBDuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSb7l-003dSV-QU; Tue, 21 Sep 2021 08:27:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFA53300252;
        Tue, 21 Sep 2021 10:27:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C97CD213969B1; Tue, 21 Sep 2021 10:27:32 +0200 (CEST)
Date:   Tue, 21 Sep 2021 10:27:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/xen: remove unneeded preempt_disable() from
 xen_irq_enable()
Message-ID: <YUmXdEGhgEoukk80@hirez.programming.kicks-ass.net>
References: <20210921070226.32021-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921070226.32021-1-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:02:26AM +0200, Juergen Gross wrote:
> Disabling preemption in xen_irq_enable() is not needed. There is no
> risk of missing events due to preemption, as preemption can happen
> only in case an event is being received, which is just the opposite
> of missing an event.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/irq.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
> index dfa091d79c2e..ba9b14a97109 100644
> --- a/arch/x86/xen/irq.c
> +++ b/arch/x86/xen/irq.c
> @@ -57,24 +57,20 @@ asmlinkage __visible void xen_irq_enable(void)
>  {
>  	struct vcpu_info *vcpu;
>  
> -	/*
> -	 * We may be preempted as soon as vcpu->evtchn_upcall_mask is
> -	 * cleared, so disable preemption to ensure we check for
> -	 * events on the VCPU we are still running on.
> -	 */
> -	preempt_disable();
> -
>  	vcpu = this_cpu_read(xen_vcpu);
>  	vcpu->evtchn_upcall_mask = 0;
>  
> -	/* Doesn't matter if we get preempted here, because any
> -	   pending event will get dealt with anyway. */
> +	/*
> +	 * Now preemption could happen, but this is only possible if an event
> +	 * was handled, so missing an event due to preemption is not
> +	 * possible at all.
> +	 * The worst possible case is to be preempted and then check events
> +	 * pending on the old vcpu, but this is not problematic.
> +	 */
>  
>  	barrier(); /* unmask then check (avoid races) */
>  	if (unlikely(vcpu->evtchn_upcall_pending))
>  		xen_force_evtchn_callback();
> -
> -	preempt_enable();
>  }
>  PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
>  
> -- 
> 2.26.2
> 

So the reason I asked about this is:

  vmlinux.o: warning: objtool: xen_irq_disable()+0xa: call to preempt_count_add() leaves .noinstr.text section
  vmlinux.o: warning: objtool: xen_irq_enable()+0xb: call to preempt_count_add() leaves .noinstr.text section

as reported by sfr here:

  https://lkml.kernel.org/r/20210920113809.18b9b70c@canb.auug.org.au

(I'm still not entirely sure why I didn't see them in my build, or why
0day didn't either)

Anyway, I can 'fix' xen_irq_disable(), see below, but I'm worried about
that still having a hole vs the preempt model. Consider:

xen_irq_disable()
  preempt_disable();
  <IRQ>
    set_tif_need_resched()
  </IRQ no preemption because preempt_count!=0>
  this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1; // IRQs are actually disabled
  preempt_enable_no_resched(); // can't resched because IRQs are disabled 

  ...

xen_irq_enable()
  preempt_disable();
  vcpu->evtch_upcall_mask = 0; // IRQs are on
  preempt_enable() // catches the resched from above


Now your patch removes that preempt_enable() and we'll have a missing
preemption.

Trouble is, because this is noinstr, we can't do schedule().. catch-22

---
Subject: x86/xen: Fixup noinstr in xen_irq_{en,dis}able()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Sep 20 13:46:19 CEST 2021

  vmlinux.o: warning: objtool: xen_irq_disable()+0xa: call to preempt_count_add() leaves .noinstr.text section
  vmlinux.o: warning: objtool: xen_irq_enable()+0xb: call to preempt_count_add() leaves .noinstr.text section

XXX, trades it for:

  vmlinux.o: warning: objtool: xen_irq_enable()+0x5c: call to __SCT__preempt_schedule_notrace() leaves .noinstr.text section

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/irq.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -44,12 +44,18 @@ __PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl,
 
 asmlinkage __visible noinstr void xen_irq_disable(void)
 {
-	/* There's a one instruction preempt window here.  We need to
-	   make sure we're don't switch CPUs between getting the vcpu
-	   pointer and updating the mask. */
-	preempt_disable();
+	/*
+	 * There's a one instruction preempt window here.  We need to
+	 * make sure we're don't switch CPUs between getting the vcpu
+	 * pointer and updating the mask.
+	 */
+	preempt_disable_notrace();
 	this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1;
-	preempt_enable_no_resched();
+	/*
+	 * We have IRQs disabled at this point, rescheduling isn't going to
+	 * happen, so no point calling into the scheduler for it.
+	 */
+	preempt_enable_no_resched_notrace();
 }
 __PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable, ".noinstr.text");
 
@@ -62,7 +68,7 @@ asmlinkage __visible noinstr void xen_ir
 	 * cleared, so disable preemption to ensure we check for
 	 * events on the VCPU we are still running on.
 	 */
-	preempt_disable();
+	preempt_disable_notrace();
 
 	vcpu = this_cpu_read(xen_vcpu);
 	vcpu->evtchn_upcall_mask = 0;
@@ -74,7 +80,11 @@ asmlinkage __visible noinstr void xen_ir
 	if (unlikely(vcpu->evtchn_upcall_pending))
 		xen_force_evtchn_callback();
 
-	preempt_enable();
+	/*
+	 * XXX if we noinstr we shouldn't be calling schedule(), OTOH we also
+	 * cannot not schedule() as that would violate PREEMPT.
+	 */
+	preempt_enable_notrace();
 }
 __PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable, ".noinstr.text");
 
