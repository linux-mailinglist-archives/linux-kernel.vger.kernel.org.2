Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6E34F796
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhCaDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhCaDmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3e3Rd196433;
        Wed, 31 Mar 2021 03:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=5YNvFPurYJ/iLlKOIfYVeqvmYygFnDVjCOsULj/RHrk=;
 b=aE6htH8BaWkF5T9jnD/8xjlTW+EwueQmZTtwFun/5f+zQty9L6uM4jp2SD4nBr3RaWCQ
 WJQoc3jQvql7WOAlfiHCzCmCLG1Ynw+WKeazc0J9NA3nFRIqANAEO/R3Y+ci9LnWcfz/
 e4wDQZEt3kS6qMEwUn1hFYAAiaP1tILneZ5yxrnCk88RpMai76ymqPxVWXPDtmm3Cv1a
 CQk1uYEZwcDYc6JQUt2+23v3RLMcYlIgT2rSnGYfThRWc788PbudN2ZVmoxu3gQsAgYe
 vlQgBH9kcenNcF8ABpR81KUgv6Xa04cIbY+SF+Pq2sluztFMvRPENdpvhUe+9fEVNuQu BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9rs0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ebfs133184;
        Wed, 31 Mar 2021 03:42:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 37mac4wb6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii799YiLV3NdRUwundnjuqcGfwq8qVFSQFChXngzwLnVbmiX7SnxaEPAU0IZEHg2mq5xP76FP9nShoU1LI9DFmgVbEJIA8f21UIC7FraOpTcQCCLPpfpS8Kqnk3GqxzpRbmoztBaNu7dw6j3na7Pxx3jJBPhRNNwtZV0gUm1soMB0jMDN3XExovCf1uGzPZJOVuxmFFexxfw77RFgJ13wpHlvQGu3UZrNNKS6zOVSWfFE7CBWJvnepIBeoDmo0mnQWiDL094vjeuzWx7wTPE+YaRRqJ9mj/SZNWTWfbuZpOItlz/teBTGS9BvUulZHX4/05WuV8nsTh3xQHZm01GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YNvFPurYJ/iLlKOIfYVeqvmYygFnDVjCOsULj/RHrk=;
 b=SPd2czEGkDXhr3yDds/Xsa3OEjd1D0qPxrSdf4SDJMoTeZuRlMSux5Y0KTePZtsUm3u55d18M0JOiBrExXsu78tMJ04nluJ2zDyTDybdhFMS5nX5aYVPPeUrC4vhX2cnr9HU8uvfQcNYDDvS/HasaF1zy64SE0v+y3Skku7Z+LRG6GNF6ohWKDdpFAMgkBx3GFqJP3Ld63iwhfthVSHaJufHhSSRv++bYjkNVF1rsrJu6F28QuUy7/6QX6nWnTnd+70W9dyPY+tGCpS6QPQMRf78KyLPhriPIFkX/FX0UaAruWjoe9IAfeHNazxHJDokxPaRUBI4FE05VmRZ8i1yoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YNvFPurYJ/iLlKOIfYVeqvmYygFnDVjCOsULj/RHrk=;
 b=uR0fCnbsRdlAa/NTwrFChknIsRzrnhdaX/2QAr3wu/MU9jmnWC7/JgYDY1GKXDfwEMdyv7eFtk9Aq93sulAZzkcuwUirhnEVlZhZePA12xy/wjcj2O4UdAAVl6nbvN1oo0SfuZTUMM4WSc8fqUZzvUnFsdVT6l5QGN9C2tUoBcw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:14 +0000
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
Subject: [PATCH v3 7/8] hugetlb: make free_huge_page irq safe
Date:   Tue, 30 Mar 2021 20:41:47 -0700
Message-Id: <20210331034148.112624-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331034148.112624-1-mike.kravetz@oracle.com>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5499952-fd2b-475a-42e1-08d8f3f6f934
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44624903C28168AF6E0F3BB2E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4B3Z5defoI0MgOeHmQJzOyW0VBSmvQhjA+6eha5hJuJWBhv0Un43vSPaap4JWo/mHgnjgDX12qCSNVEG9OPTQTBkF3SPegznVSP69SZ7ULJfOJ9+FQkx+jh6xrWB3vDicr3prc79pchTBWTDSQf5Hvr4c7gD1VAjO293dJD4eED0FINFJcF+whBeHX/GoP8QqAXA4PBlo8Q7Q4ON7fcyNzrbMFILGgRG2UYQAhEfkfAUlfctCZ6LMuaheo7cd9M6hT+935IelhcURBWDuKbhcQt8ZI51NJq47uZ3GHd2YTUbBTlNZEved78OgPsnWySj64f5YntVBOP3H7KKIxjUDWtRd4d9W1R9czYBH8KyggIGUVBmwDJHijiSga/VUTiUXbtrLbHziEKOOs0SZCjqbCU3r/QdfeVJYhhaaq+n9Ac1okIYQVTHDpxOg1tTsJGbV062rKvIRyl9hdH0N1ArqTHaMhl+VWm6ecxMRveXyUWymhINy7qchp7HVHRczn9YQKa/UoYhoiE5OQFbOu76p5HoHQwVD6XwM3LXS8RlNoth1b2Too+WRVtbc/KE+1S7bwXY0Fav2Bdmi35iD0LHKCK+SMvOc3Uls9Y1Vx6tWYT8ue1d7I9X2LI+yXRdIF9Ohl89JkPKL8O80xp5tw0KRiVtxVhgul0FYs0GwQwzKp8oAkjR09J0PoNvh+W42mdTeqaTplwzeA9r6J8SGLyrNH8irqfpiqaRYAjNhebmB934lwLR+6FqiqmdZar83FO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(966005)(8676002)(1076003)(8936002)(30864003)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UnJVsVsE8UWAG1ijxUUfHnGtBRETjiiHYdoKIeIXAPK1+fwFnzOtY4yn4jSp?=
 =?us-ascii?Q?fPpSlxRzQSwlcvi8pVyvX0sqc+YVUNW2YSWnKPj6gvCMYeCwIDbic4VK/c5O?=
 =?us-ascii?Q?6SPUul6jmbs54JwHwWOEZQVw/psNiiaop/9BHB8VcUpauE/uNT4A5ViGgIKu?=
 =?us-ascii?Q?wnMry/EQagmZ4uJWk3QWlnTqAJjpNgukap+4p44gPLw/OuYw6g0rwWICdYZb?=
 =?us-ascii?Q?hjeJZZXGrAzGIdFUaiW6qmzewSCS8nNIy6Q/0niXQ6EIhQODLCH25w602O2H?=
 =?us-ascii?Q?F8L2rwhHPgOVqPqQk2QJYHuPFIo9pYsC2B+DCdaPRL5+oTGb61s9bz4GdnCz?=
 =?us-ascii?Q?N6Cvczwv+CBaxYqHWmyCoki6j1dPuLqNYysfXAxLEIgNKVkKK4PcoczuY7jB?=
 =?us-ascii?Q?4TwAnxdC84LSElmRD64MM8PAFdSzr4lfT0iFRKYYAejh94oabjNjkxTd/vGS?=
 =?us-ascii?Q?i9Kf52Potuy2Lh0koEAeF2xio3jq8N1HCJ/veV+afMC7EO0/NvQzmc3xTRai?=
 =?us-ascii?Q?8jIFbUEXojMbCG5SjDeBZnuqH1ZQtmV4N7J4o/7pJxUlkVzQijPulvo6mtDQ?=
 =?us-ascii?Q?UWCH3bntPbJ/yJOevyI1hDprNFP5u15jqJM57MagHdYVzIwLCegxhHpfTh7X?=
 =?us-ascii?Q?zdp+l5Dh1oqCULRyRN/IVziJzYSWxorNPp5U0pc0TBkRSFKnKKVT2g0gEtDY?=
 =?us-ascii?Q?zPkjm3p5LRWYrzPHo2HKWmPJe++R5OHXvK3+DwbCdli+CHG0cD1AyP/uGCUX?=
 =?us-ascii?Q?cLcfQL6pOY8VGFPagkrf0ktqvxIB9IJXlYh8OsG4Z4CDQ+U8LsgcqzHL6H0M?=
 =?us-ascii?Q?vHgmqzqvyEfA3OfV87R6fIGb9bdchPlA8c2e2ksU1+SqgiEpqlIkpzIo61pV?=
 =?us-ascii?Q?ZN4fdfmzk6B3fbz1BnKFCdceVt3r8+mi4RmyBszW7YjjYLSb5J9HTny+3EDs?=
 =?us-ascii?Q?UfsYD7LQPI3FCFDL23E48rKRCJZlohnWFrZ0hsxHuJGEn5fKiBbyaWwE4RUK?=
 =?us-ascii?Q?o5O3RgROlokbfTpLtZPfsJCyrECKglvOXpkVphrbZpk1Wo6U+6D5Yz22A78k?=
 =?us-ascii?Q?HKmY82SzBnLo0oaloai+4dD/nAFCYTbT6M3kX7qAqUDZbzCjEN03AhBbHPlb?=
 =?us-ascii?Q?StUYdnZpasXSVQnVwh/qiu3vZATzfb6y0PtkwncakNqmvHQaNCuEToZTWkTs?=
 =?us-ascii?Q?khBy8p0hmKtSSzVICLYjRL/sxJcPsb5pTl9tnTvKWooIJEI63+AgTYdvbP31?=
 =?us-ascii?Q?37VQiOhXUjkwUs4+Ds/izAMnJk/c/yAJtxMHN3ij0p4TxJJzirfhS4ECjPpv?=
 =?us-ascii?Q?Qd/2pA+AEEvBRW8vPOy2yN0f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5499952-fd2b-475a-42e1-08d8f3f6f934
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:14.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3MORMA8t2Il4mQncRBs5rBmkQKhxbDDEEi0OyAh5C6Fvf1j/QNLSzmsrvJboukvbX589G7SsIjSGUpbf8Y3xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: wp5a0rze3wgxpd-FUz29vd4CAJ24su91
X-Proofpoint-GUID: wp5a0rze3wgxpd-FUz29vd4CAJ24su91
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
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
index 5b2ca4663d7f..0bd4dc04df0f 100644
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
@@ -2116,9 +2073,9 @@ static void return_unused_surplus_pages(struct hstate *h,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 
 
@@ -2463,7 +2420,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2471,7 +2428,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2479,7 +2436,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
@@ -2492,7 +2449,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 						  h_cg, page);
 	}
 
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	hugetlb_set_page_subpool(page, spool);
 
@@ -2704,9 +2661,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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
@@ -2802,7 +2759,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
@@ -2832,14 +2789,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
 
@@ -2878,9 +2835,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
@@ -2888,7 +2845,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
@@ -3044,9 +3001,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return count;
 }
@@ -3633,9 +3590,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
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
@@ -3731,7 +3688,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	if (!delta)
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3770,7 +3727,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		return_unused_surplus_pages(h, (unsigned long) -delta);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
@@ -5834,7 +5791,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
@@ -5844,16 +5801,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
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
 
@@ -5887,12 +5844,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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

