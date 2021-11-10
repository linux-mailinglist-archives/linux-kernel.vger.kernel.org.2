Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8F44BCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhKJImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhKJImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:42:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CAFC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HekGpi2u7A1rx9/Nm3Eol0qYx6FMizt4+yfuYyMZeaY=; b=MQejN3OFVs5DpXp0vKtAAL4U/o
        si7EnLvcLehpUnUABTAHlrDJ8KHDNB83wstwr36XAwhALEsVou4555ldACWf8FYR9HmhR8ObvqVVa
        VlNWDqTwi55T1J0q+pyS7nGYWssJ/LLOAIKv+Fcw0ybC/SyvCTtN2mxctiFFhh/vSN3jzteB4x0GA
        MF6LNA7FJkG3zwBerYjRARnRZe4bRmcVKbbUmlufPjqrYuNtWlyl8v6YXOc7sOiUzRJH5Z7e96ZlT
        Zq21vYDFv6Zzq4mqnxRA/xxgyqtl3WlLzfQJV7f3DVOiWD3+nXQ8zAmQI1YeLqbYf0705AazmZMx/
        gtjLTPWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkj89-001hn5-TH; Wed, 10 Nov 2021 08:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 662E930003C;
        Wed, 10 Nov 2021 09:38:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EFCE212EE584; Wed, 10 Nov 2021 09:38:53 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:38:53 +0100
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
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: forced idle accounting
Message-ID: <YYuFHZCxtJe+BpWM@hirez.programming.kicks-ass.net>
References: <20211018203428.2025792-1-joshdon@google.com>
 <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
 <CABk29NucnFxyPQ==n8-v=_hti2THkybrEkxruqJ_v8rvW4yacg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NucnFxyPQ==n8-v=_hti2THkybrEkxruqJ_v8rvW4yacg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 02:59:00PM -0800, Josh Don wrote:
> On Tue, Nov 9, 2021 at 3:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> > > @@ -5804,6 +5830,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >               }
> > >       }
> > >
> > > +     if (rq->core->core_forceidle_count) {
> >
> > Does this want to be something like:
> >
> >         if (schedstat_enabled() && .. ) ?
> >
> > afaict without schedstat on this is dead code.
> >
> 
> Makes sense to me, and similarly we can bail out of sched_core_tick()
> early in the disabled case.

Ok, I already changed the patch to include the above, lemme also edit
sched_core_tick().
