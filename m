Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17F242D96E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhJNMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:44:14 -0400
Received: from mail.efficios.com ([167.114.26.124]:57672 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhJNMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2FAE638D311;
        Thu, 14 Oct 2021 08:42:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id czwbs09v8Xm8; Thu, 14 Oct 2021 08:42:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 413C038D310;
        Thu, 14 Oct 2021 08:42:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 413C038D310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1634215326;
        bh=xWc4PgsuZlxMNP7hL8hq9WSvXeeebc+2sa9ZScd55oM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DPbD0/84bGOOLO/R2vaHmF4SPFEeCogT6PRqPSwNsP4a2c2Sqt7gHBJgpFiaERDCP
         AkRrcwvb6fqBS/TpQTEzziLy+K+wTJsOalfBW9fHShvOoP4bYQEKnOQk225fD477a7
         iVYyx2IRj9xPpnSo4XKvm2J+hwMh3EyEDOLwhy1GesghTYxORhMyULOiDOcpYwLu3N
         w5/gnAFv3TRzEB3B+LVcJ3rSwVTbxbiUa82SfOhBnUsqp5tATqviJwpQ5m0p/M5Hxp
         xTTorHdk79WtuRLP0UY4lyo702YNhi08fIXuFl0/ENMetpIiH5qbvrbHEYcRfBrwqX
         4FqN4YdkAB25g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ObCw-4U-kfjB; Thu, 14 Oct 2021 08:42:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2054638CE49;
        Thu, 14 Oct 2021 08:42:06 -0400 (EDT)
Date:   Thu, 14 Oct 2021 08:42:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Yafang Shao <laoar.shao@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
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
Message-ID: <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020> <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF93 (Linux)/8.8.15_GA_4156)
Thread-Topic: 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Thread-Index: H5wHRdWu73zKyeX5+STnn82RFznE0A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 14, 2021, at 5:24 AM, Yafang Shao laoar.shao@gmail.com wrote:

> On Thu, Oct 14, 2021 at 3:08 PM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 317419b91ef4eff4e2f046088201e4dc4065caa0 ("[PATCH v3 3/4] sched.h:
>> extend task comm from 16 to 24 for CONFIG_BASE_FULL")
>> url:
>> https://github.com/0day-ci/linux/commits/Yafang-Shao/task_struct-extend-task-comm-from-16-to-24-for-CONFIG_BASE_FULL/20211010-182548
>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
>> 7fd2bf83d59a2d32e0d596c5d3e623b9a0e7e2d5
>>
>> in testcase: perf-sanity-tests
>> version: perf-x86_64-7fd2bf83d59a-1_20211010
>> with following parameters:
>>
>>         perf_compiler: clang
>>         ucode: 0xde
>>
>>
>>
>> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
>> with 32G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire
>> log/backtrace):
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>> 2021-10-13 18:00:46 sudo
>> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
>> test 13
>> 13: DSO data reopen                                                 : Ok
>> 2021-10-13 18:00:46 sudo
>> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
>> test 14
>> 14: Roundtrip evsel->name                                           : Ok
>> 2021-10-13 18:00:46 sudo
>> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
>> test 15
>> 15: Parse sched tracepoints fields                                  : FAILED!
> 
> 
> That issue is caused by another hardcode 16 ...
> 
> Seems we should make some change as below,
> 
> diff --git a/tools/perf/tests/evsel-tp-sched.c
> b/tools/perf/tests/evsel-tp-sched.c
> index f9e34bd26cf3..401a737b1d85 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(struct test
> *test __maybe_unused, int subtes
>                return -1;
>        }
> 
> -       if (evsel__test_field(evsel, "prev_comm", 16, false))
> +       if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))

tools/perf/tests/* contains userspace test programs. This means it gets the
TASK_COMM_LEN from the uapi. The fix you propose won't do any good here.

ftrace and perf access a description of the sched_switch tracepoint prev_comm field
from tracefs and store it into their respective traces. The size of this field is
derived from the kernel's TASK_COMM_LEN, which is changed by the patch triggering this
failure. Therefore, if we strictly consider the field layout as ABI, this is an ABI break.
However, if we consider that trace viewers should adapt to the changes in described event
field layout, then we should tweak this test program to accept larger values of prev_comm
field size.

A simple solution would be to tweak this test program so it can adapt to the size
change, and then figure out if any other relevant program out there notice the break.
If it happens that this ABI break is noticed by more than an in-tree test program, then
the kernel's ABI rules will require that this trace field size stays unchanged. This brings
up once more the whole topic of "Tracepoints ABI" which has been discussed repeatedly in
the past.

In short, because TRACE_EVENT exposes the tracepoint layout as ABI, if any trace viewer out
there expects a fixed-size prev_comm field for the sched_switch event, its size cannot be
changed.

Thanks,

Mathieu

>                ret = -1;
> 
>        if (evsel__test_field(evsel, "prev_pid", 4, true))
> @@ -54,7 +54,7 @@ int test__perf_evsel__tp_sched_test(struct test
> *test __maybe_unused, int subtes
>        if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
>                ret = -1;
> 
> -       if (evsel__test_field(evsel, "next_comm", 16, false))
> +       if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
>                ret = -1;
> 
>        if (evsel__test_field(evsel, "next_pid", 4, true))
> @@ -72,7 +72,7 @@ int test__perf_evsel__tp_sched_test(struct test
> *test __maybe_unused, int subtes
>                return -1;
>        }
> 
> -       if (evsel__test_field(evsel, "comm", 16, false))
> +       if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))
>                ret = -1;
> 
>        if (evsel__test_field(evsel, "pid", 4, true))
> 
> 
>> 2021-10-13 18:00:46 sudo
>> /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf
>> test 16
>> 16: syscalls:sys_enter_openat event fields                          : Ok
>>
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>         sudo bin/lkp run generated-yaml-file
>>
>>         # if come across any failure that blocks the test,
>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>>
>> ---
>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>>
>> Thanks,
>> Oliver Sang
>>
> 
> 
> --
> Thanks
> Yafang

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
