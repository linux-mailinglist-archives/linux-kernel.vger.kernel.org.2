Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64240F665
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhIQLAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhIQLAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:00:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:59:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v22so24224222edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s//0d7Cj3OD9+gEt4FtNSO+EEyVbGsw9O64iurzqSXw=;
        b=Y3KEkXsxwNqgNvWq/b/b0ARtJDK4LV/8UlbfmgGXY+xNMmz1gp5ObrC8CKGepJyn8W
         WeTD37Op9TmZxeVkwniDVbFaJ2oXzSQ0FTL+ZJWlosZYzML9veTD5qmXKFolchF3Lufo
         fJWSLyxJ+qukHRdvsHxbSUBR4HzOngjBV03RsZCSd7RYBmoSui4c9zP2lo0Ih5GgSA/T
         yn6ZORgDNxBM3z3vzxcMMsgHfDAmOWLNOGpioodNd1zroiVGeXJAgD21Vzbv+5vOcS0N
         qsLjbG+wBWOpO+fj0mkJq1YXNZ6QG3lbcIecN4mhuil9WxSIruOLqTRcL3aT75KBrsNx
         LXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s//0d7Cj3OD9+gEt4FtNSO+EEyVbGsw9O64iurzqSXw=;
        b=KjVcwDAbY0vdpM/Uh/NTPsd7Sa1e3FqRSCIjRaNJcCc5Wd9UI0acDJPMPfnhKOVgFY
         0OWlWCEh9vuHQR868YSaf08W5xxAGh4sF3kFv9NOgutVcYrpu4aUqlgnl/80WFl+MrpT
         BP23XO1sKt+vyuM2H0kcPiMfaXcS91hkBmAU5AHRv2smKR8PSSx9h/djXgVzk/YnH/7f
         BLHyZIfRmQsEeDT8vQux3O+wrz1kI52+xJMCTSNkRr0x3ZW+ahR0Qx8f9CamPvhsL61K
         0y+Q/0hUVtwwUxyGdQs+u2/srLJ1JUUqI5XMqIRS5OCthDrS1sbzLUR3GYQtPgrknJ5J
         4U2w==
X-Gm-Message-State: AOAM530s7jTOg3kC3/E616wJhOfRoaEWmmWuabCnmZvLyQWfOMVL1KAv
        Ib63XpF95i+TYRLr0bYR8ZsfCB9sNZOhITeDVko=
X-Google-Smtp-Source: ABdhPJzvw6Y93PzS7e2SCv+gvDMgpKLG4EoozZmxvXQX/x4V02hLL8XmAMZUEF/qGEeBaE3SVq20xiCVN5dq3HAs6gw=
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr11587495edo.167.1631876365190;
 Fri, 17 Sep 2021 03:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
 <CAKfTPtDJip17rdZ0CMDwUztE7BGUF+J_O2Up=S5GLYrqtkA67A@mail.gmail.com>
 <d9ada2d4-1967-7b80-68e0-ef7052c41e0f@hisilicon.com> <CAKfTPtBv3TAJvKayn73yenJGmqchObXDWMm2Kxj0ixL8E0GUGA@mail.gmail.com>
In-Reply-To: <CAKfTPtBv3TAJvKayn73yenJGmqchObXDWMm2Kxj0ixL8E0GUGA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 17 Sep 2021 22:59:13 +1200
Message-ID: <CAGsJ_4wnoUCbnWgJEMnZhsCx54aCN--r=hibaVFpMeW19nKe-w@mail.gmail.com>
Subject: Re: [RFC] Perfomance varies according to sysctl_sched_migration_cost
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        prime.zeng@huawei.com,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 12:55 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 14 Sept 2021 at 14:08, Yicong Yang <yangyicong@hisilicon.com> wrote:
> >
> > Hi Vincent,
> >
> > thanks for the reply!
> >
> > On 2021/9/14 17:04, Vincent Guittot wrote:
> > > Hi Yicong,
> > >
> > > On Tue, 14 Sept 2021 at 09:27, Yicong Yang <yangyicong@hisilicon.com> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> I noticed that some benchmark performance varies after tunning the sysctl_sched_migration_cost
> > >> through /sys/kernel/debug/sched/migration_cost_ns on arm64. The default value is 500000, and
> > >> I tried 10000, 100000, 1000000. Below are some results from mmtests, based on 5.14-release.
> > >>
> > >> On Kunpeng920 (128cores, 4numa, 2socket):
> > >>
> > >> pgbench (config-db-pgbench-timed-ro-medium)
> > >>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> > >> Hmean     1       9558.99 (   0.00%)     9735.31 *   1.84%*     9410.84 *  -1.55%*     9602.47 *   0.45%*
> > >> Hmean     8      17615.90 (   0.00%)    17439.78 *  -1.00%*    18056.44 *   2.50%*    19222.18 *   9.12%*
> > >> Hmean     12     25228.38 (   0.00%)    25592.69 *   1.44%*    26739.06 *   5.99%*    27575.48 *   9.30%*
> > >> Hmean     24     46623.27 (   0.00%)    48853.30 *   4.78%*    47386.02 *   1.64%*    48542.94 *   4.12%*
> > >> Hmean     32     60578.78 (   0.00%)    62116.81 *   2.54%*    59961.36 *  -1.02%*    58681.07 *  -3.13%*
> > >> Hmean     48     68159.12 (   0.00%)    67867.90 (  -0.43%)    65631.79 *  -3.71%*    66487.16 *  -2.45%*
> > >> Hmean     80     66894.87 (   0.00%)    73440.92 *   9.79%*    68751.63 *   2.78%*    67326.70 (   0.65%)
> > >> Hmean     112    68582.27 (   0.00%)    65339.90 *  -4.73%*    68454.99 (  -0.19%)    67211.66 *  -2.00%*
> > >> Hmean     144    76290.98 (   0.00%)    70455.65 *  -7.65%*    64851.23 * -14.99%*    64940.61 * -14.88%*
> > >> Hmean     172    63245.68 (   0.00%)    68790.24 *   8.77%*    66246.46 *   4.74%*    69536.96 *   9.95%*
> > >> Hmean     204    61793.47 (   0.00%)    63711.62 *   3.10%*    66055.64 *   6.90%*    58023.20 *  -6.10%*
> > >> Hmean     236    61486.75 (   0.00%)    68404.44 *  11.25%*    70499.70 *  14.66%*    58285.67 *  -5.21%*
> > >> Hmean     256    57476.13 (   0.00%)    65645.83 *  14.21%*    69437.05 *  20.81%*    60518.05 *   5.29%*
> > >>
> > >> tbench (config-network-tbench)
> > >>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> > >> Hmean     1        333.12 (   0.00%)      332.93 (  -0.06%)      335.34 *   0.67%*      334.36 *   0.37%*
> > >> Hmean     2        665.88 (   0.00%)      667.19 *   0.20%*      666.47 *   0.09%*      667.02 *   0.17%*
> > >> Hmean     4       1324.10 (   0.00%)     1312.23 *  -0.90%*     1313.07 *  -0.83%*     1315.13 *  -0.68%*
> > >> Hmean     8       2618.85 (   0.00%)     2602.00 *  -0.64%*     2577.49 *  -1.58%*     2600.48 *  -0.70%*
> > >> Hmean     16      5100.74 (   0.00%)     5068.80 *  -0.63%*     5041.34 *  -1.16%*     5069.78 *  -0.61%*
> > >> Hmean     32      8157.22 (   0.00%)     8163.50 (   0.08%)     7936.25 *  -2.71%*     8329.18 *   2.11%*
> > >> Hmean     64      4824.56 (   0.00%)     4890.81 *   1.37%*     5319.97 *  10.27%*     4830.68 *   0.13%*
> > >> Hmean     128     4635.17 (   0.00%)     6810.90 *  46.94%*     5304.36 *  14.44%*     4516.06 *  -2.57%*
> > >> Hmean     256     8816.62 (   0.00%)     8851.28 *   0.39%*     8448.76 *  -4.17%*     6840.12 * -22.42%*
> > >> Hmean     512     7825.56 (   0.00%)     8538.04 *   9.10%*     8002.77 *   2.26%*     7946.54 *   1.55%*
> > >>
> > >> Also on Raspberrypi 4B:
> > >>
> > >> pgbench (config-db-pgbench-timed-ro-medium)
> > >>                    mig-cost-500000        mig-cost-100000
> > >> Hmean     1     1651.41 (   0.00%)     3444.27 * 108.56%*
> > >> Hmean     4     4015.83 (   0.00%)     6883.21 *  71.40%*
> > >> Hmean     7     4161.45 (   0.00%)     6646.18 *  59.71%*
> > >> Hmean     8     4277.28 (   0.00%)     6764.60 *  58.15%*
> > >>
> > >> For tbench on Raspberrypi 4B and both pgbench and tbench on x86, tuning sysctl_sched_migration_cost
> > >> doesn't have such huge difference and will have some degradations (max -8% on x86 for pgbench) in some cases.
> > >>
> > >> The sysctl_sched_migration_cost will affects the frequency of load balance. It will affect
> > >
> > > So it doesn't affect the periodic load but only the newly idle load balance
> > >
> >
> > In load_balance(), it's used to judge whether a task is hot in task_hot(). so I think it
> > participates in the periodic load balance.
>
> Not really. The periodic load balance always happens but task_hot is
> used to skip task that have recently run on the cpu and select older
> tasks instead
> At the contrary, sysctl_sched_migration_cost is used to decide if we
> should abort newly_idle_load_balance
>
> As a side point, would be good to know if the improvement and
> regression seen in your tests are more linked to the task hotness or
> for  skipping/aborting newly idle load balance
>
> >
> > >> directly in task_hot() and newidle_balance() to decide whether we can do a migration or load
> > >> balance. And affects other parameters like rq->avg_idle, rq->max_idle_balance_cost and
> > >> sd->max_newidle_lb_cost to indirectly affect the load balance process. These parameters record
> > >> the load_balance() cost and will be limited up to sysctl_sched_migration_cost, so I measure
> > >> the average cost of load_balance() on Kunpeng920 with bcc tools(./funclantency load_balance -d 10):
> > >>
> > >> system status   idle   50%load  100%load
> > >> avg cost      3160ns    4790ns    7563ns
> > >
> > > What is the setup of your test ? has this been measured during the
> > > benchmarks above ?
> > >
> >
> > I use stress-ng to generate the load. Since it's a 128core server, `stress-ng -c 64` for
> > 50% load, and `stress-ng -c 128` for 100% load. This is not measured during the benchmarks'
> > process.
>
> I don't think this is the best benchmark to evaluate the real cost of
> load_balance because it create always running task and  you measure
> only the periodic load balance and not the newly load balance which is
> the one really impacted by sysctl_sched_migration_cost
>
> >
> > > Also, do you have more details about  the topology and the number of
> > > sched domain ?
> > >
> >
> > sure. for `numactl -H`:
> >
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> > node 0 size: 257149 MB
> > node 0 free: 253518 MB
> > node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> > node 1 size: 193531 MB
> > node 1 free: 192916 MB
> > node 2 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> > node 2 size: 96763 MB
> > node 2 free: 92654 MB
> > node 3 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> > node 3 size: 127668 MB
> > node 3 free: 125846 MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  12  20  22
> >   1:  12  10  22  24
> >   2:  20  22  10  12
> >   3:  22  24  12  10
> >
> > Kunpeng 920 is non-smt. There're 4 level domains and below is part of the /proc/schedstat:
> > [...]
> > cpu0
> > domain0 00000000,00000000,00000000,ffffffff
> > domain1 00000000,00000000,ffffffff,ffffffff
> > domain2 00000000,ffffffff,ffffffff,ffffffff
> > domain3 ffffffff,ffffffff,ffffffff,ffffffff
>
> Because of the large difference between the number of cpus at 1st and
> last level, an average duration of load_balance() is not really
> meaningful and we can expect a factor of 4 between smallest and larger
> one

I also think measuring the funclatency of load_balance() might not be the
proper way to estimate the cost of migration considering it might iterate
over several levels of domains:

        for_each_domain(this_cpu, sd) {
                int continue_balancing = 1;
                u64 t0, domain_cost;

                if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
                        update_next_balance(sd, &next_balance);
                        break;
                }

                if (sd->flags & SD_BALANCE_NEWIDLE) {
                        t0 = sched_clock_cpu(this_cpu);

                        pulled_task = load_balance(this_cpu, this_rq,
                                                   sd, CPU_NEWLY_IDLE,
                                                   &continue_balancing);

                        domain_cost = sched_clock_cpu(this_cpu) - t0;
                        if (domain_cost > sd->max_newidle_lb_cost)
                                sd->max_newidle_lb_cost = domain_cost;

                        curr_cost += domain_cost;
                }

                update_next_balance(sd, &next_balance);

                /*
                 * Stop searching for tasks to pull if there are
                 * now runnable tasks on this rq.
                 */
                if (pulled_task || this_rq->nr_running > 0 ||
                    this_rq->ttwu_pending)
                        break;
        }

maybe worth adding some tracepoints at the start and the end of the
whole balance
procedure.

But even if we can get the avg, min and max figures afterwards, is it
really reasonable
to set the migration_cost according to the figure? migration cost
isn't only moving a
task, pulling a task from remote numa might mean huge cache coherence overhead.

I feel a couple of factors will determine the best sched_migration_cost:
1. hardware topology - how many sched levels, how many numas, how far
numa nodes are
2. cache coherence overhead between cpus in different topology
3. how fast each cpu is
4. if tasks are pinning numa, this might scale down/up the range LB
needs to be done
5. relax_domain_level bootargs
...

Thanks
barry
