Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17C3CD3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhGSKlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:41:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11343 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhGSKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:39:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GSzlb47pFz7tDP;
        Mon, 19 Jul 2021 19:15:07 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:19:41 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:19:41 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH 1/2] Documentation: tracing: Documentation for ultrasoc SMB drivers
Date:   Mon, 19 Jul 2021 19:17:36 +0800
Message-ID: <20210719111737.47891-2-liuqi115@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719111737.47891-1-liuqi115@huawei.com>
References: <20210719111737.47891-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ultrasoc trace module is a system level solution for tracing, and SMB
is the component in trace module to store trace message. This patch
brings in a documentation for ultrasoc SMB driver and simple introduces
how to use ultrasoc SMB by sysfs interface and perf interface.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 .../trace/coresight/ultrasoc-trace.rst        | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst

diff --git a/Documentation/trace/coresight/ultrasoc-trace.rst b/Documentation/trace/coresight/ultrasoc-trace.rst
new file mode 100644
index 000000000000..dee133e27bf3
--- /dev/null
+++ b/Documentation/trace/coresight/ultrasoc-trace.rst
@@ -0,0 +1,193 @@
+=======================================================
+Siemens Embedded Analytics - HW Assisted Tracing on SoC
+=======================================================
+   :Author:   Jonathan Zhou <Jonathan.zhouwen@huawei.com>
+              Qi Liu <liuqi115@huawei.com>
+   :Date:     July 8th, 2021
+
+Introduction
+------------
+
+This document is concerned with the Siemens Embedded Analytics Framework,
+using for tracing of multiple type SoC. As this module is developed by
+Ultrasoc technology, which is acquired by Siemens, we still use "Ultrasoc"
+to name document and structures.
+
+System Memory Buffer is an important component in this Analytics Framework,
+it provides a way to buffer and store messages in system memory. It provides
+a capability to store messages received on its input message interface to an
+area of system memory.
+
+A typical Siemens trace system would look like the following diagram:
+                           @@@@@@@@@@@@@
+                           @    CPU    @
+                           @@@@@@@@@@@@@
+                           #############
+                           # Coresight #
+                             #  ETM  #
+                              #######
+                                ###
+                                 #
+                                 |
+                                 *
+                    *******************************
+                 *** AMBA Advanced Trace Bus (ATB) ***
+                    ***************^***************
+                          ===============    |
+                           === FUNNEL ==<--- |
+                              =======
+                                 |
+                                 *
+                              @@@@@@@
+                              @ TRC @
+                               @@@@@
+                                @@@
+                                 @
+                                 |
+                                 *
+    ************************************** *******************
+ ************************ Message BUS ***************************
+    ******************^************************^****************
+             |                               |
+     @@@@@@@@@@@@@@@@@@                      |   @@@@@@@@@@@@
+     @ Message Engine @                      |   @ JTAG COM @
+     @@@@@@@@@@@@@@@@@@                      |    @@@@@@@@@@
+             |                               |---> @@@@@@@@
+             |                                      @@@@@@
+          @@@@@@@                                      |
+          @ SMB @                                     JTAG
+           @@@@@
+            @@@
+             @
+             |
+             |
+             *
+  ***************************************************************
+ **************************** AMBA AXI  ****************************
+  *****************************************************************
+
+Acronyms
+---------------------------
+
+Acronyms:
+
+SMB:         System Memory Buffer
+TRC:         Trace receiver
+
+Framework and implementation
+------------------------------
+
+SMB is implemented as platform device, each SCCL has one SMB device.
+
+As TRC receives data from coresight ETM device, SMB can use the following API
+to register into coresight framework as a sink device:
+.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
+.. c:function:: void coresight_unregister(struct coresight_device *csdev);
+
+Then users can get trace data by this path: ETM->funnel->SMB.
+More information about coresight framework can be found in
+Documention/trace/coresight/coresight.rst.
+
+If everything goes well, the relationship of Embedded Analytics devices will be
+described under the sysfs::
+
+    $# ls /sys/bus/platform/devices/
+    <HID.smb>:00
+    $# ls /sys/bus/coresight/devices/
+    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
+    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
+    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
+    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
+    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
+    etm13    etm19    etm24    etm3     etm7     funnel3
+    $# ls -l /sys/bus/coresight/devices/funnel0/connections/
+    <file details> in:0 -> ../../../../system/cpu/cpu0/ARMHC500:00/etm0
+    <file details> in:1 -> ../../../../system/cpu/cpu1/ARMHC500:01/etm1
+    <file details> in:2 -> ../../../../system/cpu/cpu2/ARMHC500:02/etm2
+    <file details> in:3 -> ../../../../system/cpu/cpu3/ARMHC500:03/etm3
+    <file details> nr_links
+    <file details> out:0 -> ../../../HISI0391:00/HISI03A1:00/sink_smb0
+    $# ls -l /sys/bus/coresight/devices/sink_smb0/connections/
+    <file details>  in:101 -> ../../../../ARMHC9FE:05/funnel5
+    <file details>  in:114 -> ../../../../ARMHC9FE:07/funnel7
+    <file details>  in:121 -> ../../../../ARMHC9FE:03/funnel3
+    <file details>  in:39 -> ../../../../ARMHC9FE:00/funnel0
+    <file details>  in:51 -> ../../../../ARMHC9FE:04/funnel4
+    <file details>  in:61 -> ../../../../ARMHC9FE:06/funnel6
+    <file details>  in:68 -> ../../../../ARMHC9FE:02/funnel2
+    <file details>  in:89 -> ../../../../ARMHC9FE:01/funnel1
+    <file details>  nr_links
+
+How to use the Embedded Analytics trace module
+-----------------------------------------------
+
+There are two ways to use the Embedded Analytics trace module:
+
+1. interacting directly with the devices using the sysFS interface.
+2. using the perf cmd line tools.
+
+1) Using the sysFS interface:
+
+Before trace collection can start, a coresight sink needs to be identified.
+There is no limit on the amount of sinks (nor sources) that can be enabled at
+any given moment.  As a generic operation, all device pertaining to the sink
+class will have an "active" entry in sysfs::
+
+    $# ls /sys/bus/coresight/devices/
+    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
+    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
+    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
+    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
+    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
+    etm13    etm19    etm24    etm3     etm7     funnel3
+    $# ls /sys/bus/coresight/devices/sink_smb0
+    connections  enable_sink  firmware_node  power  subsystem  uevent
+    $# echo 1 > /sys/bus/coresight/devices/sink_smb0/enable_sink
+    $# cat /sys/bus/coresight/devices/sink_smb0/enable_sink
+    1
+
+When start trace collection, etm devices corresponding to the enabled sink
+should be selected::
+
+    $# echo 1 > /sys/bus/coresight/devices/etm0/enable_source
+    $# cat /sys/bus/coresight/devices/etm0/enable_source
+    1
+    $# cat /sys/bus/platform/devices/<HID.smb>:00/com_status
+    com-type            : DOWN-ONLY
+    service status      : stopped
+    interrupt status    : 0x00000003
+    write point         : 0x5437f400   <----- The write pointer is moving
+
+Trace collection is stopped the same way::
+
+    $# echo 0 > /sys/bus/coresight/devices/etm0/enable_source
+    $# echo 0 > /sys/bus/coresight/devices/sink_smb0/enable_sink
+
+The content of the SMB buffer can be harvested directly from /dev::
+
+    $# dd if=/dev/sink_smb0 of=~/cstrace.bin
+    5233+0 records in
+    5233+0 records out
+    2679296 bytes (2.7 MB) copied, 0.0131708 s, 203 MB/s
+
+    root:/sys/bus/coresight/devices#
+
+The file cstrace.bin can be decompressed using "ptm2human".
+
+2) Using perf framework:
+
+As SMB device has been registered with coresight framework, perf tool can be
+used to control Embedded Analytics trace collection, and the method is similar
+to using perf to do coresight trace collection.
+
+The only thing to note is, list of cpus should be correspond to the specified
+sink device.
+
+Example usage of perf::
+
+	 $# ./perf list pmu
+	 cs_etm//                                    [Kernel PMU event]
+    $# ./perf record -e cs_etm/@sink_smb0/ -C 0 --per-thread sleep 2s
+    [ perf record: Woken up 2 times to write data ]
+    [ perf record: Captured and wrote 0.288 MB perf.data ]
+    $# ./perf report
-- 
2.17.1

