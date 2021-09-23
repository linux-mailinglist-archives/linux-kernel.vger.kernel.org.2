Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EF4164B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbhIWR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:56:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242660AbhIWRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NHmH4h012795;
        Thu, 23 Sep 2021 17:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gZlwb0fG90xtuqOiVDH4l+3Zw7FgGU7tq10bRf/yJpQ=;
 b=hH4JsUQoJxupbss6WYwdaYyEHXbnhYB6a9rJ4lOott3jQoVTkf36ld5J9+sX0EU39dih
 ABMle3Xl/QRo7o9pbsz4ufSi2aQbMxFLyXA7/RHTRkBA9/jz3LFq6A7zoEijSA/II9Mu
 TB+FeTlvGzMpFhibJmY7IP4lraGzfph8kT8vfImEjSdlvdhqXatuzsec8LUvjTe+oIXY
 W1ibmwXzEwlkazr5tNFPQR5XBnOwxuP9vM0/LpHQ9EwlYm5uhIHSGW89boX66X4w2dTE
 zhw26X+tS07dINTkr25ITbCnV0ddR7qAmScwL4hL/nNuKNPD8OxAw5aE9peSfex+/fVI Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qkrayy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHpO9Y078953;
        Thu, 23 Sep 2021 17:54:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 3b7q5e3pwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyo93/X262Yj8ZmeO7TlWJaK0bFmw3FlwyGa7bfMyumEVDrRefhvp5UgEZ21z6DOsRtDEaohZ4qeFSUxjWChaR0Q2nurDos8yYJAUmKXQ5wlDAlKEpEkGPtUb2T0j704WBvce52vtqboN7KZFLQXJjkBJIm1br1UIrkOFB23DydRMWbzI+l5XFsEEIHOJFJ4HVoU3v9jFTfEQx+tN51ZlDT9CD5pfhFWBtnGmtCh9hCcfKkWfaI2qQtdFtbx5vOAWOB3wnHptMeFbpnzF0If8IguPMhksSce4VZ/V7eQqc6q1JdXC2kggafgGbm8EZY2hTlHupWrcjFZ7HOhm9h40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gZlwb0fG90xtuqOiVDH4l+3Zw7FgGU7tq10bRf/yJpQ=;
 b=oMUj7WiDfBV8K4lL7ytyb9jVxk2xy34rOWMWx4hAZoyuxYJsOZnrjvmxeBIzMbPZaVPwZxKavsUtXbdmJlVtjWZXDu3GxeQW4ZJeqI7w4rVFMorPG72h4/StJVWEJ9Y8XOgCKaHRHYS8TKvrvurf0iRjUjTcwCXaZ98MaMupCqjwIxZXHgcDyrLWHAs5qTZ0nSMektxfTh/evTPnOhxxtEO3Rvw4gEwIuJBZP5X1jDi7RN9LCmM3esJakiQwj5gxkswc7gDwyp3nJa66OK/796gEAijoFdKbUs3LYlNgr4jOOhj2Z/twtN3r9YiwQ9CchDi5txDsdq0Q/P7KxI5uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZlwb0fG90xtuqOiVDH4l+3Zw7FgGU7tq10bRf/yJpQ=;
 b=vxQ6RmTfNk9uimG9MnDEnp56oiY3W181dNncCdUPlqbJDpMQh9HidbIf3z1C7UB1LvDGEP9CHr5NkgIJAez5Np0d8aWnRaaFPm5nBE2Tiid3v7pxH/yEfiFyD68xDP4F6EBeMFu/yYGGU+d8PfRZCw5a+gs6811uRnC5nJ557GU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2998.namprd10.prod.outlook.com (2603:10b6:a03:84::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Thu, 23 Sep
 2021 17:54:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:54:06 +0000
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
Subject: [PATCH v2 3/4] hugetlb: add demote bool to gigantic page routines
Date:   Thu, 23 Sep 2021 10:53:46 -0700
Message-Id: <20210923175347.10727-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923175347.10727-1-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:54:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cbd9b85-fded-4dc8-9e46-08d97ebb231e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB299851DF399268A883103346E2A39@BYAPR10MB2998.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFabla1TbEtv3xEYINlU/CMy+ySRnEaHYUva15o9MI3HRuetbQ5pxOqNRmgzV0efw11HA6//OL15Fn4XqB+lY5X6Jmu9Lwdt6CRoh6+pEpUGnZKdHr2fscNskfd0FwxIbsrSfU5zF6kCBseRMCcS5Ob+zUMAkWvaLtcp760yMAqA700HSIkHt73kngUlAom53pO3qIazULgT4+vbQB4++y7FZN94Lhgfy2FuVW3QGKAkvc8h4Yc18mTxUxt5OS6lYvLKMmZqPS1uPl49vgCgzvFggq3FEwuIQVeawncN+mP3/wbSZNX8NjWbPkpKb5q+SCQTlAy9dsazsXZQEFJlgBqbH+5ahry/1YKYEkY+DVRbniqWmCafx1wjvlxwU2QWSP/24J+gV8b0zcX6U5ILm/IbxnFF8bJuMzMPTvwypQOXGvjeoRaQTLQlA3g5g3UP7PRJyZiGI6GK6maV4QvW/vI0hbTMZfvFHofi/CiRmCRg7rkxz0RJUaMH9XW9MLPLUwO39Ic3CkWEbZuBmedgGrsji148Fx6YYDDwtrs67EPkVbHqOkP0mhHjFnXfhXwFpuJi5aa2hx3lrSUhpbQAeOCsVrfIKiQ6eXSDgO1cThoah1/DrFZ2vBt4t3DITV/QWZ2lxEotb0RUMgwjMwTnvfRVO6nDsAdB2PJF/B65IpfX4jzRHpj20qk/I0Q1DMga3sVRlaDtRAAADfNu107Jlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(2906002)(6666004)(4326008)(38100700002)(52116002)(956004)(8676002)(7696005)(107886003)(186003)(1076003)(83380400001)(508600001)(8936002)(36756003)(66476007)(6486002)(5660300002)(26005)(38350700002)(54906003)(316002)(44832011)(66556008)(66946007)(86362001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgoLC2SbYGBQ1YZX5sIdv3IG89lPLGETktLhgk4f14BhIBXAghxTgq0Rl8AO?=
 =?us-ascii?Q?sTO0X6qpr6eN4ISi8wg7/k1JGVZnCkpCQ0UXXt7UKotORaSb9i2EeQWGCkQw?=
 =?us-ascii?Q?Q7goY0KOs92B7aYN8ihoIdUqb8OPM26IygRG2KgU2hsJZGU2mdhBTBaCEAD5?=
 =?us-ascii?Q?bdWI7t/j4WJNmCJDREtKqdq97wv7sqbWsUlWfZG+ZSYCP6MkJio0Jg35h2nR?=
 =?us-ascii?Q?wfJb4YZg5I5WpYtT24x0MYpiPy7poaqDVoFVCAeVqxtu9G4N7pqqfpXV7bYm?=
 =?us-ascii?Q?TLMiS5y10QunH6NMMcgrF4spo4o1ERftvMuv6/kFmkm4+uF62wxnoN8uwJ71?=
 =?us-ascii?Q?Mq1P0DpVgCnVee6qqBLL+VrjLXQ4IGLrKv8cAlQVISAFx5KFZBreuBpS9gMY?=
 =?us-ascii?Q?h6dEaQhAahs+txcVDZAxw7RJxoppxHmtghVPI/jXuIPW7znthoOg3gcJ7LRT?=
 =?us-ascii?Q?thoCLkVdk4fWlqsa2AEUxSHGlQv7kY/zR5ixwNzCCq5d3Si3NaJrwpQxtgZo?=
 =?us-ascii?Q?UUTZ5mVJPfxU0lg0rMSD8uAdPUFOAF3o8XILOWVQYV3pfBA2d1SFGFdcOqWU?=
 =?us-ascii?Q?T+Prm94lwiRZmK6MghaLU/cp2CH81Va5nU3W/kobo6yp7dTN0JFFPGY5o9N6?=
 =?us-ascii?Q?YYJBpHdYo0KhDNUdZgT81KaTZxpwVmAg/SVeUin7ESQJqSJB7lQiTq4CHuIa?=
 =?us-ascii?Q?8w1vwlPBuYC7kHBthAe+D9NluOjL1veIe5kCXXRpG2KNiFZjXN27ZjhaP/kL?=
 =?us-ascii?Q?Zl09SKpb1Fb77A5TakkHMkAOrO5q7vVKFCY8X1AmW9PzHv8U+fLgG5t9rTIv?=
 =?us-ascii?Q?lKiHo+s1vIUKkHLeMvW4R5zRf6oDP/H1uYuyD3Xfw05zzvdd1qVcEGy3Rr9v?=
 =?us-ascii?Q?t3XeEo4eNdlzxPeSjeYuvDADN2vuN3yHXFLee3fpg/7TRdM14msmMxL17xIs?=
 =?us-ascii?Q?ZUsmcrXamt+59SjcBZk8r4DqijKTGWAsdoc27y5ocqlvY5ceOKv70hAr5YbR?=
 =?us-ascii?Q?9JdD7HKtdxwv05uCyK5cOta7A84jGjtIPIYY5h41ZZy8q4H2IjLIeOd5V1iD?=
 =?us-ascii?Q?fJv6nLbCrxbSKQYA/FJ3pQPWfVQ4ZWgJ4JFo7qW06L1A6mLjzX0ATdDr/6Bz?=
 =?us-ascii?Q?V7BHMTs6hGgkvGbFNVKl3tQ43xV7VFogg3P0xD6BKNNyXXZ2Ua2xWyg/XXPb?=
 =?us-ascii?Q?8XCfsGNB+PEtjKBzGH/kWWcXweoKzmSeFMYA9K9j0E30zk8W19bHRiZ5ZA8h?=
 =?us-ascii?Q?SsdfwCCCqvV+1Yp9rG94qUWoq4PCGc1Efmbg+juq6tK1A2QeYOADtiuom4NV?=
 =?us-ascii?Q?7NAAJDZzxITHn2GJuv5bEXmj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbd9b85-fded-4dc8-9e46-08d97ebb231e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:54:06.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcZ3Zj/1RYh/NKbgbVFW4MBIXK+ALmEXtWyaVNdivg31kyglhWixJ1jUF8ofMKJqNNNXodYOfo0V4hyYm65MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2998
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230107
X-Proofpoint-ORIG-GUID: wEBoui576XMAK-pQKVKbtVj8zwPWunv9
X-Proofpoint-GUID: wEBoui576XMAK-pQKVKbtVj8zwPWunv9
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
index c3f7da8f0c68..2317d411243d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1261,8 +1261,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1274,7 +1274,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1282,6 +1283,12 @@ static void destroy_compound_gigantic_page(struct page *page,
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
 #ifdef CONFIG_CMA
@@ -1354,12 +1361,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
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
 
@@ -1397,8 +1407,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1408,6 +1422,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1679,7 +1699,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1717,10 +1738,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
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
@@ -1745,6 +1772,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
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

