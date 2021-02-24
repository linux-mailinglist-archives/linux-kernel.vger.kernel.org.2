Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC635324344
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhBXRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBXRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:42:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZwEr410feKVIXvCVj35Znp2sGtryfBWRcBLV6+cjK8=; b=GIY8rMdxjvPdrYBLMx7jKiATdp
        SDZxb5uoY2/trxTRq6TsHskE1B7D3SRtD7eUDNFkLcQwSJH9qvTJDEeos6JE5RvMxTvN8JJNqLheH
        pqny+EBd4wXKT4ssJkudoTxRxesAzGpSObkguYq9kSd+NV7xBWUseexArtnl2Y6wOC2u+o8e4BNme
        T0l8IV4MQ1jvKh3Emim8Tt3j5O0QtWQy1frt1Q8ufBUsOzs/ayYVSeXRlp/3idTGKZHUTvpmi13AZ
        UJe8gtD/Fb9kJFa5tgZYxufaLexLwMvBWmJSZLNwPP1OFMLDJpwP69m0QHd+rVMMNgdlRtM+ihGn4
        aazUHLdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEy9z-0001sx-UO; Wed, 24 Feb 2021 17:41:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 603A2305C11;
        Wed, 24 Feb 2021 18:41:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 478E2206936D2; Wed, 24 Feb 2021 18:41:09 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:41:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
Message-ID: <YDaPtc47NnB5BGEW@hirez.programming.kicks-ass.net>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
 <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net>
 <CAKfTPtCwmt9HHDuN7tVhZiy7R3e5XHuExU-PVOb++40fYzu-2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCwmt9HHDuN7tVhZiy7R3e5XHuExU-PVOb++40fYzu-2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:57:15PM +0100, Vincent Guittot wrote:
> On Wed, 24 Feb 2021 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 24, 2021 at 02:30:00PM +0100, Vincent Guittot wrote:
> > > Joel reported long preempt and irq off sequence in newidle_balance because
> > > of a large number of CPU cgroups in use and having to be updated. This
> > > patchset moves the update outside newidle_imblance. This enables to early
> > > abort during the updates in case of pending irq as an example.
> > >
> > > Instead of kicking a normal ILB that will wakes up CPU which is already
> > > idle, patch 6 triggers the update of statistics in the idle thread of
> > > the CPU before selecting and entering an idle state.
> >
> > I'm confused... update_blocked_averages(), which calls
> > __update_blocked_fair(), which is the one doing the cgroup iteration
> > thing, runs with rq->lock held, and thus will have IRQs disabled any
> > which way around we turn this thing.
> >
> > Or is the problem that we called nohz_idle_balance(), which does
> > update_nohz_stats() -> update_blocked_averages() for evey NOHZ cpu from
> > newidle balance, such that we get NR_NOHZ_CPUS * NR_CGROUPS IRQ latency?
> > Which is now reduced to just NR_CGROUPS ?
> 
> Yes we can now abort between each cpu update

OK, shall I add something like:

This reduces the IRQ latency from O(nr_cgroups * nr_nohz_cpus) to
O(nr_cgroups).

To the changelog of patch #1 ?
