Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09A338A8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhETKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237840AbhETKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621507059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=nCRKEE+KFN690bJnqXzOEK+MhCAkoQiBHxbYpiXjE28=;
        b=dq6qrHPHxohdf7mTLVJdcwQHojclr4RJ4LGoyG74qouowrGDwaRkjp5RKNl2oKKAUwTrQp
        6Urjl65CJHSiat4yBTduLa2HKgzfATR6rVWmYPE0OjWA85pdrjhCtO/94cGheFvJOc8xN3
        gNwoZYlv2I9RViYOERsJND41AOftq6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-DdxlY75aOwqIjpo0vUW2IQ-1; Thu, 20 May 2021 06:37:38 -0400
X-MC-Unique: DdxlY75aOwqIjpo0vUW2IQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E30B107ACCD;
        Thu, 20 May 2021 10:37:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 217131F4;
        Thu, 20 May 2021 10:37:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org
Subject: [PATCH] Documentation: kdump: update kdump guide
Date:   Thu, 20 May 2021 18:37:29 +0800
Message-Id: <20210520103729.13696-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some parts of the guide are aged, hence need be updated.

1) The backup area of the 1st 640K on X86_64 has been removed
   by below commits, update the description accordingly.

   commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
   commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")

2) Sort out the descripiton of "crashkernel syntax" part.

3) And some other minor cleanups.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 150 ++++++++++++++--------
 1 file changed, 97 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..6d0dcf5b5e1f 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -2,7 +2,7 @@
 Documentation for Kdump - The kexec-based Crash Dumping Solution
 ================================================================
 
-This document includes overview, setup and installation, and analysis
+This document includes overview, setup, installation, and analysis
 information.
 
 Overview
@@ -13,12 +13,12 @@ dump of the system kernel's memory needs to be taken (for example, when
 the system panics). The system kernel's memory image is preserved across
 the reboot and is accessible to the dump-capture kernel.
 
-You can use common commands, such as cp and scp, to copy the
-memory image to a dump file on the local disk, or across the network to
-a remote system.
+You can use common commands, such as cp, scp or makedumpfile to copy
+the memory image to a dump file on the local disk, or across the network
+to a remote system.
 
-Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x, arm and arm64 architectures.
+Kdump and kexec are currently supported on the x86/64, ppc64, ia64,
+s390x, arm/64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -27,12 +27,14 @@ The kexec -p command loads the dump-capture kernel into this reserved
 memory.
 
 On x86 machines, the first 640 KB of physical memory is needed to boot,
-regardless of where the kernel loads. Therefore, kexec backs up this
-region just before rebooting into the dump-capture kernel.
+regardless of where the kernel loads. For simpler handling, the whole
+low 1M is reserved to avoid any later kernel or device driver writing
+data into this area. Like this, the low 1M can be reused as system RAM
+by kdump kernel without extra handling.
 
-Similarly on PPC64 machines first 32KB of physical memory is needed for
-booting regardless of where the kernel is loaded and to support 64K page
-size kexec backs up the first 64KB memory.
+On PPC64 machines first 32KB of physical memory is needed for booting
+regardless of where the kernel is loaded and to support 64K page size
+kexec backs up the first 64KB memory.
 
 For s390x, when kdump is triggered, the crashkernel region is exchanged
 with the region [0, crashkernel region size] and then the kdump kernel
@@ -46,14 +48,14 @@ passed to the dump-capture kernel through the elfcorehdr= boot
 parameter. Optionally the size of the ELF header can also be passed
 when using the elfcorehdr=[size[KMG]@]offset[KMG] syntax.
 
-
 With the dump-capture kernel, you can access the memory image through
 /proc/vmcore. This exports the dump as an ELF-format file that you can
-write out using file copy commands such as cp or scp. Further, you can
-use analysis tools such as the GNU Debugger (GDB) and the Crash tool to
-debug the dump file. This method ensures that the dump pages are correctly
-ordered.
-
+write out using file copy commands such as cp or scp. You can also use
+makedumpfile utility to analyze and write out filtered contents with
+options, e.g with '-d 31' it will only write out kernel data. Further,
+you can use analysis tools such as the GNU Debugger (GDB) and the Crash
+tool to debug the dump file. This method ensures that the dump pages are
+correctly ordered.
 
 Setup and Installation
 ======================
@@ -111,7 +113,7 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architectures which support a relocatable kernel. As
-   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
+   of today, x86/64, ppc64, ia64, arm/64 architectures support
    relocatable kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
@@ -125,9 +127,18 @@ dump-capture kernels for enabling kdump support.
 System kernel config options
 ----------------------------
 
-1) Enable "kexec system call" in "Processor type and features."::
+1) Enable "kexec system call" or "kexec file based system call" in
+   "Processor type and features."::
+
+	CONFIG_KEXEC=y or CONFIG_KEXEC_FILE=y
+
+   And both of them will select KEXEC_CORE::
 
-	CONFIG_KEXEC=y
+	CONFIG_KEXEC_CORE=y
+
+   Subsequently, CRASH_CORE is selected by KEXEC_CORE::
+
+	CONFIG_CRASH_CORE=y
 
 2) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
    filesystems." This is usually enabled by default::
@@ -180,7 +191,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 
 	CONFIG_SMP=n
 
-   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
+   (If CONFIG_SMP=y, then specify nr_cpus=1 on the kernel command line
    when loading the dump-capture kernel, see section "Load the Dump-capture
    Kernel".)
 
@@ -241,10 +252,6 @@ Dump-capture kernel config options (Arch Dependent, ia64)
 
 	crashkernel=256M
 
-  If the start address is specified, note that the start address of the
-  kernel will be aligned to 64Mb, so if the start address is not then
-  any space below the alignment point will be wasted.
-
 Dump-capture kernel config options (Arch Dependent, arm)
 ----------------------------------------------------------
 
@@ -260,44 +267,77 @@ Dump-capture kernel config options (Arch Dependent, arm64)
   on non-VHE systems even if it is configured. This is because the CPU
   will not be reset to EL2 on panic.
 
-Extended crashkernel syntax
+crashkernel syntax
 ===========================
+1) crashkernel=size@offset
 
-While the "crashkernel=size[@offset]" syntax is sufficient for most
-configurations, sometimes it's handy to have the reserved memory dependent
-on the value of System RAM -- that's mostly for distributors that pre-setup
-the kernel command line to avoid a unbootable system after some memory has
-been removed from the machine.
+   Here 'size' specifies how much memory to reserve for the dump-capture kernel
+   and 'offset' specifies the beginning of this reserved memory. For example,
+   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
+   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
+
+   The crashkernel region can be automatically placed by the system
+   kernel at run time. This is done by specifying the base address as 0,
+   or omitting it all together::
 
-The syntax is::
+         crashkernel=256M@0
+   or::
 
-    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
-    range=start-[end]
+         crashkernel=256M
 
-For example::
+   If the start address is specified, note that the start address of the
+   kernel will be aligned to a value (which is Arch dependent), so if the
+   start address is not then any space below the alignment point will be
+   wasted.
 
-    crashkernel=512M-2G:64M,2G-:128M
+2) range1:size1[,range2:size2,...][@offset]
 
-This would mean:
+   While the "crashkernel=size[@offset]" syntax is sufficient for most
+   configurations, sometimes it's handy to have the reserved memory dependent
+   on the value of System RAM -- that's mostly for distributors that pre-setup
+   the kernel command line to avoid a unbootable system after some memory has
+   been removed from the machine.
 
-    1) if the RAM is smaller than 512M, then don't reserve anything
-       (this is the "rescue" case)
-    2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
-    3) if the RAM size is larger than 2G, then reserve 128M
+   The syntax is::
 
+       crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+       range=start-[end]
 
+   For example::
 
-Boot into System Kernel
-=======================
+       crashkernel=512M-2G:64M,2G-:128M
 
+   This would mean:
+
+       1) if the RAM is smaller than 512M, then don't reserve anything
+          (this is the "rescue" case)
+       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
+       3) if the RAM size is larger than 2G, then reserve 128M
+
+3) crashkernel=size,high and crashkernel=size,low
+
+   If memory above 4G is preferred, crashkernel=size,high can be used to
+   fulfill that. With it, physical memory is allowed to allocate from top,
+   so could be above 4G if system has more than 4G RAM installed. Otherwise,
+   memory region will be allocated below 4G if available.
+
+   When crashkernel=X,high is passed, kernel could allocate physical memory
+   region above 4G, low memory under 4G is needed in this case. There are
+   three ways to get low memory:
+
+      1) Kernel will allocate at least 256M memory below 4G automatically
+         if crashkernel=Y,low is not specified.
+      2) Let user specify low memory size instread.
+      3) Specified value 0 will disable low memory allocation::
+
+            crashkernel=0,low
+
+Boot into System Kernel
+-----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
    files as necessary.
 
-2) Boot the system kernel with the boot parameter "crashkernel=Y@X",
-   where Y specifies how much memory to reserve for the dump-capture kernel
-   and X specifies the beginning of this reserved memory. For example,
-   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
-   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
+2) Boot the system kernel with the boot parameter "crashkernel=Y@X".
 
    On x86 and x86_64, use "crashkernel=64M@16M".
 
@@ -392,7 +432,7 @@ loading dump-capture kernel.
 
 For i386, x86_64 and ia64:
 
-	"1 irqpoll maxcpus=1 reset_devices"
+	"1 irqpoll nr_cpus=1 reset_devices"
 
 For ppc64:
 
@@ -400,7 +440,7 @@ For ppc64:
 
 For s390x:
 
-	"1 maxcpus=1 cgroup_disable=memory"
+	"1 nr_cpus=1 cgroup_disable=memory"
 
 For arm:
 
@@ -408,7 +448,7 @@ For arm:
 
 For arm64:
 
-	"1 maxcpus=1 reset_devices"
+	"1 nr_cpus=1 reset_devices"
 
 Notes on loading the dump-capture kernel:
 
@@ -487,7 +527,12 @@ After the dump-capture kernel is booted, write out the dump file with
 the following command::
 
    cp /proc/vmcore <dump-file>
+   scp /proc/vmcore to <user@server>:<path>/%HOST-%DATE/
+
+You can also use makedumpfile utility to write out the dump file
+with specified options to filter out unwanted contents, e.g::
 
+   core_collector makedumpfile -l --message-level 1 -d 31
 
 Analysis
 ========
@@ -535,8 +580,7 @@ This will cause a kdump to occur at the add_taint()->panic() call.
 Contact
 =======
 
-- Vivek Goyal (vgoyal@redhat.com)
-- Maneesh Soni (maneesh@in.ibm.com)
+- kexec@lists.infradead.org
 
 GDB macros
 ==========
-- 
2.17.2

