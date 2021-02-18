Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4532F31E8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhBRKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:34:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12190 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBRJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:25:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dh8P51PK6zlLl2;
        Thu, 18 Feb 2021 17:22:17 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 17:24:02 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hagen@jauu.net>, <john.wanghui@huawei.com>,
        <abudankov@huawei.com>, <yz.yuzhou@huawei.com>
Subject: [PATCH v4 2/2] perf tools: Add documentation for 'perf irq' command
Date:   Thu, 18 Feb 2021 18:43:12 +0800
Message-ID: <20210218104312.50171-3-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218104312.50171-1-cuibixuan@huawei.com>
References: <20210218104312.50171-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'perf irq' command.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 tools/perf/Documentation/perf-irq.txt | 47 +++++++++++++++++++++++++++
 tools/perf/command-list.txt           |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-irq.txt

diff --git a/tools/perf/Documentation/perf-irq.txt b/tools/perf/Documentation/perf-irq.txt
new file mode 100644
index 000000000000..8f1c466c3d6b
--- /dev/null
+++ b/tools/perf/Documentation/perf-irq.txt
@@ -0,0 +1,47 @@
+perf-irq(1)
+=============
+
+NAME
+----
+perf-irq - Tool to trace/measure hardware interrupts
+
+SYNOPSIS
+--------
+[verse]
+'perf irq' [<options>] {record|report}
+
+DESCRIPTION
+-----------
+There are several variants of 'perf irq':
+
+  'perf irq record <command>' to record the irq handler events
+  of an arbitrary workload.
+
+  'perf irq report' to calculate the time consumed by each
+   hardware interrupt processing function.
+
+    Example usage:
+        perf irq record -- sleep 1
+        perf irq report
+
+   By default it shows the individual irq events, including the irq name,
+   cpu(execute the hardware interrupt processing function), time consumed,
+   entry time and exit time for the each hardware irq:
+
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     enp2s0f2-tx-0    | [0006] |      0.000001 s |   6631263.313329 s |   6631263.313330 s
+     megasas          | [0013] |      0.000003 s |   6631263.209564 s |   6631263.209567 s
+     acpi             | [0016] |      0.000018 s |   6631263.085787 s |   6631263.085805 s
+
+
+OPTIONS for 'perf irq'
+----------------------------
+
+--cpus::
+	Show just entries with activities for the given CPUs.
+
+SEE ALSO
+--------
+linkperf:perf-record[1]
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index bc6c585f74fc..c5224ea3ac71 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -26,6 +26,7 @@ perf-report			mainporcelain common
 perf-sched			mainporcelain common
 perf-script			mainporcelain common
 perf-stat			mainporcelain common
+perf-irq			mainporcelain common
 perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
-- 
2.17.1

