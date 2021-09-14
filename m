Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F040B976
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhINUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:49:33 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34640 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhINUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:49:25 -0400
Received: by mail-ot1-f49.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso444648otp.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfnaBiDsLPqKzOMV5CVhITztcfRvCrW3VSv1OWMoIhk=;
        b=lLQ7neYe2bej+keUZvl+qA5fw8421v9Kv6cs/TsDOHbq441h2p5j93eKUUeamZstGI
         BoJNdQweknBEE9tCfgKPIy9WsqFyHryxiXKlPcwgfNJogtuj5w2o18xqgYdENfxwocl7
         +905T84DHc6wHCQ6iNclbubkmuIsYxewswMmksqq9nqatpyvojw3ys5mtDEhaxFiK67l
         Zwq7WTEfV1a8KGOkyx2cKp68tR5A8DarCRk3VxNV52L1ih837PxNq7lt4bR/ZRPF1elH
         tPv+rJOV2xTLbMTMFbKyqKjNR4uB7mi1Uhiz+Hr6jRJ+vukV0ff9qE+3M9gStho+lJ2P
         WkiA==
X-Gm-Message-State: AOAM533O9lwpNJVKmGiFFVUaVqv3lXdABG1RIRtMhPZnFtB30Ot0DhPR
        YgUP88OpnYfshhhBId8I9w==
X-Google-Smtp-Source: ABdhPJwVkq10fOJ3f6j946OdxDX/wCFWm8z6hMh+8f24Q5aunO2lKzUeMK9w3aFhxFYnHljIP6WA4A==
X-Received: by 2002:a05:6830:154a:: with SMTP id l10mr16657470otp.97.1631652487422;
        Tue, 14 Sep 2021 13:48:07 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y14sm2883236oti.69.2021.09.14.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:48:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/5] Documentation: arm64: Document PMU counters access from userspace
Date:   Tue, 14 Sep 2021 15:48:00 -0500
Message-Id: <20210914204800.3945732-6-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914204800.3945732-1-robh@kernel.org>
References: <20210914204800.3945732-1-robh@kernel.org>
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
v10:
 - Add details on perf_user_access sysctl
v9:
 - No change
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
 Documentation/arm64/perf.rst | 73 +++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..47980c9058e3 100644
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
 
@@ -88,3 +91,71 @@ exclude_host. However when using !exclude_hv there is a small blackout
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
+In order to have access to the hardware counters, the global sysctl
+kernel/perf_user_access must first be enabled:
+
+.. code-block:: sh
+
+  echo 1 > /proc/sys/kernel/perf_user_access
+
+It is necessary to open the event using the perf tool interface with config1:1
+attr bit set: the sys_perf_event_open syscall returns a fd which can
+subsequently be used with the mmap syscall in order to retrieve a page of memory
+containing information about the event. The PMU driver uses this page to expose
+to the user the hardware counter's index and other necessary data. Using this
+index enables the user to access the PMU registers using the `mrs` instruction.
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
2.30.2

