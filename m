Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3009334F792
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhCaDnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhCaDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ejIx182875;
        Wed, 31 Mar 2021 03:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=OKPBngNAFI9bp85dSsVhMD8GLSrYA03jpGeJ0VDnCJQ=;
 b=h4YgtXjJA7s1y9iOpNkWpbbyC3S83VkPXvaE86rj+TIT9U+glSI+zuf5GjNymfsPRxSI
 cWde9C8M9Sf/eQKwWjVSj/qdlLBJg6J0F6PWPO2T9eQHIT0daqLIGQr1IGkAlrsxACEW
 eBVeGMjeuj+VyA5+s71L+/bRHF6O3v6Eo456kn45YJ7nXHTmJVm6KnNXN8WUMlRiGaxx
 dCJOpLvDmqYTdxNbRELFhiVlc73SSGGEktEJa0THcfikI47MxHnXAjjNM+pGRnT3fp/A
 9mKrSnMTYcmO3rv71QNe1E7mAEz0rAzsuQPs7u0MkCSIkTB9G3+C60y9fyu1mymma2ZO SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqrsa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3fWvs086212;
        Wed, 31 Mar 2021 03:42:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 37mabkmmfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAAqAF86bFIiWSqUTYJII66pGMfTjeGjsNUYvo2zBJCHO1h7Qnzns8lnSVtAj3muBuEhgwQPQJ/yely0g9CVPBYIhupYFmYuScHyc2Y+IAL35+zdzw80EIHnB+71kFEaIfuxoPTItMPems0UtUBWDqXpdnzg65Xza/YqjOcF8MoMsr6+9TLVzDaoK7PRZLO2eqzgPzIRu/oh1XWf0LW/3EG+XjJ22H/Pz3U5qNWUXeqOr3klrDMd/D6JXduyXHMdEUseFTikImZf6zqC2kDlS88fXce59d5G//NV5sOuIKFeNwBm98dFNrFhBn3H07KS1+XTvEQazLNo5mEqiwti7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKPBngNAFI9bp85dSsVhMD8GLSrYA03jpGeJ0VDnCJQ=;
 b=m0z+Wow87pfBZVtlF3mBwK0+RVsDhajJMgjNRl2g1mdDzkSeA8/TlpfCN0E6D7Q+pPyQjunZY4jIiBLmIpletZ/+Gy5T0dsi786nFtXaajhEK8m0aQyEcrG7Et3O7+QMUbzIlE8Zb1Vi3ifayRdcfMqvy3px8rNhzw0ZrvT5B1u2+3raOeVUWUOhpcah7cy+bvf8v1yXaXpUYIE6s74sceL5cGj/YpiFUubRj/grumb4f4Vq0NMtQJDXxq31wdcIgoSPade7NnaYPzYYLe3+13F2AG8dIfT+f9dRQ5ntFh6IyX4LXde1tTFqUil8NIFVqL8UEiy3TGEYtlREO/uwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKPBngNAFI9bp85dSsVhMD8GLSrYA03jpGeJ0VDnCJQ=;
 b=bdNR5hz9gIXebZj/Vi/MIqbhEEcc1xs5xRd/8GAoxOWLLQwDrxIUcI0VUBkY4jeMtH2flA2WRIOos62qT/UU/jVpvNuyFFePWoX5RmltmmmKZA+ViFvKvqbcVHsUzzS2IN4YTcxWSoQl5L1JsnMxZLPFksl90ndsTzVoMBxnhpU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:02 +0000
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
Subject: [PATCH v3 1/8] mm/cma: change cma mutex to irq safe spinlock
Date:   Tue, 30 Mar 2021 20:41:41 -0700
Message-Id: <20210331034148.112624-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1246689c-768e-47d5-24fc-08d8f3f6f208
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB446241915CA5B21BEB883936E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjbPsn19X6Nk/ohvEiAoEPkuDrdjoXs/kXWH6yr4QHk7NgO50WMXYtoxxD0Vlzc/Y6lrNOzRtX5yqJhzAMj9h92nAtOf7nhg6YqpYBYzhez0VC7s8oDi80I15iw5zNITO9r51FIYcqEIBi44VIhcMkGHouJn8AHLryNwhKwcETu93YHBEkBMuIHNfQHpCVLMthnp5sj0iRe05KXcuyYEX+4WlaHXuxxaJ7AgXcf9K+MBiJV2TlYKpy7bbXTF907M3gjr8pzUoqCZj2pF0T6JOkZtIusFxU+KmJ9w8eZwqxL1tGi4NPbvXera/bwNZc1YNulO4WoxvTGFCE0luc31y5RA6wwoSofosX+5Veyix+kq1//C1nyh1jF/yEdXmrv/0CqejXJ7LqIByEA8GNW1Z8tgRj4pPAr/sp5gX0WLJBz9tqSkBbtP8hckiS3dovYfAK3okkaC/d7cNu6HdA2sbExd+lsDLEHaU34VimCJiP/Cao0InfGinPhhHBdyTNrEXMwAt44cjxeFbKrKiXbMZ8rQGRc5jTfr0xGSaafSEZa1x1v43E64IzLZjm1+8beBtISNw1CeIt9ED5xjISPYNv0AAKu1cdODPVwH4+SUGCkuSejtMvmhVREp02RQRjhAeEkdi/aGD9dsudyDdD1mmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JQ66oRvArpKqmDc1YbRP8ckCKC2GAm8j58LSpaezTw+QriT9DDqApjMC3G3h?=
 =?us-ascii?Q?unVifX8B/uoHjq8kHGhLuGWq3PYDKw5lwRE9XerTaO+7ZVumw6FLqD3ryput?=
 =?us-ascii?Q?LYgNO/RVX94tC8sWRtxMZQjQ7FskDZ1p2ndvNoTkofTgxEMSwOdIQLXmRjrR?=
 =?us-ascii?Q?VYXpFNhbQBoXO3244D8G8kLbr6DrzlB8NQNPm20mu03xy4uLDDlRCWqvA+2r?=
 =?us-ascii?Q?FYq/aF2crTZPMQweL3b/5rnyP/9h3schLfLS34ZvgvWuJ7zsOdYitFBxssaW?=
 =?us-ascii?Q?XE5LTJg110omy6OCIf4IkxsrUTAojZPzF4vR+nWRlCLpz9z0pQbx3h0thEon?=
 =?us-ascii?Q?Ht+aKszNFVQFmVNP1fdwtMs91hb8/bpaYYYSle4NQTqIOQHGYqr6Bj2yIhVy?=
 =?us-ascii?Q?o8bQQDdw8HbiSmH6TX2uyzF0CJOkWzFWwF5qSAa/EBwSY6mx6B64bBoJZpV4?=
 =?us-ascii?Q?agNie/Gd0yTTkMxE8uPYqqsLL1GBuY9DkgW6SQySarEUiajUOJK1B7SezzgW?=
 =?us-ascii?Q?p27So/QK/oe4PgwZkBlEwSViW9MpmNVIHd746Na716hADkVJXvhzSiH7CD/I?=
 =?us-ascii?Q?hhDbMup07CSYLLQgCIF+UjeEN9IhJGAtlxwg20Z3IQhm31kTZ1OzcMmMrAUl?=
 =?us-ascii?Q?yU69qIbOWlF+5VLOritw4McuoH9Egl388wqiLcFGLIpzuXEY0wej83Tt1iIX?=
 =?us-ascii?Q?U+hL4DTSAqd7trdfsYAbsm58Jmaq2dKSNvJY7BTGw1wTv3jY6JzsToIlosAE?=
 =?us-ascii?Q?oeKqi17UNGwG7HLjv7X/Ljs889Et58GcZXLrVtNcYZE31XklC8AQOD9mLIRV?=
 =?us-ascii?Q?wLJPEfJnx558cfo1a6VVewpn0SQrACZll5hGyUBR0IFPNKZ/+kJj+c5I/B0t?=
 =?us-ascii?Q?bLBcwX6qEFoGpIlDUz6mh26bbg0FNXgAF6c1//XcioP1q5OjeRGQMPCt64Gn?=
 =?us-ascii?Q?yxglvVJOb6/fMvsAUJVpQva9J+wr7t4HTP/k2xCZMlMkdSyizYz3iO009UJ5?=
 =?us-ascii?Q?kskXRMAfcsgT1ouXWhekitbttGLJ5LaLv+1ep94Bj8cNh+vcsj4ccOveV9CL?=
 =?us-ascii?Q?vpiSL+Z6UKLTFITUARD+9ihOgdOPnzoTkEJXXVx0G9RPN12BUWrfKS7noW4T?=
 =?us-ascii?Q?5CqOmYxbKvm+djrDzHGWnteXnWkcXsLl1iDEehx8J0ABBwrcbxorjGUcSNQw?=
 =?us-ascii?Q?/8K3cxmPWEgItoZoznTeezJ3DA3qwYEhKsfqhMmjYrHJKGGgLzfVxwddqvA6?=
 =?us-ascii?Q?4eKqH4zSn0Tc0zC2Cw+gtpv3gUpo0aCVmW+BUQVhwwzbzpZZ7FWL8aPr+jXg?=
 =?us-ascii?Q?oU/fq5fEBexjRL0BhUHKThYY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246689c-768e-47d5-24fc-08d8f3f6f208
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:02.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNfaJWZRwVGsw+mNTYtQ+Keg5C1Rhxunu0n4DEfJ3eVq3MsDm8/KnJ6/p32QqxTrsGRJG/VoGl0Wsqi2URXj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: nJqyqWqNEzGgO6AEp289d01-BtCyqTdk
X-Proofpoint-GUID: nJqyqWqNEzGgO6AEp289d01-BtCyqTdk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
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
---
 mm/cma.c       | 18 +++++++++---------
 mm/cma.h       |  2 +-
 mm/cma_debug.c |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index b2393b892d3b..2380f2571eb5 100644
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
 			     unsigned int count)
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
@@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
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
@@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
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

