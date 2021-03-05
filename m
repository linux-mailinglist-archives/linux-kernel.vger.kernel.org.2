Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491AC32F424
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCETlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:41:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhCETlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:41:12 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125Jcsvd023449;
        Fri, 5 Mar 2021 11:41:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oFsy1XB/9Egdwb07fyiHgrgDrE+KXHRmGL1DHiCm6kY=;
 b=LDgn8TnHq/5uv3aneQnGEvNotvEkkvRUDcp7RRrfTPbi3TqgbmRXPq5YHAAKpOQnADbI
 /e1ijC/zOPFSq9Ik2LqbFzBwCOxSDAaiIbWEmTJHkgwdS7awAz/4FVvRpU5Youcn/Srk
 V7GZEREgHuQMCnXWx7dFNnrIAS8B61Uf+r0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 372nyhudan-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:41:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 11:41:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkKdD5apizeeHXiGlPKOId0KU3t2DgHfBnB7jdECT1YOyWQlrGKJnhnBNTbbcT+6MZdJsi61DZvfyugvMGD4dcUoguruwFzdf1lS0Gsk5wZZYD9EiszaP6dUk+z+8+wzMSwKuUBjEzysPEzbYb+uZLyoofDQPeSyPgfxuPaxiK1kuK7STWU+FnZptHjDMRZp+XCLh6E1Qcd0oT1ya6Zi6bYsyr2MC4g5SDdF4KkFe6jh+QymsdXchVewXERxAiP6Zi068jKFa1jM1AkZrj7FAP5OF1f0/YwDMlBx3QuYC4KQYCE+3S6mKhcIEwrXDziiKPp6allgQuUbIVJ5oOs6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFsy1XB/9Egdwb07fyiHgrgDrE+KXHRmGL1DHiCm6kY=;
 b=daaWVbjJSBjDS8P5BcVXO1KAmc4NFGW7KuEYFkzqS421g7pZiperuDgqjdZZzMLft7brkAQMCL2WwIlerqWcDY+FRMH2WtTWeabYS7ozEBkGzItXYbq1ZgRh+6iZMcONH3AH85x96PILBrKnGKnXnbmN1gerWUujAv7K+C3wAG27woncdjYn4codk6/p+VDqp22WwWMfAprZilVQPgphaATnz5GESk4fdpK9CGhDtblBNaXupQt/8aHBvpuATaOz/5y2ZnOKi15nT2kqCiG/knshdxZ/f5aOg8aGfOGxVL79EKVunqenpxm+KIEP7YNGY/p4aXHj5CXYa51h5YXWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3553.namprd15.prod.outlook.com (2603:10b6:a03:1b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 19:40:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 19:40:58 +0000
Date:   Fri, 5 Mar 2021 11:40:54 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 3/5] mm: memcontrol: charge kmem pages by using
 obj_cgroup APIs
Message-ID: <YEKJRpv8ppFEEQ4B@carbon.dhcp.thefacebook.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303055917.66054-4-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:6f6c]
X-ClientProxiedBy: MWHPR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:300:81::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6f6c) by MWHPR14CA0065.namprd14.prod.outlook.com (2603:10b6:300:81::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 19:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2363eb3a-7f6c-4b85-7bee-08d8e00e998c
X-MS-TrafficTypeDiagnostic: BY5PR15MB3553:
X-Microsoft-Antispam-PRVS: <BY5PR15MB355321C5976EBEB21D7D6599BE969@BY5PR15MB3553.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nh59Hw85Iw9kCNRzDsRY8dgFSqKiCWb4eZN1YAFI7aw/9GEJm7iHAqfxoPJAJnkQdPyAL4dBb3HCcPNMdOKcfwwoXgHvFmCQmjZmg+CHFWxNOxKI8ytuT4u0cTv8JsNC/k7mrSg+WoR3HeLTllopJwe/lff0/L7PQ57i1/GYtFSDDmdvnM02rxBrsxK96xZjMCKIn2CogvjsH43+18xJKRm6V6oBNPq+SkkqqDQNJjzJ4hKiS/tR4ZbnsrmMxqwI4RW4/eYNcMQu3ogjuT2vaPwA8yQgUmiGIkqwT9e3G+qE8+G++33fRCSOTQV0s2mCi1OS/OlbObcLm/qO43HWivnGHME6v+ONoOmCT2bEAdScCCwxfXcFuoMV5ea2y0Hv0pg4AEBcNpVMh0qQsY27y5KSgM+daaIlNdEDFvKk6FFV7OIpHquRIqveRD8kGY6ivHdFr5KX9FMxoJEwjW8xAevtQgofZsfTEZtlqhb/Jbf5qtvbbKqknv2erfOjC5ekrF5Ia4lZuX26T4tvKsoaog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(16526019)(316002)(2906002)(9686003)(83380400001)(30864003)(5660300002)(186003)(4326008)(6506007)(86362001)(478600001)(7696005)(6666004)(8936002)(8676002)(6916009)(66946007)(66556008)(52116002)(66476007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6Tf/Jdv+b2lp0Y8t3BtRWysqyxr9uWdl6tpWVzL34tPvXyVC/bkStGUfGiKV?=
 =?us-ascii?Q?R1eInDRsN3NYgOyfI6jcCkJNQHXdO174DJnUF1tD4n/+46CvyT29ai4XgzOO?=
 =?us-ascii?Q?EnHv3wcC/LsTtrI/pDKLQWgyU/35H0NSO6ph9i54Nx9TpKT6a82tCFBez6sF?=
 =?us-ascii?Q?5uFZM51QW3/oULQUpH1kIVDaYo9ql0pfr4LrYxV681hH/SNTEtNWtGuZbZKx?=
 =?us-ascii?Q?3hzMSgaRi2j3W588LLkl92NN8PW9fENdGP1FozPRt4Vy/B4ggm8+MJYvHNSu?=
 =?us-ascii?Q?fXcFl7c8hTh+e9kHTalGqJy4Fx35UsI7UrD8kTZLOV3wEdt9C8vdBUThCdhP?=
 =?us-ascii?Q?y3Abt9PAZBMgGCHdDFykDK7LrPsfleGZaSV7L1KmSFQJAmsp+QDLa8fvACor?=
 =?us-ascii?Q?aRT1ymKQUE047f2MGG6fFhMm7x779/ipIlbKpPPKqIzphScI45PFUOd5qgew?=
 =?us-ascii?Q?k4JAWDTkOdKtZmUFgZmGKD195JHvSn7tcwiiOJg1sjv/n9mfyTJ6bbmqtUzP?=
 =?us-ascii?Q?6tMtApzasleqogZYWyi4GEQxmqeAoc6yXmqdG7CmMvR9bz5w+zRaB7UNumVg?=
 =?us-ascii?Q?6G5lBVWKfSVsF1yFpC4NIcyIik8PQY+rCm5xot+xN34tubY9mcJ5J88mfj+6?=
 =?us-ascii?Q?3C8z9Oa9PIWOOY92EyRj4vNIeK74tVvt0uNatEFd9leEiBhwr4dHwpnIFr0/?=
 =?us-ascii?Q?D8DmZpnpWKv2OFjhSpe/CRNWmg1VN6TOVJ+r2p42DCdi4s0uwsmB2WvbM/I7?=
 =?us-ascii?Q?zIZ8idyTk2SMcSyFqrvAAJBqrhyG+Wkht0+H/CLVvrAtFYZhuw17Ql2ON9//?=
 =?us-ascii?Q?RMs1T201ka9nflTLeQJLQHScN952fhdowmv3Hg7ajHn9stklqdl0RE+HNRjF?=
 =?us-ascii?Q?s9qt3LJ3VIB0kcnyGJsO3dFDEPIB3lXe0QXjGKuubQFn3Pe48kNumLIGVg7g?=
 =?us-ascii?Q?S5xWMv4BwJXeGI/uo7mw0avHBhdhtDy88b6XN8HR6wIuMUDB37gWRWjYFmvK?=
 =?us-ascii?Q?lRVq3NiMDwELV2HLA9W2bEDrS7JTSu4oLpATJcyRBi0Fc1O2yXRCCKF1qHuL?=
 =?us-ascii?Q?Iq9mLbklgqI7cdKN63BNdZC7Vn4kblsqkLSqSi+xsAxw3bH5QLuNf1geibCf?=
 =?us-ascii?Q?d/YuIZigT0+Ob3HeNRRRx+ZxZSGr0moj31wuXc/G5SWPvGxyYLulb4IXdaLQ?=
 =?us-ascii?Q?tYmX5edTTSFIlKDkr4akXMbMKghqKOlJn1t1FbU0FQI6Pw7I0+AocEDZKjZg?=
 =?us-ascii?Q?X0SudfYPx3Mx0TjVy/eN7GBV1CS6K0MUPk/fXQzKXvTB5Ub5YHHiCxJqlYiq?=
 =?us-ascii?Q?Xa2y+2ElUB/EsLBR8TDpGwpldvJ6lzWzWTiYopwe3sUxSQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2363eb3a-7f6c-4b85-7bee-08d8e00e998c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 19:40:58.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rUPbLef2en5bqUYdMsCrLsvqIz+DmXO3l3Hi5m5AASOA8At1NhvdMQL2d9GOTlv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3553
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:59:15PM +0800, Muchun Song wrote:
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

I believe it's a good direction, but there are still things which
need to be figured out first.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h |  63 +++++++++++++++++------
>  mm/memcontrol.c            | 123 +++++++++++++++++++++++++++++++--------------
>  2 files changed, 133 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 049b80246cbf..5911b9d107b0 100644
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
> @@ -421,9 +433,10 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>   * @page: a pointer to the page struct
>   *
>   * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function unlike page_memcg() can take any  page
> + * or NULL. This function unlike page_memcg() can take any non-kmem page
>   * as an argument. It has to be used in cases when it's not known if a page
> - * has an associated memory cgroup pointer or an object cgroups vector.
> + * has an associated memory cgroup pointer or an object cgroups vector or
> + * an object cgroup.
>   *
>   * Any of the following ensures page and memcg binding stability:
>   * - the page lock
> @@ -442,6 +455,17 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	if (memcg_data & MEMCG_DATA_OBJCGS)
>  		return NULL;
>  
> +	if (memcg_data & MEMCG_DATA_KMEM) {

This is confusing: the comment above says it can't take kmem pages?

> +		struct obj_cgroup *objcg;
> +
> +		/*
> +		 * The caller must ensure that the returned memcg won't be
> +		 * released: e.g. acquire the rcu_read_lock or css_set_lock.
> +		 */
> +		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +		return obj_cgroup_memcg(objcg);
> +	}
> +
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);

Also, the comment about page<->memcg binding stability is not correct anymore.
Taking page_lock, for example, won't protect memcg from being released,
if this a kmem page.

_Maybe_ it's ok to just say that page_memcg_check() requires a rcu lock,
but I'm not yet quite sure. The calling convention is already complicated,
we should avoid making it even more complicated, if we can.

>  }
>  
> @@ -500,6 +524,24 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> +
> +	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +}
>  #else
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
> @@ -510,6 +552,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
> @@ -728,18 +775,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
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
> index 86a8db937ec6..0cf342d22547 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -856,10 +856,16 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
>  	struct mem_cgroup *memcg;
> -	pg_data_t *pgdat = page_pgdat(page);
> +	pg_data_t *pgdat;
>  	struct lruvec *lruvec;
>  
> -	memcg = page_memcg_check(head);
> +	if (PageMemcgKmem(head)) {
> +		__mod_lruvec_kmem_state(page_to_virt(head), idx, val);
> +		return;
> +	}

This is a very confusing part: we're converting the page to the virtual address
to run mem_cgroup_from_obj() inside __mod_lruvec_kmem_state() to get back the page.

> +
> +	pgdat = page_pgdat(head);
> +	memcg = page_memcg(head);
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
>  	if (!memcg) {
>  		__mod_node_page_state(pgdat, idx, val);
> @@ -3144,18 +3150,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
> +		ret = obj_cgroup_charge_page(objcg, gfp, 1 << order);
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
> @@ -3167,17 +3173,18 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
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
> +	VM_BUG_ON_PAGE(!PageMemcgKmem(page), page);
> +
> +	objcg = page_objcg(page);
> +	obj_cgroup_uncharge_page(objcg, nr_pages);
>  	page->memcg_data = 0;
> -	css_put(&memcg->css);
> +	obj_cgroup_put(objcg);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> @@ -6794,8 +6801,12 @@ struct uncharge_gather {
>  	struct mem_cgroup *memcg;
>  	unsigned long nr_pages;
>  	unsigned long pgpgout;
> -	unsigned long nr_kmem;
>  	struct page *dummy_page;
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +	struct obj_cgroup *objcg;
> +	unsigned long nr_kmem;
> +#endif
>  };
>  
>  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> @@ -6807,12 +6818,21 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  {
>  	unsigned long flags;
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	if (ug->objcg) {
> +		obj_cgroup_uncharge_page(ug->objcg, ug->nr_kmem);
> +		/* drop reference from uncharge_kmem_page */
> +		obj_cgroup_put(ug->objcg);
> +	}
> +#endif

Hm, an obvious question here is why do we need to double the ug infrastructure
if we can just get kmem page's memcg and use the infra for user pages?
Because ug is holding a reference to memcg, it will not go away.
Maybe I'm missing something, but it seems that there is a simpler implementation.

Thanks!

> +
> +	if (!ug->memcg)
> +		return;
> +
>  	if (!mem_cgroup_is_root(ug->memcg)) {
>  		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
>  		if (do_memsw_account())
>  			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> -		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
> -			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
>  		memcg_oom_recover(ug->memcg);
>  	}
>  
> @@ -6822,26 +6842,40 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	memcg_check_events(ug->memcg, ug->dummy_page);
>  	local_irq_restore(flags);
>  
> -	/* drop reference from uncharge_page */
> +	/* drop reference from uncharge_user_page */
>  	css_put(&ug->memcg->css);
>  }
>  
> -static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> +#ifdef CONFIG_MEMCG_KMEM
> +static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
>  {
> -	unsigned long nr_pages;
> -	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg = page_objcg(page);
>  
> -	VM_BUG_ON_PAGE(PageLRU(page), page);
> +	if (ug->objcg != objcg) {
> +		if (ug->objcg) {
> +			uncharge_batch(ug);
> +			uncharge_gather_clear(ug);
> +		}
> +		ug->objcg = objcg;
>  
> -	if (!page_memcg_charged(page))
> -		return;
> +		/* pairs with obj_cgroup_put in uncharge_batch */
> +		obj_cgroup_get(ug->objcg);
> +	}
> +
> +	ug->nr_kmem += compound_nr(page);
> +	page->memcg_data = 0;
> +	obj_cgroup_put(ug->objcg);
> +}
> +#else
> +static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
> +{
> +}
> +#endif
> +
> +static void uncharge_user_page(struct page *page, struct uncharge_gather *ug)
> +{
> +	struct mem_cgroup *memcg = page_memcg(page);
>  
> -	/*
> -	 * Nobody should be changing or seriously looking at
> -	 * page memcg at this point, we have fully exclusive
> -	 * access to the page.
> -	 */
> -	memcg = page_memcg_check(page);
>  	if (ug->memcg != memcg) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
> @@ -6852,18 +6886,30 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&ug->memcg->css);
>  	}
> +	ug->pgpgout++;
> +	ug->dummy_page = page;
> +
> +	ug->nr_pages += compound_nr(page);
> +	page->memcg_data = 0;
> +	css_put(&ug->memcg->css);
> +}
>  
> -	nr_pages = compound_nr(page);
> -	ug->nr_pages += nr_pages;
> +static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> +{
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> +	if (!page_memcg_charged(page))
> +		return;
> +
> +	/*
> +	 * Nobody should be changing or seriously looking at
> +	 * page memcg at this point, we have fully exclusive
> +	 * access to the page.
> +	 */
>  	if (PageMemcgKmem(page))
> -		ug->nr_kmem += nr_pages;
> +		uncharge_kmem_page(page, ug);
>  	else
> -		ug->pgpgout++;
> -
> -	ug->dummy_page = page;
> -	page->memcg_data = 0;
> -	css_put(&ug->memcg->css);
> +		uncharge_user_page(page, ug);
>  }
>  
>  /**
> @@ -6906,8 +6952,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
>  	uncharge_gather_clear(&ug);
>  	list_for_each_entry(page, page_list, lru)
>  		uncharge_page(page, &ug);
> -	if (ug.memcg)
> -		uncharge_batch(&ug);
> +	uncharge_batch(&ug);
>  }
>  
>  /**
> -- 
> 2.11.0
> 
