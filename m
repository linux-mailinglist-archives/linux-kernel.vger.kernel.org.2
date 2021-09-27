Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47141A081
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhI0UsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236800AbhI0UsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:48:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C572611C5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632775588;
        bh=ijqSL8ib4ar/o4+1xA73ydhvwCMDgGTbIvx2qQjbGuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WxGI0KTUuj5RZ85L+aSUmP2ywiw97ZLd8JbJXc/1sTqvj46IWyryG6K0yPVlCc0S6
         y+1+ow/GGuiDmWfjkGRO/5wvFFj0puAuX/yFpJnVNCwwHdgOi8HUiTxp+LEhKlKAjA
         j3jfGZ2m2erDrTXnlyVYPnMdGZlV6XGt2NrUWwkvvxeHHcUM12vyopqh8LEUZcU4nw
         7OHQe42J3HzpZh81twEOWCR9Hnf9B19RkipWPExqIwP1s0kwdcKUjQJAiZB0SgIv5D
         0Rq/JaHfMU6CZjqoV4xu9fo5ByZBeuA37Z8vHS5mmFLa48BbRWSOosO/5Avk1Y1TSb
         UscsOQM76mSqg==
Received: by mail-ed1-f44.google.com with SMTP id g8so74320220edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:46:28 -0700 (PDT)
X-Gm-Message-State: AOAM532ozK4l17CxQ7B3c/7hmWG8zdGpAajVD7GIzfMDbzzLBRSmsDk2
        jVxXKU6aqSAzGoV0Uqith8WvON/QDVQ6oRWNug==
X-Google-Smtp-Source: ABdhPJxf7Lw7wJk+S4j8Wlxxnw6PsvK3dNp8Pfszx0pEkE6PP3nJZJn6xjwKR7lPtgFqnhb/T1P95I5t+6Ozmte6ZyM=
X-Received: by 2002:a05:6402:5146:: with SMTP id n6mr2602244edd.357.1632775586965;
 Mon, 27 Sep 2021 13:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210914204800.3945732-1-robh@kernel.org>
In-Reply-To: <20210914204800.3945732-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Sep 2021 15:46:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBDTt_SfaqRkr6jKoCnBg=acn=p+6rY32k=FyMWS16ug@mail.gmail.com>
Message-ID: <CAL_JsqJBDTt_SfaqRkr6jKoCnBg=acn=p+6rY32k=FyMWS16ug@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] arm64 userspace counter support
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 3:48 PM Rob Herring <robh@kernel.org> wrote:
>
> Another version of arm64 userspace counter access support.

Any chance someone can review this... Ideally before the end of the
cycle this time so there's time for me to respin if needed.


> The arm64 support departs from the x86 implementation by requiring the user
> to explicitly request user access (via attr.config1) and only enables access
> for task bound events. Since usage is explicitly requested, access is
> enabled at perf_event_open() rather than on mmap() as that greatly
> simplifies the implementation. Rather than trying to lock down the access
> as the x86 implementation has been doing, we can start with only a limited
> use case enabled and later expand it if needed.
>
> I've run this version thru Vince's perf tests[12] with arm64 support added.
> I wish I'd found these tests sooner...
>
> This originally resurrected Raphael's series[1] to enable userspace counter
> access on arm64. My previous versions are here[2][3][4][5][6][7][8][9][10].
> A git branch is here[11].
>
> Changes in v10:
>  - Drop changing event_mapped/event_unmapped ops to run on the event's
>    current CPU. This won't work for x86 where any thread sharing an mm
>    context will have rdpmc enabled. Instead, simply track user access
>    events when added to a perf context and use that count.
>  - Documentation for the sysctl disable
>
> Changes in v9:
>  - Reworked x86 and perf core to handle user access tracking and call
>    .event_mapped() and .event_unmapped() on the CPU with the event like
>    other changes to events.
>  - Use sysctl instead of sysfs to disable user access.
>
> Changes in v8:
>  - Restrict user access to thread bound events which simplifies the
>    implementation. A couple of perf core changes (patches 1 and 2) are
>    needed to do this.
>  - Always require the user to request userspace access.
>
> Changes in v7:
>  - Handling of dirty counter leakage and reworking of context switch and
>    user access enabling. The .sched_task hook and undef instruction handler
>    are now utilized. (Patch 3)
>  - Add a userspace disable switch like x86. (Patch 5)
>
> Changes in v6:
>  - Reworking of the handling of 64-bit counters and user access. There's
>    a new config1 flag to request user access. This takes priority over
>    the 64-bit flag and the user will get the maximum size the h/w
>    supports without chaining.
>  - The libperf evsel mmap struct is stored in its own xyarray
>  - New tests for user 64-bit and 32-bit counters
>  - Rebase to v5.12-rc2
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
> Rob
>
>
> [1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
> [2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
> [3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
> [4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
> [5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
> [6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
> [7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
> [8] https://lore.kernel.org/r/20210420031511.2348977-1-robh@kernel.org/
> [9] https://lore.kernel.org/r/20210517195405.3079458-1-robh@kernel.org/
> [10] https://lore.kernel.org/all/20210806225123.1958497-1-robh@kernel.org/
> [11] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm64-user-perf-event-v10
> [12] https://github.com/deater/perf_event_tests
>
> Raphael Gault (1):
>   Documentation: arm64: Document PMU counters access from userspace
>
> Rob Herring (4):
>   x86: perf: Move RDPMC event flag to a common definition
>   perf: Add a counter for number of user access events in context
>   arm64: perf: Add userspace counter access disable switch
>   arm64: perf: Enable PMU counter userspace access for perf event
>
>  Documentation/admin-guide/sysctl/kernel.rst |  11 ++
>  Documentation/arm64/perf.rst                |  73 +++++++++++-
>  arch/arm64/kernel/perf_event.c              | 126 ++++++++++++++++++--
>  arch/x86/events/core.c                      |  10 +-
>  arch/x86/events/perf_event.h                |   2 +-
>  include/linux/perf_event.h                  |   3 +
>  kernel/events/core.c                        |   4 +
>  7 files changed, 215 insertions(+), 14 deletions(-)
>
> --
> 2.30.2
