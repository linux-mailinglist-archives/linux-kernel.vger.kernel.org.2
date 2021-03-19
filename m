Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EC43428D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCSWnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMdmun139912;
        Fri, 19 Mar 2021 22:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mLbWxPk+DV9MUgdTJ++7u5WZineUPSEO95Aqx3RVqk8=;
 b=XmejMrCbbNFncO7VBrul0eoRREDiTEWiDwFyXgla3a1mTWALuyXINiZZv8fw+gqFVILN
 LPli9MNck3FRHIk6E6wq8WhtbaYSCPROmAi24nJC2u35pJcCjA9CML4TvBz9NZiKIn0E
 k+g+VONl7/rS52JA5Zdwf1O3sI4C+ccCkuKUUaKoqjedX3tTU5vx6mofyCkZx7e2Oncv
 +vBuwk8WxrIjxToLbzwjTP/S3uUpxJuS5Rd+SveRN1kgroKCylllrU5IHLBDH3ts5KLn
 v37rB+6RrD0Xy5o0qViPbcuUD0YcsMYgaAlFXDnpxxbfBb6uHZx1flC/VhckkSTbhFtY CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 378p1p4dpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMer30001735;
        Fri, 19 Mar 2021 22:42:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3796yxyng7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVdV8/UabqagBSYUVvdHi8rOlJDktJ7nrKNychstyXAd3cOZUCEEU197NidmSF6Z6TfUig4m1m6z4g2f92dvo7cYWEGsY5fC3xhpQWp8/FewHhYXqTZx4jqdSWatcF1BiwN0fKqZhmZArUDZ8LuCNfaRD0C5ajWwuUwryOZIlrj7sMPtcxRs8P24gJb2sFSBakAgYDOLSkB27MKLxOv+kH6b1JEfYBnWsSNLNH7fb56M3t6VjfIRRzyuSCJoDQq+ZqqPs0xl5m3B9BgYBYufqHoY0nyCMX1uISeHtPy//i7Mo8bFhtwo6Kpc5TIUw5bLFL2swEWYSridz8pW3gIF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLbWxPk+DV9MUgdTJ++7u5WZineUPSEO95Aqx3RVqk8=;
 b=WRR9KESANNR971elv7wOUkKibzNoSoD/6DY1RwavDzAIcddRZU8CCUdZdeT2J4f1eGq9wDvbWw1nsrma75QEV8x9i7ICQHi0ylcwKVY/xsUge26hVu+UIuxSmgRSD369Opp+R7h8+Qn6BFmigfwtwctDYPIOznyE1OHLaoTr98ddknfsmVZAVgTwZ2/QKO8IQ5Plv4YgQMu+dfD0PVtkdvsI6cyIe+tMeoygvV85hnBJIf/plYaeDp2wf1ByQtugrUuI4VbCncwnBjJa42a1vHqy7IHdDz60/KeAg2DwfWcajjXGrrk5X5o8wfyuJuwtHKcPyYPFN3GgQWIP1ZRV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLbWxPk+DV9MUgdTJ++7u5WZineUPSEO95Aqx3RVqk8=;
 b=si6E6KxU2UiqGFd8zumeYx36WwHrLAYwSsaV0iz0fuDDmDR+dKcd6wdL8J66OvV1dw538xGudHtYCiVmJ04ZdlW6iZ1wPUOiI82TBfq3Zccyjl3hbR4QQQyB4ZF30j1YdEYKtZsgnnGx29yOWXC49nZokX5SyrhqAi9zLqyKaIE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 22:42:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:41 +0000
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
Subject: [RFC PATCH 8/8] hugetlb: track hugetlb pages allocated via cma_alloc
Date:   Fri, 19 Mar 2021 15:42:09 -0700
Message-Id: <20210319224209.150047-9-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96c9ce35-23cc-4096-a371-08d8eb284e01
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4211FEB5DA910BF8E23C7EF4E2689@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+Kt/obVxyrx0x7kBf9c0k8AtpX1TC+76rVOGw5NdSbFPLwL83Qkh08c+mYK46GYbW/sy1mexShCLGi5tdzO29UiuCXAS9U3ClJQxYiMNwhq0beAj27xyNFp9d1U9DLHYXuul6we3bBNG91/JwDWwWL58i/lEC+yJOxLN1G2WfTI6/5twgm3vKFrmcCikZR7qjJwHEAshFFslkM8F/1+UhyWkfyJidWZO6XzN5uPZu7zUglPR2V/GmJnWHdxjm5B/41ToXXWQxc9e7ADFfnaU4Z9jdivwNoxXPh7yHDnKRp1iQMiV9PGNdNYqr0oGJAPVfGDr7X+1S0j4O3s12e9VE7CvAVU1mPmLQvh2pQ3GsxeULcpkrGFlklhq2k49OT5IkkqiOEyygjLoK0CGj8trZNzyU2pmiBiUROJ7CRgGdUqSKUxGKGz6AQctFJ9s7qOGpuElbIrcyA0RhD+uYz+0UKhSR4Dup2dUm9PUjlNk4Yd8b4sMTEkkO+sBpYLifm7aW1Z1SZo5RgZj4vuBvgTNoO3GUyHJxru7F2feiCnzWR2QJY3VgUNcyKOyqyqfGjL0XzptkaBl423YITT+4FbZU9QQ82Kh/Cn2JtRrWf2k4H9lE6BPx/U6mExXnrG8PNo3FZynlM5Glb8n5U7bovWMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(66476007)(66946007)(36756003)(86362001)(6486002)(16526019)(6666004)(26005)(2616005)(83380400001)(107886003)(316002)(52116002)(7696005)(956004)(7416002)(2906002)(1076003)(66556008)(8676002)(186003)(4326008)(44832011)(54906003)(478600001)(5660300002)(38100700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EDPuktvNO6Z/QQrqlDcNkT7n+Huqa1rqLbDm9wgNID0KREFH3ZGMraitU8aM?=
 =?us-ascii?Q?ng7V4n7fuHjhSymhSsDzufJxLdXt71pUTOvVbpYfIba8/KjKlHwAi2lHRCS2?=
 =?us-ascii?Q?0ktwXZnGsN/1UquEAAqmvnhzgKWJbgbjXYMqJyhzIMeY5GUR1fna8LkJVzdd?=
 =?us-ascii?Q?1IeJ3lq3hLyZl96DTvXAF1urJVITfPws1pKk85bGdmC2nEs7jeSqWh7G8keD?=
 =?us-ascii?Q?b0vYNaLGaeGKVYwy35UVL1ODFFYMXYQNBiT2/Z0ZEsdyXRceJ7+1M8jPG0BK?=
 =?us-ascii?Q?PhyyadRFXjkBTYYrBZ5Uz0hZN/piqcMhdlLE04eLas7swvFYw/3e9jAbUrqp?=
 =?us-ascii?Q?sOv87VXuIXo7C5mrqeE5c1d/sRpz8dPlAsI4PDVWHapkU24iOxFIyzuvY518?=
 =?us-ascii?Q?39kcRnKl1NR6dpj2UX0M9eGoTLtxl2RUYU95+KDwBnf/ZuS54G8y0qj4/3u3?=
 =?us-ascii?Q?eEMuTGkIw8ikxIuWfofWtCRk8vmEKd78Y1/APdULd7iI4CQcXpuLXA0ulwci?=
 =?us-ascii?Q?peY7hBpxq3p2rH8nuZ8YWpmag6VggoEU45NkKgUy9bTiEYhJhjUWJLyt8/KH?=
 =?us-ascii?Q?Se3LShHKb5HpTiCSszlq2c0EthQlMAZ+y0szHtejtgQPh/vM3GZ5wSFiKqSs?=
 =?us-ascii?Q?iGafVIUHOLFEhWMwLukMgJYGbbeRLfnDTIUwG08NvBEkcwb3enOmo9b1n9/h?=
 =?us-ascii?Q?jpCVYWRkKMBWxOqJ0gZSk4nTziajY1I6CxswT30Y0F8OJkNRwdYRM/eTlzPi?=
 =?us-ascii?Q?8OuqLQuw13OgFvNFwdkJWOwxjcry7qSCPcdObyPcdkxtSa7qTeyhovNWr3Cs?=
 =?us-ascii?Q?//+ozde2cbU1d0JM3I9ewDnkTfQsCu6zMWCytIbPrjmZqjGj/LMLIDJ2Wq21?=
 =?us-ascii?Q?FGPd3upAZuhdPdhUIK3OoqPtjTrcctnu5MeDCeWXgH8tb/9Tv232Wphdsmlb?=
 =?us-ascii?Q?E9u5olMHSydWusL0plKjd/PiXNepkx1i11QWv+M7qFRl7eEM07WtdpQ5gY6Y?=
 =?us-ascii?Q?Yrvx2iPZlqiEe5o/5TnFtqA48AElcrIkWU/OXS6pl3INmKEnW72fxw8w8pKn?=
 =?us-ascii?Q?CIjJHx6SzsSj26m5GBSJJFyzuZP4X3oqluGAwYUlH5Xx5+vgbxi/USyAr5zf?=
 =?us-ascii?Q?8V1hFetQ3TmcyI9ympy1ThyYuvhv4lZR1Yu+qUShtx3N4NB6u7S1x6+KgJan?=
 =?us-ascii?Q?MQ9/9ssCh/j1+Kxdw1yRys9ntsHw9kET7IGdd3Gc3Va4NdwQtccZH/i3m6r8?=
 =?us-ascii?Q?rJdRkhLR6dIL/4V2ShRYMl6baqfHGMPrVdBpzjE+h/hcjfy9to1q5pKF/4CM?=
 =?us-ascii?Q?FOHXakalRWUtPRcvs6GsB/pL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c9ce35-23cc-4096-a371-08d8eb284e01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:41.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iTcXTyoM9FocI3pZW4qXKfvikj+mDPfPDmvFeURcfLjHL4pPD9/xIX3g8uEFqP+ar1CWugtVogw14H8kOj9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
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

When a hugetlb page allocated via cma_alloc is freed via cma_release
the cma_release call may sleep.  For now, only gigantic pages can be
allocated via cma_alloc.  The routine free_huge_page can not sleep,
so it defers freeing of all gigantic pages to a workqueue.

Use a new hugetlb page specific flag HPageCma to indicate the page was
allocated via cma_alloc.  This flag can be used so that only gigantic
pages allocated via cma_alloc will have deferred freeing.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 18 ++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a81ca39c06be..0aba6957a73a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -498,12 +498,18 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	modifications require hugetlb_lock.
  * HPG_freed - Set when page is on the free lists.
  *	Synchronization: hugetlb_lock held for examination and modification.
+ * HPG_cma - Set if huge page was directly allocated from CMA area via
+ *      cma_alloc.  Initially set for gigantic page cma allocations, but can
+ *      be set in non-gigantic pages if gigantic pages are demoted.
+ *	Synchronization: Only accessed or modified when there is only one
+ *	reference to the page at allocation or free time.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
 	HPG_migratable,
 	HPG_temporary,
 	HPG_freed,
+	HPG_cma,
 	__NR_HPAGEFLAGS,
 };
 
@@ -549,6 +555,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
+HPAGEFLAG(Cma, cma)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b8304b290a73..5efff5ce337f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1241,13 +1241,11 @@ static void destroy_compound_gigantic_page(struct page *page,
 
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
-	/*
-	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
-	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	if (HPageCma(page)) {
+		cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order);
 		return;
+	}
 #endif
 
 	free_contig_range(page_to_pfn(page), 1 << order);
@@ -1269,8 +1267,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		if (hugetlb_cma[nid]) {
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
-			if (page)
+			if (page) {
+				SetHPageCma(page);
 				return page;
+			}
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1280,8 +1280,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
-				if (page)
+				if (page) {
+					SetHPageCma(page);
 					return page;
+				}
 			}
 		}
 	}
@@ -1397,7 +1399,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 static bool free_page_may_sleep(struct hstate *h, struct page *page)
 {
 	/* freeing gigantic pages in CMA may sleep */
-	if (hstate_is_gigantic(h))
+	if (HPageCma(page))
 		return true;
 
 	return false;
-- 
2.30.2

