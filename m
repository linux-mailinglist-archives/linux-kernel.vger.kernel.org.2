Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7E36E742
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhD2Ipw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2Ipv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:45:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328FC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:45:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v10-20020a25fc0a0000b02904eea8179f1fso5101138ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/nFl5CA5odwYD5KZSvpkh3fKWk1qJg9klTkH7PLEp40=;
        b=Csx7tXvAkqG1rNLJ4ziBFX7Lg1zHUuDoMPI7aO3KI++HaNREOqduBF67lPG/jPKMRZ
         GrTunRH+w6hR21p/aoNJb0j9h4PkzmmztseijgLWBnbit+a+bdzB9Pl15zbJRAhpjgSt
         mFO8pHYaQHq8S69jiXFl1/q5pWrVJW8xsmFnwwJ4vj89DtdPE9JYpANbdFgIZghtZMm1
         fImBZfywnR3uuMiKVgouic096JDzbHKu11GthTpkPfOyHRyzpq1XYZZaB2Kj4959kFII
         NLYDoGR33YbqANpqPU/SyZYCcqSA7ZSbfhObtF8jRCDFZp8L1boyfYfBjl/yn0P3NbZj
         i77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/nFl5CA5odwYD5KZSvpkh3fKWk1qJg9klTkH7PLEp40=;
        b=tHiI2I8nwdoYMjnxkUESYsA80totnmly0Eg/vlx020JyxVvA57dncARq+bhugKQQ9y
         bumXfD8uNKE58OfGtqKRgwsk+1JpB5VLV3dmMb5BFOhMVMkOoa4cmpXil0sJtMVtDzP0
         +2KIE7wfr0A1YfB7scHtzJuK4yVERwjuB3QwgL6jqYs3N2iWa0Df+DkhPViTNEUYFbXl
         bA/bUnaxqWzab3e9SouOXtpaWJhLk5CF1cwKU/YdMujBs+nr4d3n8PH4oMFotSa1ChDL
         RaL0ptS7SAuHWn26YhD0EL1u5WEIqyhGBysE75kq1jwVrq7MQITQ4i+PkZsWxfxcFb/5
         ar5Q==
X-Gm-Message-State: AOAM532IXRCXIipPYsADBiB6MqHy+f2TXUb60ffjcN0F1tsERT7KNz9+
        uauViugStSjnUwnIBxKOEuT2NAOtvTM1
X-Google-Smtp-Source: ABdhPJyTKGs6WbIoCvxIYmvdsv2tJEWq83Zwt/Jixm+zA/fQIXI57h/Z+5snW9ptCCRxtofohsmBki1sP5Ka
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:30c1:7a5a:2ec9:29e5])
 (user=amistry job=sendgmr) by 2002:a25:ba92:: with SMTP id
 s18mr49884608ybg.438.1619685902643; Thu, 29 Apr 2021 01:45:02 -0700 (PDT)
Date:   Thu, 29 Apr 2021 18:44:08 +1000
Message-Id: <20210429084410.783998-1-amistry@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 0/2] x86/speculation: Add finer control for when to
 issue IBPB
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, bp@alien8.de,
        tglx@linutronix.de, Anand K Mistry <amistry@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jay Lang <jaytlang@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It is documented in Documentation/admin-guide/hw-vuln/spectre.rst, that
disabling indirect branch speculation for a user-space process creates
more overhead and cause it to run slower. The performance hit varies by
CPU, but on the AMD A4-9120C and A6-9220C CPUs, a simple ping-pong using
pipes between two processes runs ~10x slower when disabling IB
speculation.

Patch 2, included in this RFC but not intended for commit, is a simple
program that demonstrates this issue. Running on a A4-9120C without IB
speculation disabled, each process ping-pong takes ~7us:
localhost ~ # taskset 1 /usr/local/bin/test
...
iters: 262144, t: 1936300, iter/sec: 135383, us/iter: 7

But when IB speculation is disabled, that number increases
significantly:
localhost ~ # taskset 1 /usr/local/bin/test d
...
iters: 16384, t: 1500518, iter/sec: 10918, us/iter: 91

Although this test is a worst-case scenario, we can also consider a real
situation: an audio server (i.e. pulse). If we imagine a low-latency
capture, with 10ms packets and a concurrent task on the same CPU (i.e.
video encoding, for a video call), the audio server will preempt the
CPU at a rate of 100HZ. At 91us overhead per preemption (switching to
and from the audio process), that's 0.9% overhead for one process doing
preemption. In real-world testing (on a A4-9120C), I've seen 9% of CPU
used by IBPB when doing a 2-person video call.

With this patch, the number of IBPBs issued can be reduced to the
minimum necessary, only when there's a potential attacker->victim
process switch.

Running on the same A4-9120C device, this patch reduces the performance
hit of IBPB by ~half, as expected:
localhost ~ # taskset 1 /usr/local/bin/test ds
...
iters: 32768, t: 1824043, iter/sec: 17964, us/iter: 55

It should be noted, CPUs from multiple vendors experience a performance
hit due to IBPB. I also tested a Intel i3-8130U which sees a noticable
(~2x) increase in process switch time due to IBPB.
IB spec enabled:
localhost ~ # taskset 1 /usr/local/bin/test
...
iters: 262144, t: 1210821us, iter/sec: 216501, us/iter: 4

IB spec disabled:
localhost ~ # taskset 1 /usr/local/bin/test d
...
iters: 131072, t: 1257583us, iter/sec: 104225, us/iter: 9

Open questions:
- There are a significant number of task flags, which also now reaches the
  limit of the 'long' on 32-bit systems. Should the 'mode' flags be
  stored somewhere else?
- Having x86-specific flags in linux/sched.h feels wrong. However, this
  is the mechanism for doing atomic flag updates. Is there an alternate
  approach?

Open tasks:
- Documentation
- Naming


Changes in v2:
- Make flag per-process using prctl().

Anand K Mistry (2):
  x86/speculation: Allow per-process control of when to issue IBPB
  selftests: Benchmark for the cost of disabling IB speculation

 arch/x86/include/asm/thread_info.h            |   4 +
 arch/x86/kernel/cpu/bugs.c                    |  56 +++++++++
 arch/x86/kernel/process.c                     |  10 ++
 arch/x86/mm/tlb.c                             |  51 ++++++--
 include/linux/sched.h                         |  10 ++
 include/uapi/linux/prctl.h                    |   5 +
 .../testing/selftests/ib_spec/ib_spec_bench.c | 109 ++++++++++++++++++
 7 files changed, 236 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/ib_spec/ib_spec_bench.c

-- 
2.31.1.498.g6c1eba8ee3d-goog

