Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA532488A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhBYBbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:31:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12574 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhBYBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:31:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DmFYY5kkWzMdsy;
        Thu, 25 Feb 2021 09:28:49 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Feb 2021
 09:30:44 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hagen@jauu.net>, <john.wanghui@huawei.com>,
        <abudankov@huawei.com>, <yz.yuzhou@huawei.com>
Subject: [PATCH v5 2/2] perf tools: Add documentation for 'perf irq' command
Date:   Thu, 25 Feb 2021 09:30:16 +0800
Message-ID: <20210225013016.67100-3-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210225013016.67100-1-cuibixuan@huawei.com>
References: <20210225013016.67100-1-cuibixuan@huawei.com>
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
index 825a12e8d694..bf56178d2895 100644
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

