Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6AB3428D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCSWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCSWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMYVBG026034;
        Fri, 19 Mar 2021 22:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=7zLi0DBtPFvGN/R70Qix3ZkOT4iteU2T9DCf5/hbITE=;
 b=BCcmqmo1GO2yLc6iMFLlLWnajsmiQZssFVwyFwg+PCB1QSdnRcMYOQBDfJcat/hfeYBi
 Gsg/uMAmJ5bl+cqWMaWiNBtHuv3ILUvlR3Jdf1SlCNYXqr9K0jmXguICbwLKgWnjGmvN
 gcz8i/Afd+MSFLgPf6Ko3CHgUxH3R9HQMeKzYfD7VpyjFVk5LRrrlW3mo9tDeDjN9emv
 NumJMBZSk1H5W1hbC+ccb2wv8RCv+LkCkcVlDrfWy9Cb6o6c+VloPj0SR8OfvVhrx5Di
 GS2rtDxtjUHKSWYCtE9g4HDNJ5WAZVW1V01bfUbXQqGfjloM9qyUBIjpLvQJYG/965oW 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 378jwbvhm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMdl6B044897;
        Fri, 19 Mar 2021 22:42:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 37cf2ca49n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/QLs2vSRL6vMUJohbj5lIOfcOn4kTYeb73irseb4b4UCAgacfTOqyBwEs0wSuUYy5khtK2+6+XTMmApBMNNMXTmRNOqfCCjE1ubVRts/YpIcEsUz//E4v1CSeUtxmB66XZFQkAveASdoxW2jgOysvw76VQiYo8bhGdEzE4/x+E2e2Od4IXHI0VV9FFEnF0NhjShLiBXiZ60b6QO2+CljmqMYNtaxCReOfOCsFlRzzMhyq+gO+TbKNxlm0dtgd7DNQ27nTjyarazts+hD7mWYyb414ySfB8zA24CNFhpo9nEb1LByHraBxt/b1Tsu4p3oD7PPvNmB+fZL4nDTcMP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zLi0DBtPFvGN/R70Qix3ZkOT4iteU2T9DCf5/hbITE=;
 b=K9dljNJvqjmQAXSTyK2LHj3mdBb7LHVHIM7CwM/JGrDPNOFNUpz2B9w9eXLnpFU2FHoLprZ/+Vn3T3JwTahKgCM8+c1xyBtT2mhSh7cF/DfOqUM1nOSDqag0LiVy7MZgEmU4k0yahQ/phFqkcHLnmG4dNxMPvghO6zSLWUPpnFZRgcquC8t1j+uL3W0wsqIljjeaEQFOl1trST3APLYtvvG+ZrVFUeL00XFvsGXza4sJTQUaYK9l3UBjI4eXSaYvoFhJXYuuKP5iKqQEeKvxi7ksQWxMT/mCljHwpE0pXwpI9CQ3dJpRoSN/X4ZPOCpZhr3PagKaf0y+AqlAFPpt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zLi0DBtPFvGN/R70Qix3ZkOT4iteU2T9DCf5/hbITE=;
 b=Hf+g6QOTeW0HpKUYcJAPkRWJNARC0ol/mmyP3wEuhS6U6iHFZg+9lR3I9CEiiZ+ALpTkvMyw+Uod3FXlNzf4LUaG/YJfLeKJrQKXxE52gBx7q2m/4BM6wn9QuSAQc8YKYSoovRt7S2e9A4AL+XZ7IYQqAgD0mvwTZu1IYFUf/NE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:35 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Fri, 19 Mar 2021 15:42:06 -0700
Message-Id: <20210319224209.150047-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319224209.150047-1-mike.kravetz@oracle.com>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:300:116::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48cec62a-3a2a-4288-ee0f-08d8eb284a43
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31602B81B0A41B97B0B678B2E2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJsubLE/sl2sIAz7koNpW8nyo5u8y9vm0CTTtKkXNwB2XA5VX+2ZUqtuEWNLGH1ckY79lSeHD5QRRD/Sd1a25ptAfzZpUYTwNYldSpzDhJfY+I53k8lbxPu2C792IYoNwfOR5ioeqrTxUhxqas6A6R06dZnHm3aHiP0jAZ5l3ctyfU3lb7hck91uZ5Xtwc23+ZnVd8YksobtS+d1ibKf9DlGdfzbnWrpM6/6dpM0ewlmfeqVi2fD9mTYgrkLDAASGv96mZpto/Dms0cNke5XgH95CRvt/lPc16xBS6nVCiXS2t0wIzd+ljUJ/uOTSkju1M2jR6S4jzHdZwkhW7WH5TuVsAv3vMx9zbG/KhbfQNs4yqRTUUHtoE50xiCRbil5UTU6xpx5f7CbUaT+0pYjP0AWh79Qg0ZVQYGleL7JnyMx/2O15VsopaCo3A0ZXfDFel0IoonOHomg9r0cVa24p22Bd1/Py9x80BMDzmbFMz5Hv4pq/FbCPweb5gvEwNiljSbnujBFEqV/61CAA8pUQZ3uCGsA11Cqmq2Ucms0k69ElSZk6oNoIPTMCDVbarjZ8+YjJXYa9O/16del9xbHiZE8T5fil0NVMm5FVp3YFrye32RITng4HYlGOPnhlAnfKaKMt/8yJ16xWGjXaFwl1qD+ypFrm0A4HthAzQz4PUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HPDtJkCXd5rtV53kAeWu+Vn7eG2rJtuXdrl5rILt2kesyC877VBQmiH3bTHH?=
 =?us-ascii?Q?XtcyVgJ+XSYMoUYgG/kS9YTri5xEhIuKOPm2DUQn6euUMfQZo4q84bq6K6TI?=
 =?us-ascii?Q?Yk2ej0DBsAhlNJ8J9tbIXaRdSpZAq1lGt8qW19ND8F46T1j23HU4Qzhz376Y?=
 =?us-ascii?Q?NNh1/5L1NZ00KUG1g2sBGizOoe+bIm4GNz7cVYoe7eXdY5kEZHsSEkhIFL96?=
 =?us-ascii?Q?C6r8+4Rn5QAhehApkojUgljoJYEDDOAXBF7NvJFiP2lUBmfUlsE16KbEiYs2?=
 =?us-ascii?Q?cYPHf46hzhHuQknOh6q2uYfB+sxmx7UIxLWCdLYOadVTXQlIb89t/erSax3l?=
 =?us-ascii?Q?qbj86Y2DK+7vsw13f0t1D36XV8XEX106BP/1WG9dtCF9zHPpn6zco1awl8i0?=
 =?us-ascii?Q?KBYO7kwUTF1lQmpVKQUJrvRl94XHXvLsFbz2zbCjv1dpJITy4x/ZtfPagHa9?=
 =?us-ascii?Q?XyrHT6vGfN6meyYR9xzgkHAGxR9ehGDvX3Ogtk+3oetmDFQnniQA1y3dSkKm?=
 =?us-ascii?Q?iQhzqz6pCdv0OM5OkE6LS0ZFQzHkpGg89lopWrh4ESwV+dIjRR3rWfTTcAP4?=
 =?us-ascii?Q?pfbDOAVIOeVOZlDPgFDqnP4bMcC3zKbawwKavhdJP0naQqQ+ctCRPpfQZPAC?=
 =?us-ascii?Q?F2ual6iPLe4yYIO6zbXn73p5bclUfvsqPfy3eol+agbu0kMuov++NOEhfn60?=
 =?us-ascii?Q?mI6oGDmunwNHWNf5+c+iCRHcAe69Feh3cawUqM/tSzPOhbBRBc4U1eTVmt+5?=
 =?us-ascii?Q?4e58AVlxZ+ehY2YbLlon6eqmA+rJsN+8+5BP5pkJ6pt5oZw/kWWQbYoXofTj?=
 =?us-ascii?Q?XGrefWzirPGTPTKAJFauBeOykyEOq1rnCksPOoIOeFhat9hDO+TbDAbwwEXq?=
 =?us-ascii?Q?pdyXW1JCw458fQFTfl85FCye15h/x/6QyLp8XE0XwopZCK0rKbSlnhltE5BH?=
 =?us-ascii?Q?HkN7WvlrEU32vdxc56E+7zTAf6NHoT0haw3cIqZ+xjp7wDq0jdnusUoTV/aI?=
 =?us-ascii?Q?T2KGtUu917YdAqjbHrJqGWpseJ761yZAq+ZGmxokBGiXv1rYu9q4uQ0Atc9c?=
 =?us-ascii?Q?UsZjufCI1Jqz99tKaVvI3m34JlLsPi+sNNFwJnBm1PSEN6TrAhKdm5+J7jKF?=
 =?us-ascii?Q?9F84H1XH7hm2r+mFrVM8F0lVuddnnTyw3EATax/9isOPMP4jP/SxC0/Q/5J/?=
 =?us-ascii?Q?8lJG2ACQVmsN6JYNuHIVUPxGsmcwZEeK64ToqLRYXp8COZO5NipvnhS92TQY?=
 =?us-ascii?Q?APiWWztQ7R2kgn3m1v/Tjuknt1s8pnXjOxKVrTbmKhydkwVc8KeFWMC96xUL?=
 =?us-ascii?Q?nFuduJMaNcK+FjCTb7dQqBOK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cec62a-3a2a-4288-ee0f-08d8eb284a43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:35.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faIkNy8ZYBorNmrFqt4QOL3iydYEp3GvLkVpL43aH27nwNj6tNyLeE1hG4kXP+w74z+GIMWY0nvj/NT7jgwa1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
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
 mm/hugetlb.c | 53 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3028cf10d504..f60a24e326c2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1184,7 +1184,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for free_pool_huge_page() - return the previously saved
+ * helper for remove_pool_huge_page() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -1699,16 +1699,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1717,23 +1719,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -2064,6 +2057,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
+	struct page *page;
 
 	/* Cannot return gigantic pages currently */
 	if (hstate_is_gigantic(h))
@@ -2080,7 +2074,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * free_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_huge_page() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
 	 *
 	 * Note that we decrement resv_huge_pages as we free the pages.  If
@@ -2090,9 +2084,15 @@ static void return_unused_surplus_pages(struct hstate *h,
 	while (nr_pages--) {
 		h->resv_huge_pages--;
 		unused_resv_pages--;
-		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
+		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
+		if (!page)
 			goto out;
-		cond_resched_lock(&hugetlb_lock);
+
+		/* Drop lock and free page to buddy as it could sleep */
+		spin_unlock(&hugetlb_lock);
+		update_and_free_page(h, page);
+		cond_resched();
+		spin_lock(&hugetlb_lock);
 	}
 
 out:
@@ -2631,6 +2631,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page;
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2740,9 +2741,15 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	min_count = min_hp_count(h, count);
 	try_to_free_low(h, count, nodes_allowed);
 	while (min_count < persistent_huge_pages(h)) {
-		if (!free_pool_huge_page(h, nodes_allowed, 0))
+		page = remove_pool_huge_page(h, nodes_allowed, 0);
+		if (!page)
 			break;
-		cond_resched_lock(&hugetlb_lock);
+
+		/* Drop lock as free routines may sleep */
+		spin_unlock(&hugetlb_lock);
+		update_and_free_page(h, page);
+		cond_resched();
+		spin_lock(&hugetlb_lock);
 
 		/* Recompute min_count in case hugetlb_lock was dropped */
 		min_count = min_hp_count(h, count);
-- 
2.30.2

