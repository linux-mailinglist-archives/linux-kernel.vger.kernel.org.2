Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE732BB6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhCCMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356175AbhCCHQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:16:56 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E7C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 23:16:14 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a1so7377454qkn.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 23:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ClvpDldXpDZ9EYbyGO2+VfM3Q4fJkR3CmabRdEQwcbc=;
        b=S93ke0X5VyNloubqrT/61/KsoxXCF1VtWzLmU249W/3N3Xfpbajh/vp0GZP5+H1uh8
         lXJEkKkhznxcpPULnJ5IZRFgMVOM5usqOYdlcTe6QDJ1ZWvmqeMGCFqCq42pWgKsdtp4
         lP8WqzJ8MlDHg16Gl6tfAkgAyjp4GybEaXm5Kp8mKdNuRa33Vz7zBpD844u/lA5a3jr5
         Kus0vSH7Tfrap3j3JHgr0tO/D+N2e/B3Us4QW6mnAiCJmQY3ldKPW8kocslG2JZm7vAI
         De1ZQ8tElRTGsjXl9Dmpgoczx1HB6xdlUQWltiMX4dn7jKQ2kwrznPZmzSNnt3QaQ9Fz
         EBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ClvpDldXpDZ9EYbyGO2+VfM3Q4fJkR3CmabRdEQwcbc=;
        b=U4QCHbK1mXz8nd3VdK4qSbmG2RGhMtdtwHHkkIF8sg278meFb6YeQ39nj0lFNMxHA5
         JICSuIye8glUuzq67lImIV9EEu8pkqd+HIekVlBXwtuePZ/RZGsuqKbmBERHItKidX61
         4Q69v07dtewhbv9VSNb4oBSQhrK8rIbOceKYL7nmqkIrtzWQ/Uw3umEw9sOJpM+vB+bw
         C5AzX+6clZdrL2IeB7akm2TqFDemN8pZOpiSij9tEi6qKedPrXbUDLl3txPFNuA0TjGe
         oGETlvxL+GWfmB4bR99GGJLdvf506m2xEB5fvgx6xoasIZAj1Rb27JJ8aVxxeqt/dTth
         XaPQ==
X-Gm-Message-State: AOAM530pBSKDLlKtczxeMTVD/GeOrTtKJTbxc5QYtAw2iJ5wGorltg+v
        /yiEADp7TCO6HDjDKK5BN9bZ92C+Xjo=
X-Google-Smtp-Source: ABdhPJxqR9zlDA75+iO4JbN0AuZYmFengDs5FuNzGPkCd1EziC9gx2VPqfm8ZmI7naElTni3RyuaV808qYo=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:4877:a627:46e9:4b6])
 (user=yuzhao job=sendgmr) by 2002:a0c:bf12:: with SMTP id m18mr1454169qvi.40.1614755774177;
 Tue, 02 Mar 2021 23:16:14 -0800 (PST)
Date:   Wed,  3 Mar 2021 00:16:09 -0700
In-Reply-To: <20210303071609.797782-1-yuzhao@google.com>
Message-Id: <20210303071609.797782-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20210303071609.797782-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 2/2] mm: clean up include/linux/page-flags-layout.h
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy things up and delete comments stating the obvious with typos or
making no sense.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags-layout.h | 62 +++++++++++++++----------------
 mm/mm_init.c                      |  4 --
 2 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 295c2c687d2c..ef1e3e736e14 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -21,16 +21,17 @@
 #elif MAX_NR_ZONES <= 8
 #define ZONES_SHIFT 3
 #else
-#error ZONES_SHIFT -- too many zones configured adjust calculation
+#error ZONES_SHIFT "Too many zones configured"
 #endif
 
+#define ZONES_WIDTH		ZONES_SHIFT
+
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
-
-/* SECTION_SHIFT	#bits space required to store a section # */
 #define SECTIONS_SHIFT	(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
-
-#endif /* CONFIG_SPARSEMEM */
+#else
+#define SECTIONS_SHIFT	0
+#endif
 
 #ifndef BUILD_VDSO32_64
 /*
@@ -54,17 +55,28 @@
 #define SECTIONS_WIDTH		0
 #endif
 
-#define ZONES_WIDTH		ZONES_SHIFT
-
-#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
+#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
 #define NODES_WIDTH		NODES_SHIFT
-#else
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
 #error "Vmemmap: No space for nodes field in page flags"
-#endif
+#else
 #define NODES_WIDTH		0
 #endif
 
+/*
+ * Note that this #define MUST have a value so that it can be tested with
+ * the IS_ENABLED() macro.
+ */
+#if NODES_SHIFT != 0 && NODES_WIDTH == 0
+#define NODE_NOT_IN_PAGE_FLAGS	1
+#endif
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+#define KASAN_TAG_WIDTH 8
+#else
+#define KASAN_TAG_WIDTH 0
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 #define LAST__PID_SHIFT 8
 #define LAST__PID_MASK  ((1 << LAST__PID_SHIFT)-1)
@@ -77,37 +89,21 @@
 #define LAST_CPUPID_SHIFT 0
 #endif
 
-#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
-#define KASAN_TAG_WIDTH 8
-#else
-#define KASAN_TAG_WIDTH 0
-#endif
-
-#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_WIDTH+LAST_CPUPID_SHIFT+KASAN_TAG_WIDTH \
+#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT \
 	<= BITS_PER_LONG - NR_PAGEFLAGS
 #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
 #else
 #define LAST_CPUPID_WIDTH 0
 #endif
 
-#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH+LAST_CPUPID_WIDTH+KASAN_TAG_WIDTH \
+#if LAST_CPUPID_SHIFT != 0 && LAST_CPUPID_WIDTH == 0
+#define LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#endif
+
+#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + KASAN_TAG_WIDTH + LAST_CPUPID_WIDTH \
 	> BITS_PER_LONG - NR_PAGEFLAGS
 #error "Not enough bits in page flags"
 #endif
 
-/*
- * We are going to use the flags for the page to node mapping if its in
- * there.  This includes the case where there is no node, so it is implicit.
- * Note that this #define MUST have a value so that it can be tested with
- * the IS_ENABLED() macro.
- */
-#if !(NODES_WIDTH > 0 || NODES_SHIFT == 0)
-#define NODE_NOT_IN_PAGE_FLAGS 1
-#endif
-
-#if defined(CONFIG_NUMA_BALANCING) && LAST_CPUPID_WIDTH == 0
-#define LAST_CPUPID_NOT_IN_PAGE_FLAGS
-#endif
-
 #endif
 #endif /* _LINUX_PAGE_FLAGS_LAYOUT */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 8e02e865cc65..9ddaf0e1b0ab 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -19,10 +19,6 @@
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
 
-#ifndef SECTIONS_SHIFT
-#define SECTIONS_SHIFT	0
-#endif
-
 /* The zonelists are simply reported, validation is manual. */
 void __init mminit_verify_zonelist(void)
 {
-- 
2.30.1.766.gb4fecdf3b7-goog

