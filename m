Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE3403C13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbhIHPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351946AbhIHPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F83C61168;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=HtBY1I39rjIRmneRFjC4/l5VFjhQC7Mk73QhgY5JabI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZdRqgTXJ8hAWjTqmD2uLF+MmZOiAgV0UWMrBunSA+Rq/WIAikyJ8YrjmRTZ2Sis3
         GGK2dLp2gHQUWvR2Ww9qXIzhtC7IbOppRlegzRRG4TPrHsJMM0pdJdXRDhxve37Aci
         luenOOTbNXN2OIk1yr+FCWT8a1kQ162xvv+1ezNRsI1cq7NycZqpCsuNuYB1bZq+91
         Y+jDb8hOQ5vvsvqbcvFvcWNeDDrMmkby/XNbEI81866WyN3BmWZp+RLdgAEbzA7g4L
         hM61LeG1KeWQZ7BUiW3Pj1mprqv7tHKr1hjjTOnVCtLlEbgDkMlqFw0JZW3c+UDX8q
         ovh+xP+I44eLA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2S-006r41-U6; Wed, 08 Sep 2021 16:59:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ABI: sysfs-kernel-slab: use a wildcard for the cache name
Date:   Wed,  8 Sep 2021 16:58:54 +0200
Message-Id: <753c6667d7daf4d13357b9bb4b33a12681c19cea.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the "cache" part of the description is actually a wildcard,
as, in practice, this will use per-subsystem names:

    /sys/kernel/slab/Acpi-Namespace/align
    /sys/kernel/slab/Acpi-Operand/align
    /sys/kernel/slab/Acpi-Parse/align
...
    /sys/kernel/slab/zswap_entry/align

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-slab | 94 ++++++++++-----------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index c9f12baf8baa..77e5840b00a5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -10,7 +10,7 @@ Description:
 		any cache it aliases, if any).
 Users:		kernel memory tuning tools
 
-What:		/sys/kernel/slab/cache/aliases
+What:		/sys/kernel/slab/<cache>/aliases
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -19,7 +19,7 @@ Description:
 		The aliases file is read-only and specifies how many caches
 		have merged into this cache.
 
-What:		/sys/kernel/slab/cache/align
+What:		/sys/kernel/slab/<cache>/align
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -28,7 +28,7 @@ Description:
 		The align file is read-only and specifies the cache's object
 		alignment in bytes.
 
-What:		/sys/kernel/slab/cache/alloc_calls
+What:		/sys/kernel/slab/<cache>/alloc_calls
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -39,7 +39,7 @@ Description:
 		The alloc_calls file only contains information if debugging is
 		enabled for that cache (see Documentation/vm/slub.rst).
 
-What:		/sys/kernel/slab/cache/alloc_fastpath
+What:		/sys/kernel/slab/<cache>/alloc_fastpath
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -50,7 +50,7 @@ Description:
 		current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/alloc_from_partial
+What:		/sys/kernel/slab/<cache>/alloc_from_partial
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -62,7 +62,7 @@ Description:
 		count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/alloc_refill
+What:		/sys/kernel/slab/<cache>/alloc_refill
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -73,7 +73,7 @@ Description:
 		remote cpu frees.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/alloc_slab
+What:		/sys/kernel/slab/<cache>/alloc_slab
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -84,7 +84,7 @@ Description:
 		clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/alloc_slowpath
+What:		/sys/kernel/slab/<cache>/alloc_slowpath
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -96,7 +96,7 @@ Description:
 		clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/cache_dma
+What:		/sys/kernel/slab/<cache>/cache_dma
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -106,7 +106,7 @@ Description:
 		are from ZONE_DMA.
 		Available when CONFIG_ZONE_DMA is enabled.
 
-What:		/sys/kernel/slab/cache/cpu_slabs
+What:		/sys/kernel/slab/<cache>/cpu_slabs
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -115,7 +115,7 @@ Description:
 		The cpu_slabs file is read-only and displays how many cpu slabs
 		are active and their NUMA locality.
 
-What:		/sys/kernel/slab/cache/cpuslab_flush
+What:		/sys/kernel/slab/<cache>/cpuslab_flush
 Date:		April 2009
 KernelVersion:	2.6.31
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -128,7 +128,7 @@ Description:
 		current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/ctor
+What:		/sys/kernel/slab/<cache>/ctor
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -138,7 +138,7 @@ Description:
 		constructor function, which is invoked for each object when a
 		new slab is allocated.
 
-What:		/sys/kernel/slab/cache/deactivate_empty
+What:		/sys/kernel/slab/<cache>/deactivate_empty
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -148,7 +148,7 @@ Description:
 		was deactivated.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/deactivate_full
+What:		/sys/kernel/slab/<cache>/deactivate_full
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -158,7 +158,7 @@ Description:
 		was deactivated.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/deactivate_remote_frees
+What:		/sys/kernel/slab/<cache>/deactivate_remote_frees
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -169,7 +169,7 @@ Description:
 		remotely.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/deactivate_to_head
+What:		/sys/kernel/slab/<cache>/deactivate_to_head
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -180,7 +180,7 @@ Description:
 		list.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/deactivate_to_tail
+What:		/sys/kernel/slab/<cache>/deactivate_to_tail
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -191,7 +191,7 @@ Description:
 		list.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/destroy_by_rcu
+What:		/sys/kernel/slab/<cache>/destroy_by_rcu
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -200,7 +200,7 @@ Description:
 		The destroy_by_rcu file is read-only and specifies whether
 		slabs (not objects) are freed by rcu.
 
-What:		/sys/kernel/slab/cache/free_add_partial
+What:		/sys/kernel/slab/<cache>/free_add_partial
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -211,7 +211,7 @@ Description:
 		partial list.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/free_calls
+What:		/sys/kernel/slab/<cache>/free_calls
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -221,7 +221,7 @@ Description:
 		object frees if slab debugging is enabled (see
 		Documentation/vm/slub.rst).
 
-What:		/sys/kernel/slab/cache/free_fastpath
+What:		/sys/kernel/slab/<cache>/free_fastpath
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -232,7 +232,7 @@ Description:
 		It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/free_frozen
+What:		/sys/kernel/slab/<cache>/free_frozen
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -243,7 +243,7 @@ Description:
 		clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/free_remove_partial
+What:		/sys/kernel/slab/<cache>/free_remove_partial
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -255,7 +255,7 @@ Description:
 		count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/free_slab
+What:		/sys/kernel/slab/<cache>/free_slab
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -266,7 +266,7 @@ Description:
 		the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/free_slowpath
+What:		/sys/kernel/slab/<cache>/free_slowpath
 Date:		February 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -277,7 +277,7 @@ Description:
 		be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/hwcache_align
+What:		/sys/kernel/slab/<cache>/hwcache_align
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -286,7 +286,7 @@ Description:
 		The hwcache_align file is read-only and specifies whether
 		objects are aligned on cachelines.
 
-What:		/sys/kernel/slab/cache/min_partial
+What:		/sys/kernel/slab/<cache>/min_partial
 Date:		February 2009
 KernelVersion:	2.6.30
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -297,7 +297,7 @@ Description:
 		allocating new slabs.  Such slabs may be reclaimed by utilizing
 		the shrink file.
 
-What:		/sys/kernel/slab/cache/object_size
+What:		/sys/kernel/slab/<cache>/object_size
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -306,7 +306,7 @@ Description:
 		The object_size file is read-only and specifies the cache's
 		object size.
 
-What:		/sys/kernel/slab/cache/objects
+What:		/sys/kernel/slab/<cache>/objects
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -315,7 +315,7 @@ Description:
 		The objects file is read-only and displays how many objects are
 		active and from which nodes they are from.
 
-What:		/sys/kernel/slab/cache/objects_partial
+What:		/sys/kernel/slab/<cache>/objects_partial
 Date:		April 2008
 KernelVersion:	2.6.26
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -325,7 +325,7 @@ Description:
 		objects are on partial slabs and from which nodes they are
 		from.
 
-What:		/sys/kernel/slab/cache/objs_per_slab
+What:		/sys/kernel/slab/<cache>/objs_per_slab
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -333,9 +333,9 @@ Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
 Description:
 		The file objs_per_slab is read-only and specifies how many
 		objects may be allocated from a single slab of the order
-		specified in /sys/kernel/slab/cache/order.
+		specified in /sys/kernel/slab/<cache>/order.
 
-What:		/sys/kernel/slab/cache/order
+What:		/sys/kernel/slab/<cache>/order
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -352,7 +352,7 @@ Description:
 		order is used and this sysfs entry can not be used to change
 		the order at run time.
 
-What:		/sys/kernel/slab/cache/order_fallback
+What:		/sys/kernel/slab/<cache>/order_fallback
 Date:		April 2008
 KernelVersion:	2.6.26
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -365,7 +365,7 @@ Description:
 
 		Available when CONFIG_SLUB_STATS is enabled.
 
-What:		/sys/kernel/slab/cache/partial
+What:		/sys/kernel/slab/<cache>/partial
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -374,7 +374,7 @@ Description:
 		The partial file is read-only and displays how long many
 		partial slabs there are and how long each node's list is.
 
-What:		/sys/kernel/slab/cache/poison
+What:		/sys/kernel/slab/<cache>/poison
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -383,7 +383,7 @@ Description:
 		The poison file specifies whether objects should be poisoned
 		when a new slab is allocated.
 
-What:		/sys/kernel/slab/cache/reclaim_account
+What:		/sys/kernel/slab/<cache>/reclaim_account
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -392,7 +392,7 @@ Description:
 		The reclaim_account file specifies whether the cache's objects
 		are reclaimable (and grouped by their mobility).
 
-What:		/sys/kernel/slab/cache/red_zone
+What:		/sys/kernel/slab/<cache>/red_zone
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -401,7 +401,7 @@ Description:
 		The red_zone file specifies whether the cache's objects are red
 		zoned.
 
-What:		/sys/kernel/slab/cache/remote_node_defrag_ratio
+What:		/sys/kernel/slab/<cache>/remote_node_defrag_ratio
 Date:		January 2008
 KernelVersion:	2.6.25
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -415,7 +415,7 @@ Description:
 
 		Available when CONFIG_NUMA is enabled.
 
-What:		/sys/kernel/slab/cache/sanity_checks
+What:		/sys/kernel/slab/<cache>/sanity_checks
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -426,7 +426,7 @@ Description:
 		checks.  Caches that enable sanity_checks cannot be merged with
 		caches that do not.
 
-What:		/sys/kernel/slab/cache/shrink
+What:		/sys/kernel/slab/<cache>/shrink
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -442,7 +442,7 @@ Description:
 		adversely impact other running applications.  So it
 		should be used with care.
 
-What:		/sys/kernel/slab/cache/slab_size
+What:		/sys/kernel/slab/<cache>/slab_size
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -451,7 +451,7 @@ Description:
 		The slab_size file is read-only and specifies the object size
 		with metadata (debugging information and alignment) in bytes.
 
-What:		/sys/kernel/slab/cache/slabs
+What:		/sys/kernel/slab/<cache>/slabs
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -461,7 +461,7 @@ Description:
 		there are (both cpu and partial) and from which nodes they are
 		from.
 
-What:		/sys/kernel/slab/cache/store_user
+What:		/sys/kernel/slab/<cache>/store_user
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -470,7 +470,7 @@ Description:
 		The store_user file specifies whether the location of
 		allocation or free should be tracked for a cache.
 
-What:		/sys/kernel/slab/cache/total_objects
+What:		/sys/kernel/slab/<cache>/total_objects
 Date:		April 2008
 KernelVersion:	2.6.26
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -479,7 +479,7 @@ Description:
 		The total_objects file is read-only and displays how many total
 		objects a cache has and from which nodes they are from.
 
-What:		/sys/kernel/slab/cache/trace
+What:		/sys/kernel/slab/<cache>/trace
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
@@ -488,7 +488,7 @@ Description:
 		The trace file specifies whether object allocations and frees
 		should be traced.
 
-What:		/sys/kernel/slab/cache/validate
+What:		/sys/kernel/slab/<cache>/validate
 Date:		May 2007
 KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
-- 
2.31.1

