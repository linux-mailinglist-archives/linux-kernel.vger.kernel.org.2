Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6278636E586
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhD2HE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:04:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16167 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhD2HEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:04:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FW5x86dzWzpcPn;
        Thu, 29 Apr 2021 15:00:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 15:03:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <song.bao.hua@hisilicon.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH 2/2] Documentation/ABI: Move the topology-related sysfs interface to the right place
Date:   Thu, 29 Apr 2021 15:03:39 +0800
Message-ID: <1619679819-45256-3-git-send-email-tiantao6@hisilicon.com>
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

Move the interface that exists under
/sys/devices/system/cpu/cpuX/topology/ to the more logical
Documentation/ABI/ file that can be properly parsed and
displayed to the user space

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 Documentation/ABI/stable/sysfs-devices-system-cpu | 142 ++++++++++++++++++++++
 Documentation/admin-guide/cputopology.rst         |  98 +--------------
 2 files changed, 144 insertions(+), 96 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 33c133e..f63a72d 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -1,3 +1,7 @@
+Export CPU topology info via sysfs. Items (attributes) are similar
+to /proc/cpuinfo output of some architectures. They reside in
+/sys/devices/system/cpu/cpuX/topology/:
+
 What: 		/sys/devices/system/cpu/dscr_default
 Date:		13-May-2014
 KernelVersion:	v3.15.0
@@ -23,3 +27,141 @@ Description:	Default value for the Data Stream Control Register (DSCR) on
 		here).
 		If set by a process it will be inherited by child processes.
 Values:		64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/physical_package_id
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    physical package id of cpuX. Typically corresponds to a physical
+                socket number, but the actual value is architecture and platform
+                dependent.
+Values:         64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_id
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    the CPU die ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_id
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    the CPU core ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_id
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    the book ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent. it's only used on s390.
+Values:         64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_id
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    the drawer ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent. it's only used on s390.
+Values:         64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_cpus
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    internal kernel map of CPUs within the same core.
+                (deprecated name: "thread_siblings")
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_cpus_list
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    human-readable list of CPUs within the same core.
+                The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+	        so the tail of the string will be trimmed while its size is larger
+                than PAGE_SIZE.
+                (deprecated name: "thread_siblings_list").
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/package_cpus
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    internal kernel map of the CPUs sharing the same physical_package_id.
+                (deprecated name: "core_siblings").
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/package_cpus_list
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    human-readable list of CPUs sharing the same physical_package_id.
+                The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+                so the tail of the string will be trimmed while its size is larger
+                than PAGE_SIZE.
+                (deprecated name: "core_siblings_list")
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_cpus
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    internal kernel map of CPUs within the same die.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_cpus_list
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    human-readable list of CPUs within the same die.
+                The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+                so the tail of the string will be trimmed while its size is larger
+                than PAGE_SIZE.
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_siblings
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    internal kernel map of cpuX's hardware threads within the same
+                book_id. it's only used on s390.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_siblings_list
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    human-readable list of cpuX's hardware threads within the same
+                book_id. it's only used on s390.
+                The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+                so the tail of the string will be trimmed while its size is larger
+                than PAGE_SIZE.
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_siblings
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    internal kernel map of cpuX's hardware threads within the same
+                drawer_id. it's only used on s390.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_siblings_list
+Date:           19-Mar-2021
+KernelVersion:  v5.12
+Contact:
+Description:    human-readable list of cpuX's hardware threads within the same
+                drawer_id.
+                The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
+                so the tail of the string will be trimmed while its size is larger
+                than PAGE_SIZE. it's only used on s390.
+Values:         decimal list.
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index 4538d78..de1995c 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -2,102 +2,8 @@
 How CPU topology info is exported via sysfs
 ===========================================
 
-Export CPU topology info via sysfs. Items (attributes) are similar
-to /proc/cpuinfo output of some architectures.  They reside in
-/sys/devices/system/cpu/cpuX/topology/:
-
-physical_package_id:
-
-	physical package id of cpuX. Typically corresponds to a physical
-	socket number, but the actual value is architecture and platform
-	dependent.
-
-die_id:
-
-	the CPU die ID of cpuX. Typically it is the hardware platform's
-	identifier (rather than the kernel's).  The actual value is
-	architecture and platform dependent.
-
-core_id:
-
-	the CPU core ID of cpuX. Typically it is the hardware platform's
-	identifier (rather than the kernel's).  The actual value is
-	architecture and platform dependent.
-
-book_id:
-
-	the book ID of cpuX. Typically it is the hardware platform's
-	identifier (rather than the kernel's).	The actual value is
-	architecture and platform dependent.
-
-drawer_id:
-
-	the drawer ID of cpuX. Typically it is the hardware platform's
-	identifier (rather than the kernel's).	The actual value is
-	architecture and platform dependent.
-
-core_cpus:
-
-	internal kernel map of CPUs within the same core.
-	(deprecated name: "thread_siblings")
-
-core_cpus_list:
-
-	human-readable list of CPUs within the same core.
-	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
-	so the tail of the string will be trimmed while its size is larger
-	than PAGE_SIZE.
-	(deprecated name: "thread_siblings_list");
-
-package_cpus:
-
-	internal kernel map of the CPUs sharing the same physical_package_id.
-	(deprecated name: "core_siblings")
-
-package_cpus_list:
-
-	human-readable list of CPUs sharing the same physical_package_id.
-	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
-	so the tail of the string will be trimmed while its size is larger
-	than PAGE_SIZE.
-	(deprecated name: "core_siblings_list")
-
-die_cpus:
-
-	internal kernel map of CPUs within the same die.
-
-die_cpus_list:
-
-	human-readable list of CPUs within the same die.
-	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
-	so the tail of the string will be trimmed while its size is larger
-	than PAGE_SIZE.
-
-book_siblings:
-
-	internal kernel map of cpuX's hardware threads within the same
-	book_id.
-
-book_siblings_list:
-
-	human-readable list of cpuX's hardware threads within the same
-	book_id.
-	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
-	so the tail of the string will be trimmed while its size is larger
-	than PAGE_SIZE.
-
-drawer_siblings:
-
-	internal kernel map of cpuX's hardware threads within the same
-	drawer_id.
-
-drawer_siblings_list:
-
-	human-readable list of cpuX's hardware threads within the same
-	drawer_id.
-	The format is like 0-3, 8-11, 14,17. The maximum size is PAGE_SIZE,
-	so the tail of the string will be trimmed while its size is larger
-	than PAGE_SIZE.
+Export CPU topology info via sysfs. Please refer to the ABI file:
+Documentation/ABI/stable/sysfs-devices-system-cpu.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
-- 
2.7.4

