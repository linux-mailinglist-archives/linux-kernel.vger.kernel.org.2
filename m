Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3433685E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCKAJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:09:10 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:43550 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCKAIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:08:43 -0500
Received: by mail-il1-f169.google.com with SMTP id b5so17308478ilq.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHVDTLo/nd0Nj+MeP696wg07JVbES1vb8glNOWX4NZU=;
        b=rJqbRcrr9dmhfPyhncVYUU08xL1oTLsApU8K0NRm+S0CVP5WNISOQiYoFjwfbeq0s+
         kFUCaMVwcrGgtxHO1jqnbsWowLv3boFmzC19Dur3vp2VyV+ZRH71BB1dzdRyGqq9WK59
         UQljW4TFN7kBEllR54mcoaYLuZ1+yEY80Lqi5RgnaCgDw1ebN3ZJPceGCLKRg0vootdo
         x3UXPXu1Qo/LL9x9sVOsogBcAhxgmA/B1utJDSfTwavti5h2vlIymINH3+eRLEJ868o8
         s9Kit7NksL7NUgbjticD0HweMhDtbBTInNWzSlnUGaAsz6PnDPbnl5t5dQkTMmS0eRJk
         m/Mg==
X-Gm-Message-State: AOAM533RfqlsdWCRovpi0sIemnpdF+tsHsSOU62vHd08xylcaz3Qy8W1
        XbS3NsJFn77onrwQIXF7ZrKuX9Nxfg==
X-Google-Smtp-Source: ABdhPJycjzjsvd+mmnPqAl+RssiEvI1EEhb02EmTCfOoxnaLIvB6M3/RutHuTD4I+XDCi448dhGCsQ==
X-Received: by 2002:a05:6e02:2199:: with SMTP id j25mr4772361ila.18.1615421322716;
        Wed, 10 Mar 2021 16:08:42 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id x17sm484351ilm.40.2021.03.10.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:08:41 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/10] libperf and arm64 userspace counter access support
Date:   Wed, 10 Mar 2021 17:08:27 -0700
Message-Id: <20210311000837.3630499-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Another version of libperf and arm64 userspace counter access support.
This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5][6]. A git
branch is here[7].

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
[7] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v6

Raphael Gault (3):
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable PMU counter direct access for perf event
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (7):
  tools/include: Add an initial math64.h
  libperf: Add evsel mmap support
  libperf: tests: Add support for verbose printing
  libperf: Add support for user space counter access
  libperf: Add arm64 support to perf_mmap__read_self()
  perf: arm64: Add test for userspace counter access on heterogeneous
    systems
  perf: arm64: Add tests for 32-bit and 64-bit counter size userspace
    access

 Documentation/arm64/index.rst                 |   1 +
 .../arm64/perf_counter_user_access.rst        |  60 +++++
 arch/arm64/include/asm/mmu.h                  |   5 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 ++
 arch/arm64/kernel/perf_event.c                | 104 ++++++++-
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/include/linux/math64.h                  |  75 ++++++
 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/evsel.c                        |  55 +++++
 tools/lib/perf/include/internal/evsel.h       |   1 +
 tools/lib/perf/include/internal/mmap.h        |   3 +
 tools/lib/perf/include/internal/tests.h       |  32 +++
 tools/lib/perf/include/perf/evsel.h           |   2 +
 tools/lib/perf/libperf.map                    |   2 +
 tools/lib/perf/mmap.c                         | 186 +++++++++++++++
 tools/lib/perf/tests/Makefile                 |   6 +-
 tools/lib/perf/tests/test-evsel.c             |  65 ++++++
 tools/perf/arch/arm64/include/arch-tests.h    |  12 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |  12 +
 tools/perf/arch/arm64/tests/user-events.c     | 215 ++++++++++++++++++
 22 files changed, 852 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.27.0
