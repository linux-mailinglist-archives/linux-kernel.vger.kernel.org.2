Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879CF30A5DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhBAKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbhBAKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612176738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnHeDpI4bvTxudk3KhEYwjLYvMmvMtJjXyTPeOgb0Is=;
        b=ByBtY7XFjieob04k1Q0ONjI4UYMqeLK6rhEdUnG5L0D6s8W12S73bZhRFdXLF3LQt6r7l2
        tB/q2wsx56tTFYG2q8uuSJn2x4hC8l1M+3TJmkoUKQ75Vwt2F/bhc3if+Dd7lYahsLGtDk
        alxF/VC9ovUkZQa5IR0Z/1l5/Bmi9LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Xh8r5YozM_-Og_jNIsx-ww-1; Mon, 01 Feb 2021 05:52:14 -0500
X-MC-Unique: Xh8r5YozM_-Og_jNIsx-ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B30F801817;
        Mon,  1 Feb 2021 10:52:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700FB27CA9;
        Mon,  1 Feb 2021 10:52:08 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-doc@vger.kernel.org
Subject: [PATCH v1 2/2] Documentation: sysfs/memory: clarify some memory block device properties
Date:   Mon,  1 Feb 2021 11:51:58 +0100
Message-Id: <20210201105158.6393-3-david@redhat.com>
In-Reply-To: <20210201105158.6393-1-david@redhat.com>
References: <20210201105158.6393-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory blocks
as removable") we changed the output of the "removable" property of memory
devices to return "1" if and only if the kernel supports memory offlining.

Let's update documentation, stating that the interface is legacy. Also
update documentation of the "state" property and "valid_zones"
properties.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-doc@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../ABI/testing/sysfs-devices-memory          | 53 ++++++++++++-------
 .../admin-guide/mm/memory-hotplug.rst         | 16 +++---
 2 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index 58dbc592bc57..d8b0f80b9e33 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -13,13 +13,13 @@ What:		/sys/devices/system/memory/memoryX/removable
 Date:		June 2008
 Contact:	Badari Pulavarty <pbadari@us.ibm.com>
 Description:
-		The file /sys/devices/system/memory/memoryX/removable
-		indicates whether this memory block is removable or not.
-		This is useful for a user-level agent to determine
-		identify removable sections of the memory before attempting
-		potentially expensive hot-remove memory operation
+		The file /sys/devices/system/memory/memoryX/removable is a
+		legacy interface used to indicated whether a memory block is
+		likely to be offlineable or not.  Newer kernel versions return
+		"1" if and only if the kernel supports memory offlining.
 Users:		hotplug memory remove tools
 		http://www.ibm.com/developerworks/wikis/display/LinuxP/powerpc-utils
+		lsmem/chmem part of util-linux
 
 What:		/sys/devices/system/memory/memoryX/phys_device
 Date:		September 2008
@@ -44,23 +44,25 @@ Date:		September 2008
 Contact:	Badari Pulavarty <pbadari@us.ibm.com>
 Description:
 		The file /sys/devices/system/memory/memoryX/state
-		is read-write.  When read, its contents show the
-		online/offline state of the memory section.  When written,
-		root can toggle the the online/offline state of a removable
-		memory section (see removable file description above)
-		using the following commands::
+		is read-write.  When read, it returns the online/offline
+		state of the memory block.  When written, root can toggle
+		the online/offline state of a memory block using the following
+		commands::
 
 		  # echo online > /sys/devices/system/memory/memoryX/state
 		  # echo offline > /sys/devices/system/memory/memoryX/state
 
-		For example, if /sys/devices/system/memory/memory22/removable
-		contains a value of 1 and
-		/sys/devices/system/memory/memory22/state contains the
-		string "online" the following command can be executed by
-		by root to offline that section::
-
-		  # echo offline > /sys/devices/system/memory/memory22/state
-
+		On newer kernel versions, advanced states can be specified
+		when onlining to select a target zone: "online_movable"
+		selects the movable zone.  "online_kernel" selects the
+		applicable kernel zone (DMA, DMA32, or Normal).  However,
+		after successfully setting one of the advanced states,
+		reading the file will return "online"; the zone information
+		can be obtained via "valid_zones" instead.
+
+		While onlining is unlikely to fail, there are no guarantees
+		that offlining will succeed.  Offlining is more likely to
+		succeed if "valid_zones" indicates "Movable".
 Users:		hotplug memory remove tools
 		http://www.ibm.com/developerworks/wikis/display/LinuxP/powerpc-utils
 
@@ -70,8 +72,19 @@ Date:           July 2014
 Contact:	Zhang Zhen <zhenzhang.zhang@huawei.com>
 Description:
 		The file /sys/devices/system/memory/memoryX/valid_zones	is
-		read-only and is designed to show which zone this memory
-		block can be onlined to.
+		read-only.
+
+		For online memory blocks, it returns in which zone memory
+		provided by a memory block is managed.  If multiple zones
+		apply (not applicable for hotplugged memory), "None" is returned
+		and the memory block cannot be offlined.
+
+		For offline memory blocks, it returns by which zone memory
+		provided by a memory block can be managed when onlining.
+		The first returned zone ("default") will be used when setting
+		the state of an offline memory block to "online".  Only one of
+		the kernel zones (DMA, DMA32, Normal) is applicable for a single
+		memory block.
 
 What:		/sys/devices/system/memoryX/nodeY
 Date:		October 2009
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 245739f55ac7..5307f90738aa 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -162,14 +162,14 @@ Under each memory block, you can see 5 files:
                     which will be performed on all sections in the block.
 ``phys_device``	    read-only: legacy interface only ever used on s390x to
 		    expose the covered storage increment.
-``removable``       read-only: contains an integer value indicating
-                    whether the memory block is removable or not
-                    removable.  A value of 1 indicates that the memory
-                    block is removable and a value of 0 indicates that
-                    it is not removable. A memory block is removable only if
-                    every section in the block is removable.
-``valid_zones``     read-only: designed to show which zones this memory block
-		    can be onlined to.
+``removable``	    read-only: legacy interface that indicated whether a memory
+		    block was likely to be offlineable or not.  Newer kernel
+		    versions return "1" if and only if the kernel supports
+		    memory offlining.
+``valid_zones``     read-only: designed to show by which zone memory provided by
+		    a memory block is managed, and to show by which zone memory
+		    provided by an offline memory block could be managed when
+		    onlining.
 
 		    The first column shows it`s default zone.
 
-- 
2.29.2

