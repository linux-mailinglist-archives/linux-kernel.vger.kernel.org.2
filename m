Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25BC40C713
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhIOOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbhIOOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:09:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B5C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:07:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v10so5992502ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBNwRP+33+3NF4SweKpQhbgFpKJwd60XdEkJjETIIqY=;
        b=pPxoHIzw4NeIqHNkl2Pff6oYpIakirgu6xM4l+WpFMkWwNrYwYmbFTC+sYyoREEPlr
         0PXqdsPI9K3uvMXt9u9FfTAeYZpkXlrWav5TuQqc48ejQ9eTEhA++ask3bvHgO/Q4+uD
         we46HVLFb/mekjyWpbdBbZyZ5sXPHL0m+2MhnaWIH1NO8NSyfq1Ha3FQcxGsWERnD8gI
         dmyJVvQrD/WFRLn5OmS/TWMDNVoUvEveQAjvmjmWUvGIl2N3br1HNhLRHyha105OPHSZ
         xNeJDxONZ/kl1JLUpy3rbyePWNie9+yf50UG1GxKDjq2lpSEx7ziEMlSKskvAmjBsrBj
         Tiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBNwRP+33+3NF4SweKpQhbgFpKJwd60XdEkJjETIIqY=;
        b=Cyr/Jyvul0xQldbG642vzwl095nPN1Q0P1n+p6gdqtiE4s175mfVzYchDGwqGdW6xH
         kTYrSZ2onsY6HprESWk7c77YJ/PeZv5ID8OoU5uF7xBzWRzV3wu+zWuBTtorgMteUwnQ
         KHKj49LDoWFWDvf9lmFmsAnwKT9lESye9KkbkfB5RrEini/HcsIAjJ+bK6mbDJAoPvw7
         Nmy7bHb9aIXHdonfTW2GPymWXbtkX3dItTOShPNT0SlUyyB5RXBw7F6bDISM1Es18BS8
         stcQt1y+tZqJlJQ8lVu/zQgzIVOlnAnbG5pkTQz0GjDx0iaqWeS7e6xi4vaq1gS26GsT
         YlVw==
X-Gm-Message-State: AOAM5333Th87M/7tr8OxOCTXUXApJv8kTlDN82NaNOXeL81qblZeYncX
        MI/SSaxWYbjKZxlk+Lur2ws9jdvyo1VFEXLifJFEwg==
X-Google-Smtp-Source: ABdhPJy4JCc70atmZar1JkBiROp3WcdHbH1wua6wEEMV2K17FWUm2qrROPnPQrEmvEzMHPPkgJKqbQyFHD+j5siviqg=
X-Received: by 2002:a25:c753:: with SMTP id w80mr212085ybe.245.1631714864394;
 Wed, 15 Sep 2021 07:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
 <CAKfTPtDJip17rdZ0CMDwUztE7BGUF+J_O2Up=S5GLYrqtkA67A@mail.gmail.com>
 <d9ada2d4-1967-7b80-68e0-ef7052c41e0f@hisilicon.com> <CAKfTPtBv3TAJvKayn73yenJGmqchObXDWMm2Kxj0ixL8E0GUGA@mail.gmail.com>
 <e2257ed8-00dd-a7e7-407f-558c725a8a55@hisilicon.com>
In-Reply-To: <e2257ed8-00dd-a7e7-407f-558c725a8a55@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Sep 2021 16:07:33 +0200
Message-ID: <CAKfTPtAGeBsTGc39vapezfq9ZboViWZARk4=NxacHHjVBqsW5A@mail.gmail.com>
Subject: Re: [RFC] Perfomance varies according to sysctl_sched_migration_cost
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        21cnbao@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        prime.zeng@huawei.com,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 10:34, Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> On 2021/9/14 20:55, Vincent Guittot wrote:
> > On Tue, 14 Sept 2021 at 14:08, Yicong Yang <yangyicong@hisilicon.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> thanks for the reply!
> >>
> >> On 2021/9/14 17:04, Vincent Guittot wrote:
> >>> Hi Yicong,
> >>>
> >>> On Tue, 14 Sept 2021 at 09:27, Yicong Yang <yangyicong@hisilicon.com> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> I noticed that some benchmark performance varies after tunning the sysctl_sched_migration_cost
> >>>> through /sys/kernel/debug/sched/migration_cost_ns on arm64. The default value is 500000, and
> >>>> I tried 10000, 100000, 1000000. Below are some results from mmtests, based on 5.14-release.
> >>>>
> >>>> On Kunpeng920 (128cores, 4numa, 2socket):
> >>>>
> >>>> pgbench (config-db-pgbench-timed-ro-medium)
> >>>>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> >>>> Hmean     1       9558.99 (   0.00%)     9735.31 *   1.84%*     9410.84 *  -1.55%*     9602.47 *   0.45%*
> >>>> Hmean     8      17615.90 (   0.00%)    17439.78 *  -1.00%*    18056.44 *   2.50%*    19222.18 *   9.12%*
> >>>> Hmean     12     25228.38 (   0.00%)    25592.69 *   1.44%*    26739.06 *   5.99%*    27575.48 *   9.30%*
> >>>> Hmean     24     46623.27 (   0.00%)    48853.30 *   4.78%*    47386.02 *   1.64%*    48542.94 *   4.12%*
> >>>> Hmean     32     60578.78 (   0.00%)    62116.81 *   2.54%*    59961.36 *  -1.02%*    58681.07 *  -3.13%*
> >>>> Hmean     48     68159.12 (   0.00%)    67867.90 (  -0.43%)    65631.79 *  -3.71%*    66487.16 *  -2.45%*
> >>>> Hmean     80     66894.87 (   0.00%)    73440.92 *   9.79%*    68751.63 *   2.78%*    67326.70 (   0.65%)
> >>>> Hmean     112    68582.27 (   0.00%)    65339.90 *  -4.73%*    68454.99 (  -0.19%)    67211.66 *  -2.00%*
> >>>> Hmean     144    76290.98 (   0.00%)    70455.65 *  -7.65%*    64851.23 * -14.99%*    64940.61 * -14.88%*
> >>>> Hmean     172    63245.68 (   0.00%)    68790.24 *   8.77%*    66246.46 *   4.74%*    69536.96 *   9.95%*
> >>>> Hmean     204    61793.47 (   0.00%)    63711.62 *   3.10%*    66055.64 *   6.90%*    58023.20 *  -6.10%*
> >>>> Hmean     236    61486.75 (   0.00%)    68404.44 *  11.25%*    70499.70 *  14.66%*    58285.67 *  -5.21%*
> >>>> Hmean     256    57476.13 (   0.00%)    65645.83 *  14.21%*    69437.05 *  20.81%*    60518.05 *   5.29%*
> >>>>
> >>>> tbench (config-network-tbench)
> >>>>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> >>>> Hmean     1        333.12 (   0.00%)      332.93 (  -0.06%)      335.34 *   0.67%*      334.36 *   0.37%*
> >>>> Hmean     2        665.88 (   0.00%)      667.19 *   0.20%*      666.47 *   0.09%*      667.02 *   0.17%*
> >>>> Hmean     4       1324.10 (   0.00%)     1312.23 *  -0.90%*     1313.07 *  -0.83%*     1315.13 *  -0.68%*
> >>>> Hmean     8       2618.85 (   0.00%)     2602.00 *  -0.64%*     2577.49 *  -1.58%*     2600.48 *  -0.70%*
> >>>> Hmean     16      5100.74 (   0.00%)     5068.80 *  -0.63%*     5041.34 *  -1.16%*     5069.78 *  -0.61%*
> >>>> Hmean     32      8157.22 (   0.00%)     8163.50 (   0.08%)     7936.25 *  -2.71%*     8329.18 *   2.11%*
> >>>> Hmean     64      4824.56 (   0.00%)     4890.81 *   1.37%*     5319.97 *  10.27%*     4830.68 *   0.13%*
> >>>> Hmean     128     4635.17 (   0.00%)     6810.90 *  46.94%*     5304.36 *  14.44%*     4516.06 *  -2.57%*
> >>>> Hmean     256     8816.62 (   0.00%)     8851.28 *   0.39%*     8448.76 *  -4.17%*     6840.12 * -22.42%*
> >>>> Hmean     512     7825.56 (   0.00%)     8538.04 *   9.10%*     8002.77 *   2.26%*     7946.54 *   1.55%*
> >>>>
> >>>> Also on Raspberrypi 4B:
> >>>>
> >>>> pgbench (config-db-pgbench-timed-ro-medium)
> >>>>                    mig-cost-500000        mig-cost-100000
> >>>> Hmean     1     1651.41 (   0.00%)     3444.27 * 108.56%*
> >>>> Hmean     4     4015.83 (   0.00%)     6883.21 *  71.40%*
> >>>> Hmean     7     4161.45 (   0.00%)     6646.18 *  59.71%*
> >>>> Hmean     8     4277.28 (   0.00%)     6764.60 *  58.15%*
> >>>>
> >>>> For tbench on Raspberrypi 4B and both pgbench and tbench on x86, tuning sysctl_sched_migration_cost
> >>>> doesn't have such huge difference and will have some degradations (max -8% on x86 for pgbench) in some cases.
> >>>>
> >>>> The sysctl_sched_migration_cost will affects the frequency of load balance. It will affect
> >>>
> >>> So it doesn't affect the periodic load but only the newly idle load balance
> >>>
> >>
> >> In load_balance(), it's used to judge whether a task is hot in task_hot(). so I think it
> >> participates in the periodic load balance.
> >
> > Not really. The periodic load balance always happens but task_hot is
> > used to skip task that have recently run on the cpu and select older
> > tasks instead
> > At the contrary, sysctl_sched_migration_cost is used to decide if we
> > should abort newly_idle_load_balance
> >
>
> well. I think I get it. In periodic load balance sysctl_sched_migration_cost will affect
> which task we choose to migrate but won't abort the process like what it does
> in new idle balance.
>
> > As a side point, would be good to know if the improvement and
> > regression seen in your tests are more linked to the task hotness or
> > for  skipping/aborting newly idle load balance
> >
>
> sure. I think I can get some hints by comparing the scheduler statistics
> after tuning sysctl_sched_migration_cost.
>
> >>
> >>>> directly in task_hot() and newidle_balance() to decide whether we can do a migration or load
> >>>> balance. And affects other parameters like rq->avg_idle, rq->max_idle_balance_cost and
> >>>> sd->max_newidle_lb_cost to indirectly affect the load balance process. These parameters record
> >>>> the load_balance() cost and will be limited up to sysctl_sched_migration_cost, so I measure
> >>>> the average cost of load_balance() on Kunpeng920 with bcc tools(./funclantency load_balance -d 10):
> >>>>
> >>>> system status   idle   50%load  100%load
> >>>> avg cost      3160ns    4790ns    7563ns
> >>>
> >>> What is the setup of your test ? has this been measured during the
> >>> benchmarks above ?
> >>>
> >>
> >> I use stress-ng to generate the load. Since it's a 128core server, `stress-ng -c 64` for
> >> 50% load, and `stress-ng -c 128` for 100% load. This is not measured during the benchmarks'
> >> process.
> >
> > I don't think this is the best benchmark to evaluate the real cost of
> > load_balance because it create always running task and  you measure
> > only the periodic load balance and not the newly load balance which is
> > the one really impacted by sysctl_sched_migration_cost
> >
>
> it's right. It doesn't cover the newidle balance case and bcc is based on kprobe which
> may have large latency on arm64 [1]. My original purpose is not to measure it accurately
> but to see whehter the cost is comparable to the sysctl_sched_migration_cost.
>
> [1] https://lore.kernel.org/lkml/20210818073336.59678-1-liuqi115@huawei.com/
>
> >>
> >>> Also, do you have more details about  the topology and the number of
> >>> sched domain ?
> >>>
> >>
> >> sure. for `numactl -H`:
> >>
> >> available: 4 nodes (0-3)
> >> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> >> node 0 size: 257149 MB
> >> node 0 free: 253518 MB
> >> node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> >> node 1 size: 193531 MB
> >> node 1 free: 192916 MB
> >> node 2 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> >> node 2 size: 96763 MB
> >> node 2 free: 92654 MB
> >> node 3 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> >> node 3 size: 127668 MB
> >> node 3 free: 125846 MB
> >> node distances:
> >> node   0   1   2   3
> >>   0:  10  12  20  22
> >>   1:  12  10  22  24
> >>   2:  20  22  10  12
> >>   3:  22  24  12  10
> >>
> >> Kunpeng 920 is non-smt. There're 4 level domains and below is part of the /proc/schedstat:
> >> [...]
> >> cpu0
> >> domain0 00000000,00000000,00000000,ffffffff
> >> domain1 00000000,00000000,ffffffff,ffffffff
> >> domain2 00000000,ffffffff,ffffffff,ffffffff
> >> domain3 ffffffff,ffffffff,ffffffff,ffffffff
> >
> > Because of the large difference between the number of cpus at 1st and
> > last level, an average duration of load_balance() is not really
> > meaningful and we can expect a factor of 4 between smallest and larger
> > one
> >
>
> yes, the larger domain may have larger cost. I only show the average value
> here while I got a histgram of the cost distribution as well.
> the min range means where the minimal values fall in while the max range
> means where the maximum values fall in. Counts means how many times
> load_balance() is measured.
>
>               min range(counts)        max range(counts)       total counts
> idle               256-511(456)          16384-32767(16)              14047
> 50% load          256-511(4018)         16382-32767(140)              57908
> 100%load          1024-2047(64)           32768-65535(8)               2582
>
> Load balance is more frequent on a half loaded system while it takes more time
> when it's well loaded.
>
> funclatency tools: https://github.com/iovisor/bcc/blob/master/tools/funclatency.py
>
> >> [...]
> >> cpu32
> >> domain0 00000000,00000000,ffffffff,00000000
> >> domain1 00000000,00000000,ffffffff,ffffffff
> >> domain2 00000000,ffffffff,ffffffff,ffffffff
> >> domain3 ffffffff,ffffffff,ffffffff,ffffffff
> >> [...]
> >> cpu64
> >> domain0 00000000,ffffffff,00000000,00000000
> >> domain1 ffffffff,ffffffff,00000000,00000000
> >> domain2 ffffffff,ffffffff,00000000,ffffffff
> >> domain3 ffffffff,ffffffff,ffffffff,ffffffff
> >> [...]
> >> cpu96
> >> domain0 ffffffff,00000000,00000000,00000000
> >> domain1 ffffffff,ffffffff,00000000,00000000
> >> domain2 ffffffff,ffffffff,00000000,ffffffff
> >> domain3 ffffffff,ffffffff,ffffffff,ffffffff
> >> [...]
> >>
> >>> Are you using cgroup hierarchy ?
> >>>
> >>
> >> No cgroup hierarchy during the test.
> >
> > This can slow down a bit the load_balance so might be good to take
> > that into account
> >
>
> If I run the test in a cgroup, the load balance will only be performed
> on the cpuset rather than the whole system and the scan will be faster as
> the range narrowed. Is that the reason here?

I didn't have cgroup cpuset in mind but the fair group scheduling
which scans all cpus and adds more cfs level and impacts the
update_blocked_averages(). But the latter is not accounted for in the
cost of newidle_balance so it will not impact your tests.

That being said, we should account for this duration which can be
significant in some cases. I'm going to prepare a patch to add the
cost of update_blocked_averages() which can be significant in some
cases

>
> Thanks.
>
> >>
> >>>>
> >>>> The average cost of load balance seems quite smaller than the default sysctl_sched_migration_cost
> >>>> which is 500000(500ms).
> >>>
> >>> AFAICT, it is 500us not 500ms
> >>>
> >>
> >> yes it's 500us. sorry for the wrong unit.
> >>
> >>>>
> >>>> So I have some RFC questions:
> >>>> 1. how is the default 500000 (500ms) migration cost is measured or caculated?
> >>>
> >>> 500us not ms
> >>>
> >>> I would say that it's a heuristic value that works for most of system
> >>> but it should probably be tuned per platform. But also note that it's
> >>> quite difficult to get a correct value
> >>>
> >>
> >> thanks for the explanation. I agree that it should be tuned per platform, and maybe also
> >> per workload. Current default value seems to have be well tuned on x86 but not on the some
> >> arm64 platforms.
> >
> > Adjusting the value based on the platform seems reasonable although
> > i'm not sure which input should be used (arch type / interconnect
> > bandwidth / cache size / number of cpu per cache level ...)
> >
> >>
> >> Thanks.
> >>
> >>>>    The value has never changed in the past decade. I dig into the git commits and find it was introduced
> >>>>    in da84d9617672 ("sched: reintroduce cache-hot affinity"). But it didn't explain how did this value come.
> >>>> 2. The ABI now has been removed from sysctl and moved to debugfs. As tuning this can improve the performance
> >>>>    of some workloads on some platforms, maybe it's better to make it a formal sysctl again with docs?
> >>>>
> >>>> I'll be appreciated for any comments and replies!
> >>>>
> >>>> Thanks,
> >>>> Yicong
> >>>>
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>
