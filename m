Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949EF3B0D50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhFVTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:00:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:58:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x16so269423pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9mBB3Oyw8tGq6ZxPPTZbn3rTLg8GSCWZ4AhutWO3Gb8=;
        b=d+mR3A+4TSDAuyixjne+NFKisH85rglQS0yHcwISUM0H0SNLo3Rq9KK1aKGDbc/stb
         DjhzR78M8fp5L8uip1eWuKoF6T4qlJLNfnuqwiKKV9rG+OrQjKqITC8tlco5F1b7zBNU
         ZQrrq/omC+U9WjvBB2ajdvCSzrRWznOMVKUE8+Uf41smRBkiblytZD9fo2zmsb1Er/11
         XjiyWdfZ7895PMWZMVBDg0rL4x6ZFsftNUvch6uiH1bUsp+UmnVcTpfpHlQOdVCM8zkf
         dPHc12IhsT+Peb6uEiLKFXC/DoW6NED+qfODME9BnVDDl/sTMgCdOTAI8EyeRx1qAig+
         tMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9mBB3Oyw8tGq6ZxPPTZbn3rTLg8GSCWZ4AhutWO3Gb8=;
        b=ggM6Rr69cQhkXXIPcIluDnMbbP52mCSsegZdWwaeTIYGsvi5qAqQZ7T3nvWKC3bUMm
         YjMwJaZ4d8roi5h1Zetr5sgQfq1e8aiJmwlIMxRqMuauT0mTSdOCOlJLgsPfRzP+1NeX
         PktXiaAGUaq+PeCQ9p6YGByEt4jKmY9EOtZpvQe1wpw1i1gePBAFRYl7YEdDmtQ4TQT9
         WXP55cQQxcyHuayMLY512SBcJTlS1YmZZcclP+z0YtpMiFuAukgR/hkGNSOJfoTCBkrd
         9eo80XGVf/c8oaDY6shYN1PmwyE5vU/MFTcLvVJJ409ZDz2ryAi7iV6+fbhiUEpTkjsv
         2HUg==
X-Gm-Message-State: AOAM533jk1YVNvSUnDrLsPqq4bBlTdkY/oX58J4vy4fgQ97SY8oFOkxz
        Qj6VjHgHp3HbQjt9hriZ170vrA==
X-Google-Smtp-Source: ABdhPJx/MOFI1xkYjG5ivU7inTjah9N4fcVQ7Mc+kJVsRzQF0HGdO+t7TTELkBsHIIZFHmuQvdUaOw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr137055pgf.216.1624388284965;
        Tue, 22 Jun 2021 11:58:04 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id 125sm89450pfg.52.2021.06.22.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:58:03 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 1/3] sched/fair: Introduce the burstable CFS controller
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
        <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
        <YNHjZqbtzoOy8w87@hirez.programming.kicks-ass.net>
Date:   Tue, 22 Jun 2021 11:57:51 -0700
In-Reply-To: <YNHjZqbtzoOy8w87@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 22 Jun 2021 15:19:34 +0200")
Message-ID: <xm26fsx9afrk.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jun 21, 2021 at 05:27:58PM +0800, Huaixin Chang wrote:
>> The CFS bandwidth controller limits CPU requests of a task group to
>> quota during each period. However, parallel workloads might be bursty
>> so that they get throttled even when their average utilization is under
>> quota. And they are latency sensitive at the same time so that
>> throttling them is undesired.
>> 
>> We borrow time now against our future underrun, at the cost of increased
>> interference against the other system users. All nicely bounded.
>> 
>> Traditional (UP-EDF) bandwidth control is something like:
>> 
>>   (U = \Sum u_i) <= 1
>> 
>> This guaranteeds both that every deadline is met and that the system is
>> stable. After all, if U were > 1, then for every second of walltime,
>> we'd have to run more than a second of program time, and obviously miss
>> our deadline, but the next deadline will be further out still, there is
>> never time to catch up, unbounded fail.
>> 
>> This work observes that a workload doesn't always executes the full
>> quota; this enables one to describe u_i as a statistical distribution.
>> 
>> For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
>> (the traditional WCET). This effectively allows u to be smaller,
>> increasing the efficiency (we can pack more tasks in the system), but at
>> the cost of missing deadlines when all the odds line up. However, it
>> does maintain stability, since every overrun must be paired with an
>> underrun as long as our x is above the average.
>> 
>> That is, suppose we have 2 tasks, both specify a p(95) value, then we
>> have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
>> everything is good. At the same time we have a p(5)p(5) = 0.25% chance
>> both tasks will exceed their quota at the same time (guaranteed deadline
>> fail). Somewhere in between there's a threshold where one exceeds and
>> the other doesn't underrun enough to compensate; this depends on the
>> specific CDFs.
>> 
>> At the same time, we can say that the worst case deadline miss, will be
>> \Sum e_i; that is, there is a bounded tardiness (under the assumption
>> that x+e is indeed WCET).
>> 
>> The benefit of burst is seen when testing with schbench. Default value of
>> kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.
>> 
>> 	mkdir /sys/fs/cgroup/cpu/test
>> 	echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
>> 	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>> 	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>> 
>> 	./schbench -m 1 -t 3 -r 20 -c 80000 -R 10
>> 
>> The average CPU usage is at 80%. I run this for 10 times, and got long tail
>> latency for 6 times and got throttled for 8 times.
>> 
>> Tail latencies are shown below, and it wasn't the worst case.
>> 
>> 	Latency percentiles (usec)
>> 		50.0000th: 19872
>> 		75.0000th: 21344
>> 		90.0000th: 22176
>> 		95.0000th: 22496
>> 		*99.0000th: 22752
>> 		99.5000th: 22752
>> 		99.9000th: 22752
>> 		min=0, max=22727
>> 	rps: 9.90 p95 (usec) 22496 p99 (usec) 22752 p95/cputime 28.12% p99/cputime 28.44%
>> 
>> The interferenece when using burst is valued by the possibilities for
>> missing the deadline and the average WCET. Test results showed that when
>> there many cgroups or CPU is under utilized, the interference is
>> limited. More details are shown in:
>> https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
>> 
>> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
>> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
>> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
>> ---
>
> Ben, what say you? I'm tempted to pick up at least this first patch.

Yeah, I'm fine with it; I know internally we've thought about adding
something like this.

Reviewed-by: Ben Segall <bsegall@google.com>
