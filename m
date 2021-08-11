Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEE3E8767
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhHKAoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236071AbhHKAnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 989E960EB7;
        Wed, 11 Aug 2021 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642603;
        bh=7WJKlO9bHU1KTACHVSZNKYdiOMEX5YhZuZxQV/SdLuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRnf5A4x4/jZiHyG9ZaRzXwbGnLGx/X7Meb25l6g61b2CB/dhxZTicTnsdeBUwEq8
         uPR3P/20cfHxaAzD6B2oM/PG1YvlEyleAelnhCPOKRpYyeZV9eD6HaQLNoqoMYJ5+i
         2rIEeTEM6HtnRIZPN+OyVa2JIZyVIuu5RMfoHoB93BHSDxUcrtSR/Cooe+bKYGge6S
         pIkAR2zJuxnAB8pdDLRsZ9gNp3OBD1xCxOF+VfdJYwLfEyiceL5vlqx2BCXqvIO0fg
         A8qiQb2OlNVgyyjuEAHcQu5PA47i5amo6imVqNQdIHNK+WD4wY38YMUbQnEoKKcI/T
         8ijDY055CsVjw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 17/18] ARC: mm: vmalloc sync from kernel to user table to update PMD ...
Date:   Tue, 10 Aug 2021 17:42:57 -0700
Message-Id: <20210811004258.138075-18-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... not PGD

vmalloc() sets up the kernel page table (starting from @swapper_pg_dir).
But when vmalloc area is accessed in context of a user task, say opening
terminal in n_tty_open(), the user page tables need to be synced from
kernel page tables so that TLB entry is created in "user context".

The old code was doing this incorrectly, as it was updating the user pgd
entry (first level itself) to point to kernel pud table (2nd level),
effectively yanking away the entire user space translation with kernel one.

The correct way to do this is to ONLY update a user space pgd/pud/pmd entry
if it is not popluated already. This ensures that only the missing leaf
pmd entry gets updated to point to relevant kernel pte table.

From code change pov, we are chaging the pattern:

	p4d = p4d_offset(pgd, address);
	p4d_k = p4d_offset(pgd_k, address);
	if (!p4d_present(*p4d_k))
		goto bad_area;
	set_p4d(p4d, *p4d_k);

with
	p4d = p4d_offset(pgd, address);
	p4d_k = p4d_offset(pgd_k, address);
	if (p4d_none(*p4d_k))
		goto bad_area;
	if (!p4d_present(*p4d))
		set_p4d(p4d, *p4d_k);

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/mm/fault.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index f8994164fa36..5787c261c9a4 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -36,31 +36,31 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	pgd = pgd_offset(current->active_mm, address);
 	pgd_k = pgd_offset_k(address);
 
-	if (!pgd_present(*pgd_k))
+	if (pgd_none (*pgd_k))
 		goto bad_area;
-
-	set_pgd(pgd, *pgd_k);
+	if (!pgd_present(*pgd))
+		set_pgd(pgd, *pgd_k);
 
 	p4d = p4d_offset(pgd, address);
 	p4d_k = p4d_offset(pgd_k, address);
-	if (!p4d_present(*p4d_k))
+	if (p4d_none(*p4d_k))
 		goto bad_area;
-
-	set_p4d(p4d, *p4d_k);
+	if (!p4d_present(*p4d))
+		set_p4d(p4d, *p4d_k);
 
 	pud = pud_offset(p4d, address);
 	pud_k = pud_offset(p4d_k, address);
-	if (!pud_present(*pud_k))
+	if (pud_none(*pud_k))
 		goto bad_area;
-
-	set_pud(pud, *pud_k);
+	if (!pud_present(*pud))
+		set_pud(pud, *pud_k);
 
 	pmd = pmd_offset(pud, address);
 	pmd_k = pmd_offset(pud_k, address);
-	if (!pmd_present(*pmd_k))
+	if (pmd_none(*pmd_k))
 		goto bad_area;
-
-	set_pmd(pmd, *pmd_k);
+	if (!pmd_present(*pmd))
+		set_pmd(pmd, *pmd_k);
 
 	/* XXX: create the TLB entry here */
 	return 0;
-- 
2.25.1

