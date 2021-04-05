Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45077354914
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhDEXDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:03:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37162 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhDEXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MxSsq005148;
        Mon, 5 Apr 2021 23:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=O/XRvjMbzvSwJzLqEdkFfcbq5xH6n5p5/yyxExTHKcuG8nttQU0v/fHSpICNklsWky9n
 XnUUeAOIIWvKRkYNwo+Us9i0chy6RCKsFJO5Bn8IolOsmhRmmwrvVCixMueRd7xYRO/q
 VUWeY6xHCqFQPRMMiJ95YEGby0G20TAjqRqilfgKHm037PaACJKFYnZ7Cd/fxf3SZd9e
 qv1lK3XxpDmATaMDD+Mii8EPC57N1lt1LgKK55rKNUc8v5wJgUoVHYl0dYYsRCoHZegv
 +Ut2Zu8TRhTjIhw4mDn7p1n2x2CPKmC27M1hb7AjLkgxL7YKAIkziRnahPUxHxuMMyLj cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37q38mkkb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtBJt020353;
        Mon, 5 Apr 2021 23:01:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 37q2pwt11c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCOYGVM7qDQsnvXmMHDAE/DiT55B135GYQuhQD9aS8EQHNSoj8n1wP84J4yvCz3Wbq1iHAkfgI6LQR9UO4IFWhRkz7MMapOE4je4d8J8Jcn5+YJ9OE/geeOeaq+Ee0Ab/GRqopiOVrNvwWnIfI85/CzvrNjbqWL0TBG8yiDRL+3xRP4Mn1ykNfckWgVSCbTgIBVzpxbLB9L8npxebSTS+T4yi9yTC3ZD2urgPReZy2dPQ8idLm4P9cpJOKyj/HcKBLoxYNL1HDM06HlHagMVmCOjouBLuxJUhN33Xy4wszE+zHi50h0znEM+GePgBLGAzpRMmXOn2WpRbqQbkdO6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=fr0i8LERb6DL+biRKZ4p3VeEHvCmaEQtuVpvb45LHolRlwwVjnOxIvWRsrMgM2LG94TH9EtvPKmVo6D3FwlDdloCpXLlRYMu419Td8xoKPsMWMX1+TrYFJwrqBNJBlCseyi+22w1oDfUYfZbPT9VQHx/TViPY/f9bZi2ZZPy78ZvqcM+IK9vW5uXdd9B/JRF1vq8kcxHRyeUR5wDhDFs+I+wmtEWtsAhvmLyw1ypTZQqJ65bufDma+YTpeKGD9F+nfvHKzT6OQP3TAYLTE/hJsaDwLK/VQTcCwkryme6slBHm0AsE6IwmIK0A/e+fZjkz2mtCYpkXJp4acTQhIuB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=Vky81WxyBzPfq5vWHRnQTjR5d88sPE5OK9F1hD0QQZZFbFGgrFCNBevNWqPbwnweF6KxrLZdj57+u+/e98H9NcTYpcTgFxRMuZZ3NlK2VqDdNADPaet0teKHpholnuhbqaVYXyafHPRgq44yeL4/i4k7VOC0DLj+sa9KDwqGxF0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:28 +0000
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
Subject: [PATCH v4 3/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Mon,  5 Apr 2021 16:00:38 -0700
Message-Id: <20210405230043.182734-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630bb9f4-5b6a-441b-8741-08d8f886be86
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB354465FC59BDBE38BBB2E80EE2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wZlFccx04Lvetmi6PijuDNgoRIGEahFT3lhXw4S9mj+4n0R7tBTBhbiqYqbyhcbaaEEuG3XLY7mFNRtjrnQ+XJ1dxvumP7sFKDUnrgM1rh0xfM8Oxg5UX8Dyso7EfUYTJbtFDSq+JfzexCYs82oIAeRZE7LYCTVU5E9UdEhh59Sm+DO3C9ADobsE9irxgSbb1UYFyOkbL1c6sqHubX3SBNLiDLbDaRfUOle37Q58vdIrhjvYl05yXfiXMBDySG60f+0171Ll2TjqhUrFmM88y96H97rDejfzSSTdD2VWEplY9pNouThs/Tv+I685s8MoZIAKcyPzgmDQGY3/9gkgjuhBYvWaeu+uboDg7Y3jCJoNRfWwVU2mfBcCIOW4x8BUMeab3O25hRjz+PVIHctKoPjQez5kGDuJfccFioACAirYG+0us5TrW3Bcd97eOk4dBVyhIOkAhcxCpPwbOT/arw8itbeXdxzIoPDhSAjHciYy+7Fh+2TxZnU+CbF9B5/Nck5gYUCIJGoSSOi00oZ/m+KTVlNUqH+P++MBYr3eAxKeCm1wmBQqYPLeb4Z/nCQzGNvrFB916KnGZ+f0VeQzf7+XX4m0hg2IzLLfO/cgbHZ0ESjd/gu+3vDKuCDDqaMNy/aE5y/Xp59eYO8muZk3PXBC5ZhIYnxVTw+C9bSfWrGD2xWBV9ZpFrVvTfvaG0Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(6666004)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1+DD4bLsEC/X1g+vQOhz958tT9Zm/CK/VpxRGWxq67FAXLjbPwNYuCB+D5JS?=
 =?us-ascii?Q?sG279vhEO5ZeWsghcZvwhSh75TcQlixKuhfHaIJPRqqo9WfG3qFeKh89nlLL?=
 =?us-ascii?Q?6hKXJF6g8oXdYUKGk1IGjYtLJjGkHq36ER4JuizzH9Z3lU3wwLrIxJG4o8fl?=
 =?us-ascii?Q?vEifmnVadmPKsvDxsIiGQiunyPnhfSahsHoE911d88rTya82YMIeSTIqI6a9?=
 =?us-ascii?Q?PgWv73i338PmQmjUBmSRTS2zEtZrJTXxfb6ost3Z8D4+HKLjMUEma1bW709X?=
 =?us-ascii?Q?y1xfLtOkQeQucFp6KgpprdhYqN6tIDXTWKIL5hlbpBkG27g4bbZtjAonJSCB?=
 =?us-ascii?Q?mtw1FTB37aORq2GAaK2WqlpbZ+591rZiLEbO5mSd84cWlwpQ1mD9SYImBMkM?=
 =?us-ascii?Q?e/fvF3KoFibvElG6RVeHm3VsvmP8M2330HY3TQ7URiz+V3c54LrmBr6VTOAU?=
 =?us-ascii?Q?hCOmzI1JHbHNYbYySRWYsDY1V5Ub1ny0KPxX5g1rmV5x108bH97gsJT0pH+J?=
 =?us-ascii?Q?Nk+ULgYCoAEJxeKwHorS+tn+BTJ2HwIMFpigCfJVYeuNRTSEc3pay2flmEdr?=
 =?us-ascii?Q?rQq5PoRpQWkDIMsj6xDcViuBewWr+x+1tnwiaZSlkS3yQ0FeKw8caX60sIvD?=
 =?us-ascii?Q?bBXaHPoQiZcf3VcxwBLlQGe31mopZfNlqDAO8S0znL+9NSpdEgS5rQ0ttT34?=
 =?us-ascii?Q?nfSAm3mYb23FHv/zo8MAL5WA/SA7CSpjxuzqZMlQ2GX0zgvJQw4HI+ltvFxc?=
 =?us-ascii?Q?YbLAG0oKjZFouScr0k6QFbRrHQ2loqrMTDwk/vyJFpoYIht4fa3LSAh+48Rh?=
 =?us-ascii?Q?20NaUwsd/nt4AKUfpxQBLVCcCC2lw4wMURs3EQ00AEdgEXgQbqwnnl4gwRZb?=
 =?us-ascii?Q?QO4HujWAQifrDT2wS4BFjBINDz8Th7pbh0QGRwH20jClXbIZLkdHJYlzhKNh?=
 =?us-ascii?Q?EzzIuzQN/cTH9273ONqP9gampNj7e9GoEbkNm9ckGDwFIV6S5d+7KHnS/ASY?=
 =?us-ascii?Q?nbISkHpdmy2A0Jxa5nxO8x+hKsiyTw6wOuKOzyEjrKgMyNQNLOouYFYMzE1+?=
 =?us-ascii?Q?TUlHRErw4753Ks/7JExtQinJl3uhK9Z9jXqk8YrxqKntHmvPvQNo3Opsl4Qj?=
 =?us-ascii?Q?lbu66WKEVAESBMHHsmh6f6Mb5q1Qg4x71Hb3bkeiXacgoRU45XAlG0Pw28I8?=
 =?us-ascii?Q?F/0BjDEMHvoN/hHCR2UP4qQKGd7d7L7N/TiL0uI0qQnn6KJI/jgVWjETAS75?=
 =?us-ascii?Q?ffaPune7I2x95k0atwsQAn4nFBhLA2CFG/Rb+tABBJU3w2WjdUoOZqTLSjcq?=
 =?us-ascii?Q?7K8PWyeQDG7jSXLBoX/3k7A9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630bb9f4-5b6a-441b-8741-08d8f886be86
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:28.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1Yj43KlRK+Q0WPh6xjsxbcuZsatxwrY/1pmfiLZwxcinqrtp8Gk80YI+fU5KlSidEOvVIUlmCosPs8XBWlhxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: LM4wrkCTCJTbQIi_vM2T_y-vUYRofiGK
X-Proofpoint-ORIG-GUID: LM4wrkCTCJTbQIi_vM2T_y-vUYRofiGK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper routine hstate_next_node_to_alloc accesses and modifies the
hstate variable next_nid_to_alloc.  The helper is used by the routines
alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
called with hugetlb_lock held.  However, alloc_pool_huge_page can not
be called with the hugetlb lock held as it will call the page allocator.
Two instances of alloc_pool_huge_page could be run in parallel or
alloc_pool_huge_page could run in parallel with adjust_pool_surplus
which may result in the variable next_nid_to_alloc becoming invalid
for the caller and pages being allocated on the wrong node.

Both alloc_pool_huge_page and adjust_pool_surplus are only called from
the routine set_max_huge_pages after boot.  set_max_huge_pages is only
called as the reusult of a user writing to the proc/sysfs nr_hugepages,
or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.

It makes little sense to allow multiple adjustment to the number of
hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
allow one hugetlb page adjustment at a time.  This will synchronize
modifications to the next_nid_to_alloc variable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d9b78e82652f..b92f25ccef58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
+	struct mutex resize_lock;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1d62f0492e7b..8497a3598c86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2730,6 +2730,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/*
+	 * resize_lock mutex prevents concurrent adjustments to number of
+	 * pages in hstate via the proc/sysfs interfaces.
+	 */
+	mutex_lock(&h->resize_lock);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2762,6 +2767,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2836,6 +2842,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3323,6 +3330,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->resize_lock);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

