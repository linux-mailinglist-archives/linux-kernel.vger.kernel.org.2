Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447B3E8759
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhHKAnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235993AbhHKAnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 333A26101E;
        Wed, 11 Aug 2021 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642599;
        bh=GnoibyRqmuzmp9rlWYYiDkJSczSXQYZSBk2r8Ru2kb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltgpLAb09scNIqf7hB4w+9wq/kMJo6klNCdbwyjz06C+di55vyu2NbNrNBDqyQ9d3
         G+a+jg7VCy+On16gHsKi9E77og6pPYyylaxZP9GF5YmIZWvMiizD5r/xsqP0uOGyV8
         jpQ7sfofWOWGx0uDHlZYtIEKMPcdVORhrxrIMnv2ujP0u0akUBQB+OsZVW1qW1Id1/
         LqMgqGQ88ZG3Fc0qx+fFWFglMWcLiCkzllK6qHsU7zhbTV17MKkumU279yN0pra/vJ
         ZOvjlXq/r+X/C201M9G70O7Rn6yAyiI9DNAedv3Ikgg2EP/FWSuK8UnBVIJ0GbPqko
         8z8HOQz17OYFg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 07/18] ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
Date:   Tue, 10 Aug 2021 17:42:47 -0700
Message-Id: <20210811004258.138075-8-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
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

