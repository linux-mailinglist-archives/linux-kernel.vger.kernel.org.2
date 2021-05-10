Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7470379392
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhEJQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhEJQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:18:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:17:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so24237270lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb4DlGR/i/vGPSzmEOrBRlFg7YKe0dBnbuQr4d2fYfg=;
        b=yD5/ekHuS9M97NQxNzshFolSnsmpqcxwHzviBCecBL68b48HCmWgdiYbUh2cYMCuD1
         5ikZk6BArqS7Hg9FK5KoDjOz5RRR6P5ygr3deiReExwbAelzzfQguNi1KyReA8SkHi6Y
         obFD+kgnm2WpqbdaHi2JLdjdW9VkchXDozxxuQX8S/MsEuXPO+vj8LlxQSPBMC3DYjxv
         tmyy/VH60jZO4vGBBV1qiJxyCqjWxVIZ1BwHzjr/L5SaQOW9T+JSHI9pNtXVfobusQ8+
         yiHLBQ6mbTtN1o9DDKYRtY7XbJTbePlRKEY+wmyprLgrUJGPg7paBRFIhmFal6jidLQP
         SA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb4DlGR/i/vGPSzmEOrBRlFg7YKe0dBnbuQr4d2fYfg=;
        b=GnhBFNQrRWPJd8Q4pb2zEbc/Taw2vCLdos13JHqg7col/JXfMvVIHlsp4g4j8H6Gi8
         A7Zias/r/6y5dUAi3sHsmxxLtd7gvmPFM9j8b2zCza0Fdud3z1lBRnC6NICafdTKSMTf
         n40Ot3dsBLqllT7TU1Vk3AfpJ2Yewu/j26lh7EfBea6rlBIRAwwN6GRhASpRSEHCc+Vk
         S65Pcxt2zE1fQ+iMIWPtC/6yIcJ9D6J8vFgRurADWBfcZiP0g/HD/UZwVi2uHoNrGHSb
         XMRl9xJPJhsSN2cX1UR2x1KI5/TenCrHfni/XZXjE3U7ul7W6QZ2ZVrtexBqCQYQsg7H
         41ow==
X-Gm-Message-State: AOAM530MZ8Dps23fEFJbCGlpN0dodSrlYgDw4ZiyLwnZnbMvXctfkr/3
        vD24CL0J+EGnXcJyh3qoBMWxKper6Ftc8wITK+W4F7UomMIshw==
X-Google-Smtp-Source: ABdhPJydokeQLFxdw0DkwumIuLIx2fTobgJNT6OYhW0zuEOqxrQz1Z5vt7xN5+K78Gv4le5msf/S3GgaTcNtulzU4hs=
X-Received: by 2002:a05:6512:ac1:: with SMTP id n1mr17305698lfu.254.1620663422387;
 Mon, 10 May 2021 09:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org>
In-Reply-To: <20210422120459.447350175@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 May 2021 18:16:50 +0200
Message-ID: <CAKfTPtAtRYTVaqWtWEMYt82SwU54-Nj19WYvOyjZJv9jXVVJRA@mail.gmail.com>
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

Hi Peter,

On Thu, 22 Apr 2021 at 14:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hai,
>
> This is an agressive fold of all the core-scheduling work so far. I've stripped
> a whole bunch of tags along the way (hopefully not too many, please yell if you
> feel I made a mistake), including tested-by. Please retest.
>
> Changes since the last partial post is dropping all the cgroup stuff and
> PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> the cgroup issue.
>
> Since we're really rather late for the coming merge window, my plan was to
> merge the lot right after the merge window.
>
> Again, please test.

I have run various tests with your sched/core-sched branch on my arm64
machine: 2 numa * 28 cores * SMT4

List of tests:
perf sched pipe
hackbench process and threads with 1,4,16,32,64,128,256 groups
tbench with 1,4,16,32,64,128,256 groups
Unixbench shell and exec
reaim

core-sched was compiled but not used: CONFIG_SCHED_CORE=y

I haven't seen any regressions or problems; it's a mix of +/- 1-2%. I
have only seen one significant improvement for hackbench -g 1 (+4.92%)
that I don't really explain. Will dig a bit one this later

So Tested-by: Vincent Guittot <vincent.guitto@linaro.org>



>
> These patches should shortly be available in my queue.git.
>
> ---
>  b/kernel/sched/core_sched.c                     |  229 ++++++
>  b/tools/testing/selftests/sched/.gitignore      |    1
>  b/tools/testing/selftests/sched/Makefile        |   14
>  b/tools/testing/selftests/sched/config          |    1
>  b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
>  include/linux/sched.h                           |   19
>  include/uapi/linux/prctl.h                      |    8
>  kernel/Kconfig.preempt                          |    6
>  kernel/fork.c                                   |    4
>  kernel/sched/Makefile                           |    1
>  kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
>  kernel/sched/cpuacct.c                          |   12
>  kernel/sched/deadline.c                         |   38 -
>  kernel/sched/debug.c                            |    4
>  kernel/sched/fair.c                             |  276 +++++--
>  kernel/sched/idle.c                             |   13
>  kernel/sched/pelt.h                             |    2
>  kernel/sched/rt.c                               |   31
>  kernel/sched/sched.h                            |  393 ++++++++--
>  kernel/sched/stop_task.c                        |   14
>  kernel/sched/topology.c                         |    4
>  kernel/sys.c                                    |    5
>  tools/include/uapi/linux/prctl.h                |    8
>  23 files changed, 2057 insertions(+), 222 deletions(-)
>
