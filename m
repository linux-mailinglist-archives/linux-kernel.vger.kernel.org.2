Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14733485B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhCJTyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:54:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhCJTyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:54:05 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJpFpe013935;
        Wed, 10 Mar 2021 11:53:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2y3NgKRhbm3y9w5CQzdri14K2v/Pu1zeKEu1a6xsEnw=;
 b=Xn6yONsTNRZMFFEPjfcqljlJHpB/MHBwOfexg6djNevZE/Q72q8xeGKxmtIXlz2u62Um
 iloVfNaSqjlvtg6tFm2i0N3dkzNHD9Mg9tATNQ4ZPNe4Bt4d4isDeZbNzW78h5gVz/Tt
 ktu9WvES4AMc9vrWe89RSEy3foYh8FSah5c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376be60292-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 11:53:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 11:53:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN1dnwFvdwPIb/rj/4pD2TvD5AxQZ2Oa64Mg6Vy8tEfrUeetWVdLgPUQrogP/BZuSGVLoQRoP4TJhIdHo3aSDOxhX0uDhSReqDMmVOpM4aoThGyogFmFcqzFSYqs65SNV7R8cvP5F5NEY72q7DTFGewXhYr3PGujEeiAyDkaSlzRTPBWAqrFth1O90DaIrAFBBP0bDsLlzBeqNp3zjClymoAUjMi002woxEz0xZtDOSumRR5/OYmj/CSN0HlWKHJjVdlKcm3fosozbOPDCIBZjwZ7hUqjavK1Gtpt1s33moEMiH0EjynmWxEnyMu4ca4o7SPfpkvK+NCN5KE9cpNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y3NgKRhbm3y9w5CQzdri14K2v/Pu1zeKEu1a6xsEnw=;
 b=OLYCFjRo1psYnWqgA7Pz7CYKvXI3urmLPSTJ+EMF06TRl1rOOCvvuIJG6Y2osdH95Y52ebob2Ko7tkdMXXVgoNZJ5LW/BU+DBzwOq/oI+RrD64CelbY+9yWc6MIaR5H0nHd0edt2prNHAiGXTbQf/ueKexVfpKdXVk7HbCrctA1n6H54YzJERmZVLHeVtEFZF9xjj8iIixAKmOJ7pUTJItKJniopZWR1iwLlpC7Kw8Wfi1xg+TjGriyUfK4LLi3sCtTNZRrYiDqD9sqkIDFi8b77md/KEfk56daStIZHqcfbTtW3NjkFg/vFj9Npzg4a6LsiWJzZjGSLdpjhu4IRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2711.namprd15.prod.outlook.com (2603:10b6:a03:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:53:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:53:51 +0000
Date:   Wed, 10 Mar 2021 11:53:45 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup APIs to charge
 kmem pages
Message-ID: <YEkjyZr7Sle+adUJ@carbon.dhcp.thefacebook.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309100717.253-4-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:3ed1]
X-ClientProxiedBy: MWHPR2201CA0037.namprd22.prod.outlook.com
 (2603:10b6:301:16::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3ed1) by MWHPR2201CA0037.namprd22.prod.outlook.com (2603:10b6:301:16::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:53:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e288f25-71b6-4f84-20c9-08d8e3fe3a04
X-MS-TrafficTypeDiagnostic: BYAPR15MB2711:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2711D519575B670F0CA971DBBE919@BYAPR15MB2711.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCTtmkbmuUnxTNm8KCkGU/3doA+h5ibLyitLlaQKCoiAz1b//oZpTsVihCOaJdpoxdbqDPHUtKIQlxjPUpXBQZEcZRaY19/LhFC2qQAyd25BMCAtCHThZIbgbwSF0Y9MiETa1q6PWykIJSNSu7XjYlqZjABHpIG7NbKi1r4Pgl+jjSP8QycGK+AetrAmedUmVRfxoUQx+apaqttjcmHv746pzzOLp7czn685h6BrSxURCUfVGoTOkrjIM8TullvUAu6mF/g91o+l5IgOBjLyA1XbVF0aw4KourB1KNHAYXv08XteSKlcAIDSqFMSMbxn5L/jIbkbL0SMZNq4xf6Qqb3cvnoxGHyfiX77Oatssie+mHZuASQOobICIWyhWoEBTqYcTfaPpTOOb4mXlPKIyqdHkVnTuBYXCxCblt6DRNQi39qJkqXC+cOFgz3hzsNSeU0weh5kP0mPafZM/9GulM6UclfzNuA0kTXVK2j4UtU+WX5oD+Qv77MISP6uOI+Y/FsfAqHkvqWKg7RUvt5k1aamDwbaMoDLtJeaTHRzwvQT7+I3YR11859cSY9kjTEV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(5660300002)(478600001)(2906002)(6916009)(6506007)(7696005)(30864003)(86362001)(316002)(83380400001)(55016002)(4326008)(186003)(66946007)(52116002)(9686003)(8676002)(16526019)(8936002)(66556008)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I5N4U//QllEGirbwZI4XngE4Yj1cdoF7eWnhNLxzRnJ8kbKsA85g9sdi3y3K?=
 =?us-ascii?Q?p2wk6PvDb/GzY+usufh6tf9Swk5mzLYbf7+5Fi2Pll/x6GWfjs5YQ1GEnkiE?=
 =?us-ascii?Q?ECS5l27bw38vKQ+S+MDtLuI4qMpQqAlVcAAAyMFv3i/2GZxFlEpwINW0GOOK?=
 =?us-ascii?Q?ZSlsOgrwQcTBWwj9R4EhpuPXFi7E7jjJp5qAF+NMzxX0t5qa8J7nZ34Crs5+?=
 =?us-ascii?Q?Dzip/8BXHlySql5XK32X249yz0uZyWwsQLfZoxYSZFSbFXx+z1xrTP6nHcmE?=
 =?us-ascii?Q?1pGWxWyK3/PLDlYfrDip0GCXR3WgYRq7UFzP4n8d7PKIQdV4R+aTzb/DGDik?=
 =?us-ascii?Q?6692VkJUZw1NK7ypGVF3J/OU+B3qj0HNxigzvVMKuCih38wRUQbTq/gv+qaZ?=
 =?us-ascii?Q?SRlajgwBR4AQQrzZx3O5ZXDamp2yIVZ05aDpQ7Nz5Q9as3hk6VY0MA1IVUth?=
 =?us-ascii?Q?219ENjnTvTuiZBgz43EN4Iv/bAz0M+GtdrF4sSBK1qaG8TrwEHRjot/vv93W?=
 =?us-ascii?Q?mxMMK4tX82Cp1bLzDbs30TLw4nRlpm3HKq6b2pxbzKOWQ2jYGvwcRxg/subO?=
 =?us-ascii?Q?dO45whUNVVQ7bt9OVP5p6fToQ+Mn0DJz6Q4j9w25GYHxLQlvVhuAJTyHcM+F?=
 =?us-ascii?Q?R4CokFSJ53mblIi1a4kdBUGwGsHwQYH5qJpsliz8c4Y3xG3tlViPyqc5pfVi?=
 =?us-ascii?Q?hoe/rNe7BW7VwiR5Npa+0qW4aqbUwDOytp+D65zvEqHX5Xwogis8p0z5d7Ll?=
 =?us-ascii?Q?x8ZKiwFQR053apIR9uG0JQ9pFRZK60ThBE7nF+/2f+Kir5uoWwmfSmkwcYDC?=
 =?us-ascii?Q?Yc54OorNmlTtYTyS13cnUMC23/0jQ5fWS0okb1ytKi1AC4n9ZYKE7enK0V/v?=
 =?us-ascii?Q?rqUFc3jkbkWcJ5ExnsWyVXD3XPkFIolw8nQDZOoENoNhwFWVJjTB1bDTgxug?=
 =?us-ascii?Q?EyQZMiGxkYhr6RXw90d+DiXbkueFjNAF1+kw5sil6pgMsV2ghLN3eLhwJu0q?=
 =?us-ascii?Q?/YeijygMAOhLkmgf2cWho++tgfFSyjSN3fTXgKLJtC56wNR+rFXenZPqMRGS?=
 =?us-ascii?Q?nceb5YAVfN5egqJJf354M2jPwsgvcNVsi7/YN32Jpd8IX3h3tX5311t8LXpF?=
 =?us-ascii?Q?U59d3iP8dSg7kRgd7Y4exRgpQpvJD2CzMV12QJmj6c6sIPnQZqSlspZXzztr?=
 =?us-ascii?Q?SeNQrNVah9eF2og29Qca2JC+hSckQ/i5BF3yM95boXwNgm2FF7QoEY5Ygkdw?=
 =?us-ascii?Q?fMR3pzDDV6e5sW76ZmVlGJaY93awzF0/vNAp0UL0CuNujpJssen22ZdhMUXn?=
 =?us-ascii?Q?rrC9X+NBHCJQj0jr4RvYqv9LpqCP1Ev2qcMQzaVozqUipA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e288f25-71b6-4f84-20c9-08d8e3fe3a04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:53:50.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKOss2GXAcK2RId6WHz9ZSqi53uVtwNAFmiV+jXaZZb//ZUusZx9HL3PePxQDjET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2711
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:16PM +0800, Muchun Song wrote:
> Since Roman series "The new cgroup slab memory controller" applied. All
> slab objects are charged via the new APIs of obj_cgroup. The new APIs
> introduce a struct obj_cgroup to charge slab objects. It prevents
> long-living objects from pinning the original memory cgroup in the memory.
> But there are still some corner objects (e.g. allocations larger than
> order-1 page on SLUB) which are not charged via the new APIs. Those
> objects (include the pages which are allocated from buddy allocator
> directly) are charged as kmem pages which still hold a reference to
> the memory cgroup.
> 
> This patch aims to charge the kmem pages by using the new APIs of
> obj_cgroup. Finally, the page->memcg_data of the kmem page points to
> an object cgroup. We can use the page_objcg() to get the object
> cgroup associated with a kmem page. Or we can use page_memcg_check()
> to get the memory cgroup associated with a kmem page, but caller must
> ensure that the returned memcg won't be released (e.g. acquire the
> rcu_read_lock or css_set_lock).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h |  63 ++++++++++++++++++------
>  mm/memcontrol.c            | 119 ++++++++++++++++++++++++++++++---------------
>  2 files changed, 128 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 83cbcdcfcc92..07c449af9c0f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -370,6 +370,18 @@ static inline bool page_memcg_charged(struct page *page)
>  }
>  
>  /*
> + * After the initialization objcg->memcg is always pointing at
> + * a valid memcg, but can be atomically swapped to the parent memcg.
> + *
> + * The caller must ensure that the returned memcg won't be released:
> + * e.g. acquire the rcu_read_lock or css_set_lock.
> + */
> +static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> +{
> +	return READ_ONCE(objcg->memcg);
> +}
> +
> +/*
>   * page_memcg - get the memory cgroup associated with a non-kmem page
>   * @page: a pointer to the page struct
>   *
> @@ -422,15 +434,19 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>   * @page: a pointer to the page struct
>   *
>   * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function unlike page_memcg() can take any  page
> + * or NULL. This function unlike page_memcg() can take any page
>   * as an argument. It has to be used in cases when it's not known if a page
> - * has an associated memory cgroup pointer or an object cgroups vector.
> + * has an associated memory cgroup pointer or an object cgroups vector or
> + * an object cgroup.
>   *
>   * Any of the following ensures page and memcg binding stability:
>   * - the page lock
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + *
> + * Should be called under rcu lock which can protect memcg associated with a
> + * kmem page from being released.

How about this:

For a non-kmem page any of the following ensures page and memcg binding stability:
- the page lock
- LRU isolation
- lock_page_memcg()
- exclusive reference

For a kmem page a caller should hold an rcu read lock to protect memcg associated
with a kmem page from being released.

>   */
>  static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  {
> @@ -443,6 +459,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	if (memcg_data & MEMCG_DATA_OBJCGS)
>  		return NULL;
>  
> +	if (memcg_data & MEMCG_DATA_KMEM) {
> +		struct obj_cgroup *objcg;
> +
> +		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +		return obj_cgroup_memcg(objcg);
> +	}
> +
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
> @@ -501,6 +524,25 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
> +/*
> + * page_objcg - get the object cgroup associated with a kmem page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the object cgroup associated with the kmem page,
> + * or NULL. This function assumes that the page is known to have an
> + * associated object cgroup. It's only safe to call this function
> + * against kmem pages (PageMemcgKmem() returns true).
> + */
> +static inline struct obj_cgroup *page_objcg(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> +
> +	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +}
>  #else
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
> @@ -511,6 +553,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  {
>  	return NULL;
>  }
> +
> +static inline struct obj_cgroup *page_objcg(struct page *page)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  static __always_inline bool memcg_stat_item_in_bytes(int idx)
> @@ -729,18 +776,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  	percpu_ref_put(&objcg->refcnt);
>  }
>  
> -/*
> - * After the initialization objcg->memcg is always pointing at
> - * a valid memcg, but can be atomically swapped to the parent memcg.
> - *
> - * The caller must ensure that the returned memcg won't be released:
> - * e.g. acquire the rcu_read_lock or css_set_lock.
> - */
> -static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> -{
> -	return READ_ONCE(objcg->memcg);
> -}
> -
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  	if (memcg)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e1dc73ceb98a..38376f9d6659 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -859,15 +859,26 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>  	pg_data_t *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> -	memcg = page_memcg_check(head);
> -	/* Untracked pages have no memcg, no lruvec. Update only the node */
> -	if (!memcg) {
> -		__mod_node_page_state(pgdat, idx, val);
> -		return;
> +	if (PageMemcgKmem(head)) {
> +		rcu_read_lock();
> +		memcg = obj_cgroup_memcg(page_objcg(page));
> +	} else {
> +		memcg = page_memcg(head);
> +		/*
> +		 * Untracked pages have no memcg, no lruvec. Update only the
> +		 * node.
> +		 */
> +		if (!memcg) {
> +			__mod_node_page_state(pgdat, idx, val);
> +			return;
> +		}
>  	}
>  
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
> +
> +	if (PageMemcgKmem(head))
> +		rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(__mod_lruvec_page_state);
>  
> @@ -2906,6 +2917,20 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  	page->memcg_data = (unsigned long)memcg;
>  }
>  
> +static inline struct mem_cgroup *obj_cgroup_memcg_get(struct obj_cgroup *objcg)

I'd prefer get_obj_cgroup_memcg(), if you don't mind.

> +{
> +	struct mem_cgroup *memcg;
> +
> +	rcu_read_lock();
> +retry:
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;
> +	rcu_read_unlock();
> +
> +	return memcg;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_page)
> @@ -3071,15 +3096,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  	struct mem_cgroup *memcg;
>  	int ret;
>  
> -	rcu_read_lock();
> -retry:
> -	memcg = obj_cgroup_memcg(objcg);
> -	if (unlikely(!css_tryget(&memcg->css)))
> -		goto retry;
> -	rcu_read_unlock();
> -
> +	memcg = obj_cgroup_memcg_get(objcg);
>  	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> -
>  	css_put(&memcg->css);
>  
>  	return ret;
> @@ -3144,18 +3162,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
>   */
>  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  {
> -	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
>  	int ret = 0;
>  
> -	memcg = get_mem_cgroup_from_current();
> -	if (memcg && !mem_cgroup_is_root(memcg)) {
> -		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> +	objcg = get_obj_cgroup_from_current();
> +	if (objcg) {
> +		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
>  		if (!ret) {
> -			page->memcg_data = (unsigned long)memcg |
> +			page->memcg_data = (unsigned long)objcg |
>  				MEMCG_DATA_KMEM;
>  			return 0;
>  		}
> -		css_put(&memcg->css);
> +		obj_cgroup_put(objcg);
>  	}
>  	return ret;
>  }
> @@ -3167,17 +3185,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   */
>  void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
> -	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
>  	unsigned int nr_pages = 1 << order;
>  
>  	if (!page_memcg_charged(page))
>  		return;
>  
> -	memcg = page_memcg_check(page);
> -	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> -	__memcg_kmem_uncharge(memcg, nr_pages);
> +	objcg = page_objcg(page);
> +	obj_cgroup_uncharge_pages(objcg, nr_pages);
>  	page->memcg_data = 0;
> -	css_put(&memcg->css);
> +	obj_cgroup_put(objcg);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> @@ -6806,11 +6823,23 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
>  static void uncharge_batch(const struct uncharge_gather *ug)
>  {
>  	unsigned long flags;
> +	unsigned long nr_pages;
>  
> -	if (!mem_cgroup_is_root(ug->memcg)) {
> -		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> +	/*
> +	 * The kmem pages can be reparented to the root memcg, in
> +	 * order to prevent the memory counter of root memcg from
> +	 * increasing indefinitely. We should decrease the memory
> +	 * counter when unchange.

I guess the correct syntax is
"The kmem pages can be reparented to the root memcg. In
order to prevent the memory counter of root memcg from
increasing indefinitely, we should decrease the memory
counter when unchange."

> +	 */
> +	if (mem_cgroup_is_root(ug->memcg))
> +		nr_pages = ug->nr_kmem;
> +	else
> +		nr_pages = ug->nr_pages;
> +
> +	if (nr_pages) {
> +		page_counter_uncharge(&ug->memcg->memory, nr_pages);
>  		if (do_memsw_account())
> -			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> +			page_counter_uncharge(&ug->memcg->memsw, nr_pages);
>  		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
>  			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
>  		memcg_oom_recover(ug->memcg);
> @@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
> -	unsigned long nr_pages;
> +	unsigned long nr_pages, nr_kmem;
>  	struct mem_cgroup *memcg;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
> @@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	if (!page_memcg_charged(page))
>  		return;
>  
> +	nr_pages = compound_nr(page);
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page memcg at this point, we have fully exclusive
> -	 * access to the page.
> +	 * page memcg or objcg at this point, we have fully
> +	 * exclusive access to the page.
>  	 */
> -	memcg = page_memcg_check(page);
> +	if (PageMemcgKmem(page)) {
> +		struct obj_cgroup *objcg;
> +
> +		objcg = page_objcg(page);
> +		memcg = obj_cgroup_memcg_get(objcg);
> +
> +		page->memcg_data = 0;
> +		obj_cgroup_put(objcg);
> +		nr_kmem = nr_pages;
> +	} else {
> +		memcg = page_memcg(page);
> +		page->memcg_data = 0;
> +		nr_kmem = 0;
> +	}
> +
>  	if (ug->memcg != memcg) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
>  		}
>  		ug->memcg = memcg;
> +		ug->dummy_page = page;
>  
>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&ug->memcg->css);
>  	}
>  
> -	nr_pages = compound_nr(page);
>  	ug->nr_pages += nr_pages;
> +	ug->nr_kmem += nr_kmem;
> +	ug->pgpgout += !nr_kmem;
>  
> -	if (PageMemcgKmem(page))
> -		ug->nr_kmem += nr_pages;
> -	else
> -		ug->pgpgout++;
> -
> -	ug->dummy_page = page;
> -	page->memcg_data = 0;
> -	css_put(&ug->memcg->css);
> +	css_put(&memcg->css);
>  }
>  
>  /**
> -- 
> 2.11.0
> 
