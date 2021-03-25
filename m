Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0973485E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhCYA37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33922 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbhCYA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0OOMj091690;
        Thu, 25 Mar 2021 00:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=xEcmDoGONJyuiiursH+GNkDrIZRdKSd50fOaTwQBeaQ=;
 b=nL+EHjvowspZ8/2u9eMD0FIr3HTyAD3gWq3tCUQRWpr3AXeWnirYrkDj4L9L8YA91xYU
 BFI5SfN7zCL8h80HtLZbeMMfMkXjvIFJyflHR4OLN7KIjntj3z2sa6gzSBAMhBNHSuRQ
 Gv5gySb0po84o8ICIGNr7/rCUTVe1IV5PYCRelScUzzH37mcDAC+von7O58eBFgRpSns
 oIMIhVSRUNK2egSr0Xlg0sk7DAL3j1+ozug+34NoxXVdzgC40F5EbchOE4KmGR1bevV6
 8t4IZM4Q7Jfni038lDCPsqXoped1qZ/BjgIDOnk5/1RjgGUVSgHlZ+NUusz/77zO+JDD bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbmrs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0Ovoo009237;
        Thu, 25 Mar 2021 00:29:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 37du00hg3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRQgxtxzAY93oa5gOg9AIhgQhDGBaCRDWNw4W/LgitaUQWvs/HKvI8dmI+fjFFZ85qyWLoCIhWHsQUx50Dn5ZzPPZbdNmVNz76fD9g9DYrmz0NsP1Do7aTD69tAtWceJQ22HndLmIcyGyFsJgKpBDmkKLvlIByIS7HOGgVo8tN6oaZDjmY6qGspzeUvtP72O3yrMz0VAsh8UnnExiTpNhWFx/RM6XFZyFcxgv/7iSRbY9yw/vpcO93BP/GE+En5/Vle0m69EYkLOu3mJV6psJ5C+hD5tXL6uY08gNyhvntw0/75uJ9TdjD1ZhvQVgu8YJMT2ktYTtPNv9ST/LWkpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEcmDoGONJyuiiursH+GNkDrIZRdKSd50fOaTwQBeaQ=;
 b=PLA2uLlFhxh9tTN3Jp1bTUIR7mGApsv77+UIQop9AEgYv01eyeqa4eQoYGZbkRR8XTtywGTHsOg2/OfzR9NtL9ksT3/MlykEQXf/nVs1JUd1ri4ze8qE18NyUjO8IdCqOOh/d/X3XLF1O223vzFp/jhTkWjQGdAWm9dg9z+qhGMSTR7Esi9ArGAEpikL/U7j3H0j2MZc6ThPl0iOdRFfgEVWxYzd3QKlRPt4wOyk/+e3S67GN+JNXW3VC7Y5Jmzugm5ywzMb0GtRJ9H2lgUY3N+SB8tGiEDNygenn+0hEBXwXT5VID1UrW5EGnXVM0AHxjo+FLszVhPjhxiU5c5oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEcmDoGONJyuiiursH+GNkDrIZRdKSd50fOaTwQBeaQ=;
 b=KfLQogzQYqnwwweeRPwGW3JrnpZgckbv7KDAuECS7UWueG/CrKui3lhjC+s4lYBNBnETxF15PGN5rfMEJgrvFVwEHzQfUoaMurwFtxW7FgEm7auzCiLmpEU9Gx4CucyxPS3XaE+oQsQpUhkkUrs0yIfRGcNF4aDER/tsDd1jybE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:29:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:29:06 +0000
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Wed, 24 Mar 2021 17:28:33 -0700
Message-Id: <20210325002835.216118-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc42d7b9-8187-473f-15ba-08d8ef24fe17
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4592BFEE8B8326D8190E4E0DE2629@SJ0PR10MB4592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cnD56LAFx44kjTVKSTjCnKnp+DBZ4Q/cT2OXTh+7CKwQW18q+kcrTVTqmPgwm1lHmX97gf73QZuc5+NoDNVnNqwGtJzJ2h9EL52bJYIdJsVwnDMc1QqpKK29w3GUBMdJm//PEVS3krsABRCDm8vJHMqDlVXR8cvWTGa4hzev3UC2mnshM6AT5kdluoZMsIzQtdJtMroZyQbtEuHtHSk4JO0kyO71NnA7GjvGbQae1/HiaEhatTTAs2h9ThNXvzjqPt566+tCPDGld7eU32F+nhja3hjivD2d4A8Tw3AVdva7qWNMi2wAlZ7N6ZFGNkxjiqw260nqtZVxRFFY4Fd646F3p2N+nvaio2gyLyKJElCecI2c1P+OYiRgWlslUPp2DqqW0gNJviM3TXwNW7LU3viggL0x0s3BvISbNNWgL0Vmt1VgOmOdHBnAEEalnGBkBVXC3HKgso51T3dwQHpbhvHUASDcvbo7gllYEPQFQJUIsP8cHCvq+b0QryYT+45+PJUpmitwvSEyhs04JO6pTTWMyuBJe8kfgiOZs5S4gF7o0PkwZM9ncd+TNgvn5UNa8M9WvjwaI1vWlAf4NwtqjCObd9Qw1kakeZyIVbkifkb25Y8WprwDZQnr1g26yiuYTeVztBiWiGMr5uIm4XIKiT71tThqkKTjWFGSy2fgaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(956004)(38100700001)(7696005)(52116002)(5660300002)(6486002)(2616005)(1076003)(316002)(478600001)(44832011)(2906002)(83380400001)(86362001)(8676002)(6666004)(4326008)(107886003)(8936002)(26005)(36756003)(7416002)(66556008)(54906003)(66946007)(16526019)(66476007)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4Cu0vUN8m7QXUIBWA6u7/uciXci99DhPjLCLgvlN+xno2EYUt5aDsxWFQouQ?=
 =?us-ascii?Q?c707WPt7Oae4TRLUWvuX1tuyyhN3NhXUd5eULW/SwLK4VWrX/riMzm+G8JOp?=
 =?us-ascii?Q?ZHeVrYWN7tJlD2KlisLajIXc51sTT9yJThx72aLcAJp9nhVo1IaTf0mWWVtw?=
 =?us-ascii?Q?FmffITps72AVTsBRGfMoEuWJbTeZ5WHM0pvsXcTF9YR/vOvPpjbwyONIMvA5?=
 =?us-ascii?Q?6Xs+zh1Haf7saqdKuqCqEf64QoGX1bPI2BpJfd1RfxRy7Mohyh5WP5za45IM?=
 =?us-ascii?Q?V1pzBkDbjtR88SIR2aB6kdBEReeosUcnzCeLiJ1pS0Kmgl3Tsjc8GoPf3JCv?=
 =?us-ascii?Q?qC234/iOYRgawon8+JoJfPmv9Mk0jZmZkhQE3KCY2ZcaIVlfjOJ+bHwK79V9?=
 =?us-ascii?Q?oUcszPpr2JzTerVmrWW60HTjKiw771JfgR0pDlVnLq0up718vpjFYQ7zGQmw?=
 =?us-ascii?Q?2Y0Dq49oku74ng2sTq1YDhB46CwxG6Kr//iJcpTyMw/oGb9aFUtbC8RmysZo?=
 =?us-ascii?Q?xPH+UypCeyD+QOgRcgLBbzPijh/o4CSN13cnDflKNq/+uW4FyhI/5zfa3WrU?=
 =?us-ascii?Q?BuL45aiRLOQsq7O+ei+mk1OG2BngavcThs5Lx4NCy8rEgOZZ2+mavagJjE3w?=
 =?us-ascii?Q?38soO8S9E3grUoXYjUCfsP5GkchHVm9YzXvmQYW2HnuEuCfUG3Eyd5ThFh+E?=
 =?us-ascii?Q?B0DPT2cUlRQu/f6f+KNVYjaqX/E9kJNZQJJB4SpWSn3ZW2s7FhwK7/mfGat0?=
 =?us-ascii?Q?bM63r7yoOEEsyZtnTuFbFbh+BKdm7cu0l1l6Z3lqBp1oAD2LGrcd2zpkLmta?=
 =?us-ascii?Q?td779LNN+KILD9Sce8ZUDlfhBeA33rQN8HRzUKWzRBw+NQ9xg31Xogd/kKYe?=
 =?us-ascii?Q?HQPwrrtyNTnG9aaL/xt5lpJDfGTRrXOmvICvLZj+jDQCXEoCxr6SueMiXN+g?=
 =?us-ascii?Q?Ifu9M6PHvmyu1UV+DHhzUAENuf93W23zOQ6dOxefFcy1TdiSWJqSgKerI12b?=
 =?us-ascii?Q?AsO+i9EgMgaTYb7ootiLZWFRvGV2I4dqTVMbLKumxMC0zE7K1VBr/prpAplL?=
 =?us-ascii?Q?b9oyVCvS+9jbpJJJ8A7r2en0jcpiQeLvYTJAv1yxeENRlYQdNu7KBdLgQNu3?=
 =?us-ascii?Q?z4jQXu3q+89/sgwrUfK6bQDwDMn6BEFGgNedv6hjFFN9ZDEPF6rk2MkwQeUj?=
 =?us-ascii?Q?CaTc7gLAAjKt9eW1iFKA4tQ2pqsjp1ZKqq14/xYRkIX4/l/1UBMGRk3vjPGr?=
 =?us-ascii?Q?EbgYgMiN4qm6cUbPNxFdxAYR+KqEqyIRxFuJgIQGX1SzH23JucvCXxbRyNxJ?=
 =?us-ascii?Q?H9Ht8moDr262inoMhnt0H9Ct?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc42d7b9-8187-473f-15ba-08d8ef24fe17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:29:03.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXFw/VIQxGIRPP9qdCiHb9IiieXq+WjQxmRVpzAe/Jk9RPEy6uYKQ1IZ6qkMQF7GtIYnb4dpOgANK5T6kwKKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pool_huge_page was called with hugetlb_lock held.  It would remove
a hugetlb page, and then free the corresponding pages to the lower level
allocators such as buddy.  free_pool_huge_page was called in a loop to
remove hugetlb pages and these loops could hold the hugetlb_lock for a
considerable time.

Create new routine remove_pool_huge_page to replace free_pool_huge_page.
remove_pool_huge_page will remove the hugetlb page, and it must be
called with the hugetlb_lock held.  It will return the removed page and
it is the responsibility of the caller to free the page to the lower
level allocators.  The hugetlb_lock is dropped before freeing to these
allocators which results in shorter lock hold times.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 88 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fae7f034d1eb..a9785e73379f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1204,7 +1204,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for free_pool_huge_page() - return the previously saved
+ * helper for remove_pool_huge_page() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -1720,16 +1720,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 }
 
 /*
- * Free huge page from pool from next node to free.
- * Attempt to keep persistent huge pages more or less
- * balanced over allowed nodes.
+ * Remove huge page from pool from next node to free.  Attempt to keep
+ * persistent huge pages more or less balanced over allowed nodes.
+ * This routine only 'removes' the hugetlb page.  The caller must make
+ * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-							 bool acct_surplus)
+static struct page *remove_pool_huge_page(struct hstate *h,
+						nodemask_t *nodes_allowed,
+						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	int ret = 0;
+	struct page *page = NULL;
 
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
@@ -1738,23 +1740,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			struct page *page =
-				list_entry(h->hugepage_freelists[node].next,
+			page = list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
-			/*
-			 * unlock/lock around update_and_free_page is temporary
-			 * and will be removed with subsequent patch.
-			 */
-			spin_unlock(&hugetlb_lock);
-			update_and_free_page(h, page);
-			spin_lock(&hugetlb_lock);
-			ret = 1;
 			break;
 		}
 	}
 
-	return ret;
+	return page;
 }
 
 /*
@@ -2074,17 +2067,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
  *    to the associated reservation map.
  * 2) Free any unused surplus pages that may have been allocated to satisfy
  *    the reservation.  As many as unused_resv_pages may be freed.
- *
- * Called with hugetlb_lock held.  However, the lock could be dropped (and
- * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
- * we must make sure nobody else can claim pages we are in the process of
- * freeing.  Do this by ensuring resv_huge_page always is greater than the
- * number of huge pages we plan to free when dropping the lock.
  */
 static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
+	struct page *page, *t_page;
+	struct list_head page_list;
+
+	/* Uncommit the reservation */
+	h->resv_huge_pages -= unused_resv_pages;
 
 	/* Cannot return gigantic pages currently */
 	if (hstate_is_gigantic(h))
@@ -2101,24 +2093,27 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * free_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_huge_page() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
-	 *
-	 * Note that we decrement resv_huge_pages as we free the pages.  If
-	 * we drop the lock, resv_huge_pages will still be sufficiently large
-	 * to cover subsequent pages we may free.
 	 */
+	INIT_LIST_HEAD(&page_list);
 	while (nr_pages--) {
-		h->resv_huge_pages--;
-		unused_resv_pages--;
-		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
+		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
+		if (!page)
 			goto out;
-		cond_resched_lock(&hugetlb_lock);
+
+		INIT_LIST_HEAD(&page->lru);
+		list_add(&page->lru, &page_list);
 	}
 
 out:
-	/* Fully uncommit the reservation */
-	h->resv_huge_pages -= unused_resv_pages;
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, t_page, &page_list, lru) {
+		list_del(&page->lru);
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
 }
 
 
@@ -2648,6 +2643,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page, *t_page;
+	struct list_head page_list;
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2757,11 +2754,28 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
 	min_count = max(count, min_count);
 	try_to_free_low(h, min_count, nodes_allowed);
+
+	/*
+	 * Collect pages to be removed on list without dropping lock
+	 */
+	INIT_LIST_HEAD(&page_list);
 	while (min_count < persistent_huge_pages(h)) {
-		if (!free_pool_huge_page(h, nodes_allowed, 0))
+		page = remove_pool_huge_page(h, nodes_allowed, 0);
+		if (!page)
 			break;
-		cond_resched_lock(&hugetlb_lock);
+
+		INIT_LIST_HEAD(&page->lru);
+		list_add(&page->lru, &page_list);
 	}
+	/* free the pages after dropping lock */
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, t_page, &page_list, lru) {
+		list_del(&page->lru);
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
+
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
 			break;
-- 
2.30.2

