Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2C336868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCKAJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:09:20 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:34590 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCKAJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:09:06 -0500
Received: by mail-il1-f172.google.com with SMTP id z9so17349616iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ISI1TwK8sb//N2exM9wtzOedA3xOrD5ap67pLbwpeo=;
        b=e7guVSiSy6xB+OY2qic/5LcpGuAM6csyf/8h5UysiW4VD9VrckMEaYlMMZASpxj8Lk
         vsJacJA7WS18ubWH+XCPx3ioOYLqt3AMuULj87QK9iG6zFBSlKY/gOE6Fg51/8TS8ghI
         6KKBYd+0a/53hFobsrg+1ms73Mhw/b1sNpABYCqy/BhWToBbuwAevcpuH93DoLO0AdEa
         7nDbFGTl3Td158281k3HjrZ9BLR3B7v8a+E+6F13i3KJn1vY0gxtbu9RX41S4qaTCo4c
         D2pxVkBodLi+w5kcF+P9GXKan38su6u6ju93BhKGJ2FD54RiXSCgtm38szW8ENkADRa0
         x0CQ==
X-Gm-Message-State: AOAM533hT8I3lwzi3SoLse9NVdkPhW7wjOg4ohYNFa/oFwfSyJ9pf27B
        KmPf0hmhu7D2VMg2nHbi3qxXbyCMAQ==
X-Google-Smtp-Source: ABdhPJw3VT0teNDr1ZSyUhPv7ecgc6NmCXiK+9J6AJ8yDiDtov4G3gc2zV26vLRdi5J3Q8Is2MyYUg==
X-Received: by 2002:a05:6e02:216f:: with SMTP id s15mr4871981ilv.81.1615421346262;
        Wed, 10 Mar 2021 16:09:06 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id x17sm484351ilm.40.2021.03.10.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:09:05 -0800 (PST)
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
Subject: [PATCH v6 10/10] Documentation: arm64: Document PMU counters access from userspace
Date:   Wed, 10 Mar 2021 17:08:37 -0700
Message-Id: <20210311000837.3630499-11-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311000837.3630499-1-robh@kernel.org>
References: <20210311000837.3630499-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add a documentation file to describe the access to the pmu hardware
counters from userspace

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v6:
  - Update the chained event section with attr.config1 details
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/index.rst                 |  1 +
 .../arm64/perf_counter_user_access.rst        | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 97d65ba12a35..eb7b1cabbf08 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -18,6 +18,7 @@ ARM64 Architecture
     memory
     memory-tagging-extension
     perf
+    perf_counter_user_access
     pointer-authentication
     silicon-errata
     sve
diff --git a/Documentation/arm64/perf_counter_user_access.rst b/Documentation/arm64/perf_counter_user_access.rst
new file mode 100644
index 000000000000..a42800e72458
--- /dev/null
+++ b/Documentation/arm64/perf_counter_user_access.rst
@@ -0,0 +1,60 @@
+=============================================
+Access to PMU hardware counter from userspace
+=============================================
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
+The focus is set on the armv8 pmuv3 which makes sure that the access to the pmu
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
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
-- 
2.27.0

