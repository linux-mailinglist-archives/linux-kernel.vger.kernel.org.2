Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E44164B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbhIWR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:56:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65116 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242652AbhIWRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NHmG2b012761;
        Thu, 23 Sep 2021 17:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=huwv76S06oC6GgrDsbSUKD9Mfu7EDsj+USSFwjbVOqw=;
 b=MDeENHIGavqLvMIO8NEYxBsMPFOiD11RWVpWy62mrjQwwFgJom65W2izyAw0seMvaiuc
 eRoP6AHfEfEuyuM4vgdpB14Z5CBIgByuuTDsO+NTtscKjjJ2suoLMWJ8PN5QftK9Ksbt
 g2zLoteIow8+Kzc2qzAHcbtxVLa96w/sOTPOa8nn+Ygbs51xeuLF6j5VoAk1ftISF1XK
 ocC75aei9OVHsKmj6KoaCtVE393MIGRxK2ESr1hNQYpKCTWkl9/6+8LrKHsIqgoPkiwd
 TH/C0m0OXckV9N0OWcP0uQVtN4D/njPg2q2ZoFjXButFPcwf9a+fFlsgUSGSlNdniao9 oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qkrayyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHpO9Z078953;
        Thu, 23 Sep 2021 17:54:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 3b7q5e3pwk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgUhaO5oBCUBQlxhEE01+jHrpXEmEnxR5cjXDL+3bs+QabiUEHmv5viXNVWuOPBkeDzCItl8iRZ6gLKVW9usF/PrSqOVHbnlMdzkVG/cKp9BPv4X7Xm2MLX1DefXeXnImFz28a3VanhHJEWr1fPcQeIgu8xoVu5gbhEuNyBgdf9GgKRoS5/Gtl68HDMngv1SyuMltGIJhaaAXgLjf4SbbHDHnOVJELOKlYeiOkoAhhLx7MSak2rR2XaE2AvSoxFyjKmEQ5jPXHJlX6FzWV5ukH7MbDSHf7HmnT2IhQI1xo9Bft3x9cyunPSXH2h/VJajrdTpip/puS62MoOeLiJZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=huwv76S06oC6GgrDsbSUKD9Mfu7EDsj+USSFwjbVOqw=;
 b=lZ+Uyfx6c7+KQAZUgGyGJsYu4iNaI6Rc4pSyI+KDgDA4bYNaUCKUAtwPbfwVntCXL1FiDowuRo1imQl8zkwBF0MwtXmwUhXvbSE1TOSWypXPFDNz5fPSvSuHNJzaMpD/VvN7LBc5n46XReNQ5IxF/Tmmt54yQODnYglN2x4yDomdFaUOhwcPaCIZvHJEJ8bSLaWxxiwvdaAoIisfec2Tow0+9LoMTybNwuwx8en+0tN5MDngJwPWKI5yJK3MMkoAuT6sMrV1MN/jKccc5zhfj8jEjunkMRbnIoR6B2f2cdyUZXKv1zSf/mZNHYe41fdYEAfJrP+p9nv0GZcp5W+NTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huwv76S06oC6GgrDsbSUKD9Mfu7EDsj+USSFwjbVOqw=;
 b=ZOUmBdgQoelhmk2gKJXyrU7vBK4gclV01ARDCHgh8UQjldWBNcTuZ9ych452XuNmfCyIUhdMvIkNkLtekaEBHBxS4wMkyVh8ViTYpgiT5wxwAqh9LwW/IqxVeiIgjBSc0qFnlLNvotfYxD5BsEeFVLewyoyQwMoPZKabokZCbSw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2998.namprd10.prod.outlook.com (2603:10b6:a03:84::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Thu, 23 Sep
 2021 17:54:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:54:08 +0000
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
Subject: [PATCH v2 4/4] hugetlb: add hugetlb demote page support
Date:   Thu, 23 Sep 2021 10:53:47 -0700
Message-Id: <20210923175347.10727-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923175347.10727-1-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442e2ced-ac2f-47d4-83f5-08d97ebb2413
X-MS-TrafficTypeDiagnostic: BYAPR10MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29989E711475BF98D03EE8ADE2A39@BYAPR10MB2998.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/nRfO6fDsOthSrKWYONGj0XyQhRq+IrVsvGzujLh6M+klxgeCOHScOjOD6hNcNZTn+gxVYZqdjLFXDBCNx72mtjbaC0p23dOPOM/PDrUvSF7tbsqrS6HESmsFeeXVIbvwhK/PajUVwMJ/0n17fNUHRI/2ZSlc0wtc/GWnhFspIlVINV4NSPqdUnL9/I2+PdSMZO45Y1JdIATH/HzkJTlXDk7Rf00H/pkxROMCNEJxCJjM7G/i1VuMJrWLvw+gSBiTl6wwMtTnpapj/ZqDwrc4JiTutITYKtLKe9cGCGCC5GQtxBqvQJ5U3sxXZWC1Op4dF6m+0OYWREXMVTDH/FMWV2m0c5ztKLvPxmv5lU9PP4D2pPyzy3WclFkXQLXTsiMsuh7uVObNSkKlD6nNs4H0w/9AQ3wPCp5AC4HRe6iffOwutOSbLQCvgF5psibKNG2ELWK+/8/WDAgtznG3zP7rr8fXI6VTGrItcFc+ctg/w+S6a/WZasLVxTfQj3OCipvK1mxUlpMkM5/ZGah3eirOfa9HkDpLFm6NIE1I6ChqFUTnewYYsOzdoioYYbBhajgatAcaMgiAJwrW33JEVQxusmR8RDLNtTLmn7GDKWULJxaTF5Ah9OZedB+yLpxQ6k8eYRsJdblpl6oA81EynHn4V63HphAzHYjUZXd24z1R2r2CCHKtuID2EJ+5OctQMJceRtKBO5OVGM2r2D9joi4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(2906002)(6666004)(4326008)(38100700002)(52116002)(956004)(8676002)(7696005)(107886003)(186003)(1076003)(83380400001)(508600001)(8936002)(36756003)(66476007)(6486002)(5660300002)(26005)(38350700002)(54906003)(316002)(44832011)(66556008)(66946007)(86362001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4ql2SjPPKZdxIwYYoheaBkcR1pKjxTqJhJaGByIzZvDCa8AxxhYrTphwadL?=
 =?us-ascii?Q?9tXrIdpllL3N1ssHOIV0zA9m967RSfJDyb3pQS1Jht85j3VBF430GnlLSkUI?=
 =?us-ascii?Q?w0ba1qexaNVZ6OV2FKzucg1uGMvIKStQB2gXo3lzkl7QFWhmQXzWydV6phDW?=
 =?us-ascii?Q?971WK2vBaoshEKClRAgJzkSZuGhSnRv+usURM6DFNOGDbifq4Mhnt64b1Arh?=
 =?us-ascii?Q?Ud2qFVK0ZDjrl1DqOiBfPzVrewWu6uSJKvwSscL7Akp9h3MgkGCbAVRdQlYC?=
 =?us-ascii?Q?Q1dHNXHimznpOtxh+UiUc59b94uAKor5MzVAPvKp0xMZXP/tqzvzT0Gfgamt?=
 =?us-ascii?Q?C56bUZxIzvLCYx4zZk9sAiv+VbX+br5xQ+oZhh7DeJ+rTTxH3Ma3Zcn8y7/H?=
 =?us-ascii?Q?UmS9U/FnG86sD1ph7vcCW6TCoeHWUYBMT+QfwKJ7ro9YNtUszMGb91hnGp2v?=
 =?us-ascii?Q?IyeTtTRB2vlpaYl3CMGmyAj6FxwQtt7rPptLD7/mb3DjKjV0XQjoPHWwPbK4?=
 =?us-ascii?Q?ge+gR31am5I2iZ86Lodl2ZyhQaM8yYP6+WLUFxdiuraD/2GDw/lAz658Ip4j?=
 =?us-ascii?Q?zXpIZlP1D8kZ+svqMv4MScvMcLQBCCIUOWYol5x4Zzbl2+yx84EeNxkXNexK?=
 =?us-ascii?Q?irggrC9KW6c08K6/JP3ziQSHNH6aexqC9LOPCQ7degwXm7ZNTM9dlLgkAOCT?=
 =?us-ascii?Q?JjcX+Ivbvm9DeN9W1y6c4jfA3Ku4E2hZxeGJWUMQ064s32YLHBcuTaLbITbO?=
 =?us-ascii?Q?hHVGtOwnmqAoW6VxgeYOUUuuuAnB/ODSRn5CK5HJHUIuyixpEGMiVFB2mYYH?=
 =?us-ascii?Q?m2g2RrBdD48OeC+LS1S3kaHMNcaJ5KmZair+dt4f9Sl49wbIR47cWIocn1sR?=
 =?us-ascii?Q?pye7sI2x3T4/oVnT43sFS04KcvMWPOkZwUNJAPPCVZ+4y1tcOQYDr2+AiMT/?=
 =?us-ascii?Q?Q0mnHs1n2fxysH+S9U8ZI4Gy59ZgmymtvS3i3BaQ5LEfjxdPgKUPpMIHlJ8p?=
 =?us-ascii?Q?2uOfhAYTcTVBjjcZGhNVQBwM8RkjjuKkqOGSKELeknKFxXHx7/Q2bf80qIEV?=
 =?us-ascii?Q?wY2PWnnBM4DMdaodKfiTERx913sO0eYxbbIQdNXKfhhnm3widdoQtt+a7CQN?=
 =?us-ascii?Q?s8Wu6Ak7IVBZXaoGFQZezk13HA1Cnoqojp1rdNDevLJCd7UErLZxXClSuMFC?=
 =?us-ascii?Q?50VDXbTOOHHN3Qxt0VRjjLLTPa+/yHtm8BRq1dgD4vHs++dSjpbQTo6s4bVu?=
 =?us-ascii?Q?I7at27xxWVUI2iAixMzgjpsxQ7trBUVgBBJVeoAR8JgP683qw2bNprWl78n0?=
 =?us-ascii?Q?DZBWIZk3HyPeEN/lttXv8x3T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442e2ced-ac2f-47d4-83f5-08d97ebb2413
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:54:08.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHPtqFEOui8CeuDFxl7tgFcPK8NjhBmURMaCsd9PDws37E8FvodS1Wb5KqOBiRX1G9+RNQCGx5dMJe7eeof6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2998
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230107
X-Proofpoint-ORIG-GUID: jjb-B-MvH75By613x3GRP2EgaZlDO_mN
X-Proofpoint-GUID: jjb-B-MvH75By613x3GRP2EgaZlDO_mN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Added '*_for_demote' wrappers for remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page for use
by demote code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2317d411243d..ab7bd0434057 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1260,7 +1260,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+/* used to demote non-gigantic_huge pages as well */
 static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
@@ -1283,6 +1283,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void destroy_compound_gigantic_page(struct page *page,
 					unsigned int order)
 {
@@ -1428,6 +1435,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	__remove_hugetlb_page(h, page, adjust_surplus, false);
 }
 
+static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, true);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1777,6 +1790,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return __prep_compound_gigantic_page(page, order, false);
 }
 
+static bool prep_compound_gigantic_page_for_demote(struct page *page,
+							unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, true);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -3298,9 +3317,55 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	bool cma_page = HPageCma(page);
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	if (alloc_huge_page_vmemmap(h, page)) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return 1;
+	}
+
+	/*
+	 * Use destroy_compound_gigantic_page_for_demote for all huge page
+	 * sizes as it will not ref count pages.
+	 */
+	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));
+
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		if (hstate_is_gigantic(target_hstate))
+			prep_compound_gigantic_page_for_demote(page + i,
+							target_hstate->order);
+		else
+			prep_compound_page(page + i, target_hstate->order);
+		set_page_private(page + i, 0);
+		set_page_refcounted(page + i);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		if (cma_page)
+			SetHPageCma(page + i);
+		put_page(page + i);
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	return 0;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3309,9 +3374,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	if (!h->demote_order)
 		return rc;
 
-	/*
-	 * TODO - demote fucntionality will be added in subsequent patch
-	 */
+	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (!list_empty(&h->hugepage_freelists[node])) {
+			page = list_entry(h->hugepage_freelists[node].next,
+					struct page, lru);
+			rc = !demote_free_huge_page(h, page);
+			break;
+		}
+	}
+
 	return rc;
 }
 
-- 
2.31.1

