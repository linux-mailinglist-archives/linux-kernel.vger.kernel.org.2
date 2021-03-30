Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DE34DD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC3BO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:14:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbhC3BOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:14:24 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U17g8C001806;
        Mon, 29 Mar 2021 18:13:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JjpaI7jKp+f85L3gWK1k4muexr1pfrdXKC9iMeZIGwE=;
 b=pANeXiDu0uvME/y1JFDmsmxk6Qq/s1cJodC/m+ZVq7ZytmKjoISuuScMbiyY5SnFZrMq
 baNzffnaIMh5GEiqOxkn3MXifZx6BoFepfHXltKv24G0KLlNUGcfK3TCg61kAg9wWnra
 o6ampglpYoMnceWoDAlE4pK8yngdOPPsCi8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37karjwb4c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 18:13:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 18:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhY05rpdxX3liMOMRDffrxiZ/EdzEEFzqwZ5VUoNour8PJjUX/16LhWxkRPZXH9CDvR8JTv4HwUvaIJN0ioDjwu5V+IjeBsd4lZXdyK7EWbvf71gJV1WqRX3ITbFqVPCh4yik38ervHGPhcZ2JVvQEi2gKcy3XjzmLte672Cy8zY+2hJxxb7UCotP5iZhfnpRddOeLKEnpvzCo2mHfi2MWSbJjSKaahobiJTPrumnFEOTSi2zp42ysXfpaT90fz/z+swhWeHZeGM1hWM7FsB1SQFXzxi589Ibm5PIu8nvEdXEeHjtyvdDpbxVRQXFk/7xMr19Z/yPovzpUCQKDAbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjpaI7jKp+f85L3gWK1k4muexr1pfrdXKC9iMeZIGwE=;
 b=mFnxP2KjZqvDanQBuHZhYYbDX4N90DlblyBl4RETaBxR9HHmioV637WWOdanPxOi5gI52I8HohVj2jcbSqlnDvyZE1eqnJ7se0mejRlUbbub0In/2skKQ7ugmYL/ZfUqr6RC7atz545lmaoHKB+8WsH1nCG0efPUz9mYx7NqOkB3FImzr5sU+HH5cBNSmDwH4D/9LOpPuiT5vMtBb7wUtNMisHyUSD1Xhrgol3D1gP1UaER+qLUU6nihq3J4VkZ51rXcy1NDuajj8B1DoyMcwgTTnRmL/SLAXAFgVBeorHibYPAAhTIKQvRUEA5F4927Rc3Enkk7magnBCtq9Uvpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4156.namprd15.prod.outlook.com (2603:10b6:a03:2e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 01:13:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:13:07 +0000
Date:   Mon, 29 Mar 2021 18:13:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YGJ7IN4cdfRw+jTz@carbon.dhcp.thefacebook.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210329232402.575396-2-mike.kravetz@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:8010]
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8010) by BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 01:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a36d86-4c97-466c-6908-08d8f318f9dc
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4156:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41569C1B6F9A64813ADF0C3ABE7D9@SJ0PR15MB4156.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGUY0BoylRoaV89kJqzYyf/U6hBerp0G/Wm0y06cgS8V0UU8kvEEL+dx5FhpbcVPDNTToIxBnAYxuqasj+tP8en+90bjhDmfDoD7DZcM5Ko+FUOZm8edhh1+I6ZWHzdkcTZBLKVCDj4MzCosV1MeQgG2tbmS7byK7ZFOzdrrm46V+SHgHXZ+6Y74mO3HVdVVgNhw56It9BMJ9/hVcsn47opswqhmtLiNFEILdgrddxeOqJ516wY96fetSA15zCOZrtK3ZvEjJLZszZVAGxhJDPvKMmxNol0IObSQufd58jTIcuBLyYR/eY1dIe6oWNhnZGc+wY34M+8XrTfpYtxQIsm+QXqUgYZk0AcLfxoEODWrxUcvY9eyw0L6NeXxKtdZy7zx1scYVLG3SEBKelK/iqqZxefEHKVLCF2TNhwJZITygT9NeMvKxCCpRfyddMMJQ+396itepzKhE9AqA2rOapBFOLJWRC+BqdsvRJTE5WCvcHEW1bA4TlBsNoQ40pkWFq1K/EJqE9i5bfA98zC+tQR0EMinTRepBXpRIBEXpvzt3uInOYRa3IlX0rXQzAzotG+w7bYyBbC/do8NzcKhJHF++FcViidXKlpO9JHLc2m5UUXuefM5ct7Ng9cgitFwyl+VA6rjXysNHZTBMT8Vky9U4rnMKgDcf4/rft94rEb19RWMeinQj+3RF8qEObX7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(66946007)(66556008)(66476007)(6916009)(8936002)(38100700001)(6506007)(2906002)(7696005)(52116002)(83380400001)(8676002)(316002)(54906003)(186003)(478600001)(4326008)(5660300002)(7416002)(9686003)(55016002)(86362001)(16526019)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4Okn2wMtydan86oN5DNFIt7TmjVGr1UCAlSby7ZJP6G658Q2MrMbSXmwvtO7?=
 =?us-ascii?Q?dYXEgr00or6NbgG3J2p1faNCMxt0o9Dh5DPERbVCnVpD6yA/iDRTdshtHAum?=
 =?us-ascii?Q?rv7oitghs7Orhj0PgdbB9H9215WahNuQ0kUzP6wkcOpWd7Mjoo+VAEP/ZPke?=
 =?us-ascii?Q?9Z9H7g+kcvWi39Gqhjs4K9fvyjAnPhvEQy09mS1jN+mu23toEtMFcbPvfmbo?=
 =?us-ascii?Q?qYmNoJAxvyVF0ZRPh9fK20dKLHf9qOescC7+EgY8+YPuPXZcWb6UcrAsOgL5?=
 =?us-ascii?Q?15QkjdpBE+2o7jgL3H373r5Wu9CogLX8vbVnDykvPC6B55ugb4zPxO2r+Dmw?=
 =?us-ascii?Q?nU2uiCqI+QRy4aEYMfH2bqZAZ5iEalMxgSpUycNVrfelJwQnsskOPvF/GGsb?=
 =?us-ascii?Q?RQN2EOYtsQxEWPLgUs1GVvf445s37FzX/fZfMfctfy/M9dVqo4YnQl0jr8ub?=
 =?us-ascii?Q?Rcj6yaBQugwS8j3NqG7M0WRzXsMNHQN9dHzNHoXc1XSAk3T9OY7VunkgSRtF?=
 =?us-ascii?Q?IVz9ImpEufu00D+KS6s74YAsc7feR3F9X7jr1ch1KyojBW/lKbO85XKGvEiJ?=
 =?us-ascii?Q?EtFtIATeHxdE60H+JHDNK1aU2j8HX/GNIKqiDVsHuG5jJxG3sBXDuFN80PAm?=
 =?us-ascii?Q?Qkf7B+heJfdJtZxYENg32n1KCnvbTpaGMjs70fFqcabX3ksIfCnp6nOYn4ro?=
 =?us-ascii?Q?ZqHau2eghwhhItrfVckGIx7SRrFLPp88+aS169fNID2pqmRDtTRG3gTmoEBM?=
 =?us-ascii?Q?pw3K56YK4uhKNnX2q/X7FeHKCQctP2ZTiAqNy0KNmWuTfTWe0NUhAaklOe+L?=
 =?us-ascii?Q?q2KSjV/jJSgrvf+HoyA530LmZ6gNfqahxmBN07VXh1uKcgfdj8dFXBIt30ey?=
 =?us-ascii?Q?dWS9nAVZLJUvd9IRFzK1g9vwGl9UdjNdhSaImviIrKIjp2HbVPDnNVDdFbmD?=
 =?us-ascii?Q?CEbOzee3iIjXezYt+ygThT+OextKKW72KIS9P7UuFIOICfoJiEqAo11LkfOE?=
 =?us-ascii?Q?HvS8KIjDfVBTCNxIJ1TwGWZrGfnP7wOuVZtAVivGLT19sCZrXL7LGvx01RFI?=
 =?us-ascii?Q?jbBPRVQ0Q/cFmnFyM4BAl2JPBQW4NYTuogWMNCoq3Ib4J+ncw65I65bMSS/4?=
 =?us-ascii?Q?6DOhyPxI0lbhBa1GXXJOwnzZXhF9QIL5hJmB0sZgTi2+6hETMd4xH8T6Giq7?=
 =?us-ascii?Q?bowbAHM2kC7ed2ZhxXE0yN32eHzr7NnNzlTC6p8NEbTo7CSK9mpz6ubSZ280?=
 =?us-ascii?Q?H7yXfTNRal6OySJKib4ULoyUi+EBQVLNbdHmPwDYDsalAvUrXaMGSc9IQPAi?=
 =?us-ascii?Q?CF4tqeuIZokZa8erh1bAlrUcAZcmGu4x9TYeK4aYLkF782PKcINM1anDcXCC?=
 =?us-ascii?Q?V5dqTz0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a36d86-4c97-466c-6908-08d8f318f9dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 01:13:07.1612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wislbuXgN3ev38CQ1KRmaWs7iw8CmX7cBMg8Kx24LaH7pILeGDw3GsFhIJ+HkBsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4156
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uA2eTf8UnMyNy5gBuxP6DKqQ6SQEvO8B
X-Proofpoint-ORIG-GUID: uA2eTf8UnMyNy5gBuxP6DKqQ6SQEvO8B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_16:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103300005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:23:55PM -0700, Mike Kravetz wrote:
> Ideally, cma_release could be called from any context.  However, that is
> not possible because a mutex is used to protect the per-area bitmap.
> Change the bitmap to an irq safe spinlock.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/cma.c       | 20 +++++++++++---------
>  mm/cma.h       |  2 +-
>  mm/cma_debug.c | 10 ++++++----
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index b2393b892d3b..80875fd4487b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -24,7 +24,6 @@
>  #include <linux/memblock.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> -#include <linux/mutex.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/log2.h>
> @@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
>  			     unsigned int count)
>  {
>  	unsigned long bitmap_no, bitmap_count;
> +	unsigned long flags;
>  
>  	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
>  	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  }
>  
>  static void __init cma_activate_area(struct cma *cma)
> @@ -118,7 +118,7 @@ static void __init cma_activate_area(struct cma *cma)
>  	     pfn += pageblock_nr_pages)
>  		init_cma_reserved_pageblock(pfn_to_page(pfn));
>  
> -	mutex_init(&cma->lock);
> +	spin_lock_init(&cma->lock);
>  
>  #ifdef CONFIG_CMA_DEBUGFS
>  	INIT_HLIST_HEAD(&cma->mem_head);
> @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
>  	unsigned long start = 0;
>  	unsigned long nr_part, nr_total = 0;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	pr_info("number of available pages: ");
>  	for (;;) {
>  		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> @@ -407,7 +408,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  		start = next_zero_bit + nr_zero;
>  	}
>  	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  }
>  #else
>  static inline void cma_debug_show_areas(struct cma *cma) { }
> @@ -430,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	unsigned long pfn = -1;
>  	unsigned long start = 0;
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> +	unsigned long flags;
>  	size_t i;
>  	struct page *page = NULL;
>  	int ret = -ENOMEM;
> @@ -454,12 +456,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		goto out;
>  
>  	for (;;) {
> -		mutex_lock(&cma->lock);
> +		spin_lock_irqsave(&cma->lock, flags);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);
>  		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> +			spin_unlock_irqrestore(&cma->lock, flags);
>  			break;
>  		}
>  		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
> @@ -468,7 +470,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		 * our exclusive use. If the migration fails we will take the
>  		 * lock again and unmark it.
>  		 */
> -		mutex_unlock(&cma->lock);
> +		spin_unlock_irqrestore(&cma->lock, flags);
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> diff --git a/mm/cma.h b/mm/cma.h
> index 68ffad4e430d..2c775877eae2 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -15,7 +15,7 @@ struct cma {
>  	unsigned long   count;
>  	unsigned long   *bitmap;
>  	unsigned int order_per_bit; /* Order of pages represented by one bit */
> -	struct mutex    lock;
> +	spinlock_t	lock;
>  #ifdef CONFIG_CMA_DEBUGFS
>  	struct hlist_head mem_head;
>  	spinlock_t mem_head_lock;
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index d5bf8aa34fdc..6379cfbfd568 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -35,11 +35,12 @@ static int cma_used_get(void *data, u64 *val)
>  {
>  	struct cma *cma = data;
>  	unsigned long used;
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	/* pages counter is smaller than sizeof(int) */
>  	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  	*val = (u64)used << cma->order_per_bit;
>  
>  	return 0;
> @@ -52,8 +53,9 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  	unsigned long maxchunk = 0;
>  	unsigned long start, end = 0;
>  	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	for (;;) {
>  		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
>  		if (start >= bitmap_maxno)
> @@ -61,7 +63,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
>  		maxchunk = max(end - start, maxchunk);
>  	}
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  	*val = (u64)maxchunk << cma->order_per_bit;
>  
>  	return 0;
> -- 
> 2.30.2
> 
