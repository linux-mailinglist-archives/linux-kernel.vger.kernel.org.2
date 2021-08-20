Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3C3F2A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhHTLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:05:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233437AbhHTLFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BA31101E;
        Fri, 20 Aug 2021 04:04:29 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.69.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C517E3F70D;
        Fri, 20 Aug 2021 04:04:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Drop <asm/page-def.h>
Date:   Fri, 20 Aug 2021 16:35:16 +0530
Message-Id: <1629457516-32306-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
should be moved into <asm/page.h> instead like in case for other platforms,
and then subsequently <asm/page-def.h> can be just dropped off completely.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.14-rc6.

Changes in V2:

- Moved PAGE_XXX macros into <asm/page.h> instead of <asm/pgtable-hwdef.h>
- Changed the commit message accordingly

Changes in V1:

https://lore.kernel.org/lkml/1629441331-19530-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/include/asm/memory.h   |  2 +-
 arch/arm64/include/asm/page-def.h | 18 ------------------
 arch/arm64/include/asm/page.h     |  4 +++-
 3 files changed, 4 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm64/include/asm/page-def.h

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 824a3655dd93..649d26396f9e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -12,7 +12,7 @@
 
 #include <linux/const.h>
 #include <linux/sizes.h>
-#include <asm/page-def.h>
+#include <asm/page.h>
 
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
index 993a27ea6f54..95c58b00bb71 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -8,7 +8,9 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
-#include <asm/page-def.h>
+#define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
+#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE-1))
 
 #ifndef __ASSEMBLY__
 
-- 
2.20.1

