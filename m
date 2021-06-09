Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A783A0EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhFIIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232333AbhFIIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623227549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tbWC4V0gU36QuTLqoyQ25ujS0RfxajkXidxE/KUkweg=;
        b=Pq5Qm0b5ZQl0bK4gByfdq6PY7n+amG8bKI2V1nhONbis3VL+CfI1T6iRrzI85HrFv+sgY4
        n9QtqDtIw9RRH7xb8rO4svUG//0DqYEYU3VGxDoQa/MKZD8vMeUlIiyrrRJKpfavkMC15B
        mL/Oc+sPjB6VSBlsix6rGLxOzRR7F+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-XyXt8KWjMeyge8GKBYoY_Q-1; Wed, 09 Jun 2021 04:32:28 -0400
X-MC-Unique: XyXt8KWjMeyge8GKBYoY_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D78D8015C6;
        Wed,  9 Jun 2021 08:32:25 +0000 (UTC)
Received: from localhost (ovpn-13-223.pek2.redhat.com [10.72.13.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B78FD5D75A;
        Wed,  9 Jun 2021 08:32:20 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:32:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        dyoung@redhat.com
Subject: [PATCH v3] Documentation: kdump: update kdump guide
Message-ID: <20210609083218.GB591017@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
v2->v3:
 Fix several spell checking issues pointed out by Dave.

v1->v2:
 Update the obsolete descriptions about SMP and RELOCATABLE according
 to Dave's comment.

 Documentation/admin-guide/kdump/kdump.rst | 169 ++++++++++++++--------
 1 file changed, 108 insertions(+), 61 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..a04fc854749d 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -2,7 +2,7 @@
 Documentation for Kdump - The kexec-based Crash Dumping Solution
 ================================================================
 
-This document includes overview, setup and installation, and analysis
+This document includes overview, setup, installation, and analysis
 information.
 
 Overview
@@ -13,9 +13,9 @@ dump of the system kernel's memory needs to be taken (for example, when
 the system panics). The system kernel's memory image is preserved across
 the reboot and is accessible to the dump-capture kernel.
 
-You can use common commands, such as cp and scp, to copy the
-memory image to a dump file on the local disk, or across the network to
-a remote system.
+You can use common commands, such as cp, scp or makedumpfile to copy
+the memory image to a dump file on the local disk, or across the network
+to a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
 s390x, arm and arm64 architectures.
@@ -26,13 +26,15 @@ the dump-capture kernel. This ensures that ongoing Direct Memory Access
 The kexec -p command loads the dump-capture kernel into this reserved
 memory.
 
-On x86 machines, the first 640 KB of physical memory is needed to boot,
-regardless of where the kernel loads. Therefore, kexec backs up this
-region just before rebooting into the dump-capture kernel.
+On x86 machines, the first 640 KB of physical memory is needed for boot,
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
@@ -175,17 +186,19 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 
 	CONFIG_HIGHMEM4G
 
-2) On i386 and x86_64, disable symmetric multi-processing support
-   under "Processor type and features"::
+2) With CONFIG_SMP=y, usually nr_cpus=1 need specified on the kernel
+   command line when loading the dump-capture kernel because one
+   CPU is enough for kdump kernel to dump vmcore on most of systems.
 
-	CONFIG_SMP=n
+   However, you can also specify nr_cpus=X to enable multiple processors
+   in kdump kernel. In this case, "disable_cpu_apicid=" is needed to
+   tell kdump kernel which cpu is 1st kernel's BSP. Please refer to
+   admin-guide/kernel-parameters.txt for more details.
 
-   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
-   when loading the dump-capture kernel, see section "Load the Dump-capture
-   Kernel".)
+   With CONFIG_SMP=n, the above things are not related.
 
-3) If one wants to build and use a relocatable kernel,
-   Enable "Build a relocatable kernel" support under "Processor type and
+3) A relocatable kernel is suggested to be built by default. If not yet,
+   enable "Build a relocatable kernel" support under "Processor type and
    features"::
 
 	CONFIG_RELOCATABLE=y
@@ -232,7 +245,7 @@ Dump-capture kernel config options (Arch Dependent, ia64)
   as a dump-capture kernel if desired.
 
   The crashkernel region can be automatically placed by the system
-  kernel at run time. This is done by specifying the base address as 0,
+  kernel at runtime. This is done by specifying the base address as 0,
   or omitting it all together::
 
 	crashkernel=256M@0
@@ -241,10 +254,6 @@ Dump-capture kernel config options (Arch Dependent, ia64)
 
 	crashkernel=256M
 
-  If the start address is specified, note that the start address of the
-  kernel will be aligned to 64Mb, so if the start address is not then
-  any space below the alignment point will be wasted.
-
 Dump-capture kernel config options (Arch Dependent, arm)
 ----------------------------------------------------------
 
@@ -260,46 +269,81 @@ Dump-capture kernel config options (Arch Dependent, arm64)
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
 
-The syntax is::
+   The crashkernel region can be automatically placed by the system
+   kernel at run time. This is done by specifying the base address as 0,
+   or omitting it all together::
 
-    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
-    range=start-[end]
+         crashkernel=256M@0
+   or::
 
-For example::
+         crashkernel=256M
 
-    crashkernel=512M-2G:64M,2G-:128M
+   If the start address is specified, note that the start address of the
+   kernel will be aligned to a value (which is Arch dependent), so if the
+   start address is not then any space below the alignment point will be
+   wasted.
 
-This would mean:
+2) range1:size1[,range2:size2,...][@offset]
 
-    1) if the RAM is smaller than 512M, then don't reserve anything
-       (this is the "rescue" case)
-    2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
-    3) if the RAM size is larger than 2G, then reserve 128M
+   While the "crashkernel=size[@offset]" syntax is sufficient for most
+   configurations, sometimes it's handy to have the reserved memory dependent
+   on the value of System RAM -- that's mostly for distributors that pre-setup
+   the kernel command line to avoid a unbootable system after some memory has
+   been removed from the machine.
 
+   The syntax is::
 
+       crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+       range=start-[end]
 
-Boot into System Kernel
-=======================
+   For example::
+
+       crashkernel=512M-2G:64M,2G-:128M
+
+   This would mean:
 
+       1) if the RAM is smaller than 512M, then don't reserve anything
+          (this is the "rescue" case)
+       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
+       3) if the RAM size is larger than 2G, then reserve 128M
+
+3) crashkernel=size,high and crashkernel=size,low
+
+   If memory above 4G is preferred, crashkernel=size,high can be used to
+   fulfill that. With it, physical memory is allowed to be allocated from top,
+   so could be above 4G if system has more than 4G RAM installed. Otherwise,
+   memory region will be allocated below 4G if available.
+
+   When crashkernel=X,high is passed, kernel could allocate physical memory
+   region above 4G, low memory under 4G is needed in this case. There are
+   three ways to get low memory:
+
+      1) Kernel will allocate at least 256M memory below 4G automatically
+         if crashkernel=Y,low is not specified.
+      2) Let user specify low memory size instead.
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
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 and x86_64, use "crashkernel=Y[@X]". Most of the time, the
+   start address 'X' is not necessary, kernel will search a suitable
+   area. Unless an explicit start address is expected.
 
    On ppc64, use "crashkernel=128M@32M".
 
@@ -331,8 +375,8 @@ of dump-capture kernel. Following is the summary.
 
 For i386 and x86_64:
 
-	- Use vmlinux if kernel is not relocatable.
 	- Use bzImage/vmlinuz if kernel is relocatable.
+	- Use vmlinux if kernel is not relocatable.
 
 For ppc64:
 
@@ -392,7 +436,7 @@ loading dump-capture kernel.
 
 For i386, x86_64 and ia64:
 
-	"1 irqpoll maxcpus=1 reset_devices"
+	"1 irqpoll nr_cpus=1 reset_devices"
 
 For ppc64:
 
@@ -400,7 +444,7 @@ For ppc64:
 
 For s390x:
 
-	"1 maxcpus=1 cgroup_disable=memory"
+	"1 nr_cpus=1 cgroup_disable=memory"
 
 For arm:
 
@@ -408,7 +452,7 @@ For arm:
 
 For arm64:
 
-	"1 maxcpus=1 reset_devices"
+	"1 nr_cpus=1 reset_devices"
 
 Notes on loading the dump-capture kernel:
 
@@ -488,6 +532,10 @@ the following command::
 
    cp /proc/vmcore <dump-file>
 
+You can also use makedumpfile utility to write out the dump file
+with specified options to filter out unwanted contents, e.g::
+
+   makedumpfile -l --message-level 1 -d 31 /proc/vmcore <dump-file>
 
 Analysis
 ========
@@ -535,8 +583,7 @@ This will cause a kdump to occur at the add_taint()->panic() call.
 Contact
 =======
 
-- Vivek Goyal (vgoyal@redhat.com)
-- Maneesh Soni (maneesh@in.ibm.com)
+- kexec@lists.infradead.org
 
 GDB macros
 ==========
-- 
2.17.2

