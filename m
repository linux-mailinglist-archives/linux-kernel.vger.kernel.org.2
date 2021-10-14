Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2C42D9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhJNNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:08:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B105C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:06:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d125so3658091iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXII+AXlBTit1BU5qtoANMWQnsrdIIyMZF78nSUfLPo=;
        b=Y5oiBSh0afQQOKBPObIs9+M1uf+U06+36EZRvbcscDORETCBx+/rJ6jYYL4qQ1aLdA
         zuh+yIN0f3cDmn/BcaLfUOrb08okc1gnBTRd5mo9Hg0rcZu7hwRw+4Xp2lgLy9DrRj74
         hv9B/5F/G4urd2MtXSAVFarO3sTYMoSHmrRdvHgTq1pHCH7Vx0eFqW2pZCqfa04Lp7m2
         zQQuMZLTl8o/WExBlCk2LWdpj2MM47QK516otfq5ZeN09PmhO++oGCdLrTnFKzIuH13P
         JclixRQ/OV5wMhlE6jV2YTQAnEX+pcohcDvO7HPxsANTNwlJSEy4lIWxtgtChiEIQGrO
         50Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXII+AXlBTit1BU5qtoANMWQnsrdIIyMZF78nSUfLPo=;
        b=N7gprur09eIIOURLYdpXRfz7pSacT6QvZjxqmHlg03xICwv0vK1R3TPMLwXRW3ubaR
         RE7gSkfAYhKY66sCf5LC3gfGpq2sSpGgIENYfVnjajyJTFDpZBEvRKpoOwHkttoQ0SPq
         HM1lqAXq2dI767qQevBikK1EGk+aBQhLwqBlwgOXRIVv7bzUkeJlELt4/REU+rbMdl2Z
         I6MLAoxE3wMsPPdxggfiz7z19DvDzI1HfVSVW0JX3dlP/zdQbCrMkEYebqkTDHdeZoOP
         XizYZVUmySWkrp6Wof4ylupzIZP7qNZU4sx8fDwCql1lmR0QikV5cTB3RMR7tMsneDXe
         VpoQ==
X-Gm-Message-State: AOAM532seRZGRR/e/UgsTTfP/j2JatexmE7MsZAdhhzDHGzYcyDxcuvK
        IrNU/ML8aYIfFOyONCqXzOo0yH/QqoJn4T4U4YE=
X-Google-Smtp-Source: ABdhPJxyw05jiyrMojrjr6VzL72iLe5/dbyNzZ68ZzkbNs16yVOqhz482/XwHigvU9utgxVyKSY1Sht0VBUtl355CDE=
X-Received: by 2002:a02:661d:: with SMTP id k29mr3886369jac.49.1634216759790;
 Thu, 14 Oct 2021 06:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com> <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
In-Reply-To: <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 21:05:23 +0800
Message-ID: <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark@chromium.org, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:42 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Oct 14, 2021, at 5:24 AM, Yafang Shao laoar.shao@gmail.com wrote:
>
> > On Thu, Oct 14, 2021 at 3:08 PM kernel test robot <oliver.sang@intel.com> wrote:
> >>
> >>
> >>
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-9):
> >>
> >> commit: 317419b91ef4eff4e2f046088201e4dc4065caa0 ("[PATCH v3 3/4] sched.h:
> >> extend task comm from 16 to 24 for CONFIG_BASE_FULL")
> >> url:
> >> https://github.com/0day-ci/linux/commits/Yafang-Shao/task_struct-extend-task-comm-from-16-to-24-for-CONFIG_BASE_FULL/20211010-182548
> >> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> >> 7fd2bf83d59a2d32e0d596c5d3e623b9a0e7e2d5
> >>
> >> in testcase: perf-sanity-tests
> >> version: perf-x86_64-7fd2bf83d59a-1_20211010
> >> with following parameters:
> >>
> >>         perf_compiler: clang
> >>         ucode: 0xde
> >>
> >>
> >>
> >> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
> >> with 32G memory
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire
> >> log/backtrace):
> >>
> >>
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>
> >> 2021-10-13 18:00:46 sudo
> >> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
> >> test 13
> >> 13: DSO data reopen                                                 : Ok
> >> 2021-10-13 18:00:46 sudo
> >> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
> >> test 14
> >> 14: Roundtrip evsel->name                                           : Ok
> >> 2021-10-13 18:00:46 sudo
> >> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
> >> test 15
> >> 15: Parse sched tracepoints fields                                  : FAILED!
> >
> >
> > That issue is caused by another hardcode 16 ...
> >
> > Seems we should make some change as below,
> >
> > diff --git a/tools/perf/tests/evsel-tp-sched.c
> > b/tools/perf/tests/evsel-tp-sched.c
> > index f9e34bd26cf3..401a737b1d85 100644
> > --- a/tools/perf/tests/evsel-tp-sched.c
> > +++ b/tools/perf/tests/evsel-tp-sched.c
> > @@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(struct test
> > *test __maybe_unused, int subtes
> >                return -1;
> >        }
> >
> > -       if (evsel__test_field(evsel, "prev_comm", 16, false))
> > +       if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
>
> tools/perf/tests/* contains userspace test programs. This means it gets the
> TASK_COMM_LEN from the uapi. The fix you propose won't do any good here.
>
> ftrace and perf access a description of the sched_switch tracepoint prev_comm field
> from tracefs and store it into their respective traces. The size of this field is
> derived from the kernel's TASK_COMM_LEN, which is changed by the patch triggering this
> failure. Therefore, if we strictly consider the field layout as ABI, this is an ABI break.
> However, if we consider that trace viewers should adapt to the changes in described event
> field layout, then we should tweak this test program to accept larger values of prev_comm
> field size.
>

I have verfied that perf works well after this change.
It seems that perf can adapt to this change.
So we can tweak this test program.

> A simple solution would be to tweak this test program so it can adapt to the size
> change, and then figure out if any other relevant program out there notice the break.

The other in-tree tools bpf uses the TASK_COMM_LEN as well, but it
doesn't require the fixed-size of task comm,
if task comm is larger than 16, it will be truncated, see also
bpf_get_current_comm().
IOW, this change doesn't break the bpf tools.

> If it happens that this ABI break is noticed by more than an in-tree test program, then
> the kernel's ABI rules will require that this trace field size stays unchanged. This brings
> up once more the whole topic of "Tracepoints ABI" which has been discussed repeatedly in
> the past.
>

I will check if any other in-tree tools depends on TASK_COMM_LEN.

> In short, because TRACE_EVENT exposes the tracepoint layout as ABI, if any trace viewer out
> there expects a fixed-size prev_comm field for the sched_switch event, its size cannot be
> changed.
>

Thanks for the explanation.

>
> >                ret = -1;
> >
> >        if (evsel__test_field(evsel, "prev_pid", 4, true))
> > @@ -54,7 +54,7 @@ int test__perf_evsel__tp_sched_test(struct test
> > *test __maybe_unused, int subtes
> >        if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
> >                ret = -1;
> >
> > -       if (evsel__test_field(evsel, "next_comm", 16, false))
> > +       if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
> >                ret = -1;
> >
> >        if (evsel__test_field(evsel, "next_pid", 4, true))
> > @@ -72,7 +72,7 @@ int test__perf_evsel__tp_sched_test(struct test
> > *test __maybe_unused, int subtes
> >                return -1;
> >        }
> >
> > -       if (evsel__test_field(evsel, "comm", 16, false))
> > +       if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))
> >                ret = -1;
> >
> >        if (evsel__test_field(evsel, "pid", 4, true))
> >
> >
> >> 2021-10-13 18:00:46 sudo
> >> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
> >> test 16
> >> 16: syscalls:sys_enter_openat event fields                          : Ok
> >>
> >>
> >>
> >> To reproduce:
> >>
> >>         git clone https://github.com/intel/lkp-tests.git
> >>         cd lkp-tests
> >>         sudo bin/lkp install job.yaml           # job file is attached in this email
> >>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >>         sudo bin/lkp run generated-yaml-file
> >>
> >>         # if come across any failure that blocks the test,
> >>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >>
> >>
> >>
> >> ---
> >> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> >> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> >>
> >> Thanks,
> >> Oliver Sang
> >>
> >
> >
> > --
> > Thanks
> > Yafang
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- 
Thanks
Yafang
