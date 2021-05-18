Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381C93870F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbhEREtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:49:03 -0400
Received: from foss.arm.com ([217.140.110.172]:41000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241545AbhEREtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:49:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9E231B;
        Mon, 17 May 2021 21:47:44 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C52503F73D;
        Mon, 17 May 2021 21:47:42 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Update mm_struct's MM_ANONPAGES stat for huge zero pages
Date:   Tue, 18 May 2021 10:18:20 +0530
Message-Id: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the zero huge page is being shared across various processes, each
mapping needs to update its mm_struct's MM_ANONPAGES stat by HPAGE_PMD_NR
to be consistent. This just updates the stats in set_huge_zero_page() after
the mapping gets created and in zap_huge_pmd() when mapping gets destroyed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc2.

Changes in V1:

- Updated MM_ANONPAGES stat in zap_huge_pmd()
- Updated the commit message

Changes in RFC:

https://lore.kernel.org/linux-mm/1620890438-9127-1-git-send-email-anshuman.khandual@arm.com/

 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..306d0a41bf75 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 	if (pgtable)
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
+	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
 	mm_inc_nr_ptes(mm);
 }
 
@@ -1678,6 +1679,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
+		add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else {
-- 
2.20.1

