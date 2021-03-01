Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5593B32773C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhCAFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:51:23 -0500
Received: from foss.arm.com ([217.140.110.172]:51592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhCAFvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:51:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780D21FB;
        Sun, 28 Feb 2021 21:50:34 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDFEC3F70D;
        Sun, 28 Feb 2021 21:50:30 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
Date:   Mon,  1 Mar 2021 11:20:53 +0530
Message-Id: <1614577853-7452-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
platform subscribing it. Instead just make it generic.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This change was originally suggested in an earilier discussion. This
applies on v5.12-rc1 and has been build tested on all applicable
platforms i.e ia64 and powerpc.

https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/

 arch/ia64/Kconfig    | 6 +-----
 arch/powerpc/Kconfig | 6 +-----
 mm/Kconfig           | 8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 2ad7a8d29fcc..6b3e3f6c29ae 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -32,6 +32,7 @@ config IA64
 	select TTY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HUGETLB_PAGE_SIZE_VARIABLE
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
@@ -82,11 +83,6 @@ config STACKTRACE_SUPPORT
 config GENERIC_LOCKBREAK
 	def_bool n
 
-config HUGETLB_PAGE_SIZE_VARIABLE
-	bool
-	depends on HUGETLB_PAGE
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3778ad17f56a..b8565bed284f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
@@ -416,11 +417,6 @@ config HIGHMEM
 
 source "kernel/Kconfig.hz"
 
-config HUGETLB_PAGE_SIZE_VARIABLE
-	bool
-	depends on HUGETLB_PAGE && PPC_BOOK3S_64
-	default y
-
 config MATH_EMULATION
 	bool "Math emulation"
 	depends on 4xx || PPC_8xx || PPC_MPC832x || BOOKE
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..e604a87862a4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -274,6 +274,14 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 config ARCH_ENABLE_THP_MIGRATION
 	bool
 
+config HUGETLB_PAGE_SIZE_VARIABLE
+	def_bool n
+	depends on HUGETLB_PAGE
+	help
+	  When there are multiple HugeTLB sizes available on a platform
+	  and pageblock_order could then be a dynamic value instead of
+	  standard HUGETLB_PAGE_ORDER.
+
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
-- 
2.20.1

