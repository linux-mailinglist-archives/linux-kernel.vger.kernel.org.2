Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9914D42D5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:27:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E34C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:25:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so2896096iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvYqhKlN3mlW9ztslBa/+DpoQ7H6AUrjlR5LoGl1xvc=;
        b=bTUe9pCkrYMUnSpFwP+weJh1W6Q9nigoaqe+GziaEZU7OQKw7lO/iNLorQdtnUYyc7
         rFsIHBPMWoFWMWCJEgFFwx6y/tvI3xVI974II8Yim4RMAQ1VRZ3r6nUmKY9aY113JuqM
         dfnmH5Y3cXRhp7DE5C1CvckztsGFTp0YvLkR2Jt44bMydPTB4MaAU2Ki3AU6seB0ATvd
         +kNj1IID3vkuBfeknKLxzjFpSLGWBlXLKlNNR+BZtPuxc7il4yAereJ1IEXPp/0v2BM5
         2nWMg3+vbH3PTi/70pKff1hUF6cxx2Km7jd85PoZbuyR+i9XVBWuNPksLdNtKCEKvmgO
         6KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvYqhKlN3mlW9ztslBa/+DpoQ7H6AUrjlR5LoGl1xvc=;
        b=OGEJZIZ7S5cwobGZdSRt6DCPYqYKTghcsS9ETmGYCnjsWKqq1cDZ66003so48KEzh9
         frgeG6o5tXX+Z9AhWTeph4oYp2v3oE7jjvyS+kPvH8lnd45Qw+GgE1Tq5KK5C5IH1ypN
         MddC8QeoY9ISdDTMtSeujeZ5IyaX628QnQYPsdWOo3vRDPjzwfQSBXVSYR48Ekp1Xakj
         Sr3mzj+NQd2bQPNnViJducqPK1GRldErSGEPnXqRTBqGjsOZ0+xlahTl1VnIbddotaGK
         zplWsbP5rUqiNWs7qh0tNjHRxWp1P+G5z6/uyrZe3GE5nq6yhW1xff3RNHGpOdZMlYDn
         H2bQ==
X-Gm-Message-State: AOAM531i7dfvy8/IWZstS73+TWr3pxzAnAHJ3nJTBqUezygEeWpRST2n
        bswB06UeBW+MzeTj/A8KjLJJqwGTphI1xWUjAPM=
X-Google-Smtp-Source: ABdhPJxF3FVc/1d1Qv/qOW3DuBeBeQCniIEH3ZELgm+/aJSbOEYfL2d4pzcbrf3QTfrVcJAWfFCd0y8Ef/HiC8pHe4Y=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr1572227ioj.34.1634203499859;
 Thu, 14 Oct 2021 02:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
In-Reply-To: <20211014072707.GA18719@xsang-OptiPlex-9020>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 17:24:23 +0800
Message-ID: <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:08 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 317419b91ef4eff4e2f046088201e4dc4065caa0 ("[PATCH v3 3/4] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL")
> url: https://github.com/0day-ci/linux/commits/Yafang-Shao/task_struct-extend-task-comm-from-16-to-24-for-CONFIG_BASE_FULL/20211010-182548
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 7fd2bf83d59a2d32e0d596c5d3e623b9a0e7e2d5
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-7fd2bf83d59a-1_20211010
> with following parameters:
>
>         perf_compiler: clang
>         ucode: 0xde
>
>
>
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2021-10-13 18:00:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf test 13
> 13: DSO data reopen                                                 : Ok
> 2021-10-13 18:00:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf test 14
> 14: Roundtrip evsel->name                                           : Ok
> 2021-10-13 18:00:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf test 15
> 15: Parse sched tracepoints fields                                  : FAILED!


That issue is caused by another hardcode 16 ...

Seems we should make some change as below,

diff --git a/tools/perf/tests/evsel-tp-sched.c
b/tools/perf/tests/evsel-tp-sched.c
index f9e34bd26cf3..401a737b1d85 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(struct test
*test __maybe_unused, int subtes
                return -1;
        }

-       if (evsel__test_field(evsel, "prev_comm", 16, false))
+       if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
                ret = -1;

        if (evsel__test_field(evsel, "prev_pid", 4, true))
@@ -54,7 +54,7 @@ int test__perf_evsel__tp_sched_test(struct test
*test __maybe_unused, int subtes
        if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
                ret = -1;

-       if (evsel__test_field(evsel, "next_comm", 16, false))
+       if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
                ret = -1;

        if (evsel__test_field(evsel, "next_pid", 4, true))
@@ -72,7 +72,7 @@ int test__perf_evsel__tp_sched_test(struct test
*test __maybe_unused, int subtes
                return -1;
        }

-       if (evsel__test_field(evsel, "comm", 16, false))
+       if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))
                ret = -1;

        if (evsel__test_field(evsel, "pid", 4, true))


> 2021-10-13 18:00:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-317419b91ef4eff4e2f046088201e4dc4065caa0/tools/perf/perf test 16
> 16: syscalls:sys_enter_openat event fields                          : Ok
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>


-- 
Thanks
Yafang
