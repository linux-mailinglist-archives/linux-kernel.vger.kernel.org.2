Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4632F34F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCES5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:57:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhCES46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:56:58 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125ItWM8017004;
        Fri, 5 Mar 2021 10:56:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wSvt1w5zKWvJTeNjwlK1dtfVmmMYoP80yJ+HPkt9i9g=;
 b=KQVltSgA3akIRNb3HYgrd+wz+szAoR6LYj8/cWItT8RbAdH4keJ4+rM65vab/2tsOIXd
 hgThovgtENq4E+q0QSMG2ESyiqI/PN3D1087N7gQFLePi7gzzu/V6HtbbyelLWlx82Gf
 G8TfNfrfW0i8d9l+bugfr2mD6Ty0ez/DcOg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 373ha4u2h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 10:56:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 10:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXhbem5+iBVm9+sEd7smINjvw0eMGuhcJmDIK507wClx8iHJfZsVssGbxz0o9Q+bjuPZfI3oi3sort3DQhI4yzxwv0b43LqMMx2sWdEhCX01GM00Dm0GunO1IGKFIHEsiww9IwKu+eZ8ywxnVQW8zM/yXkmZH2koLfjq4/8If0WUu2uHftgZ/vhPLtmeGN4BURl4a7gxyjkJQ3cSauMdqCtMhC8CDcHcbPGUsyz/CbcU1xRAS7yW1M2sJ05KeFDjP12UpK7ZDTtXqbeRXBvZ5YMMXDGxtEcrQJXbb79KnMY0D5UwylfuDHUrQApbGIT5rq0dvuq66Gk+yywWGyA62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSvt1w5zKWvJTeNjwlK1dtfVmmMYoP80yJ+HPkt9i9g=;
 b=PKuTj81Jz+x0qOOyHEMw4a8bnDaCAl8ILTAJhEhMR2vS1QkngCJDzRWdiSKOogFg80MUbe7j/MsajdkjR2DqsolPgTeAAqBRbxHkwteCG/zv3kHMh9Ua0a/IbTb192/u6+h+ziXjS5PrG8nmEWZbZB8BEv9/tcx5aibJptPeYEIDRV/CZ0glcvCXW5aobYCWJ4Cf9xYedMkFpzU2bOmEXG0zm3Z6hIu13Rn8A4L7Pp+QxPzppVNnH8TtuxDdhi3moSSid9Ne4D12mQuu/8hEzRVNBATdfXfDGiBWsB2HtTMvQS77MOasmmO+WFJZLBOJnsZNezEl6d8nxBTddw2hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4629.namprd15.prod.outlook.com (2603:10b6:a03:37a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 18:56:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 18:56:48 +0000
Date:   Fri, 5 Mar 2021 10:56:44 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 1/5] mm: memcontrol: introduce
 obj_cgroup_{un}charge_page
Message-ID: <YEJ+7JM3YfjfVVNo@carbon.dhcp.thefacebook.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303055917.66054-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:6f6c]
X-ClientProxiedBy: CO1PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:101:1f::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6f6c) by CO1PR15CA0051.namprd15.prod.outlook.com (2603:10b6:101:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 18:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713c73fe-0d3b-465b-6698-08d8e0086e0c
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4629:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB462943F21647F231E0BA8A0FBE969@SJ0PR15MB4629.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WciwcI7YuDd+FA/S4vXcja6ZsfTlFY1sZkJcgmawTqIlcHICQoQgZJVYe8lmUWiN7Io8EQkSAstoynDCZiKAZ5fSV5llX/3OhSTaS/2N98dXFU0VmaOJjnUKH6wojzBzRDV2qVf5RDBUFolXSlKf7qV6eMSdR9w3PaewFNHWRZ/tC6b9yh7F+G4OFgJU8+4rXgJQL9XVLD1iQq8onC/44huxhvt98AhNSwhZQEChCB3ggfroGmEnNIf4qollApzso1AXST+L+lIyqRvMkAi0OVjTgrumIZsF+9xdicHe+o5Jg2q0lW0uvapwjvcsMT/TLfoyUBadM1LITdVoNRrf8+z0czftP1EIKNYSbOzRqL4jdoCgNiuRjNo+DuyhxyoyI+b/Z3AeTtoyNleA/vRo0EnmBXsbMLNEefQRkDgEdulGzZDMrWVt2PJBJY/bwdgKqWKr7uhSKnsatVnzlMI1RGlXdLb3d5ohahy40BK1XyV1PPL5TUPsoOEMRwIrkqIzKqJsMUqB+1PUD/Efo7HtUTqPp/lYyP5kFO9yHo/PPxj0TzfpcjD2amgJwG6Yms9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(8676002)(316002)(478600001)(6506007)(83380400001)(86362001)(6916009)(186003)(8936002)(16526019)(66946007)(4326008)(66556008)(6666004)(55016002)(66476007)(9686003)(7696005)(2906002)(52116002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0x6u6D9CXxM8JV6zG/k4Q72MWwMKtFPuOc3nTJGuVfMInO1rpaXD/jaLyVR9?=
 =?us-ascii?Q?ghGtSnFmSzojDKI+MC3uQLzmhFZr74nSF3yaDwrDbS1mvFZMnihli2N8J1su?=
 =?us-ascii?Q?81BW53YSd4BjhuMitImFdHQLAIBhYrM48BMoYKle6U+baoCu/MVFCtjaood3?=
 =?us-ascii?Q?4ljWcrryFi3XurR9EU1o9i5ayA0XbgikxgS0gn9fpEjo1LWgfcQWVNmOlpYS?=
 =?us-ascii?Q?rWG2ut4nOqH1ITPjyli6uH1OVRm8G7XCGl2l/ObTuzIumqs0fXDuSyCsQow1?=
 =?us-ascii?Q?t/ZWFO6W2BkqtnQIHRDOLaHHg+C6dTAQmOpjEUQtmT72IoamvrLg/o+J2/Q0?=
 =?us-ascii?Q?1+fFzZoBx/by+Z29bNJxVe51knnstd+GRh/z2Yj7mO9FEwcE31hH3u2m1oDm?=
 =?us-ascii?Q?QaSphV/PR5P3jHHsde2VhjzefmvTcmiCbHboVDNu7hx1nFTfkFK1t8cOqWM2?=
 =?us-ascii?Q?xAmLJJvKGCuzXcfAZ6POQIhenTlGbEeMMVl/mxIMjuSL7cQe0rBSBou/y1+J?=
 =?us-ascii?Q?heh05p73+NzdJvBmxbJktMpWyOQ8YW8C0ndjw9vySl7l8Tew2O0RfZCxtOwe?=
 =?us-ascii?Q?sc9tknRoTlvT1uy239oRGMG1u8o6gEdqDXjTp8smfNaaxrpQEo6m6/JbH4Wx?=
 =?us-ascii?Q?Ox0B4zenIdf5Jz9YQpfU7BI95h0tECkBa9go5GEI+l7rKKFX58OaOs/S6NRI?=
 =?us-ascii?Q?N6xdl/EKfmoFmTIpGdefj+DSKHsrEUzdv1FslpRUsS0th7wn2UBJILj36scU?=
 =?us-ascii?Q?W3NMkdeJrqvzyFRiZhz6JQGy4gZI8mN6ytQ493pALCdWgCBTrfN83KdJYva4?=
 =?us-ascii?Q?7OJ3oPsq4EurABQ7QE+d39aeMGPQFoo6QonVKX7l0QBHzSpPC9bzsFRGGSvw?=
 =?us-ascii?Q?qPMx/9F1GKWxcX21W1PKpp8KI10up7fYRoW4Mekd6cDCRWv0QDcfknydQ96t?=
 =?us-ascii?Q?xZ/YGoyWMaKwAO6bXZuMrkvcs2LKpUizCksZf99j4sgMa/qgsUWxrHzoKJLF?=
 =?us-ascii?Q?ui8O4ljj+B5MrvJa9fRtFRvs+cCmfjNHjZlHa68E2zF4Ch+MHxct96nNh0lf?=
 =?us-ascii?Q?uHuffFXrJvrbSch+qKG4/BaILTETx7ey4nAndtN1IZruDIitMKaTE1f3v0lD?=
 =?us-ascii?Q?PaD5bZ+nGgl4C9ZvB40sNFI5Alz3FBk9Zqmn082Dm2pXdUP7yxJ3E3qsA1W1?=
 =?us-ascii?Q?ne6Bdxxim/wdLYv1FE8oEuZ/H6eFW/3n6kO6FZY169NdXkGKF9CYV+t8hgSr?=
 =?us-ascii?Q?pOUK73heYI9Fq8q+C6qC34eDSEAioMQr8EL5smsE+1lIn7YhwNFkE3Jp2qv9?=
 =?us-ascii?Q?8DXYAFAdf/V10ewRKgwPaRhfUmuzB1uuH4uOfvT5pgQ+kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 713c73fe-0d3b-465b-6698-08d8e0086e0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 18:56:48.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaLw3s2hmLgS7MevLW0ruuNrU/qTDyvgUKhZvGz1TBKfCbzxQIkUOM66R4ICLORg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:59:13PM +0800, Muchun Song wrote:
> We know that the unit of slab object charging is bytes, the unit of
> kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
> to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
> to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
> skip touch the objcg stock. And obj_cgroup_{un}charge_page() are
> introduced to charge in units of page level.
> 
> In the later patch, we also can reuse those two helpers to charge or
> uncharge a number of kernel pages to a object cgroup. This is just
> a code movement without any functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This patch looks good to me, even as a standalone refactoring.
Please, rename obj_cgroup_charge_page() to obj_cgroup_charge_pages()
and the same with uncharge. It's because _page suffix usually means
we're dealing with a physical page (e.g. struct page * as an argument),
here it's not the case.

Please, add my Acked-by: Roman Gushchin <guro@fb.com>
after the renaming.

Thank you!

> ---
>  mm/memcontrol.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec01ef9d..faae16def127 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3056,6 +3056,34 @@ static void memcg_free_cache_id(int id)
>  	ida_simple_remove(&memcg_cache_ida, id);
>  }
>  
> +static inline void obj_cgroup_uncharge_page(struct obj_cgroup *objcg,
> +					    unsigned int nr_pages)
> +{
> +	rcu_read_lock();
> +	__memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
> +	rcu_read_unlock();
> +}
> +
> +static int obj_cgroup_charge_page(struct obj_cgroup *objcg, gfp_t gfp,
> +				  unsigned int nr_pages)
> +{
> +	struct mem_cgroup *memcg;
> +	int ret;
> +
> +	rcu_read_lock();
> +retry:
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;
> +	rcu_read_unlock();
> +
> +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> +
> +	css_put(&memcg->css);
> +
> +	return ret;
> +}
> +
>  /**
>   * __memcg_kmem_charge: charge a number of kernel pages to a memcg
>   * @memcg: memory cgroup to charge
> @@ -3180,11 +3208,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
>  
> -		if (nr_pages) {
> -			rcu_read_lock();
> -			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
> -			rcu_read_unlock();
> -		}
> +		if (nr_pages)
> +			obj_cgroup_uncharge_page(old, nr_pages);
>  
>  		/*
>  		 * The leftover is flushed to the centralized per-memcg value.
> @@ -3242,7 +3267,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>  {
> -	struct mem_cgroup *memcg;
>  	unsigned int nr_pages, nr_bytes;
>  	int ret;
>  
> @@ -3259,24 +3283,16 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>  	 * refill_obj_stock(), called from this function or
>  	 * independently later.
>  	 */
> -	rcu_read_lock();
> -retry:
> -	memcg = obj_cgroup_memcg(objcg);
> -	if (unlikely(!css_tryget(&memcg->css)))
> -		goto retry;
> -	rcu_read_unlock();
> -
>  	nr_pages = size >> PAGE_SHIFT;
>  	nr_bytes = size & (PAGE_SIZE - 1);
>  
>  	if (nr_bytes)
>  		nr_pages += 1;
>  
> -	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> +	ret = obj_cgroup_charge_page(objcg, gfp, nr_pages);
>  	if (!ret && nr_bytes)
>  		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
>  
> -	css_put(&memcg->css);
>  	return ret;
>  }
>  
> -- 
> 2.11.0
> 
