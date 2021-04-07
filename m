Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20144356868
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350312AbhDGJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:51:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16376 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbhDGJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:51:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFfks249QzlVj4;
        Wed,  7 Apr 2021 17:49:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:51:36 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] docs: perf: Add description for HiSilicon PCIe PMU driver
Date:   Wed, 7 Apr 2021 17:49:03 +0800
Message-ID: <1617788943-52722-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
References: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported on
HiSilicon HIP09 platform, and document it to provide guidance on how to
use it.

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst | 103 +++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
new file mode 100644
index 0000000..8942498
--- /dev/null
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -0,0 +1,103 @@
+================================================
+HiSilicon PCIe Performance Monitoring Unit (PMU)
+================================================
+
+HiSilicon PCIe Performance Monitoring Unit (PMU) is a PCIe Root Complex
+integrated End Point(RCiEP) device. On Hip09, each PCIe Core has a PMU RCiEP
+to monitor multi root ports and all Endpoints downstream these root ports.
+
+HiSilicon PCIe PMU is supported to collect performance data of PCIe bus, such
+as: bandwidth, latency etc.
+
+
+HiSilicon PCIe PMU driver
+=========================
+
+The PCIe PMU driver registers a perf PMU with the name of its sicl-id and PCIe
+core id.::
+
+  /sys/bus/event_source/hisi_pcie<sicl>_<core>
+
+PMU driver provides description of available events and filter options in sysfs,
+see /sys/bus/event_source/devices/hisi_pcie<sicl>_<core>.
+
+The "format" directory describes all formats of the config (events) and config1
+(filter options) fields of the perf_event_attr structure. The "events" directory
+describes all documented events shown in perf list.
+
+The "identifier" sysfs file allows users to identify the version of the
+PMU hardware device.
+
+The "bus" sysfs file allows users to get the bus number of root ports
+monitored by PMU.
+
+Example usage of perf::
+
+  $# perf list
+  hisi_pcie0_0/bw_rx/ [kernel PMU event]
+  ------------------------------------------
+
+  $# perf stat -e hisi_pcie0_0/bw_rx/ sleep 5
+
+The current driver does not support sampling. So "perf record" is unsupported.
+Also attach to a task is unsupported for PCIe PMU.
+
+Filter options
+--------------
+
+1. Target filter
+PMU could only monitor the performance of traffic downstream target root ports
+or traffic of target Endpoint. PCIe PMU driver support "port" and "bdf"
+interfaces for users, and this two interfaces isn't supported at the same time.
+
+-port
+"port" filter can be used in all PCIe PMU events, target root port can be
+selected by configure the bitmap "port". Multi ports can be selected for
+AP-layer-events, and only one port can be selected for TL/DL-layer-events.
+
+For example, if target root port is 0000:00:00.0(x8 lanes), bit0 should be
+selected, port=0x1; if target root port is 0000:00:04.0(x4 lanes), bit8 is set,
+port=0x100; if these two root port are both monitored, port=0x101.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,port=0x1/ sleep 5
+
+-bdf
+
+"bdf" filter can only be used in bandwidth events, target Endpoint is selected
+by configure BDF to "bdf". Counter only counts the bandwidth of message
+requested by target Endpoint.
+
+For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,bdf=0x3900/ sleep 5
+
+2. Trigger filter
+event statistics start when the first time TLP length is greater/smaller
+than trigger condition. You can set the trigger condition by write
+"trig_len", and set the trigger mode by write "trig_mode". This filter can only
+be used in bandwidth events.
+
+For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
+means statistics start when TLP length > trigger condition, "trig_mode=1"
+means start When TLP length < condition.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,trig_len=0x4,trig_mode=1/ sleep 5
+
+3. Threshold filter
+counter counts when TLP length within the specified range. You can set the
+threshold by write "thr_len", and set the threshold mode by write "thr_mode".
+This filter can only be used in bandwidth events.
+
+For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
+statistics when TLP length >= threshold, and "thr_mode=1" means statistics
+when TLP length < threshold.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.8.1

