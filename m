Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AE37F2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 07:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhEMFwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:52:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhEMFwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:52:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19EF7101E;
        Wed, 12 May 2021 22:51:23 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4C073F73B;
        Wed, 12 May 2021 22:51:20 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/mm: Drop [PTE|PMD]_TYPE_FAULT
Date:   Thu, 13 May 2021 11:21:53 +0530
Message-Id: <1620885113-5938-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop these unused symbols i.e PTE_TYPE_FAULT and PMD_TYPE_FAULT.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on latest mainline. Just found this by code inspection and
built tested for arm platform. Posted this earlier as well but some
how got missed.

https://patchwork.kernel.org/project/linux-arm-kernel/patch/1592277724-2721-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm/include/asm/pgtable-2level-hwdef.h | 2 --
 arch/arm/include/asm/pgtable-3level-hwdef.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index 556937e1790e..b10d6e1aee33 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -14,7 +14,6 @@
  *   - common
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
-#define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 1) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 2) << 0)
 #define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 */
@@ -56,7 +55,6 @@
  *   - common
  */
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
-#define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_LARGE		(_AT(pteval_t, 1) << 0)
 #define PTE_TYPE_SMALL		(_AT(pteval_t, 2) << 0)
 #define PTE_TYPE_EXT		(_AT(pteval_t, 3) << 0)		/* v5 */
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 2f35b4eddaa8..43aa8f61eac1 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -15,7 +15,6 @@
  *   - common
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
-#define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
 #define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
@@ -56,7 +55,6 @@
  * + Level 3 descriptor (PTE)
  */
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
-#define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
 #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
-- 
2.20.1

