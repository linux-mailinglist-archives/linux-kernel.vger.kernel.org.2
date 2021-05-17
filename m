Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D89383DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhEQTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:26 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37680 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbhEQTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:24 -0400
Received: by mail-ot1-f43.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so6620337otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMI1NGkyA9KDseWfqagnDt+aMEJhhRHqdf6sB+Zl3RY=;
        b=qM5xPG/6bgbTrZe2q5uEM0SdlIQfDfAk4iXGXTcUctBEtNdmASCtQaYODCGoc3dexS
         SRsNUgfPM776hAmOldrMJRLsj92Buf9m24I8kuJfw4eB5WfrsvKTAfdBhYm2+OL2MOhv
         hsQLHy3nn60b1/XQAYyLUXQsLuviWhu1HBILfLvK2GclsRRl/p5H8qNY2w49vvFTj375
         mQgqXPFfLwb1T5+ymsuuIPyVIvbb+qIWbm2MoVNsdAADU32+7B0ND8hzzXpB+EWkQgNI
         I8+hHTpvrvGNu6i8/XBxON5y6QZZogNBivAOBjkhdDF++L4fjLfBUZv5fHvhhoK/+g9+
         1fGQ==
X-Gm-Message-State: AOAM530odesGPe8y4I4T+phOASTOQBRK0dfZfpXDFxbY87Dr7ucg/YkN
        mz3UPgML3rGo6PCAQrGbkE8YvwyDVQ==
X-Google-Smtp-Source: ABdhPJyFrWyrEN7G2NNq23CHUzxxCHwIuIUMabui/qfH19Yl2FvJaX0moj81sOdSqqc7Wszj/9EnTQ==
X-Received: by 2002:a9d:4584:: with SMTP id x4mr1002973ote.85.1621281247451;
        Mon, 17 May 2021 12:54:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] arm64 userspace counter support
Date:   Mon, 17 May 2021 14:54:00 -0500
Message-Id: <20210517195405.3079458-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another version of arm64 userspace counter access support. This is just the
Arm bits as Arnaldo asked to send the tools separately. The bulk of the
libperf changes landed in 5.13-rc1.

This version departs from the x86 implementation by requiring the user
to always explicitly request user access (via attr.config1) and only
enables access for task bound events. Rather than trying to lock down the
access as the x86 implementation has been doing, we can start with only a
limited use case enabled and later expand it if needed.

This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5][6][7][8]. A git
branch is here[9].


Changes in v8:
 - Restrict user access to thread bound events which simplifies the
   implementation. A couple of perf core changes (patches 1 and 2) are
   needed to do this.
 - Always require the user to request userspace access.

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

Rob


[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
[7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
[8] https://lore.kernel.org/r/20210420031511.2348977-1-robh@kernel.org/
[9] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm64-user-perf-event-v8


Kan Liang (1):
  perf: Track per-PMU sched_task() callback users

Raphael Gault (1):
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (3):
  perf: Add a counter for number of user access events in context
  arm64: perf: Enable PMU counter userspace access for perf event
  arm64: perf: Add userspace counter access disable switch

 Documentation/arm64/perf.rst   |  68 ++++++++++-
 arch/arm64/kernel/perf_event.c | 201 +++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |  11 +-
 include/linux/perf_event.h     |   4 +
 kernel/events/core.c           |   8 +-
 5 files changed, 279 insertions(+), 13 deletions(-)

--
2.27.0
