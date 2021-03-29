Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC834DC65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC2XZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhC2XZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNIwoQ153749;
        Mon, 29 Mar 2021 23:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=kiYEXAzkj8k19ZaDk6k1MsXea5isDu5qDl+c5dI1+mk=;
 b=JyTDHQf7k9I1YjCEB7TIMjVqCbi6QtC8u243HxRy/HaLxrVLUH1I6c0K/f/PgZsXs5St
 acN/ZqHcissDPVNwsv4QhMvcjYRAf2gqRaUn01vPeFlWpENMyscdSUz6zACOsmFcQTl7
 zC2rgKSJO/1/oZpe44fFCDF1IFxYY81RtS9WwmmPmxcTJ5rXnRaZA8Bt6eRdZPAz2ur3
 ECvGcDgcOuC/sCiWYJmQj1lAdCDwPRYRoxxKgyvITSs+F+n6uRXBoBosSgFMZgYNVNU2
 jeI5SsCykbKKdj+ObI/y+OVWj+zbdq9fJ60OdYf/Fnyt6Y3QIFRnTc+77HldH5rwexVY 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37ht7bdbr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFYFk055873;
        Mon, 29 Mar 2021 23:24:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 37je9p06mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqg2lHTur8yQyoZ5r1CubbEBTJ4q9/T1DAOd2/6mMDjtw67f3cqHZ7otrGA38E4n8GP8IzaT5KCYXL23bCHF40r4Z3riZSJSUT8pETMFftigYh50c2sLjGJCa6dt7mykXmW0yINjA+DESWtQ1PfF/j/P84yDUu927bd9gUQJgXvbNRCY6G7mkSfGziW/mkaGi+9gf0R4JlPmLAdcvipp1PtmNWG+XmhCAgturTgnww9DZNO+j4ih4EY/LY+Wev2Efm8/XtsaU+Ir8yE53cteiNwobndE6HL1Uc+zskaF9k1UvIgI30P5AL73czwIbsFmJLCoibyhHciZERxMsGO3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiYEXAzkj8k19ZaDk6k1MsXea5isDu5qDl+c5dI1+mk=;
 b=D5eF2YS+Hfeu3PnSfNKB/+gSADLdApPbZlRbPr++fjYO2JLKCjM/YC0peCo+n7/TxXvgRzPzQTz5pTOUZ29Z5k57uBlqhEry+wIzeigizch9UBvibiCrk0JoEoAm0Tj5QZmbGd0HXIkjW1Pea6dHXo8mqZO2I2ixlYsfvShQrm6Yrd2dO9B2UmvQhke2d74KKPZb+ue8B0YPadcGnLl458TnlEKXA8gpH9xZUXFHd9HBpNv8Qm7nHGG+Hgpv7mdj1vQML1W8siIbCXRyzX2C+gv7qf+evjcAIUL9ykyUFYlJpIMVuPKJEO2G9s0tXcFWsvc9GdL1FBA+H65/daEv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiYEXAzkj8k19ZaDk6k1MsXea5isDu5qDl+c5dI1+mk=;
 b=sby6V7cP1Kabc14igMr67e/ykN533VXMKN9XJc9ZFlo4CWYei9+9Lx1gUS8svTfR1erHGqW0Ewq9CvdPEv+oZG2vEd+WO57YxvON/qo40FFxovcKCNVZUsnZscTgxazRdBRm18dcOVREB18n0LKKy+aiivPca30WZByVqBX2XB0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:18 +0000
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
Subject: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
Date:   Mon, 29 Mar 2021 16:23:55 -0700
Message-Id: <20210329232402.575396-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ef4317-bd97-4616-4d6f-08d8f309c667
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB414868E4A0E859A71BFE666CE27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxOv8S+tQU5gxfDaj+DmZnvZ/pYidg5LzArqQn7OO/R2bPfzgtvz4MKalpWIKa4WKs+l05VvunCrp6N15b4aWAQinGJQZnOFL1NOOqeryd07oMKhjjn73SXRVhDJ3uCvyAkcIyNbviPyq11SRVyvCjCghBl6/Wc0jIJiEcCIqrKaqLiiFvMEPdNGxHE0BoDJZwj46ox55t+vjyBigIyrkFL8kh/zRJAdEuO60E/BLFoFhx15jAR8M9bMPKU1ybGDsM4tlqBHYyzyKUTmT2JPio7Je5H0jbv6KrFczZG/l64XkHAfQochtYVzkeVTzQOiVueqJJ3OKYmom2uevTGjCbuQq7p0ozYvWe5nBCW1ZynnBAKTVBWZ9MNNmK+dT/fMFNs81d4YjdPp9CCCEucUcQ7QTQm53FIpQDi4xEricx6G0nn55o+9+0BghrkuqXgtbtq842Ck39rA3SjVVWAzZDVr/1v5MgIIdO+D39qLTkx+E+NSxFqLG7Kl8lcNTJP7pAZ7d/dlaF8K9AT7NbjWOOvzicgx30OpEZbEWxWq+dcF2PEnJ5nt9yTZG0cfTS9j97sumWY/vRsxFTRGvk6HYSf1H5c7+J6RoPuBJk8O8rTTlBMW7Y57+fgZNYkfypmOVYyTpsRHv36uhvF4oYb+0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+TIliutXksls0XFOEchQDlU3IuGWwL/lvpmGbPVzG5e3Xs7qn+0OB2cwObu7?=
 =?us-ascii?Q?2PTQRa/6jVpEzZK7xPg+rRIoKqHJSUd+r0SHxwPAk+TT3x4vJuDtb+GCY0RA?=
 =?us-ascii?Q?j41UVbC9iDrwwMgBY86m+nwUUPOBufTeVfqTGxjCmKsQHYnLu033Iyk4H4ye?=
 =?us-ascii?Q?FucZQmI/2oHgTfoqbE724SKlkmhXRT/MHddAsao7n+uLB7HOtiOkPeYWLSbk?=
 =?us-ascii?Q?qu/CFZXjd3m88fxpVwjgF9iIj5CED1ynSCgyDXqiS6d6cRH9GpuYkV1xac/B?=
 =?us-ascii?Q?L9KEeqMNxjoAgv/87VTCb44cqeNLJ2FDkjlVs8pxB4SHrZs5DIxYqRFh2QT9?=
 =?us-ascii?Q?akTfLu9DrMxtcMIyG2F/9J6N+Ye64FxFIEzr4zlp994iI+6AmHxXwzSyDbNN?=
 =?us-ascii?Q?V3togVc1mx/ZQFzyKNUyMgMvMuRs/Bf0jVIj3ykx3pXv3S3NOj23+EmZa8+J?=
 =?us-ascii?Q?L7oU9OXQboLr1dCU1etpc9Nn/S6o2+p0RUefCL5GxThmhWnIEKC0HbinFHtR?=
 =?us-ascii?Q?VBGzFDdQ2r1HVlDxxO2zXOZe1VybuqinjnhFibLAng8ckzr4hD5VAq2SBpYZ?=
 =?us-ascii?Q?Oy4LNvx/5R6SKbdhmFML78fzmlckXgNbMMwtjwxsFm/FeuTRxKIZZqgxBVj+?=
 =?us-ascii?Q?KyIW5NpfU/wj9e3Lqcx9Hevuy/pdXthWbnQ/gHh+3z9lowc51PyNzJXB987V?=
 =?us-ascii?Q?KnyhwjR8r28woOuBq6At7olv9Kq2xMWq9NwGd5AOQGCk1T96fkF7pBJi6rG6?=
 =?us-ascii?Q?/YJHxXttxfz3Dt8cubFKpt2RwTEDzXTPcD80p4ORNiAr5DnYtfv3exm7hF/7?=
 =?us-ascii?Q?DcQoVkUV3Nhj7DkKlb7CfjDEdfmhUGKYbVmfOiREWop+p9FcR7WOSd7tPszJ?=
 =?us-ascii?Q?5ETJLYRZyP1xW15ZYncgsjXKIuujFtJfSStqjgfKmCZ50yMKXyNUIgNktC+J?=
 =?us-ascii?Q?dQ5gPqMgSttZmb80f5FzJvlzixCN9w9AsjEt0YadjNjQ1eC+MS26qMXL8Wwe?=
 =?us-ascii?Q?0swVHh58iFvzo4uqZkPOyrjrhkWSJUXorgUyDr05VNOyhAqjJx6zXmTWAH9Q?=
 =?us-ascii?Q?5vZxifWv7dOJENnucwsEmCfWoC4SHkc9XKoEJ2si9+BLmyjEBJujKGye3i0t?=
 =?us-ascii?Q?XJjBe/3EU1KNrSoxrMZ0vs+n1GaTy9Rb2KckXQCFECCwDZK9A1jVWeZwDe8G?=
 =?us-ascii?Q?YjhJH+1BoU17e5xJq/a1GT/eVWkjRIIO8ZIOPH2U7P9Gn1p46aBK1hdkjhp9?=
 =?us-ascii?Q?vebw7upSrQDFTmY7NrfzuZGD8EVQDeqEpf8TJmI16LBg/QQeWfZp7NizWBj2?=
 =?us-ascii?Q?xLLA1rDn1PftkzFbciSOMCSl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef4317-bd97-4616-4d6f-08d8f309c667
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:18.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JoasxsPKAUBepD+ogeDZHCApTRfeP8ZZGSbHxkrNa2Zlcoo2GgnYcUwZ5XfMk11IW24sfr+PrHc9V7+xTZEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: XDF7oFZfr-wMC_Zy1E4FC0_fKoGFD3LS
X-Proofpoint-ORIG-GUID: XDF7oFZfr-wMC_Zy1E4FC0_fKoGFD3LS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally, cma_release could be called from any context.  However, that is
not possible because a mutex is used to protect the per-area bitmap.
Change the bitmap to an irq safe spinlock.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/cma.c       | 20 +++++++++++---------
 mm/cma.h       |  2 +-
 mm/cma_debug.c | 10 ++++++----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index b2393b892d3b..80875fd4487b 100644
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
@@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
 	unsigned long start = 0;
 	unsigned long nr_part, nr_total = 0;
 	unsigned long nbits = cma_bitmap_maxno(cma);
+	unsigned long flags;
 
-	mutex_lock(&cma->lock);
+	spin_lock_irqsave(&cma->lock, flags);
 	pr_info("number of available pages: ");
 	for (;;) {
 		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
@@ -407,7 +408,7 @@ static void cma_debug_show_areas(struct cma *cma)
 		start = next_zero_bit + nr_zero;
 	}
 	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
-	mutex_unlock(&cma->lock);
+	spin_unlock_irqrestore(&cma->lock, flags);
 }
 #else
 static inline void cma_debug_show_areas(struct cma *cma) { }
@@ -430,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	unsigned long pfn = -1;
 	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
+	unsigned long flags;
 	size_t i;
 	struct page *page = NULL;
 	int ret = -ENOMEM;
@@ -454,12 +456,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		goto out;
 
 	for (;;) {
-		mutex_lock(&cma->lock);
+		spin_lock_irqsave(&cma->lock, flags);
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
+			spin_unlock_irqrestore(&cma->lock, flags);
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
@@ -468,7 +470,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		 * our exclusive use. If the migration fails we will take the
 		 * lock again and unmark it.
 		 */
-		mutex_unlock(&cma->lock);
+		spin_unlock_irqrestore(&cma->lock, flags);
 
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
index d5bf8aa34fdc..6379cfbfd568 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -35,11 +35,12 @@ static int cma_used_get(void *data, u64 *val)
 {
 	struct cma *cma = data;
 	unsigned long used;
+	unsigned long flags;
 
-	mutex_lock(&cma->lock);
+	spin_lock_irqsave(&cma->lock, flags);
 	/* pages counter is smaller than sizeof(int) */
 	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
-	mutex_unlock(&cma->lock);
+	spin_unlock_irqrestore(&cma->lock, flags);
 	*val = (u64)used << cma->order_per_bit;
 
 	return 0;
@@ -52,8 +53,9 @@ static int cma_maxchunk_get(void *data, u64 *val)
 	unsigned long maxchunk = 0;
 	unsigned long start, end = 0;
 	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
+	unsigned long flags;
 
-	mutex_lock(&cma->lock);
+	spin_lock_irqsave(&cma->lock, flags);
 	for (;;) {
 		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
 		if (start >= bitmap_maxno)
@@ -61,7 +63,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
 		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
 		maxchunk = max(end - start, maxchunk);
 	}
-	mutex_unlock(&cma->lock);
+	spin_unlock_irqrestore(&cma->lock, flags);
 	*val = (u64)maxchunk << cma->order_per_bit;
 
 	return 0;
-- 
2.30.2

