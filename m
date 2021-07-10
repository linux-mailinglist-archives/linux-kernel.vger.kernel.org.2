Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211C43C2C08
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhGJA2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:28:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhGJA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:28:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A07Hsg018591;
        Sat, 10 Jul 2021 00:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=uxw/Q9cnbmd2qoAVkRUIf9tKuSpi17BKl8fq8VMdxnk=;
 b=wz4NMyf5vtS2aPJgWAav0OCyB3Nu5/OypNsG/1+3sl3hP1DGBEn+8pULJsNAk/pZl+Vx
 GoX3rW/JA0BIv4KQ2MMxcoloFHL2cGYTH/cDLcx8gJziNheP7dDZEulcZNvzucu/KbrG
 Cnzj4bYvbbf6q5sLFXeawalYSopzcoJBHBJQ8bunvPxAOG+mHqLzv2eXHbd5/LdCMwZC
 xXo24E3tnraU4ZUQ0USYkIBSe22cfFyWCCTIxz7nEaHvkusMoFxdQ+CBYMitqfeadDso
 DCZRYXHVmBUO24QnFgPBJcZuvqA1t70cKGl+Oh8yMmsJ/17diU07mIOfS+1FoyMAFksm Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pjkaspe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:25:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16A06XUB021657;
        Sat, 10 Jul 2021 00:25:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3020.oracle.com with ESMTP id 39jfqkceyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe255bLE0riGpU4a/mnvkuPc0YyLgxGf8Lgn0qLFrTzk/IIwHBTC47B3vFBbFQuIN0r9kS0fyzETpFV7KTJ/vDnEbRPRG/1emG9TozHqJO/4XBBDBhm94edVUpS4JbZW6g4eTt0Jk7i4b/32TjcV/2OOfGHpQvZLL9g468GTUXUl7wqd20O8fksqI7CviVC70mYdMYirBa730/pZ65I5oVJvT2HYDo8jxwS639fTSFY4GyLa055roJRbwYLzhqU3pTkUW1dyPesI96P8bu1vNKkAcheY8LOGnogp6PifOfymz4TNQygCqIEKJ0nsZ5mp/FR3IoJqnLf1w8dQ96lDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxw/Q9cnbmd2qoAVkRUIf9tKuSpi17BKl8fq8VMdxnk=;
 b=frSur7XfQRv+HxGcw0EU/RZzN89qF3HkGZpk6s+jhsrubdsmeEbEjgiMECuxxTaP55D34yxgFnUiYdbfz4dbluX5YXe2Rx1WIuHTV0hexFG7umL2HHNX2dtO1/V26KnS/Fi9K/MOMT1T5T0JG/lC95/vyP2C0MnGE6lAZbVylx8KD1VIIYR5wnfAZENqpksuWyvmRAH72OHZkUMdLgr7mOUUeq8AFB0ZhXLI86IQeD67l+f2wxgAr0sKzivBFb0OgzJ8dv1Owp6d8p9aHQV3bAgD9tjqOG5afp86sQIfmU4AnrOhfKcQ0e2CXvpmBXmYcoSc2/L8Q6dJ2hvbIFNQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxw/Q9cnbmd2qoAVkRUIf9tKuSpi17BKl8fq8VMdxnk=;
 b=Rkjlymz4M9XlF0vL5jZoyQwt8gjVQnXNjsK8s4CPos3nY+Np+Z30GqJE3CHHO5xwjl9JiwaoaT2qx8++aR1eEnVBQ3ZT5sHEqYJOLilH45WemhnkrsB97p3aEw5FxMWan7nmUXvuHlctXb5NIhHhu3wnqUkdAir1Y1D9BhpPwWw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 10 Jul
 2021 00:24:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:24:57 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/3] hugetlb: drop ref count earlier after page allocation
Date:   Fri,  9 Jul 2021 17:24:40 -0700
Message-Id: <20210710002441.167759-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210710002441.167759-1-mike.kravetz@oracle.com>
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:300:12b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 00:24:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 754ecdb0-e7f6-4d5e-d5d5-08d94339259f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38109A2401D98EAD3151B57FE2179@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36QThsPdDBUf3x4m493fJwiX7mqFs2jbGw99llQd4Depa+cWRd+TwocfRrIaGH0k7jKbs49fEXoSyv4vGWFywQUFv1rvE13lJMnZd0BL1wMKlibk3rMOubNqAX8MEvxUCdDKTPLuH2NsrHUebJZQG644FqzkkywR3iEMBTYQpLzKeovnzG/9XgoTadS1cgP0224pbmA8aJ30oyAIMaHoX58rtz0lVWiV+BTFH6ndc2MYffr8JDW6dtDrQD88yKuKILpUFVODxPE4EnrxByIyUNMhbFhsV2ZJSx6Vit316y0n/4ixdo/z6ptCAmIeqg6QbhGDS8S9ptSsau/1Pi8NIQi4TnaG91ozEc0xGMGge6eOU1HWrdoaIX2V4HvGuxaeN6e99pOvU/c6vRbWq0EeIPI1JRmP8krS+NFemA2f5vb4UJlufqLuz3dNGNy+N0I2VqgOeBaaFLhFTvaqt2MxSSF+Z84g5j2EyHCZUeunfYNJZufYtPZmI2+cmT8ynsimErOQlY9isgyYM2tr07xzkwErgvvcNSV7lVKr3z+gbgSAEmoKBWyxp4h7VeLluEt+ZMaPhYKDnZx+A4/lKreQ8jJ5oP1MfuN675jPNe0wFg+WUQPZPBSkdZugmuZ3847mNRz9Fe/k9hK4opSSCZA8m9Qq7u1J5llmghrLcdnCX6/dDZ6rLvxbXdsWkYkPCdtK/HGaZFxbUlwkef8gPJik0bixYOeAWNUy5Nr3QfugbzSb8s7x2JnXGC+CcWxMf7tV/wG0aQStgT+Fzh6bc/YtD+hyxrg/nqOKhtfnCotfOeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(66476007)(2616005)(8676002)(107886003)(66946007)(186003)(38350700002)(316002)(86362001)(38100700002)(8936002)(956004)(66556008)(478600001)(36756003)(26005)(44832011)(4326008)(1076003)(52116002)(83380400001)(54906003)(966005)(2906002)(6486002)(6666004)(7696005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HD9kKKfN3BlvPjowPzyiczo0cYUdR2u8V/Jf7RuFQjUwpdHJhO+lKUOUfd6I?=
 =?us-ascii?Q?jGuZxv76Vc9XSo2z2lt9vwmygj3zId2LiTKTJmX1bwz6B3ESCWxQFKoDIZ9E?=
 =?us-ascii?Q?LxgfbdDtju+GJS32kx8VnBjGwf7O9n7iDmV8VkOJqHUF9rqBh4PSmTjhdUrD?=
 =?us-ascii?Q?yccwxsPO17fQFD/SLDAfXoaVrst2QsVtg+qqTb9XuLN+LX0rTQ+2BfGRuqTz?=
 =?us-ascii?Q?ASSDXk8cRZfxSfiVllMk7eQLJQYwTkbEm9gu6hQwMXILUrhwozOuURY6bKmn?=
 =?us-ascii?Q?6RXIdAME5N16C89FmIaTUcDx4wtusIWEIefMY36DbzvvMKvtpboUG4D/ioGh?=
 =?us-ascii?Q?0v5Yqu6K++EvQ6C9R9GRwpJSnr5j6DJ4OFrFJqM3rLSagVQeB/Z/RwO74+aI?=
 =?us-ascii?Q?KXoXgtgPN0k+Kvc6r8R1oowBt6xjrfAH8KdQMDQ1hiWWVjZU9OKqK1ZZLcV9?=
 =?us-ascii?Q?eZW8KGff787qDoqCXFtSR8whhoRmtgiRQPdPQ5zrfF/Wo/mAa6/VrIV/MUNF?=
 =?us-ascii?Q?Iy5AdAYVXjHsFMNEiijXrztjLQA/qgjrj1I0ZynRH+W4Rr03g82RIxSZF8pB?=
 =?us-ascii?Q?4sdX6KAJCeIq0lWizxONejjT3rVcXigi3VThzmUpRGVmEDE1nU1zVlH9PzMG?=
 =?us-ascii?Q?UG+xHAUqRYe7mQ16fTfN5PttTwVWDZ4jG7K/+xxN6hddjwKJAg+z5in9ecLx?=
 =?us-ascii?Q?6O+4hhqzZpGI55KQiWr863UYVjQYhD26K8e5ZWSynSDEvRdn9ijszgo8XJGn?=
 =?us-ascii?Q?0Ot0JxzfBHFJFTwTfwfmNf6yhNqqRNMlV8j6QNdID07ssvdgPQV3dNAjTMv1?=
 =?us-ascii?Q?KAlhFgnBNmR9kDyELvuAd3uIierWFXdnzCkoERtM+S8Y9s2Z5evROnHWANtU?=
 =?us-ascii?Q?QWK4O/bjdxqIeNMg9GkOjxMkln2+8M8HcHwRaqGupLM4AdXfDIL2415x4miy?=
 =?us-ascii?Q?2I0UidKrGCDQgaMwSqRe+7lcwVeqWb5CyKo5N/h5e8k55aPjnIV+Su4+XXbF?=
 =?us-ascii?Q?Beci7kVnEsyH57ujmiPARDdjUC7J8b0uuHbN9uAadm1oqQ38nMNwk2gYt/XC?=
 =?us-ascii?Q?TnzEIkxcXoilHaUP44QSv88LCN+WFKgkzg9MsMXMOkDEbsj4Y7XCwJuGC94h?=
 =?us-ascii?Q?WE1Ni60LvyXA31a0Q981wT0ylT+lVhks9ppfa+NHa9sPi9DhwmtoRtLxc6ja?=
 =?us-ascii?Q?BbqiGEtVyIE9HmaHWtduuZfEh3nIdr3KScDkIS6D6g8sHSPYijMeDEkNAgpN?=
 =?us-ascii?Q?kX1MoiouRXZjAqtSRH5U2wUIf1k7E/T/L3+CzIkbT1VdcvWDGWAWB+570jjf?=
 =?us-ascii?Q?TCNNvaE0zAxXQwBekFstqXcS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ecdb0-e7f6-4d5e-d5d5-08d94339259f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:24:57.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2t9iwkgbqy0+jgIV6GW+GyNDmU3XoS2vGNp8eXFv6Soc5v2gPpFW7ejXirqyAtON7q/SIbyrPFAaj+zezHqBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090126
X-Proofpoint-GUID: s_aFSw7GY4DmLA5NfZcTqAdxPdbJ1tKP
X-Proofpoint-ORIG-GUID: s_aFSw7GY4DmLA5NfZcTqAdxPdbJ1tKP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When discussing the possibility of inflated page ref counts, Muuchun
Song pointed out this potential issue [1].  It is true that any code
could potentially take a reference on a compound page after allocation
and before it is converted to and put into use as a hugetlb page.
Specifically, this could be done by any users of get_page_unless_zero.

There are three areas of concern within hugetlb code.
1) When adding pages to the pool.
   In this case, new pages are allocated added to the pool by calling
   put_page to invoke the hugetlb destructor (free_huge_page).  If there
   is an inflated ref count on the page, it will not be immediately added
   to the free list.  It will only be added to the free list when the
   temporary ref count is dropped.  This is deemed acceptable and will
   not be addressed.
2) A page is allocated for immediate use normally as a surplus page or
   migration target.  In this case, the user of the page will also hold
   a reference.  There is no issue as this is just like normal page ref
   counting.
3) A page is allocated and MUST be added to the free list to satisfy a
   reservation.  One such example is gather_surplus_pages as pointed out
   by Muchun in [1].  More specifically, this case covers callers of
   enqueue_huge_page where the page reference count must be zero.  This
   patch covers this third case.

Three routines call enqueue_huge_page when the page reference count
could potentially be inflated.  They are: gather_surplus_pages,
alloc_and_dissolve_huge_page and add_hugetlb_page.

add_hugetlb_page is called on error paths when a huge page can not be
freed due to the inability to allocate vmemmap pages.  In this case, the
temporairly inflated ref count is not an issue.  When the ref is dropped
the appropriate action will be taken.  Instead of VM_BUG_ON if the ref
count does not drop to zero, simply return.

In gather_surplus_pages and alloc_and_dissolve_huge_page the caller
expects a page (or pages) to be put on the free lists.  In this case we
must ensure there are no temporary ref counts.  We do this by calling
put_page_testzero() earlier and not using pages without a zero ref
count.  The temporary page flag (HPageTemporary) is used in such cases
so that as soon as the inflated ref count is dropped the page will be
freed.

[1] https://lore.kernel.org/linux-mm/CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com/
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 100 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e59ebba63da7..3132c7395743 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1072,6 +1072,8 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	int nid = page_to_nid(page);
 
 	lockdep_assert_held(&hugetlb_lock);
+	VM_BUG_ON_PAGE(page_count(page), page);
+
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
@@ -1399,11 +1401,20 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 	SetHPageVmemmapOptimized(page);
 
 	/*
-	 * This page is now managed by the hugetlb allocator and has
-	 * no users -- drop the last reference.
+	 * This page is about to be managed by the hugetlb allocator and
+	 * should have no users.  Drop our reference, and check for others
+	 * just in case.
 	 */
 	zeroed = put_page_testzero(page);
-	VM_BUG_ON_PAGE(!zeroed, page);
+	if (!zeroed)
+		/*
+		 * It is VERY unlikely soneone else has taken a ref on
+		 * the page.  In this case, we simply return as the
+		 * hugetlb destructor (free_huge_page) will be called
+		 * when this other ref is dropped.
+		 */
+		return;
+
 	arch_clear_hugepage_flags(page);
 	enqueue_huge_page(h, page);
 }
@@ -2015,9 +2026,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask)
+		int nid, nodemask_t *nmask, bool zero_ref)
 {
 	struct page *page = NULL;
+	bool retry = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2027,6 +2039,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
+retry:
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
@@ -2044,11 +2057,35 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		spin_unlock_irq(&hugetlb_lock);
 		put_page(page);
 		return NULL;
-	} else {
-		h->surplus_huge_pages++;
-		h->surplus_huge_pages_node[page_to_nid(page)]++;
 	}
 
+	if (zero_ref) {
+		/*
+		 * Caller requires a page with zero ref count.
+		 * We will drop ref count here.  If someone else is holding
+		 * a ref, the page will be freed when they drop it.  Abuse
+		 * temporary page flag to accomplish this.
+		 */
+		SetHPageTemporary(page);
+		if (!put_page_testzero(page)) {
+			/*
+			 * Unexpected inflated ref count on freshly allocated
+			 * huge.  Retry once.
+			 */
+			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
+			spin_unlock_irq(&hugetlb_lock);
+			if (retry)
+				return NULL;
+
+			retry = true;
+			goto retry;
+		}
+		ClearHPageTemporary(page);
+	}
+
+	h->surplus_huge_pages++;
+	h->surplus_huge_pages_node[page_to_nid(page)]++;
+
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
@@ -2090,7 +2127,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
 	mpol_cond_put(mpol);
 
 	return page;
@@ -2162,7 +2199,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL);
+				NUMA_NO_NODE, NULL, true);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -2203,24 +2240,20 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	/* Free the needed pages to the hugetlb pool */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
-		int zeroed;
-
 		if ((--needed) < 0)
 			break;
-		/*
-		 * This page is now managed by the hugetlb allocator and has
-		 * no users -- drop the buddy allocator's reference.
-		 */
-		zeroed = put_page_testzero(page);
-		VM_BUG_ON_PAGE(!zeroed, page);
+		/* Add the page to the hugetlb allocator */
 		enqueue_huge_page(h, page);
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
 
-	/* Free unnecessary surplus pages to the buddy allocator */
+	/*
+	 * Free unnecessary surplus pages to the buddy allocator.
+	 * Pages have no ref count, call free_huge_page directly.
+	 */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
-		put_page(page);
+		free_huge_page(page);
 	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
@@ -2529,6 +2562,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
+	bool alloc_retry = false;
 	struct page *new_page;
 	int ret = 0;
 
@@ -2539,9 +2573,30 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
+alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
+	/*
+	 * If all goes well, this page will be directly added to the free
+	 * list in the pool.  For this the ref count needs to be zero.
+	 * Attempt to drop now, and retry once if needed.  It is VERY
+	 * unlikely there is another ref on the page.
+	 *
+	 * If someone else has a reference to the page, it will be freed
+	 * when they drop their ref.  Abuse temporary page flag to accomplish
+	 * this.  Retry once if there is an inflated ref count.
+	 */
+	SetHPageTemporary(new_page);
+	if (!put_page_testzero(new_page)) {
+		if (alloc_retry)
+			return -EBUSY;
+
+		alloc_retry = true;
+		goto alloc_retry;
+	}
+	ClearHPageTemporary(new_page);
+
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2581,11 +2636,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		remove_hugetlb_page(h, old_page, false);
 
 		/*
-		 * Reference count trick is needed because allocator gives us
-		 * referenced page but the pool requires pages with 0 refcount.
+		 * Ref count on new page is already zero as it was dropped
+		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
-		page_ref_dec(new_page);
 		enqueue_huge_page(h, new_page);
 
 		/*
@@ -2599,6 +2653,8 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
+	/* Page has a zero ref count, but needs a ref to be freed */
+	set_page_refcounted(new_page);
 	update_and_free_page(h, new_page, false);
 
 	return ret;
-- 
2.31.1

