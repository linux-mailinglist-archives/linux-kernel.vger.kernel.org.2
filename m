Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E028B41DC94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351087AbhI3Onu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348952AbhI3Ons (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:43:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A0C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Egjnz23MRRc2Eq0mP2OOoBetktHSOuEeQVcHOJ6ZEGs=; b=iNcGtuVmRObx7CF3YbzfDfcTJR
        rHaSvq6E5aw1YkFyOfnf0w4SFB/94FG92xmPTO6NuQALbU4SYTl7bxLfqw8hGN412FuEAJYZOqAin
        bjdwgzde7TKi1l7NurDyFFja4U7JyMfj2k7jkYUPzinmPpOdxLKDoE3rqgReKuOglKZ+UJJZC8/DB
        TQGpMCJtj8VtwPADQMsnH/viwrddci7yDh9DS4Yn3MrzUq5zyEzbHvn7qWF+NvWDG4NsuZr8aIT9i
        cVnhhj5DUnzfkeAnDdfk78NJCfgKbTewfcTdPZe00XjxJL4t1scw1y184wgt0ngRvE56cW4PNuMGq
        eOdHeLyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVxE0-00CxUP-U4; Thu, 30 Sep 2021 14:40:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE7AD30023F;
        Thu, 30 Sep 2021 16:39:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2E62212EE533; Thu, 30 Sep 2021 16:39:51 +0200 (CEST)
Date:   Thu, 30 Sep 2021 16:39:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
 <20210930095348.tud6jdcenfkfzugz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930095348.tud6jdcenfkfzugz@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:53:48AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-30 11:07:18 [+0200], Peter Zijlstra wrote:
> > 
> > IIRC we have existing problems in -RT due to this irq_work softirq muck.
> 
> We have existing problems in -RT due irq_work being used without knowing
> the consequences.

Obviously :-)

> > I think the problem was something Jolsa found a while ago, where perf
> > defers to an irq_work (from NMI context) and that irq_work wants to
> > deliver signals, which it can't on -RT, so the whole thing gets punted
> > to softirq. With the end-result that if you self-profile RT tasks,
> > things come apart or something.
> 
> For signals (at least on x86) we this ARCH_RT_DELAYS_SIGNAL_SEND thingy
> where the signal is delayed until exit_to_user_mode_loop().

Yeah, I think that is what started much of the entry rework.. the signal
rework is still pending.

> perf_pending_event() is the only non-HARD on RT (on the perf side). I
> think that is due to perf_event_wakeup() where we have wake_up_all() and

Right, and that is exactly the problem, that needs to run at a higher
prio than the task that needs it, but softirq makes that 'difficult'.

One possible 'solution' would be to, instead of softirq, run the thing
as a kthread (worker or otherwise) such that userspace can at least set
the priority and has a small chance of making it work.

Runing them all at the same prio still sucks (much like the single
net-RX thing), but at least a kthread is somewhat controllable.

> read_lock_irqsave().

That one is really vexing, that really is just signal delivery to self
but even when signal stuff is fixed, we're stuck behind that fasync
rwlock :/
