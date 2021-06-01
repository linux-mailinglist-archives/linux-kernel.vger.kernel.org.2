Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA15F39742E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFANaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:30:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:30:51 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 673671FD2A;
        Tue,  1 Jun 2021 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622554149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3//ZXYFGS2gJNMYmcQjP54lBt+RMFWlb/7oFp0wJebA=;
        b=Kg0jq4A68Hcom19fII2Vqcbmduk/F1VpNg0+9ql1kQBUKRqSKQN3c0Kl0xj9FgtT4UdbPm
        +L6p/3IWyuxZ09vEdzD1yxS3Hx/gScpcr3EobxOT0g6TEMdalE5jObyxcQVgvd/nmHNpz2
        9+dUR0BwVZjeOQNG70ZfvMFWLbR01KA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE242A3BB3;
        Tue,  1 Jun 2021 13:29:08 +0000 (UTC)
Date:   Tue, 1 Jun 2021 15:29:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YLY2JEbEMPYyvdww@alley>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
 <20210531162051.2325-2-john.ogness@linutronix.de>
 <YLWhlZy8jQR3zpun@google.com>
 <87y2bu2hqp.fsf@jogness.linutronix.de>
 <87v96y2fyz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96y2fyz.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-01 09:37:08, John Ogness wrote:
> On 2021-06-01, John Ogness <john.ogness@linutronix.de> wrote:
> >> Is there any particular reason this does
> >>
> >> 	preempt_disable();
> >> 	cpu = smp_processor_id();
> >> 	local_irq_safe();
> >>
> >> instead of
> >>
> >> 	local_irq_safe();
> >> 	cpu = raw_smp_processor_id();
> >>
> >> ?
> >
> > If the lock is owned by another CPU, there is no need to disable
> > interrupts for this CPU. (The local_irq_save() is conditional.)
> 
> The cpu lock implementation from dump_stack() also keeps preemption
> continually enabled while spinning.

I wonder if this might reduce some noise on the CPU cache lines
when disable_preemption()/enable_preemption() actually does something.
But the problem might be only with cmpxchg() in a busy loop.
Peter Zijlstra might know more.

> I used the cpu lock implementation from PREEMPT_RT. But for my v2
> I will adopt the same ordering from dump_stack(), as you are suggesting.

Anyway, please document any changes in the ordering if there are any.
The current commit message sounds like a code move without any
functional changes.

Best Regards,
Petr
