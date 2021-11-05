Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE51446056
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhKEH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232453AbhKEH5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:57:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A79E06126A;
        Fri,  5 Nov 2021 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636098864;
        bh=Ip8ksL1d39Oojfv6OIR65aUdoJJPXviXFWi/+0sgmO0=;
        h=From:To:Cc:Subject:Date:From;
        b=qqfNatdCzgN9+ujyhD4OnQ1jeTCzY91cBdSjAuipYPd1cOkoVLgH2Z7jQs9xPguTv
         a0AWuafKJewVp7a1MRFIKh36uY5iNLwSYYVXKP2C1kZwo4ytGuyYIpptqvpZI99zq4
         aGZijWrVPaLbInGHtIxmMBZUnvNiha8n3rlpsjnh5HKqa0bswDJAC9G5BqOt9VaKCA
         PNfEjcZepc5DqPKe9oee2wNkOyO6qLbOK+/EpV2GuPsYiFjSXWVYphYRQ545f2lcvU
         ThsRKK/aQ1K9YA9WTzNOcJ39xx5HKJ7FdF+iIGiDM0oZuvvhR7oCur9HNY2ArjI68v
         DOckJfrHyorww==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Bob Picco <bob.picco@oracle.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: pgtable: make __pte_to_phys/__phys_to_pte_val inline functions
Date:   Fri,  5 Nov 2021 08:54:03 +0100
Message-Id: <20211105075414.2553155-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about undefined behavior the vmalloc code when building
with CONFIG_ARM64_PA_BITS_52, when the 'idx++' in the argument to
__phys_to_pte_val() is evaluated twice:

mm/vmalloc.c: In function 'vmap_pfn_apply':
mm/vmalloc.c:2800:58: error: operation on 'data->idx' may be undefined [-Werror=sequence-point]
 2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
      |                                                 ~~~~~~~~~^~
arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
   25 | #define __pte(x)        ((pte_t) { (x) } )
      |                                     ^
arch/arm64/include/asm/pgtable.h:80:15: note: in expansion of macro '__phys_to_pte_val'
   80 |         __pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
      |               ^~~~~~~~~~~~~~~~~
mm/vmalloc.c:2800:30: note: in expansion of macro 'pfn_pte'
 2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
      |                              ^~~~~~~

I have no idea why this never showed up earlier, but the safest
workaround appears to be changing those macros into inline functions
so the arguments get evaluated only once.

Cc: Matthew Wilcox <willy@infradead.org>
Fixes: 75387b92635e ("arm64: handle 52-bit physical addresses in page table entries")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/pgtable.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 84fbb52b4224..c4ba047a82d2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -67,9 +67,15 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
  * page table entry, taking care of 52-bit addresses.
  */
 #ifdef CONFIG_ARM64_PA_BITS_52
-#define __pte_to_phys(pte)	\
-	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
-#define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
+static inline phys_addr_t __pte_to_phys(pte_t pte)
+{
+	return (pte_val(pte) & PTE_ADDR_LOW) |
+		((pte_val(pte) & PTE_ADDR_HIGH) << 36);
+}
+static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
+{
+	return (phys | (phys >> 36)) & PTE_ADDR_MASK;
+}
 #else
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
 #define __phys_to_pte_val(phys)	(phys)
-- 
2.29.2

