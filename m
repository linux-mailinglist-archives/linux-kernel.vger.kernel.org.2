Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8934164AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbhIWRz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:55:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242603AbhIWRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NHmcjo027816;
        Thu, 23 Sep 2021 17:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lukYegQNe7HVRS5Ynyv3DvyMb+oBopWKmJgecjXAbKs=;
 b=txE9LI5SYdlCuQIi75xvGDDQBNEAr1Xns41xnlRZq+BwBB0kQPceJ0a9A2zcEMQra320
 Vvoar+g63IEQMZhhG9bW7puFechGWja3VG7RiHEc/gdU7RH06p4L+PBPaAre/x2kSi3d
 0h5bw2IWJwRImu4umodcS5X4YNv7ULDVjoCiFRUUU5q17uETpb9VDuss5EUa+gO70Ezz
 EESCFL+L4QHC0eqsfMHaAfMBS0wGcV1oSIqgBGPQRuWAR2zrPWTvUCxqtrpNSGZyf3vN
 bBlJOvJGRWff4FAsvOWjMnXv3w/fsON8nO8QhJL8rdMKxF+xbpxrFp+RIbc6ajBmUAHN 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8n2v457k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHpJAq077938;
        Thu, 23 Sep 2021 17:54:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3b7q5e3pt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxUokCleofIfVuYB8a3LEv8x3Wg4Sw5F6yWZ2+uQhQ6o9a/g0cIOSYC5Ry+f8dbK2zm4DDTXb69HaXavSWh62pBteprMokiiHSlrjy1+0trUCEI8OI75S7+7sHP3g/gQzByd10YwETrl317btdLPYQfIhR9cYPQ2zn7HineKxgPkt49/tf1WvdfB+YHvaMfmgvdzluzjyXlvJBTiDEB8fXiL75hq7HwSp8wHQdzGEzu0G93jeaKmPHVzoZ/0IIhO+o5WvWtzm2d0Xdc+6kQajfwMxfMla0Zsmzf1O4uMcsEwLmw6a3QW5d3bzvEJFy1wW2DqvSxcbWmgCg3UZmvlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lukYegQNe7HVRS5Ynyv3DvyMb+oBopWKmJgecjXAbKs=;
 b=ReYIt0KnIjKSJ1KM1iCJmNyzl+//MyR6cNt3VLAa7sMj4XAgBAAkTGUpGnThS26dUDhL98JVIIKqD+7qqgl4DTYANqIMNK6oiXSuhdxK0nzJ1iBOaLTfZM0N9+liNhgd3mDBfGdBOnWIShlMzM6rWfM4xh9DGcGRNSABk+0ljyPfCxrpTNs7iLUo2HwEsEPS6X+ISy/WfMQY3tO3GYqmSsIs1xWhh79a6jEADOM6be550ne8zWkHGlx622xmPIcLloRV81T4h0x+LtzwNT/pLuPlQbB41O/GZIdcVkX3UcrQI6Rk9UwfkQQnZdxxVVA83ZdmHUbid14bSR29QbyLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lukYegQNe7HVRS5Ynyv3DvyMb+oBopWKmJgecjXAbKs=;
 b=MxFKu9Lcx1lZTfD9ZUVWeRjQvJU2SfRT/u8SbIPeFJaq4aTaiKK8p08UcqHUfzmdrLMB2gTI+AOX0BRUNyjS07ZwflSR9S9NC58cYhYRy4PlOifmkpyryoUGBh6X4a1VbuSEjMB85yLQwKnVWAoPW7SKJ6mriD2cnuEN2tiGpNo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3350.namprd10.prod.outlook.com (2603:10b6:a03:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 17:54:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:54:04 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/4] hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
Date:   Thu, 23 Sep 2021 10:53:45 -0700
Message-Id: <20210923175347.10727-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923175347.10727-1-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:54:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd52dbd1-4174-45c5-0996-08d97ebb21d4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3350923833085F3C2A49C12EE2A39@BYAPR10MB3350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sv2BLTaECap9blNrQTta7G9epIbotIuhU/VJ29dK3ZeIFUMohgigTOJ3R4USXtEODB7VTIBhSX+b1mdCohF9bxg6N/PwYwF0AKh5l8MWpKi9mcqiFC3h62L7RIbwDEm3hJcaoig+ZGXLoJn46QrLb3A514ta1njWKskVLC+yMytiPKH5/V43LPblmUionh2Ywke28BTkuGNkQIG+CBPVS1WQnvle6jZWoQ8dyw67YZ/k0pSMoTpFxUh4aN25zp0nP4VS5agpKmAumKHkPS4ix87ugZfHX6yYKmqdV84EqfYBHorLS0NDRnNQKyMqFCKCHT+XI1f9YUe+8xtXBrGSDSu525d2ReN6JXwDJT3b8Dk3jsb+sm74Qy/ZU5Mais+DZBu/+sQQFBc6JhjBXK8W7odAtm22VWlD1aQGB/iDk/tJAV5HsOh1MwzUFXtr8ubH7YiWZ8t/uEHHBYY9BCKek4zsq2xMIgZHhuJFDBkNR0aJLwr1+DqRR60oVd6yrKHbSavXTApXUWJzQqySZ65ZRd8pdo8pYoNBCsWLE8JArk55fa4f9YqoDH3cVsBKmv8wb2mEPl3c4x/4kkcvO2ksj6WcUsQfk0H6juFCFqkgVpZU90HfiHG79kTiN4RrR+4Flft6MXR8ddn5PSC0IjgHYwa5IqmHSo8fGtSqN9hIFrgfX+FFSB+vXTx0dMDwsosAP5KnU1nC8+pF5ux/OA+sKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(38350700002)(508600001)(38100700002)(66556008)(83380400001)(316002)(54906003)(7416002)(8676002)(6666004)(107886003)(26005)(2906002)(44832011)(5660300002)(52116002)(36756003)(86362001)(1076003)(4326008)(8936002)(6486002)(7696005)(956004)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LQ56EcNzD4w2haQGv1H8XJjbGFnSvsYYs2yvHfx+D6dqaC5hWL8SpezHGQ1?=
 =?us-ascii?Q?hsG9gS0tegOkDHEWcSWysF5CWmnvTVPPN/Qol1MljKUUuvMDTFyigynvmLN3?=
 =?us-ascii?Q?fU6cq2SwX1np9oAnBG7FLVbBb4JvbHRoDchgOOPq85N9PZMZxGT2ZMas/Nly?=
 =?us-ascii?Q?Ohinyr5JfH4rxxlH4xiUIAXPqnvL/786PW+R9ZTS+ouvJHZSeS7lvGMVM4GY?=
 =?us-ascii?Q?F2w/xqHd3xOmUlgb8Ui3vFOONrkX5Plc1ZWHEjrBJXPfPb9QqDUFNUNnmmTX?=
 =?us-ascii?Q?M8fh8zboqeLOmNYETklq1Mp/0Y+iHPVq/q/P3DOqZT3Vxchj7UO2rQbo3KIB?=
 =?us-ascii?Q?l5hOcgJ98Jslfnsu3DGzPUWvsl30UQAUGQptg9EFhRhzB8+ivCnmVdN5yTmx?=
 =?us-ascii?Q?ztYaN/5TPCjLPU7S1dKJ5SVpGQMktnR+JxkRtY/anCr+1OOTmMFiL/yHLV0+?=
 =?us-ascii?Q?tpl+IyFiY8e5GFW06kd9N72lr3IXLBmnPndWrdWfYnpVZQTffkQ/keGyxtbK?=
 =?us-ascii?Q?XwIu1Kj70YZkWqlI/RQYOVb2XTECiMTPKN4WRQZnqF6PPHOMcl2/PPys5KaY?=
 =?us-ascii?Q?2Azuelc0RhxEZCSDyRMTHZDcpHPDiyv/4FQwkf8agKJUB/TKjCRPoxvNe1gy?=
 =?us-ascii?Q?xyh5Pwgy9nz9hGxCe6UQtZ36U22l3RhoXXvP9v1s4efn6iOpLZ0lIYAL59u5?=
 =?us-ascii?Q?3gt9dfWC35FLHpK3vCaboM7hwAdWjd0muRzS7fPKATY2fMA/oqY/Djak2YKI?=
 =?us-ascii?Q?VVjMqGocow4W/Ym9N7mbkxCFNSjd3udGgA8roZLFAuixDagUH7hrupNVzRsO?=
 =?us-ascii?Q?eIvYjGPviSeTw4iMtSmKBO1245c2uBMvkDMCpYUyQmrVeOoKe3kMIwP612E8?=
 =?us-ascii?Q?0r14IdpSA7PWoDJ7lUHVCPgWwqTqSLhM90ZBFRcf5URLaieYRWPC2nTU14+f?=
 =?us-ascii?Q?7eWmx9iR1xUl4zWXHHzkJNCsc1rtQhEznChAEpFDK0MWTkfKYvQn9zSWvZFc?=
 =?us-ascii?Q?c5fr/bC50P5rRkTnaMz5Xz/SBlicTgr2flI0p/4tD35uTFsYqj6nv7sGURHB?=
 =?us-ascii?Q?PmeZbtLr18exv51IPB5Sbd6vimHmc15FWb1uBIncdm0WcNqCod2aX94S2Q+5?=
 =?us-ascii?Q?2+Bsvl8jvy3KDbIs7hyQ1wHuCFTRRpoxVnxGj/fDzYQ7wGFnuHkEPeQ8M3Dv?=
 =?us-ascii?Q?Mhs8fuu/ZzOVCsed1jplsNw49XFd9PnkG3sf404WCdyDv/rCWPO+lM2H4Xvx?=
 =?us-ascii?Q?Mi8YeAR9/hm9KLjvqwfVmIm55Kqr3ErSEYflLNdcVd9UJnhn6fkgXQW1O7P6?=
 =?us-ascii?Q?1EOk2BvOXBpaPr/QJrZBXQPT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd52dbd1-4174-45c5-0996-08d97ebb21d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:54:04.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbru3XjasP3/ABou75rDxRcrQ3JDWFRjocAyhUpx5nTdDXap35tZB7huX63Im5HHPgG3vmp6VLNeTpa0haSWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230107
X-Proofpoint-GUID: SnN2YAK5zynPQrNJGgIfCy8oE-me9jNF
X-Proofpoint-ORIG-GUID: SnN2YAK5zynPQrNJGgIfCy8oE-me9jNF
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
 include/linux/hugetlb.h |  7 +++++
 mm/hugetlb.c            | 64 +++++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f2c3979efd69..08668b9f5f71 100644
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
index c76ee0bd6374..c3f7da8f0c68 100644
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
@@ -2997,14 +3012,19 @@ static void __init hugetlb_init_hstates(void)
 			hugetlb_hstate_alloc_pages(h);
 
 		/*
-		 * Set demote order for each hstate.  Note that
-		 * h->demote_order is initially 0.
+		 * Set demote order for each hstate.  hstates are not ordered,
+		 * so this is brute force.  Note that h->demote_order is
+		 * initially 0.  If cma is used for gigantic pages, the smallest
+		 * demote size is HUGETLB_PAGE_ORDER.
 		 */
-		for_each_hstate(h2) {
-			if (h2 == h)
-				continue;
-			if (h2->order < h->order && h2->order > h->demote_order)
-				h->demote_order = h2->order;
+		if (!hugetlb_cma_size || !(h->order <= HUGETLB_PAGE_ORDER)) {
+			for_each_hstate(h2) {
+				if (h2 == h)
+					continue;
+				if (h2->order < h->order &&
+				    h2->order > h->demote_order)
+					h->demote_order = h2->order;
+			}
 		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
@@ -3555,6 +3575,8 @@ static ssize_t demote_size_store(struct kobject *kobj,
 	if (!t_hstate)
 		return -EINVAL;
 	demote_order = t_hstate->order;
+	if (demote_order < HUGETLB_PAGE_ORDER)
+		return -EINVAL;
 
 	/* demote order must be smaller hstate order */
 	h = kobj_to_hstate(kobj, &nid);
@@ -6563,7 +6585,13 @@ void __init hugetlb_cma_reserve(int order)
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

