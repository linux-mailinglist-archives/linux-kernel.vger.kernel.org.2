Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AA39F993
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhFHOvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhFHOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 57F89219DC;
        Tue,  8 Jun 2021 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623163789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sp3Oqg3CSzUFZ5tDEFNZBW1Vq6oX3/Pn7E8jqzxX9UI=;
        b=PzTvpfSzVcPwZ1kqPT9z4EEASMn1EkG04Wjzivshe7J764DsAHMTTMpvxgmyzr8oNpERlD
        itF82MK7UYSDBEENQJALbaT9v9v4G897FlffSlfACCvBGJDKK98ZDNrx+Z1LqXuaW36Uc2
        zaaXEtrHexEnVEcSQUAoPRTFbRftXfQ=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22546A3B8F;
        Tue,  8 Jun 2021 14:49:49 +0000 (UTC)
Date:   Tue, 8 Jun 2021 16:49:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v2 2/2] printk: fix cpu lock ordering
Message-ID: <YL+DjNG0uhg/uT+C@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
 <20210607200232.22211-3-john.ogness@linutronix.de>
 <YL9osWvgvdCo4JAK@alley>
 <875yyoigms.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yyoigms.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-08 16:18:51, John Ogness wrote:
> On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
> > The change makes perfect sense and the code looks correct.
> > But I am not sure about the description of the memory barriers.
> 
> OK.
> 
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index f94babb38493..8c870581cfb4 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -3560,10 +3560,29 @@ void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
> >>  
> >>  	cpu = smp_processor_id();
> >>  
> >> -	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
> >> +	/*
> >> +	 * Guarantee loads and stores from the previous lock owner are
> >> +	 * visible to this CPU once it is the lock owner. This pairs
> >> +	 * with cpu_unlock:B.
> >
> > These things are not easy to describe. It took me quite some time to
> > understand the above description. And think that it does not say
> > the full storry.
> >
> > IMHO, the lock should work the way that:
> >
> >    + The new owner see all writes done or seen by the previous owner(s).
> >    + The previous owner(s) never see writes done by the new owner.
> 
> You are right. I can describe those independently.
> 
> > Honestly, I am not sure if we could describe the barriers correctly
> > and effectively at the same time.
> 
> For v3 I would describe the 2 cases separately. For lock/acquire:
> 
> 	/*
> 	 * Guarantee loads and stores from this CPU when it is the lock owner
> 	 * are _not_ visible to the previous lock owner. This pairs with
> 	 * cpu_unlock:B.

Sounds better to me.

*
> 	 * Memory barrier involvement:
> 	 *
> 	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_unlock:A can never
> 	 * read from cpu_lock:B.
> 	 *
> 	 * Relies on:
> 	 *
> 	 * RELEASE from cpu_unlock:A to cpu_unlock:B
> 	 *    matching
> 	 * ACQUIRE from cpu_lock:A to cpu_lock:B
> 	 */

I can't check this so I believe you ;-)

> And for unlock/release:
> 
> 	/*
> 	 * Guarantee loads and stores from this CPU when it was the
> 	 * lock owner are visible to the next lock owner. This pairs
> 	 * with cpu_lock:A.

Sounds good.

*
> 	 * Memory barrier involvement:
> 	 *
> 	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_lock:B
> 	 * reads from cpu_unlock:A.
> 	 *
> 	 * Relies on:
> 	 *
> 	 * RELEASE from cpu_unlock:A to cpu_unlock:B
> 	 *    matching
> 	 * ACQUIRE from cpu_lock:A to cpu_lock:B
> 	 */

Same as for acquire ;-)

> I know you are not a fan of these drawn out memory barrier comments. But
> it really simplifies verification and translation to litmus
> tests. Without such comments, I would be lost looking back at
> printk_ringbuffer.c.
> 
> If the previous dump_stack() cpu lock implementation had such comments,
> we would know if the missing memory barriers were by design.

Sure. I am fine with the comments as long as there is also some human
readable description of the barrier intention.

Best Regards,
Petr
