Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90EF3650B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhDTDPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:15:48 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37799 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhDTDPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:45 -0400
Received: by mail-ot1-f44.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso20536042otm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VEETDXPqBgPZUU+Jc1UmJM7E+FtoTdgHKBL94zcgp4=;
        b=A9/3UNM+TbAZhsupItAik7SzFiCfhB19G5wuLTgin/Ovl1lbY2fT8aP5vwBYGM7ECZ
         +wfwHTgc5jfQHTQUq+koiBeE0eqvOALBEqqPL1wVSW9I5QnZrtn/j2ktWlufeBog/DMo
         IgxFiz+uJXz0fmvgmelLqIci1KADxi10kOCB2ssi+3rorbdjmQxL+FvCbtQ482ioNDU8
         CgxkmrPnFVZLMh8gHl238GV2/T1qGiCRKb3d0uoqmDe6uvdOBh/tAXCpRXX76kCEsgtD
         GNiaP7mIoFVqCQnBtFK6qeZOBR3lQZ+TDPpf6idfGrSZgnvlxdbv2bWDrJvPSV3Z4KkO
         S6Pw==
X-Gm-Message-State: AOAM531RpvAZFgAg91bkrXu/TdpYFDzPZ7CaZjODaPOhQYju9rNqg5sb
        iSCefJWblcxxT8lKh5oJLg==
X-Google-Smtp-Source: ABdhPJwCOJqrLE+mLWWh6jLRFFZFpIF+Q5lGlqSVEQbJ9uTINQi+fwn/HxXWcJnU0LzxwM451n31cg==
X-Received: by 2002:a05:6830:237c:: with SMTP id r28mr17468924oth.130.1618888513640;
        Mon, 19 Apr 2021 20:15:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] arm64 userspace counter access support
Date:   Mon, 19 Apr 2021 22:15:02 -0500
Message-Id: <20210420031511.2348977-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Another version of arm64 userspace counter access support. I sent out
the libperf bits separately and those are now applied (Thanks!), so this
is just the arm64 bits.


This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5][6][7]. A git
branch is here[8].


Changes in v7:
 - Handling of dirty counter leakage and reworking of context switch and
   user access enabling. The .sched_task hook and undef instruction handler
   are now utilized. (Patch 3)
 - Add a userspace disable switch like x86. (Patch 5)

Changes in v6:
 - Reworking of the handling of 64-bit counters and user access. There's
   a new config1 flag to request user access. This takes priority over
   the 64-bit flag and the user will get the maximum size the h/w
   supports without chaining.
 - The libperf evsel mmap struct is stored in its own xyarray
 - New tests for user 64-bit and 32-bit counters
 - Rebase to v5.12-rc2

Changes in v5:
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.
   The x86 method of using mm_cpumask doesn't work for arm64 as it is not
   updated.
 - Only set cap_user_rdpmc if event is on current cpu. See patch 2.
 - Create an mmap for every event in an evsel. This results in some changes
   to the libperf mmap API from the last version.
 - Rebase to v5.11-rc2

Changes in v4:
 - Dropped 'arm64: pmu: Add hook to handle pmu-related undefined instructions'.
   The onus is on userspace to pin itself to a homogeneous subset of CPUs
   and avoid any aborts on heterogeneous systems, so the hook is not needed.
 - Make perf_evsel__mmap() take pages rather than bytes for size
 - Fix building arm64 heterogeneous test.

Changes in v3:
 - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
 - Added verbose prints for tests
 - Split adding perf_evsel__mmap() to separate patch

The following changes to the arm64 support have been made compared to
Raphael's last version:

The major change is support for heterogeneous systems with some
restrictions. Specifically, userspace must pin itself to like CPUs, open
a specific PMU by type, and use h/w specific events. The tests have been
reworked to demonstrate this.

Chained events are not supported. The problem with supporting chained
events was there's no way to distinguish between a chained event and a
native 64-bit counter. We could add some flag, but do self monitoring
processes really need that? Native 64-bit counters are supported if the
PMU h/w has support. As there's already an explicit ABI to request 64-bit
counters, userspace can request 64-bit counters and if user
access is not enabled, then it must retry with 32-bit counters.

Prior versions broke the build on arm32 (surprisingly never caught by
0-day). As a result, event_mapped and event_unmapped implementations have
been moved into the arm64 code.

There was a bug in that pmc_width was not set in the user page. The tests
now check for this.

The documentation has been converted to rST. I've added sections on
chained events and heterogeneous.

The tests have been expanded to test the cycle counter access.

Rob

[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
[7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
[8] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v7

Raphael Gault (4):
  arm64: Restrict undef hook for cpufeature registers
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable PMU counter direct access for perf event
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (5):
  drivers/perf: arm_pmu: Export the per_cpu cpu_armpmu
  arm64: perf: Add userspace counter access disable switch
  libperf: Add arm64 support to perf_mmap__read_self()
  perf: arm64: Add test for userspace counter access on heterogeneous
    systems
  perf: arm64: Add tests for 32-bit and 64-bit counter size userspace
    access

 Documentation/arm64/perf.rst               |  67 +++++-
 arch/arm64/include/asm/mmu.h               |   5 +
 arch/arm64/kernel/cpufeature.c             |   4 +-
 arch/arm64/kernel/perf_event.c             | 254 ++++++++++++++++++++-
 drivers/perf/arm_pmu.c                     |   2 +-
 include/linux/perf/arm_pmu.h               |  14 +-
 tools/lib/perf/mmap.c                      |  98 ++++++++
 tools/lib/perf/tests/test-evsel.c          |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h |  12 +
 tools/perf/arch/arm64/tests/Build          |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |  12 +
 tools/perf/arch/arm64/tests/user-events.c  | 215 +++++++++++++++++
 12 files changed, 672 insertions(+), 14 deletions(-)
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.27.0
