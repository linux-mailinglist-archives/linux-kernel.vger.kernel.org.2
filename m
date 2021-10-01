Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8241F3B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355566AbhJARyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:54:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355545AbhJARyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:54:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191Gwn7s011112;
        Fri, 1 Oct 2021 17:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=kFzMwKxnbfSGwrvHo+Y//iX48aKR56ZuyLEE1Iabk3w=;
 b=eIC+oLRAzB241hONeu0vbTkhceLLwuk30cUORIGxeIg36pJ/xAyRdVgvxnVkiTaHSssc
 BL784BU2u6mEFgSDrPfydAXJqG1gs8JbaUaquULmjQgfrMV64tmxejnHhGct/jvbywD4
 yJFviv40P0NBM0C+DRdzLRx4sQo8iAkfnzEFlPgRvILJetp2osHvdFNUeE9g1rJHpJ8F
 yAkAHK9lP3ZDhrQekzYe1rQ6mH/6cr6xsEswAgBkOBZT0LTL864Le6TUsUsdU+j04tku
 /65kPdsbmtbK3D30XhyBIzY34dEKmplAp3n4bfMWt7/koL6j9aSTT9KvNjJ4gkLqCxYK 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3chgyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HjJHW123520;
        Fri, 1 Oct 2021 17:52:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3bd5wd0epp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecOlRrjqV+zlP7P2BQ0IOssC4L0ASAlrFeJk2NWKMfQwv96ShIaVXRrZUSg6QTavDxFj3xDVokH+UAQguerdyp8OAF3puV+AYP7vKyytlvJCnkg7Fgng+XgnRaAiJZXeHqmA49WcLuCbjYu0yv4ydwvSeJKhNbVRSeNQF+CzxRwSgc4QzN+CMuA2UyXitxbVRYH2w5TqVt/RBlOGV1Q9TkH31tSbuxZtmmMxfLvDKvawHJq1esLWgXqPYOBHHp7GmlUa29zI+pAClYM+DYYTE6XhtZoDOKg5VZJCKxFPGkJslZKcStJsrGFMXT/35QqIMhiYjrb/EuGDHPA2bTaXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFzMwKxnbfSGwrvHo+Y//iX48aKR56ZuyLEE1Iabk3w=;
 b=WDvoqxRPoo8sgcaQwU+YDvVHarF4kuBUtiF8qcH09FQ9nxbB7YtEvCXEeiwp9zTE++JROQuAG2MocgFqpGGnMeMYf7kNV5wxYVSbLhskTksE2jIwurc3+h/gc5yynZGBsYwCkauhtBMmtGTgkLI43gtffWLYTnJHBsT4LRgsgIhAFDTTM40/HLTUHK4MqXfygYK4Dfv5oUlTKlnL26rhGxM0H4GzdxtCh9eVQMmTZrVq/bQs20MQIi8w3gDwy98v8uxKg/LXnbNipTBTEvS6kt8tkT81H6AOEkNOpV/fip5YBxenrQ2z2XUtEz2Llk0aDXe7Q7V11YeNT6Esrg42lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFzMwKxnbfSGwrvHo+Y//iX48aKR56ZuyLEE1Iabk3w=;
 b=LozMtquc7hNeFnjbk/JIZFPOL8Ww/dvMmjsBvF9ZIyo3kJE77Zyn4cHkE4Q1dPNvProTkhdlONDIPssK4eRfF6Sy51L0vkOsRVeCRi7Wli+3as7vSlLZXuW4a4h3gRtjW964h9lfWS7mFL8wSfAip+7fjClLAkpMyBl8dvcPxOU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:52:39 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:39 +0000
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
Subject: [PATCH v3 4/5] hugetlb: add demote bool to gigantic page routines
Date:   Fri,  1 Oct 2021 10:52:09 -0700
Message-Id: <20211001175210.45968-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001175210.45968-1-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7223aaef-8062-4286-9625-08d985044288
X-MS-TrafficTypeDiagnostic: CH0PR10MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB49241C7018A6E63CB9A2221FE2AB9@CH0PR10MB4924.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x+IJuQ9ibne+f89qQC+0g7Yt+NTeaU6M2xLaCsnlpOhUI2foKqKGnO4/ULFdZu9nwfsyQW7rHPtn0GOQYu4s+45v9Jr7pOt7yo/uK+Masiu587FZJV3M2iDajncsM0VWibYEnMEcusu3/QNOZ7o+iLNt7Elnxi5pHo7vsih9ceFjRf7S0n5rBqXD5Nh4XGPdRr1KZELBJT5PJzDiNVcm3b/eCUaQzXpHgRvz30InNqRbrImvg5smXquEqnYNdFpgZWLVWQjcNxPsn2XTOZ/l1Avk0PomnFiFYFx5pxP43CCHEPWCGqyoI/YsMBpl/7THEAQcXnlLkMZRHiMid7cHNpkbxrSIM9Fbe/t7pS/+FdH0KCoWlRA4kVn+5jZeeAtIk1ghq8lkcePV0HKc9qUA5Ye2OPmcKyRSp+m2i6fq49wIlXBmbal5SV+QBdOOFZNplfdd8/n/yx0BojZTaEucI6mD2QmasHG8do57oGcOJ3mBsUFsYaduUcIig1vDFosd0KUwwTABBH3yfWDbutjoevyjlJZPnu1jEu8CK6tAMKAl0zrdPHy8TigOha7+D6Edk7d07Hhc62kHAkD5w+zlTlSMtpu+NjaEnkPo8kWWUW5usJh9u0P3y7RWa90rzBV7lL3vHO1c/LQFAda2wHXID37vknB5wm+w2aK0VbFCnXtjrzLw20O2KB5WTSVM/5dcrgnQu1YiPeik6mYW/e9Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(8936002)(52116002)(508600001)(5660300002)(6666004)(316002)(66476007)(7696005)(54906003)(83380400001)(107886003)(44832011)(36756003)(4326008)(66556008)(7416002)(2616005)(956004)(2906002)(38100700002)(1076003)(38350700002)(26005)(186003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKD1wozh2EvoHAZZ23ejHjGysfFRo33mOJhYnbW89r8PilHtFcsyZ+Wb+1MR?=
 =?us-ascii?Q?m8/jgnPOsEEEHGPMyG15C4oCiJ40WsUYctxrAkl+j2CoGA0DdrF97HM430BY?=
 =?us-ascii?Q?ppuDCFu8lkQvlfU9J/gd0AGX0TlZ2/QxA1+ikPDR22nLVkzqP8juFSOGtenc?=
 =?us-ascii?Q?nTQ7JvYvSbCXEVD5lFly90uWfU8/yAfA7UiX/WW5UvjQvnzd2DiL9u7phD4V?=
 =?us-ascii?Q?hF0lwaM3/5FkK4keNpmUAzEKhSrz3bnXjyZunKe0fBkGspPQQkwAxmqUx05+?=
 =?us-ascii?Q?X7C2wwpcaYsWTqno69jtAv3oAiJ84FqS9+e5Ek2DAr7xgX5Ywrz/v3BVTY2O?=
 =?us-ascii?Q?XG8Eu55A8SJGVQkhUgjInyp7+ycFYY9ZDBF+XfKT+19TnrZ5Sn6GxkHVoaqL?=
 =?us-ascii?Q?z7lQjly2BCVBPW/ucUWB0NJRszuLwL2icTsDFhkHMe6ythN5EcXreJw/Wqg8?=
 =?us-ascii?Q?1USMdYPIlE6eiwkF8zXeFN18H5sUK5F7IjSasjdbYhOxDPtfKBSzMht9PhTS?=
 =?us-ascii?Q?FLzEXrr0bGuzr118BTbqdD5hHc2kgUruBa96Hwak2EHBC0SvalOkvhtvh4Ax?=
 =?us-ascii?Q?kpU5zwmBiDdONJkJz/kbM2OSQdvIgEFuLCBfwMPtN1h7/G5oW4uJvTSuHCvB?=
 =?us-ascii?Q?dr6AsAkTLzCnNkhvzrsgMLu8C9ozRmxVusnDug2XgVptj/eyP4oP0rVgZtsp?=
 =?us-ascii?Q?uPhgyuXGkS4vygrZeX/PB/4h/JoNvsT7Wk8nR2MKDerkzsYi+NU0sD47OGuC?=
 =?us-ascii?Q?LDyg0Ol/MAz+HLOnk3Gw38gWFgmUF9SWKVwPOmiuGuDhiH4h9NFgfIzYsDoS?=
 =?us-ascii?Q?sKjqsPYQh9PYFXqBA8oWJCYNj2963iQ02mDD4tlS+bRzYW6Ce5XoDjXFHDew?=
 =?us-ascii?Q?mAve2lvhc/uAHXHob0xbVmyeRO9MGu75AacmhibMhefbQ5LBhadClfMtRMf+?=
 =?us-ascii?Q?5SV3XA7oEcEAc0vd12gDtLtZ2g+wVeie3OrVyvnFlFbmTCjs0FZL9d2sYpIF?=
 =?us-ascii?Q?XeHkkp7+zuhrDu7sp7Tr4CNzsWFnTvG5KEYux+/kV9arxa6uhUNZFkzmoaUK?=
 =?us-ascii?Q?vZvH0uiqT9+p93BuWO4TBU9m1Lxm/nKiOCS+vMTr8KhXeQ6slIcqfMy3oVpo?=
 =?us-ascii?Q?YZpfRGXNAyK1pB2iTgoE1VNw8NpEIXtwDnN4/Ekyq7nCy1TySXgY+bMO9oVm?=
 =?us-ascii?Q?o11Qz724nmF82ewFr5zDKGi5pTZSDZXKPcqn8BhACzUWhXUeDGiPQureZU+3?=
 =?us-ascii?Q?A+7uP5IhY8lptmeyvFlUN8xGgNb4z3RDtLoU7zGYPXzo7TJHUz0suEg7jwsi?=
 =?us-ascii?Q?iKlwH/knb8FrFZkTRiaS2fUH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7223aaef-8062-4286-9625-08d985044288
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:39.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE+LPVhnStfAudeB2PTARa4TRQlubN1UmYM0CJJVY6g7/H1RLokpc0Ql3mHpZ9u+LCNgUdcyxueJw8QoPRZwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-GUID: 9zvRoyMiyiuh7WZVX14BSsffpXuv8WG2
X-Proofpoint-ORIG-GUID: 9zvRoyMiyiuh7WZVX14BSsffpXuv8WG2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines remove_hugetlb_page and destroy_compound_gigantic_page
will remove a gigantic page and make the set of base pages ready to be
returned to a lower level allocator.  In the process of doing this, they
make all base pages reference counted.

The routine prep_compound_gigantic_page creates a gigantic page from a
set of base pages.  It assumes that all these base pages are reference
counted.

During demotion, a gigantic page will be split into huge pages of a
smaller size.  This logically involves use of the routines,
remove_hugetlb_page, and destroy_compound_gigantic_page followed by
prep_compound*_page for each smaller huge page.

When pages are reference counted (ref count >= 0), additional
speculative ref counts could be taken.  This could result in errors
while demoting a huge page.  Quite a bit of code would need to be
created to handle all possible issues.

Instead of dealing with the possibility of speculative ref counts, avoid
the possibility by keeping ref counts at zero during the demote process.
Add a boolean 'demote' to the routines remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
boolean is set, the remove and destroy routines will not reference count
pages and the prep routine will not expect reference counted pages.

'*_for_demote' wrappers of the routines will be added in a subsequent
patch where this functionality is used.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a15f6763e8f4..ccbe323c992b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1271,8 +1271,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1284,7 +1284,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1292,6 +1293,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, false);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
@@ -1364,12 +1371,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
 /*
  * Remove hugetlb page from lists, and update dtor so that page appears
- * as just a compound page.  A reference is held on the page.
+ * as just a compound page.
+ *
+ * A reference is held on the page, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
-							bool adjust_surplus)
+static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus,
+							bool demote)
 {
 	int nid = page_to_nid(page);
 
@@ -1407,8 +1417,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * This handles the case where more than one ref is held when and
 	 * after update_and_free_page is called.
+	 *
+	 * In the case of demote we do not ref count the page as it will soon
+	 * be turned into a page of smaller size.
 	 */
-	set_page_refcounted(page);
+	if (!demote)
+		set_page_refcounted(page);
 	if (hstate_is_gigantic(h))
 		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	else
@@ -1418,6 +1432,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, false);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1681,7 +1701,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1719,10 +1740,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * the set of pages can not be converted to a gigantic page.
 		 * The caller who allocated the pages should then discard the
 		 * pages using the appropriate free interface.
+		 *
+		 * In the case of demote, the ref count will be zero.
 		 */
-		if (!page_ref_freeze(p, 1)) {
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
-			goto out_error;
+		if (!demote) {
+			if (!page_ref_freeze(p, 1)) {
+				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+				goto out_error;
+			}
+		} else {
+			VM_BUG_ON_PAGE(page_count(p), p);
 		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1747,6 +1774,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return false;
 }
 
+static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, false);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
-- 
2.31.1

