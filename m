Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFD41DF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352160AbhI3Qkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352035AbhI3Qko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:40:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DEC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:39:01 -0700 (PDT)
Date:   Thu, 30 Sep 2021 18:38:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633019939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfyxy9FKVnpBOR385KJqgLwbAYCIUV3vt3a58Pj39Tg=;
        b=2tiT2n5+VhjPdsd1VJ2an7XV1XipKcASoazP3VLLQQthWIBQ6npiKHG11uONPdqwIAjVIm
        bdaNrxElEbpkBYZIdWzvyLKCEtVym0DKcsO3bkFk6oZTP7VMJYN+6FzRYiI2emf9porMwV
        1GIisOQ9TdykD7XJEBR3OYKbZoevAhdk8Dg5JIK4epb8qjSyfOp75AhpRAHLGvq7ImcC6r
        DKC8mWb9bvm0ZsZeBr3RxgWIonurnkgyFkWHPFb8JBWQ7F97xmFQO75zzhuqWORXp6LwUd
        pWS6OCLlzle+S+LO+l4DWKmF89qHwBUuvkf+OcgnVErdS9rYSH8vdUaIqRQnIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633019939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfyxy9FKVnpBOR385KJqgLwbAYCIUV3vt3a58Pj39Tg=;
        b=+lLIM6zBLf9mZ1jfFTo3d13W5oY7larBnVLUXwC98ADVHUCrXcPPr4z/JZM9tOFQlgpt0o
        YV9305wxNlLdZ/Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <20210930163858.orndmu5xfxue3zck@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
 <20210930095348.tud6jdcenfkfzugz@linutronix.de>
 <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-30 16:39:51 [+0200], Peter Zijlstra wrote:
> > > I think the problem was something Jolsa found a while ago, where perf
> > > defers to an irq_work (from NMI context) and that irq_work wants to
> > > deliver signals, which it can't on -RT, so the whole thing gets punted
> > > to softirq. With the end-result that if you self-profile RT tasks,
> > > things come apart or something.
> > 
> > For signals (at least on x86) we this ARCH_RT_DELAYS_SIGNAL_SEND thingy
> > where the signal is delayed until exit_to_user_mode_loop().
> 
> Yeah, I think that is what started much of the entry rework.. the signal
> rework is still pending.

posix timer were also guilty here :)

> > perf_pending_event() is the only non-HARD on RT (on the perf side). I
> > think that is due to perf_event_wakeup() where we have wake_up_all() and
> 
> Right, and that is exactly the problem, that needs to run at a higher
> prio than the task that needs it, but softirq makes that 'difficult'.
> 
> One possible 'solution' would be to, instead of softirq, run the thing
> as a kthread (worker or otherwise) such that userspace can at least set
> the priority and has a small chance of making it work.
>
> Runing them all at the same prio still sucks (much like the single
> net-RX thing), but at least a kthread is somewhat controllable.

I could replace the softirq processing with a per-CPU thread. This
should work. But I would have to (still) delay the wake-up of the thread
to the timer tick - or - we try the wake from the irqwork-self-IPI. I
just don't know how many will arrive back-to-back. The RCU callback
(rcu_preempt_deferred_qs_handler()) pops up a lot. By my naive guesswork
I would say that the irqwork is not needed since preempt-enable
somewhere should do needed scheduling. But then commit
  0864f057b050b ("rcu: Use irq_work to get scheduler's attention in clean context")

claims it is not enough.

> > read_lock_irqsave().
> 
> That one is really vexing, that really is just signal delivery to self
> but even when signal stuff is fixed, we're stuck behind that fasync
> rwlock :/

Yea. We are already in a RCU section and then this.

Sebastian
