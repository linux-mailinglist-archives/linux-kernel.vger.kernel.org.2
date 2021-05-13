Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7402B37F37C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhEMHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:58400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhEMHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1F53101E;
        Thu, 13 May 2021 00:19:58 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 905073F719;
        Thu, 13 May 2021 00:19:56 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in set_huge_zero_page()
Date:   Thu, 13 May 2021 12:50:38 +0530
Message-Id: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the zero huge page is being shared across various processes, each
mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in order
to be consistent. This just updates the stats in set_huge_zero_page() after
the mapping gets created.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.

 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..262703304807 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 	if (pgtable)
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
+	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
 	mm_inc_nr_ptes(mm);
 }
 
-- 
2.20.1

