Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D33EE01F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhHPWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43428 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhHPWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMm00M013214;
        Mon, 16 Aug 2021 22:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8QTQAqWYQLsqdQLgAUxfRRVN6/xbU+jI70PG4q8RsTk=;
 b=fvrDcqy3FiV1qvSbD7Vn8yEi4fQ/QLe52HUWFEZPCcxtTriCw2+VPiSoiYK3PaaGlo/W
 cXZHgFH318EcaQCSkuCpYKDCg1N2SLh1atgqEWQ8LCNS2C3Icwq/VMIENINyBltxolmz
 R0Qwo87D3pjTscAsvdiDsjaoEaQTT8pE153LQdnFScy/u2PHEkBbp0vijJVsah2Ra8PX
 CtYH2xMFHU6OZdaWCn+0eUkjCcOvPgtUAH6kyKjC2avO+d9ZGhiQ95g24OgdklSJ1P+4
 qRnNcl40aI8Ocj7xe45xpjboUlkY/xrLX1wB9JXruq6SIsueONdt2v+LR8LsE9KaMFso Xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=8QTQAqWYQLsqdQLgAUxfRRVN6/xbU+jI70PG4q8RsTk=;
 b=w8NuNn/BMUXLJ0b0fVpKdh0GmUeSdEeu0Qs0p7qFW2DkZGqsXjR7XZO87Mojrok0G1nd
 uHzk8f1SxHwr5X/X0QUUZgXZth5Em4baiv03DsKWwFSBs+XnBRUnw2v/qoaRpiYMn/n8
 8KypX8LzavTde6WIuA2L54Z4tiVxiro6iDueZtFuG5Y+sLjJdQyUIkLyquLZZQnjzGGG
 dPeTRqyYXqLihwnxJJ+LuoLPWUiPrfc8xTfhmRQeoM+7UiWE5+XK2nhpldQpGVzCqdFj
 ENxuO0Tjs1IdKemzncKYx8j75Wz5wz49z/JSrKMmwBh7f88fzH/8A2bNAEh7qempvSL6 mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd2ndc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMiu6J040104;
        Mon, 16 Aug 2021 22:50:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3ae2xy13wd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgWy65du2xEr0T6O7cKQj1cgr/yWjhbgU6y6if7JSlY9UEyszjvFct3owpi9oqlZ7gz0Em6pBzEojhBWy1eUK1RXIq5o2dOibasX7VfnM+tO3004mbLYImJTJBcl4xOqkD2a7nlwmeSV0KpxabIhIH+gnB1nltd+IRxD8GoPAAwODi2mv2/aJdjIFdJZ5xxs2dE/LW0zDWMp8KBO2CZLnzDA4Cz7X9NNXs8tFsL19UddcMmPGaxXEMuE4lz8m7DYpjfKzHaK6hBMJ3jqJ3PgfSu39yNC53PpaHkW8ZSu2Nr++BM2fvXypf5Otk0pHoa30+n5qI9zxt5zBdgWBvyiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QTQAqWYQLsqdQLgAUxfRRVN6/xbU+jI70PG4q8RsTk=;
 b=OG8KoI2v7PeBNoNc7nakJi7MeMpg00RnM7aMR3Slz8lGZe+mpyLbAynhuWJEEe52/haBvrj6L4VbZLGIZg6g+KAsenFadvo1i1b60lcLH4XZQ+fCc9dydj/ZvwMsPZbJf36vDeIzJ0n5fycY7MnzRbX+qqSvB0XQrQw54FMMmmYQ83TqOYsGD/jfIQB/nUp512jqQsEM5tDgNlA5sV01mH+3GvJtsMVjkVWFL5x2Ud5qUkGT9e0VdskToH6kahH2Q3xndNevaythwZwJ/yJhNN3+IQedVf5GIf29gS+3zj+u+izqR2YbWfz4nXTUGJpeQlNR6GZKCJwZxbdIQI4BSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QTQAqWYQLsqdQLgAUxfRRVN6/xbU+jI70PG4q8RsTk=;
 b=JZT4yHSURXgfH17mX1eFxZCp9SdsDuRWd3UzJoH2Cvd74YrAdPrfR7zf+Cj1QlLhaaEThmRNYTlbt2x4lKnSXYyc+lgBUcKJQMPtTejlhpElxtW2rCIqdYwTv7YSrzMnEPiEjfD3aau2wxMYoIQs9jQkQ7G+H/8UdB7LgmTUZW8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:13 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 4/8] hugetlb: add hugetlb demote page support
Date:   Mon, 16 Aug 2021 15:49:49 -0700
Message-Id: <20210816224953.157796-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffdf9579-f3ea-4064-6d20-08d96108358f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB339722467F04C8E23757C07EE2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9MwYREgKg3V1a+BKzGaj1n0Wqa6dcnwRi4ZV7zfdQGMGMStw7XtZthAIq1WHoq31UB6xcHvsSdBQubF7DJNUosyrXMeUM4ATumW4NgDt1DeGZDiad6Lat26j3e1TlLq5vv0gs+sGAODf5dLfucgYgUEZ59MVPPluthfryA1DqF21B4fIzFztoMqE1gRUrSR5Lh0hV5GvkmyuGfh+pNYV1yI7Rf7B14Jx/9I1gPh9gJUpFySqL0aaT+TRmKKwn0sVJ2XwijYF8onG0hsNsxvUMshNAE4adgDZfHq6hm83ueBvQGklkE46deNFbqYzNO4i3x8RmXWBkGOvVvQDzNbzOBq2VYP7uQmbkpp7YOm4unCEtTI1fY+oF+A2gvhI5gzrrkvUrkscKjfTTOuqmgYHqRPb3tPBrQcEvdL4+I8BPFItl+yrIJIxsUV+pg2RK+RkbuOGUC2+BOyE1Bj27PeH+b05/dnlaBoU/RXSSzyo+l2erDn1k1hG21QZR7AhfcdmbCjbUtSifXE0KWlszW/qrLw3D/nxXVOryS371ethgIEucZbwoDYr8+wQcGXQ7+X7ZHiVbNceF3jqZ0liC2+2VOsEjB5gYEpq6985d0oEb6qEZxsolRyI6N4S2J85HQJ11wd/UkNzAtbzYDVzg9ek2dmZucL4lkUoe+Nas8HLM1E5u8ft9ZVFY/92Lx2DD6Q32O9VqBXGmYy7k7wYUe5lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo+uFOuTNX6Wc3HsZkWDoLdNyeQ0hxjxLIUzK4WP0nqH/YKDUxP8sBccTaiF?=
 =?us-ascii?Q?6g0pNsJglIX7hRsrQoXp0MMO4hx0xZ8WbTDWgQc/KkM9Vy1N9pj/rieyNZI2?=
 =?us-ascii?Q?mE44ORaoHdb33dcCkU2nzLLawngPDe2PoEb5yUgh1mIaQ7r027UeEltWPgUX?=
 =?us-ascii?Q?mJ2eZgFjTLCbuFFPUoc88+Z2ap1VuJrHXcDe+c1IXeFWVgwQGUyLdJrTMpiw?=
 =?us-ascii?Q?eaUhXYDBxyUq6WdfZU3E3TE0nK9aM9lGyqfmT8fk4zkxDD+XCyIIk3oQVy2Z?=
 =?us-ascii?Q?ALQecXN9wD9R378kV0nj6CggTc0XQZcQQZ3a3zN0WJrfziKmMEnHo//ODpWw?=
 =?us-ascii?Q?uyGF7t9lwwVZDBmTqIwnlFYQHp8EELOXsHqZTEAwlI43dYpJrDMvdhtZeI+s?=
 =?us-ascii?Q?1QnuJOipXVFd94PcrLEQST8SYlP+jwY40BpvGyXyFD0somWRfg02xXn55Xu6?=
 =?us-ascii?Q?ZwilNgNlBze9kFSYiXgG5g38lrfFq9vK77uXwjN/4a+jnAwON/MS37oFxLqi?=
 =?us-ascii?Q?n8inXt9g9GYreBoh0iWlwEc/d3AmCSqsjojzSLZp8O04w9Nf+XMhF8j5Q61W?=
 =?us-ascii?Q?hIqG/+Esw5/0BndFkZqIr2R2lrBREpj5wBnLsWxuac74WLbxagbyXZofpqeu?=
 =?us-ascii?Q?kso4eKpS8auOENj+BapZ9nu/MRY+xBn0Ffl5RGArL8ooN04hcPs13PGPIHlh?=
 =?us-ascii?Q?Rh00epbMM2DCC8BNX+WTiK3Ik71KWrXyTwu7nk/pZwHgE+dCjEJ8GpRH1RPp?=
 =?us-ascii?Q?Mxc00fvL+rFZKo0mvdeTrjz2R5W/zoDPGT8zszsP7de5ryCDDnW+uELantSQ?=
 =?us-ascii?Q?7YK2KROlkXy0qFjcNaBfas7FhdDj6j8oRu70yf2mNFgPo2t4LQ8mzeokqT80?=
 =?us-ascii?Q?31iiaVoRhWrKkgfvnzNrEvfrCuXJMQzMOilJNnfwCwkAp81EQBrQbb5YO91g?=
 =?us-ascii?Q?H5rh0dfo5ycFMtOkqpEeGLfOiB5MTD2AkQOeMlNwPh1d7BB+2f/zc42bqq73?=
 =?us-ascii?Q?wf9cIWT3TJ9kCoVhR3b0u3bbyidtyFg/4/tyIlj+vvfvBomd0+IOCLqW8KPg?=
 =?us-ascii?Q?sUxuEG7kE7ZdvHfFc6wyBAMlY1pz6zMt/hjTxxsqWXBh/5Qm2ae/8ygjPgb1?=
 =?us-ascii?Q?HnzZnHDE7C7DgArW9POPmgTP1MrE6GRoHJojnKUEhVJypD7b0BtPZ/0PHvee?=
 =?us-ascii?Q?x55Y7T2daYs+EqbFftGfqb2VTXWS3nmA4WIw1NgUBiYdfru0rNgOYuj8KH7O?=
 =?us-ascii?Q?cXJHYd0mHHw1En5Z9iNfFVDyH9t0IGPUhElm7/43GGY404BnxCeVXEV1YE/B?=
 =?us-ascii?Q?YxeStR7S9Uer/Gon7t5qACJV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf9579-f3ea-4064-6d20-08d96108358f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:13.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xtcAeH0RSRgRgfZm4LutbQ2sZOHUb1AgAX60quE5LSlcmdvAlG8cy63jbnRT6d07ktfI+RD2N6jD2jXZd3CEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-ORIG-GUID: oWhduWpMv38hWC9bwwpcWjx_8jlquBiP
X-Proofpoint-GUID: oWhduWpMv38hWC9bwwpcWjx_8jlquBiP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Added '*_for_demote' wrappers for remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page for use
by demote code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f2d5002fe73..6d43523a1a4d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1289,6 +1289,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__destroy_compound_gigantic_page(page, order, false);
 }
 
+static void destroy_compound_gigantic_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 #ifdef CONFIG_CMA
@@ -1428,6 +1434,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	__remove_hugetlb_page(h, page, adjust_surplus, false);
 }
 
+static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, true);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1777,6 +1789,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return __prep_compound_gigantic_page(page, order, false);
 }
 
+static bool prep_compound_gigantic_page_for_demote(struct page *page,
+							unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, true);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -3294,9 +3312,55 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	bool cma_page = HPageCma(page);
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	if (alloc_huge_page_vmemmap(h, page)) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return 1;
+	}
+
+	/*
+	 * Use destroy_compound_gigantic_page_for_demote for all huge page
+	 * sizes as it will not ref count pages.
+	 */
+	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));
+
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		if (hstate_is_gigantic(target_hstate))
+			prep_compound_gigantic_page_for_demote(page + i,
+							target_hstate->order);
+		else
+			prep_compound_page(page + i, target_hstate->order);
+		set_page_private(page + i, 0);
+		set_page_refcounted(page + i);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		if (cma_page)
+			SetHPageCma(page + i);
+		put_page(page + i);
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	return 0;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3312,9 +3376,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		return 1;
 	}
 
-	/*
-	 * TODO - demote fucntionality will be added in subsequent patch
-	 */
+	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (!list_empty(&h->hugepage_freelists[node])) {
+			page = list_entry(h->hugepage_freelists[node].next,
+					struct page, lru);
+			rc = !demote_free_huge_page(h, page);
+			break;
+		}
+	}
+
 	return rc;
 }
 
-- 
2.31.1

