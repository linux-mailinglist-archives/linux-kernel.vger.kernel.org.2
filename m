Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CE334869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhCJT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:58:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35016 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhCJT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:58:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJmwnR023008;
        Wed, 10 Mar 2021 11:57:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AeL8C+U6pdgYfECInw038i0vJu2bRHkU2nhOmJCRrjs=;
 b=ho9nH/iGmHMG0OHQqYwdxvb5/KPJWD6lmjqB+7smRRm6y4b7Q37LTj9+kKZkIQsjL1O7
 5TFDN8HHWt6LbICpbRMkY7eMQr4HDqawCnZgUvRgP6zvPT/FU4wPUgTbYL5a3RP7xM6A
 0PwlwrdNRKw6+5MQ6fwKxS6z1w88AK1d3SM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376bp0yxq9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 11:57:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 11:57:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpeEpRkgKpCQv6psPLCLyNWyOMBgqnPUU5dnLSK6moxzwRLtEnIB8yYFVbXrthnbHylHybZyBlDywNyaYIbYIAVkKMqtUuDvAaccZoEry/3vfBvENT8/3hf8eGXuaqqLV3dgoFGMPnxm0YRsGf6JjTzdjGLp8KVfPDEgArHgj+qRKhmy9Rtk1omF+vhRsOvxfJNA66R9Vmm5p3P3HjU5gLSgKhmEkaOs55FczeOaqM45N/tFZpawa6TexAuKKK0bvqAdJ0z4mALmPQwRBQEgJol1aFGg7NpBvYVvr99tI8ziHR/zswN+i2XQ4/L8Cm4aVn1ajtvvHhEGUGQ2eoFsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeL8C+U6pdgYfECInw038i0vJu2bRHkU2nhOmJCRrjs=;
 b=oVm/s72W+P5L6nnMI2Mnn3sX3wSYyRocv/Ao+ARz7fYfvUtcjMDMmA/wK03J1Rlli2spJVzARiEXdE4u971SnSPqbroyyUirLi5Ix6FWmTkF2+4cragz7TliQKWDMB+YPPENeqVLwyB50Mu1HFwr1Mr8jOv0OkBlSQaTSaLu+v+gKMncyTlQfUO+M6BGGs03Ci6eJHXlNLZTXvTHa6CB2SvSajBe2Ql5iyXZnEo22jPSVS4sCuTljjVAaPw0c/tTq/Ikt9jDcmm523/lOgd3MPeY1TKAO+nlczG56rW4S9px19FZirFeWYaQw0me5J2qGC6FO5FdBm0qG2aX8EvN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2807.namprd15.prod.outlook.com (2603:10b6:a03:15a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 19:57:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:57:55 +0000
Date:   Wed, 10 Mar 2021 11:57:50 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v3 2/4] mm: memcontrol: make page_memcg{_rcu} only
 applicable for non-kmem page
Message-ID: <YEkkvuIZ/0+LD/9s@carbon.dhcp.thefacebook.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309100717.253-3-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:b20c]
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b20c) by MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:57:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e952fa3-a5e8-4b84-115e-08d8e3fecbf0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2807:
X-Microsoft-Antispam-PRVS: <BYAPR15MB280708505594A2BCD9A85B46BE919@BYAPR15MB2807.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hML/LYN0Iyr677jc1dh7euaomHFprBa4bGw405Ug9bd5OhFn9forpIDf7uvJO7hROUa3LgfvA9xsP0I7LP3wmCC/25BS9bHEIv0Wtdqm5HUqqs1uW4eirfu8dEr0umI4A4gNGIIY/oxiNoV48xiHPw8DZZo0e+gRHm6OhCfLfpmjb3tdhmEZ4i0cppHvB2TWj+LApjLEUUo7UeIQanOPtnDY4c3nU+wECHNUdaQkf8Kvu38dmexIiPAnN25NL1y9y/0wtnuO0IIXXimiLMfVNRfO+/KqHmOew+QYKzbPS60+sYZBdNRg47q59Ccgd+cq4gzTwEKoc6XJxMGJhlCu0Hh+atpr8glebYreu1yCWW1CtEgJ8WmYuJqhSd3XFlvXI5yviVf7oK5pwFXDKhHCeuOPyYIOXgFe4uG6AgpXeJkZnneMzd/aY+7fUpiZve/f7i8fI1Rb5y5enwtMFZQANKhs8oo7Vj4F9mlm549RCz9EFTICZ12xK2YVOdnmOt1kDJtH1mm8uEoXXyNaTMCTIDBTg1BU48exLEjIRPZgQdBiuMCTdgqRD4lcBWr9NGiKdkyl3SYNqD4LO3zDkFeYXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(55016002)(8676002)(86362001)(66476007)(8936002)(2906002)(66946007)(6916009)(7696005)(6506007)(316002)(5660300002)(9686003)(83380400001)(52116002)(186003)(4326008)(66556008)(478600001)(6666004)(16526019)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sldkqmP9Q5OQnFjDf1V6B8OgiGhuVAIkvv4oDoyI5oUBTBYTY3xN6VkowhbY?=
 =?us-ascii?Q?XHl6ZWq/nYW5aNP+Ii7SSJH/YJX8XOvhICdBQaa5yFDwziJhKUuY6zVTjF2i?=
 =?us-ascii?Q?mdEKbYuitZhlf8mUTys/QZYN2q8y3ySaYuN/+M0x9lDwxBmdpYtq/BzqMqg5?=
 =?us-ascii?Q?2EXAZSgDTpg4BDo+68kYiqu3DY8lAgY+SNzvUq6KXlS2nvoYrBr4H4kjeZrN?=
 =?us-ascii?Q?Vyot1Hr/QGtxzhq3bDs/QkCBg1WEEk2MZ7vNjHeA4QfKQlES01w4QLMFPWTC?=
 =?us-ascii?Q?B+jMjmxMckhPYNV25IBe41k7vnPhGOWjezV090W1ALj/hfQtpD+cDkQmL+EH?=
 =?us-ascii?Q?vNXxvJIzy7PF82F5FliyUDxXxBXuBWl6+UE+i+zOQMSw8KrOsnfT8n8uJYC5?=
 =?us-ascii?Q?UQB7Rfgm2xaHZ3SgPm1Z/GhD7f3vGmIyQ6R0QVNnSJYVfIOtYY3IY/Oc/usw?=
 =?us-ascii?Q?Z/TGUC+W7N6fjKjRbvApEQ0RsIxCxR+o45eNCWqEfN0Mz1BafbcKwyZvfhdz?=
 =?us-ascii?Q?CoWemCbnPhTq2IyOvWLXdJACEPzatW83kX1avElBp9ytDttrspWoY2yAexeu?=
 =?us-ascii?Q?zcZVCRwY2md1qGZoZdjAY2qoRrxila8/fShp/uDkI92AYP46sfqp3lcx6Fq6?=
 =?us-ascii?Q?yZ3oRAu1oGYdaDMEl/b3H1eKH5Msm4/d0Wuvr0v28MEnjgwbM8L6J2xaC/9n?=
 =?us-ascii?Q?lNN2pNYb+w9E+vA2gPI8ICwYu2lT1b5w9k8/PX8AS7ZK2PT0f5Ygmrwc6GH1?=
 =?us-ascii?Q?n0I31AbF9rrwAdZhnOnemy2PdQqSXw40xz/MU4IHeMqSJEnDpbWws0J5jVlJ?=
 =?us-ascii?Q?tP2KxPQSh/1fWoLY8biTqEKqgWSsrLlDunqh+/CEQS8FdagzQd6sy4yUcmi+?=
 =?us-ascii?Q?PDNqiWufI2dLdAKFcLfdf9E7xpASX7JRdf7YUNcRr5lACJW8XKbvk3xVrhCh?=
 =?us-ascii?Q?2trb4IG60j3ZVOYJolnLz8czDS8cwbw2d8jAc2qlclJOJhV57LrLpVN3jILb?=
 =?us-ascii?Q?IBOV679rSU5ubzFCGHeZMvdCr9qwqhaWb6j4IIFnjuvbuKfYnCKzaFDRw2Q9?=
 =?us-ascii?Q?y4a7nTk/tHw1RZy47qg7182JQ256CyAs3X4Kd7dP3J3tAudc/99cklfbPSdC?=
 =?us-ascii?Q?2Bf+OgyIOneIhgZw37HInb+bbXSTWEPWWErW7JSn5ElyPosxEi6YloLgtWxZ?=
 =?us-ascii?Q?cbWEVZzdyL1FhOBz3BUPH8Yye0t/D9YZdZltHZN6QBq40UiBf0yog9nsaGOL?=
 =?us-ascii?Q?kJcZueUp5tvwrhDnvfBAL6kq1so+ms8iMeVA4+Uax+sEh+wcXw0JFcztMPU2?=
 =?us-ascii?Q?WmFJGB3DeYivrsq4Vq1XId89EUUKfREDm+FUoj/kZBppZg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e952fa3-a5e8-4b84-115e-08d8e3fecbf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:57:55.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbGB1KtZE2M8WJySwdPO3SnjQ4Wc4gBUNp7gTR51Dt/EGk4ULbA7xJWXHv5MtpZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:15PM +0800, Muchun Song wrote:
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
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
> ---
>  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
>  mm/memcontrol.c            | 23 +++++++++++++----------
>  mm/page_alloc.c            |  4 ++--
>  3 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..83cbcdcfcc92 100644
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
> @@ -378,27 +390,31 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
>  	unsigned long memcg_data = page->memcg_data;
>  
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
>  	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
>  
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
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
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> -				     ~MEMCG_DATA_FLAGS_MASK);
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -1072,6 +1088,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
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
> index fc22da9805fb..e1dc73ceb98a 100644
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

In general, this and the next patch look good to me (aside from some small things,
commented separately).

But I wonder if it's better to have two separate versions of __mod_lruvec_page_state()
for kmem and non-kmem pages, rather then rely on PageMemcgKmem flag. It's a hot path,
so if we can have fewer conditions here, that would be nice.
I take a brief look (and could be wrong), but it seems like we know in advance
which version should be used.

Thanks!

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
