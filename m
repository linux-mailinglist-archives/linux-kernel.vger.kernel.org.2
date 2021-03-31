Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85734F794
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhCaDng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhCaDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3fdSQ001603;
        Wed, 31 Mar 2021 03:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=XO91rhECBlZ4sJE9BGLwXKbATaM3qjN9AXdXXJyLG3TvPeA0EK21Z5gcDvwAzN6PheRH
 YMC1VoSt91lyanZCVVXSm2TTOPexngUvZALYYAeil9rrIsB0LrKj5mXM03koNt5CrC4c
 kNkYDTLuHtiOelEqwFufNdO7A7cagrzqyueQMRU9zd/7OD/7gm9JePp4Xhuzc5VwZbnK
 knIv2eMUtbevH866Q8+je2loD3f5+j2at1IAqwIuKBkcmYlVALo2BHW0dAE6EGp04E+x
 pqO9xelIfJ35OmaGhvRND3LagEAh58nisqM0833/eRotSgMVYfPeSi+mFDBNXFEcZaB0 lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9rs08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ddFp121881;
        Wed, 31 Mar 2021 03:42:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 37mabnuyq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T32bgmlwne/LksMAzagLed48daz4fWxc9oOt8troCtJUUlFe45mySONtwDYfpta/GvuSSbK2y43WTq3npHDLpy1NDtU98Naz+OHPLUfYKZO5ha8GQLvC73WG6bKGvIeBOTjA+O6+C8bG9xYvEb+23GD94cb52WrQt1VKS1ayXD1vf0AF2N2EzAlmGay4MmPG9QvSPReBOQSDU4UAKssIITpTaKUVQhzxdqzVUPpB5wTcfdredwdNN5zKEoWZS7X1l+fyWIpJVkauTchBDu0hD4J15O08yd+pxaeVJ4fRVxCyCNAitUlSrUfyJiEVc0QxASftpa6Jzm+5FJS4ewrqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=TWqEGhN+bbwBM0CgcfYwYk1IgNPi4OcdqVV5QqTy936UxaPNT5gyauBJQnkPXGwZ5a20kdW8nwV8fbIu8zU4zxcNtxvUVMn2rcKXE1jzWD+4rf25TqzpFaOCwuN2f/xtqNNuyySYZmdu5vD3S6qWhJUGlS+URqi7WhSExPVBTLe+BDEY97GV8SC/NsJtOFOcONcvP0Z3zAVHL2JBCQ+toMVvQjNhqgjs5OPaj1hkJ8t2yWcOInvdjf6pc0hVUnY1gCbDZeoBzzB2H/sQWsSp09b680eJ9i4k4Vq++EI+/50bWyEx0uaWmyfgBydf6q3yKOqei4r4muPBs2D1k6fzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=cnGPmrNP6QqvwzcFsENKgF+n5j7JNdbNRfanW7oHrpm4G92t41WqsOEJqTMcHi5cLHA558sK/pJ45ZNgu9RTOlG8gelPlMtr1idRTMOS+zpY8y2R/UrJtwdS0/p2LZaje7/jCjKjXczvKW62Q3S2b7/YWtjUuW8IuWd3iWlZp2E=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:08 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 4/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Tue, 30 Mar 2021 20:41:44 -0700
Message-Id: <20210331034148.112624-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331034148.112624-1-mike.kravetz@oracle.com>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1def4b4-22d3-4ce1-36a7-08d8f3f6f5e6
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4462F388256DA29E647973D4E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPfoz1lGF7zdaFGTFDAuK6Xs++n7Hexyzz78iDNxs30r/0si//z4wiAIlsJRPoP9oY4Uhd00veWQHmQws7TkTeHpaNfr2xeo+NMG4kcI7IK1s/2tY3pgqdVO7M5TyR7kcQew8RUlo6oySOgQj9Q6dKU7SmVybm8vzzxtJco431hyqLVCeS5SFpyh84c3Ihpu2CG7zXlrD68DbhgT7ydjuo7P7SgMQH9KX46138405EMfbxsmwnDTVr75RzkAuOS64xAUc+cdoDMOiPxUVrNY10t5aTNI3TV1Dzg2CMfkfhguTrS5nMP/T5ap8iQhw5YuLvqJACrLm2tDRNmocp4BrEEyL/0RDXbS7ZTQzg5mKkcPu9jeJfYbkGAv8yTIgKz8UkryiroSBDmhqj6ViMHsalCEfAXcAvWMGhHXUYOhDdIe8Xx2x1d6Kh/xee0+Zsri85Wp1WcOiNz1UXkBvEWSLmqw0LoSJdMnPUTwx2U/Lq8f2RngGoAzVoSQY+tRZQEYmzXy9MiRREYBZid9gWrkCr3ZSSrkq2jkEa9ceD/XwabA//tlZXBFLOxJf57rl72t9UPMK8Wen6ww/pE9yh/XoCmUnw0xWhsZvLPyZc/2qZOHy04o5tKFTwB4RkhSKfdT6QSEpMWDNWdwUnhQGzfhqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3kQdEYni9QMlmfcHGlTZJRngvdHC6ye1JjElEQYjwtdNdAEJDUkZpCS5E118?=
 =?us-ascii?Q?a56J7TgUNjtSDwPYp+CLw+8jr1pE5lXQ9P7y5fUqmXZR/anNHoYG1tuhAY4j?=
 =?us-ascii?Q?Vn3gzdXWBwNDQ960gsgxZHWjYkvqDoAxB+SjzcA1uFQ3Cj/dwfThP/NFN6hC?=
 =?us-ascii?Q?o7pxC247iH3PXUyolZSw6UO+UUvlDRKwZDTvvdngLOAKbCB8kESkSlBZ1j+l?=
 =?us-ascii?Q?LQN+Y0vhvwY5g3qv8uDFjH5TQYPuoVi2d/ARJmVPyQE4DxW6ypccLZHvLwbV?=
 =?us-ascii?Q?QCbJ/h8FIMXX0UodFFMCljY1BoDXA+hmz/QEm98a3JwVdSaX2AGzwf4ze7Ou?=
 =?us-ascii?Q?iSGnVrDM3nFuA3gvp4KSyOCTRaKmVFhvNdvKi54QtK0SdgpOCgh0P56Md90k?=
 =?us-ascii?Q?8cpcf8v3kcVrOop4haYx2L26BWkCieEvHNNTxTc/XBMvnwEyG5xENanPSF+c?=
 =?us-ascii?Q?kTAZM+s5cAMJemJy8JSGpvxfXmb/vDAGDK8EF0r2Ef0kxtn3uK6RS+skerqE?=
 =?us-ascii?Q?QIIjohBLqjeDHI6Tsdql8cuZwtRH9wjSBHN35Uc8fuyrIaZ1gPlHc/dFy9hR?=
 =?us-ascii?Q?M18FHSDOSlSz9q4XMTcrtDAqwhFdyuDx/YcMlHwsXGjEGDJFEOQ8FnnIW8XG?=
 =?us-ascii?Q?rYAMgPaS04lc4cWlV7y7K82ckaqsRaluQ8QDYocTwd+rrRASsyRxHT/URsqd?=
 =?us-ascii?Q?ylrbIZ5TGeggE8CLMikyfUGtt4pkCLlSgiVxd4g/2vOooiB7gggLw0F/80um?=
 =?us-ascii?Q?ec1bYe36O9Gylv+7VWML2Wb2CrZGckv3UJXckopqq4k0qtUjQwYPa5aWFJ46?=
 =?us-ascii?Q?T9HEkeRvBpVdL+YuR0zriwBC+fVO0C69EH/nC0tiQxbgUCkGUHFHgOj4r7Jg?=
 =?us-ascii?Q?DC4oSh8s5Nvv0uP+t7M0k7fMG2aXN0k9LDTd4LDQaEYFSm8x0c/zlo4cWltH?=
 =?us-ascii?Q?4mz8SieoY4Y+3sKSJXaKnwSPtRIZvq3R18s8sozJFHKY1adeRQmYu9kJkBRf?=
 =?us-ascii?Q?KKoIQDyD8FB42x1pYKhFd0RwZpiNWEbFl3kCRuMm1dLLwWz+192CvscahKsu?=
 =?us-ascii?Q?20gtJ3B3THczUGaSMp3h2osxdLR3UhHkjEd3p6ZHhKL2HX8KqNUtXLHMsNtf?=
 =?us-ascii?Q?FkbE6cyITR8vD7KBMZDDlApbVr8jRcntKB6Z8HTtodWoU6uh+HNkuqMEXMRW?=
 =?us-ascii?Q?Mq98ZzTlZdz+lN5WRbJNwVghDra6IeYcl3HswXeDaWSWjFF9dnSPo8MqOVqi?=
 =?us-ascii?Q?8hlSQes5txGTlAhorngRkbxKoBzU5F+OrDHOU4byuxGnCb9ongFMNF7gAXER?=
 =?us-ascii?Q?AQE//ncncmsGohBt5s0jAOqE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1def4b4-22d3-4ce1-36a7-08d8f3f6f5e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:08.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD+Ha63kEv610w3WB6Ak6Z6LSQ8R+m17ogLaaRdBQsyrT+qX7FWo3qyFBr8/uNzKn9tJ1KkDn9j6kXC1yHlAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: 58DRCebx8beg15Fc9awEMrewBao-OJTS
X-Proofpoint-GUID: 58DRCebx8beg15Fc9awEMrewBao-OJTS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new remove_hugetlb_page() routine is designed to remove a hugetlb
page from hugetlbfs processing.  It will remove the page from the active
or free list, update global counters and set the compound page
destructor to NULL so that PageHuge() will return false for the 'page'.
After this call, the 'page' can be treated as a normal compound page or
a collection of base size pages.

remove_hugetlb_page is to be called with the hugetlb_lock held.

Creating this routine and separating functionality is in preparation for
restructuring code to reduce lock hold times.  This commit should not
introduce any changes to functionality.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 67 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8497a3598c86..16beabbbbe49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1331,6 +1331,43 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+/*
+ * Remove hugetlb page from lists, and update dtor so that page appears
+ * as just a compound page.  A reference is held on the page.
+ *
+ * Must be called with hugetlb lock held.
+ */
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	int nid = page_to_nid(page);
+
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		return;
+
+	list_del(&page->lru);
+
+	if (HPageFreed(page)) {
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+		ClearHPageFreed(page);
+	}
+	if (adjust_surplus) {
+		h->surplus_huge_pages--;
+		h->surplus_huge_pages_node[nid]--;
+	}
+
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
+
+	ClearHPageTemporary(page);
+	set_page_refcounted(page);
+	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+
+	h->nr_huge_pages--;
+	h->nr_huge_pages_node[nid]--;
+}
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -1339,8 +1376,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1348,10 +1383,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
-	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
-	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
@@ -1419,15 +1450,12 @@ static void __free_huge_page(struct page *page)
 		h->resv_huge_pages++;
 
 	if (HPageTemporary(page)) {
-		list_del(&page->lru);
-		ClearHPageTemporary(page);
+		remove_hugetlb_page(h, page, false);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
-		list_del(&page->lru);
+		remove_hugetlb_page(h, page, true);
 		update_and_free_page(h, page);
-		h->surplus_huge_pages--;
-		h->surplus_huge_pages_node[nid]--;
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -1712,13 +1740,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 			struct page *page =
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
-			list_del(&page->lru);
-			h->free_huge_pages--;
-			h->free_huge_pages_node[node]--;
-			if (acct_surplus) {
-				h->surplus_huge_pages--;
-				h->surplus_huge_pages_node[node]--;
-			}
+			remove_hugetlb_page(h, page, acct_surplus);
 			update_and_free_page(h, page);
 			ret = 1;
 			break;
@@ -1756,7 +1778,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1787,9 +1808,7 @@ int dissolve_free_huge_page(struct page *page)
 			SetPageHWPoison(page);
 			ClearPageHWPoison(head);
 		}
-		list_del(&head->lru);
-		h->free_huge_pages--;
-		h->free_huge_pages_node[nid]--;
+		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
 		update_and_free_page(h, head);
 		rc = 0;
@@ -2667,10 +2686,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 				return;
 			if (PageHighMem(page))
 				continue;
-			list_del(&page->lru);
+			remove_hugetlb_page(h, page, false);
 			update_and_free_page(h, page);
-			h->free_huge_pages--;
-			h->free_huge_pages_node[page_to_nid(page)]--;
 		}
 	}
 }
-- 
2.30.2

