Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD63B591C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhF1G2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1G17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:27:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95843C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:25:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c17so2060240ejk.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v8oHuk9warTwjiSIvaYyDFCU50feyWqzIK9BaI9FPs4=;
        b=vUac1p4xfsW2ZGSBm4YTRvGsvp4DMxorMth69YpKSk8TiHniWM8O2AsPaYv8beZ5RE
         CUbhx4pze2ZaoGWbFWN3pnKB6dHekPlzVm4q4vkOUpnGnDc63W1W6ks5r45YDKb/qWcx
         YZjsvvyRebnMFA7bQHBkPGqLhFVsKCn1vzTTWEynysrz4uN4PAlxLgBr6n6nEHZa25m+
         jLeLVfXzhg/MhK4KdGP660VYBBWn7IcpSbODIXiZjoccOTEuYB8BK3gRSTukzoUbhaHl
         Yudvo8sTReQI3OUJBlzB8SwgxVAwAa3CcuRpYNeU20pgIeobUFaghRmyBAtMtJmkCS1y
         Ukhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=v8oHuk9warTwjiSIvaYyDFCU50feyWqzIK9BaI9FPs4=;
        b=BkHX7RiRRWMb0RjMIGmoBL084xi0zdhrmqtmkhn9pWMR55vtmTz371QfHQOERCvoBm
         v/k2o8NDCSct9dvpm8n/7FxBNCuZ1IMDu3lqLwVw3iEwW64hB650pQnL1P4bXHSJlJtN
         4YTespZ32hVCzuBLZqqWmKotRt3PnUwm1APd7ML9Ipz1021JnoCBAUHaMpkLwL7uPGcu
         wul5m32Z8vdeqrdS4hsfEfvy84X/g4XlnhgCBRZt53ynoPEhD5VvrOQ7CoH91EwuxgjS
         OKE4+6G2v5FdSba907gpR0TdeVx/DM8mX8F6BkhJxCe8gTd1WH4BvVTYbQ55W3kzcxcA
         KfYw==
X-Gm-Message-State: AOAM5333gFe+Xc6Ji7liw+tqCXmPppwlJ22wddAgk/FGVzZ+UyFVVTYX
        FyyD1JZmLGtdqdALbUjY8SE=
X-Google-Smtp-Source: ABdhPJxr8rMMvHw+7X3GJL+3Yfo96+kPafgLfNWm+RmzoguDL73xq/ZNXyqGa2mgNIp98Rc7c5bORg==
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr22579113ejk.366.1624861533190;
        Sun, 27 Jun 2021 23:25:33 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id d22sm6611039ejj.47.2021.06.27.23.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 23:25:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 08:25:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events updates for v5.14
Message-ID: <YNlrWz8Y3Tdk0N54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-06-28

   # HEAD: 012669c740e6e2afa8bdb95394d06676f933dd2d perf: Fix task context PMU for Hetero

Perf events updates for this cycle:

 - Platform PMU driver updates:

     - x86 Intel uncore driver updates for Skylake (SNR) and Icelake (ICX) servers
     - Fix RDPMC support
     - Fix [extended-]PEBS-via-PT support
     - Fix Sapphire Rapids event constraints
     - Fix :ppp support on Sapphire Rapids
     - Fix fixed counter sanity check on Alder Lake & X86_FEATURE_HYBRID_CPU
     - Other heterogenous-PMU fixes

 - Kprobes:

     - Remove the unused and misguided kprobe::fault_handler callbacks.
     - Warn about kprobes taking a page fault.
     - Fix the 'nmissed' stat counter.

 - Misc cleanups and fixes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Alexander Antonov (3):
      perf/x86/intel/uncore: Generalize I/O stacks to PMON mapping procedure
      perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR
      perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX

Guenter Roeck (1):
      perf/x86/intel/uncore: Drop unnecessary NULL checks after container_of()

Haocheng Xie (3):
      perf/core: Make local function perf_pmu_snapshot_aux() static
      perf/core: Fix DocBook warnings
      perf/hw_breakpoint: Fix DocBook warnings in perf hw_breakpoint

Kan Liang (4):
      perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task
      perf/x86/intel: Fix fixed counter check warning for some Alder Lake
      perf/x86/intel: Add more events requires FRONTEND MSR on Sapphire Rapids
      perf/x86/intel: Fix instructions:ppp support in Sapphire Rapids

Like Xu (1):
      perf/x86/intel: Fix PEBS-via-PT reload base value for Extended PEBS

Naveen N. Rao (1):
      kprobes: Do not increment probe miss count in the fault handler

Peter Zijlstra (3):
      kprobes: Remove kprobe::fault_handler
      x86,kprobes: WARN if kprobes tries to handle a fault
      perf: Fix task context PMU for Hetero

Qiujun Huang (1):
      uprobes: Update uprobe_write_opcode() kernel-doc comment


 Documentation/trace/kprobes.rst      |  24 +----
 arch/arc/kernel/kprobes.c            |  16 ----
 arch/arm/probes/kprobes/core.c       |  23 -----
 arch/arm64/kernel/probes/kprobes.c   |  17 ----
 arch/csky/kernel/probes/kprobes.c    |  17 ----
 arch/ia64/kernel/kprobes.c           |  16 ----
 arch/mips/kernel/kprobes.c           |   3 -
 arch/powerpc/kernel/kprobes.c        |  17 ----
 arch/riscv/kernel/probes/kprobes.c   |  17 ----
 arch/s390/kernel/kprobes.c           |  17 ----
 arch/sh/kernel/kprobes.c             |  17 ----
 arch/sparc/kernel/kprobes.c          |  17 ----
 arch/x86/events/core.c               |  28 +++++-
 arch/x86/events/intel/core.c         |  15 ++-
 arch/x86/events/intel/ds.c           |  20 ++--
 arch/x86/events/intel/uncore.c       |   4 -
 arch/x86/events/intel/uncore.h       |   1 +
 arch/x86/events/intel/uncore_snbep.c | 173 +++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h         |   1 +
 arch/x86/include/asm/perf_event.h    |   1 +
 arch/x86/kernel/kprobes/core.c       |  18 ----
 arch/x86/mm/fault.c                  |   4 +-
 arch/x86/mm/tlb.c                    |  10 +-
 include/linux/kprobes.h              |   8 --
 kernel/events/core.c                 |  21 ++++-
 kernel/events/hw_breakpoint.c        |   2 +
 kernel/events/uprobes.c              |   1 +
 kernel/kprobes.c                     |  19 ----
 samples/kprobes/kprobe_example.c     |  15 ---
 29 files changed, 257 insertions(+), 285 deletions(-)
