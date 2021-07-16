Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDA3CB0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhGPC0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhGPC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:26:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88831C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Lnk9JSiNco+fvpMtgugwGUPHQQd7tGUSorOWrIOEXkY=; b=w8ioiaqfhhDici1jpNd+no0a4h
        rxWKw48oHbyYk9b5hyv3HQqL7ULbPV/+RhnWOK2n1W20iQKG0dB2q9KTh0KNNicbrQIU08aEZEhpH
        Hxo+NWvA243pVij1lSP5Hzb1qUk7uL5UtaTons2jCTP+mFrFk7bjFz9O67U04URtKVt7+ngUPH/+V
        qr/6BTDqn2qRI0gqG/MCrNLDKQ6x8acucTzNzsCo+Fjeh2dZ5V84a0YFpGSqAirCcmfXXE5LGL7cP
        KFHW7/n9n3CjgJAtQJueLq5TWtD3f6FQO7z9Y9fCtWwWJvR+WrMbisX8E0cHqTyUZqjkKGHUtVLgE
        5acAdboA==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4DVs-002uGU-P7; Fri, 16 Jul 2021 02:23:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: rename or32 code & comments to or1k
Date:   Thu, 15 Jul 2021 19:23:38 -0700
Message-Id: <20210716022338.19342-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Documentation/openrisc/todo.rst, rename "or32" in the
source code to "or1k" since this is the name that has been
settled on.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/include/asm/pgtable.h     |    6 +++---
 arch/openrisc/include/asm/thread_info.h |    2 +-
 arch/openrisc/kernel/entry.S            |    4 ++--
 arch/openrisc/kernel/head.S             |    6 +++---
 arch/openrisc/kernel/setup.c            |    4 ++--
 arch/openrisc/lib/Makefile              |    2 +-
 arch/openrisc/mm/fault.c                |    2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

--- linux-next-20210715.orig/arch/openrisc/include/asm/pgtable.h
+++ linux-next-20210715/arch/openrisc/include/asm/pgtable.h
@@ -12,7 +12,7 @@
  * et al.
  */
 
-/* or32 pgtable.h - macros and functions to manipulate page tables
+/* or1k pgtable.h - macros and functions to manipulate page tables
  *
  * Based on:
  * include/asm-cris/pgtable.h
@@ -29,14 +29,14 @@
 
 /*
  * The Linux memory management assumes a three-level page table setup. On
- * or32, we use that, but "fold" the mid level into the top-level page
+ * or1k, we use that, but "fold" the mid level into the top-level page
  * table. Since the MMU TLB is software loaded through an interrupt, it
  * supports any page table structure, so we could have used a three-level
  * setup, but for the amounts of memory we normally use, a two-level is
  * probably more efficient.
  *
  * This file contains the functions and defines necessary to modify and use
- * the or32 page table tree.
+ * the or1k page table tree.
  */
 
 extern void paging_init(void);
--- linux-next-20210715.orig/arch/openrisc/include/asm/thread_info.h
+++ linux-next-20210715/arch/openrisc/include/asm/thread_info.h
@@ -25,7 +25,7 @@
 
 /* THREAD_SIZE is the size of the task_struct/kernel_stack combo.
  * normally, the stack is found by doing something like p + THREAD_SIZE
- * in or32, a page is 8192 bytes, which seems like a sane size
+ * in or1k, a page is 8192 bytes, which seems like a sane size
  */
 
 #define THREAD_SIZE_ORDER 0
--- linux-next-20210715.orig/arch/openrisc/lib/Makefile
+++ linux-next-20210715/arch/openrisc/lib/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Makefile for or32 specific library files..
+# Makefile for or1k specific library files..
 #
 
 obj-y	:= delay.o string.o memset.o memcpy.o
--- linux-next-20210715.orig/arch/openrisc/mm/fault.c
+++ linux-next-20210715/arch/openrisc/mm/fault.c
@@ -28,7 +28,7 @@ unsigned long pte_misses;	/* updated by
 unsigned long pte_errors;	/* updated by do_page_fault() */
 
 /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
- *            - also look into include/asm-or32/mmu_context.h
+ *            - also look into include/asm/mmu_context.h
  */
 volatile pgd_t *current_pgd[NR_CPUS];
 
--- linux-next-20210715.orig/arch/openrisc/kernel/entry.S
+++ linux-next-20210715/arch/openrisc/kernel/entry.S
@@ -326,7 +326,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler
 1:	l.ori   r6,r0,0x0                  // !write access
 2:
 
-	/* call fault.c handler in or32/mm/fault.c */
+	/* call fault.c handler in openrisc/mm/fault.c */
 	l.jal   do_page_fault
 	 l.nop
 	l.j     _ret_from_exception
@@ -348,7 +348,7 @@ EXCEPTION_ENTRY(_insn_page_fault_handler
 	/* r4 set be EXCEPTION_HANDLE */   // effective address of fault
 	l.ori	r6,r0,0x0		   // !write access
 
-	/* call fault.c handler in or32/mm/fault.c */
+	/* call fault.c handler in openrisc/mm/fault.c */
 	l.jal   do_page_fault
 	 l.nop
 	l.j     _ret_from_exception
--- linux-next-20210715.orig/arch/openrisc/kernel/head.S
+++ linux-next-20210715/arch/openrisc/kernel/head.S
@@ -599,7 +599,7 @@ flush_tlb:
 	l.jal	_flush_tlb
 	 l.nop
 
-/* The MMU needs to be enabled before or32_early_setup is called */
+/* The MMU needs to be enabled before or1k_early_setup is called */
 
 enable_mmu:
 	/*
@@ -641,9 +641,9 @@ enable_mmu:
 	/* magic number mismatch, set fdt pointer to null */
 	l.or	r25,r0,r0
 _fdt_found:
-	/* pass fdt pointer to or32_early_setup in r3 */
+	/* pass fdt pointer to or1k_early_setup in r3 */
 	l.or	r3,r0,r25
-	LOAD_SYMBOL_2_GPR(r24, or32_early_setup)
+	LOAD_SYMBOL_2_GPR(r24, or1k_early_setup)
 	l.jalr r24
 	 l.nop
 
--- linux-next-20210715.orig/arch/openrisc/kernel/setup.c
+++ linux-next-20210715/arch/openrisc/kernel/setup.c
@@ -209,7 +209,7 @@ void __init setup_cpuinfo(void)
 }
 
 /**
- * or32_early_setup
+ * or1k_early_setup
  *
  * Handles the pointer to the device tree that this kernel is to use
  * for establishing the available platform devices.
@@ -217,7 +217,7 @@ void __init setup_cpuinfo(void)
  * Falls back on built-in device tree in case null pointer is passed.
  */
 
-void __init or32_early_setup(void *fdt)
+void __init or1k_early_setup(void *fdt)
 {
 	if (fdt)
 		pr_info("FDT at %p\n", fdt);
