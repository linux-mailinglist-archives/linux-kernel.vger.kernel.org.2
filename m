Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2F36D60F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhD1LEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhD1LEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:04:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zxNgnu2M7GkuCzxbYYc67l1UTIAJJ8OaQJP7t4GsgZs=; b=YyMWUI9LhynBY1idJkAJ9coqw7
        +YUlnKB8hm+9GVbxHZ1CS8lfc9i1WI6XYtY+dp+FNr6H9UskDXpIt+oamjie6Ai+ZVUS99fwFbQqQ
        Pp47Vjrn13G1RKR2dr7MtmhAnAQEW0S+hj9p+lF4E3blotJFxlTorVAxcIqpyjf8YnBipRG4sgwxi
        JPx2IRkxjBrbi8+iVT5kON/BBu01K0TX5sxjgsxEkAJ+jtPjYhmfuXV85UHFWDK7jMaYeir/NckpA
        2T3JqSIeibtMGHLAmoMhJl/Z1MFkirPDaeVBq7Nf+uy2Wnax+Ltj6SmtpR9/VwfZ7jNa/cBng0tZa
        F5SGZ0Ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbhye-008BnE-9N; Wed, 28 Apr 2021 11:03:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32152300091;
        Wed, 28 Apr 2021 13:03:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF16D2CCF1F67; Wed, 28 Apr 2021 13:03:29 +0200 (CEST)
Date:   Wed, 28 Apr 2021 13:03:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Josh Don <joshdon@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YIlBASJRMHlLBivL@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
 <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
 <CAERHkrttLutB1yUHS=i_syQZjqWmttm8PfQeH4WkcCLQvaR64A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrttLutB1yUHS=i_syQZjqWmttm8PfQeH4WkcCLQvaR64A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 06:35:36PM +0800, Aubrey Li wrote:
> On Wed, Apr 28, 2021 at 5:14 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Ah, indeed so.. rq_lockp() could do with an assertion, not sure how to
> > sanely do that. Anyway, double_rq_unlock() is simple enough to fix, we
> > can simply flip the unlock()s.
> >
> > ( I'm suffering a cold and am really quite slow atm )
> >
> > How's this then?
> >
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f732642e3e09..3a534c0c1c46 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
> >  static void __sched_core_enable(void)
> >  {
> >         static_branch_enable(&__sched_core_enabled);
> > +       /*
> > +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> > +        */
> > +       synchronize_sched();
> 
> synchronize_sched() seems no longer exist...

Bah.. Paul, why did that go away? I realize RCU merged in the sched and
bh flavours, but I still find it expressive to use sync_sched() vs
preempt_disable().

Anyway, just use sync_rcu().
