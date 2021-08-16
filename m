Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989E3EE01B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHPWvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233869AbhHPWvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMmfrh026744;
        Mon, 16 Aug 2021 22:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=juKGQFig8fUy1uHmmnuGMRjyuaZcj6mUOPoOpkcnplk=;
 b=fDiT/w+duKfxzmJFw05kRsZjdGTu/MnOaXlOoGhNTgD1aGcceBQjWs/gGLOSa3+E4Pxl
 7+DKbJipCmuOtHfCHjAi3gaDimJKtvxiEIZ0bvlEBhLGrzkesEK8ng/vIXaN4rvpIcvJ
 4u9VkFWE/hfbZNycYrfAPDOEPaoPTy381dTum1T+rPoD82tk85HnQ+TqTCoR6LH/+DaC
 QuXWo/12dMCjYY5KgsFdzbTlzOSltoJhi1hP4/o1G7NOC1of5g2Q1AAwz4VuxXl5xoOy
 VgOnhCQXiFm2+xOt10ZYHQU+szGVsF6aJHKOc1s0f3HXThFIuF95plkheusuIbBQRx6I LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=juKGQFig8fUy1uHmmnuGMRjyuaZcj6mUOPoOpkcnplk=;
 b=YofYpZ2jf9Floc3dgsSf88VxFVKlYyoWbj6J1jPZfyZ4TUwAAGN3zuiR/NRcwZ3CA7yD
 cMznG+ixPc3pedyeojvKBMmQgy9Twukhqj2kmtldk674G/QUIqL0ZOQ1r1wPJFqy3JFV
 pxRhtjeAO1RL4EoO0zs+XuC3RceNbSNKyWH5yUKcydYLYkUjUbMKhFZV1/WRsL2H22HT
 TCqIfaE30iFqi3ZQXr4Lu8e0ufbD7HgmJc6Q4lZCPAruin9Fk79SNae3Jz3CA+M0lwWs
 EtO3rKbHnHBUulc3cJH1i2Fx1kRpaG2IdFBsxz65jVsiyUyqtGfgyZCo7RFsaXuVKHoE 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af830322x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMiu6H040104;
        Mon, 16 Aug 2021 22:50:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3ae2xy13wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwRkPl86gejsP/mOAG+yRELt2FyhnoDzd1fikFwzInqr+WSi8hPx1wvByqrw/70uPtmb9ukk5nJ0aFfE2LI9iHBdMrPUkXDAijCWtvBtBfGnmsz40hBiFQB5h9DhB4Kb7suJ8oUXvfaq4X4lakzlR1hU3PyQmGFI+NnGdceLzOTsTdYkuDFwbY7CO/+52SA7tfy8lvT6HkR/OwIf1Bkc9eU4FX6OYQ0sVfxGtQrdm+9dH1Mukl4dnQV/vKV2GaMQctmmKZJmuIIwKPfU3jakxpMDphk4+mO+HqpbA6fn8imvSTbrn860GQ4ewj1idgTLzjW0MsPyBKH60SffwpLgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juKGQFig8fUy1uHmmnuGMRjyuaZcj6mUOPoOpkcnplk=;
 b=Geo6ayWz7Ihd35Rx67BN399zJF4bMtK1SQe0OIvo4K+N4KzmMsYOrMuySDbm6VQBBmshQZjoYh7QWXhYGMHByhcIydY2P/9rUU+1+wNB8kn4Ya3OBWPz9GNid/DlMQaS9De3CUotBVX5zkikQ1tmttPextDY2Ry23Bg3A4mjCY1bnyIx529aK1coKCNjPrw3cZUyiDyfrx3bP2DeHgDU/sHHpPP2SqdyaOG0H/1ynI9hv+2dRnMWx06O9G/w+uVDaX8/v7v2Nczu7LJ6lK+tmrIDg7v3NIYAxOPSzfuknziYqzsH3TbjZIcUpYyidq38wFYpFdDFvYN/x89RR65F5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juKGQFig8fUy1uHmmnuGMRjyuaZcj6mUOPoOpkcnplk=;
 b=MBCwc0HC6ZIAyMFcxh6SmQ8uxBa6TltpOCZmpEuUoS8u8rBqP6CU+5cKE/glbvNFxtmW/+57o2au8jdbrO3sztP0GLYL3+bV06i08XhRXwfp0QUYV5cAktWGlnqGncE098DYYCggoT1vOh8VNayiw0XKe7YHuVwVrkR2cP3HCIU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/8] hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
Date:   Mon, 16 Aug 2021 15:49:47 -0700
Message-Id: <20210816224953.157796-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb809ec4-95a5-4853-9b36-08d96108339b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3397631ADC342C628FC68E20E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVqq88YllSJtC+gGUESh/fv04nmxk+YNsvC05KC8wRQz4d+z8q1+URyvJ8u0ZSVups6BuFU9nk+6AZIu8Y7WM8jNOHRWL8ER1QbsQ4Gr5iG/Nbdxzqfbh7kZ+trGI6S0jxWauiB0klDnmwl5O566n33TliidAeFkzFF36FDN4dFx1G19He1KPjcjBNdA7bIpJgZG2wCBYcPNQNo5r/ke6Yti3EIskhUZOHPUZYJUYIlsB4tp2yhblfJJr1MJC/jbv2FRWRxvE6gJExJhhB/ef8nyIR01RLaoLSRZifb9AL4SIUG/oIPgmqW4ZbHQHTwh1AI3xAI/K+FlLKfOE95GD3Zjaxk95nhqf5Tbj0xqpNMqoKPLj4ucYOGhuuJ7ZBzHFucSkxpHuMmAZOe/yGlg8/xtVX1owWvoBH0tguLnrL4OZDSLcbx08SSjgQf1Pd1ap14CNrvOXQ+eAWy9Y9qqc2rJutGujs364KM+yyiTN53i1jLBPFyQ6h8XBcnHoRR2dLSfebowpAbbAWTFitVJKB+cGQy18FrkSSSZfJ02rUghJ7JKM1MVEAMP1EF0FD90mvnoRfoBEiWSbQ12ZNB8tcB2TptY6JqVEg0c8BVxC+ZUhn+QDn5bDxYhCyE97LnttzrkUgN4PL1fV0b3JhqWd6pxbWuv8q6pSNMXVZtmSJxlxvInP1DDDiCaSJlEZuKVKeL3EUl7IAbT2XpVror5Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKscPD08VhHhd9fFzezPG1Usy+Eu+7QZe3BOtFnI/uolCufdMK7yuoF66C/K?=
 =?us-ascii?Q?05QCC3g+HnWJCFTYvS6wdaop+jI0H1+dDAkj2pZadz4Lje1XEgcUjsH6ecLx?=
 =?us-ascii?Q?ew4E5lW+CztWRtm7sQ6DzOOgdO9D9m0Q//sVd/FGRB6uk0SXigxEAHxDGQ41?=
 =?us-ascii?Q?2FEqiTOzjQQk1RaHk00uFvuWZgtC8imBmtW0/28UJJq/Rw7IOxN8XMnjc+ul?=
 =?us-ascii?Q?yx1CD2XZqrmsNzuEx63qUHdWoJ2qjlew/wMJMHJd/UQNY7s0izWyNYJ03OKE?=
 =?us-ascii?Q?dq3Idto5a+/JN1/ruMdKcGRHtyeXBGCEgzCcujyIHWy4cpFKdYIy/anhuFft?=
 =?us-ascii?Q?bpYi7zrZeck5U8liCtOBQPTjT98Bfmb1+d7Hfn566zIrrZfYb8xrt/5N1WgL?=
 =?us-ascii?Q?/dpPWJOIKOVZvUXhewmA37lePrVDMbW3AL7i7x7b+hOJI1bBAq6Og9LHn0zF?=
 =?us-ascii?Q?QfzqdF/UHEZiv9gPp5gOVzZGyNlhomEIUU71xsZURZt4ukYfVHO21UWuuG1J?=
 =?us-ascii?Q?RvNJ57Xp2kQNh0WiOIKC+6C6drELGz7vbM7JwjRdd6b4e6uX+GvVOAHWnXpR?=
 =?us-ascii?Q?CtWf3Hg8WvA7g7v+SazAX2mJnxZFtDuct83/ZnhdM51Y8DJWQG+Bac1gMh5h?=
 =?us-ascii?Q?XPjpwS51nzOjD5OwBXfe3Rzv40ydoTftXp6veo2gPpXW0wN/YOFzocA72QgS?=
 =?us-ascii?Q?mzhlWDqnjsbL2QEabH7j8Sl+9nVC+svhj7FatUCyq9EowFdM15rJpf8v5VAY?=
 =?us-ascii?Q?B5PCR1kh0D4vDBZyjJs2re35kczSKqmr1I6UATAVAovj4Pfo8l9wndfA8N6h?=
 =?us-ascii?Q?7cEjZNqm52hSh4Z/P80rPLfmZwUekmThjDyGEIg82241Avo/liDutoJG6UXN?=
 =?us-ascii?Q?DnNsLzZup/yvbYBMmoaRRV2x9UtQhUEu7Pk3vynh1dFX0nn251NALWjs+/cM?=
 =?us-ascii?Q?JaxQuTNdziM8fW9ThEaSyC8+S8/8ymzTG7AEmSTEzDG/KETZs2w6LOzP0ddn?=
 =?us-ascii?Q?2GRJyKF4w/71rY+NPvHbl82aegvsXpqI6exA06D3VSLwbBdIvni1VDbMXp9F?=
 =?us-ascii?Q?XznL8pLqEJ9CrBeUvBMAh/ttk0fOnwskHC82BQZyw5t8Bc1ju00z7XXfrMP1?=
 =?us-ascii?Q?aFoz1kGpHlBwyW4r7JR6Fk3vJMf55tEwv+RGRQk4WRlZI7rg8SoCUw2IJ4Ux?=
 =?us-ascii?Q?qbbtYtfhvUdHF78PknlKGT7mw3wpcQ27SJ8UhNgURHV/2PshTUYQnQS4S8oA?=
 =?us-ascii?Q?wu7fd6BanDg8Qjv05qePXn1Tp6dCr7cEWaEoTBsp+E6G8KYW7Ri2EKTitgu6?=
 =?us-ascii?Q?O2J0bDpIZMSVhUv1BEl83wEA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb809ec4-95a5-4853-9b36-08d96108339b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:10.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9TZeCp7RxkIGe6LmyyfOZ41yhmbWpmwkdAAiFcBDVkls3LaBToPXsFP+t3BUNPpECmOYzTIPIovM+9kSB8pog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-ORIG-GUID: ZtD13qfB-bA9x4zeCv2VKMjSS1joOJWt
X-Proofpoint-GUID: ZtD13qfB-bA9x4zeCv2VKMjSS1joOJWt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When huge page demotion is fully implemented, gigantic pages can be
demoted to a smaller huge page size.  For example, on x86 a 1G page
can be demoted to 512 2M pages.  However, gigantic pages can potentially
be allocated from CMA.  If a gigantic page which was allocated from CMA
is demoted, the corresponding demoted pages needs to be returned to CMA.

In order to track hugetlb pages that need to be returned to CMA, add the
hugetlb specific flag HPageCma.  Flag is set when a huge page is
allocated from CMA and transferred to any demoted pages.  Non-gigantic
huge page freeing code checks for the flag and takes appropriate action.

This also requires a change to CMA reservations for gigantic pages.
Currently, the 'order_per_bit' is set to the gigantic page size.
However, if gigantic pages can be demoted this needs to be set to the
order of the smallest huge page.  At CMA reservation time we do not know
the size of the smallest huge page size, so use HUGETLB_PAGE_ORDER.
Also, prohibit demotion to huge page sizes smaller than
HUGETLB_PAGE_ORDER.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 46 ++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d96e11ce986c..60aa7e9fe2b9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -533,6 +533,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_freed - Set when page is on the free lists.
  *	Synchronization: hugetlb_lock held for examination and modification.
  * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
+ * HPG_cma - Set if huge page was directly allocated from CMA area via
+ *	cma_alloc.  Initially set for gigantic page cma allocations, but can
+ *	be set in non-gigantic pages if gigantic pages are demoted.
+ *	Synchronization: Only accessed or modified when there is only one
+ *	reference to the page at allocation, free or demote time.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
@@ -540,6 +545,7 @@ enum hugetlb_page_flags {
 	HPG_temporary,
 	HPG_freed,
 	HPG_vmemmap_optimized,
+	HPG_cma,
 	__NR_HPAGEFLAGS,
 };
 
@@ -586,6 +592,7 @@ HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
+HPAGEFLAG(Cma, cma)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0f16306993b3..47b4b4d1a8f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1272,6 +1272,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		p->mapping = NULL;
 		clear_compound_head(p);
 		set_page_refcounted(p);
 	}
@@ -1283,16 +1284,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
-	/*
-	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
-	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
-		return;
+	if (HPageCma(page))
+		cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order);
+	else
 #endif
-
-	free_contig_range(page_to_pfn(page), 1 << order);
+		free_contig_range(page_to_pfn(page), 1 << order);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -1311,8 +1308,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		if (hugetlb_cma[nid]) {
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
-			if (page)
+			if (page) {
+				SetHPageCma(page);
 				return page;
+			}
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1322,8 +1321,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
-				if (page)
+				if (page) {
+					SetHPageCma(page);
 					return page;
+				}
 			}
 		}
 	}
@@ -1480,6 +1481,20 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
+#ifdef CONFIG_CMA
+		/*
+		 * Could be a page that was demoted from a gigantic page
+		 * which was allocated in a CMA area.
+		 */
+		if (HPageCma(page)) {
+			destroy_compound_gigantic_page(page,
+					huge_page_order(h));
+			if (!cma_release(hugetlb_cma[page_to_nid(page)], page,
+					1 << huge_page_order(h)))
+				VM_BUG_ON_PAGE(1, page);
+			return;
+		}
+#endif
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -3003,7 +3018,8 @@ static void __init hugetlb_init_hstates(void)
 		for_each_hstate(h2) {
 			if (h2 == h)
 				continue;
-			if (h2->order < h->order && h2->order > h->demote_order)
+			if (h2->order >= HUGETLB_PAGE_ORDER &&
+			    h2->order < h->order && h2->order > h->demote_order)
 				h->demote_order = h2->order;
 		}
 	}
@@ -6518,7 +6534,13 @@ void __init hugetlb_cma_reserve(int order)
 		size = round_up(size, PAGE_SIZE << order);
 
 		snprintf(name, sizeof(name), "hugetlb%d", nid);
-		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
+		/*
+		 * Note that 'order per bit' is based on smallest size that
+		 * may be returned to CMA allocator in the case of
+		 * huge page demotion.
+		 */
+		res = cma_declare_contiguous_nid(0, size, 0,
+						PAGE_SIZE << HUGETLB_PAGE_ORDER,
 						 0, false, name,
 						 &hugetlb_cma[nid], nid);
 		if (res) {
-- 
2.31.1

