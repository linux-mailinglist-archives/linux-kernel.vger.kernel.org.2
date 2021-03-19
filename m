Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2803428D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCSWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCSWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMaeWS138519;
        Fri, 19 Mar 2021 22:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T3dFsB+WFB+MLZZ9FRwUsTao9HIlRMf6SCY4VgMzVAs=;
 b=u08eU0AKT3dVXzoW0ter1V8nFot3W6gzBcqGmLW5sJyd2ZGvDLCcPGabGyrrpytuV1qp
 MJNM/vTHKdRLL7P1Z2mUwk1ke86DwQVIp3OmZbCuW5S05GplCUanlU++tSPX+GDTETkk
 yIp0W0WTVeGWN6nMJcrRrnb4oL1aJuOJ7sjoswNmsK54HD1UVA74+g4+/R20bvATjm/d
 p3UeJ2JVd+UhDGO7YjJRCmyzuFoyfdZodRifj4v5TbGw3BM6fpv4JYG13X8aKA/xTbzn
 CNyY0Wwad+iAlgcOF3H1T2VQ5HtMw7hv1hjY8wcm8W+arlW+W/CLUMryPLlVyKHHK4UR yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1p4dpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMeGb8155442;
        Fri, 19 Mar 2021 22:42:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3797b4sr31-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh92HkoaNBj48hePh2c8QWH6g964WoqD6u8yz8SOxPWMFnAZlc1IvJdHB6mf390bu3u0KXvgdPktc43bjcaueHXqpet6Rka3Bs7scbLEZVJggq0/VmKDOosNBQgl1di/gbbNOI6LFX74pVGh9BLcrbGtksnp1JOfZ4OiidTgoORc+4kN44ytd7GEGOUlAPaLuDZvNnlNVZUVIiiCcIDYAkaS7Ld8QJMp3GyihKq8Kftx6Hjg0Va77lVhy42l6hNDoNGvuMwUwT2uu4JqTCCTAqSU/1OzmL2jlLSgCR0P3+yiDN0g0a09tnCtxQ1mrFeO6+BfdCwQVq56oGbwQDjIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3dFsB+WFB+MLZZ9FRwUsTao9HIlRMf6SCY4VgMzVAs=;
 b=AorXE/vZ8EpmumJBHYa0/wMfpIifknLWypOjNIXM8XQ2pnf8lUhZnCO6BoGKY33yQ6wXvxCg1i+axdE8+c1Ydf2/UjxPIwgGZT6T9CCNGBFyQWyIc5qUVphUNjCbO9rmEhr1iXyKz3WGQ2ZlY11i6wmnn9+SCO1xng2HBekG0Qn303JltbB+DJuM28RSM0A37uc4dnI61h3xni3y4LlPmxcnTtKLTcrS4kCIN+1W9X8RDf1NbdrN+ZC6Ko7j3iOsGFKyKJiViCfDtfZ2t/+LIUA3/A1Cj4RLPdlxlDVO48ffjHsj2U+4UhUjKmD/6YkP3ONMsG7u2Abi9S1Vk9RcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3dFsB+WFB+MLZZ9FRwUsTao9HIlRMf6SCY4VgMzVAs=;
 b=W+U3tbgPHxJcEP4gLYfNrpfFIve8FA62+LkwoiVJPfvSLxDeF1x43gPqzXpTuj2hK+ey4oVF2BC2RLrayNM2iOM3HWDtToyeb9ritDQ8DroY2s+Vugfueocd3/mAspP25x26ilHepQUucjU7wJqX27MfDj074GWAlPjKuHn+0qY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:28 +0000
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
Subject: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping hugetlb_lock
Date:   Fri, 19 Mar 2021 15:42:03 -0700
Message-Id: <20210319224209.150047-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf984369-efef-43da-678f-08d8eb284659
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31607BC79F1DE10B55E6DF5EE2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt2cHZm447l9rY0BDb8Butcwk4Rg4x0CZJNgmYmTuPLdN4OyS8DfKxsDiMxnpuCQOYnBN+9A2A4vw0HIhDr8YAhf+pXhyJvs5wGG2DF5fwXCChOLUhLGJ5V1THVSNxB1JNGu14bUa4DPWhWIVofMaZbzpk/8MU3zAymHdXrzPp7rtsd/qbEY7xG1qBKSoHbRn0vJ4O86NcabRPSK4/GevLTtICHx+/lYTdrVMUbHgwDOL/zx8vLhgrHVw57VdW2xn1IUv0mG7YvjDehkCS3WJBmykLIKwitxhV1ysdDImlExLxsOVDqtz3ZnD5Vh3ZUpnhID5njQoDmRQuSWHIEYwVr5BTrXrOS+xfk7QN2y103iTnAZuQwX0ajHKBwzMaikparZlrfY37RbsNn1vZXZdc1fHrmUUeHpuVl2K+onbVsopQZ2AX9Zae4Y0bwKZFIRvmh/nOp3K3buav4PeBonPBGYi/FNSfsgTivrKI5igNWbW5N2yIFLw+WVFrGW8fTSkpcKyfeWudWSMyZAlxVij4ChIuxWf3L4/vXGeWfq74zcizLIi6RkGD0mQSN6FvhSYovdoz1alpDcN2aM7zRMODWrhQVHJqWZXK+cJ8OnjVj6wBY+852zlomUFFQ9c+t6zaJ56g31zFGWpasEQt1fRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f/WjJX7+4wbr3kVb4Qih2HoEhwve2Rzb132WT1yKH96WDIwx78I9FuQP/tkA?=
 =?us-ascii?Q?qywBPPg/gAzE+Wz96ZGBK5/qPxySOvAJxghq2OW3y5c3jtKgC0ZEBUVuDAyt?=
 =?us-ascii?Q?fFE81yIbrQQMO9mpP3QVbqfESQCNfzrg5Ev/pFl5jcE0tz1N8+yeg184xjoW?=
 =?us-ascii?Q?Zymgu/E2sJAXj0LL2k5AHNOjTdQde3aY0nmA+ehIwfC+N3gI8zzAScYwkKcN?=
 =?us-ascii?Q?qTYSRVgAgWsmzLIjMHTT2uENVLH9NBTj9zlMcd+FCnPPOjamMKQgL/D1tinS?=
 =?us-ascii?Q?ug9pdgDqxueQs830ktjV0v37CxV/HcQVsNInlJmA4ZSB96WfchTP1T978xzo?=
 =?us-ascii?Q?y89wfqafcz6X1iedf1nGCb4tVnOVnS5KM2+d8VEqYf04ox5HbAfJwWseeall?=
 =?us-ascii?Q?/d0uRCdKni1FZleXOdPpBkWXLMQBUQ+imN5FBiYJqc7iSdEZDwsdJTwhKc0K?=
 =?us-ascii?Q?CS8PUjw5+BgouMn6j7xfgvRfL9aCk7zVkd1jUHIwVxHWQaBgQ4kTZrAbSp1q?=
 =?us-ascii?Q?Mo0NSZKx8xPa4jxbI3YIHGI7F9gM/go2xqFcqay0dCoLQEatG/Z4ja9LICZx?=
 =?us-ascii?Q?7d8MLmwvmvhwhC/pZPfcEoG9OuCiz1PPHcKqlIjCHJvgGBkHt0xDgf4qazN5?=
 =?us-ascii?Q?zj/PLWhf0ymlt3VJCF+mBkxM7t3mHSM8pRpdmR9SrJdwz+uxw21KMZTFlaQu?=
 =?us-ascii?Q?mpwFb1slli51oRVJeSO8/C/vrAQTSsvWJABZqzORzwvRcRdkaH7DGLG2nvb3?=
 =?us-ascii?Q?ZZk312UgYx03dmGYeQPbRQv3S7EfNDqIoGqUoXWnWVeuvC+5GruHOT1P7Amt?=
 =?us-ascii?Q?hpL1/LuSDw96T1EpeT8MI7huON1tjrvg8M9ce/YHzycJgf32IMt/TMoaTLB1?=
 =?us-ascii?Q?UPdStCehu3wIFm52/tAtSGT8xTTcsTwgYKir9m8oBr7iftmin7J92/ZYFnbK?=
 =?us-ascii?Q?swmpA0SxnJ6Y6y0y8v2O2mP8mQ09TKU7TaKa20b38i+Pt1EmpL5acYS2Yur6?=
 =?us-ascii?Q?Oh9G80K8ljK6XTemuQ2nMSiEpB1A5sIMJ1wF3sYhl5f+TqDNgq0W5tAJ8p64?=
 =?us-ascii?Q?38o48Zz5Szldd2N0e0K3s6J090RTV0EryrrD3DopIJOBm3XVIGGzfNZItn1l?=
 =?us-ascii?Q?BcDPrfXAEnC2StUY9iuFMJ1Vu35xE7rf92V7UwlvZSnbCF9uwvV/hsjHFqC3?=
 =?us-ascii?Q?TEPXQeR7ul1f954b24Oeji5ZZYTAKTHgC5v27zhIqZnT2uYyYDNCd/qYZNt0?=
 =?us-ascii?Q?0eVvu/ChsreSu0IlTs/bM5QWJpbsEFk8kckK5Sy/UOq2LAAPh+6MLKSOydLA?=
 =?us-ascii?Q?OSSn+BsIZl5pfExl1ZVvw1nD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf984369-efef-43da-678f-08d8eb284659
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:28.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwn+RoP9kheDfDfJj6Xwddz4X3B2uRzAXru56f8qvW6Y/aGkgs54kS2BpzL39AZotMxqr9NAtAmf+LcmgIVxbQ==
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

The routine set_max_huge_pages reduces the number of hugetlb_pages,
by calling free_pool_huge_page in a loop.  It does this as long as
persistent_huge_pages() is above a calculated min_count value.
However, this loop can conditionally drop hugetlb_lock and in some
circumstances free_pool_huge_page can drop hugetlb_lock.  If the
lock is dropped, counters could change the calculated min_count
value may no longer be valid.

The routine try_to_free_low has the same issue.

Recalculate min_count in each loop iteration as hugetlb_lock may have
been dropped.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d5be25f910e8..c537274c2a38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2521,11 +2521,20 @@ static void __init report_hugepages(void)
 	}
 }
 
+static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
+{
+	unsigned long min_count;
+
+	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
+	return max(count, min_count);
+}
+
 #ifdef CONFIG_HIGHMEM
 static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
+	unsigned long min_count = min_hp_count(h, count);
 
 	if (hstate_is_gigantic(h))
 		return;
@@ -2534,7 +2543,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
-			if (count >= h->nr_huge_pages)
+			if (min_count >= h->nr_huge_pages)
 				return;
 			if (PageHighMem(page))
 				continue;
@@ -2542,6 +2551,12 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 			update_and_free_page(h, page);
 			h->free_huge_pages--;
 			h->free_huge_pages_node[page_to_nid(page)]--;
+
+			/*
+			 * update_and_free_page could have dropped lock so
+			 * recompute min_count.
+			 */
+			min_count = min_hp_count(h, count);
 		}
 	}
 }
@@ -2695,13 +2710,15 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * and won't grow the pool anywhere else. Not until one of the
 	 * sysctls are changed, or the surplus pages go out of use.
 	 */
-	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
-	min_count = max(count, min_count);
-	try_to_free_low(h, min_count, nodes_allowed);
+	min_count = min_hp_count(h, count);
+	try_to_free_low(h, count, nodes_allowed);
 	while (min_count < persistent_huge_pages(h)) {
 		if (!free_pool_huge_page(h, nodes_allowed, 0))
 			break;
 		cond_resched_lock(&hugetlb_lock);
+
+		/* Recompute min_count in case hugetlb_lock was dropped */
+		min_count = min_hp_count(h, count);
 	}
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
-- 
2.30.2

