Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136FD40D0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhIPAUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhIPAUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:20:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DCC061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:19:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z94so10020310ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0mVJdgPVSe+iYPghtsbmJkGCwsDgWSqxjc6SHi85z0=;
        b=HiYNra6eaBy+1vINAszO+g/UE/KGjSFMmqrp49MVWg08qLyrrYpwCvIa7Wjbs/jTa8
         UIiYhwzlX8VRfgwPbz4TDGhtHgXsHrdTq6lLDehHs7EU83vIX15/gyMviejP9fRkG6tI
         pOx6IJsarjpSrXDbVk8B0Yj2piASOsBm+KXSZNodL2RYEaV3/IGtd1yzElQ0ZrS0jIgx
         jvHEPBNQ6JpNwGyk7UMRoK0nBdvX3LIyScwg/pjjtYc5zrcpxO/4fN9F7Xiwq06VdMXO
         BKdU/gbpXSPyG1AyU9LDqMmSzrmmnB3tNqigXBWW/MPpTyYfPCIMCMy22ta0N8p8GBWJ
         YIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0mVJdgPVSe+iYPghtsbmJkGCwsDgWSqxjc6SHi85z0=;
        b=ltA/U4uuonESd0jM4ZqOu9LoLEoKMs/VDJThz+iAglqgcLLXz8V3yuMMV8wQ7WgrFM
         Qxlhj2RFd4OIqVWLWDHqi9QtJe0ohYlsIKD1JcA/1mIh7P6GNvkQ4Jjz3/a17pmyx2Rb
         Wco3ErDi5shfFJnhfeeQyRZxR1gqqduWfc2Gsy+o2X7Cm8SEO19ggTzoxG+n2Q7XmzWW
         bhYDrMzKFHQnhS+D4CMs+mhAvS9PiTcbOF0YoiBIGtNSQ5+pt9EAGkQQmhwN2DNMFEQN
         Vo2iouOYJ/Zf+3MnlnKA5qBnSPpDx5AMIX+hLf2IMTG9E8W1YGK8BCZiSV35A2QlYG2H
         m0Yw==
X-Gm-Message-State: AOAM532Dml8ARD/18mqz/FBP+0ZGY+G6CIE9gzjhNgVuT6ytyxFqGh69
        gAEAe0MwfmABagep4JEmpEAH5Dzlv/Tw8J0GVedBkA==
X-Google-Smtp-Source: ABdhPJz5p8eEDM1jXV8oIdEr+s1DrUFc7KSRytGqD9y8Sksy+yYySiwmyuTAjzZ0AfF4bUZhiQFlrBxwkjE7v0d1Ml8=
X-Received: by 2002:a05:6402:3459:: with SMTP id l25mr3086422edc.55.1631751554949;
 Wed, 15 Sep 2021 17:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210915213550.3696532-1-guro@fb.com>
In-Reply-To: <20210915213550.3696532-1-guro@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 15 Sep 2021 17:19:03 -0700
Message-ID: <CA+khW7i460ey-UFzpMSJ8AP9QeD8ufa4FzLA4PQckNP00ShQSw@mail.gmail.com>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barret Rhoden <brho@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Wed, Sep 15, 2021 at 3:04 PM Roman Gushchin <guro@fb.com> wrote:
>
> There is a long history of distro people, system administrators, and
> application owners tuning the CFS settings in /proc/sys, which are now
> in debugfs. Looking at what these settings actually did, it ended up
> boiling down to changing the likelihood of task preemption, or
> disabling it by setting the wakeup_granularity_ns to more than half of
> the latency_ns. The other settings didn't really do much for
> performance.
>
> In other words, some our workloads benefit by having long running tasks
> preempted by tasks handling short running requests, and some workloads
> that run only short term requests which benefit from never being preempted.
>
> This leads to a few observations and ideas:
> - Different workloads want different policies. Being able to configure
>   the policy per workload could be useful.
> - A workload that benefits from not being preempted itself could still
>   benefit from preempting (low priority) background system tasks.
> - It would be useful to quickly (and safely) experiment with different
>   policies in production, without having to shut down applications or reboot
>   systems, to determine what the policies for different workloads should be.
> - Only a few workloads are large and sensitive enough to merit their own
>   policy tweaks. CFS by itself should be good enough for everything else,
>   and we probably do not want policy tweaks to be a replacement for anything
>   CFS does.
>
> This leads to BPF hooks, which have been successfully used in various
> kernel subsystems to provide a way for external code to (safely)
> change a few kernel decisions. BPF tooling makes this pretty easy to do,
> and the people deploying BPF scripts are already quite used to updating them
> for new kernel versions.
>
> This patchset aims to start a discussion about potential applications of BPF
> to the scheduler. It also aims to land some very basic BPF infrastructure
> necessary to add new BPF hooks to the scheduler, a minimal set of useful
> helpers, corresponding libbpf changes, etc.
>

Thanks for initiating the effort of bringing BPF to sched. I've been
looking at the potential applications of BPF in sched for some time
and I'm very excited about this work!

My current focus has been using BPF for profiling performance and
exporting sched related stats. I think BPF can provide a great help
there. We have many users in Google that want the kernel to export
various scheduling metrics to userspace. I think BPF is a good fit for
such a task. So one of my recent attempts is to use BPF to account for
the forced idle time caused by core scheduling [1]. This is one of the
topics I want to discuss in my upcoming LPC BPF talk [2].

Looking forward, I agree that BPF has a great potential in customizing
policies in the scheduler. It has the advantage of quick
experimentation and deployment. One of the use cases I'm thinking of
is to customize load balancing policies. For example, allow using BPF
to influence whether a task can migrate (can_migrate_task). This is
currently only an idea.

> Our very first experiments with using BPF in CFS look very promising. We're
> at a very early stage, however already have seen a nice latency and ~1% RPS
> wins for our (Facebook's) main web workload.
>
> As I know, Google is working on a more radical approach [2]: they aim to move
> the scheduling code into userspace. It seems that their core motivation is
> somewhat similar: to make the scheduler changes easier to develop, validate
> and deploy. Even though their approach is different, they also use BPF for
> speeding up some hot paths. I think the suggested infrastructure can serve
> their purpose too.

Yes. Barret can talk more about this, but I think it summarized the
work of ghOSt [3] and the use of BPF in ghOSt well.

Hao

>
> An example of an userspace part, which loads some simple hooks is available
> here [3]. It's very simple, provided only to simplify playing with the provided
> kernel patches.
>
>
> [1] c722f35b513f ("sched/fair: Bring back select_idle_smt(), but differently")
> [2] Google's ghOSt: https://linuxplumbersconf.org/event/11/contributions/954/
> [3] https://github.com/rgushchin/atc
>
>
> Roman Gushchin (6):
>   bpf: sched: basic infrastructure for scheduler bpf
>   bpf: sched: add convenient helpers to identify sched entities
>   bpf: sched: introduce bpf_sched_enable()
>   sched: cfs: add bpf hooks to control wakeup and tick preemption
>   libbpf: add support for scheduler bpf programs
>   bpftool: recognize scheduler programs
>
>  include/linux/bpf_sched.h       |  53 ++++++++++++
>  include/linux/bpf_types.h       |   3 +
>  include/linux/sched_hook_defs.h |   4 +
>  include/uapi/linux/bpf.h        |  25 ++++++
>  kernel/bpf/btf.c                |   1 +
>  kernel/bpf/syscall.c            |  21 ++++-
>  kernel/bpf/trampoline.c         |   1 +
>  kernel/bpf/verifier.c           |   9 ++-
>  kernel/sched/Makefile           |   1 +
>  kernel/sched/bpf_sched.c        | 138 ++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c             |  27 +++++++
>  scripts/bpf_doc.py              |   2 +
>  tools/bpf/bpftool/common.c      |   1 +
>  tools/bpf/bpftool/prog.c        |   1 +
>  tools/include/uapi/linux/bpf.h  |  25 ++++++
>  tools/lib/bpf/libbpf.c          |  27 ++++++-
>  tools/lib/bpf/libbpf.h          |   4 +
>  tools/lib/bpf/libbpf.map        |   3 +
>  18 files changed, 341 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/bpf_sched.h
>  create mode 100644 include/linux/sched_hook_defs.h
>  create mode 100644 kernel/sched/bpf_sched.c
>
> --
> 2.31.1
>

[1] core scheduling and forced idle: https://lwn.net/Articles/799454/
[2] BPF talk: https://linuxplumbersconf.org/event/11/contributions/954/
[3] ghOSt: https://github.com/google/ghost-kernel
