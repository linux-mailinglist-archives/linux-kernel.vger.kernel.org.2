Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D173650BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhDTDQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:20 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:34584 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhDTDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:16:02 -0400
Received: by mail-oo1-f47.google.com with SMTP id m25-20020a4abc990000b02901ed4500e31dso1216572oop.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNdvbsEMRO0fI8eAuDBOQGRWp+U15lnQujv4W2LToH4=;
        b=FsS5WZZ5XetyQc2od7jCgXFpJmyAFweOtMtSVz+mq6OoJKm7zRQqynRDGJfQAhC7PD
         z+4JsuOGaT+s6ai72e4docNyixnpKxFZyDIYJlm/kCzw7ORbGGnxH2R0JCmrKgtX7+lI
         svzr/B2wmXRfFcqQNedYYyAOlefKA/a0bt8dPi0t/Vf3c3f6C1ncrDkZrlvINqAx2kLQ
         IoaAHpDloSwpw7K2T9t5aoboMknwV5evbGF5Gggn9ywSFrl+adqe6eswNz+GI0Tpevz7
         pEDj3u9dDVdL5H6YdgmrcXgtvtUMnMNGQPsnOlN2ehCpu6vQcX2OxXjKjC/JIVh8PGRY
         sk9A==
X-Gm-Message-State: AOAM532GVmekZOUjgUWUfo3Ygj0H5LzLAgyGaFX2zJTW3ndXQgPQjPEm
        7AZwULfEF+e9p+vj0zu8og==
X-Google-Smtp-Source: ABdhPJwmQaQsMHpbrHoIEEqn7KRtQOxiXHAhGFQEMqx5RE7tJm6hTVC4Ogf9URq2UFwBsXqiodgnVw==
X-Received: by 2002:a4a:d80e:: with SMTP id f14mr12625074oov.54.1618888529160;
        Mon, 19 Apr 2021 20:15:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:28 -0700 (PDT)
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
Subject: [PATCH v7 9/9] Documentation: arm64: Document PMU counters access from userspace
Date:   Mon, 19 Apr 2021 22:15:11 -0500
Message-Id: <20210420031511.2348977-10-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
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
 Documentation/arm64/perf.rst | 67 +++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..c40fc2adc451 100644
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
 
@@ -88,3 +91,65 @@ exclude_host. However when using !exclude_hv there is a small blackout
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
+In order to have access to the hardware counter it is necessary to open the event
+using the perf tool interface: the sys_perf_event_open syscall returns a fd which
+can subsequently be used with the mmap syscall in order to retrieve a page of
+memory containing information about the event.
+The PMU driver uses this page to expose to the user the hardware counter's
+index and other necessary data. Using this index enables the user to access the
+PMU registers using the `mrs` instruction.
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
+access. If a 64-bit counter is requested (attr.config1:0), then
+userspace access must also be requested with attr.config1:1 set. This
+will disable counter chaining. The 'pmc_width' in the user page will
+indicate the actual width of the counter which could be only 32-bits
+depending on event and PMU features.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/lib/perf/tests/test-evsel.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
-- 
2.27.0

