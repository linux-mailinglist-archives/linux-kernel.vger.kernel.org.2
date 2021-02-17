Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9631E0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhBQUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbhBQUp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:45:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34468C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:44:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f14so24814442ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c4RxuYxZn5q17gBAGUNng0VtwXLK1bPok5RbjXQ0nGs=;
        b=M/whrOp+5KJIQ9oofH5eDA5rxCsOGuwKVJgvqTTIkh6LhTlFG5+rJXbXcFX7nGdCx7
         d7FIK91sHfYQTSz4EwbdhbKiBpQ2VnqLjIPvbOsE2b12PsGqkxg4fwD0OkDdRWi2asFP
         qMShBcZOUE4L1Xz2v2S8NTL1BDHWlsL+erHdkctEYx920eg6wtiH2Ls1J2np9xTo/TrG
         c1jNPfwIInPBpKrexsJeFwKHDkVep+dxQLLHW5wmtm7ehG6OA9bxve+5SFrL9WRd9q2Q
         sMRpYIZQwEFh7UbHen0NHMugtAJA1eO7VOoBlmLdUNaY+QXiDLc620bCp2TZSfEWb2pM
         UgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=c4RxuYxZn5q17gBAGUNng0VtwXLK1bPok5RbjXQ0nGs=;
        b=HzB8sAP+OPAB3Dygbv5ERnbmB+wD8vOjbtVVTdvy6L3oCCckqjv9I9BcNQh1kyXBHz
         KHwuQ0VrJp3YFM2gV5ipWPeuLdJLENLt8o171WOJq1VPwO0Wjm/mVGIyaKmq0H0EgKF7
         SBOaw4Hr5J0C7hv7BcdYPxkBuolU3/9nOa/QJmQ3QW/MDXh+pWPQU3cj0z7XEluAfRf3
         euAIKnayoGRLO2I5aCid/831wIaAL79YxYJ1EKG3AJKtNd/UgAnzkzoEqmIGCj/lZYGe
         8VuhAVZc7U3fPqmgZnl8S8HZn/yXKVHjChYINpehEc3yb8P3ixH+vZGD2ZV7stxv0wpD
         ll2g==
X-Gm-Message-State: AOAM5314kZB5TGj7oQnhXT/gY2F5WWNqTaDXP5ZI4qsD0sh+uoHbUKh6
        D8sso+gQBKrW6cA/H5vYs4o=
X-Google-Smtp-Source: ABdhPJyLvuuSRKf73I31dwtsWKSeGWSKDWGLowRXlrkcpM2wgg4KAYRsMhocFBBFhi0TrwU4TZ+XNw==
X-Received: by 2002:a17:906:f2c3:: with SMTP id gz3mr729072ejb.315.1613594686876;
        Wed, 17 Feb 2021 12:44:46 -0800 (PST)
Received: from gmail.com (20014C4E1C8ABB004E764B08203955B1.dsl.pool.telekom.hu. [2001:4c4e:1c8a:bb00:4e76:4b08:2039:55b1])
        by smtp.gmail.com with ESMTPSA id v13sm1641185eds.43.2021.02.17.12.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:44:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Feb 2021 21:44:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] Performance events updates for v5.12
Message-ID: <20210217204444.GA505189@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-02-17

   # HEAD: 8bcfdd7cad3dffdd340f9a79098cbf331eb2cd53 Merge branch 'perf/kprobes' into perf/core, to pick up finished branch

The performance event updates for v5.12 are:

 - Add CPU-PMU support for Intel Sapphire Rapids CPUs

 - Extend the perf ABI with PERF_SAMPLE_WEIGHT_STRUCT, to offer two-parameter
   sampling event feedback. Not used yet, but is intended for Golden Cove
   CPU-PMU, which can provide both the instruction latency and the cache
   latency information for memory profiling events.

 - Remove experimental, default-disabled perfmon-v4 counter_freezing support
   that could only be enabled via a boot option. The hardware is hopelessly
   broken, we'd like to make sure nobody starts relying on this, as it would
   only end in tears.

 - Fix energy/power events on Intel SPR platforms

 - Simplify the uprobes resume_execution() logic

 - Misc smaller fixes.

 Thanks,

	Ingo

------------------>
Jim Mattson (1):
      perf/x86/kvm: Add Cascade Lake Xeon steppings to isolation_ucodes[]

Kan Liang (5):
      perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
      perf/x86/intel: Factor out intel_update_topdown_event()
      perf/x86/intel: Filter unsupported Topdown metrics event
      perf/x86/intel: Add perf core PMU support for Sapphire Rapids
      perf/x86/intel: Support CPUID 10.ECX to disable fixed counters

Like Xu (1):
      x86/perf: Use static_call for x86_pmu.guest_get_msrs

Masami Hiramatsu (1):
      x86/kprobes: Do not decode opcode in resume_execution()

Peter Zijlstra (1):
      perf/intel: Remove Perfmon-v4 counter_freezing support

Steve Wahl (2):
      perf/x86/intel/uncore: Store the logical die id instead of the physical die id.
      perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info

Zhang Rui (3):
      perf/x86/rapl: Add msr mask support
      perf/x86/rapl: Only check lower 32bits for RAPL energy counters
      perf/x86/rapl: Fix psys-energy event on Intel SPR platform


 Documentation/admin-guide/kernel-parameters.txt |   6 -
 arch/powerpc/perf/core-book3s.c                 |   2 +-
 arch/x86/events/core.c                          |  28 +-
 arch/x86/events/intel/core.c                    | 547 +++++++++++++++---------
 arch/x86/events/intel/ds.c                      | 131 +++++-
 arch/x86/events/intel/uncore.c                  |  58 +--
 arch/x86/events/intel/uncore.h                  |   5 +-
 arch/x86/events/intel/uncore_snb.c              |   2 +-
 arch/x86/events/intel/uncore_snbep.c            | 114 +++--
 arch/x86/events/perf_event.h                    |  21 +-
 arch/x86/events/probe.c                         |   7 +-
 arch/x86/events/probe.h                         |   7 +-
 arch/x86/events/rapl.c                          |  34 +-
 arch/x86/include/asm/kprobes.h                  |  11 +-
 arch/x86/include/asm/perf_event.h               |  24 +-
 arch/x86/kernel/kprobes/core.c                  | 168 ++++----
 include/linux/perf_event.h                      |   4 +-
 include/uapi/linux/perf_event.h                 |  54 ++-
 kernel/events/core.c                            |  11 +-
 19 files changed, 801 insertions(+), 433 deletions(-)
