Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA323538A0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhDDPdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 11:33:38 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:64865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231135AbhDDPde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 11:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6jMVjS/QvO1BO397rmxRlvyVUXYBIr+lgvPU5Wf60kHJArkNN0zrj9KfCud0FqcVDEYCTZFohSPb3cPj+a6YRVZAxBvoBkQzxhND5I0oejeNsaYduZ0tDG5/J8ZrBBax3+/ovHH7LsAdF+yBudWHCtLvQivTCFqJeblfFT77LvUWmFnqrPZCIcnUxijQSBxUbfdRwKi+LR9px+W4HDpnUM+xdL/7dQMyoxMpXA39SHXuzjWbITyEgN8YSgZ6WpopPtKQMCGc5cMVWQJCGzNAglo+AlNxrSmG8LjK6gfDwgL5BlA9IGY205yJ5S2dUEySN56OmEiqhqpn4TqhAazRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+OlJ5uq8qCC6WlIMGuNECBqNu2Oa+tLmowthOMXQco=;
 b=dONKtosPYk9FJzN0H1sExncJ0Z9QKI0eYfod1AcOoCFRAJMCcXkTcV5I02Cmb5ri1kzzKWexR9ZJBIcAysu40OigR0Av3/Arjd5zpwfAlokWpylXIHQDKJPBzVvLWqB/EjfulF3Z5EX64bvfP7b/+gbeF+i7EQRQ2VuQ9I0jtVV1kZyYpzfqC9a8dPNRCbxPD51ClRiGQUrxzKHa45IEpNoOrjxmDGLMrw10Ga39p7GOM+yBAaYfSVrqK/BwsWgS7f3OzW6IhkGVJRQY7L4kwg1kJgJYiIpc/IjzM1TDeApndbq/pWgXEDHww1g/E73/5gsj4YPND9hlD8Yyaz/NKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+OlJ5uq8qCC6WlIMGuNECBqNu2Oa+tLmowthOMXQco=;
 b=CIQqVGroyyjE/UfA+MsCaX5x4CtVVW6AqZA0MrxA+PEJnT2hV62NPu/bg0gaOzOT04PF2a4UNI3070yyGv3yFmG1H3q52x0rEAT6OdshZ4JigQuSpw+2Un4gVQ9uZ9ndjgSCApSO7T2/5RoXx1IXitcu3Gjyr8SaxvMHvKJdWpM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4181.namprd11.prod.outlook.com (2603:10b6:a03:18c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Sun, 4 Apr
 2021 15:33:24 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 15:33:24 +0000
From:   yanfei.xu@windriver.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: khugepaged: use macro to align addresses
Date:   Sun,  4 Apr 2021 23:33:10 +0800
Message-Id: <20210404153311.1460106-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210404153311.1460106-1-yanfei.xu@windriver.com>
References: <20210404153311.1460106-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Sun, 4 Apr 2021 15:33:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eace5dd1-4ccf-4fa4-c6b9-08d8f77efc26
X-MS-TrafficTypeDiagnostic: BY5PR11MB4181:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4181A5BCF71D6F22940A15D4E4789@BY5PR11MB4181.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtHG+Yx4ZAPauQi1Ac5/quqCdVUgmsxdiCZRDAOUQ36alof8i7gatn+ucbJcsgIhQEps0s2+usNx6sAT61lEHvUb9AHz8/PoUFM57lKuPaLWhv6FB5t7cmHWKiUHzdSI3qdu3zjLLMp8LPDlIR6QpACqUYt+DDen+jCSMuEoR7C34nMRShHoGlMS5UpKOEpxAkF1MOMSZf+Wt/QZSO+ZsJwcUgaljkXEdVLVp2TAtOdkg/zrJE6UiyJeGfdFIExLHeZQH9VcznV0P+lsFU5geAy78XxHn7RxtKdgA1WIsQPeML0KdMpoC60zdkCACIlTNr9o7+3qnjzkfsCEkd1grs8uQAhitYmtjAHMAmQmi5Z/wvmZwV5UxlpSHv2R3gXLTDIrAhbGi7PulZ9TxRSXZHLrwcJdYhzxwP1UeyJ5Z93Bj/FgTtlgI1vstyWvDUfar1f3U4K9ov4RDp3L8gIhrhNjSF6EV1pYH337a4YD4zac2xr74xgPGfZdf5XBUNAozIMzzRHVr5gwyU54sdN0Suw09G6mvsjZ65iLCyT8+W3sip+v+IUMt8BkxFGhQg+ANMC5D5dC68amuumMss94RIngH4zrwpGiNIBOTNkBPg6EoL/SYl1hW7kyWTEPY667v+5SPgIFZl0uKmZLXh+1Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(186003)(16526019)(6486002)(8936002)(1076003)(36756003)(6506007)(86362001)(83380400001)(8676002)(956004)(6666004)(5660300002)(52116002)(38100700001)(9686003)(6512007)(2616005)(66556008)(66476007)(66946007)(2906002)(478600001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K9DhspIEeQ9HGCM7MbFd4A50/dnLLXMU9zKu80pn5724dSkzhIM+IgfsTLfH?=
 =?us-ascii?Q?0rN17uWNQWlSAgwZZtIl21Bs9xDG6laEQ0NiD9G+dJXQsNfzZVrXD19+L+yE?=
 =?us-ascii?Q?3YtRHV0Az2FCFY9GaUnV6mOh6V+JyZL/Get8vT1/CTEafr4TgRHf6IguvbhL?=
 =?us-ascii?Q?X+A6vIc3fiq6PJqwUYmgeBxP7+RyogmoYa4wG6n6qJ0HCEPZ0MXzzeCKncM9?=
 =?us-ascii?Q?ZF4XKtxpQt3XkEMmxTVu8x3B6/lVk0OdoCvS6Gy3hmPW5Etpb5D3WkRc7aG4?=
 =?us-ascii?Q?3+zzglkJWmZPYBQGcqP7F4YcCEttqXVV6WXY8mMTi8niQmyxDkjGKZh7/di0?=
 =?us-ascii?Q?e3iDifG/0ycP+Yr25liOy3RUitqQgSO0HIAFSz5vLHFw0kiDB/qeEF/McQht?=
 =?us-ascii?Q?Vh7auFX4aN7xW2dRBLgokeLA/KgLzmmdOtfCF8cmo9kt4w6/GBTWYESPYoF6?=
 =?us-ascii?Q?/u5s/FO1KPDZIQAGQUfqSCIUb9FQ9MOX04S+4a9uWyPUKHnhsnAzRZzUiTPO?=
 =?us-ascii?Q?TAGd4eC65MuBFtYW0adY0zvSTRLUMvBwUwbIwLRUJPEdLrEwqLTXl9b2vTRH?=
 =?us-ascii?Q?bTNaIHBo4RUohB5JtNxwAvnGZfSR7ktkdxRQXZ6GnDN/uayOAAVxYUox38eW?=
 =?us-ascii?Q?6143dqTonhNU11Nyn+9rN6TkhPcQNgpVpEq3e4ru+PzM4t/mYsM/46NczQ9m?=
 =?us-ascii?Q?DqQLmSplEC4apPdCGF2t41sgAIxSzwt57VY0sRvGCZmqfLxA38/4dSzR5jpD?=
 =?us-ascii?Q?LW+jQcpMLlVJrdMmilU57jahETtdXjsmEJBHAbfH4uiHVEPup3H6YCicm9/b?=
 =?us-ascii?Q?l//uYzDaGvo4OGCh1AzKlEWoF+DhfEcIJSS/YQttdeD0aCV/4rfXYNkXLykX?=
 =?us-ascii?Q?2cNV+zP4LY8LR7q6gQ/EBdQyGwiUDsTGZ7VlLvfsaGHjlhrTPS3vpJa9amFk?=
 =?us-ascii?Q?dGu7t+NJ1h1qxijhdOOcNdvJZzwO0O/uFPvqOAn4a6qeCyoifFoLE6WQ3kck?=
 =?us-ascii?Q?FGphQD4ODizIwApYN45Wkqe1O14wIW+e3maw648j4TwjIfhO+BiY2tdahN32?=
 =?us-ascii?Q?t+N+cqIHHk+P2s4HEYP9pUiXt6Z6c7L3T9+0IcM3tg2EilYCnwlPVtoRVqq/?=
 =?us-ascii?Q?Wkve91KZvQdBOeN1bxABGag4+vMic0ufSiQcHQpnuPY3sWjI8O8xKY62jSFL?=
 =?us-ascii?Q?lzNN8pdYh9zXXprZXOf89Wg7y7cLb6F6Pm12czlMBkupcXGhABvcI6k4B/MR?=
 =?us-ascii?Q?oITeEvZHM7BYHAGyvFhxibSeBOd+WR8PGOlaRolqMQGQfJBGnkmNpoaccQlU?=
 =?us-ascii?Q?gbRPGohn79mK316Q5jzF3/sM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace5dd1-4ccf-4fa4-c6b9-08d8f77efc26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 15:33:24.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uSmk5zzy85ISEeTydGYmr2pChOa6viuxuhkEDofPLf0YkSAtpZ6E3NazlbhTzyXZrZZlmb8KM22lfz+7W172g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

We could use macro to deal with the addresses which need to be aligned
to improve readability of codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/khugepaged.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..2efe1d0c92ed 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -517,8 +517,8 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 	if (!hugepage_vma_check(vma, vm_flags))
 		return 0;
 
-	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-	hend = vma->vm_end & HPAGE_PMD_MASK;
+	hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
+	hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
 	if (hstart < hend)
 		return khugepaged_enter(vma, vm_flags);
 	return 0;
@@ -979,8 +979,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!vma)
 		return SCAN_VMA_NULL;
 
-	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-	hend = vma->vm_end & HPAGE_PMD_MASK;
+	hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
+	hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
 	if (address < hstart || address + HPAGE_PMD_SIZE > hend)
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
@@ -1070,7 +1070,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	struct mmu_notifier_range range;
 	gfp_t gfp;
 
-	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 
 	/* Only allocate from the target node */
 	gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
@@ -1235,7 +1235,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	int node = NUMA_NO_NODE, unmapped = 0;
 	bool writable = false;
 
-	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 
 	pmd = mm_find_pmd(mm, address);
 	if (!pmd) {
@@ -1414,7 +1414,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 {
 	struct mm_slot *mm_slot;
 
-	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
 
 	spin_lock(&khugepaged_mm_lock);
 	mm_slot = get_mm_slot(mm);
@@ -1437,7 +1437,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
  */
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
-	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	unsigned long haddr = ALIGN_DOWN(addr, HPAGE_PMD_SIZE);
 	struct vm_area_struct *vma = find_vma(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
@@ -1584,7 +1584,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		if (vma->anon_vma)
 			continue;
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-		if (addr & ~HPAGE_PMD_MASK)
+		if (!IS_ALIGNED(addr, HPAGE_PMD_SIZE))
 			continue;
 		if (vma->vm_end < addr + HPAGE_PMD_SIZE)
 			continue;
@@ -2070,7 +2070,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 {
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
 	int progress = 0;
 
 	VM_BUG_ON(!pages);
@@ -2092,7 +2092,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	 * Don't wait for semaphore (to avoid long wait times).  Just move to
 	 * the next mm on the list.
 	 */
-	vma = NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
 	if (likely(!khugepaged_test_exit(mm)))
@@ -2112,15 +2111,16 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			continue;
 		}
-		hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-		hend = vma->vm_end & HPAGE_PMD_MASK;
+		hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
+		hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
 		if (hstart >= hend)
 			goto skip;
 		if (khugepaged_scan.address > hend)
 			goto skip;
 		if (khugepaged_scan.address < hstart)
 			khugepaged_scan.address = hstart;
-		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
+		VM_BUG_ON(!IS_ALIGNED(khugepaged_scan.address, HPAGE_PMD_SIZE));
+
 		if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
 			goto skip;
 
-- 
2.27.0

