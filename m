Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619F23F211A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHSTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhHSTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:54:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC550C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:55 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t190so8467325qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0Vyo5Zpb/uKT9dTj3UDP38gz9wGa8FmLTe57ROUr0k=;
        b=nQwyYmzJ8Le7zMUt1HvjgRtMrGeHPynrZFZ0AGdDTvQ8sacbnNjxT4kbWrvN3vqlqc
         E7egmJZfZ0BuNIYc1+L59p+csI2/9saKxmtGVrf96I3Ii4Dq9kwqY3f6HZMkcztVSmYV
         ALfQ330+kUdEDUz+JV/wU7C29qYiagfkGZTxcpQlzRhAiYH6fxPaJAMq5yd4HbDTfgL1
         blKs5koPh7juPKSjT0AwDo0+rwCv/cLgbBvxV2/M0M+XiUZE3Il5SPwL/EZRQW9rnlRY
         jai9LWOMhrhKRJ9p15RyGey3TP55vuHUkh/VM91jw7ELErAJr4Zf2Z0IJ/kYToSoss54
         zjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0Vyo5Zpb/uKT9dTj3UDP38gz9wGa8FmLTe57ROUr0k=;
        b=C/o0k6rRUphjxz29blLVSX4hxBUKkahTZutIS1PLH1QRau3VSGgB0mtMaWHpLZLFLm
         VgTNy4R4Un5GWoYPqsnBW20KI0qT6WDJz1IlpLbCwbo+cncoayxtCYlP2/1zB2OHHMER
         Hrb4E4cMdXBokedd//h560wRZEN8HPwKdmnvuuyzsWUPLBAgzAil8WSGL5RrI7ucvSvy
         u/SMBeT2FzEEBtoJu8nn3eVCqPMY+5smHm+R8ES3+ayNjODFD5vISMr1BWk3im7GfuoU
         30m+/pOAzt2aW7u0UuF8RDK0okmRlW124fG8vhQz6qjeqmcgj/Qoff/s9E/SjGbjbsnW
         TCVg==
X-Gm-Message-State: AOAM530GQ3sKkHVxNJLAKkbShnQ8CqEJcAobBTPHw6hDUejfQJ+7/SoZ
        SIva5WDmI4XvRJ+YWDC/WYXN3Q==
X-Google-Smtp-Source: ABdhPJy9zvg5l8XB1C6E0TAARsBwSXIkC5w/HxVKpgjx9112FX0dad/lmtNVJavK/KExC9nNqqwVkg==
X-Received: by 2002:a05:620a:1a14:: with SMTP id bk20mr5196856qkb.481.1629402835079;
        Thu, 19 Aug 2021 12:53:55 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bm7sm2014304qkb.79.2021.08.19.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:53:54 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/4] mm: Kconfig: move swap and slab config options to the MM section
Date:   Thu, 19 Aug 2021 15:55:30 -0400
Message-Id: <20210819195533.211756-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are currently under General Setup. MM seems like a better fit.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 init/Kconfig | 120 ---------------------------------------------------
 mm/Kconfig   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a61c92066c2e..a2358cd5498a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -331,23 +331,6 @@ config DEFAULT_HOSTNAME
 	  but you may wish to use a different default here to make a minimal
 	  system more usable with less configuration.
 
-#
-# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
-# add proper SWAP support to them, in which case this can be remove.
-#
-config ARCH_NO_SWAP
-	bool
-
-config SWAP
-	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU && BLOCK && !ARCH_NO_SWAP
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for so called swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unsure say Y.
-
 config SYSVIPC
 	bool "System V IPC"
 	help
@@ -1862,109 +1845,6 @@ config COMPAT_BRK
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
-choice
-	prompt "Choose SLAB allocator"
-	default SLUB
-	help
-	   This option allows to select a slab allocator.
-
-config SLAB
-	bool "SLAB"
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
-	help
-	  The regular slab allocator that is established and known to work
-	  well in all environments. It organizes cache hot objects in
-	  per cpu and per node queues.
-
-config SLUB
-	bool "SLUB (Unqueued Allocator)"
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
-	help
-	   SLUB is a slab allocator that minimizes cache line usage
-	   instead of managing queues of cached objects (SLAB approach).
-	   Per cpu caching is realized using slabs of objects instead
-	   of queues of objects. SLUB can use memory efficiently
-	   and has enhanced diagnostics. SLUB is the default choice for
-	   a slab allocator.
-
-config SLOB
-	depends on EXPERT
-	bool "SLOB (Simple Allocator)"
-	help
-	   SLOB replaces the stock allocator with a drastically simpler
-	   allocator. SLOB is generally more space efficient but
-	   does not perform as well on large systems.
-
-endchoice
-
-config SLAB_MERGE_DEFAULT
-	bool "Allow slab caches to be merged"
-	default y
-	help
-	  For reduced kernel memory fragmentation, slab caches can be
-	  merged when they share the same size and other characteristics.
-	  This carries a risk of kernel heap overflows being able to
-	  overwrite objects from merged caches (and more easily control
-	  cache layout), which makes such heap attacks easier to exploit
-	  by attackers. By keeping caches unmerged, these kinds of exploits
-	  can usually only damage objects in the same cache. To disable
-	  merging at runtime, "slab_nomerge" can be passed on the kernel
-	  command line.
-
-config SLAB_FREELIST_RANDOM
-	bool "Randomize slab freelist"
-	depends on SLAB || SLUB
-	help
-	  Randomizes the freelist order used on creating new pages. This
-	  security feature reduces the predictability of the kernel slab
-	  allocator against heap overflows.
-
-config SLAB_FREELIST_HARDENED
-	bool "Harden slab freelist metadata"
-	depends on SLAB || SLUB
-	help
-	  Many kernel heap attacks try to target slab cache metadata and
-	  other infrastructure. This options makes minor performance
-	  sacrifices to harden the kernel slab allocator against common
-	  freelist exploit methods. Some slab implementations have more
-	  sanity-checking than others. This option is most effective with
-	  CONFIG_SLUB.
-
-config SHUFFLE_PAGE_ALLOCATOR
-	bool "Page allocator randomization"
-	default SLAB_FREELIST_RANDOM && ACPI_NUMA
-	help
-	  Randomization of the page allocator improves the average
-	  utilization of a direct-mapped memory-side-cache. See section
-	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
-	  6.2a specification for an example of how a platform advertises
-	  the presence of a memory-side-cache. There are also incidental
-	  security benefits as it reduces the predictability of page
-	  allocations to compliment SLAB_FREELIST_RANDOM, but the
-	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
-	  10th order of pages is selected based on cache utilization
-	  benefits on x86.
-
-	  While the randomization improves cache utilization it may
-	  negatively impact workloads on platforms without a cache. For
-	  this reason, by default, the randomization is enabled only
-	  after runtime detection of a direct-mapped memory-side-cache.
-	  Otherwise, the randomization may be force enabled with the
-	  'page_alloc.shuffle' kernel command line parameter.
-
-	  Say Y if unsure.
-
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
 config MMAP_ALLOW_UNINITIALIZED
 	bool "Allow mmapped anonymous memory to be uninitialized"
 	depends on EXPERT && !MMU
diff --git a/mm/Kconfig b/mm/Kconfig
index 02d44e3420f5..894858536e7f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -2,6 +2,126 @@
 
 menu "Memory Management options"
 
+#
+# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
+# add proper SWAP support to them, in which case this can be remove.
+#
+config ARCH_NO_SWAP
+	bool
+
+config SWAP
+	bool "Support for paging of anonymous memory (swap)"
+	depends on MMU && BLOCK && !ARCH_NO_SWAP
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for so called swap devices or swap files in your kernel that are
+	  used to provide more virtual memory than the actual RAM present
+	  in your computer.  If unsure say Y.
+
+choice
+	prompt "Choose SLAB allocator"
+	default SLUB
+	help
+	   This option allows to select a slab allocator.
+
+config SLAB
+	bool "SLAB"
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
+	help
+	  The regular slab allocator that is established and known to work
+	  well in all environments. It organizes cache hot objects in
+	  per cpu and per node queues.
+
+config SLUB
+	bool "SLUB (Unqueued Allocator)"
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
+	help
+	   SLUB is a slab allocator that minimizes cache line usage
+	   instead of managing queues of cached objects (SLAB approach).
+	   Per cpu caching is realized using slabs of objects instead
+	   of queues of objects. SLUB can use memory efficiently
+	   and has enhanced diagnostics. SLUB is the default choice for
+	   a slab allocator.
+
+config SLOB
+	depends on EXPERT
+	bool "SLOB (Simple Allocator)"
+	help
+	   SLOB replaces the stock allocator with a drastically simpler
+	   allocator. SLOB is generally more space efficient but
+	   does not perform as well on large systems.
+
+endchoice
+
+config SLAB_MERGE_DEFAULT
+	bool "Allow slab caches to be merged"
+	default y
+	help
+	  For reduced kernel memory fragmentation, slab caches can be
+	  merged when they share the same size and other characteristics.
+	  This carries a risk of kernel heap overflows being able to
+	  overwrite objects from merged caches (and more easily control
+	  cache layout), which makes such heap attacks easier to exploit
+	  by attackers. By keeping caches unmerged, these kinds of exploits
+	  can usually only damage objects in the same cache. To disable
+	  merging at runtime, "slab_nomerge" can be passed on the kernel
+	  command line.
+
+config SLAB_FREELIST_RANDOM
+	bool "Randomize slab freelist"
+	depends on SLAB || SLUB
+	help
+	  Randomizes the freelist order used on creating new pages. This
+	  security feature reduces the predictability of the kernel slab
+	  allocator against heap overflows.
+
+config SLAB_FREELIST_HARDENED
+	bool "Harden slab freelist metadata"
+	depends on SLAB || SLUB
+	help
+	  Many kernel heap attacks try to target slab cache metadata and
+	  other infrastructure. This options makes minor performance
+	  sacrifices to harden the kernel slab allocator against common
+	  freelist exploit methods. Some slab implementations have more
+	  sanity-checking than others. This option is most effective with
+	  CONFIG_SLUB.
+
+config SHUFFLE_PAGE_ALLOCATOR
+	bool "Page allocator randomization"
+	default SLAB_FREELIST_RANDOM && ACPI_NUMA
+	help
+	  Randomization of the page allocator improves the average
+	  utilization of a direct-mapped memory-side-cache. See section
+	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
+	  6.2a specification for an example of how a platform advertises
+	  the presence of a memory-side-cache. There are also incidental
+	  security benefits as it reduces the predictability of page
+	  allocations to compliment SLAB_FREELIST_RANDOM, but the
+	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
+	  10th order of pages is selected based on cache utilization
+	  benefits on x86.
+
+	  While the randomization improves cache utilization it may
+	  negatively impact workloads on platforms without a cache. For
+	  this reason, by default, the randomization is enabled only
+	  after runtime detection of a direct-mapped memory-side-cache.
+	  Otherwise, the randomization may be force enabled with the
+	  'page_alloc.shuffle' kernel command line parameter.
+
+	  Say Y if unsure.
+
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
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
-- 
2.32.0

