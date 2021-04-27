Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7936C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhD0Mpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhD0Mps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:45:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:45:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a13so14174141ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEm1bQ6boYn9sgOS7se993fi5zEhbGrHhlvchnybY1c=;
        b=ZOP3CuV9lm4JC9hbdhoneZV5TmJGTQ20+43Fum9sENKQjXmwR45lPpH2pS1VdEgW7o
         jpZjGn7f6hNmHXEGsPxFEcrI+Y4UpG/MVFzS3FkghOgUfFKhlPnOIsMYO18LFBwUD4Fp
         14CfnLN14sIuqpuACpr1uktBNYBKpxjmYVBVY/pNncs3TVldalChwmNE37FEbDej5/1W
         Fwd8OM6ZV/jt2UT69cN7Rc/hJcq5zzLXxxgTjz+1dnF+XqSB9ZKLG/Xmbbqore5sXSQe
         i/xsR0lNzZk1pXpDCzwNZIzuzkXjnCdyV6JtQFgjfZzSG6hHVYAtXaO6xcevQYlpxdFr
         cGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEm1bQ6boYn9sgOS7se993fi5zEhbGrHhlvchnybY1c=;
        b=WEZjmlUpFhsDAGjIoLJkgsUs1zoSxDppgEIk5I+Vz0zj2QSI3z0ozmB2vfGkv9h/X3
         5hRM29R42d7H2Y+14BtESPS2kxF1fzQhHI6h3AsLwo8SpLuQwfMPrUtynfuydNBeuYSG
         CZbd/NN52lv7u6tkM5j0+cQsycmV8Z9Pq2WP9/wlsiniogM+5udpxE1iYn2iGe3txx2h
         hzOUdZNcZenYzIUNo7C4UdsirFTHSijrqPISnE6i6xwFFp0yah0wupLDrwXeAzMXl0Qw
         /WQvjlAlTSWSzNY21E9K6huNjYS5XzyjFbsW1nqNu+buJ/vGTHDnxVkMTIYQVRxdQy+m
         tsWQ==
X-Gm-Message-State: AOAM533/k1j5DGc36P0n7kJh2MerRnNsskEGTClYnievPYa0OSvAR8nm
        946gTFGOR5ssM8BIwMnLsTtgGGOIS2prMm4h9xs1vQ==
X-Google-Smtp-Source: ABdhPJz4nD06WqG22LxTr5qqg6p1P9JYn7CA/1voVL9vrgN0Btux1M/e7ILM8YZP4PIcV0hwNpEM2KhJQaT3yf78xbM=
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr16523306lje.445.1619527502059;
 Tue, 27 Apr 2021 05:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <CAKfTPtBHm+CjBTA614P9F2Vx3Bj7vv9Pt0CGFsiwqcrTFmKzjg@mail.gmail.com>
 <CAFpoUr1FgZhuBmor2vCFqC9z7wao+XSybPxJZKFfK-wvZOagCA@mail.gmail.com>
 <CAKfTPtCdJC2-jxJn82Z4GSsHu0e49pKL4DT0GWk5vKXnyn1Gog@mail.gmail.com> <CAFpoUr2PmOzOfE4+zBP5HGzEypj-7BhStjUoCVChPt-yT_s2EA@mail.gmail.com>
In-Reply-To: <CAFpoUr2PmOzOfE4+zBP5HGzEypj-7BhStjUoCVChPt-yT_s2EA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Apr 2021 14:44:50 +0200
Message-ID: <CAKfTPtBnDsRcQNz3pA13KwakODYHBiS8XkAQMepOog1h5ocECA@mail.gmail.com>
Subject: Re: [PATCH 0/1] sched/fair: Fix unfairness caused by missing load decay
To:     Odin Ugedal <odin@ugedal.com>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 at 13:24, Odin Ugedal <odin@ugedal.com> wrote:
>
> Hi,
>
> > I wanted to say one v5.12-rcX version to make sure this is still a
> > valid problem on latest version
>
> Ahh, I see. No problem. :) Thank you so much for taking the time to
> look at this!
>
> > I confirm that I can see a ratio of 4ms vs 204ms running time with the
> > patch below.
>
> (I assume you talk about the bash code for reproducing, not the actual
> sched patch.)

yes sorry

>
> > But when I look more deeply in my trace (I have
> > instrumented the code), it seems that the 2 stress-ng don't belong to
> > the same cgroup but remained in cg-1 and cg-2 which explains such
> > running time difference.
>
> (mail reply number two to your previous mail might also help surface it)
>
> Not sure if I have stated it correctly, or if we are talking about the
> same thing. It _is_ the intention that the two procs should not be in the
> same cgroup. In the same way as people create "containers", each proc runs
> in a separate cgroup in the example. The issue is not the balancing
> between the procs
> themselves, but rather cgroups/sched_entities inside the cgroup hierarchy.
> (due to the fact that the vruntime of those sched_entities end up
> being calculated with more load than they are supposed to).
>
> If you have any thought about the phrasing of the patch itself to make it
> easier to understand, feel free to suggest.
>
> Given the last cgroup v1 script, I get this:
>
> - cat /proc/<stress-pid-1>/cgroup | grep cpu
> 11:cpu,cpuacct:/slice/cg-1/sub
> 3:cpuset:/slice
>
> - cat /proc/<stress-pid-2>/cgroup | grep cpu
> 11:cpu,cpuacct:/slice/cg-2/sub
> 3:cpuset:/slice
>
>
> The cgroup hierarchy will then roughly be like this (using cgroup v2 terms,
> becuase I find them easier to reason about):
>
> slice/
>   cg-1/
>     cpu.shares: 100
>     sub/
>       cpu.weight: 1
>       cpuset.cpus: 1
>       cgroup.procs - stress process 1 here
>   cg-2/
>     cpu.weight: 100
>     sub/
>       cpu.weight: 10000
>       cpuset.cpus: 1
>       cgroup.procs - stress process 2 here
>
> This should result in 50/50 due to the fact that cg-1 and cg-2 both have a
> weight of 100, and "live" inside the /slice cgroup. The inner weight should not
> matter, since there is only one cgroup at that level.
>
> > So your script doesn't reproduce the bug you
> > want to highlight. That being said, I can also see a diff between the
> > contrib of the cpu0 in the tg_load. I'm going to look further
>
> There can definitely be some other issues involved, and I am pretty sure
> you have way more knowledge about the scheduler than me... :) However,
> I am pretty sure that it is in fact showing the issue I am talking about,
> and applying the patch does indeed make it impossible to reproduce it
> on my systems.

Your script is correct. I was wrongly interpreting my trace. I have
been able to reproduce your problem and your analysis is correct. Let
me continue on the patch itself

>
> Odin
