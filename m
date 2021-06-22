Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827A3AFAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFVCRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:17:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhFVCR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:17:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M2CFWx002119;
        Tue, 22 Jun 2021 02:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mbv2Nd6UumpVMG3C4bZmcm9fxjOu05OSYSd0BAAzfR4=;
 b=F1KRaT5gpWkaFFeHj4gDAzcmink1fqGBfn2GE3Xv2IYAVFKGyRcBGlOlu2MykbNxx5FW
 oLyXMN4CYjI0tNdI2CS93rvxTLtw9afYYDdzXEANoeHQ7iVqsTdu4lrcIPirD2vqekMA
 YStm5dnqv6Nt+liI0jpDDbovCgcryHYf3NRtV0SCH7vab2UWi1KxZmJVMjn6RMnxstHZ
 r9NcH9SlG6B3fh1yjt8VY345i0epG/vxF3myiFvN0NqP2FAnrnl5iYHiT/686w1MEosR
 WW84YOUbuxsiphMdpRG8b07eBZnYJ1K09cKIefrA0MgyOwhZpBSwdH6tVKIpnSqReQx9 Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyqandc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M29aL0033420;
        Tue, 22 Jun 2021 02:14:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3996mcqnbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOtierj9P5S7Hhwb3Y0BZQMct1Wv8Jn6SpLvDPqZr29IoSOU3GRrWp08G1dCM9SzBDLGkZHT66W6ickvEiBkG+p9lyfEWlwq5dBrDSVMoJmmoRgef9g5XJftfw2F2vb1CnGF3/YxB9u3JNG1ngTgdrKnGNLLQSZZ3DF45FORfAo2YRurh47HuM2g5yVIlSvZlpUOU7RUMh46AGns1k+NP2r+m+7yFSK8xL7wPRZLWY8i5O+S4TE589fe1iBwVq30gI2+9XjSqn8GCHCiVetq5T6s4qyW/IRtjoGq4+eZArM3cAcm+wQUItuNfKk+FE3Mcdop/9r5CClbBN+5Ifsn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbv2Nd6UumpVMG3C4bZmcm9fxjOu05OSYSd0BAAzfR4=;
 b=nG4vyKnxt9XmhBgmALXUSmq+aoTyznVgDS9uLyNhQLUI9IFFiJ3R8NUGG1tQcqMuGN6lS+RUMwAjdsjH323Smlh6Ap8sa8u4gQY4QzO6hg7DqS6DNsGYCoE0KPhvkg5QO/fY9jdE+bhKRxrofDsjN6+7HqwTJZNIgP2hwzuHaX3Jlmm8oDtdQGvXYggare9R1bVuMfNbGGWga+hTitclL8FYLRrM3eWiQTL+dyJYbHcSAzp9k7y1eq0OwMpr4N5N56L6dn+rs734WPlT63e6L7O93jd5Ba8sCTKT82jIXNq9SKPIqeX4MCGlaU6XbXAyZJLYthQ9AfTImHiJ4AzRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbv2Nd6UumpVMG3C4bZmcm9fxjOu05OSYSd0BAAzfR4=;
 b=lloIpo3yvm3yb0z3qZsRuaLI0FQbzw094FUPccCB01Ro+T+BDKXPfRnGTuzkhgsHmTQh1YGcbHjKKo7ivRfeSEDlEEH11+GD8t2KXl+M35hXeg1zy7c22WWdLGKJJMUZBoXOVIApM41HmJkQTwWpZ56mG2lUD7ABQGCfnxVRFRk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 02:14:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:14:40 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/2] hugetlb: remove prep_compound_huge_page cleanup
Date:   Mon, 21 Jun 2021 19:14:22 -0700
Message-Id: <20210622021423.154662-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622021423.154662-1-mike.kravetz@oracle.com>
References: <20210622021423.154662-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 02:14:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa9ffb4-9b44-4605-dad4-08d935237e27
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB266406EFB70101280C0AE270E2099@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3rp7unXtC3bFcY1KxIDhojrgTXFW6SowawVG8l3cWoShs1hfxNFQyJTWP2vEDVtFT/Ubw3RyNTP2cla20PIUlkh9nMs8IbDhc0CqdpMvA4simjyjx38YeBsUckiJDccxjcU0nkvCKl5dAgHa+9PnK7+to7yDinD5RZfCfizpPokXR9Pdu9+uomCJPzXNRLU7X/JwplNq9Bifm+mABJBwcAzmY3IcwUmni5XbomA+sgOSjDhAgC1UR2ec0SQdN4OCl+9yPFAdowx1qjpoLmndFyrF8zq1UVmP8AhwoiHgHsk/eM4U41xhyMkzsxCG1WCfSEJ8ySQaFTKsHqBfnywDZ/c4eUWEoM6N1CKRQTbgo5KsqSOXzlKrIKtpHEiZnrIiMA95JKDsAr5+VPpJkIkfsEcclQJ6eBVE9WcnpgE7RWy7wIEGC6cfakk3zSiSz3dJUJfNNh3bdbPiv03rnUYqVsxm6DeY9c//nvVp9JlAuJE72r5CsTn6iOjTQ+Rwdp9kAB/4HFvMgM2WkVE4Tfg/6J0+bYc6qXnEe5grCpPMwQz8tqAYUW9NUxZdE33fFK1tgzAc69fYqb17q07/wB4Up3cnz43ODXSLGt8loRbX2ygXKiMmDAtgLxt79dJ/20ToPBOUUeemCx6QjzvkuEBxBgAq1Lg+GFlG5JE9qCaN7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(52116002)(16526019)(186003)(66946007)(86362001)(66556008)(5660300002)(66476007)(8936002)(7696005)(2906002)(7416002)(1076003)(26005)(8676002)(36756003)(478600001)(44832011)(107886003)(38350700002)(38100700002)(54906003)(316002)(6486002)(2616005)(4326008)(83380400001)(956004)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ma1Eb6OlMV5TC/AH1DAFvIG3Sn/xwKwNmYGHgLQ9wspkbLxVTjV+cNVE1eDe?=
 =?us-ascii?Q?aNODVT1nsWtHpYgVtiEdWPaGzdXpBnpuvbyQKhx2RJdd0qlcL5zFUmktJI8E?=
 =?us-ascii?Q?8Y+Wt/c64rdfSz4HudpIGk8KJngfPnQYB5R9Ditk0Vhh1XCeXLqvf1f9cW7C?=
 =?us-ascii?Q?P2mlSuo85dvQwwJeanTr9L+ug35GH5MHlC9J9gu6AaMdvPaTRQ5IOc09cZ0n?=
 =?us-ascii?Q?IHTTBcVAeCDqba4GcnZD+5W5SfDZjh9Xxe1yr4hASyCrYqfdwZ1RUSOw7vRd?=
 =?us-ascii?Q?JGf7JNxR8quYfjwQsY4hQ77OB747WOBMtW/MR8s9a3hWFX+UjzJpdDGFVA/h?=
 =?us-ascii?Q?bE/dymP4T/qPuRmf/0QSGgwWiPllV3CvVEWFqdEeEhP2UOAAA4Zbr5sW77iP?=
 =?us-ascii?Q?dov9U25HJAp3C1R9mXkOB/dCOBMObB5Fk21gHFoAt98RZaguYMdZENTa+rea?=
 =?us-ascii?Q?II8ftkmFnKK+23eJ5JSDxxVw9Ar+IIgArelGWPcKURJJ1VJ7tZbtfo+PdqKi?=
 =?us-ascii?Q?CXe7pDsrijTaRgIqrtCyiC34KCdMd4OzyDPwDVTSqLruyn16CcQrssTGbvUO?=
 =?us-ascii?Q?gmxQmNnDAUhT2qMfUUjYX7eYIibQlVlHocG6dZJZH3AwWnc4C/D9qVVmMCFd?=
 =?us-ascii?Q?3Uf3vh7ZfL0mWmQCVtZjZ3tFqwbzbwxeOCm8gJCOy/pfmRHIWWWG6SfEAh5u?=
 =?us-ascii?Q?FOW8GsMBbhrPgz/hjDsFd18tATafWnWQF7lBsU5wKTJ+qlsjk6xDxufIIPl5?=
 =?us-ascii?Q?9mzzEx8EvXe+GQueBTwK2wWwFYr/DikEBUWPl5Ebw+9QRFH9xOGvx75EVXbA?=
 =?us-ascii?Q?GqxLpEo0R/mexk1tM5561t6cphdNL/sry3rjcLZSDGVdxR9HMQ7OeJv9XHbE?=
 =?us-ascii?Q?3vK68Mp9ptBBXGKvDwu5m6cTf1qyQFKIxTqsTLQxIyZpRkDdrBkCJhnlbKaF?=
 =?us-ascii?Q?AhVDtzINNdXIeOgVAYSeaogO+g6yNDb5A8kV+pycDQk5dwub0SUnj/TBZ2lv?=
 =?us-ascii?Q?09y+jC+Km3+YfjTfOLHvzRaCu7qDCtUyy2IiWIthseDP4pwUVCsp/wHutV/r?=
 =?us-ascii?Q?SHBLlDOdNUUp7uR7d+pTjgb2sjm7wXclFocDSx9kndDhx6YfDOz+KqY5ekJ6?=
 =?us-ascii?Q?IpOYawvhX3JQn1Pal2VwXMIOkRz5d7Rv518PP1df9umyAoACD9RBLQU7isCb?=
 =?us-ascii?Q?xNifELldJkSlUTa4TldRZIJh+D19/QN4Hf6ygmWeZz48RQIlz7c8yrc2l8o/?=
 =?us-ascii?Q?0CkxABA/KTuF192UmZa7/Yz4K7KrF8jpyfpg8tEBRmBJIkyzw2e7fZzRZN6R?=
 =?us-ascii?Q?Elh6Sdopigakim29a73bnmyD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa9ffb4-9b44-4605-dad4-08d935237e27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:14:40.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtGxJ11Q4S8m5O0rRsTWVtg99LWdDhe07bYKaBOfZKggApy7jUJLNoqBwL0VcSTlsNwrm4oZ5pdA4zTRwEImVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220012
X-Proofpoint-GUID: BMyGzsjoWissqy57CebtcF3mvCvYrhgn
X-Proofpoint-ORIG-GUID: BMyGzsjoWissqy57CebtcF3mvCvYrhgn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine prep_compound_huge_page is a simple wrapper to call either
prep_compound_gigantic_page or prep_compound_page.  However, it is only
called from gather_bootmem_prealloc which only processes gigantic pages.
Eliminate the routine and call prep_compound_gigantic_page directly.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 760b5fb836b8..50596b7d6da9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1320,8 +1320,6 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
 }
 
-static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
-static void prep_compound_gigantic_page(struct page *page, unsigned int order);
 #else /* !CONFIG_CONTIG_ALLOC */
 static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 					int nid, nodemask_t *nodemask)
@@ -2759,16 +2757,10 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 	return 1;
 }
 
-static void __init prep_compound_huge_page(struct page *page,
-		unsigned int order)
-{
-	if (unlikely(order > (MAX_ORDER - 1)))
-		prep_compound_gigantic_page(page, order);
-	else
-		prep_compound_page(page, order);
-}
-
-/* Put bootmem huge pages into the standard lists after mem_map is up */
+/*
+ * Put bootmem huge pages into the standard lists after mem_map is up.
+ * Note: This only applies to gigantic (order > MAX_ORDER) pages.
+ */
 static void __init gather_bootmem_prealloc(void)
 {
 	struct huge_bootmem_page *m;
@@ -2777,20 +2769,19 @@ static void __init gather_bootmem_prealloc(void)
 		struct page *page = virt_to_page(m);
 		struct hstate *h = m->hstate;
 
+		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(page_count(page) != 1);
-		prep_compound_huge_page(page, huge_page_order(h));
+		prep_compound_gigantic_page(page, huge_page_order(h));
 		WARN_ON(PageReserved(page));
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
 		/*
-		 * If we had gigantic hugepages allocated at boot time, we need
-		 * to restore the 'stolen' pages to totalram_pages in order to
-		 * fix confusing memory reports from free(1) and another
-		 * side-effects, like CommitLimit going negative.
+		 * We need to restore the 'stolen' pages to totalram_pages
+		 * in order to fix confusing memory reports from free(1) and
+		 * other side-effects, like CommitLimit going negative.
 		 */
-		if (hstate_is_gigantic(h))
-			adjust_managed_page_count(page, pages_per_huge_page(h));
+		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
 }
-- 
2.31.1

