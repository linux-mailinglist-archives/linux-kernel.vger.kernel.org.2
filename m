Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB57235A824
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhDIUyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhDIUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KnFTX070792;
        Fri, 9 Apr 2021 20:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=3wVwMkjo2Ou9kKq/aTmPNbq1CAbDNjcVaM/Z5DzD+p0=;
 b=tsVhhosUSqicg3YAkNr7WgXS1uaD4D4+9Ylz047t/HKT4Tjlj5knBZsQJHFz5ps0/KyO
 Z+8qoit9HPVkLk2erj0HwAvIDlJIcyotJvDxpDuuZstqQ7Dayzadq1m/cB/3I3jSEpvi
 mvfkpQinsB3rGnlHs1lE1+m5nYVmtH7QLTyACgHCfwMqHcY6wQSM3FuoqoHQ4FjZqi5k
 k+qew084BGAEPnofwzw33NteS1XZxYzHEQeM/coflJhuXWT7XksHq1UiYwWsLkDHRtzk
 W3sIsM2TeFrsYEJV+rHH49DjbqqRvwfdO5579d/7TUy1Y8fxRjFlX5s0vQKLDBfV2qlT nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37rvasaq54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KjFUd022483;
        Fri, 9 Apr 2021 20:53:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 37rvb30bvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOZSjEPmv3x+pheCnpqroz92279rDUgNpKr1vc/Zn1zNKmruZUvfX+M+TTy+r61JnE7DHM0PsUOrTepHUOFrCN7h3Ovzq0wP6trMOfdT46Xiw5tDLyfvDPHtHjPRBt4MtV2JuUbcx7TTqyUbQp9Zy8YRJqgzHhd7lDbkYSMmecGqC8Eqslce4GjL/rZWo9Uj/BnW8AZDkdAjrGTx7TORfaPOjsRBIzck/TZFwB5cP0nJCTKOfbGDpoVTgszz/Z62rYrNsMJBK0TLpHCdQ2qlWnN2zCU5UHpFe7enwD78nPy3AAvmZpHAxtw7Mu5AgRlQQQHwMhJBMIRRG3GuwPxhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wVwMkjo2Ou9kKq/aTmPNbq1CAbDNjcVaM/Z5DzD+p0=;
 b=XopASjQcXfAd2JKynu6FUq0NjVKse7yal1AM8Bh2EizfD5vJo/lqB4PgRfuVNTV5Cpm4vLskKJ6oMZH46wBUs3JRRMZWGMA5CIG2ecXKejuGI5awtil65yt2wPyo7RTlDTXBdA6k688+H1kIO8bNZZDx0j2/yas4SjvS8V+BOHxlPFQYwB2dOIPpEdxpRPH33VqFQErWA1QUIxPsr5DIgi3WL6FtglTB/g2XGcGOI+I+yeoAfK4GSAh5VqoHBPQvt2/T1LW9qdKzDnnxt3sp/yOjjqgCuRiQh/IN50BucuZnx94NiYgCsL/TxG7/wFqXD+WUP3hTjOmF81QQ1jCG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wVwMkjo2Ou9kKq/aTmPNbq1CAbDNjcVaM/Z5DzD+p0=;
 b=kxDNDSQ+l6v7km9VrUReji03Zsr2hTTQM7yyxktCnUPwBHUHVIroqYCCHAMI5USA9wuWFdnz4gIL7EAZA7TJXtoT95I91D12CRW6sWg1OVM1RGUwDqc8pf//C2rdiRllFeNxKXL3d57eOXBTntS66dFlWrfHgtTCxG1GurWiP0U=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:10 +0000
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
Subject: [PATCH v5 1/8] mm/cma: change cma mutex to irq safe spinlock
Date:   Fri,  9 Apr 2021 13:52:47 -0700
Message-Id: <20210409205254.242291-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9059c936-73f6-4183-4ac5-08d8fb997c26
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39723FE0237CE29241E311D3E2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF/qh+Q4bjjvgbnH7VL7hPHQhAkg2oDOxmiWLrC0//5jCZYm3SaRmmMdfxEXRjAqx53cHRo5Wk/d0GD1ayc7/XZIXwVSeRSUnb9VPnM5moqpZWpTvcN89QJHE4Tlz70+m1avfwYSHOcHKuaxPj77J5Ej+takRFBVU7mpCmrkEnzY0XrXeQwvA6Hqii1NDgJfTYjYaoHUT5+wVGcGfmgIyuPAo0ECRCZBqZ61XCf50HYSf9NWFn90dzdivVFi6xDKdYG/0vrG+jk4HS6IotMRkGssMWJFhI9Ra0H1yXZKsJgmlXU9SK5MwzEfPJhjVJ3uZwKu3ZFRxfYgOqsYj91/X1tvATnS0dYKN+xy1qPrM6b3wcH+js4+3QAhSHnhGo9toZbQYzDTWcLSV4/WfqWGWUVa1mZjqf+2JPPTZJ/FIBC6c2LCfn2o+aJapSPwbNO9Ax9idt6QPSxaahDLvpnAzvcewALZ+FB9xUZHrM2yzI6/C5iUYIK8sHOKU33hAKq5145fwo0vKb7OaQpO8dzs0w8Tajgkk03dikyqqRCFf/1JAULk14tHLFIZgt3rDU32MGQ25WZrqjj9eqc6Fc2KjlXs86WN00BILNI0eezdUb6Rax6rg/FVk0TH6lrvTWevwYV8BXj65FWKK/zgOOOSeJebZVEOQtW3/aGKILAVSIjhCdHNKwiU/OMvkHF9U+GK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ne+pma5PdNP5YpcsVI8N/TQIvabIF9NDZIT0k3lOEYYmTSwqp9twZOSdW0em?=
 =?us-ascii?Q?20iZXI/HqLPkbHsT7eC26qBtSapRZndPOOQD9UtZGRGORsbAdfbJ11IUyiGP?=
 =?us-ascii?Q?q4SQYFncvcJhpd3qvwTyUtW4IJyGBegvk0Gg93KwWCdfTgVzWSkBECVnaXcj?=
 =?us-ascii?Q?NlftNKXxFB3W7iCtkLR5Aru3tnBlknT6VDHP9QtPig/DNLSv6fFNPoSsX8E7?=
 =?us-ascii?Q?+GX5puVZHsR4XC4VohYpgzQTOlrPBaVMhz7f/fON0waPcMYsjC2WhpJ2RdA4?=
 =?us-ascii?Q?oQIKBRQd39Uia5IshIU1H/VAAzuO0WtydVD4QwlV6nOwzuj57aGQ7T0OIKbP?=
 =?us-ascii?Q?5e9cEuqyz58PbqWQwKRb5SB8l4T6YeVkVAF2w2rcyk6r+THIyNojorzY0DEW?=
 =?us-ascii?Q?qDgZwMMIRVvW2z28wrFTHUjMqXOMxF4vdJ9VveZquwDzVZMPeryG1hB7lyfg?=
 =?us-ascii?Q?goSUrCP///CPGQHB6GVknR48HfubigqLwe59wTJ+CNEZWkdCMjnKWNUXl6FQ?=
 =?us-ascii?Q?6ZiVVS2t6p5mhlew9e90gzbxZfLxfUOnF5ufll+kEjikHa8Qo4mLSZBs4Cfk?=
 =?us-ascii?Q?/P5aw80Ztn2cyCf11CbwfAbqj6jEZmKEmt93lCCi/UMHH7ZIhghCoz6wxOVS?=
 =?us-ascii?Q?4XMVKTbMm4NjBzM8XnEIDMkEOitj/s1kYTMg/on5CjViQpat5gjSFDqV0PS+?=
 =?us-ascii?Q?BR+zyRVRCEeqSsfJWwoeaA6iNEbhsTx1wwhTiNtYenZvVGVc9ymCf8GPiuJa?=
 =?us-ascii?Q?98K7aGHhSBHcWUVRO9FovDIQ94NAdafYmoH9O7P0QXDATUlxdTTvNkVcukGv?=
 =?us-ascii?Q?Ye4aaF01HruyY8dfxxVHd4/c1I9qi/TPAciEyAaoIRCO/D43OghUA7NZfbzR?=
 =?us-ascii?Q?0/4s17ajSz9eWQznRYlkU2zV6WUkvPKU4yhN1HmUybMKAgrpoH4/t82H/L6f?=
 =?us-ascii?Q?mJkCphiKR0rcaMqPEd2HqedFfUxueMT4VmdeP7Cd6AOrefBNfQG//sKs9H7f?=
 =?us-ascii?Q?dYN4jLSNnOqBkKTV4FAhdJ4BrFAHEy6e18O6m8zJL4E/U7JJz5b5Ozi3Vqr2?=
 =?us-ascii?Q?rRiLTZoaTfbSWutgb7N/8dVf/I7E8xyappeZCpQatB8D3hW94lwEhOBgzCJX?=
 =?us-ascii?Q?pxpAixBj+7eQjnZIJLtEZ68kzEv60T9nhQhk90KMqwLNTivhwvwaxY0Lj5RF?=
 =?us-ascii?Q?+mA0JL6d9iQeaJFULprmpk/eadF7nM/0gBkO7EhYd+J57I/g6SYvRVhFenJO?=
 =?us-ascii?Q?s8cJch8KpQ7Sio2BCKPhvj3lwEjp9a6HjOkYHfzqaQRzM6D/Uq5v0OLBbw7c?=
 =?us-ascii?Q?bSAv/2qhYSDV4BtwDnWuwshp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059c936-73f6-4183-4ac5-08d8fb997c26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:10.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNv7sxrtZittZ3xDiNlXhL0elAzCKwCFnyqdAzHw38kZEQh0W0XAnw3NM2T8h2Sow2HDn5s/P2Qo8VrculRoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
X-Proofpoint-GUID: Z10HSZcqLFaat_LyEweLj1nZ3RuCTB_e
X-Proofpoint-ORIG-GUID: Z10HSZcqLFaat_LyEweLj1nZ3RuCTB_e
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
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
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
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

