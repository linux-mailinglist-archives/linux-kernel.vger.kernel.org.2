Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC750354916
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhDEXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:03:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37184 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbhDEXDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:03:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Mwvh1004925;
        Mon, 5 Apr 2021 23:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=u6d7WLtJ7GClBEpNkul0k+BxSZweslX8faM0um+cJiI=;
 b=qLgp8+21S5AJF8RE5fv1Y5P7+/hh9nyfXJUxEsHYYqCnAQwLf8pBtMzUf0D4yvZFxAuK
 AxbksRvQ0xvcmXz8/EekuaSqJ71rjOca+O5GkK22m5igN+LeThZhWi6TiJF7u3ga88vu
 cxlbcUm7KJgjVbK1irkA3xpixvEEsvBLPKuCacbuBv43efRc7WJC/zoHEDM/JAndJNTs
 vpxZHN3vJ+M4yVix1u8YIIBbuWijD8Kplv3W1Qomz70HUw+zCB6JwK0sVNyjtYKt6srv
 SUaM59lMW9NynoxiLsTJk3aw2Hdz1sTuMF2gx0M7b2dOTnCW0c3y6NQ1r+LMK9ihWqhn LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37q38mkkb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Msxpd038292;
        Mon, 5 Apr 2021 23:01:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 37q2ptgmm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbBAlpvhJzf6iic13BPvWKUH+RxEqmvSpCIephOs8axKY4S7JAXBJxYnZ40+7xvwkqZ53WsLw/7JH8AUx3MN0YNg6QGqjr3gQAQ/WysvXCSwn2tWqo7VhtK+fmgeumu6TEd41wSv7QPAeFKwBUgVcQGfLfvQdBvqfEDwc48ySXQRakflM/MGfsgOLEY5zpdDUstfJ3MBatB6m9A3FlmRVOb9ioTfTd4mKz62Cbr0F59aM3IPvYguSHkNmOqbbYjaJ93fnpdY3KGXI3u0530V+9k1KE7G0T15AxJCHHdhOoiXEeMYQNzScWKCcSi2yE8wavYwNHyvxGiK7bafgOB4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6d7WLtJ7GClBEpNkul0k+BxSZweslX8faM0um+cJiI=;
 b=KrJYbmOJUqS7WopbxxcCrGIw21JoCMrIPNNyz6dSCdfLTnM3RMnZ2cwXy2ndBJip3aCQ35hPnlwd07eAT5ehYPnLGD9oVbV0kxbEu3WjCyWG9j3KCmMG3oTph3tr8JVe0iQJbSG79MfYCN62I0QG/MaDfpkKhYjKpi3+DxVY/vG60VxZbmRnI+CeKTA74NbhgNNw4qDAfe7dkb5txEBjShynps4edGAknI1nqevd2tb2cqekC5IBfVHghuKlXklUvzUbOWUqFh/dW47PVelO9iOW+rdUJsDBvEPIu9FjRBrvvnizPt2Wm6lMK3A20UTWvm6EN2fh99HiNnPMLI2acA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6d7WLtJ7GClBEpNkul0k+BxSZweslX8faM0um+cJiI=;
 b=q1gnMVfrGcaTxnH22Wo5LwjfkSvDxEpxGBSr1gUpjRMHRvF6XsBrxAyUYaL69a15+cowtgYDqArP5G9YMIQcOtP5vMV4wJ71edJrLsPBSCYkeZir0nYtXOv7MoOOHUmxVAIOYrumZVY5M0vs+yXrHZXj/DI5TIiXRbo5SeIuHGY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:31 +0000
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
Subject: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Mon,  5 Apr 2021 16:00:39 -0700
Message-Id: <20210405230043.182734-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405230043.182734-1-mike.kravetz@oracle.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00019ecc-7411-4732-fd82-08d8f886c00a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB354489BA72FA043EEA674DDEE2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/+sHOgvi40j0pk5/QUdf0Exy3QKYogFQYeSO1hiG1OB1pR91B1t7RZOnD2rlEx5PyGew4nOjhT6mjbGdvLygsAYVRPyN6gxboxnqsQl72CgNA+DIXr8IbyBrfZck/0IrfJ6Ta+LJ+2X0McGLGC97PY0aYFt0qF8vXFVCgTVAZDol/c7pZpbcjF7i8GOMJVTleMwD4fmYR4ULHFZV5B0CG7lgew3IeTMabH/9HAsUXq8e4rR8W6E2JNIWAMQz4JfF19f8qIeNtknSi9Q0VO2VLbSIuByi77K2J2FTmc09t9IrQ0VfLTQU4U4223bAgfvXetP0UdTpzXK0oTSYt+fbEHCpHBNhm+4db1tc660l1f5DjWKDZYqT/dNFPmmkRNsykeNpl2b6z6xp1dzIhLUzY3FATPVoUH9j0UMlZkut5ii9xxpM+q2gZu9LcJun2L4BV7x2xZVcIycrj7ruhVAHex1Lg4GNgd+Tu1oLjj3UbhAc+8mWuUxscdk3TSj7l7Av6Tb//X3zdkKxKtmP037oR8ZNFdvY0uWsRqKO8TePx6zkH/f+aRk0sFX/4y1APL7+YvItVv1EvWx/Dur2A1VLL7XG07NYq7QYDyPcpvDKc8wW234k/eUbLVwy80sscWPV38A4EKZcdbDVFtbmdl7pGd91jmer6d/k87afMDjDX8N86orhd1XAibWFIeZxUHO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(6666004)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/Mpy6+53BEQ27LC/yZPZe8UulK3bOGThAaT4xYMGL6P9vkzGCe7sn/qL4ScR?=
 =?us-ascii?Q?FHGObZ2t9/9hXNCkAUy7CSOjfZP9vO12XsCkVpc6wX8UYhX66aR56SZdRNxm?=
 =?us-ascii?Q?UiD/k5eX9Sns1uq6Disl0tsxt5lVeEuOKpuvVezoMVvL6Fbp+tVoUeJ5FVfT?=
 =?us-ascii?Q?6hsXINU0RFakTcLeQFjvxmD7KkBcPeMp3W7YTWU4wIcOiaRxNRtJdPCTvOKI?=
 =?us-ascii?Q?0nNaZfdhRZeNQwbDE/eFum4gm8ORV7i8AjzQxT8hL3jKedvdL2MnNFwpAL/6?=
 =?us-ascii?Q?ZvbGORG/MIHvQG4NvfAMtFLb2hdQjsjBI8qa6N0kcNplYOoqPNcGr41vvvuw?=
 =?us-ascii?Q?0G2yYnl+9PNjX1KJjns1w5cbpKBrjvkUnDBS4Ts2mkeKMi/3vlOFC2hlXwUK?=
 =?us-ascii?Q?2n426S3zOszhEJ+G8v3iVLhwYt23TrOZ+YkF5WFKa+9LLXnLXycXbWB23n/J?=
 =?us-ascii?Q?AmcaOVNz4sQi6snT9xUtUyAOdTV/WPzAUPGYDjqfEJ5Fcc8u/PaWKGvTeo0a?=
 =?us-ascii?Q?nu5cWzU1gJvzr6kqiDu1zZeo+i1/fnrWJ8lKmGBdokldV86693wlCcrqRHsq?=
 =?us-ascii?Q?uN5nxYxPJ3vkuVGDWJoz8F6tyzNmvAGisfig9O9pIKY+5diFos+VVOHLHpDd?=
 =?us-ascii?Q?1ONM9A9U0YOb+0jOp8mpNeS/0aMnBJVK8vOvYMYiMHAX82RMVLw2zpovOFpz?=
 =?us-ascii?Q?xRp+Pn+PUWuXhgEvKgICJy8jEB8dDkkT+/lOmgZYrmKy5o0TlGS0Dfy61FSL?=
 =?us-ascii?Q?RSmMH/wsIGHpJJKLWCQwRXyi/w473CrbCbl92f4UDbYAdNJbCVt+gPI9Q34B?=
 =?us-ascii?Q?/pDCz2BcrcikeCqgmhODTlVTIRuMOsFFS1ZXg+RRpwAblQEkURh6cmw528mT?=
 =?us-ascii?Q?HnNWTObgKyBpG+l5ka1d5JBewlH8qPxpi0z+VdVw6wcNJ6p4QyrBDdS8Sg2f?=
 =?us-ascii?Q?4cvZOwnF7a+kRYvwiplZGHw8Qs11GPNJTSHM8hCrwSeDcwHOJsWZ3l+50YOi?=
 =?us-ascii?Q?YK2m7JY6gvTudv97UvVXihpipQqsznQPsfg+Cu5Do/Vd5gp5dsc9dxDly5FE?=
 =?us-ascii?Q?pVp1edwPpYRPqoVjyOAkC5K5+oi2llJ58zJ0hri5bq9hKr45B4ECUOCQsUjH?=
 =?us-ascii?Q?t2ruWDcCG8i4QlWoezs8bjeo23KgIpGo2BL/p16Q71kO+bv1oFi0qSDN73Tf?=
 =?us-ascii?Q?IwPFS9NBebZyyAXZRBJwZ+s763mwlzATvGkE+blbPxDItW5Tu1y3ctq5prAl?=
 =?us-ascii?Q?Gan2UEF4Yn6yVo7qCpOGKXGpFCUOYq+tkepuIfssPYw9AeKNTAvex4Wk3SKK?=
 =?us-ascii?Q?TyQEp67a3UZp/Mjp3W0EPGjO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00019ecc-7411-4732-fd82-08d8f886c00a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:31.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ezYx3Pd6VNAiQnNe6WreSh7VoGyYZj1PFiODq5zADCHCTkabqUugWSar4lCNKVya96vDKQUVjdEBbkjEH9Olw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: Anhw9X2tXfRnmDTDmHBcVee3z_rqUne9
X-Proofpoint-ORIG-GUID: Anhw9X2tXfRnmDTDmHBcVee3z_rqUne9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new remove_hugetlb_page() routine is designed to remove a hugetlb
page from hugetlbfs processing.  It will remove the page from the active
or free list, update global counters and set the compound page
destructor to NULL so that PageHuge() will return false for the 'page'.
After this call, the 'page' can be treated as a normal compound page or
a collection of base size pages.

update_and_free_page no longer decrements h->nr_huge_pages{_node} as
this is performed in remove_hugetlb_page.  The only functionality
performed by update_and_free_page is to free the base pages to the lower
level allocators.

update_and_free_page is typically called after remove_hugetlb_page.

remove_hugetlb_page is to be called with the hugetlb_lock held.

Creating this routine and separating functionality is in preparation for
restructuring code to reduce lock hold times.  This commit should not
introduce any changes to functionality.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 88 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8497a3598c86..df2a3d1f632b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1055,18 +1055,13 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
-static void __enqueue_huge_page(struct list_head *list, struct page *page)
-{
-	list_move(&page->lru, list);
-	SetHPageFreed(page);
-}
-
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
-	__enqueue_huge_page(&h->hugepage_freelists[nid], page);
+	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
+	SetHPageFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1331,6 +1326,43 @@ static inline void destroy_compound_gigantic_page(struct page *page,
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
@@ -1339,8 +1371,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1348,10 +1378,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1419,15 +1445,12 @@ static void __free_huge_page(struct page *page)
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
@@ -1712,13 +1735,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1756,7 +1773,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1787,9 +1803,7 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2298,6 +2312,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		/*
 		 * Freed from under us. Drop new_page too.
 		 */
+		remove_hugetlb_page(h, new_page, false);
 		update_and_free_page(h, new_page);
 		goto unlock;
 	} else if (page_count(old_page)) {
@@ -2305,6 +2320,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Someone has grabbed the page, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
 		 */
+		remove_hugetlb_page(h, new_page, false);
 		update_and_free_page(h, new_page);
 		spin_unlock(&hugetlb_lock);
 		if (!isolate_huge_page(old_page, list))
@@ -2323,13 +2339,13 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		/*
 		 * Ok, old_page is still a genuine free hugepage. Replace it
 		 * with the new one.
+		 * Note: h->free_huge_pages{_node} counters are decremented
+		 * in remove_hugetlb_page for old_page and incremented in
+		 * enqueue_huge_page for new page.  Net result is no change.
 		 */
-		list_del(&old_page->lru);
+		remove_hugetlb_page(h, old_page, false);
 		update_and_free_page(h, old_page);
-		/*
-		 * h->free_huge_pages{_node} counters do not need to be updated.
-		 */
-		__enqueue_huge_page(&h->hugepage_freelists[nid], new_page);
+		enqueue_huge_page(h, new_page);
 	}
 unlock:
 	spin_unlock(&hugetlb_lock);
@@ -2667,10 +2683,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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

