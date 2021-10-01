Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2C41EAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353576AbhJAKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353585AbhJAKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:34:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22614C06177B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i2ahBXbdGv+KTiVnHxIUE13HLAjZrkmTliChn1QvLfg=; b=OhAw54lvEzYAUtGkSqtCGnxiBy
        ulAsKrGRidtTway6feogMumZymL8Ba4l9OquqonQnCV7pH06dYJU7GW+0zEyXBqspwc5px/A80nA5
        x2APIjG1o5m/ILsfGpF/f/O7D2IJqvKjwB6R3SzW7sPnAzhk4OaD6z/wkMj37KKawdgqKs9MyVRDG
        cwMIThZqxMwZY5agKqLMcdtrEt+ncxx/EQ5g0DKE4kQH93hnXyEzy5YOG+1qSy7xFDBfv0Zh8NRVG
        yoaRm8HQJb9btggkG+49S6CcybUAO3DtQdXwJZB2lGtl55ErAY71aEcIjZ4OHWZ85FfogRRXOSOjt
        RPrwVfSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWFqK-0078hN-5t; Fri, 01 Oct 2021 10:32:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F294B30019C;
        Fri,  1 Oct 2021 12:32:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D315426717AF3; Fri,  1 Oct 2021 12:32:38 +0200 (CEST)
Date:   Fri, 1 Oct 2021 12:32:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <YVbjxjzVM5Dx4Mv4@hirez.programming.kicks-ass.net>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
 <20210930095348.tud6jdcenfkfzugz@linutronix.de>
 <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
 <20210930163858.orndmu5xfxue3zck@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930163858.orndmu5xfxue3zck@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:38:58PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-30 16:39:51 [+0200], Peter Zijlstra wrote:

> > Runing them all at the same prio still sucks (much like the single
> > net-RX thing), but at least a kthread is somewhat controllable.
> 
> I could replace the softirq processing with a per-CPU thread. This
> should work. But I would have to (still) delay the wake-up of the thread
> to the timer tick - or - we try the wake from the irqwork-self-IPI.

That, just wake the thread from the hardirq.

> I
> just don't know how many will arrive back-to-back. The RCU callback
> (rcu_preempt_deferred_qs_handler()) pops up a lot. By my naive guesswork
> I would say that the irqwork is not needed since preempt-enable
> somewhere should do needed scheduling. But then commit
>   0864f057b050b ("rcu: Use irq_work to get scheduler's attention in clean context")
> 
> claims it is not enough.

Oh gawd, that was something really nasty. I'm not sure that Changelog
captures all (at least I'm not sure I fully understand the problem again
reading it).

But basically that thing wants to reschedule, but suffers the same
problem as:

	preempt_disable();

	<TIF_NEED_RESCHED gets set>

	local_irq_disable();
	preempt_enable();
	  // cannea schedule because IRQs are disabled
	local_irq_enable();
	// lost a reschedule


Yes, that will _eventually_ reschedule, but violates the PREEMPT rules
because there is an unspecified amount of time until it does actually do
reschedule.

So what RCU does there is basically trigger a self-IPI, which guarantees
that we reschedule after IRQs are finally enabled, which then triggers a
resched.

I see no problem marking that particular irq_work as HARD tho, it really
doesn't do anything (other than tell RCU the GP is no longer blocked)
and triggering the return-from-interrupt path.

There's also a fun comment in perf_lock_task_context() that possibly
predates the above RCU fix.
