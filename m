Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712734DC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC2XZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhC2XZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNK47a086557;
        Mon, 29 Mar 2021 23:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=byxtiIA7N4E8ZgTCCVitoLstpHZXHHyvttpRxw/0DsA=;
 b=QaJQn0l5xaVAKYLS8AscpDTiVUQKMkjHcEweiNgexMU0emTclBB+kg1SO+SM3Q8iIbOo
 DjYrnP8l1ORbfKO98t6ZQ1/FtB+q7lwLEaoMWtKhz/rNhRpnzgs+Ir+8tmUFMo4xS698
 S9k1rU1DGfZED27JSQ42EWTSEROZOS9dzKnyAW67F5UkSSE2c7JXJZfic4Zk8hXBfcEu
 K2zOtZiBqO+FLzGugbWA3C8IJOXHaYUluavjGdsoSGkeBU5F8YhmNJdK2u5BNQ8PgZ+g
 c3YJqmhRN2TxNsjpRuQMOHTslmfAr97mzBR1PXiqz9ySyaY2viHhkFS7JuyuTDpw1xCF zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37hv4r57u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFQM7068058;
        Mon, 29 Mar 2021 23:24:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 37jemwc71w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWwB3+valbwQ+cv6sBDcyutGCaKEF0iufGbmsx1Ii6Xm0FlDiOIzistaHzmu8Ms+VRScHQOG/oYDTOVXNMGzT0RKg6QhcwKyZXtlJD6nYpD5hb80zgETqCXBX2iFLo01vkE5EGt+bpeB79ct19eiIl9ghI3n3pBvU4Y1/OWbFQ1EpOokFKgs6L5QgXZle9KnVjH5zVqtkr6lZomQQ5Em5np/N5De6fX9y8axygbE6btbYfjgA889sGg9awLY5QwIC+M/cpsIPWjSkfgKLU511dS97lZ0ZpTAo3N4aAd9+FQyQjBkIWAr11o6MmasUR6oRfJyhEFX+YFqypWGbsgh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byxtiIA7N4E8ZgTCCVitoLstpHZXHHyvttpRxw/0DsA=;
 b=ecHhotRFy3sgB7YN8MPBj/TVt/C6tOEt+cr3nINBUKNsD+VKljUpSckl1E+2ztYTAESFtwwWgj7sa4OlxymvhLozO43QedbCtOObmBbN6sGtH/umvPcvlXO3VEQGZTbS3YdZgSWAqxovfKE8ASMzbmJ0x8Pej3Phcvj+eBahd6+z0VKafiQjwkbBkIPEm/YrebbM5M/PNQaj2VrnatbtRjb899tIGTWyG9tY+YxqVwffKBEy5aUBXtxaeufxVL+EzPxXDoeNVAfBs9gDE3PrwR8rbJAjDRf+PZuLn33pVmAbCxFPQlQTWwAYf0Z28ypJUbFjgxoRyCTeX+FIRTz0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byxtiIA7N4E8ZgTCCVitoLstpHZXHHyvttpRxw/0DsA=;
 b=qMseT1E6HexR/Hccsbuyr6AsTl6ILfcqTEg4gnjXdK8LCGhLptr+h9S25nOHxKKq45n/sxoKc8SPnsodJycqn4+vYsBEKAjos8RppedZQC22aMPY3tAEic1pEZpMY93uD2fAbtHTr+MhPx5u1gRCng+9Kk4WwHRTFQKvwjTsWYY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:29 +0000
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
Subject: [PATCH v2 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Mon, 29 Mar 2021 16:24:00 -0700
Message-Id: <20210329232402.575396-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329232402.575396-1-mike.kravetz@oracle.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 021dc397-3916-40c9-801b-08d8f309cd07
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41481B1F7318D0E522C74A2AE27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLoECzoce3FX7MTnSmtwDEsNnnAeWxiybjmUbRrl8CHf4536AzeF94wBsQHvvQ+rEIkeM7dXslUewuik/1MH/Jq/cA7tDlR7VOA40zeb8p93jHFjiGU7eJLyBuO9KkMNZcf1PqkMUKhKErSGZuzmNck/8GizTjlcaxUcO5USi3DhyBcu6lU2PlGtFkHG4tmxHnIE0iBkPszBfLiqRkhAlHLBpuhTi7dStK2II05TX9/afgf25PaeEqn2AbRO2N8V53/out2AJUxqB7Xgsv5zRRBFJAGJrJs9XQG0gz1VB1XXWk8B3FRRVOA274VWaShVstCjxVtj2z6j3JSvTwa46WBy5M5sAjs0hgeo2AC3Zg7l8kSfHr9reCQaqlEaS3u28uSj2QFuXfAlx/sQr7CcG1HZ1O4RVGR5rtL1YUHdhSshwdOBHAu9WyJGue+QCOXBMq00ZIyoPFHH72soJSOCiV+mrbSmbRrPyqqcs+KpyC3XjjVmcf8qzyo0w9qUDtHr/RlNAE6PgV4JfUZDcxJmGjRXbO+F3tDAyoFFWvu32e9SKFEGzI/elRbmygEC2SHcXXz/LWOgnHdm/2xEE/KWg2FofwdGp0iPh8SP5EWfw8wE+ZKvjw3qlKuI8lr1t705830omBwyePYVgu0eD01MKF9nMECrOOBG7LgJoDEFwz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MLMkdxZeZ8X/jmN1YNH8DsLI5VOc74D19agLjnZHshPlePTuEbuuPCCOM0Lm?=
 =?us-ascii?Q?HyqY/WbL2PMc84EB+u+MlQSKbsj1SLFr7Rz2QCN/0FIQU4MR4If/FVRHICZu?=
 =?us-ascii?Q?79q4J4dU7llV0NQcuOi50RBNjpQTSglv5nFDSnpZTYlfscRSBfIUOsy4pYGB?=
 =?us-ascii?Q?lFRnc0v4qlCHmk5m01vPvRI2Menkonk+9YQqyx/DJ7p2Yp0sO6tmJJ0DnV7I?=
 =?us-ascii?Q?huf6UiQsfg9xuHUkCGVXRLfHIgd2+Ce/Q+ky1Hg/8wlryy82R7qagPM03hK+?=
 =?us-ascii?Q?yAZ78rCntCss5rIp20MWYOuoOVkXPil2IjlvRK/5zE9yh+VBmgKAyC9ZOmkW?=
 =?us-ascii?Q?5mPYz20eZC4XMccGzZsrXPuX6IFbkwULLzeqibdkDYx4RLngSOMWvCKPtgjp?=
 =?us-ascii?Q?YbIU19kq8mE/5GmC2AxDHnmEtbi460QGH972D10i9rQ8iKOV50IiGh4nTyjQ?=
 =?us-ascii?Q?5fHXKy4g/anFYZO3k4h1rr+MDJdmRUjUymr+wdggcxZnfXONepyNV2iuhPHO?=
 =?us-ascii?Q?UbohxZ9tS7rhJxz6nn4JzjhsITeF0Ksr2HUBTHj6BUv0SB8vjEphiMHayOc2?=
 =?us-ascii?Q?Ep+ceWDlhEoEiuuydXrUWSomKalVjqLAMPJmn9+3nAy8/3JGednt9GAKch6x?=
 =?us-ascii?Q?5VIDMEOVq8E6z+VJ+sxAq5Sac3zCauWHmGL2e3FP4Phc0kdawSi0Xgf6fvEq?=
 =?us-ascii?Q?kC1ri95iAeaHWVmit8/hH1AD9aCJPXx5//Ftwe1ZC9WeQd7Q2CpBzV+5uJ04?=
 =?us-ascii?Q?qLcdEJ+F/4lPB+PE8xGIdGeOge6ttnLZKIWPLhSiJnyvs2QYhn+POuGWsJ/T?=
 =?us-ascii?Q?Flv/4TB/wDAmk4w95UqJzPIYXLcDRnd49SVSC0CZPUCk0Q5eec90gKCWby1V?=
 =?us-ascii?Q?qNqwUZ4b3s2GY9YLv2U6XhDH/W1uaXURcWBl1U74Z7OsYj8HEViQMwnN5rrF?=
 =?us-ascii?Q?JWotT78Ik4aj0neE5Az3p0Nx4j6GcHQa6fwQwEX1IL/r2AqwHCqOU1ljty59?=
 =?us-ascii?Q?Z3o3ndiQLCIXrXRVVH4uuq7lfY+lJh1DpViXl4a3vQTRJYkOX9gd/tzEFt93?=
 =?us-ascii?Q?XKcrfDDtxx0vvKJdj1KUep76cp3/GgxmqLiBEe2P3JBMKlRHZS6Dqvkge1k9?=
 =?us-ascii?Q?JW9E/rw3ZuhHVmEBePt3rlVctNsfXpWGuwJueMmgVmBI9l4svn8wFiNXUq5V?=
 =?us-ascii?Q?agnRBhQPqf94faCEYmSofWzh9KrfCiDZS0MQq0wYfST6YFJBvDnPinpFJw7a?=
 =?us-ascii?Q?vySYUzqwrGkj73UB5pVIDHIWJL8CmvNK7ISELjrC8sJpcE53jCs+FX69rG3l?=
 =?us-ascii?Q?2L9lvj+Gmp88Bdevz5diG7Zh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021dc397-3916-40c9-801b-08d8f309cd07
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:29.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emUCToP1l+7f6BZlNK2WuZrDkH8BbY8k5gN8sigNsUcoi5DPdHtQnNzM0I685xNbJ6jf7J/utOMgjpDtBbmcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-ORIG-GUID: u8R7d3aIXj96LdvK2uAYjyAdZ-QXfT-8
X-Proofpoint-GUID: u8R7d3aIXj96LdvK2uAYjyAdZ-QXfT-8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
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

Add new helper routine to call update_and_free_page for a list of pages.

Note: Some changes to the routine return_unused_surplus_pages are in
need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
race when freeing surplus pages") modified this routine to address a
race which could occur when dropping the hugetlb_lock in the loop that
removes pool pages.  Accounting changes introduced in that commit were
subtle and took some thought to understand.  This commit removes the
cond_resched_lock() and the potential race.  Therefore, remove the
subtle code and restore the more straight forward accounting effectively
reverting the commit.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 95 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dec7bd0dc63d..d3f3cb8766b8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1209,7 +1209,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for free_pool_huge_page() - return the previously saved
+ * helper for remove_pool_huge_page() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -1391,6 +1391,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+{
+	struct page *page, *t_page;
+
+	list_for_each_entry_safe(page, t_page, list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+}
+
 struct hstate *size_to_hstate(unsigned long size)
 {
 	struct hstate *h;
@@ -1721,16 +1731,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1739,23 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -2075,17 +2078,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
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
+	struct page *page;
+	LIST_HEAD(page_list);
+
+	/* Uncommit the reservation */
+	h->resv_huge_pages -= unused_resv_pages;
 
 	/* Cannot return gigantic pages currently */
 	if (hstate_is_gigantic(h))
@@ -2102,24 +2104,22 @@ static void return_unused_surplus_pages(struct hstate *h,
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
+		list_add(&page->lru, &page_list);
 	}
 
 out:
-	/* Fully uncommit the reservation */
-	h->resv_huge_pages -= unused_resv_pages;
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
 }
 
 
@@ -2683,7 +2683,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
-	struct page *page, *next;
 	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
@@ -2694,6 +2693,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 */
 	INIT_LIST_HEAD(&page_list);
 	for_each_node_mask(i, *nodes_allowed) {
+		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
@@ -2707,10 +2707,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 
 out:
 	spin_unlock(&hugetlb_lock);
-	list_for_each_entry_safe(page, next, &page_list, lru) {
-		update_and_free_page(h, page);
-		cond_resched();
-	}
+	update_and_free_pages_bulk(h, &page_list);
 	spin_lock(&hugetlb_lock);
 }
 #else
@@ -2757,6 +2754,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page;
+	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2869,11 +2868,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
+		list_add(&page->lru, &page_list);
 	}
+	/* free the pages after dropping lock */
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
+
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
 			break;
-- 
2.30.2

