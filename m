Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8438E475
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhEXKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhEXKq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:46:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599361396;
        Mon, 24 May 2021 03:45:28 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4933F719;
        Mon, 24 May 2021 03:45:25 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 2/8] arm64: Handle MTE tags zeroing in __alloc_zeroed_user_highpage()
Date:   Mon, 24 May 2021 11:45:07 +0100
Message-Id: <20210524104513.13258-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524104513.13258-1-steven.price@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Currently, on an anonymous page fault, the kernel allocates a zeroed
page and maps it in user space. If the mapping is tagged (PROT_MTE),
set_pte_at() additionally clears the tags under a spinlock to avoid a
race on the page->flags. In order to optimise the lock, clear the page
tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
have VM_MTE set.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/page.h |  6 ++++--
 arch/arm64/mm/fault.c         | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..97853570d0f1 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/personality.h> /* for READ_IMPLIES_EXEC */
+#include <linux/types.h>
 #include <asm/pgtable-types.h>
 
 struct page;
@@ -28,8 +29,9 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
-#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
-	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
+struct page *__alloc_zeroed_user_highpage(gfp_t movableflags,
+					  struct vm_area_struct *vma,
+					  unsigned long vaddr);
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 871c82ab0a30..5a03428e97f3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -921,3 +921,24 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 	debug_exception_exit(regs);
 }
 NOKPROBE_SYMBOL(do_debug_exception);
+
+/*
+ * Used during anonymous page fault handling.
+ */
+struct page *__alloc_zeroed_user_highpage(gfp_t movableflags,
+					  struct vm_area_struct *vma,
+					  unsigned long vaddr)
+{
+	struct page *page;
+	bool tagged = system_supports_mte() && (vma->vm_flags & VM_MTE);
+
+	page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma,
+			      vaddr);
+	if (tagged && page) {
+		mte_clear_page_tags(page_address(page));
+		page_kasan_tag_reset(page);
+		set_bit(PG_mte_tagged, &page->flags);
+	}
+
+	return page;
+}
-- 
2.20.1

