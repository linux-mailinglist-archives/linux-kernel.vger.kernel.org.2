Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1286344E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCVSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:13:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28142 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhCVSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:13:29 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MIAUnq021483;
        Mon, 22 Mar 2021 11:13:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NCcQsWYbYnWAisnw9MZs4JdC8ik58kFoYpy9wvFlND8=;
 b=AKPW54fkjPDKdoVgVLa8iPCSm/FdlzBx3CsjU6AWMeQArARaGCUyf1Qi3Wx6W8p4j5sa
 mq6tvzhSDab4MIUAnbJ2fWrP3QAn05CyZ+dJ8KZ+XfJ9qKFjnUvUzG89cYV4bNskv/pM
 Hih488wETA9/bWmJ6I6y6mamHaN3FQtC0dI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37dejq1wd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 11:13:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 11:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGh6TI4FI1Uuk8ecBC8oV+7XpjlxdZwKa/ORaaFE+rggFiyHC9OgSUYfENnaZlgIcR5fGs6iGgTqCOpRh/VWYcvWWkw2/tFYmk0ZWUEesaOXUWwfH0tTl7qjgd9ojfJ+W9HER3SamNfoeKN++l0E4Z/r9x/rfy5K0axMErJd+aH8/4E0UIYBRuX09d+zvrksK6KqZUKTWJ7GiN1S6oCxK+qT6knOq+n0L5CtxIbbO3yeVTlnOukYsfHN7Va9i/sbp2lmePu72Y9mGLBJ01N5y0jgn4dc/qgQtPWagAszz84RRP7S6MqPdOEVexIGQHEHQ0RCsZGL9rDbdIdeiYp03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcQsWYbYnWAisnw9MZs4JdC8ik58kFoYpy9wvFlND8=;
 b=jVf02Ikka/3qz1cQ4Pmwq7e6AW2AWlEYgar9l+0VRy0sNApt8VVCwms9wxQTTtvLSW8+9ughv8fB22GnaqetgkTM3YIQXaWuNbmYSmvRle5/Qsug4y52NIvfJUFwX9bfMnFp2oLG8sa4w0sZgydU86GUKVIpIGuA+5e25TZpNn65L6tAw7ed85d/2XbyysJ7IaTjM4FARefw/13TZpRfiTP0uSuVSJABDO/7+aEhPyuyMacNWXsP551TCckW7/k024mc/Qu6RkKm1o0oflqSfrHZkmGT2U/2C/7hpQaGt/M/wphQf7SmZ+G92thQAQILvXlcSSp/6iFR2NXnqUgjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4648.namprd15.prod.outlook.com (2603:10b6:a03:37d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:13:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:13:14 +0000
Date:   Mon, 22 Mar 2021 11:13:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v5 5/7] mm: memcontrol: use obj_cgroup APIs to charge
 kmem pages
Message-ID: <YFjeNqEHigV5y84m@carbon.dhcp.thefacebook.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210319163821.20704-6-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:cbc1]
X-ClientProxiedBy: MWHPR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:300:81::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cbc1) by MWHPR14CA0065.namprd14.prod.outlook.com (2603:10b6:300:81::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:13:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39d4590-e990-4d21-a4d0-08d8ed5e28e4
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4648:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB46488E3F0345839D87F47F21BE659@SJ0PR15MB4648.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqVhFA9m3X0/P0J6lFKKP8ZYO0VIUirWiwMsObI8gbcQxERHix/yYIR/o4qvxnarhem73pKL18+DaKlyWK4H441rN+StGFOONHXOunz20HW8Pb+L5eV6O3kJcvOQLOcGdqd+ggeykC77hqrrhO2xWnmNM0d2zNFZYAw4SDUT4jZsURVsXB7MAuKUUtQr0LdfBJvr+yZM4Rjkg1dpNObwzoz5e336j+p3T7YWjGBXTWuIuI6WgK9ZtjKlRC4kqiLCMvEabTDA8WsqDZ7lkNFc0cSta49vc0aANo1oPIrmfPNWDdmLlj3CSapZrJAY7FfRtg7VYwFhU8VTzBss3kGO0rpK2JVCPTrkuUTocFGnpyooZQOa9a2W8ceC10BGKkZ5zfU7DZj3UL+3IjD2sW6d5Ac17P9inoE9ck5padv7oCoAazEvJVtWRmCu+ovDsIK+CYOBPRVbxnoxq27PmEPCaNMSyFw8j1wUfTl/aM9oEBkocP3IP7NpLTt5zQ/4i5oDcSQnKIcFhaV2wBfEzzmcUkfASiAjSpJ0EWQQI44KIyuYvN+Ufixg3ihrlPavUMGkojOJEihHYqwulu5WvNJHxjmhRMavg5KgNcl0XzVHNSh1JXVLIA1ehzhQfhnDLKtprX5+3N5SRsbjCnz7YeAbBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(186003)(16526019)(8676002)(8936002)(83380400001)(7696005)(5660300002)(30864003)(6916009)(6506007)(52116002)(316002)(66946007)(4326008)(86362001)(38100700001)(55016002)(9686003)(478600001)(66556008)(2906002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Za7Ne7sfdgeVKtGYrHgrzRwKAORGf2ffQxnKw4wIWDwM4VASbzvCXhz802Ck?=
 =?us-ascii?Q?0vtzYMYbdRK+phEuF8/NuJL/ADj9MK+4jaeB1tRmOuEOk7bDSuKYCMoPJto1?=
 =?us-ascii?Q?mkAI0bz1/Afl1vlJdqY/Bpq3Aubql+8P0ODGgyS8/1RTgIbh5pjR3Nyuf0/m?=
 =?us-ascii?Q?SG05YIWQos1XWGj3vSbwfDSKpWPYtXka5lYWpX7MCfRBxNC4Nr+GRH9tGv/v?=
 =?us-ascii?Q?nDj6s/DsphHDO4/DgytrYO6ShmpwMSR3sF00H0yunK3nuTrSea5CWxgQTc52?=
 =?us-ascii?Q?Poi/qTxLFYK23k1Y3fqnBNXsuJTqtw9ajj4p2kMa1DQc944f3BEBdZGAXJ/w?=
 =?us-ascii?Q?fAgHNxOfqQoinH/I7CEy6UN6KSs55doHAEpwleu3p7Ymm6LzLFl/eg6lPCXi?=
 =?us-ascii?Q?VGjJIC3ry0tOxB1ZmP6LBgqZJoM+KF/7s0DxlciUNsZBR9gGPbKTuukcfPa5?=
 =?us-ascii?Q?O1UPFHmj3Xt8sO1uMpPa9ChIOQcHal4wSIR/bMAQGs8iPa5Uadsy4mGM3SMZ?=
 =?us-ascii?Q?mNRo78FqgqmKYYUQ6cTI6EhsX/cZhbwq/RqIBwOBWxm4O7HtvGy32dhHC0Sf?=
 =?us-ascii?Q?sQokodeNUiWoqllYvk5QZOkrZU/f5x2ttkp+q18HqQz3SKfpu6GMYCrdDV7J?=
 =?us-ascii?Q?qOolnw1O9xNkNfO6vKtZEleg9Yo9Nhx9U0tIqkQ2JJoy6XgEH6Fyp7ZAKq3Z?=
 =?us-ascii?Q?wrZvu7gL8xmS1Lc2RMJ7aHQ6kmkY1tUeUvlz0L7qTuUa31crJtkUTkIV+4pK?=
 =?us-ascii?Q?2QMsgMOjXcKCJa4oe79zqQ19F62zHvOtlbcywNjh7CtQlH+Wohms5SOulWsy?=
 =?us-ascii?Q?cNPD9JdKKOgnTMwVLkGsPC+67grYdc3EzXyxGR9m99cKbclj5M+tIeAZMbSQ?=
 =?us-ascii?Q?1Ff94sexsoktKmGMBQCoHVOHLr3CDULZHX4zNX3Ip9l6QKpK03oGn4Ihl4+Z?=
 =?us-ascii?Q?0PAzyaDWhfxHEn40J3xykJdPOa+pUrJTgu4xfOL9hCuh4Cwa+Qvmn6nj9tQa?=
 =?us-ascii?Q?bCrE3hcNd01057qfGoSUbSotGoFnbK7WZiJ6sNUPlmuGJZ1X4tTE6RTRKXmg?=
 =?us-ascii?Q?DeFKMDgojTV0cONfvPMt5pCPCK/nF5Ieqb4N7n7s9ug8pnCpKvQsPRz4JMlr?=
 =?us-ascii?Q?KC3379xyI3MaVcdiZxx8RLbynZN7ntZHdcu7kkgVYOL9ylstQGqSK/CeL09e?=
 =?us-ascii?Q?wfBntbHtoI4WkrqPEZKIWhXn5nTspzEM7r39zq1BwycE/DVmiMEVzu+t8/7W?=
 =?us-ascii?Q?//SCoA+H0lFdgGk9yyxn2QGJO+kCy8/c9lctjO31ZKh7SBWOIElClPUMJH0p?=
 =?us-ascii?Q?pCyfu9qcIL0dPVAqn1dBSXRfYAq4ndDZHx3JHru3bB6KNQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f39d4590-e990-4d21-a4d0-08d8ed5e28e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:13:14.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSnPr5uoOD0En2oKjEWITSjXtC8UR8Ef2nVTj+o8JkpolwiHdzzQTsSP1vseRYS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_10:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:38:18AM +0800, Muchun Song wrote:
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
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
> 
> Finally, page->memcg_data will have 3 different meanings.
> 
>   1) For the slab pages, page->memcg_data points to an object cgroups
>      vector.
> 
>   2) For the kmem pages (exclude the slab pages), page->memcg_data
>      points to an object cgroup.
> 
>   3) For the user pages (e.g. the LRU pages), page->memcg_data points
>      to a memory cgroup.
> 
> We do not change the behavior of page_memcg() and page_memcg_rcu().
> They are also suitable for LRU pages and kmem pages. Why?
> 
> Because memory allocations pinning memcgs for a long time - it exists
> at a larger scale and is causing recurring problems in the real world:
> page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted
> into a new cgroup every time. Unreclaimable dying cgroups pile up,
> waste memory, and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer. At that time, LRU pages and kmem
> pages will be treated the same. The implementation of page_memcg()
> will remove the kmem page check.
> 
> This patch aims to charge the kmem pages by using the new APIs of
> obj_cgroup. Finally, the page->memcg_data of the kmem page points to
> an object cgroup. We can use the __page_objcg() to get the object
> cgroup associated with a kmem page. Or we can use page_memcg()
> to get the memory cgroup associated with a kmem page, but caller must
> ensure that the returned memcg won't be released (e.g. acquire the
> rcu_read_lock or css_set_lock).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 116 +++++++++++++++++++++++++++++++++++----------
>  mm/memcontrol.c            | 110 +++++++++++++++++++++---------------------
>  2 files changed, 145 insertions(+), 81 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..395a113e4a3b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -358,6 +358,62 @@ enum page_memcg_data_flags {
>  
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
>  
> +static inline bool PageMemcgKmem(struct page *page);
> +
> +/*
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
> + * __page_memcg - get the memory cgroup associated with a non-kmem page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function assumes that the page is known to have a
> + * proper memory cgroup pointer. It's not safe to call this function
> + * against some type of pages, e.g. slab pages or ex-slab pages or
> + * kmem pages.
> + */
> +static inline struct mem_cgroup *__page_memcg(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> +
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +}
> +
> +/*
> + * __page_objcg - get the object cgroup associated with a kmem page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the object cgroup associated with the page,
> + * or NULL. This function assumes that the page is known to have a
> + * proper object cgroup pointer. It's not safe to call this function
> + * against some type of pages, e.g. slab pages or ex-slab pages or
> + * LRU pages.
> + */
> +static inline struct obj_cgroup *__page_objcg(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> +
> +	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +}
> +
>  /*
>   * page_memcg - get the memory cgroup associated with a page
>   * @page: a pointer to the page struct
> @@ -367,20 +423,23 @@ enum page_memcg_data_flags {
>   * proper memory cgroup pointer. It's not safe to call this function
>   * against some type of pages, e.g. slab pages or ex-slab pages.
>   *
> - * Any of the following ensures page and memcg binding stability:
> + * For a non-kmem page any of the following ensures page and memcg binding
> + * stability:
> + *
>   * - the page lock
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + *
> + * For a kmem page a caller should hold an rcu read lock to protect memcg
> + * associated with a kmem page from being released.
>   */
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
> -	unsigned long memcg_data = page->memcg_data;
> -
> -	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> -
> -	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +	if (PageMemcgKmem(page))
> +		return obj_cgroup_memcg(__page_objcg(page));
> +	else
> +		return __page_memcg(page);
>  }
>  
>  /*
> @@ -394,11 +453,19 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
>   */
>  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>  {
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> -				     ~MEMCG_DATA_FLAGS_MASK);
> +	if (memcg_data & MEMCG_DATA_KMEM) {
> +		struct obj_cgroup *objcg;
> +
> +		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +		return obj_cgroup_memcg(objcg);
> +	}
> +
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -406,15 +473,21 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>   * @page: a pointer to the page struct
>   *
>   * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function unlike page_memcg() can take any  page
> + * or NULL. This function unlike page_memcg() can take any page
>   * as an argument. It has to be used in cases when it's not known if a page
> - * has an associated memory cgroup pointer or an object cgroups vector.
> + * has an associated memory cgroup pointer or an object cgroups vector or
> + * an object cgroup.
> + *
> + * For a non-kmem page any of the following ensures page and memcg binding
> + * stability:
>   *
> - * Any of the following ensures page and memcg binding stability:
>   * - the page lock
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
> + *
> + * For a kmem page a caller should hold an rcu read lock to protect memcg
> + * associated with a kmem page from being released.
>   */
>  static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  {
> @@ -427,6 +500,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
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
> @@ -713,18 +793,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
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
> index 8d28a5a2ee58..962499542531 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -855,18 +855,22 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>  			     int val)
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
> -	struct mem_cgroup *memcg = page_memcg(head);
> +	struct mem_cgroup *memcg;
>  	pg_data_t *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> +	rcu_read_lock();
> +	memcg = page_memcg(head);
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
>  	if (!memcg) {
> +		rcu_read_unlock();
>  		__mod_node_page_state(pgdat, idx, val);
>  		return;
>  	}
>  
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(__mod_lruvec_page_state);
>  
> @@ -1055,20 +1059,6 @@ static __always_inline struct mem_cgroup *active_memcg(void)
>  		return current->active_memcg;
>  }
>  
> -static __always_inline struct mem_cgroup *get_active_memcg(void)
> -{
> -	struct mem_cgroup *memcg;
> -
> -	rcu_read_lock();
> -	memcg = active_memcg();
> -	/* remote memcg must hold a ref. */
> -	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> -	rcu_read_unlock();
> -
> -	return memcg;
> -}
> -
>  static __always_inline bool memcg_kmem_bypass(void)
>  {
>  	/* Allow remote memcg charging from any context. */
> @@ -1083,20 +1073,6 @@ static __always_inline bool memcg_kmem_bypass(void)
>  }
>  
>  /**
> - * If active memcg is set, do not fallback to current->mm->memcg.
> - */
> -static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
> -{
> -	if (memcg_kmem_bypass())
> -		return NULL;
> -
> -	if (unlikely(active_memcg()))
> -		return get_active_memcg();
> -
> -	return get_mem_cgroup_from_mm(current->mm);
> -}
> -
> -/**
>   * mem_cgroup_iter - iterate over memory cgroup hierarchy
>   * @root: hierarchy root
>   * @prev: previously returned memcg, NULL on first invocation
> @@ -3152,18 +3128,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
> @@ -3175,16 +3151,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   */
>  void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
> -	struct mem_cgroup *memcg = page_memcg(page);
> +	struct obj_cgroup *objcg;
>  	unsigned int nr_pages = 1 << order;
>  
> -	if (!memcg)
> +	if (!PageMemcgKmem(page))
>  		return;
>  
> -	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> -	__memcg_kmem_uncharge(memcg, nr_pages);
> +	objcg = __page_objcg(page);
> +	obj_cgroup_uncharge_pages(objcg, nr_pages);
>  	page->memcg_data = 0;
> -	css_put(&memcg->css);
> +	obj_cgroup_put(objcg);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> @@ -6799,7 +6775,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  
>  struct uncharge_gather {
>  	struct mem_cgroup *memcg;
> -	unsigned long nr_pages;
> +	unsigned long nr_memory;
>  	unsigned long pgpgout;
>  	unsigned long nr_kmem;
>  	struct page *dummy_page;
> @@ -6814,10 +6790,10 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  {
>  	unsigned long flags;
>  
> -	if (!mem_cgroup_is_root(ug->memcg)) {
> -		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> +	if (ug->nr_memory) {
> +		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
>  		if (do_memsw_account())
> -			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> +			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
>  		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
>  			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
>  		memcg_oom_recover(ug->memcg);
> @@ -6825,7 +6801,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  
>  	local_irq_save(flags);
>  	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
> -	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
> +	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
>  	memcg_check_events(ug->memcg, ug->dummy_page);
>  	local_irq_restore(flags);
>  
> @@ -6836,40 +6812,60 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
>  	unsigned long nr_pages;
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (!page_memcg(page))
> -		return;
> -
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page_memcg(page) at this point, we have fully
> +	 * page memcg or objcg at this point, we have fully
>  	 * exclusive access to the page.
>  	 */
> +	if (PageMemcgKmem(page)) {
> +		objcg = __page_objcg(page);
> +		/*
> +		 * This get matches the put at the end of the function and
> +		 * kmem pages do not hold memcg references anymore.
> +		 */
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +	} else {
> +		memcg = __page_memcg(page);
> +	}
>  
> -	if (ug->memcg != page_memcg(page)) {
> +	if (!memcg)
> +		return;
> +
> +	if (ug->memcg != memcg) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
>  		}
> -		ug->memcg = page_memcg(page);
> +		ug->memcg = memcg;
>  		ug->dummy_page = page;
>  
>  		/* pairs with css_put in uncharge_batch */
> -		css_get(&ug->memcg->css);
> +		css_get(&memcg->css);
>  	}
>  
>  	nr_pages = compound_nr(page);
> -	ug->nr_pages += nr_pages;
>  
> -	if (PageMemcgKmem(page))
> +	if (PageMemcgKmem(page)) {
> +		ug->nr_memory += nr_pages;
>  		ug->nr_kmem += nr_pages;
> -	else
> +
> +		page->memcg_data = 0;
> +		obj_cgroup_put(objcg);
> +	} else {
> +		/* LRU pages aren't accounted at the root level */
> +		if (!mem_cgroup_is_root(memcg))
> +			ug->nr_memory += nr_pages;
>  		ug->pgpgout++;
>  
> -	page->memcg_data = 0;
> -	css_put(&ug->memcg->css);
> +		page->memcg_data = 0;
> +	}
> +
> +	css_put(&memcg->css);
>  }
>  
>  /**
> -- 
> 2.11.0
> 
