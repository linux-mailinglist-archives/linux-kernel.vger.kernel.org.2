Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5D3F211C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhHSTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhHSTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:54:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y144so8467336qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Te7Vtbwf1FWH0SUwrKII1C36E9Z2yXd6HJrJnQpoc3k=;
        b=FP0ANrLl3UD45GmhfienmSCRtF1dYHDlsGkhvNovLGbUXVXLv34pEYocAPQWTm65TM
         ZeO0tgubrtGYvnYOgpRZSxJzsdGLl0wmE7bX28IGFK6gHCq7/43IwsXAfuvAY81RqLlX
         c6Zx98qId4RchnRxj0eo9l09M6qnk6vpUfnbcjxgSpauzo/xxqw0xffzmh0PKPswvgal
         cQJzy9HCPoNlRNjJpGJBL1khs8rgEdMNaI5/PYf4x93D0xoPj1lyu5odPT8tbueCRHiL
         SqoqsnTa/+yjV4Io40TGguPNrM0vx0ILBq+kC8lfX/CPK97jKxnAPzs7It1228Lxw+ds
         6nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Te7Vtbwf1FWH0SUwrKII1C36E9Z2yXd6HJrJnQpoc3k=;
        b=Z6a4QoDh9de90S+bQEjRqMua+ys+RFrW5zM6mRkFjHtng0eDPunQYyA2fZOLI879pZ
         xKIv5sfq7ePOlz+IzCTtYPBeWgQCB/+H+FDbn5KrR/2UfvKXKz9v/iL3HI0OzAgQSPsX
         TMdvmFl1vYib5CPyscUEQIz/wpOytvuVN+jKuz70tLpTBT3jM0AhIx4aHSsDBSRM1snA
         1WgSHJKgd8fYj7Gj9z03aUspKvdGXzVrnxY49Q5S9FHqRprsn/eKhqTRSc/LTz98mY4s
         3DMl+rVVyLSosCHJcquns4RjzUQXVnSjz9aTD3A9SgEVQnOw+buNit3Y4GivFDs/kmn0
         +5Jg==
X-Gm-Message-State: AOAM530XCNCD/ardpFqKebd4+FrWtkhwE7/ODiremFmzMqNOWxVT2At0
        T79PA8GrdbkVS5clMszldiqY+g==
X-Google-Smtp-Source: ABdhPJxu3u/NfH1mWdipGRolH4jKp7zgO23gRqOeKD0UyirhOewQ0ol8nkW0R5p1CKnRHg+8dbLtxQ==
X-Received: by 2002:a37:c94:: with SMTP id 142mr5381982qkm.78.1629402837838;
        Thu, 19 Aug 2021 12:53:57 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id x8sm1649604qts.69.2021.08.19.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:53:57 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/4] mm: Kconfig: simplify zswap configuration
Date:   Thu, 19 Aug 2021 15:55:32 -0400
Message-Id: <20210819195533.211756-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819195533.211756-1-hannes@cmpxchg.org>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up option ordering; make prompts and help text more concise and
actionable for non-developers; turn depends into selects where
possible, so that users can simply select the functionality they want
without having to chase down obscure code dependencies.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 drivers/block/zram/Kconfig |  3 ++-
 mm/Kconfig                 | 53 ++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 668c6bf2554d..e4163d4b936b 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
+	depends on BLOCK && SYSFS
 	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
+	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
diff --git a/mm/Kconfig b/mm/Kconfig
index dbceaa2a04a4..62c6e6092a0a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -21,9 +21,13 @@ menuconfig SWAP
 
 if SWAP
 
+config ZPOOL
+	bool
+
 config ZSWAP
 	bool "Compressed cache for swap pages (EXPERIMENTAL)"
-	depends on FRONTSWAP && CRYPTO=y
+	select FRONTSWAP
+	select CRYPTO
 	select ZPOOL
 	help
 	  A lightweight compressed cache for swap pages.  It takes
@@ -39,8 +43,18 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
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
 choice
-	prompt "Compressed cache for swap pages default compressor"
+	prompt "Default compressor"
 	depends on ZSWAP
 	default ZSWAP_COMPRESSOR_DEFAULT_LZO
 	help
@@ -106,7 +120,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
        default ""
 
 choice
-	prompt "Compressed cache for swap pages default allocator"
+	prompt "Default allocator"
 	depends on ZSWAP
 	default ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
@@ -146,24 +160,9 @@ config ZSWAP_ZPOOL_DEFAULT
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
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
 config ZBUD
-	tristate "Low (Up to 2x) density storage for compressed pages"
+	tristate "2:1 compression allocator (zbud)"
+	depends on ZSWAP
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to two compressed pages per physical
@@ -172,8 +171,8 @@ config ZBUD
 	  density approach when reclaim will be used.
 
 config Z3FOLD
-	tristate "Up to 3x density storage for compressed pages"
-	depends on ZPOOL
+	tristate "3:1 compression allocator (z3fold)"
+	depends on ZSWAP
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
@@ -181,15 +180,13 @@ config Z3FOLD
 	  still there.
 
 config ZSMALLOC
-	tristate "Memory allocator for compressed pages"
+	tristate
+	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
 	depends on MMU
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
-	  compressed RAM pages.  zsmalloc uses virtual memory mapping
-	  in order to reduce fragmentation.  However, this results in a
-	  non-standard allocator interface where a handle, not a pointer, is
-	  returned by an alloc().  This handle must be mapped in order to
-	  access the allocated space.
+	  pages of various compression levels efficiently. It achieves
+	  the highest storage density with the least amount of fragmentation.
 
 config ZSMALLOC_STAT
 	bool "Export zsmalloc statistics"
-- 
2.32.0

