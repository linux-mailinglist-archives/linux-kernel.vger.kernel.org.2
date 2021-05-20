Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB838B0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhETOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbhETOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:05:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31561C06137B
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:01:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a10so6001616qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNm1bjmfsZbC69+bgr31wf7AQ2E2k62h3QcNqMqF8BY=;
        b=K5bQnKG8qYmvPQWsdgfTYKdpNdPVKUmmIaFV1R6k/0x3kmEGrGYBLCHtKgCs+bXVU0
         hYEFFtfUgiraqEJiflUErmW20VBtttdeMUOeZIyjmBiU+U7aXdicgZFJ0d6lbjbQbqNi
         D6yq78OMLiMB9xyqBddYEyGxTixn8I4fRy4W/fAqHO6kx5ex1+DJ5DcBhgIKFO3Rpeqh
         dkV3/X2U6zaR6lxDqtu7VHmkJzEIOrs9W5OlI9fgLJY0hg97Jrh0cD6gZJLqHk2PZaef
         iwWV4cIp0T6tunKMoXeDRBnFVFxvj8xQUWyGlLNZU7MAxTbE+eg8mPEmoOHtAI6Zhoyl
         ksnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNm1bjmfsZbC69+bgr31wf7AQ2E2k62h3QcNqMqF8BY=;
        b=rV57doD5z99Yg6OEr4YS+6xVN2rsReGmpBMsohRg1clb3HhrmQnjhjzbQ/vuwjcWwp
         F6I/ELo3ljjOPA8AjUsgYIOGt5ZNjzER/ThVQF9Q3fPB/0W9udln8HFRywpAZkr9zd4e
         j56esPNk6cVDeFUn9ptpJR6X0G+cDEVbx3A1144a1OHsqV7cbMTNU1T+DHK8A6GQ0SNx
         B1BAO25XlJSgtNxOVNWRl9eow8jsdQYZgee5tgAvwzp53XlkrZ0o4JPn1Mdf8GjqXN8p
         TccC9s7z241v30oxzZdmdE3WUe+DWrtKtt377jJkRX/8pbDi32rJdnZWXYYmzWnI2/NF
         qmhg==
X-Gm-Message-State: AOAM531X+qORgif78EsT/WNX0g1O5kGJURrLvon894Md3FABqZqXFMoN
        FQCr/LCvlr9szZsGqLYMzsv/21am6B+GIg/rv8KGOA==
X-Google-Smtp-Source: ABdhPJw7BSjP0aTZNtZ4cYsWOrOfBPRz9feofIo8M3P73WvDoYT9XpigMjYZ739N4vtooe97vu6/22zb+myniPRsl5Q=
X-Received: by 2002:ac8:45c2:: with SMTP id e2mr5510935qto.138.1621519265995;
 Thu, 20 May 2021 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com> <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
In-Reply-To: <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 20 May 2021 16:00:29 +0200
Message-ID: <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, pauld@redhead.com,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        shanpeic@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more thoughts and questions:

> The benefit of burst is seen when testing with schbench:
>
>         echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
>         echo 600000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>         echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
>         echo 400000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>
>         # The average CPU usage is around 500%, which is 200ms CPU time
>         # every 40ms.
>         ./schbench -m 1 -t 30 -r 10 -c 10000 -R 500
>
>         Without burst:
>
>         Latency percentiles (usec)
>         50.0000th: 7
>         75.0000th: 8
>         90.0000th: 9
>         95.0000th: 10
>         *99.0000th: 933
>         99.5000th: 981
>         99.9000th: 3068
>         min=0, max=20054
>         rps: 498.31 p95 (usec) 10 p99 (usec) 933 p95/cputime 0.10% p99/cputime 9.33%

It should be noted that this was running on a 64 core machine (if that was
the case, ref. your previous patch).

I am curious how much you have tried tweaking both the period and the quota
for this workload. I assume a longer period can help such bursty application,
and from the small slowdowns, a slightly higher quota could also help
I guess. I am
not saying this is a bad idea, but that we need to understand what it
fixes, and how,
in order to be able to understand how/if to use it.

Also, what value of the sysctl kernel.sched_cfs_bandwidth_slice_us are
you using?
What CONFIG_HZ you are using is also interesting, due to how bw is
accounted for.
There is some more info about it here: Documentation/scheduler/sched-bwc.rst. I
assume a smaller slice value may also help, and it would be interesting to see
what implications it gives. A high threads to (quota/period) ratio, together
with a high bandwidth_slice will probably cause some throttling, so one has
to choose between precision and overhead.

Also, here you give a burst of 66% the quota. Would that be a typical value
for a cgroup, or is it just a result of testing? As I understand this
patchset, your example
would allow 600% constant CPU load, then one period with 1000% load,
then another
"long set" of periods with 600% load. Have you discussed a way of limiting how
long burst can be "saved" before expiring?

> @@ -9427,7 +9478,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
>  {
>         struct task_group *tg = css_tg(seq_css(sf));
>
> -       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
> +       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
> +                              tg_get_cfs_burst(tg));
>         return 0;
>  }

The current cgroup v2 docs say the following:

>   cpu.max
>     A read-write two value file which exists on non-root cgroups.
>     The default is "max 100000".

This will become a "three value file", and I know a few user space projects
who parse this file by splitting on the middle space. I am not sure if they are
"wrong", but I don't think we usually break such things. Not sure what
Tejun thinks about this.

Thanks
Odin
