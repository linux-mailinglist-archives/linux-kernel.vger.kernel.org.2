Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1E3561BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbhDGDGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:06:19 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:60289
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344397AbhDGDGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLJd4QgG47xXEXoo8c+TgKAYX+Tr12EdUKd096p4a8BP2BvpebuNRho+y+SLDxLUOvjD8wUPbfyChp2OC4WwubfBKo+YJDtfHdgzj8phpmag/DkBY8TDLNtdwqlNE5D4DdpNitd9Qdw38iD+qGGQkJC07UMOSlZONGGBQFdNkP9wYjSMvXqhBuiFXMGwNHbLw94Tsehd3PAQNa6/yp2Vf7/QXBws9NiM6fcU6oLzLxaCdPLqKQnSxo6mWujgFBf9wnmaXh6TfCv2crbqmP0qyxVmurH+lJKU0a4HCkJPLMyxn45jdsc/FUJCVwrrEda6oA02YlK3I/N9t9xl7wTaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHshhN4h6TRXXAwkAbo7pnyPuGjnlVA8bSZADuaCnEI=;
 b=Cb5J3WeB2pH0f7KzwEV6GYZuM+lII3fP+FCb03zU6GGGNj0ewTHzYGXiH6gW2b+qEsHK73Fa9QGZeHZch6WpvCHfvOwhkFiDziJ7cVBxytyJdik0S5beycrq/DiNv0/YaHc0tVpGjpQ5/c0DeyTg3hPpXWvyoT1yyVNdMi+ygBcwD/DLk/bpQb/85twy7AGsHF/H7pasU+dPscbEwEWhxbyHR5FlLj3A1TwCWRDtIUPVPSTRWA5uJEAn4OXB3V/N0m6cEf63sbjExwHRii+QDzWsC1NKZkobnXXgGT9QjRFQrqSTIdAhjbn/rMfCp0olGKAJZTNlID5x/T4LngvGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHshhN4h6TRXXAwkAbo7pnyPuGjnlVA8bSZADuaCnEI=;
 b=fyuOxjIr6HCFpXth4H6U6lMF5W6kzJIzwqa/O2bW56IBuJTsX24Zj721QloX7237AWGc+9IxhVcbjicj8BKYiPDFUvhte3Z4BLWjmC/hCnnSzkKYYZO7ruObVLA9mMlPe25om9Ys7LE59Kw1rhAOPZvzgQGblYffL+jfRAe1jb8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 03:06:06 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:06:06 +0000
From:   yanfei.xu@windriver.com
To:     shy828301@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: khugepaged: use macro to align addresses
Date:   Wed,  7 Apr 2021 11:05:47 +0800
Message-Id: <20210407030548.189104-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210407030548.189104-1-yanfei.xu@windriver.com>
References: <20210407030548.189104-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 03:06:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aaf2817-be1a-4ca1-0e56-08d8f97215cb
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4864:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB486431C64168E52C42B1F7D8E4759@SJ0PR11MB4864.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKNWN7ELdpmQ4pluAPbTPRdCkIJb+KJ3HgePG2kyowc3KbNyA3vocH9/Ev0jk++om6zv55qNQruMan7z8WH+WO8acpBIDmhXAhHVCC8ZrgcQFKLMWOy5Ce6sqPXCt6Tw9rQSljnKQrI+LBNEkVPO16/HhYSHWm1nUsfalifs1a85FclC/wDceBTumT7UQi6Mvag1Ef4ElbDcblmU1/QdIMVB3xb6gwzBx3fN8cjioK/6+RmUG1Ehp0P96WIj9I4ASA2eauWOz4FS5u9cNUvHAu45BL62pYoMXM/UO7FZ2oUWHYRBnaN97u4DaCC0wMm5NBgrHkC2kHZJe03p6l/YZVlpIgTfZtRks83PFVQGwfImcLnLEVv2ZdNmQ0z0N2ZsFt5ZXUtuX9XJ3/UXK6nn6MqTsyzWW+eyibEmT2gzPsur8MA74WoBLusKvab/cFiz0uzjFN2de8xw16n4pdjsd9/6KTM7ImGz98ggId5mTTjuJOZbm2aMQX5F2k12g8qKpGr/Oo9k4Bdh5kZhfhMNk8wJ+nFMQXGj3wGOLSPw86WV9qViL29l9JPN6ngXMHrUftzF47g/sHJJ0KPRklj7cgeeaO0J3P6AIUTf65ZdCBXPIO512pKTqLNipn2QCTJUJQwPl7Er3tyBDiBp29wQrGIhM6/JaS1923C8LZoP01iGgohoZ8RYbsx8Bo29p7MK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(4326008)(26005)(6916009)(52116002)(38350700001)(66476007)(38100700001)(83380400001)(2616005)(8936002)(316002)(9686003)(6506007)(16526019)(86362001)(66946007)(6512007)(5660300002)(36756003)(6666004)(2906002)(478600001)(6486002)(1076003)(956004)(8676002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o+Z73QgMbMp99mL97bkQ1QfkJkh/aV4iJw65hub7miIKZnTdviMXNRD3diLD?=
 =?us-ascii?Q?raDLH5U0UJV8pSJ0Wl6YfuYB3HyUOf68j74FVu9OzkqTpQ1+ympl/E8d82uH?=
 =?us-ascii?Q?XuXe3HfcSVVifxbu89jKgMBoJ4XJPi5Wk4MoJ+IMcIcUZYaL/RXB5NiXagwT?=
 =?us-ascii?Q?eDqbDxjxlRhrpJf167a+jD+O2YfTcO/0R3LvEAXAeBlSeS6iD2GhKW8PfdH3?=
 =?us-ascii?Q?SV57Kh2cN10wvb6uJGTTmMBoRdvnBLinYQ+crZqFLOcmr3tEPdRN11jt5UaP?=
 =?us-ascii?Q?SphmLDMkeRUUT2h4M3HCt3HJ09g6pm6j4stlZmXcC65C2LGzcA+NKExSe1Wm?=
 =?us-ascii?Q?My9BW8RAJqb2+J/ZB+BBHXmhC728og5s64dVIdha1cW/Gp6YSCbw+kUesyc5?=
 =?us-ascii?Q?OS7eS9K1uZhHZHecc78/5hMnTykB0FRsMxrnhIUQ7lCvTkt7pAzgAfU3zmqR?=
 =?us-ascii?Q?ZXeJ80h82p6Gam4kBS3ozGVcNvYqqfuNoMcTU9UzUzWYzYvlegcq3eslyjpv?=
 =?us-ascii?Q?Bp0nAKNdOtaDv4Gzi14+bUM+60oxP17WSTgbPlSxyExkYWHWdz7wCJDChLP+?=
 =?us-ascii?Q?hsbfP5g0jk7VYYMfAhamH56aecfJElMocdZMA4BsaVPzcfOZgaf16ddAw5DQ?=
 =?us-ascii?Q?K4j9wkbBOn0aOcgleObUzUuFHgIWiSgOX73gQA1P8Wil6JqbPj37t+s8wBFa?=
 =?us-ascii?Q?A8adZvKglb+e4fc/FpwMmkxnCd6HFNUKDiFurqtrxWDpgiIVN3L0C67QpjfJ?=
 =?us-ascii?Q?JR38dU91c5BY7wcjsgKplihMT5g4veOkIGtdgrFgaeOGODB9kMFwpQHN3Gwu?=
 =?us-ascii?Q?nyRr6UR90cWUMHiLR3yntUTxiL3nhQSCU6l6D4xWz7myO0L3mnbrGH6IzoD9?=
 =?us-ascii?Q?7gwiZjZFlKIBZ8P10EXX1wSOE4PMJzt7DAFtO9eAVDJf1r6HtBm2b/aD836C?=
 =?us-ascii?Q?B5xtF9l0TmRmYsyp/yaHuTgsh7mbn+f/5ZfQIACDeLqnwc5DVvGlRussN26S?=
 =?us-ascii?Q?nG5aypLiJ1P2xW77DgwZGIC6wBjWTiM+qWjB65YbshN5Pn0mSS4OQAM7/COo?=
 =?us-ascii?Q?KlVtaR8zy8CrgsqVjV7Ooa5YZNO68GCrBV8zJ89fJ5a5QPihV5JlqlrtmUyu?=
 =?us-ascii?Q?0OtnHJUyZijefG+qiDWw3HzI2YU+5o23OmsPvgKODY4R7z9z7Ms+2yhWK/Mt?=
 =?us-ascii?Q?qodUXx0Y0OXwduN42j9jX61tyYhhla71WibXY551L7OYY8rqpuYJX+r1yseo?=
 =?us-ascii?Q?IK25nC2fj7dzTyHME745YUYGice9ft2vXeAlRzQItXj8itrD13KRaNHnQlIk?=
 =?us-ascii?Q?pYdExt8rBQ4bhdEc6+uFfxRt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaf2817-be1a-4ca1-0e56-08d8f97215cb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:06:06.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okxn5FPZvd3RGo0nmr9usWlNVAaUt7DTqqFDLBcAPentzo+1yd0/aO/oxJ1dvLTyk90qQ1Gf+m9QgMpE/ZKdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

We could use macro to deal with the addresses which need to be aligned
to improve readability of codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/khugepaged.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..a6012b9259a2 100644
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
@@ -2112,15 +2111,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
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
 		if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
 			goto skip;
 
-- 
2.27.0

