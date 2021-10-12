Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA742A465
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhJLM3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbhJLM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:29:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69733C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffPHDJJEvo/WkeBn4dyBDe1/NGOwywL+tze3tYyLZNg=; b=YuNHCGiyEF91GQSGBJhptO//l5
        aLOxnPn7YBu9ig9+Yo72doRaHS7QtYgqEaLeTqe5XJOEKEaeJfVqvBh1nx8L4vsIGXlZcFcnR7/S3
        SjurpGumPVTfQWMZT/OrebfoZYKkcpcsv0JSSf9w1E5vtypi4+iNDvbtOb1QEusrJBQbfXlu8MEZ9
        75st3h11eddDSutAjI+cveJ9hqLN3zI8J875n+C8Z6Ad3CgBCbMDBP4ME9s+/HIhc1DMMm+4eJb0n
        2xgPzLvMewawP5XKsuYYUhO9XzobC0nueP3pFf/RSrA3FitGhdaEtYL1qRnUkrrzo+TIcn6oEjnTs
        Hc4vkd2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGsA-009PZ0-BL; Tue, 12 Oct 2021 12:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53CF1300079;
        Tue, 12 Oct 2021 14:27:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FC4A212D6A1E; Tue, 12 Oct 2021 14:27:09 +0200 (CEST)
Date:   Tue, 12 Oct 2021 14:27:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/core: forced idle accounting
Message-ID: <YWV/HNDJaIAOLdrt@hirez.programming.kicks-ass.net>
References: <20211008000825.1364224-1-joshdon@google.com>
 <20211009155435.GW174703@worktop.programming.kicks-ass.net>
 <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:12:43PM -0700, Josh Don wrote:

> > > +             if (WARN_ON_ONCE(!nr_running)) {
> > > +                     /* can't be forced idle without a running task */
> > > +             } else {
> > > +                     delta *= nr_forced_idle;
> > > +                     delta /= nr_running;
> > > +             }
> >
> > Now the comment sayeth:
> >
> > > +     /*
> > > +      * For larger SMT configurations, we need to scale the charged
> > > +      * forced idle amount since there can be more than one forced idle
> > > +      * sibling and more than one running cookied task.
> > > +      */
> >
> > But why?
> 
> We scale by the number of cpus actually forced idle, since we don't
> want to falsely over or under charge forced idle time (defined
> strictly as time where we have a runnable task but idle the cpu). The
> more important scaling here though is the division over the number of
> running entities. This is done so that the aggregate amount of forced
> idle over some group of threads makes sense. Ie if we have a cpu with
> SMT8, and a group of 7 threads sharing a cookie, we don't want to
> accrue 7 units of forced idle time per unit time while the 8th SMT is
> forced idle.

So why not simply compute the strict per-cpu force-idle time and let
userspace sort out the rest?

