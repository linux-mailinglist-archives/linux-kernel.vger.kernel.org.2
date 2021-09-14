Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3740AA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhINJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhINJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:05:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:04:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k65so26615990yba.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8jSKhRwSkEFgva+PjLfSkV5IjychoxopGAIBkdt7R8=;
        b=DdUuNTaSrb0M3e4Xn2BipAtjFe/r/93MAYgvxeFrgMkK9I4Sehm0DddzGi7zb3H8Xw
         8TRcQGivs/OGljhVLjlZ85g7gErdRIjNUqu2Zf9nrJhSC4UtSIZqUv2UYKMVhuan0GrH
         cTs+Q0ve+SEbmxuiwYhpv/BDi9M40fxG4BqGDd5rqOFhIPUsBT/U+TlGcX2o5IhFUgnk
         cccufRzW9OLSlCAS2YwJTHtpVn6pepcw2Z0cdhkSh4xrNqsD8iqaHe2eRpA5rztaom2z
         AvYzZBfBFSGAYZfXPVw0i89ZE8h25hRd8oq00i3gl1W9M+kPre7OCbrmORwMxzneUtPt
         4Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8jSKhRwSkEFgva+PjLfSkV5IjychoxopGAIBkdt7R8=;
        b=69uS8d9Pgq501IFJn3Dm61faKqEkyxg7JjDHI7a95MbFL0CvuKHDx6KsX7ItUZ4Rg7
         Y5uarIKo2BjWGhzwMc065EGcpyLHL1kkxheNbkFjzvAH+es3G1mnYqSdw2PuRGMhxW5T
         SYzyPbzVkyffaRmsiktvfmPfxAZ8V4rRYmj3ofUk9KIHrd75I7fX2ubW6Mpl3DbkXQol
         RYVvAU41Me4HOdNJYGjUhwaSnP7Vp9K7lBOtyRFzXJ0xShQkSykHooZKKVcsfzc7xJNz
         O67ieN0lDbktvKcCNtcUQ6Lbj2M7i8qsPvrDaVP/NKZ0sWPjElGhv//uhAThPSyDFqCX
         3bHA==
X-Gm-Message-State: AOAM530BHa8ouGraeDC3hfEoiVGeCTT331OkSSTNKPUIdganeGUsd2EP
        RehyPXIcL3E600f0hFiaJxRLfV0yFsJNIV1c22+FCg==
X-Google-Smtp-Source: ABdhPJyiV0oHW3uXMpVuLfHC4uinOyCFZoclQPJ/QRlJgLm1PXjPsGn/DHxHPkR448N0jFEybrDMBabFvudGmjNz3SI=
X-Received: by 2002:a25:c753:: with SMTP id w80mr20893601ybe.245.1631610254194;
 Tue, 14 Sep 2021 02:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
In-Reply-To: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Sep 2021 11:04:03 +0200
Message-ID: <CAKfTPtDJip17rdZ0CMDwUztE7BGUF+J_O2Up=S5GLYrqtkA67A@mail.gmail.com>
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

Hi Yicong,

On Tue, 14 Sept 2021 at 09:27, Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Hi all,
>
> I noticed that some benchmark performance varies after tunning the sysctl_sched_migration_cost
> through /sys/kernel/debug/sched/migration_cost_ns on arm64. The default value is 500000, and
> I tried 10000, 100000, 1000000. Below are some results from mmtests, based on 5.14-release.
>
> On Kunpeng920 (128cores, 4numa, 2socket):
>
> pgbench (config-db-pgbench-timed-ro-medium)
>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> Hmean     1       9558.99 (   0.00%)     9735.31 *   1.84%*     9410.84 *  -1.55%*     9602.47 *   0.45%*
> Hmean     8      17615.90 (   0.00%)    17439.78 *  -1.00%*    18056.44 *   2.50%*    19222.18 *   9.12%*
> Hmean     12     25228.38 (   0.00%)    25592.69 *   1.44%*    26739.06 *   5.99%*    27575.48 *   9.30%*
> Hmean     24     46623.27 (   0.00%)    48853.30 *   4.78%*    47386.02 *   1.64%*    48542.94 *   4.12%*
> Hmean     32     60578.78 (   0.00%)    62116.81 *   2.54%*    59961.36 *  -1.02%*    58681.07 *  -3.13%*
> Hmean     48     68159.12 (   0.00%)    67867.90 (  -0.43%)    65631.79 *  -3.71%*    66487.16 *  -2.45%*
> Hmean     80     66894.87 (   0.00%)    73440.92 *   9.79%*    68751.63 *   2.78%*    67326.70 (   0.65%)
> Hmean     112    68582.27 (   0.00%)    65339.90 *  -4.73%*    68454.99 (  -0.19%)    67211.66 *  -2.00%*
> Hmean     144    76290.98 (   0.00%)    70455.65 *  -7.65%*    64851.23 * -14.99%*    64940.61 * -14.88%*
> Hmean     172    63245.68 (   0.00%)    68790.24 *   8.77%*    66246.46 *   4.74%*    69536.96 *   9.95%*
> Hmean     204    61793.47 (   0.00%)    63711.62 *   3.10%*    66055.64 *   6.90%*    58023.20 *  -6.10%*
> Hmean     236    61486.75 (   0.00%)    68404.44 *  11.25%*    70499.70 *  14.66%*    58285.67 *  -5.21%*
> Hmean     256    57476.13 (   0.00%)    65645.83 *  14.21%*    69437.05 *  20.81%*    60518.05 *   5.29%*
>
> tbench (config-network-tbench)
>                      mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
> Hmean     1        333.12 (   0.00%)      332.93 (  -0.06%)      335.34 *   0.67%*      334.36 *   0.37%*
> Hmean     2        665.88 (   0.00%)      667.19 *   0.20%*      666.47 *   0.09%*      667.02 *   0.17%*
> Hmean     4       1324.10 (   0.00%)     1312.23 *  -0.90%*     1313.07 *  -0.83%*     1315.13 *  -0.68%*
> Hmean     8       2618.85 (   0.00%)     2602.00 *  -0.64%*     2577.49 *  -1.58%*     2600.48 *  -0.70%*
> Hmean     16      5100.74 (   0.00%)     5068.80 *  -0.63%*     5041.34 *  -1.16%*     5069.78 *  -0.61%*
> Hmean     32      8157.22 (   0.00%)     8163.50 (   0.08%)     7936.25 *  -2.71%*     8329.18 *   2.11%*
> Hmean     64      4824.56 (   0.00%)     4890.81 *   1.37%*     5319.97 *  10.27%*     4830.68 *   0.13%*
> Hmean     128     4635.17 (   0.00%)     6810.90 *  46.94%*     5304.36 *  14.44%*     4516.06 *  -2.57%*
> Hmean     256     8816.62 (   0.00%)     8851.28 *   0.39%*     8448.76 *  -4.17%*     6840.12 * -22.42%*
> Hmean     512     7825.56 (   0.00%)     8538.04 *   9.10%*     8002.77 *   2.26%*     7946.54 *   1.55%*
>
> Also on Raspberrypi 4B:
>
> pgbench (config-db-pgbench-timed-ro-medium)
>                    mig-cost-500000        mig-cost-100000
> Hmean     1     1651.41 (   0.00%)     3444.27 * 108.56%*
> Hmean     4     4015.83 (   0.00%)     6883.21 *  71.40%*
> Hmean     7     4161.45 (   0.00%)     6646.18 *  59.71%*
> Hmean     8     4277.28 (   0.00%)     6764.60 *  58.15%*
>
> For tbench on Raspberrypi 4B and both pgbench and tbench on x86, tuning sysctl_sched_migration_cost
> doesn't have such huge difference and will have some degradations (max -8% on x86 for pgbench) in some cases.
>
> The sysctl_sched_migration_cost will affects the frequency of load balance. It will affect

So it doesn't affect the periodic load but only the newly idle load balance

> directly in task_hot() and newidle_balance() to decide whether we can do a migration or load
> balance. And affects other parameters like rq->avg_idle, rq->max_idle_balance_cost and
> sd->max_newidle_lb_cost to indirectly affect the load balance process. These parameters record
> the load_balance() cost and will be limited up to sysctl_sched_migration_cost, so I measure
> the average cost of load_balance() on Kunpeng920 with bcc tools(./funclantency load_balance -d 10):
>
> system status   idle   50%load  100%load
> avg cost      3160ns    4790ns    7563ns

What is the setup of your test ? has this been measured during the
benchmarks above ?

Also, do you have more details about  the topology and the number of
sched domain ?

Are you using cgroup hierarchy ?

>
> The average cost of load balance seems quite smaller than the default sysctl_sched_migration_cost
> which is 500000(500ms).

AFAICT, it is 500us not 500ms

>
> So I have some RFC questions:
> 1. how is the default 500000 (500ms) migration cost is measured or caculated?

500us not ms

I would say that it's a heuristic value that works for most of system
but it should probably be tuned per platform. But also note that it's
quite difficult to get a correct value

>    The value has never changed in the past decade. I dig into the git commits and find it was introduced
>    in da84d9617672 ("sched: reintroduce cache-hot affinity"). But it didn't explain how did this value come.
> 2. The ABI now has been removed from sysctl and moved to debugfs. As tuning this can improve the performance
>    of some workloads on some platforms, maybe it's better to make it a formal sysctl again with docs?
>
> I'll be appreciated for any comments and replies!
>
> Thanks,
> Yicong
>
>
