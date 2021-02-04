Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4630F60C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhBDPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:20:20 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46631 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhBDPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:19:23 -0500
Received: by mail-ot1-f49.google.com with SMTP id d1so3676110otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RhsRUIY4PwSbVtlxeuMCCB1IWHFQpv1uTxQeDPLtde0=;
        b=E0ZJjcq2B8wVsjhag1Kxx1tcsA0MUkh03KDn9d7ci6X/1+tB2GbzmuO00QhRMKYvwV
         V3cM+nYnHbxQ1WCQ+yML4wXXH7TUrTOJIRSQiqcGDNCfQG3VmpVPHZ+UQdIhr5fTlUgr
         bLiU/JnOdOe3oezU18xx/POs4zva+95xegpwNcCO8Ub9oIXZmZnFuTmgASfMt6vYhEFX
         lW5koOLq0sJW/UBZrjuNU1ObShoZGBuUMAz6DCH2L5oI3jyMgVwfUV6KI2fZlKKlgLeD
         v+eC0O1JXGkfqWvn2afImVX+Yot9yOOcxFbQWDhdD8dmutbF8i270JqvC8klKU1jYlox
         LkDw==
X-Gm-Message-State: AOAM532fUnABYzUkV35AeUcH7DurVKkS0KryDPL3EQ6Sw31yLXA5h8U8
        6IPPTiZJZpfhSdrNjfyLvA==
X-Google-Smtp-Source: ABdhPJyf1i46goE7Fl0eVk0dbbaNifbkwfzIk+WyhbDrVANZ9G8qMNM+ovniEwivEV/H8Jt36ruZDA==
X-Received: by 2002:a9d:61d0:: with SMTP id h16mr5897819otk.1.1612451920983;
        Thu, 04 Feb 2021 07:18:40 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t62sm1141712oif.2.2021.02.04.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:18:40 -0800 (PST)
Received: (nullmailer pid 447920 invoked by uid 1000);
        Thu, 04 Feb 2021 15:18:38 -0000
Date:   Thu, 4 Feb 2021 09:18:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v5 0/9] libperf and arm64 userspace counter access support
Message-ID: <20210204151838.GF3706951@robh.at.kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:05:56PM -0600, Rob Herring wrote:
> Hi all,
> 
> Another version of libperf and arm64 userspace counter access support.
> This originally resurrected Raphael's series[1] to enable userspace counter
> access on arm64. My previous versions are here[2][3][4][5]. A git branch is
> here[6].

Ping.

Will, Mark, comments on the Arm bits?

> 
> Changes in v5:
>  - Limit enabling/disabling access to CPUs associated with the PMU
>    (supported_cpus) and with the mm_struct matching current->active_mm.
>    The x86 method of using mm_cpumask doesn't work for arm64 as it is not
>    updated.
>  - Only set cap_user_rdpmc if event is on current cpu. See patch 2.
>  - Create an mmap for every event in an evsel. This results in some changes
>    to the libperf mmap API from the last version.
>  - Rebase to v5.11-rc2
> 
> Changes in v4:
>  - Dropped 'arm64: pmu: Add hook to handle pmu-related undefined instructions'.
>    The onus is on userspace to pin itself to a homogeneous subset of CPUs
>    and avoid any aborts on heterogeneous systems, so the hook is not needed.
>  - Make perf_evsel__mmap() take pages rather than bytes for size
>  - Fix building arm64 heterogeneous test.
> 
> Changes in v3:
>  - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
>  - Added verbose prints for tests
>  - Split adding perf_evsel__mmap() to separate patch
> 
> 
> The following changes to the arm64 support have been made compared to
> Raphael's last version:
> 
> The major change is support for heterogeneous systems with some
> restrictions. Specifically, userspace must pin itself to like CPUs, open
> a specific PMU by type, and use h/w specific events. The tests have been
> reworked to demonstrate this.
> 
> Chained events are not supported. The problem with supporting chained
> events was there's no way to distinguish between a chained event and a
> native 64-bit counter. We could add some flag, but do self monitoring
> processes really need that? Native 64-bit counters are supported if the
> PMU h/w has support. As there's already an explicit ABI to request 64-bit
> counters, userspace can request 64-bit counters and if user
> access is not enabled, then it must retry with 32-bit counters.
> 
> Prior versions broke the build on arm32 (surprisingly never caught by
> 0-day). As a result, event_mapped and event_unmapped implementations have
> been moved into the arm64 code.
> 
> There was a bug in that pmc_width was not set in the user page. The tests
> now check for this.
> 
> The documentation has been converted to rST. I've added sections on
> chained events and heterogeneous.
> 
> The tests have been expanded to test the cycle counter access.
> 
> Rob
> 
> [1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
> [2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
> [3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
> [4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
> [5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
> [6] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v5
> 
> 
> Raphael Gault (3):
>   arm64: pmu: Add function implementation to update event index in
>     userpage
>   arm64: perf: Enable PMU counter direct access for perf event
>   Documentation: arm64: Document PMU counters access from userspace
> 
> Rob Herring (6):
>   tools/include: Add an initial math64.h
>   libperf: Add evsel mmap support
>   libperf: tests: Add support for verbose printing
>   libperf: Add support for user space counter access
>   libperf: Add arm64 support to perf_mmap__read_self()
>   perf: arm64: Add test for userspace counter access on heterogeneous
>     systems
> 
>  Documentation/arm64/index.rst                 |   1 +
>  .../arm64/perf_counter_user_access.rst        |  56 ++++++
>  arch/arm64/include/asm/mmu.h                  |   5 +
>  arch/arm64/include/asm/mmu_context.h          |   2 +
>  arch/arm64/include/asm/perf_event.h           |  14 ++
>  arch/arm64/kernel/perf_event.c                |  68 +++++++
>  include/linux/perf/arm_pmu.h                  |   2 +
>  tools/include/linux/math64.h                  |  75 +++++++
>  tools/lib/perf/Documentation/libperf.txt      |   2 +
>  tools/lib/perf/evsel.c                        |  50 ++++-
>  tools/lib/perf/include/internal/evsel.h       |   2 +
>  tools/lib/perf/include/internal/mmap.h        |   3 +
>  tools/lib/perf/include/internal/tests.h       |  32 +++
>  tools/lib/perf/include/perf/evsel.h           |   2 +
>  tools/lib/perf/libperf.map                    |   2 +
>  tools/lib/perf/mmap.c                         | 186 ++++++++++++++++++
>  tools/lib/perf/tests/Makefile                 |   6 +-
>  tools/lib/perf/tests/test-evsel.c             |  65 ++++++
>  tools/perf/arch/arm64/include/arch-tests.h    |   7 +
>  tools/perf/arch/arm64/tests/Build             |   1 +
>  tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
>  tools/perf/arch/arm64/tests/user-events.c     | 170 ++++++++++++++++
>  22 files changed, 751 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/arm64/perf_counter_user_access.rst
>  create mode 100644 tools/include/linux/math64.h
>  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> 
> --
> 2.27.0
