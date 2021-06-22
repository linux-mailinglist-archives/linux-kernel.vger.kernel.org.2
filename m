Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86BE3B05BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhFVNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:22:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE44C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQFbFa9RdQpPGqJOh5LUvIwo2jlGAApfeGAQXYKBcV8=; b=qXvLWpFItamVErrPHfzyPfZl4I
        bzlb9G807wN14YgEm0NP3YZIUzHBlA7Qh3FvqB4ADI19kzNQgBmW2Vt0c+8+XD+i0LV088jjAdnsC
        vVDO8UqU9auSNOg632CVdVvXikEpbzg1YPS5ACrVtBMOTakSaPEGwbFDD8TfLxd7yhvewtwJo2NS1
        W2q9Zc6tvQLihI0sKkw+06xhVEP/WoDIT2DxqeNOkEW9q2j7VQ0UcYhShFzFBLeD7Wv9iAS+SGhEF
        BM7ECP4TVp+dIrRB4zRRvoMadfEB7gkjXUowsMboZPWP4RY7dX+UX9xwXIiJjEq2tVjCVEmSFyevn
        zDlZUbjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvgJS-00Abek-Q1; Tue, 22 Jun 2021 13:19:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30F51300223;
        Tue, 22 Jun 2021 15:19:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E20C62C82BAEA; Tue, 22 Jun 2021 15:19:34 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:19:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YNHjZqbtzoOy8w87@hirez.programming.kicks-ass.net>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 05:27:58PM +0800, Huaixin Chang wrote:
> The CFS bandwidth controller limits CPU requests of a task group to
> quota during each period. However, parallel workloads might be bursty
> so that they get throttled even when their average utilization is under
> quota. And they are latency sensitive at the same time so that
> throttling them is undesired.
> 
> We borrow time now against our future underrun, at the cost of increased
> interference against the other system users. All nicely bounded.
> 
> Traditional (UP-EDF) bandwidth control is something like:
> 
>   (U = \Sum u_i) <= 1
> 
> This guaranteeds both that every deadline is met and that the system is
> stable. After all, if U were > 1, then for every second of walltime,
> we'd have to run more than a second of program time, and obviously miss
> our deadline, but the next deadline will be further out still, there is
> never time to catch up, unbounded fail.
> 
> This work observes that a workload doesn't always executes the full
> quota; this enables one to describe u_i as a statistical distribution.
> 
> For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
> (the traditional WCET). This effectively allows u to be smaller,
> increasing the efficiency (we can pack more tasks in the system), but at
> the cost of missing deadlines when all the odds line up. However, it
> does maintain stability, since every overrun must be paired with an
> underrun as long as our x is above the average.
> 
> That is, suppose we have 2 tasks, both specify a p(95) value, then we
> have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
> everything is good. At the same time we have a p(5)p(5) = 0.25% chance
> both tasks will exceed their quota at the same time (guaranteed deadline
> fail). Somewhere in between there's a threshold where one exceeds and
> the other doesn't underrun enough to compensate; this depends on the
> specific CDFs.
> 
> At the same time, we can say that the worst case deadline miss, will be
> \Sum e_i; that is, there is a bounded tardiness (under the assumption
> that x+e is indeed WCET).
> 
> The benefit of burst is seen when testing with schbench. Default value of
> kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.
> 
> 	mkdir /sys/fs/cgroup/cpu/test
> 	echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
> 	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
> 	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
> 
> 	./schbench -m 1 -t 3 -r 20 -c 80000 -R 10
> 
> The average CPU usage is at 80%. I run this for 10 times, and got long tail
> latency for 6 times and got throttled for 8 times.
> 
> Tail latencies are shown below, and it wasn't the worst case.
> 
> 	Latency percentiles (usec)
> 		50.0000th: 19872
> 		75.0000th: 21344
> 		90.0000th: 22176
> 		95.0000th: 22496
> 		*99.0000th: 22752
> 		99.5000th: 22752
> 		99.9000th: 22752
> 		min=0, max=22727
> 	rps: 9.90 p95 (usec) 22496 p99 (usec) 22752 p95/cputime 28.12% p99/cputime 28.44%
> 
> The interferenece when using burst is valued by the possibilities for
> missing the deadline and the average WCET. Test results showed that when
> there many cgroups or CPU is under utilized, the interference is
> limited. More details are shown in:
> https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
> 
> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---

Ben, what say you? I'm tempted to pick up at least this first patch.
