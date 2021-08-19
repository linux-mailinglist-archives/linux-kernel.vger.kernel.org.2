Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B43F211B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhHSTyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhHSTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:54:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A590C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g11so5584775qtk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVVGLw1r7yJ/rcgAC7V6ll4qt4izuftp3UCKThI0BB0=;
        b=DnCSFPBbDIw8zdsCdzkAkJLB8ZFRmXOdAP1jB0gYzj9NAmP8EJAp1BnCtzXZBQ1Tly
         ccsckeGPiQ11wrYq8VSdSqSqCHK8YV/2/Jwu7PZzlJyggNoxCcjm9Kc7DqUp40pSrPv2
         NrFo9ZNXvx1iY/7LSfxdxbUx+reKT1+I8/90aymlTN9wyvjzbTyqX1UieU9yIzsqBrVv
         BL2HUtRWdOB/CuQOYW4wJ1oYnDbfH8ZIh3NR7COZe+ujvmqCt16sCH0c+OroCm+r6OON
         ux/eg8RhpRWOyxC1oMcWrYSs5lnUrX/tBD7EWjoQ8yWZPTeqcESDkAeEjdTZH627sh1U
         B94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVVGLw1r7yJ/rcgAC7V6ll4qt4izuftp3UCKThI0BB0=;
        b=oHPHdIn+8V4dox2wj5/n6mpkyiXeLLBmkiGSThoukkNDN+XRGBPVHXsiiJcuSteLOe
         CcbxtrAfiVgJ1k4Snio7QW/kd7r8voTjUbk5vGs/kudoy1wa/DHxA6kRdTqIW4qZV6Ww
         xob2vSRG2AsAJEv+UpzMEBAoMTb/BtTLnM0kNHpb5TNfXmuEUtDas1Y5rrKozSfOtP/F
         wqpNdHKa/9upNB8OC27kYKAycYSjGuSGgP6SOWSkq8kPqozFHin+LQ/Xo1r757Vmr8QF
         xjzM1VVp5SVd9/pyclHVoLU/PWqdDfM0i3cluPgE1e/w4ftsAxcKvcW5UJv/n33eNkER
         +7SA==
X-Gm-Message-State: AOAM531BL7HRtCZxODFm8lCk0vn1wTG9ot7NQ5iSLhBT0XpkMMTc0TF0
        Za9B2tyiNTNjM0uddbELV30QtA==
X-Google-Smtp-Source: ABdhPJzOevSBrQZwGK+wFMGGkmMmQPwYOJYH3IgFv+7rB+u+3zA41R1tJMZzTZfKWaL85xfCO7P6yA==
X-Received: by 2002:a05:622a:2cc:: with SMTP id a12mr14288496qtx.115.1629402836481;
        Thu, 19 Aug 2021 12:53:56 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j185sm2168388qkf.28.2021.08.19.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:53:55 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/4] mm: Kconfig: group swap, slab, hotplug and thp options into submenus
Date:   Thu, 19 Aug 2021 15:55:31 -0400
Message-Id: <20210819195533.211756-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819195533.211756-1-hannes@cmpxchg.org>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several clusters of related config options spread throughout
the mostly flat MM submenu. Group them together and put specialization
options into further subdirectories to make the MM section a bit more
organized and easier to navigate.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/Kconfig | 428 +++++++++++++++++++++++++++--------------------------
 1 file changed, 222 insertions(+), 206 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 894858536e7f..dbceaa2a04a4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -9,7 +9,7 @@ menu "Memory Management options"
 config ARCH_NO_SWAP
 	bool
 
-config SWAP
+menuconfig SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU && BLOCK && !ARCH_NO_SWAP
 	default y
@@ -19,6 +19,192 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+if SWAP
+
+config ZSWAP
+	bool "Compressed cache for swap pages (EXPERIMENTAL)"
+	depends on FRONTSWAP && CRYPTO=y
+	select ZPOOL
+	help
+	  A lightweight compressed cache for swap pages.  It takes
+	  pages that are in the process of being swapped out and attempts to
+	  compress them into a dynamically allocated RAM-based memory pool.
+	  This can result in a significant I/O reduction on swap device and,
+	  in the case where decompressing from RAM is faster that swap device
+	  reads, can also improve workload performance.
+
+	  This is marked experimental because it is a new feature (as of
+	  v3.11) that interacts heavily with memory reclaim.  While these
+	  interactions don't cause any known issues on simple memory setups,
+	  they have not be fully explored on the large set of potential
+	  configurations and workloads that exist.
+
+choice
+	prompt "Compressed cache for swap pages default compressor"
+	depends on ZSWAP
+	default ZSWAP_COMPRESSOR_DEFAULT_LZO
+	help
+	  Selects the default compression algorithm for the compressed cache
+	  for swap pages.
+
+	  For an overview what kind of performance can be expected from
+	  a particular compression algorithm please refer to the benchmarks
+	  available at the following LWN page:
+	  https://lwn.net/Articles/751795/
+
+	  If in doubt, select 'LZO'.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.compressor=' option.
+
+config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+	bool "Deflate"
+	select CRYPTO_DEFLATE
+	help
+	  Use the Deflate algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZO
+	bool "LZO"
+	select CRYPTO_LZO
+	help
+	  Use the LZO algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_842
+	bool "842"
+	select CRYPTO_842
+	help
+	  Use the 842 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4
+	bool "LZ4"
+	select CRYPTO_LZ4
+	help
+	  Use the LZ4 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+	bool "LZ4HC"
+	select CRYPTO_LZ4HC
+	help
+	  Use the LZ4HC algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+	bool "zstd"
+	select CRYPTO_ZSTD
+	help
+	  Use the zstd algorithm as the default compression algorithm.
+endchoice
+
+config ZSWAP_COMPRESSOR_DEFAULT
+       string
+       depends on ZSWAP
+       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
+       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
+       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
+       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+       default ""
+
+choice
+	prompt "Compressed cache for swap pages default allocator"
+	depends on ZSWAP
+	default ZSWAP_ZPOOL_DEFAULT_ZBUD
+	help
+	  Selects the default allocator for the compressed cache for
+	  swap pages.
+	  The default is 'zbud' for compatibility, however please do
+	  read the description of each of the allocators below before
+	  making a right choice.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.zpool=' option.
+
+config ZSWAP_ZPOOL_DEFAULT_ZBUD
+	bool "zbud"
+	select ZBUD
+	help
+	  Use the zbud allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+	bool "z3fold"
+	select Z3FOLD
+	help
+	  Use the z3fold allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+	bool "zsmalloc"
+	select ZSMALLOC
+	help
+	  Use the zsmalloc allocator as the default allocator.
+endchoice
+
+config ZSWAP_ZPOOL_DEFAULT
+       string
+       depends on ZSWAP
+       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+       default ""
+
+config ZSWAP_DEFAULT_ON
+	bool "Enable the compressed cache for swap pages by default"
+	depends on ZSWAP
+	help
+	  If selected, the compressed cache for swap pages will be enabled
+	  at boot, otherwise it will be disabled.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.enabled=' option.
+
+config ZPOOL
+	tristate "Common API for compressed memory storage"
+	help
+	  Compressed memory storage API.  This allows using either zbud or
+	  zsmalloc.
+
+config ZBUD
+	tristate "Low (Up to 2x) density storage for compressed pages"
+	help
+	  A special purpose allocator for storing compressed pages.
+	  It is designed to store up to two compressed pages per physical
+	  page.  While this design limits storage density, it has simple and
+	  deterministic reclaim properties that make it preferable to a higher
+	  density approach when reclaim will be used.
+
+config Z3FOLD
+	tristate "Up to 3x density storage for compressed pages"
+	depends on ZPOOL
+	help
+	  A special purpose allocator for storing compressed pages.
+	  It is designed to store up to three compressed pages per physical
+	  page. It is a ZBUD derivative so the simplicity and determinism are
+	  still there.
+
+config ZSMALLOC
+	tristate "Memory allocator for compressed pages"
+	depends on MMU
+	help
+	  zsmalloc is a slab-based memory allocator designed to store
+	  compressed RAM pages.  zsmalloc uses virtual memory mapping
+	  in order to reduce fragmentation.  However, this results in a
+	  non-standard allocator interface where a handle, not a pointer, is
+	  returned by an alloc().  This handle must be mapped in order to
+	  access the allocated space.
+
+config ZSMALLOC_STAT
+	bool "Export zsmalloc statistics"
+	depends on ZSMALLOC
+	select DEBUG_FS
+	help
+	  This option enables code in the zsmalloc to collect various
+	  statistics about what's happening in zsmalloc and exports that
+	  information to userspace via debugfs.
+	  If unsure, say N.
+
+endif # SWAP
+
+menu "SLAB allocator options"
+
 choice
 	prompt "Choose SLAB allocator"
 	default SLUB
@@ -87,6 +273,19 @@ config SLAB_FREELIST_HARDENED
 	  sanity-checking than others. This option is most effective with
 	  CONFIG_SLUB.
 
+config SLUB_CPU_PARTIAL
+	default y
+	depends on SLUB && SMP
+	bool "SLUB per cpu partial cache"
+	help
+	  Per cpu partial caches accelerate objects allocation and freeing
+	  that is local to a processor at the price of more indeterminism
+	  in the latency of the free. On overflow these caches will be cleared
+	  which requires the taking of locks that may cause latency spikes.
+	  Typically one would choose no for a realtime system.
+
+endmenu # SLAB allocator options
+
 config SHUFFLE_PAGE_ALLOCATOR
 	bool "Page allocator randomization"
 	default SLAB_FREELIST_RANDOM && ACPI_NUMA
@@ -111,17 +310,6 @@ config SHUFFLE_PAGE_ALLOCATOR
 
 	  Say Y if unsure.
 
-config SLUB_CPU_PARTIAL
-	default y
-	depends on SLUB && SMP
-	bool "SLUB per cpu partial cache"
-	help
-	  Per cpu partial caches accelerate objects allocation and freeing
-	  that is local to a processor at the price of more indeterminism
-	  in the latency of the free. On overflow these caches will be cleared
-	  which requires the taking of locks that may cause latency spikes.
-	  Typically one would choose no for a realtime system.
-
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
@@ -272,14 +460,16 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 	bool
 
 # eventually, we can have this option just 'select SPARSEMEM'
-config MEMORY_HOTPLUG
-	bool "Allow for memory hot-add"
+menuconfig MEMORY_HOTPLUG
+	bool "Memory hotplug"
 	select MEMORY_ISOLATION
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT || BROKEN
 	select NUMA_KEEP_MEMINFO if NUMA
 
+if MEMORY_HOTPLUG
+
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y
 	depends on SPARSEMEM && MEMORY_HOTPLUG
@@ -313,6 +503,8 @@ config MHP_MEMMAP_ON_MEMORY
 	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
 	depends on ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 
+endif # MEMORY_HOTPLUG
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
@@ -521,7 +713,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 
 	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
-config TRANSPARENT_HUGEPAGE
+menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select COMPACTION
@@ -536,6 +728,8 @@ config TRANSPARENT_HUGEPAGE
 
 	  If memory constrained on embedded, you may want to say N.
 
+if TRANSPARENT_HUGEPAGE
+
 choice
 	prompt "Transparent Hugepage Support sysfs defaults"
 	depends on TRANSPARENT_HUGEPAGE
@@ -573,6 +767,19 @@ config THP_SWAP
 
 	  For selection by architectures with reasonable THP sizes.
 
+config READ_ONLY_THP_FOR_FS
+	bool "Read-only THP for filesystems (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && SHMEM
+
+	help
+	  Allow khugepaged to put read-only file-backed pages in THP.
+
+	  This is marked experimental because it is a new feature. Write
+	  support of file THPs will be developed in the next few release
+	  cycles.
+
+endif # TRANSPARENT_HUGEPAGE
+
 #
 # UP and nommu archs use km based percpu allocator
 #
@@ -680,186 +887,6 @@ config MEM_SOFT_DIRTY
 
 	  See Documentation/admin-guide/mm/soft-dirty.rst for more details.
 
-config ZSWAP
-	bool "Compressed cache for swap pages (EXPERIMENTAL)"
-	depends on FRONTSWAP && CRYPTO=y
-	select ZPOOL
-	help
-	  A lightweight compressed cache for swap pages.  It takes
-	  pages that are in the process of being swapped out and attempts to
-	  compress them into a dynamically allocated RAM-based memory pool.
-	  This can result in a significant I/O reduction on swap device and,
-	  in the case where decompressing from RAM is faster that swap device
-	  reads, can also improve workload performance.
-
-	  This is marked experimental because it is a new feature (as of
-	  v3.11) that interacts heavily with memory reclaim.  While these
-	  interactions don't cause any known issues on simple memory setups,
-	  they have not be fully explored on the large set of potential
-	  configurations and workloads that exist.
-
-choice
-	prompt "Compressed cache for swap pages default compressor"
-	depends on ZSWAP
-	default ZSWAP_COMPRESSOR_DEFAULT_LZO
-	help
-	  Selects the default compression algorithm for the compressed cache
-	  for swap pages.
-
-	  For an overview what kind of performance can be expected from
-	  a particular compression algorithm please refer to the benchmarks
-	  available at the following LWN page:
-	  https://lwn.net/Articles/751795/
-
-	  If in doubt, select 'LZO'.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.compressor=' option.
-
-config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
-	bool "Deflate"
-	select CRYPTO_DEFLATE
-	help
-	  Use the Deflate algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZO
-	bool "LZO"
-	select CRYPTO_LZO
-	help
-	  Use the LZO algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_842
-	bool "842"
-	select CRYPTO_842
-	help
-	  Use the 842 algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4
-	bool "LZ4"
-	select CRYPTO_LZ4
-	help
-	  Use the LZ4 algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
-	bool "LZ4HC"
-	select CRYPTO_LZ4HC
-	help
-	  Use the LZ4HC algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
-	bool "zstd"
-	select CRYPTO_ZSTD
-	help
-	  Use the zstd algorithm as the default compression algorithm.
-endchoice
-
-config ZSWAP_COMPRESSOR_DEFAULT
-       string
-       depends on ZSWAP
-       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
-       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
-       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
-       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
-       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
-       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
-       default ""
-
-choice
-	prompt "Compressed cache for swap pages default allocator"
-	depends on ZSWAP
-	default ZSWAP_ZPOOL_DEFAULT_ZBUD
-	help
-	  Selects the default allocator for the compressed cache for
-	  swap pages.
-	  The default is 'zbud' for compatibility, however please do
-	  read the description of each of the allocators below before
-	  making a right choice.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.zpool=' option.
-
-config ZSWAP_ZPOOL_DEFAULT_ZBUD
-	bool "zbud"
-	select ZBUD
-	help
-	  Use the zbud allocator as the default allocator.
-
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
-	help
-	  Use the z3fold allocator as the default allocator.
-
-config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
-	bool "zsmalloc"
-	select ZSMALLOC
-	help
-	  Use the zsmalloc allocator as the default allocator.
-endchoice
-
-config ZSWAP_ZPOOL_DEFAULT
-       string
-       depends on ZSWAP
-       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
-       default ""
-
-config ZSWAP_DEFAULT_ON
-	bool "Enable the compressed cache for swap pages by default"
-	depends on ZSWAP
-	help
-	  If selected, the compressed cache for swap pages will be enabled
-	  at boot, otherwise it will be disabled.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.enabled=' option.
-
-config ZPOOL
-	tristate "Common API for compressed memory storage"
-	help
-	  Compressed memory storage API.  This allows using either zbud or
-	  zsmalloc.
-
-config ZBUD
-	tristate "Low (Up to 2x) density storage for compressed pages"
-	help
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to two compressed pages per physical
-	  page.  While this design limits storage density, it has simple and
-	  deterministic reclaim properties that make it preferable to a higher
-	  density approach when reclaim will be used.
-
-config Z3FOLD
-	tristate "Up to 3x density storage for compressed pages"
-	depends on ZPOOL
-	help
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to three compressed pages per physical
-	  page. It is a ZBUD derivative so the simplicity and determinism are
-	  still there.
-
-config ZSMALLOC
-	tristate "Memory allocator for compressed pages"
-	depends on MMU
-	help
-	  zsmalloc is a slab-based memory allocator designed to store
-	  compressed RAM pages.  zsmalloc uses virtual memory mapping
-	  in order to reduce fragmentation.  However, this results in a
-	  non-standard allocator interface where a handle, not a pointer, is
-	  returned by an alloc().  This handle must be mapped in order to
-	  access the allocated space.
-
-config ZSMALLOC_STAT
-	bool "Export zsmalloc statistics"
-	depends on ZSMALLOC
-	select DEBUG_FS
-	help
-	  This option enables code in the zsmalloc to collect various
-	  statistics about what's happening in zsmalloc and exports that
-	  information to userspace via debugfs.
-	  If unsure, say N.
-
 config GENERIC_EARLY_IOREMAP
 	bool
 
@@ -988,17 +1015,6 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
 config GUP_GET_PTE_LOW_HIGH
 	bool
 
-config READ_ONLY_THP_FOR_FS
-	bool "Read-only THP for filesystems (EXPERIMENTAL)"
-	depends on TRANSPARENT_HUGEPAGE && SHMEM
-
-	help
-	  Allow khugepaged to put read-only file-backed pages in THP.
-
-	  This is marked experimental because it is a new feature. Write
-	  support of file THPs will be developed in the next few release
-	  cycles.
-
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
-- 
2.32.0

