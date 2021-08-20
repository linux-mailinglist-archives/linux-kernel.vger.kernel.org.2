Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763733F26E0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhHTGfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:35:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238406AbhHTGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:35:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D681042;
        Thu, 19 Aug 2021 23:34:42 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.69.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40FCC3F40C;
        Thu, 19 Aug 2021 23:34:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop page-def.h
Date:   Fri, 20 Aug 2021 12:05:31 +0530
Message-Id: <1629441331-19530-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
should be moved into pgtable-hwdef.h instead, and subsequently page-def.h
can be just dropped off completely.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.14-rc6. Could move these definitions into <asm/page.h>
if that is preferred. But <asm/page-def.h> is neither really required as
a separate header nor is present on other platforms.

 arch/arm64/include/asm/memory.h        |  2 +-
 arch/arm64/include/asm/page-def.h      | 18 ------------------
 arch/arm64/include/asm/page.h          |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++++
 4 files changed, 6 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm64/include/asm/page-def.h

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 824a3655dd93..f987204c716a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -12,7 +12,7 @@
 
 #include <linux/const.h>
 #include <linux/sizes.h>
-#include <asm/page-def.h>
+#include <asm/pgtable-hwdef.h>
 
 /*
  * Size of the PCI I/O space. This must remain a power of two so that
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
deleted file mode 100644
index 2403f7b4cdbf..000000000000
--- a/arch/arm64/include/asm/page-def.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Based on arch/arm/include/asm/page.h
- *
- * Copyright (C) 1995-2003 Russell King
- * Copyright (C) 2017 ARM Ltd.
- */
-#ifndef __ASM_PAGE_DEF_H
-#define __ASM_PAGE_DEF_H
-
-#include <linux/const.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-
-#endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..40313964d4b2 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
-#include <asm/page-def.h>
+#include <asm/pgtable-hwdef.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 40085e53f573..be8045080ebd 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -5,6 +5,10 @@
 #ifndef __ASM_PGTABLE_HWDEF_H
 #define __ASM_PGTABLE_HWDEF_H
 
+#define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
+#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
 #include <asm/memory.h>
 
 /*
-- 
2.20.1

