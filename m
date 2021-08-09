Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38123E4C72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhHISyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:54:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235844AbhHISxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:53:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179IpvcP000446;
        Mon, 9 Aug 2021 18:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cjzHVGiPOd0xqdqMQdU4VkgDFiyhVm5RZJGYPVRWmXc=;
 b=cmuL7DIFsP0dtqzEhee4uOpVkuZ+Yv/IZw05P7UyvFkwX1co4Hmr+yL7+I9w/ERvkir7
 GIfRN51QXmdYae7A7h660jxVx1YpmDWyD94WzUTjrE7nVAsAADbKgT2e93VmX710W9xe
 sFxwd/leR8RGiT7gqmWdQtOwMlb3JmSh93o5gPIq+fjX7qSvLWqBaut5VdLKSBwIYbWN
 DDf1V0A133JzzAWmsh9UHYk6W7/fH8peEwf0ET/QP8TWv0eoPmeudCQfkP9P79ANW9F2
 C9q+hMBqTeCSoasxGmu4rLjXhH2lk+vJ4kd0P0Es820f2/KwikquJfTt3bB1B7Yn1x+8 iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=cjzHVGiPOd0xqdqMQdU4VkgDFiyhVm5RZJGYPVRWmXc=;
 b=CjQBqHNFpuNBWTxIxWGhUqPRV6cQNDBttguYkx8+7Z1K1+AJLpwtY+Xwart2CEGxfKJN
 LKdrxV77SuozTuUmbF4zuX/PUQPydDzyXXgHQW+/Sz3Y8cX671XqaW2aeMyphpjktw9t
 txEDM7chQPharoeWUOROK3cEYObAz54ipXNI0zL9GHQMP26mKIOX/FIj/OMDnB5k148t
 vQxKEGdGyK0wZiCQWIRuKKweI6J4M3Kcd2v2+IhafaajyTs6XKLjbZ8ajZo206CyHQ6W
 sq75951la7zrBr293t0aJDbU45s86v67pz8ipFwX4Vzm/ATy8pz94+La4unadZaZhRzK kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fsrv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:53:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179IqEcJ152833;
        Mon, 9 Aug 2021 18:53:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3aa3xrrmpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRT/6lkGksSfOP1kPsdL8DUCaV/ClvwkZgTDAGe+vgISJfbWKguvvUCVwxcesiO5eeeuKYpPQqk9Kamy1kZcW6ZuqolKF7oo2LwE48qYqJCVfaZ4aOvNRR6uZa9Xr5jtC+R8Rh7hk5tisw1nffzfQN5hcQA7P1WJmcRQILGb46D11tcrGV9RKk1Dy/U5QGKPBczLWjrSJBNgVsXgZK0bwYaJrUUXzMkanwlZ1QNetFwaH+r0GFKaXRpUsXN+AgAprEL+BAbYkxdcljxoEW6MO+YKosgwA5C4GpR/tS7MXnaO8zXTF/RPpakqtl/BuwUatMIf8YCcnGBqTl0z9O2o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjzHVGiPOd0xqdqMQdU4VkgDFiyhVm5RZJGYPVRWmXc=;
 b=IR3/exgb1kQ2wSDV1mwl+Qkhl7YxDwPiSoVGSNH6YoXOwwydXaI8WcBYXyroYT+D+APvJsgdUfrtgMxegWgoTaesyHFHbqUbNEfiSR6j8B/29brV3KfvxLXwFXsnBjktEjZeQhzcxi0k90/c+u3UBh8GJYElVSeoua+fvjrPUCvs+n1AS7h/Y+JhOJhuVoGnpEaUkHKjDL41rI/ozfPePc+Q2P/Fe1UPpPlSr9cNLBL9j/pV3Y0UA8vTXLgbpjlslNDx62avW0Vglq95rI4eFrsYTDeT0naBLRYhI7UdakVCPAD4KphJtB9C3d62382wWBZKCosguCH3gYYoRDFERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjzHVGiPOd0xqdqMQdU4VkgDFiyhVm5RZJGYPVRWmXc=;
 b=twfsq3plMK29PUMvdpscuY29YZON14pBmAqUod8SEXxtojGjP6LqZrSSrNXXQsHYMuckWDTi7pTw1U94R8Q0b51xH1TRvbKcTM9SzvQ7HHotFSHID6pdBnlZkqiE20f6XqNeAj7+1INmWRb9GIh+OXhaPQ+FD+bOYejBQKmykkw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5455.namprd10.prod.outlook.com (2603:10b6:a03:3b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 18:48:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:48:51 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/3] hugetlb: drop ref count earlier after page allocation
Date:   Mon,  9 Aug 2021 11:48:31 -0700
Message-Id: <20210809184832.18342-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809184832.18342-1-mike.kravetz@oracle.com>
References: <20210809184832.18342-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:48:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aacf4ff0-6e5b-438f-6b26-08d95b66542f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5455F0AA8B1FCDACD45D0723E2F69@SJ0PR10MB5455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcBv8UGH850LwGBUGC+0rg1odTb5a7J2U6OFOjLjVhjyhn5RP/DQKWeAsc3d5UX1MRX0nDekx+3aXTXDGdLE4wgMaXXK+LhWprDL7WkrbDZqYDpmICspqrjnKwPnmTjUUwH6c49MFHzrzEZDSFXtZA0n6XNH2pmSyEuy+cF6OH+a5IpOD3GrhPQTCMtk/NGMv/6MMbM4RIidWis31j3kx/kuq3XinR1bU6UcZ1QseFvptf6H0+K3FkDX546JrX/CIq0FRPHVLNlILMdMhUPevUKKpx6vU/70NRVMR1zlv5uyI4xXqY2cQFogmChclLF2MEqGvi1KidAg7uOEkovwyoT4xneKJMnWOoDYs2fLUgLUWvt7wBzYHM6PhHfAP02iAoiljpIBnIS32OT8bfOvE8d2cWIhqtcnIFgInghzAp8/FgpdTBD2KmpemizWIuQDUbZxA6hknglnj7/7uX9usAkpo3m58We/TgN9c+YAHIAceGHPXcPaVfkaW2aFmtzxWGuEA5sHb9WqCKM4LfxHINrsg+HdAm7otFqDN4KBaixCtZiMJrA85KrWfNfDupGl9FHKuN27ePJDLJO6VsjBDYlcELE5lHdwtRNXBieSKotlYHl8ONgbgTAChiQ56aY4JF/CR1qyK9UBwPPfOQv0B3JRLgrHFLFgvONA8r1DdnbZk3/lITxC8/j0GUdNMYRyuMQltMf1N3ega4ZTgIhUfXa8WzWCYAu9qW4RBPfmALay9hggSqljnSi3z8+jDidNzdcUz3ILHAypguNVjcUZnw441xJjh3v/xmww6Xl9qB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(7416002)(83380400001)(86362001)(316002)(956004)(2616005)(5660300002)(8936002)(1076003)(38350700002)(6666004)(38100700002)(8676002)(186003)(6486002)(966005)(66476007)(66556008)(107886003)(66946007)(36756003)(4326008)(478600001)(7696005)(52116002)(2906002)(44832011)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wVbDK9zNdzb+WDR+clGFMq9UTHNVX3M8aSzdDPBbuHmGi596kcnDLkN0hXu?=
 =?us-ascii?Q?0WSo/roUc+3wIhtGmMfz/Wtz41yAtwdfArrsFQQPAk21mTaMzBZNNNLDJCNl?=
 =?us-ascii?Q?C7KLQO9VaIppspTQIhOy+HmVcxnDKKzYyET20F23ghLWNJz6biMz0mLVcTTd?=
 =?us-ascii?Q?3wedb3pro4Eq8Lrquvwn8uZ4yxHHNUb+V2Lvc1Jg9k275GLmZk8rMUGQwKdB?=
 =?us-ascii?Q?G/Dtf6lFePIpxk6Thr2JlHMs1HI2qQ/PP4WAMFYTMgPGVZo7MbbznnUNupaN?=
 =?us-ascii?Q?3Wj48vaN6v90fQ5P4ublVH6OULzz3oNKtTi9ffK520uj6SueCDy3HJ/MT6NE?=
 =?us-ascii?Q?bu6C4e8JzGQIbxeLpeSsbuZmptqF1n+2ExndT1tVYKe/Ky6yCSUzjLVvVZLg?=
 =?us-ascii?Q?g9T/PTnePu4ioCdx3yT8Crug0w5MFw+BNRTs4sF2e44HdPZcraTqpzA2FmtQ?=
 =?us-ascii?Q?g9S3QpOgkLktpClDhQ/yeVMnKdT2kBzMXchgGy4hMW6NCX/Bsaf+dHUPXd15?=
 =?us-ascii?Q?6koiOyT5HhIuIrouwT18k4OKsCwbMikLyikdN+MAVPtd54+hlf665Ux9gzNR?=
 =?us-ascii?Q?Wxo2Kb5ZFqE2Eb14nOXWcuXXNefOdJiErLiMW824zJpc8lOlEHbJ6UcJCI64?=
 =?us-ascii?Q?453yA/5x97W2iUPORZvg8H+vtaumLFRCZM1F/v1yIW+LI2iu9c8WVPLK7KLP?=
 =?us-ascii?Q?VrI1PYw5eY20pptkWn3nYZu+bCEeyn9OtpaeS1HhipqjrC6Nhi5iLTrYCoET?=
 =?us-ascii?Q?bSIxXJzVKQO3xs2ILjm70tke8/2XDAG3cGw4KtQa4gHKk5e72AMV6uw4limn?=
 =?us-ascii?Q?sj24PeG6Jm9zqfxnzchH9VYN8N/QA1aCcAPHux1FRCz7YnFiEDyLkK1Uj+6E?=
 =?us-ascii?Q?tPVyK3TmK8pP8fb0oZD18BwQbft5sxikEkUQ2dBDqOe11wRrUV2aQVihWYbY?=
 =?us-ascii?Q?8VzEIUlFYzTgO7YU2WNKmS41XakWUp7JpWzxONM3rkJaEItvdZ5t6f9cg7AH?=
 =?us-ascii?Q?iDbAPEQmfkJsLCJCRuL8ag9AzspHiUOlZSqtLVzlm1hRHnVQYLU18x3bW57Y?=
 =?us-ascii?Q?kU++QrEgAdKDzjdPdXVrHBgVSbJBlKMe1KVucshOrArsJ2CLnwBX+cGi+j+Q?=
 =?us-ascii?Q?i+b1VEZmWggzAirpXulcC7sz1YMNEqqtYfJwePTOYS7nckY6ai9hFhte37Cv?=
 =?us-ascii?Q?FfsNAFsNc+8wj6qEDnwJLe13x7o4fDmqEY+TVs3YlAHrvOHPjyQ3L8Cnjoba?=
 =?us-ascii?Q?lQyXGK+r8nmYI2txZ+r2Kp9DZeQalgERaQGJzcdr8zEmcJTR8NV+BhaRMjom?=
 =?us-ascii?Q?RwIbP7telSxrNIaEuEaVBAnd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf4ff0-6e5b-438f-6b26-08d95b66542f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:48:51.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtM3OfArdxef9pdt1Ylmr4fi5KUwpx+bNRQF2wGH1Rd7VjZibEbUXfkp1Di9vpvb3yAMdziac/+ciCsSQtonng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090133
X-Proofpoint-ORIG-GUID: USjvolypyGEZqu_jZM87M8sImSlAsDnw
X-Proofpoint-GUID: USjvolypyGEZqu_jZM87M8sImSlAsDnw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When discussing the possibility of inflated page ref counts, Muuchun
Song pointed out this potential issue [1].  It is true that any code
could potentially take a reference on a compound page after allocation
and before it is converted to and put into use as a hugetlb page.
Specifically, this could be done by any users of get_page_unless_zero.

There are three areas of concern within hugetlb code.
1) When adding pages to the pool.
   In this case, new pages are allocated added to the pool by calling
   put_page to invoke the hugetlb destructor (free_huge_page).  If there
   is an inflated ref count on the page, it will not be immediately added
   to the free list.  It will only be added to the free list when the
   temporary ref count is dropped.  This is deemed acceptable and will
   not be addressed.
2) A page is allocated for immediate use normally as a surplus page or
   migration target.  In this case, the user of the page will also hold
   a reference.  There is no issue as this is just like normal page ref
   counting.
3) A page is allocated and MUST be added to the free list to satisfy a
   reservation.  One such example is gather_surplus_pages as pointed out
   by Muchun in [1].  More specifically, this case covers callers of
   enqueue_huge_page where the page reference count must be zero.  This
   patch covers this third case.

Three routines call enqueue_huge_page when the page reference count
could potentially be inflated.  They are: gather_surplus_pages,
alloc_and_dissolve_huge_page and add_hugetlb_page.

add_hugetlb_page is called on error paths when a huge page can not be
freed due to the inability to allocate vmemmap pages.  In this case, the
temporairly inflated ref count is not an issue.  When the ref is dropped
the appropriate action will be taken.  Instead of VM_BUG_ON if the ref
count does not drop to zero, simply return.

In gather_surplus_pages and alloc_and_dissolve_huge_page the caller
expects a page (or pages) to be put on the free lists.  In this case we
must ensure there are no temporary ref counts.  We do this by calling
put_page_testzero() earlier and not using pages without a zero ref
count.  The temporary page flag (HPageTemporary) is used in such cases
so that as soon as the inflated ref count is dropped the page will be
freed.

[1] https://lore.kernel.org/linux-mm/CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com/
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 100 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 791ee699d635..bde324e69276 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1072,6 +1072,8 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	int nid = page_to_nid(page);
 
 	lockdep_assert_held(&hugetlb_lock);
+	VM_BUG_ON_PAGE(page_count(page), page);
+
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
@@ -1399,11 +1401,20 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 	SetHPageVmemmapOptimized(page);
 
 	/*
-	 * This page is now managed by the hugetlb allocator and has
-	 * no users -- drop the last reference.
+	 * This page is about to be managed by the hugetlb allocator and
+	 * should have no users.  Drop our reference, and check for others
+	 * just in case.
 	 */
 	zeroed = put_page_testzero(page);
-	VM_BUG_ON_PAGE(!zeroed, page);
+	if (!zeroed)
+		/*
+		 * It is VERY unlikely soneone else has taken a ref on
+		 * the page.  In this case, we simply return as the
+		 * hugetlb destructor (free_huge_page) will be called
+		 * when this other ref is dropped.
+		 */
+		return;
+
 	arch_clear_hugepage_flags(page);
 	enqueue_huge_page(h, page);
 }
@@ -2017,9 +2028,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask)
+		int nid, nodemask_t *nmask, bool zero_ref)
 {
 	struct page *page = NULL;
+	bool retry = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2029,6 +2041,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
+retry:
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
@@ -2046,11 +2059,35 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		spin_unlock_irq(&hugetlb_lock);
 		put_page(page);
 		return NULL;
-	} else {
-		h->surplus_huge_pages++;
-		h->surplus_huge_pages_node[page_to_nid(page)]++;
 	}
 
+	if (zero_ref) {
+		/*
+		 * Caller requires a page with zero ref count.
+		 * We will drop ref count here.  If someone else is holding
+		 * a ref, the page will be freed when they drop it.  Abuse
+		 * temporary page flag to accomplish this.
+		 */
+		SetHPageTemporary(page);
+		if (!put_page_testzero(page)) {
+			/*
+			 * Unexpected inflated ref count on freshly allocated
+			 * huge.  Retry once.
+			 */
+			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
+			spin_unlock_irq(&hugetlb_lock);
+			if (retry)
+				return NULL;
+
+			retry = true;
+			goto retry;
+		}
+		ClearHPageTemporary(page);
+	}
+
+	h->surplus_huge_pages++;
+	h->surplus_huge_pages_node[page_to_nid(page)]++;
+
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
@@ -2092,7 +2129,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
 	mpol_cond_put(mpol);
 
 	return page;
@@ -2164,7 +2201,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL);
+				NUMA_NO_NODE, NULL, true);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -2205,24 +2242,20 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	/* Free the needed pages to the hugetlb pool */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
-		int zeroed;
-
 		if ((--needed) < 0)
 			break;
-		/*
-		 * This page is now managed by the hugetlb allocator and has
-		 * no users -- drop the buddy allocator's reference.
-		 */
-		zeroed = put_page_testzero(page);
-		VM_BUG_ON_PAGE(!zeroed, page);
+		/* Add the page to the hugetlb allocator */
 		enqueue_huge_page(h, page);
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
 
-	/* Free unnecessary surplus pages to the buddy allocator */
+	/*
+	 * Free unnecessary surplus pages to the buddy allocator.
+	 * Pages have no ref count, call free_huge_page directly.
+	 */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
-		put_page(page);
+		free_huge_page(page);
 	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
@@ -2531,6 +2564,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
+	bool alloc_retry = false;
 	struct page *new_page;
 	int ret = 0;
 
@@ -2541,9 +2575,30 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
+alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
+	/*
+	 * If all goes well, this page will be directly added to the free
+	 * list in the pool.  For this the ref count needs to be zero.
+	 * Attempt to drop now, and retry once if needed.  It is VERY
+	 * unlikely there is another ref on the page.
+	 *
+	 * If someone else has a reference to the page, it will be freed
+	 * when they drop their ref.  Abuse temporary page flag to accomplish
+	 * this.  Retry once if there is an inflated ref count.
+	 */
+	SetHPageTemporary(new_page);
+	if (!put_page_testzero(new_page)) {
+		if (alloc_retry)
+			return -EBUSY;
+
+		alloc_retry = true;
+		goto alloc_retry;
+	}
+	ClearHPageTemporary(new_page);
+
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2583,11 +2638,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		remove_hugetlb_page(h, old_page, false);
 
 		/*
-		 * Reference count trick is needed because allocator gives us
-		 * referenced page but the pool requires pages with 0 refcount.
+		 * Ref count on new page is already zero as it was dropped
+		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
-		page_ref_dec(new_page);
 		enqueue_huge_page(h, new_page);
 
 		/*
@@ -2601,6 +2655,8 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
+	/* Page has a zero ref count, but needs a ref to be freed */
+	set_page_refcounted(new_page);
 	update_and_free_page(h, new_page, false);
 
 	return ret;
-- 
2.31.1

