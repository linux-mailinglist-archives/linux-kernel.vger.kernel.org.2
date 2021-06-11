Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6621C3A3B50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKFZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:25:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3840 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFKFY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:24:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1Td803QYzWlc8;
        Fri, 11 Jun 2021 13:18:04 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:22:58 +0800
Received: from SWX921481.china.huawei.com (10.126.200.167) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:22:56 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] docs: cputopology: move the sysfs ABI description to right place
Date:   Fri, 11 Jun 2021 17:22:49 +1200
Message-ID: <20210611052249.25776-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.167]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

Documentation/admin-guide/cputopology.rst is the wrong place to describe
sysfs ABI. So move the cputopology ABI things to
Documentation/ABI/stable/sysfs-devices-system-cpu and add a reference to
ABI doc in Documentation/admin-guide/cputopology.rst.

Link: https://lkml.kernel.org/r/20210319041618.14316-1-song.bao.hua@hisilicon.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
  *this patch is addressing the concern of Greg KH in the above link tag:

  "Why are these sysfs files in this file, and not in a
   Documentation/ABI/ file which can be correctly parsed
   and shown to userspace?"

 .../ABI/stable/sysfs-devices-system-cpu       | 83 ++++++++++++++++++
 Documentation/admin-guide/cputopology.rst     | 85 +------------------
 2 files changed, 87 insertions(+), 81 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 33c133e2a631..516dafea03eb 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -23,3 +23,86 @@ Description:	Default value for the Data Stream Control Register (DSCR) on
 		here).
 		If set by a process it will be inherited by child processes.
 Values:		64 bit unsigned integer (bit field)
+
+What:           /sys/devices/system/cpu/cpuX/topology/physical_package_id
+Description:    physical package id of cpuX. Typically corresponds to a physical
+                socket number, but the actual value is architecture and platform
+                dependent.
+Values:         integer
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_id
+Description:    the CPU die ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         integer
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_id
+Description:    the CPU core ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         integer
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_id
+Description:    the book ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent. it's only used on s390.
+Values:         integer
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_id
+Description:    the drawer ID of cpuX. Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent. it's only used on s390.
+Values:         integer
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_cpus
+Description:    internal kernel map of CPUs within the same core.
+                (deprecated name: "thread_siblings")
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/core_cpus_list
+Description:    human-readable list of CPUs within the same core.
+                The format is like 0-3, 8-11, 14,17.
+                (deprecated name: "thread_siblings_list").
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/package_cpus
+Description:    internal kernel map of the CPUs sharing the same physical_package_id.
+                (deprecated name: "core_siblings").
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/package_cpus_list
+Description:    human-readable list of CPUs sharing the same physical_package_id.
+                The format is like 0-3, 8-11, 14,17.
+                (deprecated name: "core_siblings_list")
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_cpus
+Description:    internal kernel map of CPUs within the same die.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/die_cpus_list
+Description:    human-readable list of CPUs within the same die.
+                The format is like 0-3, 8-11, 14,17.
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_siblings
+Description:    internal kernel map of cpuX's hardware threads within the same
+                book_id. it's only used on s390.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/book_siblings_list
+Description:    human-readable list of cpuX's hardware threads within the same
+                book_id.
+                The format is like 0-3, 8-11, 14,17. it's only used on s390.
+Values:         decimal list.
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_siblings
+Description:    internal kernel map of cpuX's hardware threads within the same
+                drawer_id. it's only used on s390.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/drawer_siblings_list
+Description:    human-readable list of cpuX's hardware threads within the same
+                drawer_id.
+                The format is like 0-3, 8-11, 14,17. it's only used on s390.
+Values:         decimal list.
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index b90dafcc8237..8632a1db36e4 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -2,87 +2,10 @@
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
-	(deprecated name: "core_siblings_list")
-
-die_cpus:
-
-	internal kernel map of CPUs within the same die.
-
-die_cpus_list:
-
-	human-readable list of CPUs within the same die.
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
+CPU topology info is exported via sysfs. Items (attributes) are similar
+to /proc/cpuinfo output of some architectures. They reside in
+/sys/devices/system/cpu/cpuX/topology/. Please refer to the ABI file:
+Documentation/ABI/stable/sysfs-devices-system-cpu.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
-- 
2.25.1

