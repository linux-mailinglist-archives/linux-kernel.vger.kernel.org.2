Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A433F59B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhHXIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhHXIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:12:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06EFC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T3mdjdXunlsbWXwGgryPRHDmOYktBKnLJTuTpTZcTpA=; b=coXP/mZ/BzITdG8+Z/+NlMTDsQ
        +Ypj6x8QLQcjHn+rnSePfN2jfVoCpzHk9hJmmQ3FYjve040rxsi9MBk4f4Vmk0L/EEk+dweTL53cQ
        oYYUZp/9MdwNtCpziGfS64fdH2CJMCUjmu3hluc7l2zfQ/v3l53bShjaZyHQn27LX0T9ufy95LoqW
        UrOO4U7ry+sTpVFm8Xa391c5et7EAOQFQ55OUCxhTbub6AQsqskxgUfeQGpdQWD0us5dXGY5R1TCW
        fCQNIW/GtFPYj7rVknsHJPMfSSqMk5ImccLjP383QKqjtvP6eDVdYnnRZnWrbZRVcHNf4cEcbH3Y5
        2ZwyKPuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIRXA-00CXMu-IC; Tue, 24 Aug 2021 08:11:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FB6C300399;
        Tue, 24 Aug 2021 10:11:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C739220CCE56B; Tue, 24 Aug 2021 10:11:46 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:11:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
Message-ID: <YSSpwo/VM3+ybgV9@hirez.programming.kicks-ass.net>
References: <20210823111700.2842997-1-valentin.schneider@arm.com>
 <20210823111700.2842997-2-valentin.schneider@arm.com>
 <YSONmyWL14mqV6zA@hirez.programming.kicks-ass.net>
 <87fsv02u9h.mognet@arm.com>
 <99b4c9d6-d20c-bc94-58c0-c1f5249b2636@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b4c9d6-d20c-bc94-58c0-c1f5249b2636@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:53:16PM +0200, Dietmar Eggemann wrote:
> >> I'm a bit puzzled by this; that function has:
> >>
> >>   SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
> >>
> >> Which:
> >>
> >>  - isn't updated
> >>  - implies STATS must be set when BALANCE
> > 
> > Yup
> > 
> >>
> >> the latter gives rise to my confusion; why add that gate on STATS? It
> >> just doesn't make sense to do a BALANCE and not update STATS.
> > 
> > AFAIA that warning was only there to catch BALANCE && !STATS, so I didn't
> > tweak it.
> > 
> > Now, you could still end up with
> > 
> >   flags == NOHZ_NEXT_KICK
> > 
> > (e.g. nohz.next_balance is in the future, but a new CPU entered NOHZ-idle
> > and needs its own rq.next_balance collated into the nohz struct)
> > 
> > in which case you don't do any blocked load update, hence the
> > gate. In v1 I had that piggyback on NOHZ_STATS_KICK, but Vincent noted
> > that might not be the best given blocked load updates can be time
> > consuming - hence the separate flag.
> 
> Maybe the confusion stems from the fact that the NOHZ_NEXT_KICK-set
> changes are only introduced in 2/2?
> 
> @@ -10417,6 +10418,9 @@ static void nohz_balancer_kick(struct rq *rq)
>  unlock:
>  	rcu_read_unlock();
>  out:
> +	if (READ_ONCE(nohz.needs_update))
> +		flags |= NOHZ_NEXT_KICK;
> +

The confusion was about how we'd ever get there and not have STATS set,
but i guess having it all nicely gated does make it saner.

Thanks!
