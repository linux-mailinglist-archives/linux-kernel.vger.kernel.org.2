Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECE34DC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhC2XZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhC2XZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNOZ6p164127;
        Mon, 29 Mar 2021 23:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=y9zys2i0cdd3Oi+3BnIautw4FxcBb5BI7MA2DnFDUiE=;
 b=JhLM4Y+qzMLQFQNyCohPJRvsjlPuBk1bzGX6r9aTn2ODxWqzu3DprrF3Su1Tec36rLrl
 FFLOEXJvk0pJIhk0WbyY6E4OYCjMaaS9L77uKr48J2n8QbQOqOhN7A/dUFFv1tYiHRcE
 2xZcVQGQH1zOtr4n+4UFM0mT05IoDqBJTfxJM7u6ydUs3bP2oRAmq7cdDHf/ttuWS0qv
 dgR++T4ucMWNpktKwZ6+Nz6sDwTvG3jojYD9muN53UI2XG1Hje6/7mhDQo5RYGXggiWY
 Zkv2Vn2fgak42lBvK6s69gNLmhx6coRPomBk9vuM2wra89KTWv1gbjErHgtBkyVPWPHj hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37ht7bdbrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFY1r055853;
        Mon, 29 Mar 2021 23:24:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 37je9p06s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diROtVkl5+0fVJywdo4McRAxY41H8eUsHxS+CH4m+oCl8nJpg8vlJx3mRTtwb9+R7CVXBa/GCSOiQLi5nYtRaDVfZFJ59vaQtrZHsqdmQSm3jYktBT6IvouS7HB279Hc751/p7jFluBaJ2yH3cjHHs+qy1FaoKEca/DX/I6joTjg/KEUDJxby/kK70xQhw1ey4/OuuHYl9RX8y0xtHCZQibOio7dKvVWOAPCrTtzVEmUnz9zM0O92+1xuHdngYWKswb9VoLlPh2nSV64jjmXytk4nYKj9C2c599+jN/yi9aqGcpIVzBsDyvTmpljIxrymuGUYJaVN8ztDY6GStwFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9zys2i0cdd3Oi+3BnIautw4FxcBb5BI7MA2DnFDUiE=;
 b=gtW+m02tAONCVNsAvqSBtI0ik9MpDcngEcb2s1vnqRE62fyoh1jbaA2GSsgtjEq0k8ED93F0vDAU1WjJFEX8x1A5DbVXXr4Qs9XzI/XV8ckye/gwDib6+HiIRpJ8W1MyFqqsKdFJixPcGb65EWeFcoJjFoPc9KHKl4WRWenVJyUePisXLAb+8KVoXGOaWZfGHelUot1vdS0eGPU7ZLC92swWgMOPpwbvi5YMCdmZWhVdgN7pbyDnjTkFhXqbtWpfetBFp2DgUppQN5B6vQYl0aNp4a65z8ydRmXKCor8mAcYfRdr55NpQu8O8aHsLnyoqzxKCRImq0MNx1GIzM8KDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9zys2i0cdd3Oi+3BnIautw4FxcBb5BI7MA2DnFDUiE=;
 b=BBQmKWp4LKNSmCP7nDwTPhOVc1oMV7TFUBhU7mV5Mlynm0+g9NxMBPFJrxnVWdf3Y2Q3Ec+cnA7bGeFRhQ3SfmVikpA+zrLlvkl/pX5iplK/grngBqMr+jUwL0LBbcpz5FpcPCVRC2MU6ldK8vqSISDA5sC3MiRZfH57FlQ7t+c=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:31 +0000
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
Subject: [PATCH v2 7/8] hugetlb: make free_huge_page irq safe
Date:   Mon, 29 Mar 2021 16:24:01 -0700
Message-Id: <20210329232402.575396-8-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04329fb2-aae8-45b6-d8de-08d8f309ce82
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4148713ABF82A36F8D7CF467E27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vxO5lbtmTZiUVNHsSKKtHnPvIWrKAbkWYNNpS0XQbynQkVweKmLMx0WcZbT9RHeHllEc1MDYGRQYgjnR9G/5iYMPr4gAtVv4dYinsYd1nciFwEt5abxJgVtN+IZ6O5HfyJYbjYMdJeqtDli4JqjRzInToxHa7MLuH0zIr5MyIPcn7eW53oXUiw7By3tFDmt76q2sZ3q1XBlTVJCsF7W8SLsX7v16tXQrUuk1+otNJtmrSMDzl2mV05z+glKUnJR9QnfwTKih+BU73DAgEsP9rbSkQYWV+ER2xqLno4xQfj+Uqm49Ge6X+5ctZca4ptulxeG6ZtSxj5Y2Js+NLUmOaNGO//JzSUucHT327ZhViMz6teltDhaMQMD5nryaVwS1Ei0G07jD030nqGlc6aI+KKxu/XbuFE8wUvqfIz4Ef0Q+DJo829pB1MvcHetel0FRanqDYBAcd7XGQmfBI9aqNTulblSdo5BZru/5ir+87/5Nu7KEYt1c29pdfmE5awVH0kRzSxyGjULxrNwnOLYkhNhYBpVIh8yRLOAcajhLbBnfNhvI4OLCyS+ZJLL7X0FIb7Utnj4hQL6ImugCdK7ads9WfyQirBXvA4NzmsuR+8fyPwBOun+atW8yQ33RA0nxs/lCvIAsD891tbhKLrKkM8nkfqNKg4H4wFpAcO8Po/hYhpnpEZxyd9C94ZWKMv2b2IPttkDETs7uZmyeKGcYzAURSbE79SLyizVCDIYoOrmMhhZBdq3EnUHw6qpcz7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(30864003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(966005)(2906002)(107886003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jtdxhXWUxMrQE9rr9hQgvjiwUHPwWT4Dl/9U3u5C8HgQPcTyIIPlvRqIkA0t?=
 =?us-ascii?Q?YznWUP9ZVpG9cRpN2JqqK2hvcNtDJH9r70OoKChhFzBk0iVWMY3X8cwaGvcm?=
 =?us-ascii?Q?pbvsYdKk4aTXx9y3EJQAqRqGY693WYgZ9/JSj3brXLJuLB9n+gxzbDVUfHNA?=
 =?us-ascii?Q?fBN5JuduMGHEXuhr9tdFTk5hhFJvsHgkQIjbKn0UvzukOjSLNQeY8XYzpb+2?=
 =?us-ascii?Q?j4YWhqxdUsy2iwwuM/y/eunPOcpzgMrWVhr22QOuKTyQkIsFdrmtWmw6X43P?=
 =?us-ascii?Q?2IQZQAO7/iDsTN/tSaDPvrAOag0brjZLgRw9WSuzL0MypfkqdK19b/vhF5VY?=
 =?us-ascii?Q?2mHauLiPYr2Yntm27ShNBIh5bhwevP4X0MD23+Tkavhwxau/B/HBqrRNp2Cm?=
 =?us-ascii?Q?HgRZrp5yC5P2T26uxqk9msKG3quf2WF8m46E3BGHh9r8mO19iNsm9uy8c9bC?=
 =?us-ascii?Q?gxxAjCy8RaRpJEzvn94ZjYMT/rJjO57AVIMrhXPVLwrjYVW0hPa4TAEsvrT8?=
 =?us-ascii?Q?Tmn4A2PuD2Kx/zI9z7DX0xu6y7htFujn2VRl9ihnkVpvRAQmzcWYAioWqa4/?=
 =?us-ascii?Q?+Kjc08qG0YXZIOs96JHRTqQV7cODA236e4Xn+IMHWtU1yYIm5j0YFF5A+cCe?=
 =?us-ascii?Q?yGmXIOtiXohLe3JnP3HDWMAv4CNWrDRzf+XUrRZJJYiGQIK++fqBdyKWy7YE?=
 =?us-ascii?Q?+o5CR2sXq2woxkQ4YTmHeg6W1x1vkYuss1TKNF3d5bKRgMGJqnmLnDCGzKZs?=
 =?us-ascii?Q?xRksuHwXhAXd42taZObbH/63GL+XMlJq1knGW7yu1tj6cA1JdRI8k/wwNnJ3?=
 =?us-ascii?Q?O29QuIns1snIPUfLqc/ZF8ajaJLUgrpEzWGyjPPY2OH1RezK2Eo2hHy2lqhi?=
 =?us-ascii?Q?U0xrUivIZ2VY9atCbeKNPYJE1LoZw59VcRSMD8y7LVyTDVqEbuISRYD762MP?=
 =?us-ascii?Q?P8DNo+W+/DnK0WzXP85DaKBhpRVUm1S9svs6mcZRGdlPgkw8liCBmJMJQm0h?=
 =?us-ascii?Q?ZKWg3qJzO1fOf/QjsMPwUQ4QnHxQ2CUwc11kBz4eAI93xBH3yO0F26surDmY?=
 =?us-ascii?Q?flfyj7eecMUJ90oQULrSGAExDsWdGkSB8ZXqCF2bqUEmX/15DQAt0W07SXUM?=
 =?us-ascii?Q?JUCm8OQYj6AvxgekIJyDpTCTZfnnZitCA4vhenY2tK5S9E6nPXxHYBEjjQ2i?=
 =?us-ascii?Q?jxQUBrNulDhLs4Hol+Hq14BoRU/w3rVz6Xw5juIeeMkm10GhnaATg/D6fC/R?=
 =?us-ascii?Q?6SGOxTOVpESGbJ2P06GA25HPW6OUSlS5Xs8D9N5Zwqz+FPyiOAVWtGnrbYzk?=
 =?us-ascii?Q?Bp1zo9o8OaHyW+VOZMfLF3dK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04329fb2-aae8-45b6-d8de-08d8f309ce82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:31.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM1n8q0rD+2aCBLZGv8QuBKR2B/N0riTFWqpiErXgWvw7zCx+5kFQxTKTG20jywExJpEBiqZKn6K+a2pInXBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: bN__hQdAlsL-XPl1d6kvy8Po3vWa67tR
X-Proofpoint-ORIG-GUID: bN__hQdAlsL-XPl1d6kvy8Po3vWa67tR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
non-task context") was added to address the issue of free_huge_page
being called from irq context.  That commit hands off free_huge_page
processing to a workqueue if !in_task.  However, this doesn't cover
all the cases as pointed out by 0day bot lockdep report [1].

:  Possible interrupt unsafe locking scenario:
:
:        CPU0                    CPU1
:        ----                    ----
:   lock(hugetlb_lock);
:                                local_irq_disable();
:                                lock(slock-AF_INET);
:                                lock(hugetlb_lock);
:   <Interrupt>
:     lock(slock-AF_INET);

Shakeel has later explained that this is very likely TCP TX zerocopy
from hugetlb pages scenario when the networking code drops a last
reference to hugetlb page while having IRQ disabled. Hugetlb freeing
path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
chain can lead to a deadlock.

This commit addresses the issue by doing the following:
- Make hugetlb_lock irq safe.  This is mostly a simple process of
  changing spin_*lock calls to spin_*lock_irq* calls.
- Make subpool lock irq safe in a similar manner.
- Revert the !in_task check and workqueue handoff.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c        | 167 ++++++++++++++++----------------------------
 mm/hugetlb_cgroup.c |   8 +--
 2 files changed, 66 insertions(+), 109 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d3f3cb8766b8..bf36abc2305a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,9 +93,10 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
 	return true;
 }
 
-static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
+static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
+						unsigned long irq_flags)
 {
-	spin_unlock(&spool->lock);
+	spin_unlock_irqrestore(&spool->lock, irq_flags);
 
 	/* If no pages are used, and no other handles to the subpool
 	 * remain, give up any reservations based on minimum size and
@@ -134,10 +135,12 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 
 void hugepage_put_subpool(struct hugepage_subpool *spool)
 {
-	spin_lock(&spool->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&spool->lock, flags);
 	BUG_ON(!spool->count);
 	spool->count--;
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 }
 
 /*
@@ -156,7 +159,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	if (!spool)
 		return ret;
 
-	spin_lock(&spool->lock);
+	spin_lock_irq(&spool->lock);
 
 	if (spool->max_hpages != -1) {		/* maximum size accounting */
 		if ((spool->used_hpages + delta) <= spool->max_hpages)
@@ -183,7 +186,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	}
 
 unlock_ret:
-	spin_unlock(&spool->lock);
+	spin_unlock_irq(&spool->lock);
 	return ret;
 }
 
@@ -197,11 +200,12 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 				       long delta)
 {
 	long ret = delta;
+	unsigned long flags;
 
 	if (!spool)
 		return delta;
 
-	spin_lock(&spool->lock);
+	spin_lock_irqsave(&spool->lock, flags);
 
 	if (spool->max_hpages != -1)		/* maximum size accounting */
 		spool->used_hpages -= delta;
@@ -222,7 +226,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 	 * If hugetlbfs_put_super couldn't free spool due to an outstanding
 	 * quota reference, free it now.
 	 */
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 
 	return ret;
 }
@@ -1412,7 +1416,7 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-static void __free_huge_page(struct page *page)
+void free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1422,6 +1426,7 @@ static void __free_huge_page(struct page *page)
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
 	bool restore_reserve;
+	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
@@ -1450,7 +1455,7 @@ static void __free_huge_page(struct page *page)
 			restore_reserve = true;
 	}
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1461,67 +1466,19 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
-		spin_unlock(&hugetlb_lock);
-	}
-}
-
-/*
- * As free_huge_page() can be called from a non-task context, we have
- * to defer the actual freeing in a workqueue to prevent potential
- * hugetlb_lock deadlock.
- *
- * free_hpage_workfn() locklessly retrieves the linked list of pages to
- * be freed and frees them one-by-one. As the page->mapping pointer is
- * going to be cleared in __free_huge_page() anyway, it is reused as the
- * llist_node structure of a lockless linked list of huge pages to be freed.
- */
-static LLIST_HEAD(hpage_freelist);
-
-static void free_hpage_workfn(struct work_struct *work)
-{
-	struct llist_node *node;
-	struct page *page;
-
-	node = llist_del_all(&hpage_freelist);
-
-	while (node) {
-		page = container_of((struct address_space **)node,
-				     struct page, mapping);
-		node = node->next;
-		__free_huge_page(page);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 }
-static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
-
-void free_huge_page(struct page *page)
-{
-	/*
-	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
-	 */
-	if (!in_task()) {
-		/*
-		 * Only call schedule_work() if hpage_freelist is previously
-		 * empty. Otherwise, schedule_work() had been called but the
-		 * workfn hasn't retrieved the list yet.
-		 */
-		if (llist_add((struct llist_node *)&page->mapping,
-			      &hpage_freelist))
-			schedule_work(&free_hpage_work);
-		return;
-	}
-
-	__free_huge_page(page);
-}
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
@@ -1530,11 +1487,11 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	ClearHPageFreed(page);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
@@ -1780,7 +1737,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!PageHuge(page))
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(page)) {
 		rc = 0;
 		goto out;
@@ -1797,7 +1754,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * when it is dissolved.
 		 */
 		if (unlikely(!HPageFreed(head))) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 
 			/*
@@ -1821,12 +1778,12 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_page(h, head);
 		return 0;
 	}
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return rc;
 }
 
@@ -1868,16 +1825,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
@@ -1887,7 +1844,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		put_page(page);
 		return NULL;
 	} else {
@@ -1896,7 +1853,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	}
 
 out_unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return page;
 }
@@ -1946,17 +1903,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
 		if (page) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			return page;
 		}
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -2004,7 +1961,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	ret = -ENOMEM;
 retry:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
@@ -2021,7 +1978,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * After retaking hugetlb_lock, we need to recalculate 'needed'
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
@@ -2061,12 +2018,12 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		enqueue_huge_page(h, page);
 	}
 free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	/* Free unnecessary surplus pages to the buddy allocator */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 		put_page(page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
 }
@@ -2117,9 +2074,9 @@ static void return_unused_surplus_pages(struct hstate *h,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 
 
@@ -2464,7 +2421,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2472,7 +2429,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2480,7 +2437,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
@@ -2493,7 +2450,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 						  h_cg, page);
 	}
 
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	hugetlb_set_page_subpool(page, spool);
 
@@ -2706,9 +2663,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
@@ -2804,7 +2761,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
@@ -2834,14 +2791,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 * page, free_huge_page will handle it by freeing the page
 		 * and reducing the surplus.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (!ret)
 			goto out;
 
@@ -2881,9 +2838,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		list_add(&page->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
@@ -2891,7 +2848,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
@@ -3047,9 +3004,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return count;
 }
@@ -3636,9 +3593,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		goto out;
 
 	if (write) {
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		h->nr_overcommit_huge_pages = tmp;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 out:
 	return ret;
@@ -3734,7 +3691,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	if (!delta)
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3773,7 +3730,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		return_unused_surplus_pages(h, (unsigned long) -delta);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
@@ -5837,7 +5794,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
@@ -5847,16 +5804,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
 void putback_active_hugepage(struct page *page)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	put_page(page);
 }
 
@@ -5890,12 +5847,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		 */
 		if (new_nid == old_nid)
 			return;
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
 			h->surplus_huge_pages_node[new_nid]++;
 		}
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 }
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 726b85f4f303..5383023d0cca 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -204,11 +204,11 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		idx = 0;
 		for_each_hstate(h) {
-			spin_lock(&hugetlb_lock);
+			spin_lock_irq(&hugetlb_lock);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);
 
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			idx++;
 		}
 		cond_resched();
@@ -784,7 +784,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	if (hugetlb_cgroup_disabled())
 		return;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_page(oldhpage);
 	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);
@@ -794,7 +794,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	set_hugetlb_cgroup(newhpage, h_cg);
 	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return;
 }
 
-- 
2.30.2

