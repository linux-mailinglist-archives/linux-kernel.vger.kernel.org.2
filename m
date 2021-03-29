Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF3234DC69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhC2XZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhC2XZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNOJ2n060855;
        Mon, 29 Mar 2021 23:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=chtyvAs784yyPCikCs1YAicr9bFeuv2v541t7rOIifA=;
 b=DAX7T3m10vMIIp9CjisZagIXvOX5tsFH416xyWu8+y4EoLfhtPFJMw1w8tga3FKAmnZ/
 XAOyfocQwrSRKhPDmBOGEYhNBJ5snviON9a4dpeOBKsncTIaVVx+aTMjTs/a+DbZPwJ6
 jS21VNO8/QyVy5K6dvv1f/25VTC6bFEWgO/xwFi8EX6aBy7rMC4IHxOrtHeTEJ/WX9xw
 OuRpm54cF1EE5IFChkzwhWt5IcA31TjFSEVVHmZETO+eVCx+mGjMkDetHfK2LgT+UXr8
 wCYl+VskRtlYPZKNnSSjVPpQ7LARAOC3cAvizqzTPZJfGy8PL2tCujD5D8/Ary1HoWwg 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37hvnm57xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFZJv055929;
        Mon, 29 Mar 2021 23:24:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 37je9p06qp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBFG8z0Q2d2fRHnGJTA8afuX2jWp0mDNCLiA594PELo+LFUtUmOSli3enhcGamTArxySCIHRsR+KmnkzJJ5gsJ5F6rkwYoEGK8mhw1z3Li0HaCeGrKywNtZsOXefMFbBnm0zc3nEOpv5+nZXfSBnyYNaGxHXeHOl2fBqWo/0Tg+0vHPLkmUr1B4DW6D9OO1YTNcuw5Ai0+1NgRZQcEW3FKU0D1DnOem9w2vwpYtK3C/TdYC7+ugM+mkv7nOyPO48lbYJ60L+4lQ+BcW7oatSHv5Fg9NvAe2WI67urcrzQ1auqp22bau7VcqIiyxvOaYZht44z0HRrjD1OYi4sjSgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chtyvAs784yyPCikCs1YAicr9bFeuv2v541t7rOIifA=;
 b=T8GdXYJwKR0QMaBRDdvtPxrCWdypdKVHQwSCwfUZhNw/Kd3nD0/J7SfMA0ZnQ5K6uYIwR1hdyCDjwBFfIkCuTQvNPAGW5l25MfGeSVT3bA09uF0GEmpmTwSDFYpc377EOc1q+XM/s8sFLxMyFVX+ktwGtDjQILrBCInQyPVh2x7eCCYyZxjpU/2HnxlDfbiAeeHZXUH/Alz0D+Y6yxXKvR9owuDUiBJS7pvFF5lu/YwaxLbDURbqG//10q4eCNdC3VcKocLDZ22J++tA2EWDVJB3vnSvQ4AzcUFN9yoancX4brfQhYPDu0cZ5k1R95UEaDrCPcftIAeVbXTKKMR+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chtyvAs784yyPCikCs1YAicr9bFeuv2v541t7rOIifA=;
 b=p7PhgQ5ZyGyyqHrLaLrqhk71oZhMDhsTonnz39Jj/TejGE5SfbYXK0hVJWh9iuZIYFvVbjU/2tsOkv1PR/L3WBDTBNrQazVLuUSOBNTVRgP7kOjVeNp75o2cDbN4ugN2SzRffUObOSgHy5ULmsFw/BvQgZQV1u+WA3/HRFYhXFQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:27 +0000
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
Subject: [PATCH v2 5/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Mon, 29 Mar 2021 16:23:59 -0700
Message-Id: <20210329232402.575396-6-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6a409f-84ba-4217-c146-08d8f309cbb7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41489181B95CB50177E6F129E27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byZbKFIOVWza32WuKZMCuboiZm4n9tOVGmsIsLU61KMklLv4dP+hwu/CEvDqHwjP2J+nLoJXFv/+IIz3v3/yMXIIiPSPUHPE/jsf1T0poBzGuKVkth53JKtPPz9+jDOLJyJyzDbae60JaJN4N4FR44t00QQHULddri9Rhuqz5clQDR3u9p7kBYYw1JyTI+hkfMT4po5qM1DiENc7IBdIufWtP4bcXi1nDGfDaoYwFu0v0rN9Jm8vqqBJORxgx1hYDTMccaHws+dWou6tzN1Vkw5ADjB17IyI+CSLBW5qkW8aykWkcA/r8StarBOpdXaDCwOy7EVJ0IjZ5S+5GvPcVZ97/bNWgIZxdId81t2s3pE2dYgxi65wES8ooxQKXjCaOnqKmR8qH0z8WfigQ/ZPLYgcFbssdkkV5QYJL0e909Zik83lDD3q9c1nlbO16OPYMP/qQcbLYEWE+XhPwILwyJcXWHDCfCxK4UztB9LiWB7iY0ZvUztDw4x8gfi9OX4nMM4lDI5AYFq+GNunrgxigw7uzqrMdSlu0UWEbSXpFc52dwFFi2ru4mu4u2OJSDVL3bizpL6VLtgcw9jzPgFg1GXyDMa5dpjd/U8baM7b/BGtRQmLRjFl1ou0Tb/6RY+NjZEFrwFtyzwuMN7MmNjKiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(15650500001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G+KL0YRTMu+oiOscuPZ7UH532ZADHtZpuaBwSqWHnyh+0/fgAv2jEj8dgA7F?=
 =?us-ascii?Q?iykOR0FGVja5IZvMVmTWs+uazWkmgxssUxU+tl0lGxnTP77xXnwUnbT9SgKc?=
 =?us-ascii?Q?Ho0rWi2O6n7rU+p70GdBzap+PXTMe+PUooXC0BrhkXZ5i6W1AFPNMvZ1m7qV?=
 =?us-ascii?Q?vSovJHhyd0cGRLOpe46HCEgN0NxEpcfpTtIvedya/Uerf1YOyveyVk3P+kfk?=
 =?us-ascii?Q?Xgd1b/VnTcCu0RAp8imyKE9xYq6T6BcExeBohQk9LPDGVQgO17Al7rsQZpJ/?=
 =?us-ascii?Q?tXjJdWInmfbGbnVYEyHcFFOYccKQ0fw1oV+GKI35zeaHv8O2qFztWtvSexdS?=
 =?us-ascii?Q?i2LAlD98zhVN9klQ+LEUcWVs0A0/Nmqpru8Eav9cJtS+SsJBTQmCKPoAI1UB?=
 =?us-ascii?Q?ANZ0eIxN3rJ0cPxKakQfE+U2OpJa/w/7kdWhQfhHivRYKKdv9p+Z9JJMfsSZ?=
 =?us-ascii?Q?arXxcNMSgLj6oQQ3XcJVAGwUo8lCwhrercAsVdcFGr/OHmzDHUwuS/Vu9Tf7?=
 =?us-ascii?Q?lkDc7W5iVjNkSXKFNN7STgYOXF3rNlpHe5YbHvn3r4iVIi4QJ/JJ425GqjJu?=
 =?us-ascii?Q?NujlKpeFOzJUY8teyt5cuxsf5mXcsC/ven2bIa8GxNrWnVKs4LTzAWk+nz2Z?=
 =?us-ascii?Q?zge0DkgPVPHw4yO8i+Dcozcga24R1f9UOg14FLnzw9/8NMe48NzdRm0bEeiL?=
 =?us-ascii?Q?yNnuJtAQAqjFFJm80uLM8+FfTtiDVC0rJnQ7kKCyEHaRrDuQdeeF+Yk41kbe?=
 =?us-ascii?Q?eLa5VMwYigFWg8XGJyRn7gWcmiBRvcAnTHVXK5K2NQydfECod1UQesvolPDd?=
 =?us-ascii?Q?qjqbu449ZRAnjKVhlWJCJ9EnTVH3zHXlahyP0P/89Yh/vl40kbi8xkLDZ0rE?=
 =?us-ascii?Q?tMgaOt/o8xj7wuNaDAWB5jQXuR4nYGDgIhNJEzX9AbtNkVouRZW5mhC9Jv6L?=
 =?us-ascii?Q?tB7UQ33E6tEuujKHKYpm1Kj9hvk8zza5OaPehYaG9NHgJBlpOZoaLKHlTcl6?=
 =?us-ascii?Q?p7JBE6vr1S72o4lArLzn/bBchDsnd7Iqz4IomnJEbtItr7EJ6Ckj0gAQ1O5F?=
 =?us-ascii?Q?NpuzQZXYO0qBtkM/+syhXuDDZBB2yc9+9tcYZzgRX18qJnspSjgo8glnhLKo?=
 =?us-ascii?Q?RwddcrLf5/91Yb3rU468p02gUTrxW7FmdK7YDjnlY6Ny7B33QGOxlBlf171D?=
 =?us-ascii?Q?sMCPUrA08/QTFLxnl7nb25D4ftW2GCN99cdA9BNmSXa/nf/AapyhOxCzk+fW?=
 =?us-ascii?Q?JHZ8TqqyQQUooHyokIc0sOe0YZrYj1nIaCUEGy/z46COFZNAYaenSFxRMx9x?=
 =?us-ascii?Q?J5ZYQK8TBU85kSG7u3p3THHX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6a409f-84ba-4217-c146-08d8f309cbb7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:27.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQynTE9lGAwpaMrjCa7H0XS2r8fq6nOTMCydF0u7z9qNGaxyyaJEVN4tHYF3jzuMEJiIC+nLMTGTAqfAJ4hVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: c7FfU2fLLmTBooCUy4JjkHfK7tXJAGJv
X-Proofpoint-ORIG-GUID: c7FfU2fLLmTBooCUy4JjkHfK7tXJAGJv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290174
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
---
 mm/hugetlb.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16beabbbbe49..dec7bd0dc63d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1451,16 +1451,18 @@ static void __free_huge_page(struct page *page)
 
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
@@ -1741,7 +1743,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1810,8 +1818,9 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2674,22 +2683,35 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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
+	INIT_LIST_HEAD(&page_list);
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

