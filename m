Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6391E3EADAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhHLXij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238056AbhHLXi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD134610A8;
        Thu, 12 Aug 2021 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811480;
        bh=GnoibyRqmuzmp9rlWYYiDkJSczSXQYZSBk2r8Ru2kb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ5LZ4ULgVjyz2u3mRUlYamQ/7jmPMb7gl8kc5FY89Ndfg1EO7yHTvHxz7q8XDKaA
         bck5ngmrh8YhCbTADIdDXRaYTj8Nh2Vr8b24023FVZvRD4426mg78uWRO2Pfdom4A8
         oB5v4Cozx+FrwVZIErcM8A/GwPNE/+vMszDu1dnhDa5gHUgN4OULVKJ+qqYbLierIW
         LqShWqr+RbK1q4XPVDe25+wvzUFfBLMSlGwLA0cRMtq2fbEoRw9aELP3HDq+1ArdAU
         /c5X97hoSq4KcTPBqFFrVy2KLzBHy4uWQONQnKUzKwpxb5xxk1GxpEyLpjgTbAMdzx
         BgRFn/rB65VUw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 06/19] ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
Date:   Thu, 12 Aug 2021 16:37:40 -0700
Message-Id: <20210812233753.104217-7-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and remove the one off uncached definition for ARC

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/pgtable.h | 3 ---
 arch/arc/mm/ioremap.c          | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 80b57c14b430..b054c14f8bf6 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -103,9 +103,6 @@
  */
 #define PAGE_KERNEL          __pgprot(_K_PAGE_PERMS | _PAGE_CACHEABLE)
 
-/* ioremap */
-#define PAGE_KERNEL_NO_CACHE __pgprot(_K_PAGE_PERMS)
-
 /* Masks for actual TLB "PD"s */
 #define PTE_BITS_IN_PD0		(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_HW_SZ)
 #define PTE_BITS_RWX		(_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ)
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 052bbd8b1e5f..0ee75aca6e10 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -39,7 +39,8 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 	if (arc_uncached_addr_space(paddr))
 		return (void __iomem *)(u32)paddr;
 
-	return ioremap_prot(paddr, size, pgprot_val(PAGE_KERNEL_NO_CACHE));
+	return ioremap_prot(paddr, size,
+			    pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 }
 EXPORT_SYMBOL(ioremap);
 
-- 
2.25.1

