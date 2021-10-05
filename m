Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DB422247
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJEJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:28:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988FC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVBK8qZqKJK7GoPZ1PWvSP/Na8ce1nj7kFjunKNO8qs=; b=b1Bu5tAWLynJgXAnTlC1w5/0TJ
        +7CjOJ4akG4e1p1Soh4+Yuai5Pq+WQYrMMlYiEsKlKOqxiS4qZ1Uf1kDhA2Qzv4QCPhQPr57wIBb1
        So1gA7nhdtha6GMu+Nm3/sohDhbkNa/STHOWvd6V/o2s49vLIHAV1keANKFHGpQApD/Y1+BJ4qF8h
        DPVg/PNxLieZr9zRZdvJs1IMXYUVbubyWt/SWJ29V1XP7Fehh4DN7hoP/oGdXwvQatnp93FK8UfQ6
        nwRzm6JwKyFfrbXllq6zUuLhtwXpbIbCqqB0x7HrECFCHNHvhwu93dldTMtq20UFkrbqgFqRnbfdM
        y/N+ZYQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXggT-000B4x-Um; Tue, 05 Oct 2021 09:24:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFBE5300233;
        Tue,  5 Oct 2021 11:24:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C809202A012E; Tue,  5 Oct 2021 11:24:23 +0200 (CEST)
Date:   Tue, 5 Oct 2021 11:24:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwZx1Mc6FQdWY6J@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <0cf76bb7701d4a37367773881c7d7c7bfceb455e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf76bb7701d4a37367773881c7d7c7bfceb455e.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:32:54PM +0200, Mike Galbraith wrote:
> On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:

> > FAIR_SLEEPERS primarily affects tasks that just became runnable and the
> > new task is trying to fit in without causing too much disruption based
> > on sysctl_sched_latency.
> 
> No, fair sleepers is all about sleeper wakeup preemption, I think
> you're thinking of fork initial placement.

Butting in in the middle of the thread (and I know there's still lots to
read)...

So the FAIR_SLEEPERS thing is about giving tasks that have slept a while
some extra credit to run sooner.

The classical example has always been a task that run 50% combined with
a task that runs 100%, what's fair? a 1:2 or 1:1 ratio? Strict fair
(runnable) scheduling will get you the 1:2, while intuitively having two
tasks with 100% combined CPU utilization 1:1 would be 'fair'.

FAIR_SLEEPERS gets you towards that 1:1, *provided* the period of that
50% is near sched_latency/2.

Another important factor for wakeup preemption has always been desktop
usage; can you still get responsive terminals while building a kernel,
how does firefox scroll during a kernel build etc..

(fwiw, firefox should start scrolling responsively and then bog down if
you keep on scrolling because it becomes a hog and has exhausted the
inital boost)

Also, I think the ChromeOS people have interactivity measures these
days.

All our traditinoal benchmarks miss out here; they're mostly throughput
oriented, and it is really easy to totally wreck interactivity while
getting great througput :/
