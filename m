Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87D35578A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbhDFPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDFPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:17:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zOaHfWbHE4n6flY58/e1qK+btntIvQwNIRvz8PcW0J8=; b=if48cUWkt9VrVzgqJSFkLyvpCZ
        Wrk/8moPwde1VliEgOVARKthYb6HaLlPtSYuScdVSg2wCejSyc2x8kpGyixq5O1Io+tbGdO4jyKIq
        Y7Sel0NAr/G8F8aYDVkyDaKK039WeocFTfSRIkRV0K59wOIEGfb1geCjYXvuOjRcOSelVqO1uvGRa
        VSUioSjXFS1s45kgkQb7WrejcEOQ7/oeFfqaqY9FgXrRDgY4vBH1gw6lVYNbY3xeli4C/lRlIUY7E
        pa0F7XdLfeQlO9uWg1BszGQ9MU0iwWP89Gr5BNGW9B9vlmyqc6G3yK2onVbet31zcj04LFClGKYag
        HLqLELeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTnNu-00CzYB-Nd; Tue, 06 Apr 2021 15:13:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64027300F43;
        Tue,  6 Apr 2021 17:12:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A4262C22771A; Tue,  6 Apr 2021 17:12:53 +0200 (CEST)
Date:   Tue, 6 Apr 2021 17:12:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 9/9] sched: prctl() and cgroup interaction
Message-ID: <YGx6dZiAZFpN7QBt@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <20210401133917.590280797@infradead.org>
 <CABk29NvYfAAREeBV-gcoQa+LijphCUJXqeJLWjgPr_PTYumUMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvYfAAREeBV-gcoQa+LijphCUJXqeJLWjgPr_PTYumUMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 06:30:48PM -0700, Josh Don wrote:
> Hi Peter,
> 
> I walked through the reference counting, and it seems good to me
> (though it did take a few passes to fully digest the invariants for
> the fat cookie stuff).
> 
> > +unsigned long sched_core_alloc_cookie(unsigned int type)
> >  {
> >         struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
> >         if (!ck)
> >                 return 0;
> > -       refcount_set(&ck->refcnt, 1);
> > +       WARN_ON_ONCE(type > GROUP_COOKIE);
> > +       sched_core_init_cookie(ck, type);
> >         sched_core_get();
> >
> > -       return (unsigned long)ck;
> > +       return (unsigned long)ck | type;
>  > }
> 
> This feels like it needs to be stronger than a WARN_ON_ONCE; could
> create a corrupted address that we later try to kfree().

The fattie is also released with kfree(), not a real problem that.

> Also, for my own edification, why will the bottom two bits here always be 0?

#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)

> > -unsigned long sched_core_alloc_cookie(void)
> > +static inline void *cookie_ptr(unsigned long cookie)
> > +{
> > +       return (void *)(cookie & ~3UL);
> > +}
> > +
> > +static inline int cookie_type(unsigned long cookie)
> > +{
> > +       return cookie & 3;
> > +}
> 
> s/3/FAT_COOKIE

COOKIE_MASK if anything..

> > +#define FAT_COOKIE     0x03
> 
> Move to sched.h to group with TASK/GROUP_COOKIE?

Didn't want to expose FAT outside the ifdef

> > +static unsigned long __sched_core_fat_cookie(struct task_struct *p,
> > +                                            void **spare_fat,
> > +                                            unsigned long cookie)
> > +{
> 
> This function looks good to me, but could use some more comments about
> the pre/post-condition assumptions. Ie. cookie already has a get()
> associated with it, caller is expected to kfree the spare_fat.

Fair enough. I'll go write up something. I had to fix a refcount issue
here, which should've been clue a comment it required.

There's actually a bug with the rb tree magic too, I'll go fix.

> > +       raw_spin_lock_irqsave(&fat_lock, flags);
> > +       n = rb_find_add(&fat->node, &fat_root, fat_cmp);
> > +       raw_spin_unlock_irqrestore(&fat_lock, flags);
> > +
> > +       if (n) {
> > +               sched_core_put_fat(fat);
> > +               fat = node_2_fat(n);
> 
> This put() doesn't seem strictly necessary; caller will be
> unconditionally freeing the spare_fat. Keep anyway for completeness,
> but add a comment?

It needs to put the references we got on constructing the new fat.
