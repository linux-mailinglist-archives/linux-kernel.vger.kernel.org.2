Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909C6354915
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbhDEXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:03:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44300 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbhDEXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:03:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MxKqT191525;
        Mon, 5 Apr 2021 23:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=afCUay6aDA1HVi46U0n4bQgnXO/c96gibkJTrCcAfaA=;
 b=E42zgQ+N9kcnDU/ruYrAlIgSR5ATGMMUBnnoyIdbu5w9NloeHRfTn5ryrnNZt8fDj3eq
 J47jJE58bv/jX1KIiHpkGE2HgGrDjO1rkWQELc7UNffw6ZxzVcCHIkacr+a+OXn8RZts
 8ECX1w3v3UcuSJ2cc7PnFvzzCI2/Ygh1KZ5AsC3bb+1ynws9PXK/o1Ktdb/qdTZz0A9z
 4Me75aJIg30/PhIinoz+dodNXZtQeyQSJzMzDwfGCoo4AWos+OJsACvoWeSKhKavhUK/
 XlsFn7r1+ZJPtRdIPjBrCzGbGLfwR2GOdcpgcf4qEh2oWQviv+Xl9drGkAzZkx3cTlsD 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37q3f2bkn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtBZa020545;
        Mon, 5 Apr 2021 23:01:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 37q2pwt0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwipTAEmJ0Qst+KK8ZAU9ub+ERWLEFDO/+UC937Lec9lDHo5geVtKapYyDWCpuIxoQkco25Z5fDXDsQZAzL4S6eig5hw9PFGEbe9KjSiqnYrfoSuCUBdF5zbslfd7O/KR5ZYnRek84g5y/w2uOcJ2ogZJxA0gbrbKBCout3qvxLUM67VXRRB2ps5OcTBbYD3GvhBYmi9vX+oKCbYQMNxdlwqrbKIWDwnex1HNEJBB6Kex5yKQXfaK9QzAwMfnf79s+cuSPntlzNTyqcfBv9tKRMQrw9DlnGoPBHD4mzC+2AtQ+qWF9lJ8d+4j8sSFMWTrBNkNti2I3/Zo6M6lXWnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afCUay6aDA1HVi46U0n4bQgnXO/c96gibkJTrCcAfaA=;
 b=RY828NNuWh/UzkJvEY8egszw1OyETPxhxruQ5sxeG383lPPJoDAcd6ScW2mZiBck+wevVeOEChtc5tBShb+ZWW0UeoQAnW79QFLaktoTp/SiZYCPYgzitqb0sQszym3MyHAaudsoBY89jvaiwP4mI97dLLAkRWslXglV409Pckz0fkbJ2FvTA+7jh2ip4L8iMg+RwmFHLS52RIJaDDp68ebesTwGacj2o4d7CDQR3MtpCSbfERe5mAu2b5M86NYS6mPIyW3NlBFylVoBJ9w8h+sa8jx9fr2BD6uQtsqojxi64lRdC6L9cR/uJi10vcpuOfylo0/Mk4gQWEUeBLsH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afCUay6aDA1HVi46U0n4bQgnXO/c96gibkJTrCcAfaA=;
 b=fMCCpHz6yxZf2Wg3rOQ7v/WPPsFoSq9DN1deD+GRA7ic8mNuIdg1gcX0t1Y1/QaWgMlaNXtNI3u1GslV7o1y3JO8pWmGbfLicW8XXfxfzOnhOtNOvB7Q8TVHqj0WNQRmWeWiaJfSpbJSqDdg8d7jk+BYHg3pRTT4balsVFHSs1g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5424.namprd10.prod.outlook.com (2603:10b6:a03:3bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 23:01:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:21 +0000
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
Subject: [PATCH v4 1/8] mm/cma: change cma mutex to irq safe spinlock
Date:   Mon,  5 Apr 2021 16:00:36 -0700
Message-Id: <20210405230043.182734-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e65f73-890b-438b-3a2a-08d8f886b9e0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5424242B5A9AFAE6BD7D93E6E2779@SJ0PR10MB5424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyq5xlZS/N0GDE1HJQskH9F3iISArqNd8Wiqe4tHzEQMgboUEGNsA3edEK6XczIwsphrYnuZu4zEx0ZyJs3/PiNyU6NZ0/+mKKR96MfvbJPklOVQycbT7OYgwEZbTMdSOvGapfXvL2WQLOaYkW//hUw8uy1xI4Zxl4Ty7BWFvD81HrqTwtxm+3RK+OZOxKDCWKfvIh3goczn5PQY4i7vZsrvw4L1gfbvdfuwSeKzWs29SANYctPYlYH0hkw/V/CSZt6Po0KV8xm00Xv6ELg4AGjhnkcIQQPk10X4q6kLOlxTgDcxGUP2wSZhUTgn1CSzRDy7Yvvq/6y+RU+5XIS/XNgq22ATSRLTkvna+lXKyPSmkCsQAj2eKJ/CZAz2h04V37u6N9dKCFCwVld+3ZtIw8PLka2G252L/bXaH0O4r6vD9lwAwqo0QQQAsCLIY7wnCmSqCXVpkCq2U/zLFD595Fn0EYigy2r7NBle+80nNbXImHjUiwWnmL8uEMHpM4Ay6yIWsvZyNcWL3lFA2jQmFN04xtzOP3HHYZY6zUATaw81xjLVPXMfmo6TeiolOiLZ+5bN7AiFvtVKuBBUbGur/kCuG8kR0Ek7AlD8TdQWjSmJ94o+igG863xtZtikykTEjl311aPAY8lxfyZfx33D3/QkjUhwOCmqIyzgomGCMXaArTEAkn8MqDHRWHg0WOvm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(66556008)(478600001)(66476007)(6486002)(66946007)(8936002)(52116002)(316002)(54906003)(7416002)(38350700001)(83380400001)(7696005)(8676002)(1076003)(107886003)(956004)(186003)(2906002)(26005)(86362001)(6666004)(38100700001)(5660300002)(44832011)(16526019)(4326008)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VcJ52AaC7yetz9arMy4yYWovaK+yNeuVOeL6NN5HzMVhC6jXAiIPJpqDqetJ?=
 =?us-ascii?Q?JX4311fOymSF3WajhPE3+6J0AgFlWekqeYaTlEeiJoW+fBU1BatZWSecsZhP?=
 =?us-ascii?Q?aGzkPYFcc23YYqRqUMEDw1UoYfnjz+riCQxfVFrdz61I/XXlo6Cf/7zvzTw5?=
 =?us-ascii?Q?8eoLWbIi2T7IzNP/kn+v9KwMODcttAmTgn02Lm3qjloHwLkGO7DJtv6LX5g5?=
 =?us-ascii?Q?cOvhqaKmwRGDRBApYNtl+jcVUwnlQMji535xZ4BYwDgWqORg9JNxmEaAWyUZ?=
 =?us-ascii?Q?eK5LdgEWH+RYJs/5B+yxXUKihs6EzHnB5S4DCpPOgIkk5pKTkVo6mcFcmAtU?=
 =?us-ascii?Q?+L3IokQW+3lpey1Jd3VqwIfW8365jBVMqJgp6wXrVeTsvkiLQkNgJmTN5UXw?=
 =?us-ascii?Q?ChBKQmWjbRWq+xnhaUtzBVB4euLPoo1J2xUDHyLmY6SjYLplOryg9LZkEpuG?=
 =?us-ascii?Q?6Uh9c/OkNFogh/R4VCqj1n/MPZIHS8oVTq/eLQ1ra6svDpEcBPRSbHb363uY?=
 =?us-ascii?Q?x8xyypdB4ivzfwcNpCH9pkLlW4lFGRjNeOm+sFbdxGFO27Vf9F7bRsuSKdpP?=
 =?us-ascii?Q?XH+8hnnXWtqXjoYWdhmuULAHRHPm8L0dDm7u4uqeVDTL8PTUhNKMQ0bnP+CR?=
 =?us-ascii?Q?GCUo7oTr+5adQ8Meu7BIvVgAoAdbpf6BEPs18SqgN7xSHTtCR1SM0Touexri?=
 =?us-ascii?Q?xOIP04unNywkPRi11+BccAu7Ms0HEZLC3b3muUwr+97rOwL63dPuZgWNh4Bz?=
 =?us-ascii?Q?kfWKBbIauhMs7xZpYEThHNKNgD37G0kK0P5SJZsiu5BN6gD0u/ZH8o5Iub56?=
 =?us-ascii?Q?eLO1secN/8O0DOvpNyRNoPSQ8L9jPOMgRbNhbGYydZBQnoBc5aTN/lRhT1JC?=
 =?us-ascii?Q?glpDjFRgf+TVAPCInDeJynJ0zKOa9xUdZW7YdWgrDgyo/p2BmBbctP75pJer?=
 =?us-ascii?Q?LjcbTRPgtnvJs9n9bZoy7YncPVVBi4xh7X+M5Ih18kGxa1ZVP/8rZhkx/yHC?=
 =?us-ascii?Q?Gc9wJMspqLX1TQWK+CpPqc3qp5Bn3xz6hAIa5M9P7AdbAVdZTFn4mmYPnyU7?=
 =?us-ascii?Q?+kD+aeAXglKXWI+6KKN8LeUI08mNO/X3O5nRH4aAD3R3ybAocho40Mlze1+d?=
 =?us-ascii?Q?QnMW8ySi4dJfkv6wTyURBpmPk5u9mij/AUm7MCfhs+QizaWdBmPX7sCaMtVL?=
 =?us-ascii?Q?kpZ/vibxdsm7ZSKfaEOEJ5JsPsUvFQKvBCNC81Dt241q7UnGR3BRDXGO9NSr?=
 =?us-ascii?Q?kRo/b19fTIATy1097YQqrbye/5o+rKy917mDrvBSR1r7Y/p75HywycqLnfav?=
 =?us-ascii?Q?o6iC+Cye7UnGk/QGi0L5Q9Lc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e65f73-890b-438b-3a2a-08d8f886b9e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:21.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss47ZGb9MIcCziTA2NqUdoOQ0NKrx4EZxALF9PY2qfJRxcgUrt0sJucDCapBU3Xnrngrkx33HgrG/16pSZuZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5424
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: Akm4HZn2E_Q23IrbxnkgX83-r7olEswK
X-Proofpoint-ORIG-GUID: Akm4HZn2E_Q23IrbxnkgX83-r7olEswK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cma_release is currently a sleepable operatation because the bitmap
manipulation is protected by cma->lock mutex. Hugetlb code which relies
on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
irq safe.

The lock doesn't protect any sleepable operation so it can be changed to
a (irq aware) spin lock. The bitmap processing should be quite fast in
typical case but if cma sizes grow to TB then we will likely need to
replace the lock by a more optimized bitmap implementation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/cma.c       | 18 +++++++++---------
 mm/cma.h       |  2 +-
 mm/cma_debug.c |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index f3bca4178c7f..995e15480937 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -24,7 +24,6 @@
 #include <linux/memblock.h>
 #include <linux/err.h>
 #include <linux/mm.h>
-#include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
@@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
 			     unsigned long count)
 {
 	unsigned long bitmap_no, bitmap_count;
+	unsigned long flags;
 
 	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
-	mutex_lock(&cma->lock);
+	spin_lock_irqsave(&cma->lock, flags);
 	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
-	mutex_unlock(&cma->lock);
+	spin_unlock_irqrestore(&cma->lock, flags);
 }
 
 static void __init cma_activate_area(struct cma *cma)
@@ -118,7 +118,7 @@ static void __init cma_activate_area(struct cma *cma)
 	     pfn += pageblock_nr_pages)
 		init_cma_reserved_pageblock(pfn_to_page(pfn));
 
-	mutex_init(&cma->lock);
+	spin_lock_init(&cma->lock);
 
 #ifdef CONFIG_CMA_DEBUGFS
 	INIT_HLIST_HEAD(&cma->mem_head);
@@ -392,7 +392,7 @@ static void cma_debug_show_areas(struct cma *cma)
 	unsigned long nr_part, nr_total = 0;
 	unsigned long nbits = cma_bitmap_maxno(cma);
 
-	mutex_lock(&cma->lock);
+	spin_lock_irq(&cma->lock);
 	pr_info("number of available pages: ");
 	for (;;) {
 		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
@@ -407,7 +407,7 @@ static void cma_debug_show_areas(struct cma *cma)
 		start = next_zero_bit + nr_zero;
 	}
 	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
-	mutex_unlock(&cma->lock);
+	spin_unlock_irq(&cma->lock);
 }
 #else
 static inline void cma_debug_show_areas(struct cma *cma) { }
@@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		goto out;
 
 	for (;;) {
-		mutex_lock(&cma->lock);
+		spin_lock_irq(&cma->lock);
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
+			spin_unlock_irq(&cma->lock);
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
@@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		 * our exclusive use. If the migration fails we will take the
 		 * lock again and unmark it.
 		 */
-		mutex_unlock(&cma->lock);
+		spin_unlock_irq(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
diff --git a/mm/cma.h b/mm/cma.h
index 68ffad4e430d..2c775877eae2 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -15,7 +15,7 @@ struct cma {
 	unsigned long   count;
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
-	struct mutex    lock;
+	spinlock_t	lock;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index d5bf8aa34fdc..2e7704955f4f 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -36,10 +36,10 @@ static int cma_used_get(void *data, u64 *val)
 	struct cma *cma = data;
 	unsigned long used;
 
-	mutex_lock(&cma->lock);
+	spin_lock_irq(&cma->lock);
 	/* pages counter is smaller than sizeof(int) */
 	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
-	mutex_unlock(&cma->lock);
+	spin_unlock_irq(&cma->lock);
 	*val = (u64)used << cma->order_per_bit;
 
 	return 0;
@@ -53,7 +53,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
 	unsigned long start, end = 0;
 	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
 
-	mutex_lock(&cma->lock);
+	spin_lock_irq(&cma->lock);
 	for (;;) {
 		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
 		if (start >= bitmap_maxno)
@@ -61,7 +61,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
 		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
 		maxchunk = max(end - start, maxchunk);
 	}
-	mutex_unlock(&cma->lock);
+	spin_unlock_irq(&cma->lock);
 	*val = (u64)maxchunk << cma->order_per_bit;
 
 	return 0;
-- 
2.30.2

