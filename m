Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57DE3428D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhCSWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCSWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMZPjL137221;
        Fri, 19 Mar 2021 22:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=CfnRtUVJM27gw2iz+CQbyD7wcXFAxcVVPvq0KxvEoZ8=;
 b=mDrLJTB8RQl4luYmvHV7SQL/Z2uEPbjBmRpwOs30yEMMr6vOFs1Y5zWaoUJjvwcdECSZ
 19saxJ9kgIK5ABrKHXFQNu7h59ii2kxwTZl0jbsbeqozkVK6EHIZsu+sqQUmFGV+yVqo
 2kgki8XBZPOuS+ZivIoT0ArIQWU/xsmZ+IWlM5uBqJkY0uNx+O/A3OQzvqJ9g2fzGxI9
 fpSqTnIrWuTiMH0Yx4mf0Y0vlEU8qwrVYQWbkafs1yuoVp+uQ5XTo9qiFRWEbo06+khA
 HfqKEMvGSlP9RrbdNXnE3hTT0WtOE2J8E27uGmvHRE0OEH+4KH2p8jZm13GLmjvPWNzU CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1p4dpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMeFA2155350;
        Fri, 19 Mar 2021 22:42:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3797b4sr44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThwQ6SNvGG1QS0QJ5iONj1RxtzMSS8melT3KQrmSHbmPjSP6DobntySJ5i0BDvPKNu8qdNE4kbcUz7hYO5s8CFHRRYXNpRCIFQkpRt1Jhes3OT5P+DOiwSO+2eIhZthvJs5vAOLc0od7l0n0k4yNG+Z3psnIqwuFE64/qhf7aw20pb2JYcQOnLgi6sORnqWRfPfFh14AGMCi9deEkEgqAPpea3n8zLojJnwb077L8mlXs0bq+PQ0jPWgjnpBSEtggtfkvWdDITxOafg5AQpm39LfA1KD/GrjoEFbGc/nMseM7Yomdt2x61FoAgBj6Qixx3m0jwcyPFMMSPR/Po6PnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfnRtUVJM27gw2iz+CQbyD7wcXFAxcVVPvq0KxvEoZ8=;
 b=fapX5zzbwsx+WWx49BPEYG5ed70Kwozw8VtE2yDArVlTcgbS+SX/yg0sKUqjj551npaaWmrt8rzeyT1XRY2lp5shfvArOV/9faBT5FURn84TuKXbeLdzeUvH9zZLPBWXYW0kJcYO0es13cvlNmV+n8FVd74KFsWF9umh5r1cxeUBHnnK3SX3gt6HFAbyQnmqNqztkxjtsnNTUFUKqUr+xAMesnHizi8KeY8qLnZpyLnnM0F340m1gFWFXWgkRiCD47J8wVvyakb6KUCuQas+gKiBpJ72xHDuHmqJ14DRnK3qes6MCLoH3ijziluj3xhc93+obhadaQDYmvdhbbPJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfnRtUVJM27gw2iz+CQbyD7wcXFAxcVVPvq0KxvEoZ8=;
 b=H6eeWzsIeHz47kaQ6dUaoescQiqo5SXoVod/LdApLhXI8WxFp2EYG1XXI4VMJ1ZF70fcCfY2xxsr3ikO3xZXFAOf4M7YJMd5zWZawkWm6WYH97uNDvjRFHDzEkJbUW1EkF6C38fYZptrOIIiPOiAvnJpTT3wRO7pIem3Hp+Pqpc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:30 +0000
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
Subject: [RFC PATCH 3/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Fri, 19 Mar 2021 15:42:04 -0700
Message-Id: <20210319224209.150047-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ab2d41-d998-45b3-4862-08d8eb284780
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31603ACBDE44B38B710C2C01E2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbBxhu6/NfZii0fIOELe+7yTZyBlLpCX+2RzuNGnbu4r9ywITV3c6ytPjkANIMdU+opOQVrUf7jTquv5/YYTkE1ItOOQD1aFJNJL6CukdVyetSc93ssP6mDF9SmrtWsviLfzv2lbYLlS4KNv7NiAxXk1t2sVK0a6QSAtUm2FoXYrtN0iRXAtmeCsxSfZk9Ue5YpIozltuQGAJp/GSow8hh7EoBPmxpmIr5NKiXt2Mi0TZmR1z0Dimnqs5W/IRcB+6PpfsBi6/UTLpJGhRzCdMG9DWonSd0IkYBje2E+QjKZ6Rx8Ke6PRe1HmYKC6pp6zXqJNYJVcA82LMqvR3qBeRzFqA8UwywKiP5AF28hZyBAdibfPOAl4VCe6f/9VL9yioJ8rQTo2/cz69wE+6DWhdkBTJkPV8D0/44GeQFev+9zq+svu90fD+dJi0tVL4wYWRn7I+zONpbbKPfFkN8Mki+h1JqkG/eRORuBeUl1xR64uwEcu+ZEvRq7jkwVPg1KQdKuK5hpcBzZz/z7EbsJvJx0gVPRaGC3/5mxi7Pb2sX9FrL+JkXW3g9E+cpSsDy0Dyx0wCLuKIunmiZKqBL26Krqt1im9ib5VF12lby/YYVlIaj2QMV+lJzKSyJ2EC1zbxkBNPtnW5IqmzEM2NAp3lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kGfIr0TvOHXscYwRTdmu9ikeIDPlemrR4B0tKQoPw+diMb6LDSew5+AxWsNo?=
 =?us-ascii?Q?mwWhqyrjVOyEazYI2Pc54auwAIqBs2drSlctSQPgFloDIzZE8Og43vBhTS47?=
 =?us-ascii?Q?ByRuAlgkpKG9vY69MI6OB+pWgCTPcKKSqtS2PsyhMFthTMAFZ609TU/JEGxH?=
 =?us-ascii?Q?cQ+kIuT9/MhZwbbJ+fyAJDlE6x4puokXJJZAFklUv08dEfnn0T4OreOtcFmD?=
 =?us-ascii?Q?XZ73NQtk8+dVGAZDFOMkmU2bnkQo8BJ63nphaSWQ+6TL0u75eHRg1q6+M93c?=
 =?us-ascii?Q?2Lwdopj7+Yy1jv4Sqi65cFcXrg5Rya2vB0HUH1CgScNZvUZIQ719ZFjd/nKt?=
 =?us-ascii?Q?3slKD62BJ/a1IFJMmGF56xusqjgNHrqsQ9Xe9jMBuCKIp/NQ9aK0cv33z/Ca?=
 =?us-ascii?Q?siW2QH7TLBoA5I9Fj8gdQ4Nqj9A4WvqmyGFn98HIrcUSlLiLx1Kvw+GTSui0?=
 =?us-ascii?Q?W6TDgajkFfDNN8C5yO5addNbVcpSdGk9y0vOzovIbHvV1q1TkJXHywzQocjb?=
 =?us-ascii?Q?ml9L5anqs9iq3MppDw0Sjr35oJlW/vstDEABDYjTU56GZl+qXaSEO0X/KM2a?=
 =?us-ascii?Q?+J8XIjKC6UIEv6QksfpT6J2KJxEoT5m6G7Z+7Zi4wJy2DkCiJP4lk9ah8ppq?=
 =?us-ascii?Q?3nQeGlWIa5MO4KqgfNEqt8iSRLlzb2cBmD82CFeKCgH29wIgDxWZ69xNK4wo?=
 =?us-ascii?Q?2UA9euzPYk3wWANYXPtK4JFpE6m15m1nMAumABklDGV0H8/FXd5N0mlG2DW9?=
 =?us-ascii?Q?2dzsdOSn+M+6rWqiDfM19DzTGarQ2z4A/Uxs5r4xeqdB0Z8ve9pfE0aNXzi2?=
 =?us-ascii?Q?+BR76P68A1U2G0JskyvpRzdcZkcPbmtMMdXcJFS7wdY41eSbRI0ucO7yo5GG?=
 =?us-ascii?Q?XFnlV6FIdgpLtIBpKr8e4ZAwACS6L5Q5tol3IzuoHg733CCNSwc246+NsOlo?=
 =?us-ascii?Q?sOpFdx4sUzXSATfQPj2I7pfcSVjGQjOiijgZVEHJGk6UC1GFyWODhWzWw99i?=
 =?us-ascii?Q?eIxZ4cLIQariwl/sy5rs/XzRUM6+PIGa3Z59KfXXrXDWcIoFFgsKaJG7Cz7c?=
 =?us-ascii?Q?LvtAyCaKbG/2lv2//7BGjdEuasnXFnt8jZN933Q54QEddlvMSg1LCODgqLDA?=
 =?us-ascii?Q?SgFG+fK85efHcvh4Bt6NPufUWC33XAEiZkypckJwn0soTqtyLc/eGgqKrERI?=
 =?us-ascii?Q?KJ3l/tTulb6hWh4PwHhWInfB3M7/jsW3FSsaqu6OGYsVhVkYWCdisnnowu/9?=
 =?us-ascii?Q?Pc7NJIE9yhOjykMSh+G9aaSBRRz5ZjTj5+Pe8GVDK8C3Eyv7Jsckasj1wW7c?=
 =?us-ascii?Q?oTy/bLwRnVWeo3WaZUolEqxp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab2d41-d998-45b3-4862-08d8eb284780
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:30.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzA3Jhr2nrxwALYBuNz7IkB9goMxah+cvcGG11T0/I1GJuOCFnGSJriptlHNtLJRK79FAQJj0JVVMBTLDibooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
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
restructuring code to reduce lock hold times.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c537274c2a38..ae185d3315e0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1306,6 +1306,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+/*
+ * Remove hugetlb page from lists, and update dtor so that page appears
+ * as just a compound page.  A reference is held on the page.
+ * NOTE: hugetlb specific page flags stored in page->private are not
+ *	 automatically cleared.  These flags may be used in routines
+ *	 which operate on the resulting compound page.
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
@@ -1314,8 +1354,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1323,10 +1361,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
-	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
-	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		/*
 		 * Temporarily drop the hugetlb_lock, because
@@ -1400,15 +1434,12 @@ static void __free_huge_page(struct page *page)
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
@@ -1693,13 +1724,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1737,7 +1762,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1768,9 +1792,7 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2547,10 +2569,10 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 				return;
 			if (PageHighMem(page))
 				continue;
-			list_del(&page->lru);
-			update_and_free_page(h, page);
+			remove_hugetlb_page(h, page, false);
 			h->free_huge_pages--;
 			h->free_huge_pages_node[page_to_nid(page)]--;
+			update_and_free_page(h, page);
 
 			/*
 			 * update_and_free_page could have dropped lock so
-- 
2.30.2

