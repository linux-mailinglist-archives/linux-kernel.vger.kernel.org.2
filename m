Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54381383DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhEQTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:46 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45614 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhEQTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:34 -0400
Received: by mail-ot1-f53.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6589877otc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ox5Uad03HIvUneUEV0ZALlKBmbYKT82BLfWq3q/UJso=;
        b=PLcV2wDMYCx5XhJFjFTYP54mzXTwMg9A/dCHe9Iim6SARtE0qQx58uDiuEco+qL2Q+
         Z8ACw2pUeZMuS1KY0GfuS4M9jsjtZqTQGhve6YskNlSNlAdCPevH85yHfa4k4PZgWm6x
         W35jj1/WGLduf/PVamzXLaJDfJVC8d1SLl4JdLeh7kEs4t95dvDHl3hPuyzugwuIh+9Z
         btC2GM/V/R5Snnuz7mQsV6iMY6SGmdf4Ln6wNk45AHOGYSqzgAp3dzeRkrSsij4wvSo6
         WQBe+A3bZYVyBQdWpx1x+JPXf/eCaPlfu+IEn4HkkEbevQnJo+u6EN2hkacThjpC6bmF
         LnBg==
X-Gm-Message-State: AOAM530tT0De17oocZS77KWVC6Znw3vFJbpcVckcWILPE8aGjLVzEtje
        GOgZMMuD5BujQordDAIf7w==
X-Google-Smtp-Source: ABdhPJxA55TueFl6ZH0b8jUa6655l5IlMrQ6hNVNItlskSFPY1EzoUbAAg7NtPBD/z5noHYY2Xiaqg==
X-Received: by 2002:a9d:6244:: with SMTP id i4mr1019131otk.182.1621281257538;
        Mon, 17 May 2021 12:54:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:16 -0700 (PDT)
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
Subject: [PATCH v8 5/5] Documentation: arm64: Document PMU counters access from userspace
Date:   Mon, 17 May 2021 14:54:05 -0500
Message-Id: <20210517195405.3079458-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517195405.3079458-1-robh@kernel.org>
References: <20210517195405.3079458-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add documentation to describe the access to the pmu hardware counters from
userspace.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Reword that config1:1 must always be set to request user access
v7:
 - Merge into existing arm64 perf.rst
v6:
  - Update the chained event section with attr.config1 details
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/perf.rst | 68 +++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..5dcbb508586f 100644
--- a/Documentation/arm64/perf.rst
+++ b/Documentation/arm64/perf.rst
@@ -2,7 +2,10 @@
 
 .. _perf_index:
 
-=====================
+====
+Perf
+====
+
 Perf Event Attributes
 =====================
 
@@ -88,3 +91,66 @@ exclude_host. However when using !exclude_hv there is a small blackout
 window at the guest entry/exit where host events are not captured.
 
 On VHE systems there are no blackout windows.
+
+Perf Userspace PMU Hardware Counter Access
+==========================================
+
+Overview
+--------
+The perf userspace tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 PMUv3 which makes sure that the access to the pmu
+registers is enabled and that the userspace has access to the relevant
+information in order to use them.
+
+In order to have access to the hardware counter it is necessary to open the 
+event using the perf tool interface with config1:1 attr bit set: the 
+sys_perf_event_open syscall returns a fd which can subsequently be used 
+with the mmap syscall in order to retrieve a page of memory containing 
+information about the event. The PMU driver uses this page to expose to 
+the user the hardware counter's index and other necessary data. Using 
+this index enables the user to access the PMU registers using the `mrs` 
+instruction.
+
+The userspace access is supported in libperf using the perf_evsel__mmap()
+and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
+an example.
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
+
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About chained events and 64-bit counters
+----------------------------------------
+Chained events are not supported in conjunction with userspace counter
+access. If a 64-bit counter is requested (attr.config1:0) with userspace 
+access (attr.config1:1 set), then counter chaining will be disabled. The 
+'pmc_width' in the user page will indicate the actual width of the 
+counter which could be only 32-bits depending on the event and PMU 
+features.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/lib/perf/tests/test-evsel.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
-- 
2.27.0

