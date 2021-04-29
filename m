Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC736E587
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbhD2HEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:04:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16169 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbhD2HE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:04:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FW5x904r5zpcPc;
        Thu, 29 Apr 2021 15:00:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 15:03:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <song.bao.hua@hisilicon.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue of sysfs pagebuf
Date:   Thu, 29 Apr 2021 15:03:38 +0800
Message-ID: <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both numa node and cpu use cpu bitmap like 3,ffffffff to expose hardware
topology. When cpu number is large, the page buffer of sysfs will over-
flow. This doesn't really happen nowadays as the maximum NR_CPUS is 8196
for X86_64 and 4096 for ARM64 since 8196 * 9 / 32 = 2305 is still smaller
than 4KB page size.

So the existing BUILD_BUG_ON() in drivers/base/node.c is pretty much
preventing future problems similar with Y2K when hardware gets more
and more CPUs.

On the other hand, it should be more sensible to move the guard to common
code which can protect both cpu and numa:
/sys/devices/system/cpu/cpu0/topology/die_cpus etc.
/sys/devices/system/node/node0/cpumap etc.

Topology bitmap mask strings shouldn't be larger than PAGE_SIZE as
lstopo and numactl depend on them. But other ABIs exposing cpu lists
are not really used by common applications, so this patch also marks
those lists could be trimmed as there is no any guarantee those lists
are always less than PAGE_SIZE especially a list could be like this:
0, 3, 5, 7, 9, 11... etc.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 Documentation/ABI/stable/sysfs-devices-node |  5 ++++-
 Documentation/admin-guide/cputopology.rst   | 15 +++++++++++++++
 drivers/base/node.c                         |  3 ---
 include/linux/cpumask.h                     |  6 ++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 484fc04..82dfe64 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -47,7 +47,10 @@ What:		/sys/devices/system/node/nodeX/cpulist
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
 Description:
-		The CPUs associated to the node.
+		The CPUs associated to the node. The format is like 0-3,
+		8-11, 14,17. maximum size is PAGE_SIZE, so the tail
+		of the string will be trimmed while its size is larger
+		than PAGE_SIZE.
 
 What:		/sys/devices/system/node/nodeX/meminfo
 Date:		October 2002
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index b90dafc..4538d78 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -44,6 +44,9 @@ core_cpus:
 core_cpus_list:
 
 	human-readable list of CPUs within the same core.
+	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 	(deprecated name: "thread_siblings_list");
 
 package_cpus:
@@ -54,6 +57,9 @@ package_cpus:
 package_cpus_list:
 
 	human-readable list of CPUs sharing the same physical_package_id.
+	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 	(deprecated name: "core_siblings_list")
 
 die_cpus:
@@ -63,6 +69,9 @@ die_cpus:
 die_cpus_list:
 
 	human-readable list of CPUs within the same die.
+	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 book_siblings:
 
@@ -73,6 +82,9 @@ book_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	book_id.
+	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 drawer_siblings:
 
@@ -83,6 +95,9 @@ drawer_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	drawer_id.
+	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 2c36f61d..e24530c3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -33,9 +33,6 @@ static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
 	cpumask_var_t mask;
 	struct node *node_dev = to_node(dev);
 
-	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
-	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
-
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return 0;
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..1882477 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -12,6 +12,7 @@
 #include <linux/bitmap.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <asm/page.h>
 
 /* Don't assign or return these: may not be this big! */
 typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
@@ -979,6 +980,11 @@ static inline bool cpu_dying(unsigned int cpu)
 static inline ssize_t
 cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 {
+	/*
+	 * 32bits requires 9bytes: "ff,ffffffff", thus, too many CPUs will
+	 * cause the overflow of sysfs pagebuf
+	 */
+	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
 				      nr_cpu_ids);
 }
-- 
2.7.4

