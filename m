Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFE3C232F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGIL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGIL4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:56:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22893C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wtx3QtcbLpkELuuqeE1PDsjiFgDSHURAU19z4+EjxV0=; b=dhFgfMMMPjM/DeOiXnXy4PtSRE
        Vc4LpX6ODcx9PtzNQO/C7QMk692qHtBJ9QkE/9REQjhZHd9sDv82FJI+vg+pKnx6HkV5CC5iUnTA6
        0qX8BdwSdpUFfVUPM45BEJeiD+JY0pNgOpsilejAs+OKntKg3/LgzFZ5eIBYMiJ3N5nTL+/f0MCCS
        efV6b8FQor6ayz2Zi2KmWbD92fsCNF/U1yySHEikMrkg1WF1flNOA8N/2T3YVVIM+PNRIeK5jS3JT
        hjwXXwUqF+VoNAlEEHo+kftDkbxAbS51/jHwPV/jqzxY7pjXPHsxJd2ttJmMZ3XpQk0jRRKfoNspj
        eNtQpLyA==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1p4S-00ETB1-Kt; Fri, 09 Jul 2021 11:53:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] h8300: don't implement set_fs
Date:   Fri,  9 Jul 2021 13:53:11 +0200
Message-Id: <20210709115311.3424912-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709115311.3424912-1-hch@lst.de>
References: <20210709115311.3424912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for set_fs on this nommu-only architecture, so just
remove all the boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/h8300/Kconfig                   |  1 -
 arch/h8300/include/asm/processor.h   |  1 -
 arch/h8300/include/asm/segment.h     | 40 ----------------------------
 arch/h8300/include/asm/thread_info.h |  3 ---
 arch/h8300/kernel/entry.S            |  1 -
 arch/h8300/kernel/head_ram.S         |  1 -
 arch/h8300/mm/init.c                 |  6 -----
 7 files changed, 53 deletions(-)
 delete mode 100644 arch/h8300/include/asm/segment.h

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3e3e0f16f7e0..fe48c4f26cc8 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -24,7 +24,6 @@ config H8300
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
-	select SET_FS
 	select UACCESS_MEMCPY
 
 config CPU_BIG_ENDIAN
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index a060b41b2d31..66d7d5271f10 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -13,7 +13,6 @@
 #define __ASM_H8300_PROCESSOR_H
 
 #include <linux/compiler.h>
-#include <asm/segment.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
 
diff --git a/arch/h8300/include/asm/segment.h b/arch/h8300/include/asm/segment.h
deleted file mode 100644
index 37950725d9b9..000000000000
--- a/arch/h8300/include/asm/segment.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _H8300_SEGMENT_H
-#define _H8300_SEGMENT_H
-
-/* define constants */
-#define USER_DATA     (1)
-#ifndef __USER_DS
-#define __USER_DS     (USER_DATA)
-#endif
-#define USER_PROGRAM  (2)
-#define SUPER_DATA    (3)
-#ifndef __KERNEL_DS
-#define __KERNEL_DS   (SUPER_DATA)
-#endif
-#define SUPER_PROGRAM (4)
-
-#ifndef __ASSEMBLY__
-
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-#define USER_DS		MAKE_MM_SEG(__USER_DS)
-#define KERNEL_DS	MAKE_MM_SEG(__KERNEL_DS)
-
-/*
- * Get/set the SFC/DFC registers for MOVES instructions
- */
-
-static inline mm_segment_t get_fs(void)
-{
-	return USER_DS;
-}
-
-#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* _H8300_SEGMENT_H */
diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
index a518214d4ddd..ff2d873749a4 100644
--- a/arch/h8300/include/asm/thread_info.h
+++ b/arch/h8300/include/asm/thread_info.h
@@ -10,7 +10,6 @@
 #define _ASM_THREAD_INFO_H
 
 #include <asm/page.h>
-#include <asm/segment.h>
 
 #ifdef __KERNEL__
 
@@ -31,7 +30,6 @@ struct thread_info {
 	unsigned long	   flags;		/* low level flags */
 	int		   cpu;			/* cpu we're on */
 	int		   preempt_count;	/* 0 => preemptable, <0 => BUG */
-	mm_segment_t		addr_limit;
 };
 
 /*
@@ -43,7 +41,6 @@ struct thread_info {
 	.flags =	0,			\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index c6e289b5f1f2..42db87c17917 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -17,7 +17,6 @@
 #include <linux/sys.h>
 #include <asm/unistd.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/arch/h8300/kernel/head_ram.S b/arch/h8300/kernel/head_ram.S
index dbf8429f5fab..489462f0ee57 100644
--- a/arch/h8300/kernel/head_ram.S
+++ b/arch/h8300/kernel/head_ram.S
@@ -4,7 +4,6 @@
 #include <linux/init.h>
 #include <asm/unistd.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index f7bf4693e3b2..9fa13312720a 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -34,7 +34,6 @@
 #include <linux/gfp.h>
 
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
@@ -71,11 +70,6 @@ void __init paging_init(void)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
-	/*
-	 * Set up SFC/DFC registers (user data space).
-	 */
-	set_fs(USER_DS);
-
 	pr_debug("before free_area_init\n");
 
 	pr_debug("free_area_init -> start_mem is %#lx\nvirtual_end is %#lx\n",
-- 
2.30.2

