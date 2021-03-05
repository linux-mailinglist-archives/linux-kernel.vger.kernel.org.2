Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929B032F35D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCETA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:00:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55760 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhCETAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:00:32 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125IsT9R032635;
        Fri, 5 Mar 2021 11:00:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=db2rkzyug0A4ciRYLWrf/LJRCYskPPUebURfrlRtzK0=;
 b=kn7ua1SFqPM7VjE7EKmOpaM9+isZH3NaOzCcz9Z583ZCbIMy5A2k5JHBR4OaeptlfOm2
 394mjMb5A7ls/E6TkqTsVP+Gt1ONNqTFmJP9GKjH/q8NnMGOEIKf4dsRJGy/+4O+XknT
 cJds98B0r3i7vYHZiXTxpMPxIH7z14byEj0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 373kpdtb1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:00:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 11:00:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6vTBEtESRFb7UH2jUPimhM76oJlygn1lCZrbH/zD3w4pinOSrklw5IOUHNc28JsrpoufmMqI3cCEN8MPKmJr6Ccj8nuW13mexVOhvoJdSIlWM1ZxnutGt/rAmIPrykL97Xk7ndwerVRm7BZfgYcw3L+aU4Xm306znCJGuHZOmqhpPoQmYsIbOgC7O7tAcKcSGfuGODioYwIbzlL7nzfr1qe5vGrb0vEHOsCOtKAPkkgU/VaRIYtBRsiE7/Q3fWZusdRImMMvfaofSo9eQ5YD2XwZvyO/SsmE8Gz0s7azrYpyl/HhBgK/ENX+PoUHRtUqJpuirBHlVgmOKduj96XbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db2rkzyug0A4ciRYLWrf/LJRCYskPPUebURfrlRtzK0=;
 b=R+iy9NhqqyqA3LAahnG9b1caW1dQEn1k446NBsfCCfr1nV4t6w9Z/iWWFw0e9niAWU6IfYyX4hRlBhahmPEq3pgyjGaIPiqKOrWoep3jWTjzic2bFB80E+tQFvEsjVeepKzz59dh+lbabUcW7uxFUabv5UHY1D5gnABGJHBuos59nggmAhVXsj5HppsvmNfQd45gFuOCGh38S1X2HIDjHg/JLL5y71772+mudBY0JrQ8bQql+mjEOprYD4i+WzllzKxfzE1yD7FTV76stcYr3ZodkXXTLMlvZWeTZAyBtYcd2gDfO9j4d2hYUulqaV80Wfps9AV+fgxPgaoU00ah8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3681.namprd15.prod.outlook.com (2603:10b6:a03:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 19:00:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 19:00:23 +0000
Date:   Fri, 5 Mar 2021 11:00:19 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 2/5] mm: memcontrol: make page_memcg{_rcu} only
 applicable for non-kmem page
Message-ID: <YEJ/w/FLVMbbedbG@carbon.dhcp.thefacebook.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303055917.66054-3-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:6f6c]
X-ClientProxiedBy: MWHPR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:301:4c::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6f6c) by MWHPR15CA0055.namprd15.prod.outlook.com (2603:10b6:301:4c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 19:00:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6723e637-11f9-4ac3-4b96-08d8e008edf8
X-MS-TrafficTypeDiagnostic: BY5PR15MB3681:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3681D35CC90369587501AD3DBE969@BY5PR15MB3681.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJmDoqSKQMdVEWCvuAM1G2S4tMNJQ629PJLukgEefkBL9nSUz+FTXQkERwtx5F787y/v7bLsqjvFhfXUypBY7a6/UA3DjTVUAtl4RikeR+BPR3jZBQKn2pw7hKBs5i95nm+7IqJIkUlbtT3NxTwc/Z6HEs3tVxpoIQB3vxyTdMcj6ezjEGZdALOFfF9lWNQirOC71PEeKRNfeExc3rEd3dC8lvp0viTBD2R28ZvFX2MLmUcnRvqXQF/UINXY98Iag6nqyJxg0HjGj11u3fmR4Q88hnqndcHE2RNK7eP9zBba6p7Ch3/2MYVdzBpEbmttk8w/OcEFqC5QNpXdqQH+e9fICGEtuIswrtgmsJD0BbevG7xjgkwVZhtxKFQt8v6FLx9kfHmQtlIBOkY/wFhub26CPEK7k1Zb+brL2TIZovxFV/KwMm3ZJ8gpMIt7E4TnDNuK5PYmmqXMF1V7UqHVPqoO3I+XTBJvI3arKmykfSlyog8tjq0mzaA9bqV/rFxusv8VMXj0JVQMexu/nJjBp9hm+NsrTCXOaxdKy3mttJciKXqMsdeREZm/nau9fiZbjv6zZ7W9rayAo36zQpMzpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(186003)(83380400001)(9686003)(8936002)(16526019)(6666004)(478600001)(2906002)(66556008)(6916009)(55016002)(4326008)(66946007)(52116002)(7696005)(6506007)(66476007)(8676002)(5660300002)(316002)(86362001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8eDG4+jQszFweVS92DM40NdaLEb5BC2DW/cKBHv36hkco4le/9NGPBkcC1Y0?=
 =?us-ascii?Q?/j9wDyk/S8HYGGZEe8tweedP/h6o6Wr4WwAgODOBIp/9C3YISCspSyykua9Q?=
 =?us-ascii?Q?HTW7pcmxNeepXwQhJAWSMywqcsIUPWXeIn7DE1AgIOCMdabAvYTIUgbTF0+m?=
 =?us-ascii?Q?GpHVfSt9xVIIEWAn6zq9Puu18dUpv79FxYInC7GTLzVrXaWddAVltl9K790l?=
 =?us-ascii?Q?2LdIHF3zFWi0nP0osjqr4aC3YKa42QpNKiJWEQyVXdTEqjvzVeiiHYIrWfVQ?=
 =?us-ascii?Q?ZlQsH0LWWZT4TxQkwK58b/LWhPhg17CeTwoAZJklp860gEt6QN80x0CY/PXi?=
 =?us-ascii?Q?Fv92uPCsC8+vRjOasm67mRx1NoVQmLelTbILG1PqAIoJKoMEmpLEwFOoCr2P?=
 =?us-ascii?Q?mrzKnIAAyniCUUhPokGg6ropuv+GFop4ysNwuVkwsC+LrwDHIMsEDYM+EqC3?=
 =?us-ascii?Q?zBy6/zmOim9C1MHcVciyid09u9Y6wVz3HW/8k6EmQjfE9aC9w8PVQ3zObXJy?=
 =?us-ascii?Q?fmhawTiit3ypeFkD+zB5Cxe3fZJ3w3hN+nIAOnvbSi+0EVPDsIgfCuQh0dbF?=
 =?us-ascii?Q?7Cta7M91Gx0i6BALL85dr3rfB/OfpPmDCRxB2WokWbBd2vpMgjCbJvsi+IBk?=
 =?us-ascii?Q?/xU+JL13doWVgL4uAckk4CupFhiU1lYD1LNScTvK1tmgKikMlG0Sy3tJelkq?=
 =?us-ascii?Q?sNFZ920Z1GyrRGJOYLDN2/QZYXB98ABm6Ju6nWqKrtYkGrSvoZT7YblMY1y1?=
 =?us-ascii?Q?4HcOp9354JPekQ3zzrOf/bJOQsBFECa9XEY35WDprxwU5a0eTpoDsYqKLetw?=
 =?us-ascii?Q?LdMoFSZCWuLqrvo0vSqO8DT/wstqIYBK7fGIWMO7Ta6OuYx/FriV4/vRDLCn?=
 =?us-ascii?Q?u9X5s8KGFNksxleDBAKLk+2ogDeBXo6ff+SdAdT6Tle3tKCxXHc4N3bE5Fe+?=
 =?us-ascii?Q?U4f0OEPQsBB1asgcy7NL0B6GoTDGR9QthKrRtUcMVlzVLaInmIc+k0tGX7B0?=
 =?us-ascii?Q?32LL4I7qhhD2p4hzdvEDWzXaUAgBj53p1UZtNuK8CfrMMNP1i4haZZlCVCTI?=
 =?us-ascii?Q?5KpRwKHK5FPjBbsVigjBFhM39PUv9PctziTzKGyXAN9ui9JUusxa89qL3fu3?=
 =?us-ascii?Q?H19vU99n69d90Mhfpw2UQNVkN9VR92tp3CJgxEQIeF3lKMAXXg+iGCfty5jE?=
 =?us-ascii?Q?0J4PYSYZxFtxhIs/L9JBxOvNz568KRTp2AnBipyjy9l4GLLHCzd2hnxQIRWR?=
 =?us-ascii?Q?jeG6529oXlyJ07Dt+TAZp2ViaAlZmh/6Ibic5AQoVCGTOtwLEjLUasIlCsFi?=
 =?us-ascii?Q?vAnJ5VnMPIxXV3EIfi54Yc+pzaHgEHX0pOLBYDp6rzffFA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6723e637-11f9-4ac3-4b96-08d8e008edf8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 19:00:23.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKjX87IF8rE1/ahe50lWdhMlB/QGXV6UUBViFcd00XZJOlIrtfEzWRaF2BMAKtiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3681
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:59:14PM +0800, Muchun Song wrote:
> We want to reuse the obj_cgroup APIs to charge the kmem pages when
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
> 
> Finally, page->memcg_data can have 3 different meanings.
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
> Currently we always get the memory cgroup associated with a page via
> page_memcg() or page_memcg_rcu(). page_memcg_check() is special, it
> has to be used in cases when it's not known if a page has an
> associated memory cgroup pointer or an object cgroups vector. Because
> the page->memcg_data of the kmem page is not pointing to a memory
> cgroup in the later patch, the page_memcg() and page_memcg_rcu()
> cannot be applicable for the kmem pages. In this patch, make
> page_memcg() and page_memcg_rcu() no longer apply to the kmem pages.
> We do not change the behavior of the page_memcg_check(), it is also
> applicable for the kmem pages.
> 
> In the end, there are 3 helpers to get the memcg associated with a page.
> Usage is as follows.
> 
>   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
>      pages).
> 
>      - page_memcg()
>      - page_memcg_rcu()
> 
>   2) Get the memory cgroup associated with a page. It has to be used in
>      cases when it's not known if a page has an associated memory cgroup
>      pointer or an object cgroups vector. Returns NULL for slab pages or
>      uncharged pages. Otherwise, returns memory cgroup for charged pages
>      (e.g. the kmem pages, the LRU pages).
> 
>      - page_memcg_check()
> 
> In some place, we use page_memcg() to check whether the page is charged.
> Now introduce page_memcg_charged() helper to do that.
> 
> This is a preparation for reparenting the kmem pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This patch also looks good to me, but, please, make it safe for adding
new memcg_data flags. E.g. if someone will add a new flag with a completely
new meaning, it shouldn't break the code.

I'll ack it after another look at the final version, but overall it
looks good.

Thanks!

> ---
>  include/linux/memcontrol.h | 36 ++++++++++++++++++++++++++++--------
>  mm/memcontrol.c            | 23 +++++++++++++----------
>  mm/page_alloc.c            |  4 ++--
>  3 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..049b80246cbf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -358,14 +358,26 @@ enum page_memcg_data_flags {
>  
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
>  
> +/* Return true for charged page, otherwise false. */
> +static inline bool page_memcg_charged(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +
> +	return !!memcg_data;
> +}
> +
>  /*
> - * page_memcg - get the memory cgroup associated with a page
> + * page_memcg - get the memory cgroup associated with a non-kmem page
>   * @page: a pointer to the page struct
>   *
>   * Returns a pointer to the memory cgroup associated with the page,
>   * or NULL. This function assumes that the page is known to have a
>   * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages.
> + * against some type of pages, e.g. slab pages, kmem pages or ex-slab
> + * pages.
>   *
>   * Any of the following ensures page and memcg binding stability:
>   * - the page lock
> @@ -378,27 +390,30 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
>  	unsigned long memcg_data = page->memcg_data;
>  
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
>  
> -	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +	return (struct mem_cgroup *)memcg_data;
>  }
>  
>  /*
> - * page_memcg_rcu - locklessly get the memory cgroup associated with a page
> + * page_memcg_rcu - locklessly get the memory cgroup associated with a non-kmem page
>   * @page: a pointer to the page struct
>   *
>   * Returns a pointer to the memory cgroup associated with the page,
>   * or NULL. This function assumes that the page is known to have a
>   * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages.
> + * against some type of pages, e.g. slab pages, kmem pages or ex-slab
> + * pages.
>   */
>  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>  {
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> -				     ~MEMCG_DATA_FLAGS_MASK);
> +	return (struct mem_cgroup *)memcg_data;
>  }
>  
>  /*
> @@ -1072,6 +1087,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>  
>  struct mem_cgroup;
>  
> +static inline bool page_memcg_charged(struct page *page)
> +{
> +	return false;
> +}
> +
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
>  	return NULL;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index faae16def127..86a8db937ec6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -855,10 +855,11 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>  			     int val)
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
> -	struct mem_cgroup *memcg = page_memcg(head);
> +	struct mem_cgroup *memcg;
>  	pg_data_t *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> +	memcg = page_memcg_check(head);
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
>  	if (!memcg) {
>  		__mod_node_page_state(pgdat, idx, val);
> @@ -3166,12 +3167,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   */
>  void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
> -	struct mem_cgroup *memcg = page_memcg(page);
> +	struct mem_cgroup *memcg;
>  	unsigned int nr_pages = 1 << order;
>  
> -	if (!memcg)
> +	if (!page_memcg_charged(page))
>  		return;
>  
> +	memcg = page_memcg_check(page);
>  	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
>  	__memcg_kmem_uncharge(memcg, nr_pages);
>  	page->memcg_data = 0;
> @@ -6827,24 +6829,25 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
>  	unsigned long nr_pages;
> +	struct mem_cgroup *memcg;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (!page_memcg(page))
> +	if (!page_memcg_charged(page))
>  		return;
>  
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page_memcg(page) at this point, we have fully
> -	 * exclusive access to the page.
> +	 * page memcg at this point, we have fully exclusive
> +	 * access to the page.
>  	 */
> -
> -	if (ug->memcg != page_memcg(page)) {
> +	memcg = page_memcg_check(page);
> +	if (ug->memcg != memcg) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
>  		}
> -		ug->memcg = page_memcg(page);
> +		ug->memcg = memcg;
>  
>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&ug->memcg->css);
> @@ -6877,7 +6880,7 @@ void mem_cgroup_uncharge(struct page *page)
>  		return;
>  
>  	/* Don't touch page->lru of any random page, pre-check: */
> -	if (!page_memcg(page))
> +	if (!page_memcg_charged(page))
>  		return;
>  
>  	uncharge_gather_clear(&ug);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f10966e3b4a5..bcb58ae15e24 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1124,7 +1124,7 @@ static inline bool page_expected_state(struct page *page,
>  	if (unlikely((unsigned long)page->mapping |
>  			page_ref_count(page) |
>  #ifdef CONFIG_MEMCG
> -			(unsigned long)page_memcg(page) |
> +			page_memcg_charged(page) |
>  #endif
>  			(page->flags & check_flags)))
>  		return false;
> @@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>  	}
>  #ifdef CONFIG_MEMCG
> -	if (unlikely(page_memcg(page)))
> +	if (unlikely(page_memcg_charged(page)))
>  		bad_reason = "page still charged to cgroup";
>  #endif
>  	return bad_reason;
> -- 
> 2.11.0
> 
