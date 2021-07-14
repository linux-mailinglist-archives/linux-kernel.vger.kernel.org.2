Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EA3C829A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGNKUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhGNKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:20:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYzErK5xgdi3EIPpdk93cUhrQezZZQYmIThqOr+rBF8=; b=GtqCq1XcqP+uBBfV/urgniX2+w
        E6TvvxoPdA0XLOQvrH2MhKiHUnTjXMBxrqCNgYn8wvGSDRrR/GsbgHFZAfW4iOZ66mtXt7L9n3ivj
        1rc2+ierma5X42jcxGUSnWbR9KLVDPrR5wsxY++HCQPH0eyH54SEDumPwUuyWzUXPicTpyQ92AegP
        uzyOZG6lcjIW8U3qqJZ/njg6yq2c39ewws3AZhBQMUesaEMQU6fdP5f4gDFGDvFSABtqAfGAaOcFQ
        2tGMov5ovWZL4diYFsHYIuQgUEL7R2BhQh0/Nu+C8PHqyYrk3jnDUw4oC2xnQyekSEe4yu6K6AZQ7
        Q0y0QV7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3bww-00HS91-Q7; Wed, 14 Jul 2021 10:17:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 162B198689D; Wed, 14 Jul 2021 12:17:06 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:17:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 05/50] sched: Provide schedule point for RT locks
Message-ID: <20210714101705.GB2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160746.410991567@linutronix.de>
 <20210714082820.GB2725@worktop.programming.kicks-ass.net>
 <87y2a9b4xw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2a9b4xw.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:49:47AM +0200, Thomas Gleixner wrote:
> On Wed, Jul 14 2021 at 10:28, Peter Zijlstra wrote:
> > On Tue, Jul 13, 2021 at 05:10:59PM +0200, Thomas Gleixner wrote:
> >
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -5832,8 +5832,14 @@ pick_next_task(struct rq *rq, struct tas
> >>   */
> >>  #define	SM_NONE			0x0
> >>  #define	SM_PREEMPT		0x1
> >> -#define SM_MASK_PREEMPT		UINT_MAX
> >> -#define SM_MASK_STATE		SM_MASK_PREEMPT
> >> +#ifndef CONFIG_PREEMPT_RT
> >> +# define SM_MASK_PREEMPT	UINT_MAX
> >> +# define SM_MASK_STATE		SM_MASK_PREEMPT
> >> +#else
> >> +# define SM_RTLOCK_WAIT		0x2
> >> +# define SM_MASK_PREEMPT	SM_PREEMPT
> >> +# define SM_MASK_STATE		(SM_PREEMPT | SM_RTLOCK_WAIT)
> >> +#endif
> >
> > Wouldn't something like this:
> >
> >
> > #ifndef CONFIG_PREEMPT_RT
> > # define SM_MASK_PREEMPT        (~0U)
> > #else
> > # define SM_RTLOCK_WAIT         0x2
> > # define SM_MASK_PREEMPT        SM_PREEMPT
> > #endif
> >
> > #define SM_MASK_STATE          (~0U)
> >
> > Be even better?
> 
> SM_MASK_STATE is overengineered. See combo patch 4+5 below

Yep, that should result in similar code as my proposal, thanks!

nit: you like UINT_MAX better than (~0U) ?
