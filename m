Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2538FF05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhEYK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhEYK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621938379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wZwgDXBNCinoEc0JuBx0upXGHOECbhvCiiFsaAIXzjM=;
        b=eYl9uobYfh308QFYE1tGpHxXRnCx34xRtYr4uJgRSCvuYWWC6lHGE9Ppg6QqjphQ68I4KZ
        fPLih1995+qC0jR4jHOET8wW8hqnVORJJnAa+2a3RfKpBwes/Lb+eHotu40X47ck4gM19b
        nHisfvKDjMoAyARG04hdSQDOukyZIEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-pkjoJY-5Phi0YgqsgYwchQ-1; Tue, 25 May 2021 06:26:17 -0400
X-MC-Unique: pkjoJY-5Phi0YgqsgYwchQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 912681007467;
        Tue, 25 May 2021 10:26:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F016E418;
        Tue, 25 May 2021 10:26:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Date:   Tue, 25 May 2021 12:26:04 +0200
Message-Id: <20210525102604.8770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory hot(un)plug documentation is outdated and incomplete. Most of
the content dates back to 2007, so it's time for a major overhaul.

Let's rewrite, reorganize and update most parts of the documentation. In
addition to memory hot(un)plug, also add some details regarding
ZONE_MOVABLE, with memory hotunplug being one of its main consumers.

The style of the document is also properly fixed that e.g., "restview"
renders it cleanly now.

In the future, we might add some more details about virt users like
virtio-mem, the XEN balloon, the Hyper-V balloon and ppc64 dlpar.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-doc@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Based on linux-next, which includes hugetlb vmemmap changes to the doc
that are not upstream yet.

---
 .../admin-guide/mm/memory-hotplug.rst         | 738 +++++++++++-------
 1 file changed, 440 insertions(+), 298 deletions(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index c6bae2d77160..c95f5c2b30dd 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -1,419 +1,573 @@
 .. _admin_guide_memory_hotplug:
 
-==============
-Memory Hotplug
-==============
+==================
+Memory Hot(Un)Plug
+==================
 
 :Created:							Jul 28 2007
 :Updated: Add some details about locking internals:		Aug 20 2018
+:Updated: Complete overhaul:					May 18 2021
 
-This document is about memory hotplug including how-to-use and current status.
-Because Memory Hotplug is still under development, contents of this text will
-be changed often.
+This document describes generic Linux support for memory hot(un)plug with
+a focus on System RAM, including ZONE_MOVABLE support.
 
 .. contents:: :local:
 
-.. note::
-
-    (1) x86_64's has special implementation for memory hotplug.
-        This text does not describe it.
-    (2) This text assumes that sysfs is mounted at ``/sys``.
-
-
 Introduction
 ============
 
-Purpose of memory hotplug
--------------------------
+Memory hot(un)plug allows for increasing and decreasing the physical memory
+available to a machine at runtime. In the simplest case, it consists of
+physically plugging or unplugging a DIMM at runtime, coordinated with the
+operating system.
 
-Memory Hotplug allows users to increase/decrease the amount of memory.
-Generally, there are two purposes.
+Memory hot(un)plug is used for various purposes:
 
-(A) For changing the amount of memory.
-    This is to allow a feature like capacity on demand.
-(B) For installing/removing DIMMs or NUMA-nodes physically.
-    This is to exchange DIMMs/NUMA-nodes, reduce power consumption, etc.
+(A) The physical memory available to a machine can be adjusted at runtime,
+    up- or downgrading the memory capacity. This dynamic memory
+    resizing, sometimes referred to as "capacity on demand", is frequently
+    used with virtual machines and logical partitions.
 
-(A) is required by highly virtualized environments and (B) is required by
-hardware which supports memory power management.
+(B) Replacing hardware, such as DIMMs or whole NUMA nodes, without downtime.
+    One example is replacing failing memory modules.
 
-Linux memory hotplug is designed for both purpose.
+(C) Reducing memory consumption either by physically unplugging
+    memory modules or by logically unplugging (parts of) memory modules
+    from Linux.
 
-Phases of memory hotplug
+Further, the basic memory hot(un)plug infrastructure in Linux is nowadays
+also used to expose PMEM, other performance-differentiated
+memory and reserved memory regions as ordinary system RAM to Linux.
+
+Phases of Memory Hotplug
 ------------------------
 
-There are 2 phases in Memory Hotplug:
+Memory hotplug consists of two phases:
+
+(1) Adding the memory to Linux
+(2) Onlining memory blocks
 
-  1) Physical Memory Hotplug phase
-  2) Logical Memory Hotplug phase.
+In the first phase, metadata (such as the memmap) is allocated, page tables
+for the direct mapping are allocated and initialized, and memory blocks
+are created; the latter also creates sysfs files for managing
+newly created memory blocks.
 
-The First phase is to communicate hardware/firmware and make/erase
-environment for hotplugged memory. Basically, this phase is necessary
-for the purpose (B), but this is good phase for communication between
-highly virtualized environments too.
+In the second phase, added memory is exposed to the page allocator. After this
+phase, the memory is visible in memory statistics, such as free and total
+memory, of the system.
 
-When memory is hotplugged, the kernel recognizes new memory, makes new memory
-management tables, and makes sysfs files for new memory's operation.
+Phases of Memory Hotunplug
+--------------------------
 
-If firmware supports notification of connection of new memory to OS,
-this phase is triggered automatically. ACPI can notify this event. If not,
-"probe" operation by system administration is used instead.
-(see :ref:`memory_hotplug_physical_mem`).
+Memory hotunplug consists of two phases:
 
-Logical Memory Hotplug phase is to change memory state into
-available/unavailable for users. Amount of memory from user's view is
-changed by this phase. The kernel makes all memory in it as free pages
-when a memory range is available.
+(1) Offlining memory blocks
+(2) Removing the memory from Linux
 
-In this document, this phase is described as online/offline.
+In the fist phase, memory is "hidden" from the page allocator again, for
+example, by migrating busy memory to other memory locations and removing all
+relevant free pages from the page allocator After this phase, the memory
+is no longer visible in memory statistics of the system.
 
-Logical Memory Hotplug phase is triggered by write of sysfs file by system
-administrator. For the hot-add case, it must be executed after Physical Hotplug
-phase by hand.
-(However, if you writes udev's hotplug scripts for memory hotplug, these
-phases can be execute in seamless way.)
+In the second phase, the memory blocks are removed, the direct map is torn
+down, and metadata is freed.
 
-Unit of Memory online/offline operation
----------------------------------------
+Unit of Memory Hot(Un)Plug
+--------------------------
 
-Memory hotplug uses SPARSEMEM memory model which allows memory to be divided
-into chunks of the same size. These chunks are called "sections". The size of
-a memory section is architecture dependent. For example, power uses 16MiB, ia64
-uses 1GiB.
+Memory hot(un)plug uses the SPARSEMEM memory model, which divides the physical
+memory address space into chunks of the same size: memory sections. The size
+of a memory section is architecture dependent. For example, x86_64 uses
+128 MiB and ppc64 uses 16 MiB.
 
 Memory sections are combined into chunks referred to as "memory blocks". The
-size of a memory block is architecture dependent and represents the logical
-unit upon which memory online/offline operations are to be performed. The
-default size of a memory block is the same as memory section size unless an
-architecture specifies otherwise. (see :ref:`memory_hotplug_sysfs_files`.)
+size of a memory block is architecture dependent and corresponds to the smallest
+granularity that can be hot(un)plugged. The default size of a memory block is
+the same as memory section size, unless an architecture specifies otherwise.
 
-To determine the size (in bytes) of a memory block please read this file::
+All memory blocks have the same size.
 
-  /sys/devices/system/memory/block_size_bytes
+Memory Hotplug Notifications
+============================
 
-Kernel Configuration
-====================
+There are various ways how Linux is notified about memory hotplug events
+such that it can start adding hotplugged memory. This description is
+mostly limited to mechanisms present on physical machines; mechanisms specific
+to virtual machines or logical partitions are not described.
 
-To use memory hotplug feature, kernel must be compiled with following
-config options.
+ACPI Notifications
+------------------
 
-- For all memory hotplug:
-    - Memory model -> Sparse Memory  (``CONFIG_SPARSEMEM``)
-    - Allow for memory hot-add       (``CONFIG_MEMORY_HOTPLUG``)
+Platforms that support ACPI, such as x86_64, can support memory hotplug
+notifications via ACPI.
 
-- To enable memory removal, the following are also necessary:
-    - Allow for memory hot remove    (``CONFIG_MEMORY_HOTREMOVE``)
-    - Page Migration                 (``CONFIG_MIGRATION``)
+In general, a firmware supporting memory hotplug defines a memory class
+object _HID "PNP0C80". When notified about hotplug of a new memory device,
+the ACPI driver will hotplug the memory to Linux.
 
-- For ACPI memory hotplug, the following are also necessary:
-    - Memory hotplug (under ACPI Support menu) (``CONFIG_ACPI_HOTPLUG_MEMORY``)
-    - This option can be kernel module.
+If the firmware supports hotplug of NUMA nodes, it defines an object _HID
+"ACPI0004", "PNP0A05", or "PNP0A06". When notified about an hotplug event,
+all assigned memory devices are added to Linux by the ACPI driver.
 
-- As a related configuration, if your box has a feature of NUMA-node hotplug
-  via ACPI, then this option is necessary too.
+Similarly, Linux can be notified about requests to hotunplug a memory device
+or a NUMA node via ACPI. The ACPI driver will try offlining all relevant memory
+blocks, and, if successful, hotunplug the memory from Linux.
 
-    - ACPI0004,PNP0A05 and PNP0A06 Container Driver (under ACPI Support menu)
-      (``CONFIG_ACPI_CONTAINER``).
+Manual Probing
+--------------
 
-     This option can be kernel module too.
+On some architectures, the firmware may not be able to notify the operating
+system about a memory hotplug event. Instead, the memory has to be manually
+probed from user space.
 
+The probe interface is located at::
 
-.. _memory_hotplug_sysfs_files:
+	/sys/devices/system/memory/probe
 
-sysfs files for memory hotplug
-==============================
+Only complete memory blocks can be probed. Individual memory blocks are
+probed by providing the physical start address of the memory block::
 
-All memory blocks have their device information in sysfs.  Each memory block
-is described under ``/sys/devices/system/memory`` as::
+	% echo addr > /sys/devices/system/memory/probe
 
-	/sys/devices/system/memory/memoryXXX
+Which results in a memory block for the range [addr, addr + memory_block_size)
+being created.
 
-where XXX is the memory block id.
+.. note::
 
-For the memory block covered by the sysfs directory.  It is expected that all
-memory sections in this range are present and no memory holes exist in the
-range. Currently there is no way to determine if there is a memory hole, but
-the existence of one should not affect the hotplug capabilities of the memory
-block.
+  Using the probe interface is discouraged as it is easy to crash the kernel,
+  because Linux cannot validate user input; this interface might be removed in
+  the future.
 
-For example, assume 1GiB memory block size. A device for a memory starting at
-0x100000000 is ``/sys/device/system/memory/memory4``::
+Onlining and Offlining Memory Blocks
+====================================
 
-	(0x100000000 / 1Gib = 4)
+After a memory block has been created, Linux has to be instructed to actually
+make use of that memory: the memory block has to be "online".
 
-This device covers address range [0x100000000 ... 0x140000000)
+Before a memory block can be removed, Linux has to stop using any memory
+part of the memory block: the memory block has to be "offlined".
 
-Under each memory block, you can see 5 files:
+The Linux kernel can be configured to automatically online added memory
+blocks and drivers automatically trigger offlining of memory blocks
+when trying hotunplug of memory. Memory blocks can only be removed once offlining
+succeeded.
 
-- ``/sys/devices/system/memory/memoryXXX/phys_index``
-- ``/sys/devices/system/memory/memoryXXX/phys_device``
-- ``/sys/devices/system/memory/memoryXXX/state``
-- ``/sys/devices/system/memory/memoryXXX/removable``
-- ``/sys/devices/system/memory/memoryXXX/valid_zones``
+Onlining Memory Blocks Manually
+-------------------------------
 
-=================== ============================================================
-``phys_index``      read-only and contains memory block id, same as XXX.
-``state``           read-write
+If auto-onlining of memory blocks isn't enabled, user-space has to manually
+trigger onlining of memory blocks. Often, udev rules are used to automate this
+task in user space.
 
-                    - at read:  contains online/offline state of memory.
-                    - at write: user can specify "online_kernel",
+Onlining of a memory block can be triggered via::
 
-                    "online_movable", "online", "offline" command
-                    which will be performed on all sections in the block.
-``phys_device``	    read-only: legacy interface only ever used on s390x to
-		    expose the covered storage increment.
-``removable``	    read-only: legacy interface that indicated whether a memory
-		    block was likely to be offlineable or not.  Newer kernel
-		    versions return "1" if and only if the kernel supports
-		    memory offlining.
-``valid_zones``     read-only: designed to show by which zone memory provided by
-		    a memory block is managed, and to show by which zone memory
-		    provided by an offline memory block could be managed when
-		    onlining.
+	% echo online > /sys/devices/system/memory/memoryXXX/state
 
-		    The first column shows it`s default zone.
+Or alternatively::
 
-		    "memory6/valid_zones: Normal Movable" shows this memoryblock
-		    can be onlined to ZONE_NORMAL by default and to ZONE_MOVABLE
-		    by online_movable.
+	% echo 1 > /sys/devices/system/memory/memoryXXX/online
 
-		    "memory7/valid_zones: Movable Normal" shows this memoryblock
-		    can be onlined to ZONE_MOVABLE by default and to ZONE_NORMAL
-		    by online_kernel.
-=================== ============================================================
+The kernel will select the target zone automatically, usually defaulting
+to ``ZONE_NORMAL`` unless ``movablecore=1`` has been specified on the kernel
+cmdline or if the memory block would intersect the ZONE_MOVABLE already.
 
-.. note::
+One can explicitly request to associate it with ZONE_MOVABLE by::
 
-  These directories/files appear after physical memory hotplug phase.
+	% echo online_movable > /sys/devices/system/memory/memoryXXX/state
 
-If CONFIG_NUMA is enabled the memoryXXX/ directories can also be accessed
-via symbolic links located in the ``/sys/devices/system/node/node*`` directories.
+Or one can explicitly request a kernel zone (usually ZONE_NORMAL) by::
 
-For example::
+	% echo online_kernel > /sys/devices/system/memory/memoryXXX/state
 
-	/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+In any case, if offline succeeds, the state of the memory block is changed to
+be "online". If it fails, an error will be returned by the kernel.
 
-A backlink will also be created::
+Onlining Memory Blocks Automatically
+------------------------------------
 
-	/sys/devices/system/memory/memory9/node0 -> ../../node/node0
+The kernel can be configured to try auto-onlining of newly added memory blocks.
+If disabled, the memory blocks will stay offline until explicitly onlined
+from user space.
 
-.. _memory_hotplug_physical_mem:
+The configured auto-online behavior can be observed via::
 
-Physical memory hot-add phase
-=============================
+	% cat /sys/devices/system/memory/auto_online_blocks
 
-Hardware(Firmware) Support
---------------------------
+Auto-onlining can be enabled by writing ``online``, ``online_kernel`` or
+``online_movable`` to that file, like::
 
-On x86_64/ia64 platform, memory hotplug by ACPI is supported.
+	% echo online > /sys/devices/system/memory/auto_online_blocks
 
-In general, the firmware (ACPI) which supports memory hotplug defines
-memory class object of _HID "PNP0C80". When a notify is asserted to PNP0C80,
-Linux's ACPI handler does hot-add memory to the system and calls a hotplug udev
-script. This will be done automatically.
+Modifying the auto-online behavior will only affect all subsequently
+added memory blocks only.
 
-But scripts for memory hotplug are not contained in generic udev package(now).
-You may have to write it by yourself or online/offline memory by hand.
-Please see :ref:`memory_hotplug_how_to_online_memory` and
-:ref:`memory_hotplug_how_to_offline_memory`.
+.. note::
 
-If firmware supports NUMA-node hotplug, and defines an object _HID "ACPI0004",
-"PNP0A05", or "PNP0A06", notification is asserted to it, and ACPI handler
-calls hotplug code for all of objects which are defined in it.
-If memory device is found, memory hotplug code will be called.
+  In corner cases, auto-onlining can fail. The kernel won't retry. Note that
+  auto-onlining is not expected to fail in default configurations.
 
-Notify memory hot-add event by hand
------------------------------------
+.. note::
 
-On some architectures, the firmware may not notify the kernel of a memory
-hotplug event.  Therefore, the memory "probe" interface is supported to
-explicitly notify the kernel.  This interface depends on
-CONFIG_ARCH_MEMORY_PROBE and can be configured on powerpc, sh, and x86
-if hotplug is supported, although for x86 this should be handled by ACPI
-notification.
+  DLPAR on ppc64 ignores the ``offline`` setting and will still online added
+  memory blocks; if onlining fails, memory blocks are removed again.
 
-Probe interface is located at::
+Offlining Memory Blocks
+-----------------------
 
-	/sys/devices/system/memory/probe
+In the current implementation, Linux's memory offlining will try migrating
+all movable pages off the affected memory block. As most kernel allocations,
+such as page tables, are unmovable, page migration can fail and, therefore,
+inhibit memory offlining from succeeding.
 
-You can tell the physical address of new memory to the kernel by::
+Having the memory provided by memory block managed by ZONE_MOVABLE severely
+increases memory offlining reliability; still, memory offlining can fail in
+some corner cases.
 
-	% echo start_address_of_new_memory > /sys/devices/system/memory/probe
+Further, memory offlining might retry for a long time (or even forever),
+until aborted by the user.
 
-Then, [start_address_of_new_memory, start_address_of_new_memory +
-memory_block_size] memory range is hot-added. In this case, hotplug script is
-not called (in current implementation). You'll have to online memory by
-yourself.  Please see :ref:`memory_hotplug_how_to_online_memory`.
+Offlining of a memory block can be triggered via::
 
-Logical Memory hot-add phase
-============================
+	% echo offline > /sys/devices/system/memory/memoryXXX/state
 
-State of memory
----------------
+Or alternatively::
 
-To see (online/offline) state of a memory block, read 'state' file::
+	% echo 0 > /sys/devices/system/memory/memoryXXX/online
 
-	% cat /sys/device/system/memory/memoryXXX/state
+If offline succeeds, the state of the memory block is changed to be "offline".
+If it fails, an error will be returned by the kernel.
 
+Observing the State of Memory Blocks
+------------------------------------
 
-- If the memory block is online, you'll read "online".
-- If the memory block is offline, you'll read "offline".
+The state (online/offline/going-offline) of a memory block can be observed
+either via::
 
+	% cat /sys/device/system/memory/memoryXXX/state
 
-.. _memory_hotplug_how_to_online_memory:
+Or alternatively (1/0) via::
 
-How to online memory
---------------------
+	% cat /sys/device/system/memory/memoryXXX/online
 
-When the memory is hot-added, the kernel decides whether or not to "online"
-it according to the policy which can be read from "auto_online_blocks" file::
+For an online memory block, the managing zone van be observed via::
 
-	% cat /sys/devices/system/memory/auto_online_blocks
+	% cat /sys/device/system/memory/memoryXXX/valid_zones
 
-The default depends on the CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE kernel config
-option. If it is disabled the default is "offline" which means the newly added
-memory is not in a ready-to-use state and you have to "online" the newly added
-memory blocks manually. Automatic onlining can be requested by writing "online"
-to "auto_online_blocks" file::
+Configuring Memory Hot(Un)Plug
+==============================
 
-	% echo online > /sys/devices/system/memory/auto_online_blocks
+There are various ways how admins can configure memory hot(un)plug and interact
+with memory blocks, especially, to online them.
 
-This sets a global policy and impacts all memory blocks that will subsequently
-be hotplugged. Currently offline blocks keep their state. It is possible, under
-certain circumstances, that some memory blocks will be added but will fail to
-online. User space tools can check their "state" files
-(``/sys/devices/system/memory/memoryXXX/state``) and try to online them manually.
+Memory Hot(Un)Plug Configuration via Sysfs
+------------------------------------------
 
-If the automatic onlining wasn't requested, failed, or some memory block was
-offlined it is possible to change the individual block's state by writing to the
-"state" file::
+Some memory hot(un)plug properties can be configured or inspected via sysfs in::
 
-	% echo online > /sys/devices/system/memory/memoryXXX/state
+	/sys/devices/system/memory/
 
-This onlining will not change the ZONE type of the target memory block,
-If the memory block doesn't belong to any zone an appropriate kernel zone
-(usually ZONE_NORMAL) will be used unless movable_node kernel command line
-option is specified when ZONE_MOVABLE will be used.
+The following files are currently defined:
 
-You can explicitly request to associate it with ZONE_MOVABLE by::
+====================== =========================================================
+``auto_online_blocks`` read-write: set or get the default state of new memory
+		       blocks; configure auto-onlining.
 
-	% echo online_movable > /sys/devices/system/memory/memoryXXX/state
+		       See the ``state`` property of memory blocks for details.
+``block_size_bytes``   read-only: the size in bytes of a memory block.
+``probe``	       write-only: add (probe) selected memory blocks manually
+		       from user space by supplying the physical start address.
+``uevent``	       read-write: generic udev file for device subsystems.
+====================== =========================================================
 
-.. note:: current limit: this memory block must be adjacent to ZONE_MOVABLE
+.. note::
+  The default of ``auto_online_blocks`` depends on
+  CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE.
 
-Or you can explicitly request a kernel zone (usually ZONE_NORMAL) by::
+.. note::
 
-	% echo online_kernel > /sys/devices/system/memory/memoryXXX/state
+  With CONFIG_MEMORY_FAILURE, two additional files ``hard_offline_page`` and
+  ``soft_offline_page`` are available to trigger hwpoisoning of pages, for
+  example, for testing purposes. Note that this functionality is not really
+  related to memory hot(un)plug or actual offlining of memory blocks.
 
-.. note:: current limit: this memory block must be adjacent to ZONE_NORMAL
+.. note::
+
+  ``probe`` is only available with CONFIG_ARCH_MEMORY_PROBE.
 
-An explicit zone onlining can fail (e.g. when the range is already within
-and existing and incompatible zone already).
+Memory Block Configuration via Sysfs
+------------------------------------
 
-After this, memory block XXX's state will be 'online' and the amount of
-available memory will be increased.
+Each memory block is represented as a memory block device that can be
+onlined or offlined. All memory blocks have their device information located in
+sysfs. Each present memory block is listed under
+``/sys/devices/system/memory`` as::
 
-This may be changed in future.
+	/sys/devices/system/memory/memoryXXX
 
-Logical memory remove
-=====================
+where XXX is the memory block id; the number of digits is variable.
 
-Memory offline and ZONE_MOVABLE
--------------------------------
+A present memory block indicates that some memory in the range is present;
+however, a memory block might span memory holes. A memory block spanning
+memory holes cannot be offlined.
 
-Memory offlining is more complicated than memory online. Because memory offline
-has to make the whole memory block be unused, memory offline can fail if
-the memory block includes memory which cannot be freed.
+For example, assume 1 GiB memory block size. A device for a memory starting at
+0x100000000 is ``/sys/device/system/memory/memory4``::
+
+	(0x100000000 / 1Gib = 4)
 
-In general, memory offline can use 2 techniques.
+This device covers address range [0x100000000 ... 0x140000000)
 
-(1) reclaim and free all memory in the memory block.
-(2) migrate all pages in the memory block.
+The following files are currently defined:
 
-In the current implementation, Linux's memory offline uses method (2), freeing
-all  pages in the memory block by page migration. But not all pages are
-migratable. Under current Linux, migratable pages are anonymous pages and
-page caches. For offlining a memory block by migration, the kernel has to
-guarantee that the memory block contains only migratable pages.
+=================== ============================================================
+``online``	    read-write: simplified interface to trigger onlining /
+		    offlining and to observe the state of a memory block.
+		    When onlining, the zone is selected automatically.
+``phys_device``	    read-only: legacy interface only ever used on s390x to
+		    expose the covered storage increment.
+``phys_index``	    read-only: the memory block id (XXX).
+``removable``	    read-only: legacy interface that indicated whether a memory
+		    block was likely to be offlineable or not. Nowadays, the
+		    kernel return ``1`` if and only if it supports memory
+		    offlining.
+``state``	    read-write: advanced interface to trigger onlining /
+		    offlining and to observe the state of a memory block.
+
+		    When writing, ``online``, ``offline``, ``online_kernel`` and
+		    ``online_movable`` are supported.
+
+		    ``online_movable`` specifies onlining to ZONE_MOVABLE.
+		    ``online_kernel`` specifies onlining to the default kernel
+		    zone for the memory block, such as ZONE_NORMAL.
+                    ``online`` let's the kernel select the zone automatically.
+
+		    When reading, ``online``, ``offline`` and ``going-offline``
+		    may be returned.
+``uevent``	    read-write: generic uevent file for devices.
+``valid_zones``     read-only: shows by which zone memory provided by an
+		    online memory block is managed, and by which zone memory
+		    provided by an offline memory block could be managed when
+		    onlining.
 
-Now, a boot option for making a memory block which consists of migratable pages
-is supported. By specifying "kernelcore=" or "movablecore=" boot option, you can
-create ZONE_MOVABLE...a zone which is just used for movable pages.
-(See also Documentation/admin-guide/kernel-parameters.rst)
+		    For online memory blocks, ``DMA``, ``DMA32``, ``Normal``,
+		    ``Movable`` and ``none`` may be returned. ``none`` indicates
+		    that memory provided by a memory block is managed by
+		    multiple zones or spans multiple nodes; such memory blocks
+		    cannot be offlined. ``Movable`` indicates ZONE_MOVABLE.
+		    Other values indicate a kernel zone.
 
-Assume the system has "TOTAL" amount of memory at boot time, this boot option
-creates ZONE_MOVABLE as following.
+		    For offline memory blocks, the first column shows the
+		    zone the kernel would select when onlining the memory block
+		    right now without further specifying a zone.
+=================== ============================================================
 
-1) When kernelcore=YYYY boot option is used,
-   Size of memory not for movable pages (not for offline) is YYYY.
-   Size of memory for movable pages (for offline) is TOTAL-YYYY.
+.. note::
 
-2) When movablecore=ZZZZ boot option is used,
-   Size of memory not for movable pages (not for offline) is TOTAL - ZZZZ.
-   Size of memory for movable pages (for offline) is ZZZZ.
+  ``valid_zones`` is only available with CONFIG_MEMORY_HOTREMOVE.
 
 .. note::
 
-   Unfortunately, there is no information to show which memory block belongs
-   to ZONE_MOVABLE. This is TBD.
+  If CONFIG_NUMA is enabled the memoryXXX/ directories can also be accessed
+  via symbolic links located in the ``/sys/devices/system/node/node*``
+  directories.
+
+  For example::
+
+	/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+  A backlink will also be created::
+
+	/sys/devices/system/memory/memory9/node0 -> ../../node/node0
 
-   Memory offlining can fail when dissolving a free huge page on ZONE_MOVABLE
-   and the feature of freeing unused vmemmap pages associated with each hugetlb
-   page is enabled.
+Cmdline Parameters
+------------------
 
-   This can happen when we have plenty of ZONE_MOVABLE memory, but not enough
-   kernel memory to allocate vmemmmap pages.  We may even be able to migrate
-   huge page contents, but will not be able to dissolve the source huge page.
-   This will prevent an offline operation and is unfortunate as memory offlining
-   is expected to succeed on movable zones.  Users that depend on memory hotplug
-   to succeed for movable zones should carefully consider whether the memory
-   savings gained from this feature are worth the risk of possibly not being
-   able to offline memory in certain situations.
+Some cmdline parameters affect memory hot(un)plug handling. The following
+cmdline parameters are relevant:
+
+======================== =======================================================
+``memhp_default_state``	 configure auto-onlining by essentially setting
+                         ``/sys/devices/system/memory/auto_online_blocks``.
+``movablecore``		 configure automatic zone selection of the kernel. When
+			 set, the kernel will default to ZONE_MOVABLE, unless
+			 other zones can be kept contiguous.
+======================== =======================================================
+
+Module Parameters
+------------------
+
+Instead of additional cmdline parameters or sysfs files, the ``memory_hotplug``
+subsystem now provides a dedicated namespace for module parameters. Module
+parameters can be set via the cmdline by predicating them with
+``memory_hotplug.`` such as::
+
+	memory_hotplug.memmap_on_memory=1
+
+and they can be observed (and some even modified at runtime) via::
+
+	/sys/modules/memory_hotplug/parameters/
+
+The following module parameters are currently defined:
+
+======================== =======================================================
+``memmap_on_memory``	 read-write: Allocate memory for the memmap from the
+			 added memory block itself. Even if enabled, actual
+			 support depends on various other system properties and
+			 should only be regarded as a hint whether the behavior
+			 would be desired.
+
+			 While allocating the memmap from the memory block
+			 itself makes memory hotplug less likely to fail and
+			 keeps the memmap on the same NUMA node in any case, it
+			 can fragment physical memory in a way that huge pages
+			 in bigger granularity cannot be formed on hotplugged
+			 memory.
+======================== =======================================================
+
+ZONE_MOVABLE
+============
+
+ZONE_MOVABLE is an important mechanism for more reliable memory offlining.
+Further, having system RAM managed by ZONE_MOVABLE instead of one of the
+kernel zones can increase the number of possible transparent huge pages and
+dynamically allocated huge pages.
+
+Only movable allocations are served from ZONE_MOVABLE, resulting in
+unmovable allocations being limited to the kernel zones. Without ZONE_MOVABLE,
+there is absolutely no guarantee whether a memory block can be offlined
+successfully.
+
+Zone Imbalances
+---------------
+
+Most kernel allocations are unmovable. Important examples include the memmap
+(usually 1/64 of memory), page tables, and kmalloc(). Such allocations
+can only be served from the kernel zones.
+
+Most user space pages, such as anonymous memory, and page cache pages
+are movable. Such allocations can be served from ZONE_MOVABLE and the kernel
+zones.
+
+Having too much system RAM managed by ZONE_MOVABLE is called a zone imbalance,
+which can harm the system or degrade performance. As one example, the kernel
+might crash because it runs out of free memory for unmovable allocations,
+although there is still plenty of free memory left in ZONE_MOVABLE.
+
+Usually, MOVABLE:KERNEL ratios of up to 3:1 or even 4:1 are fine. Ratios of 63:1
+are definitely impossible due to the memmap overhead.
+
+Actual safe zone ratios depend on the workload. Extreme cases, like excessive
+long-term pinning of pages, might not be able to deal with ZONE_MOVABLE at all.
 
 .. note::
-   Techniques that rely on long-term pinnings of memory (especially, RDMA and
-   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
-   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
-   memory can still get hot removed - be aware that pinning can fail even if
-   there is plenty of free memory in ZONE_MOVABLE. In addition, using
-   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
-   migrated off that zone first.
 
-.. _memory_hotplug_how_to_offline_memory:
+  CMA memory part of a kernel zone essentially behaves like memory in
+  ZONE_MOVABLE and similar considerations apply, especially when combining
+  CMA with ZONE_MOVABLE.
 
-How to offline memory
----------------------
+Considerations
+--------------
 
-You can offline a memory block by using the same sysfs interface that was used
-in memory onlining::
+We usually expect that a large portion of available system RAM will actually
+be consumed by user space, either directly or indirectly via the page cache. In
+the normal case, ZONE_MOVABLE can be used when allocating such pages just fine.
 
-	% echo offline > /sys/devices/system/memory/memoryXXX/state
+With that in mind, it makes sense that we can have a big portion of system RAM
+managed by ZONE_MOVABLE. However, there are some things to consider when
+using ZONE_MOVABLE, especially when fine-tuning zone ratios:
 
-If offline succeeds, the state of the memory block is changed to be "offline".
-If it fails, some error core (like -EBUSY) will be returned by the kernel.
-Even if a memory block does not belong to ZONE_MOVABLE, you can try to offline
-it.  If it doesn't contain 'unmovable' memory, you'll get success.
+- Having a lot of offline memory blocks. Even offline memory blocks consume
+  memory for metadata and page tables in the direct map; having a lot of
+  offline memory blocks is not a typical case, though.
+
+- Memory ballooning. Some memory ballooning implementations, such as
+  the Hyper-V balloon, the XEN balloon, the vbox balloon and the VMWare
+  balloon with huge pages don't support balloon compaction and, thereby
+  ZONE_MOVABLE.
+
+  Further, CONFIG_BALLOON_COMPACTION might be disabled. In that case, balloon
+  inflation will only perform unmovable allocations and silently create a
+  zone imbalance, usually triggered by inflation requests from the
+  hypervisor.
+
+- Gigantic pages are unmovable, resulting in user space consuming a
+  lot of unmovable memory.
+
+- Huge pages are unmovable when an architectures does not support huge
+  page migration, resulting in a similar issue as with gigantic pages.
+
+- Page tables are unmovable. Excessive swapping, mapping extremely large
+  files or ZONE_DEVICE memory can be problematic, although only
+  really relevant in corner cases. When we manage a lot of user space memory
+  that has been swapped out or is served from a file/pmem/... we still need
+  a lot of page tables to manage that memory once user space accessed that
+  memory once.
+
+- DAX: when we have a lot of ZONE_DEVICE memory added to the system as DAX
+  and we are not using an altmap to allocate the memmap from device memory
+  directly, we will have to allocate the memmap for this memory from the
+  kernel zones.
 
-A memory block under ZONE_MOVABLE is considered to be able to be offlined
-easily.  But under some busy state, it may return -EBUSY. Even if a memory
-block cannot be offlined due to -EBUSY, you can retry offlining it and may be
-able to offline it (or not). (For example, a page is referred to by some kernel
-internal call and released soon.)
+- Long-term pinning of pages. Techniques that rely on long-term pinnings
+  (especially, RDMA and vfio/mdev) are fundamentally problematic with
+  ZONE_MOVABLE, and therefore, memory offlining. Pinned pages cannot reside
+  on ZONE_MOVABLE as that would turn these pages unmovable. Therefore, they
+  have to be migrated off that zone while pinning. Pinning a page can fail
+  even if there is plenty of free memory in ZONE_MOVABLE.
 
-Consideration:
-  Memory hotplug's design direction is to make the possibility of memory
-  offlining higher and to guarantee unplugging memory under any situation. But
-  it needs more work. Returning -EBUSY under some situation may be good because
-  the user can decide to retry more or not by himself. Currently, memory
-  offlining code does some amount of retry with 120 seconds timeout.
+  In addition, using ZONE_MOVABLE might make page pinning more expensive,
+  because of the page migration overhead.
 
-Physical memory remove
-======================
+Boot Memory and ZONE_MOVABLE
+----------------------------
 
-Need more implementation yet....
- - Notification completion of remove works by OS to firmware.
- - Guard from remove if not yet.
+Without further configuration, all boot memory will be managed by kernel zones
+when booting up in most configurations. ZONE_MOVABLE is not used as default.
 
+However, there is a mechanism to configure that behavior during boot via the
+cmdline: ``kernelcore=`` and ``movablecore=``. See
+Documentation/admin-guide/kernel-parameters.rst for details.
+
+Memory Offlining and ZONE_MOVABLE
+---------------------------------
+
+Even with ZONE_MOVABLE, there are some corner cases where offlining a memory
+block might fail:
+
+- Memory blocks with memory holes; this applies to memory blocks present during
+  boot and can apply to memory blocks hotplugged via the XEN balloon and the
+  Hyper-V balloon.
+
+- Mixed NUMA nodes and mixed zones within a single memory block prevent memory
+  offlining; this applies to memory blocks present during boot only.
+
+- Special memory blocks prevented by the system from getting offlined. Examples
+  include any memory available during boot on arm64 or memory blocks spanning
+  the crashkernel area on s390x; this usually applies to memory blocks present
+  during boot only.
+
+- Memory blocks overlapping with CMA areas cannot be offlined, this applies to
+  memory blocks present during boot only.
+
+- Concurrent activity that operates on the same physical memory area, such as
+  allocating gigantic pages, can result in temporary offlining failures.
+
+- Out of memory when dissolving huge pages, especially when freeing unused
+  vmemmap pages associated with each hugetlb page is enabled.
+
+  Offlining code may be able to migrate huge page contents, but may not be able
+  to dissolve the source huge page because it fails allocating (unmovable) pages
+  for the vmemmap, because the system might not have free memory in the kernel
+  zones left.
+
+  Users that depend on memory hotplug to succeed for movable zones should
+  carefully consider whether the memory savings gained from this feature are
+  worth the risk of possibly not being able to offline memory in certain
+  situations.
+
+Further, when running into out of memory situations while migrating pages, or
+when still encountering permanently unmovable pages within ZONE_MOVABLE
+(-> BUG), memory offlining will keep retrying until it eventually succeeds.
 
 Locking Internals
 =================
@@ -440,8 +594,8 @@ As the device is visible to user space before taking the device_lock(), this
 can result in a lock inversion.
 
 onlining/offlining of memory should be done via device_online()/
-device_offline() - to make sure it is properly synchronized to actions
-via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
+device_offline() -- to make sure it is properly synchronized to actions
+via sysfs -- while holding the device_hotplug_lock.
 
 When adding/removing/onlining/offlining memory or adding/removing
 heterogeneous/device memory, we should always hold the mem_hotplug_lock in
@@ -452,15 +606,3 @@ In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
 mode allows for a quite efficient get_online_mems/put_online_mems
 implementation, so code accessing memory can protect from that memory
 vanishing.
-
-
-Future Work
-===========
-
-  - allowing memory hot-add to ZONE_MOVABLE. maybe we need some switch like
-    sysctl or new control file.
-  - showing memory block and physical device relationship.
-  - test and make it better memory offlining.
-  - support HugeTLB page migration and offlining.
-  - memmap removing at memory offline.
-  - physical remove memory.
-- 
2.31.1

