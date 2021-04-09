Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09F35A829
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhDIUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhDIUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Ko0Sa071231;
        Fri, 9 Apr 2021 20:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=MvjokJjB5zUDCnakgLH/9HBYHTsYx5V0OJeMIP8CtOc=;
 b=KYau4RiYbWW7ty2QuZrqYSEIVixaxLF1ewXkYVLEHHEjqSPblYZd3rvr1Q7YHz++feMR
 bD09I8uXGmueWq1cAspguPl7vA78VP2YoVL7Kf42xtE8UhsuItLbj45eM12dQppAH8gu
 X6A+UgtgVaCH0YXQGur1qRYeui6cGnLvUxTSSeW9D03I7p4/wrmyXn7JmQXA50g68esW
 ZIelC1jyi/VSRlhlkK8hsMLsrVZQp4QUOvjExkFQEAVN1R1kA7PvUDsCCKDqV/Kt8gj6
 fH2bCl6kWTKcgjvvIdAqZM7XusEVhuY+4Q1Q6uO99bZlYJ28V7Vt9sMH1uKMFZiwGX4I IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvasaq5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Kk7bU035297;
        Fri, 9 Apr 2021 20:53:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 37rvbhfka6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoHNo+gLPuk8OAFojA888bLPsf35Z8io3/e/5Z1ANqYrXuo4aYpFT/jF3TdWxMV4MW0i5mE0sNrG7nrsY7Y01ZouA90RrnbAeqPGGjYqVXX7czlnyAbkFvTQ0kB+2F+9sKLPgVa+qBL5QFWJ1k0bjNdjIq+U1USVI6BqHKeWmK38EOM97XxyrnRDyu6GTChvrVvWKoM31NLwZUmHVIwZqNYP5hT8pBTUAsukQMTGlaLVAOwocE3GoV/uZH0ZZiEKkVhiejNu4DWd5a15o/l4XtxC7SHz+z0xFo4X9kE1uFM+AJFte6on/V/iRxoUpIWOjtQClzY0Zlw4bQ5xO0qyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvjokJjB5zUDCnakgLH/9HBYHTsYx5V0OJeMIP8CtOc=;
 b=WOjOQ2b6i+MgMioGd0QUT0uVm+F/Vb2FrhzESqajsd8sh85MEtcQ7A/9CzMsMVO9Dd2kbS10bAi/cKDGYEctpf+kkAC4KUqKgpe9zI5mEoUmjKJH0oyBFqyN5B5zXAizJ+nfplOa1ZcI59wd4k1T/PQy5/FCVkhVQTe/lVIPGejZ/jTRgsMQ1xAB2KAfpiSvhu28NLVpBFIPh8gT4yNga7DMuRX/P9lYZj/4qjbzHwAQC9IKAQemh28205dZPqAV2rOM+pZHoZHyTBUyuItYK1fz/q7f+XM/WAemBqpqM+nV7iZYbOl6n9Y1/yFlNauPg/TzrQnDF1bn9sTW7Iz+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvjokJjB5zUDCnakgLH/9HBYHTsYx5V0OJeMIP8CtOc=;
 b=ogkvUpeekZzJ7GxsrplWdVBQMiOwNZMTlyJ31g2Xrg0nT1ccUksodnmlAWk3iSvGMhkomA6xdNMAoqzbndhuIT4oZJuKxnttwzdpXJbekg0pzSp5HI3iXZqtiQirdXrCucmL5nxxWFCWoHatmXP9inXYZglehsAQQOsRX+w+OOE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:20 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 5/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Fri,  9 Apr 2021 13:52:51 -0700
Message-Id: <20210409205254.242291-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409205254.242291-1-mike.kravetz@oracle.com>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c6e501-ec51-4749-b8cd-08d8fb9981df
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39725ABFBE4DA36BFB3BE548E2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpKiv2QDPftwgNTrTU9uxp/NGzVkhKl1dVQ7nF2Yrd/Xepn4FxU48jG4bxD6hrtR9w89Sq7bACttA/eGpm1QNLL2Cyf5H7R0E7viZ5vgOMvvG9jSLmjD5uNJcJqOv3DqazpxIf5XpPdwRiv5xns5gNwibw8HgcoNk2G6NfcmFofZBdgks3dttWc2SH1s+JuvG/skERAmiwWy01jx03bmArAsRbhxjVqWiej3Zc6itkBuBuy5ggKmkzF0fzedtguuj/OHkX6QFS8KYQYBm1mvZP4dLbOaS6Dnf+9DPg7wbi5p0QU/SycY7oGtII2neWr4NV3Tl8HSxpNYxt8ziM/9kJSFU88bhW3juksC58JAdD5CIkvc3zru56bKpzLBTGkc7EdwLJgo5bmcKyRvfBbVcQw5h+oja0xrWuo2l2JvzZ7hYH9mFFUo6b2o3jkSgRj+ZWEaC22/diYED0nInmoZM7xQBAQ2tPcw/6UPuFiRAMHH5lHos1oNh55Z3u+mQxSez82NJNm91S62uhD6yDxCl2iWxmicluIGJJMy1cVJ0+14TlbwQBtPm+J/TtjaOf7Lx9YiU/haaP6I3u/jiCRYMEIB+d79rP7t7IoVSz9Hoxa5cnQFLogbxqPLpDu5CT/LbVmkeygxHqomYzu0tmKbvru68CMq82BuxVSigoPvDgiEUhdyIIT98BcgA8NEBR/j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(15650500001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1flSoQq2hbkP4I8jT65vNs9Mqrm295Whx1sTujRAu/oVggbT0VINq9PjFrxB?=
 =?us-ascii?Q?xLI75M/gT8SkxaFdSJpV7cZ6WUicse3jKnav2vWordXSLOKpep7H8EGdu+xO?=
 =?us-ascii?Q?qlb0u55Or9jCBUWjMTWPZ6a2go3GM10pflmTF5kLog8fW96nBu7gdzrFx0S7?=
 =?us-ascii?Q?R6PR7vZlelkBCiY863y/7Eako2o5XUvGCjx+IuFyjIbJgACMvYVChrPpRFT1?=
 =?us-ascii?Q?FwodiJLmdEbZZZmh+p4zuiER+6KI3FhveSJZZnj6bb18oKPxcD6q2XnqJGN1?=
 =?us-ascii?Q?B8rSCbvCla4QHmRJJSJTHW+0zWXXHlyZdndtXOfRgWp5593jt+jyqkzUBxKm?=
 =?us-ascii?Q?lklXPEaRgUoY/hEmb4U0tRb/Ds0RRmYxQDjJ82nXgEXgbRPgVjbHL+tuQ6iV?=
 =?us-ascii?Q?uQRZECM+RKPsSUKxSMdrZcen3JgVKkcAzdxXiSGac1H2ka3TGfeonjLqAx+C?=
 =?us-ascii?Q?yTzfrQseLMpWblYLW4JykNsh/QqW2j+K1yJZOSMJPGP1AQcw7sspORoBsNZa?=
 =?us-ascii?Q?XajBcxZaB0F2wXpCGkuNIqRYR9F83b+XuuM1DNUfvJoVa/xQmNDjgMIx0eeR?=
 =?us-ascii?Q?2NAi5gGty5mgETXfRpvYdDGEF4Lj5RUfLw08B790qFvUYOUdEUYzuoCumJQX?=
 =?us-ascii?Q?NACJMz9blR23e1qaaM2zXoQJc/M9CeBBykBirkUU/TDRazWUHguHP1m/8wfd?=
 =?us-ascii?Q?37SxqC7EpRoefi3bzjqYBN9K63FbChzXf3gWjqANPIh/eKqicv9ehIOMPSCn?=
 =?us-ascii?Q?psjqJ/PifkLdwLR/kWib7AFglTzrmPCBKW2mfHgnuuD/7ow2a2s+/Z0ahLbA?=
 =?us-ascii?Q?qeSOYLlqGre/bQKnlxCXC3Y8oRN/DTSZRUSPWb5jBktPtGyQV0seNzeTUVLJ?=
 =?us-ascii?Q?hJp+qC/RL7bAaBzoS4l1oQztl60LdeHGXU/JXMaPMnMKZkE2tJUpRqjZudzp?=
 =?us-ascii?Q?lqeRXbYTdowMj54vkwzjgEjBVpUm902C0JTgkfEOacMawBfotlDYqaVBaT7S?=
 =?us-ascii?Q?rVa8Ug4BcRNaHEEFUmyUPrPYyrODkqeF3GzHhus2h2bDzbHiHryciMKHLL0G?=
 =?us-ascii?Q?2ooJcoZBzzytL6wfNWy/sEwljOL3CRIZyb33RgyyhrrHfoC2IeM0KuWrjSfz?=
 =?us-ascii?Q?1z7uqcbUv2RTngZj7qaZjZ0Wnt1yQ5+mWvOwUZx4DqhOWiEGUyiHA7sSZkmt?=
 =?us-ascii?Q?cM8qtTl3lxh32ziHz/XSNv0lqSfxIVqTz7Ekwm8mXNIC1GaKCSdiWwqOuo9Z?=
 =?us-ascii?Q?J67TdxeSwOWO2pNDY3fVmKmS28mi7Bo77H+9MZmiVbgeEhVClUmE04oQt0eR?=
 =?us-ascii?Q?ly0eM0RV1+OliMcFcLNkLXNm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6e501-ec51-4749-b8cd-08d8fb9981df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:20.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk95DeSFYZti1J3BB1kuQnVs/FhPTOBTAluocKvZ780734Z+zvsKOJZpzpotuPOXPhH/8PfRQl/vCikK0BMbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
X-Proofpoint-GUID: dsw42Kb5Yo_A70BiTmg2sTGaq3Jv91yV
X-Proofpoint-ORIG-GUID: dsw42Kb5Yo_A70BiTmg2sTGaq3Jv91yV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of remove_hugetlb_page(), there is no need for
update_and_free_page to hold the hugetlb lock.  Change all callers to
drop the lock before calling.

With additional code modifications, this will allow loops which decrease
the huge page pool to drop the hugetlb_lock with each page to reduce
long hold times.

The ugly unlock/lock cycle in free_pool_huge_page will be removed in
a subsequent patch which restructures free_pool_huge_page.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 773081709916..d3e5e49bf687 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1444,16 +1444,18 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
+		spin_unlock(&hugetlb_lock);
 	}
-	spin_unlock(&hugetlb_lock);
 }
 
 /*
@@ -1734,7 +1736,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
+			/*
+			 * unlock/lock around update_and_free_page is temporary
+			 * and will be removed with subsequent patch.
+			 */
+			spin_unlock(&hugetlb_lock);
 			update_and_free_page(h, page);
+			spin_lock(&hugetlb_lock);
 			ret = 1;
 			break;
 		}
@@ -1803,8 +1811,9 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, head);
-		rc = 0;
+		return 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
@@ -2557,22 +2566,34 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
+	struct page *page, *next;
+	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
 		return;
 
+	/*
+	 * Collect pages to be freed on a list, and free after dropping lock
+	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
-				return;
+				goto out;
 			if (PageHighMem(page))
 				continue;
 			remove_hugetlb_page(h, page, false);
-			update_and_free_page(h, page);
+			list_add(&page->lru, &page_list);
 		}
 	}
+
+out:
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, next, &page_list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-- 
2.30.2

