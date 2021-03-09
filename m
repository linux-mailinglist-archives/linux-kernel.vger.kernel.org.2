Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156D3332780
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCINrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCINrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:47:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F823C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:47:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so1942526wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI0Yvtfii0Ip0yhdSjib+BHAmdEKMzAYA0N/7UY5LAY=;
        b=EjQJgft/z6GZkiLcgTJd9yZ/iI7WPuyB8GIM/ATRUQCt6pKcuRVYBaeGV6KZN8NZ1t
         SxAjiLSL5oobw6QeM5cgTU8+RD0pjHtRWz1fy15Td3eEdjVCdMKOoZio7UhH8DiWHq/H
         aiJJj99u4bpGAF7P/5eqg5l7rYvs3kc1xig78J2dCt2jAOgBQfrxIeQLsWgeX+Yn+anR
         oRA71MNMGPnAMKEDNAZbjuRInM/KMA2wHrXIYQyCN4HwpOQ8QehWodb15gKQ2NqBCNq1
         kCsUGkEY8sIwUtjMA6HyNtyQ8/jxLvnCfFrAh7OAljZ+K0FeB/C/uWZkJvFDh+cfG7e5
         TxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI0Yvtfii0Ip0yhdSjib+BHAmdEKMzAYA0N/7UY5LAY=;
        b=PZ7UHL3RL2bFowb6Xg3vXcKgc2Eyla4+N7NjqVIMg/fSpI6EyyAVzz1+j2gysbEC1l
         iV87TCyp9isoLwFAKL6O60aQIN2eO3X+iyvojwmtrkWjiIYrBDtZ85tx51v+DnCJyBtA
         iRsRF0ExwtoW1a9hwDKi5dpTY5/0cXI5scnIBDqshBWKtPOZM/WHBQ+qxWzjtCNJutH1
         acC5AwHIhEJxLWD1hIEi3oHMCgSdCw/XapnvuKh2bOm8DMN1dCdi11wF+axFPje+Y1/U
         cruOWdd8oEe6zY+aLu2KWapEJL9ESc+1Pd72B66BXNizDXPk/gBBoUPqXFAOeCuww+3j
         gLJQ==
X-Gm-Message-State: AOAM5304T782C77U6LghUyTbfTOd3cbPc0G0/aHiW4U7CmegASJOWeoW
        sk203VOuwx+rGX+/768HMI1O1w==
X-Google-Smtp-Source: ABdhPJwsxP0bHWl1ztzAtui9QPyYm+HVJBogXDY14rypog+PXdGDtV/cjVxLtNJoNLGp3JpqSx1HTA==
X-Received: by 2002:a1c:1bc7:: with SMTP id b190mr4150675wmb.115.1615297642111;
        Tue, 09 Mar 2021 05:47:22 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i8sm24327575wrx.43.2021.03.09.05.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:47:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] mm/slub: Add slub_debug option to panic on memory corruption
Date:   Tue,  9 Mar 2021 15:47:20 +0200
Message-Id: <20210309134720.29052-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being able to stop the system immediately when a memory corruption
is detected is crucial to finding the source of it. This is very
useful when the memory can be inspected with kdump or other tools.

Let's add an option panic the kernel when slab debug catches an
object or list corruption.

This new option is not enabled by default (yet), so it needs to be
enabled explicitly (for example by adding "slub_debug=FZPUC" to
the kernel command line).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/vm/slub.rst | 1 +
 include/linux/slab.h      | 3 +++
 mm/slab.h                 | 2 +-
 mm/slub.c                 | 9 +++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 03f294a638bd..32878c44f3de 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -53,6 +53,7 @@ Possible debug options are::
 	Z		Red zoning
 	P		Poisoning (object and padding)
 	U		User tracking (free and alloc)
+	C		Panic on object corruption (enables SLAB_CORRUPTION_PANIC)
 	T		Trace (please only use on single slabs)
 	A		Enable failslab filter mark for the cache
 	O		Switch debugging off for caches that would have
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..ebff5e704d08 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -39,6 +39,9 @@
 #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
 /* Panic if kmem_cache_create() fails */
 #define SLAB_PANIC		((slab_flags_t __force)0x00040000U)
+/* Panic if memory corruption is detected */
+#define SLAB_CORRUPTION_PANIC	((slab_flags_t __force)0x00080000U)
+
 /*
  * SLAB_TYPESAFE_BY_RCU - **WARNING** READ THIS!
  *
diff --git a/mm/slab.h b/mm/slab.h
index 120b1d0dfb6d..ae0079017fc6 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -134,7 +134,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
 #elif defined(CONFIG_SLUB_DEBUG)
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
-			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
+			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS | SLAB_CORRUPTION_PANIC)
 #else
 #define SLAB_DEBUG_FLAGS (0)
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 077a019e4d7a..49351427f701 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -741,6 +741,8 @@ void object_err(struct kmem_cache *s, struct page *page,
 {
 	slab_bug(s, "%s", reason);
 	print_trailer(s, page, object);
+	if (slub_debug & SLAB_CORRUPTION_PANIC)
+		panic(reason);
 }
 
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
@@ -755,6 +757,8 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 	slab_bug(s, "%s", buf);
 	print_page_info(page);
 	dump_stack();
+	if (slub_debug & SLAB_CORRUPTION_PANIC)
+		panic("slab: slab error\n");
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -776,6 +780,8 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
+	if (slub_debug & SLAB_CORRUPTION_PANIC)
+		panic("slab: object overwritten\n");
 	slab_fix(s, "Restoring 0x%p-0x%p=0x%x\n", from, to - 1, data);
 	memset(from, data, to - from);
 }
@@ -1319,6 +1325,9 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 		case 'a':
 			*flags |= SLAB_FAILSLAB;
 			break;
+		case 'c':
+			*flags |= SLAB_CORRUPTION_PANIC;
+			break;
 		case 'o':
 			/*
 			 * Avoid enabling debugging on caches if its minimum
