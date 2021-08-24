Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCD3F5A64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhHXJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhHXJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:05:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00813C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4BqOeEvKn3VT12X6PVV36rmpulDjNs6oQIazXntzmGs=; b=VdNEU++DYYanfEoGHkoAMxqdQs
        apdSS7XiB730XVzHPhewHEQ5kwUFUxK2LtFcGRXDS0AsUDqSLDOV7jkHdQUQHAfgjhGSM0iSZzmoD
        /vjsAp1WlrTjIt7E2ZKvdH6RWqUgPAMCmri8W1g16RBJOQXnOMheMtFyeqFV/JExOTwHolelwUwIQ
        3AU/RLSdAKoSoDuK38biQIBMqX04uoE/dx1GJOYGJVr21248pOGcl1tUhNz5TB9vNd5tVwcv9EYPZ
        vMIxdXKmMOYp4bm0FEGDJ5XoKCUGJKhTkDs4L4LF1luGW6uqa9I8pUmPsI+kavIAv71q0DrR31P3v
        Py1hZGZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISLf-00CXwA-0S; Tue, 24 Aug 2021 09:03:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F69F300024;
        Tue, 24 Aug 2021 11:03:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5866B2C57D1EB; Tue, 24 Aug 2021 11:03:58 +0200 (CEST)
Date:   Tue, 24 Aug 2021 11:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Pillai <vineethrp@gmail.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSS1/rqqsGaBX/yQ@hirez.programming.kicks-ass.net>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:25:28PM -0400, Vineeth Pillai wrote:
> Hi Peter,
> 
> 
> > > Here, we should have instead updated 'max' when picking for SMT-1. Note
> > > that this code would eventually have righted itself, since the retry
> > > loop would re-pick p2, and update 'max' accordingly. However, this patch
> > > avoids the extra round-trip.
> >
> > Going with the observation Tao made; how about we rewrite the whole lot
> > to not be mind-bending complicated :-)
> >
> > How's this? It seems to build and pass the core-sched selftest thingy
> > (so it must be perfect, right? :-)
> >
> Nice, the code is much simpler now :-). A minor suggestion down..
> 
> > -       for_each_cpu(i, smt_mask) {
> > -               struct rq *rq_i = cpu_rq(i);
> > -
> > +       /*
> > +        * For each thread: do the regular task pick and find the max prio task
> > +        * amongst them.
> > +        *
> > +        * Tie-break prio towards the current CPU
> > +        */
> > +       for_each_cpu_wrap(i, smt_mask, cpu) {
> > +               rq_i = cpu_rq(i);
> >                 rq_i->core_pick = NULL;
> >
> >                 if (i != cpu)
> >                         update_rq_clock(rq_i);
> > +
> > +               for_each_class(class) {
> > +                       p = rq_i->core_temp = class->pick_task(rq_i);
> I think we can use core_pick to store the pick here and core_temp
> might not be required. What do you feel?

Indeed we can; makes the code a little less obvious but saves a few
bytes.

Let me go do that and also attempt a Changelog to go with it ;-)
