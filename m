Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4F37A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhEKHBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:01:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:00:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x20so27104359lfu.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5ft0YSy4kj6wIj5VldvZNqp+3H2AbvtK8HaLIpvSNo=;
        b=vjHyDEy0ZrVvThr49L7inlD0/vvWJc4+qE7s/WZIUKF9Ce3Yxg7jWYeGU/2UHs2+oL
         E/aCXZKJA54YDYCQTfPNBAVQOsofiyIKU9MoYF9hHt98/F2p1ZIzZ3ojNiwRPytZ/x/s
         Ek4moVZTp21XiP2K59a1L5OX54U/LeJYqlverj9zpiBLw6jYsaghvedM4hsV6+emgugy
         vUPyzLnZHT4bxl3wVV2AkyZsqpPv8N72dutozuhblSXfbtSWvCMZUJVVvAdZLr/LohKv
         eJCrH8yo55cHxvkLsBAjW1TJ2jspZA39Pu5lzhV0T8P4/toG4P1b01yXREEc74g5gL6l
         LKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5ft0YSy4kj6wIj5VldvZNqp+3H2AbvtK8HaLIpvSNo=;
        b=J0zehQzmNtfHENtvMEvRyH6GHwHkPMV+m3diq6FSHXq1dSraaskK3/8N5pOH1f9jUW
         5H6O1fqAQgUJbgGn+I/qkY1xw4hRyFPKWwtOuXtYvNEuLkFx5pOLzx70fOHrCD2OuteV
         rKJtOXeq9moQKbaNnTOHzbZHUfElQkLak0t/gijt1j7YaUuVTgrzQAmzZszHul36p2DI
         DFf3Se6SUNCOdHyseX+2m+bzOTSD3hhw1iFevyDdIHGezUiYQUPhPg/gHD6QUFN1BIan
         W6cxRxKQfmhxsn1gEBytuWOgUHn1CSw20BIBs4CWh43nhyOJYQk2n9Dqr3z3/8VqGkss
         ry3A==
X-Gm-Message-State: AOAM5317lxz8C8cW73gwhNSDT9A+fLB3OrsxtN6lV7fCupfdNAHjDr61
        7T8nlCjb3SRaveyrRF/w9E7RV7dKQr8qRoojvs2RzQ==
X-Google-Smtp-Source: ABdhPJwN3arht1/zSdGfMi25spAMxPxPZ2fh65688ocE7tj+vbJkL+i+NLPGjTN4AzZuWklWbliwNW0AJHFVzG7Nksg=
X-Received: by 2002:a05:6512:ac1:: with SMTP id n1mr19624726lfu.254.1620716424023;
 Tue, 11 May 2021 00:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <CAKfTPtAtRYTVaqWtWEMYt82SwU54-Nj19WYvOyjZJv9jXVVJRA@mail.gmail.com>
In-Reply-To: <CAKfTPtAtRYTVaqWtWEMYt82SwU54-Nj19WYvOyjZJv9jXVVJRA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 May 2021 09:00:12 +0200
Message-ID: <CAKfTPtBLr9bk68q7cuFOhYfKYvigGaB+TEeGzU_p4egQXq2gLA@mail.gmail.com>
Subject: Re: [PATCH 00/19] sched: Core Scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 18:16, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Peter,
>
> On Thu, 22 Apr 2021 at 14:36, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hai,
> >
> > This is an agressive fold of all the core-scheduling work so far. I've stripped
> > a whole bunch of tags along the way (hopefully not too many, please yell if you
> > feel I made a mistake), including tested-by. Please retest.
> >
> > Changes since the last partial post is dropping all the cgroup stuff and
> > PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> > the cgroup issue.
> >
> > Since we're really rather late for the coming merge window, my plan was to
> > merge the lot right after the merge window.
> >
> > Again, please test.
>
> I have run various tests with your sched/core-sched branch on my arm64
> machine: 2 numa * 28 cores * SMT4
>
> List of tests:
> perf sched pipe
> hackbench process and threads with 1,4,16,32,64,128,256 groups
> tbench with 1,4,16,32,64,128,256 groups
> Unixbench shell and exec
> reaim
>
> core-sched was compiled but not used: CONFIG_SCHED_CORE=y
>
> I haven't seen any regressions or problems; it's a mix of +/- 1-2%. I
> have only seen one significant improvement for hackbench -g 1 (+4.92%)
> that I don't really explain. Will dig a bit one this later
>
> So Tested-by: Vincent Guittot <vincent.guitto@linaro.org>

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

With the correct email address

>
>
>
> >
> > These patches should shortly be available in my queue.git.
> >
> > ---
> >  b/kernel/sched/core_sched.c                     |  229 ++++++
> >  b/tools/testing/selftests/sched/.gitignore      |    1
> >  b/tools/testing/selftests/sched/Makefile        |   14
> >  b/tools/testing/selftests/sched/config          |    1
> >  b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
> >  include/linux/sched.h                           |   19
> >  include/uapi/linux/prctl.h                      |    8
> >  kernel/Kconfig.preempt                          |    6
> >  kernel/fork.c                                   |    4
> >  kernel/sched/Makefile                           |    1
> >  kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
> >  kernel/sched/cpuacct.c                          |   12
> >  kernel/sched/deadline.c                         |   38 -
> >  kernel/sched/debug.c                            |    4
> >  kernel/sched/fair.c                             |  276 +++++--
> >  kernel/sched/idle.c                             |   13
> >  kernel/sched/pelt.h                             |    2
> >  kernel/sched/rt.c                               |   31
> >  kernel/sched/sched.h                            |  393 ++++++++--
> >  kernel/sched/stop_task.c                        |   14
> >  kernel/sched/topology.c                         |    4
> >  kernel/sys.c                                    |    5
> >  tools/include/uapi/linux/prctl.h                |    8
> >  23 files changed, 2057 insertions(+), 222 deletions(-)
> >
