Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65469447EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhKHLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhKHLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:24:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB12C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 03:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7l9Qh23ABh9dJBsIWZLWZvILEE4YxWy7+qXg5zYdiIk=; b=IWW3vvi/BKZOJ+HoTuYfplYJ4D
        Gt6Qbib3UE3GJBsc6nVW58xSTiUouh8ZgnsGwqymYrz5lLGJdEk20O9uWbWIDPv1nQu96H5mRiX8n
        CXMxLabp58gs+negPerQwX7Seccm0NZGkVCPOLe1q9DjD4rFhzOJq9sRYDPTfbCWj94GzMcNd8nGc
        uZ1HyJs+FDTfCzLOmpkbjL719hXzmFJIgy3hhVS7XrTE2YanRT+AoYb1FK19E4QID3pThRiiBhuKr
        ywoQNoIn9PD0L3A0SXvvlJCF0HikLxIBARGIZpETJER5ks0p8N4wAtTDQdCf1/WFDKikl9uRSEUUc
        mHXot00w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk2gQ-0008LC-QR; Mon, 08 Nov 2021 11:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 869093000DD;
        Mon,  8 Nov 2021 12:19:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58E16202A012E; Mon,  8 Nov 2021 12:19:23 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:19:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Vincent Donnefort <Vincent.Donnefort@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, jing-ting.wu@mediatek.com
Subject: Re: [PATCH] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Message-ID: <YYkHu8kkp9q9/QPP@hirez.programming.kicks-ass.net>
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
 <CAKfTPtAQTCqhbaW90EiyerPM2x-==cX3Xodq+nAymVK_U=45vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAQTCqhbaW90EiyerPM2x-==cX3Xodq+nAymVK_U=45vA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:08:33PM +0100, Vincent Guittot wrote:
> On Thu, 4 Nov 2021 at 18:52, Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > Nothing protects the access to the per_cpu variable sd_llc_id. When testing
> > the same CPU (i.e. this_cpu == that_cpu), a race condition exists with
> > update_top_cache_domain(). One scenario being:
> >
> >               CPU1                            CPU2
> >   ==================================================================
> >
> >   per_cpu(sd_llc_id, CPUX) => 0
> >                                     partition_sched_domains_locked()
> >                                       detach_destroy_domains()
> >   cpus_share_cache(CPUX, CPUX)          update_top_cache_domain(CPUX)
> >     per_cpu(sd_llc_id, CPUX) => 0
> >                                           per_cpu(sd_llc_id, CPUX) = CPUX
> >     per_cpu(sd_llc_id, CPUX) => CPUX
> >     return false
> >
> > ttwu_queue_cond() wouldn't catch smp_processor_id() == cpu and the result
> > is a warning triggered from ttwu_queue_wakelist().
> >
> > Avoid a such race in cpus_share_cache() by always returning true when
> > this_cpu == that_cpu.
> >
> > Fixes: 518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")
> > Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
>  Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f2611b9cf503..f5ca15cdcff4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3726,6 +3726,9 @@ void wake_up_if_idle(int cpu)
> >
> >  bool cpus_share_cache(int this_cpu, int that_cpu)
> >  {
> > +       if (this_cpu == that_cpu)
> > +               return true;
> > +
> >         return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
> >  }

Blergh, that's annoying. Thanks guys, picked it up for /urgent
