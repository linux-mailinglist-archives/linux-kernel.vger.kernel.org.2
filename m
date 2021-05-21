Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8061638C36C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhEUJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhEUJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:40:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:39:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i5so11837199qkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X1vaIVC//iTRofgRsPkEvi0MlPPJAR3fKEDO/5WqBw=;
        b=cvzpBW0tXfh5kVERzbaSFuFUeHAHFC5Ycuc4ZuuoHJ1H7dSXzPKqFgEg9znaPEdcIT
         MzIiqbSOoevDwnWVClrHL2GVz9gMAnaSymRBhkosPDh1HGdH7ucylxTeoOI8GhKeFpaV
         2cCEeCTWm1KRaC5YA5n0LPGMRAjob9EmqNyKbkCxY+rEGPDF77amBEcBDqeioneiscE5
         hdbEFMZfRkSZYvQy/Sc8CLEqzDq8kNADIn6QFNQ/jITWgyklNzHMrXq2X8LsKKKQyNxD
         U9Ee3NzfMhyIZb39p7/NepxkmroQCj5E5xS7S6nyoqw5NrDf6gJMlCOgVWvxa8UEBquq
         v+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X1vaIVC//iTRofgRsPkEvi0MlPPJAR3fKEDO/5WqBw=;
        b=nURT128xtg3S0JTeg7ZuHqzMkzob6HtznU5atXWV0Takpn7cv1IDH4XH5zrjl1QQgc
         BxYjGs9TOAOmwbpm1PvOsNof/JnQP2IWViaqREjpuqZiscx7ngFSMzyg6Pm+7xuIaixp
         /rm85yhTntCAQzUnCigdewJHLRJAUrPeyfb1B2RYN9iGoyuYADnTl3bec9jnsg84206K
         6klgdd9/BUEG+0NGm3cWY5q3At3ffpKhv/YMd1N57neQHuD6z6EhWLiOue8ffwhmieg4
         4Rmc4g7OIqzWmRosBVyiYEVzY2x3i2XXabDWSw0BjrU6V2Ef7DGTAVXbT20giEEbzYYF
         p1kQ==
X-Gm-Message-State: AOAM5330APx+XkIy9RDk36W5oizLSb3E3qQ8/sFl+PcvePbqSL7mohK4
        6cUQ/DNRdA+ePER3kup1cgPHQoQb3Y5sST4k4RaWWA==
X-Google-Smtp-Source: ABdhPJyTVxFQ3jfgPZJUj9DUbhxqd/oCI+iKVCRS8M5xMv/TKrSl0tU2q5IOQRvKT+jBmulhqyj/XE6XQzwLy2CPQ8U=
X-Received: by 2002:a37:e10e:: with SMTP id c14mr10997428qkm.209.1621589967448;
 Fri, 21 May 2021 02:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com> <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
 <447D741B-F430-4502-BCA6-C2A12118A2D2@linux.alibaba.com>
In-Reply-To: <447D741B-F430-4502-BCA6-C2A12118A2D2@linux.alibaba.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Fri, 21 May 2021 11:38:50 +0200
Message-ID: <CAFpoUr3nUEWYZjAj+cJp_FL7csOMMS-LE73sb-jjfRNY2fEBDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Odin Ugedal <odin@uged.al>, Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Yeah, it is a well tuned workload and configuration. I did this because for benchmarks
> like schbench, workloads are generated in a fixed pattern without burst. So I set schbench
> params carefully to generate burst during each 100ms periods, to show burst works. Longer
> period or higher quota helps indeed, in which case more workloads can be used to generate
> tail latency then.

Yeah, that makes sense. When it comes to fairness (you are talking
about generating tail
latency), I think configuration of cpu shares/weight between cgroups
is more relevant.

How much more tail latency will a cgroup be able to "create" when
doubling the period?


> In my view, burst is like the cfsb way of token bucket. For the present cfsb, bucket capacity
> is strictly limited to quota. And that is changed into quota + burst now. And it shall be used when
> tasks get throttled and CPU is under utilized for the whole system.

Well, it is as strict as we can make it, depending on how one looks at it. We
cannot guarantee anything more strict than the length of a jiffy or
kernel.sched_cfs_bandwidth_slice_us (simplified ofc.), especially since we allow
runtime from one period to be used in another. I think there is a
"big" distinction between
runtime transferred from the cfs_bw to cfs_rq's in a period compared
to the actual runtime used.

> Default value of kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.

You should mention that in the msg then, since it is highly relevant
to the results. Can you try to tweak
kernel.sched_cfs_bandwidth_slice_us to something like 1ms, and see
what the result will be?

For such a workload and high cfs_bw_slice, a smaller CONFIG_HZ might
also be beneficial (although
there are many things to consider when talking about that, and a lot
of people know more about that than me).

> The following case might be used to prevent getting throttled from many threads and high bandwidth
> slice:
>
> mkdir /sys/fs/cgroup/cpu/test
> echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
> echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
> echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>
> ./schbench -m 1 -t 3 -r 20 -c 80000 -R 20
>
> On my machine, two workers work for 80ms and sleep for 120ms in each round. The average utilization is
> around 80%. This will work on a two-core system. It is recommended to  try it multiple times as getting
> throttled doesn't necessarily cause tail latency for schbench.

When I run this, I get the following results without cfs bandwidth enabled.

$ time ./schbench -m 1 -t 3 -r 20 -c 80000 -R 20
Latency percentiles (usec) runtime 20 (s) (398 total samples)
        50.0th: 22 (201 samples)
        75.0th: 50 (158 samples)
        90.0th: 50 (0 samples)
        95.0th: 51 (38 samples)
        *99.0th: 51 (0 samples)
        99.5th: 51 (0 samples)
        99.9th: 52 (1 samples)
        min=5, max=52
rps: 19900000.00 p95 (usec) 51 p99 (usec) 51 p95/cputime 0.06% p99/cputime 0.06%
./schbench -m 1 -t 3 -r 20 -c 80000 -R 20  31.85s user 0.00s system
159% cpu 20.021 total

In this case, I see 80% load on two cores, ending at a total of 160%. If setting
period: 100ms and quota: 100ms (aka. 1 cpu), throttling is what
you would expect, or?. In this case, burst wouldn't matter?


Thanks
Odin
