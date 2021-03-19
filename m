Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2190C3428D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCSWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCSWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMYU62026030;
        Fri, 19 Mar 2021 22:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=1JUOu8sJE85O3bodR4CCM+u8Q8W0RyCN8K/iW9k5u70=;
 b=Au+77cJ96sFNe/iVUfWY02aoLmpjF7tcQuocm8p/+xtRQeNyVPZlXfjVOFyh+fXwG6cN
 dnIbrsBuwapGDIvhwC/HT1vBY1FK+V2R3hXuFLNcaG8tGrLM7PQdl2hCTvJGrt8ZLKMj
 MoS/0U3xuAejmp0cfV93LunCduUTHK90RSUPcqEguL8jHT8jG8I8MTkIPfZ/y3N0pgr9
 seTIX15sEIqz6TGbGQo7KyLEGmdPtPIn/jxWS5BXmAWp2midXQLu5fchLjz99pxoc6Uc
 fCmNwV06cNZVNEpdykfHj216EHFYhMR4NrB9hJ5S3A0dvthHJHgNy4RWM6pVZrhhW6kZ gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 378jwbvhmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMesZo001873;
        Fri, 19 Mar 2021 22:42:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3796yxynfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXJuCvF9ZyLFbAjKL4SlSFLHY49EZKbVc9jWPXd90dAS6UkqW06gaP8wwyRYISYcGTImObSggInb8nOwWBjF0DyoBKlCH/ioYkO6Fuy1Jc3LKsIbR+siIIphlt86nQc1V48aQMNkgfGYYWNAzG81I068wGEp/L9CQHtNiKniB06goYUck1Pi+fkJbGdjqxJxr8NazL9sSsHKZ1EFiTzbwQKP6qUrHCnGB1Pr9+E/ijxUAL84so/fYIFTmXRvMxiHuOkdYZnUtP1ZzUBVjUFMph1aqIAOKjIMqDvs3VGn3IWGO51szmajx63SegqrO9zj3YE6zl2FY6cZAdnHDJc9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JUOu8sJE85O3bodR4CCM+u8Q8W0RyCN8K/iW9k5u70=;
 b=WksGwmxkeMiTcV/EVJmd7LQTzslRutCZuLKslJvWiRqY41l0jmNbbYF5fSv/2qDI1w3ULNfpZCt+/Vfquydx82TIm5b6RhM7HuNeclmGts9DiZDKO7bNQSzYlEdPC9yor2aeMuvQn8zxtuQEerqUSU8w//0fKrkd8osJy/g9a2yad3+sKCsXwaJd8eJm2Yna+7/HisTzjuCRUDMimUchWUsZdrw/sd2vt4xsCCo9FS6Wz5fgrdQiyO1GgrrD7Zd8u8RgfHCQiNQu6B778++pDB2WqCcVO/3IhEytU2NDli4sGIj8MNDcKaQA9l/WFi+GK6Nb4aNt1eE0RXVmDOzytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JUOu8sJE85O3bodR4CCM+u8Q8W0RyCN8K/iW9k5u70=;
 b=StMb/wbUUYY8rR8CGqVg99sNZrJb+XQRkCscM6Cr8H9eRfBi4qcbaJUUmvJiC7lw3F9DwNIxcDH3WTZruk9jwpuQbIF5AR2RXzlgS8PcJptOKr1F9d8NYpaja8edAlxaz0pOglyu6F4EgfTMROO8VwzKJl82F4af5W6ZhvdR0uM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:37 +0000
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
Subject: [RFC PATCH 6/8] hugetlb: make free_huge_page irq safe
Date:   Fri, 19 Mar 2021 15:42:07 -0700
Message-Id: <20210319224209.150047-7-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca269bf-a230-4846-2979-08d8eb284b67
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB316072A133A53FF4332650FDE2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qWAJZGz3Au512eGKeyklBzuD/lkBu798gk+JbkShG4mwhmYiL0qG3DqDT1gnAPll0wkWepmj6tK7XLih7aa3aAxygIrq54yF6rGno7WRvoJgXpfjggyBGTLwTA0FEf/Q7YJrisfqTpTTc9SqdSxWSkTdAuEhoEMZmDcBdsGi1Sdln93Cqg3zkmkTLeiHQBAPogS3hQsSebSz5E5tH76ymLPDl/VKrXJOq8mn5jpXr8srdJsMy/TNvoC/b900Xg8Se/IRY7gzuRgseHnZ0/Kqo483SphvPc0knhKdg3Jrdc4RKdFOyJUu6yMVYavl6dGGfIkCzRiC6ekV7ddYSxvG6btGUep9s1MTRs3wkGPp/Uhhgv4J4V+3ipWsCx5DWN6+Msv726vOMsL6kvwFeWU+CqjEcxhpH8TZkXb1UVfYOoUjt515z9rRl50fgc/ZzwLVSayzR6BVmtMxxLDNqMinBei0hCiM9Ex2R/NQ1qzCQ1zD9yAJ6BaftqH6TUetiJW/B3pWTdiA3ICQR1sK2MaNtMSFGv+NM2Ov/GOGHnQUaK0fDtWnaBQfYvOf0dnRaG/6J3X8VPoxOamz3AWnc1yT/Y+ZUIRRf/8Tqn4Pj247xCowGCqom/2BPePzkD1a6gm8tPjQgk90Yp5acXNRM8UjBras3l2C8W0R631xmrJyh8Y/J/pxBNYt2ly32ZROJDGRerAk35wkM4UamPWzlB+MHtWnBei6Ly41HFr5b/vy+kji8bulQ3K5koNZJJTZqw3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(30864003)(52116002)(7696005)(83380400001)(8676002)(956004)(966005)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?paFHojV0twthsyDxj1+P7mh8ffPCYr6AKFLNzvnMnY7rzzf1+kfwwH3U7iz3?=
 =?us-ascii?Q?xuz/3eqttBZczCwhy3XvqnhfRp1DvZxZi88cfi5lrzi7A23D/fEmShUv/kGh?=
 =?us-ascii?Q?FJ382107E7aULCbmrbPDd6S7QxBeJ4Vn9VwuBkiG4I5JiDLwKdKj8AE4llPi?=
 =?us-ascii?Q?ZTDqdLf4fkK6ckwhIA4Qb2/x29us/357DOHg0rLxJYsYUDRHOB4lARkH7XuP?=
 =?us-ascii?Q?8crkedv9tpt1jsWFWDH2bWl0NGy0LOvfHZP7QQSWmHtmxdYNTTJ5IeCM/TV5?=
 =?us-ascii?Q?dE7GfzIVKQRfD9YLJhI/7tfMqmOvt/r8H0+wVtUK/N9azI6ELFoMmwN1d1kQ?=
 =?us-ascii?Q?2kRgMqIORHJWY6TSPfMmB8US51hJrCFCuMJfRotAtJKAmvrucWGQde/H04/N?=
 =?us-ascii?Q?5K4LQ80h5A8/3NOWmfn1DlDtFdaAWkbP+MeeECRnrUFM29Z5PQExcofv8U2a?=
 =?us-ascii?Q?pBTR1vZymhc+RjuUqLeJQYa75UE3PnWHtPiSh+TQeU4miQLtrFfSEJXEFzh/?=
 =?us-ascii?Q?3ZVPQP773dbwsDNC3jw7GpO59Otm1QnFZYbmVxpWVBwFptvF16GnAETG4faA?=
 =?us-ascii?Q?AfnO4Z0UY/3gMEtOaEFcVhmxbh4szdd21wCYOGaaowANqgeFdqx5X/R2Z4eh?=
 =?us-ascii?Q?UxdSOGO1Rle0FKNZ0/YvyJ0cxbX3lVj1Y0x/iOKQRnS8cdjC4omacjdeCqK2?=
 =?us-ascii?Q?YHmzhG9FU9R8LtDwyFRW9PU+6BNGYlLuBYrE2toCB1eVps98cuQ21YU3XHLh?=
 =?us-ascii?Q?i35W0kLVcLQpj5ZYnLghNAhwwf0E0WbOjH0t6Qr0VN49gUd0+Aq8CDY1wU7e?=
 =?us-ascii?Q?ZxQt5Iq66HqySP00oeDYJGlieb0AetNCezeLEvTIo0r4Upq2TG1JV44cCHjs?=
 =?us-ascii?Q?JSFNa7GfU8ewZEzs+FQtayPvA1PI440LvrwgSoV67TZC5ByGmXeRZSOGIbJF?=
 =?us-ascii?Q?eGBjnUt2H7Wenv8ly6NtqW2ElyD3m5n0V0OpFyYf8dgRmEotjATkOcxjqkGZ?=
 =?us-ascii?Q?uTSvqYLsLckR5c9WImenIzbg+NOmWFet6qUXgWBpi+tWXvNxEDQDylcwjpEn?=
 =?us-ascii?Q?qxdjH5c1W2VB5J+5gQbWqmJ0KI3TmTI6uIlHcoz+U+LdHENVCMNGfzxiLJ9c?=
 =?us-ascii?Q?dsqZJFCQDKeYiEs0hneKXexV1CeSMaHr/WMeagpPKpSQ1c4RRJw2TUkPVnwM?=
 =?us-ascii?Q?KJMA/NghoPA82kT7lum7U1CP+WwXGPQtvPSIyQ2e0MRx7WckYbSLJnnnzRJR?=
 =?us-ascii?Q?JmbV7kRE4YfarXxpji/lt+nPYlG4gc1R0R6Ayp71mcSt0UC/H+dos0ynI/SF?=
 =?us-ascii?Q?En6W30VtDqT1omZ8mmf6h5ID?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca269bf-a230-4846-2979-08d8eb284b67
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:37.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+C9rmx50i1+XZxKDtmxdziV/m1kElwBmEnzmXDX/z/33ajNEriJjJGP7CfCOZE/lO679hxrgSG8zQyeF+eKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
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

Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
non-task context") was added to address the issue of free_huge_page
being called from irq context.  That commit hands off free_huge_page
processing to a workqueue if !in_task.  However, as seen in [1] this
does not cover all cases.  Instead, make the locks taken in the
free_huge_page irq safe.

This patch does the following:
- Make hugetlb_lock irq safe.  This is mostly a simple process of
  changing spin_*lock calls to spin_*lock_irq* calls.
- Make subpool lock irq safe in a similar manner.
- Revert the !in_task check and workqueue handoff.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c        | 206 ++++++++++++++++++++------------------------
 mm/hugetlb_cgroup.c |  10 ++-
 2 files changed, 100 insertions(+), 116 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f60a24e326c2..82614bbe7bb9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -94,9 +94,10 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
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
@@ -135,10 +136,12 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 
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
@@ -153,11 +156,12 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 				      long delta)
 {
 	long ret = delta;
+	unsigned long flags;
 
 	if (!spool)
 		return ret;
 
-	spin_lock(&spool->lock);
+	spin_lock_irqsave(&spool->lock, flags);
 
 	if (spool->max_hpages != -1) {		/* maximum size accounting */
 		if ((spool->used_hpages + delta) <= spool->max_hpages)
@@ -184,7 +188,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	}
 
 unlock_ret:
-	spin_unlock(&spool->lock);
+	spin_unlock_irqrestore(&spool->lock, flags);
 	return ret;
 }
 
@@ -198,11 +202,12 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
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
@@ -223,7 +228,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 	 * If hugetlbfs_put_super couldn't free spool due to an outstanding
 	 * quota reference, free it now.
 	 */
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 
 	return ret;
 }
@@ -1380,7 +1385,7 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-static void __free_huge_page(struct page *page)
+void free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1390,6 +1395,7 @@ static void __free_huge_page(struct page *page)
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
 	bool restore_reserve;
+	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
@@ -1418,7 +1424,7 @@ static void __free_huge_page(struct page *page)
 			restore_reserve = true;
 	}
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1429,80 +1435,34 @@ static void __free_huge_page(struct page *page)
 
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
+	unsigned long flags;
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	ClearHPageFreed(page);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
@@ -1742,13 +1702,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	unsigned long flags;
 
 retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	if (!PageHuge(page)) {
 		rc = 0;
 		goto out;
@@ -1765,7 +1726,12 @@ int dissolve_free_huge_page(struct page *page)
 		 * when it is dissolved.
 		 */
 		if (unlikely(!HPageFreed(head))) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irqrestore(&hugetlb_lock, flags);
+
+			/*
+			 * ??? Does this retry make any sense now that
+			 * hugetlb_lock is held with irqs disabled ???
+			 */
 			cond_resched();
 
 			/*
@@ -1789,12 +1755,12 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, head);
 		return 0;
 	}
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	return rc;
 }
 
@@ -1832,20 +1798,21 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nmask)
 {
 	struct page *page = NULL;
+	unsigned long flags;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
@@ -1855,7 +1822,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		put_page(page);
 		return NULL;
 	} else {
@@ -1864,7 +1831,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	}
 
 out_unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 	return page;
 }
@@ -1914,17 +1881,19 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	spin_lock(&hugetlb_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
 		if (page) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irqrestore(&hugetlb_lock, flags);
 			return page;
 		}
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -1951,7 +1920,8 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
  */
-static int gather_surplus_pages(struct hstate *h, long delta)
+static int gather_surplus_pages(struct hstate *h, long delta,
+						unsigned long *irq_flags)
 	__must_hold(&hugetlb_lock)
 {
 	struct list_head surplus_list;
@@ -1972,7 +1942,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	ret = -ENOMEM;
 retry:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, *irq_flags);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
@@ -1989,7 +1959,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * After retaking hugetlb_lock, we need to recalculate 'needed'
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, *irq_flags);
 	needed = (h->resv_huge_pages + delta) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
@@ -2029,12 +1999,12 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		enqueue_huge_page(h, page);
 	}
 free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, *irq_flags);
 
 	/* Free unnecessary surplus pages to the buddy allocator */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 		put_page(page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, *irq_flags);
 
 	return ret;
 }
@@ -2054,7 +2024,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
  * number of huge pages we plan to free when dropping the lock.
  */
 static void return_unused_surplus_pages(struct hstate *h,
-					unsigned long unused_resv_pages)
+					unsigned long unused_resv_pages,
+					unsigned long *irq_flags)
 {
 	unsigned long nr_pages;
 	struct page *page;
@@ -2089,10 +2060,10 @@ static void return_unused_surplus_pages(struct hstate *h,
 			goto out;
 
 		/* Drop lock and free page to buddy as it could sleep */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, *irq_flags);
 		update_and_free_page(h, page);
 		cond_resched();
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, *irq_flags);
 	}
 
 out:
@@ -2281,6 +2252,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
 	bool deferred_reserve;
+	unsigned long flags;
 
 	idx = hstate_index(h);
 	/*
@@ -2332,7 +2304,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2340,7 +2312,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2348,7 +2320,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, flags);
 		list_add(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
@@ -2361,7 +2333,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 						  h_cg, page);
 	}
 
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 	hugetlb_set_page_subpool(page, spool);
 
@@ -2556,7 +2528,8 @@ static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
 
 #ifdef CONFIG_HIGHMEM
 static void try_to_free_low(struct hstate *h, unsigned long count,
-						nodemask_t *nodes_allowed)
+						nodemask_t *nodes_allowed,
+						unsigned long *irq_flags)
 {
 	int i;
 	unsigned long min_count = min_hp_count(h, count);
@@ -2575,9 +2548,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 			remove_hugetlb_page(h, page, false);
 			h->free_huge_pages--;
 			h->free_huge_pages_node[page_to_nid(page)]--;
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irqrestore(&hugetlb_lock, *irq_flags);
 			update_and_free_page(h, page);
-			spin_lock(&hugetlb_lock);
+			spin_lock_irqsave(&hugetlb_lock, *irq_flags);
 
 			/*
 			 * update_and_free_page could have dropped lock so
@@ -2589,7 +2562,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-						nodemask_t *nodes_allowed)
+						nodemask_t *nodes_allowed,
+						unsigned long *irq_flags)
 {
 }
 #endif
@@ -2633,6 +2607,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	unsigned long min_count, ret;
 	struct page *page;
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
+	unsigned long flags;
 
 	/*
 	 * Bit mask controlling how hard we retry per-node allocations.
@@ -2646,7 +2621,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 
 	/* mutex prevents concurrent adjustments for the same hstate */
 	mutex_lock(&h->mutex);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 
 	/*
 	 * Check for a node specific request.
@@ -2677,7 +2652,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irqrestore(&hugetlb_lock, flags);
 			mutex_unlock(&h->mutex);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
@@ -2707,14 +2682,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 * page, free_huge_page will handle it by freeing the page
 		 * and reducing the surplus.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, flags);
 		if (!ret)
 			goto out;
 
@@ -2739,7 +2714,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * sysctls are changed, or the surplus pages go out of use.
 	 */
 	min_count = min_hp_count(h, count);
-	try_to_free_low(h, count, nodes_allowed);
+	try_to_free_low(h, count, nodes_allowed, &flags);
 	while (min_count < persistent_huge_pages(h)) {
 		page = remove_pool_huge_page(h, nodes_allowed, 0);
 		if (!page)
@@ -2760,7 +2735,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	mutex_unlock(&h->mutex);
 
 	NODEMASK_FREE(node_alloc_noretry);
@@ -2908,6 +2883,7 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	int err;
 	unsigned long input;
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
+	unsigned long flags;
 
 	if (hstate_is_gigantic(h))
 		return -EINVAL;
@@ -2916,9 +2892,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 
 	return count;
 }
@@ -3490,6 +3466,7 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	struct hstate *h = &default_hstate;
 	unsigned long tmp;
 	int ret;
+	unsigned long flags;
 
 	if (!hugepages_supported())
 		return -EOPNOTSUPP;
@@ -3505,9 +3482,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		goto out;
 
 	if (write) {
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, flags);
 		h->nr_overcommit_huge_pages = tmp;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 out:
 	return ret;
@@ -3599,11 +3576,12 @@ unsigned long hugetlb_total_pages(void)
 static int hugetlb_acct_memory(struct hstate *h, long delta)
 {
 	int ret = -ENOMEM;
+	unsigned long flags;
 
 	if (!delta)
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3628,21 +3606,21 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	 * above.
 	 */
 	if (delta > 0) {
-		if (gather_surplus_pages(h, delta) < 0)
+		if (gather_surplus_pages(h, delta, &flags) < 0)
 			goto out;
 
 		if (delta > allowed_mems_nr(h)) {
-			return_unused_surplus_pages(h, delta);
+			return_unused_surplus_pages(h, delta, &flags);
 			goto out;
 		}
 	}
 
 	ret = 0;
 	if (delta < 0)
-		return_unused_surplus_pages(h, (unsigned long) -delta);
+		return_unused_surplus_pages(h, (unsigned long) -delta, &flags);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	return ret;
 }
 
@@ -5654,8 +5632,9 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
 bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
+	unsigned long flags;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
@@ -5665,22 +5644,25 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	return ret;
 }
 
 void putback_active_hugepage(struct page *page)
 {
-	spin_lock(&hugetlb_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	put_page(page);
 }
 
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 {
 	struct hstate *h = page_hstate(oldpage);
+	unsigned long flags;
 
 	hugetlb_cgroup_migrate(oldpage, newpage);
 	set_page_owner_migrate_reason(newpage, reason);
@@ -5702,12 +5684,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		SetHPageTemporary(oldpage);
 		ClearHPageTemporary(newpage);
 
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, flags);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
 			h->surplus_huge_pages_node[new_nid]++;
 		}
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 }
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f68b51fcda3d..b3b5759e44b4 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -200,15 +200,16 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	struct hstate *h;
 	struct page *page;
 	int idx;
+	unsigned long flags;
 
 	do {
 		idx = 0;
 		for_each_hstate(h) {
-			spin_lock(&hugetlb_lock);
+			spin_lock_irqsave(&hugetlb_lock, flags);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);
 
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irqrestore(&hugetlb_lock, flags);
 			idx++;
 		}
 		cond_resched();
@@ -774,12 +775,13 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
+	unsigned long flags;
 
 	if (hugetlb_cgroup_disabled())
 		return;
 
 	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	h_cg = hugetlb_cgroup_from_page(oldhpage);
 	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);
@@ -789,7 +791,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	set_hugetlb_cgroup(newhpage, h_cg);
 	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 	return;
 }
 
-- 
2.30.2

