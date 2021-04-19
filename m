Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE19E364D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhDSVut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:50:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:61937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhDSVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:50:41 -0400
IronPort-SDR: kELDPFvffylkWMOCTrCOTtUX78B6jgtrWcPpZbrrQFZ3oSaLM3Wrz/XZJ8U2zQucrXLljdZ4br
 6hr3FB4NP1CQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193279424"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="193279424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:50:10 -0700
IronPort-SDR: grzhUimw1W1XjtcD4r2oLDdVuWE6wIectyzuwZG8Dc+qV9iMe7fIGViXZ8ad7UdB23Z2He/eMg
 RFUvtneltV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="534277605"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2021 14:50:10 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/4] Documentation/x86: Add buslock.rst
Date:   Mon, 19 Apr 2021 21:49:55 +0000
Message-Id: <20210419214958.4035512-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419214958.4035512-1-fenghua.yu@intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buslock.rst to explain bus lock problem and how to detect and
handle it.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/buslock.rst | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/x86/buslock.rst

diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
new file mode 100644
index 000000000000..4deaf8b82338
--- /dev/null
+++ b/Documentation/x86/buslock.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Bus lock detection and handling
+===============================
+
+:Copyright: |copy| 2021 Intel Corporation
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Tony Luck <tony.luck@intel.com>
+
+Problem
+=======
+
+A split lock is any atomic operation whose operand crosses two cache lines.
+Since the operand spans two cache lines and the operation must be atomic,
+the system locks the bus while the CPU accesses the two cache lines.
+
+A bus lock is acquired through either split locked access to writeback (WB)
+memory or any locked access to non-WB memory. This is typically thousands of
+cycles slower than an atomic operation within a cache line. It also disrupts
+performance on other cores and brings the whole system to its knees.
+
+Detection
+=========
+
+Intel processors may support either or both of the following hardware
+mechanisms to detect split locks and bus locks.
+
+#AC exception for split lock detection
+--------------------------------------
+
+Beginning with the Tremont Atom CPU split lock operations may raise an
+Alignment Check (#AC) exception when a split lock operation is attemped.
+
+#DB exception for bus lock detection
+------------------------------------
+
+Some CPUs have ability to notify the kernel by an #DB trap after a user
+instruction acquires a bus lock and is executed. This allows the kernel
+to enforce user application throttling or mitigation.
+
+Software handling
+=================
+
+The kernel #AC and #DB handlers handle bus lock based on kernel parameter
+"split_lock_detect". Here is a summary of different options:
+
++------------------+----------------------------+-----------------------+
+|split_lock_detect=|#AC for split lock		|#DB for bus lock	|
++------------------+----------------------------+-----------------------+
+|off	  	   |Do nothing			|Do nothing		|
++------------------+----------------------------+-----------------------+
+|warn		   |Kernel OOPs			|Warn once per task and |
+|(default)	   |Warn once per task and	|and continues to run.  |
+|		   |disable future checking	|			|
+|		   |When both features are	|			|
+|		   |supported, warn in #AC	|			|
++------------------+----------------------------+-----------------------+
+|fatal		   |Kernel OOPs			|Send SIGBUS to user.	|
+|		   |Send SIGBUS to user		|			|
+|		   |When both features are	|			|
+|		   |supported, fatal in #AC	|			|
++------------------+----------------------------+-----------------------+
+
+Usages
+======
+
+Detecting and handling bus lock may find usages in various areas:
+
+It is critical for real time system designers who build consolidated real
+time systems. These systems run hard real time code on some cores and
+run "untrusted" user processes on some other cores. The hard real time
+cannot afford to have any bus lock from the untrusted processes to hurt
+real time performance. To date the designers have been unable to deploy
+these solutions as they have no way to prevent the "untrusted" user code
+from generating split lock and bus lock to block the hard real time code
+to access memory during bus locking.
+
+It may also find usage in cloud. A user process with bus lock running
+in one guest can block other cores from accessing shared memory.
+
+Bus lock may open a security hole where malicious user code may slow
+down overall system by executing instructions with bus lock.
+
+
+Guidance
+========
+off
+---
+
+Disable checking for split lock and bus lock. This option may be
+useful if there are legacy applications that trigger these events
+at a low rate so that mitigation is not needed.
+
+warn
+----
+
+The bus lock is warned so that it can be found and fixed. This is the
+default behavior.
+
+It may be useful to find and fix bus lock. The warning information has
+process id and faulting instruction address to help pin point bus lock
+and fix it.
+
+fatal
+-----
+
+In this case, the bus lock is not tolerated and the process is killed.
+
+It is useful in hard real time system.
-- 
2.31.1

