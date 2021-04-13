Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884C35E5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbhDMRwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:52:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240954AbhDMRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:52:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHpKIW001851;
        Tue, 13 Apr 2021 10:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vWgOioGBjoWunOX2j9WT8ihRkkCUSBwvOPqtP/O3p4Q=;
 b=RkIi4quymmh8aexbFd899XSBrasQt0p78Ubwd00ztwecAjWyqvzbRFJ+WiOqaCLiMKyN
 HMcvC0DKn4SCFIh9tFTYGANGjNe8h/4ZNei1ZGF5IPQjE23efUeavFO3s9JktU+X6v2l
 6a31UTOX2cc27cALl4kmB5Uwj+LwzcdpxwU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37w4k83ver-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:52:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:51:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXxUlNr6zjBVOCa8aa12FspJg2RsP9nTaWkzlranr2f4dXKTz1WxfzXfRgQGBGzQ1H2hT8zTAt46f/hlH5yMF6+d5F41/E3EZTRAiVN2DwDoHzzPn/9FGFUKrcaQ6LFu/DTJxpbbnezGivttZ0njsaQ/TCiA0fqNdFUVN8+M94G4tDoIJtYmHI22BWbU5ne/ZVYpuKnXFDvcEXYXX16T5HgmCvA809qCO35RqJIc+3dByzWn8BGYax5IRX5PGdBrWEmENW9eubakYAyHeRIPt7w+6pvrXFtYahgt0lPinckp+9UxJTt4lill3dUOj8Yai1EZO4Q1RFMgMH0z0CDbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWgOioGBjoWunOX2j9WT8ihRkkCUSBwvOPqtP/O3p4Q=;
 b=k2KO97/oX+lZ7gh7nYyMRrQYo8cX5br7yzYLjc0MLiHBYznyWIPTPjpOCw2X7V5cbjimtzUvfR86vfWB1aptlZc9VjmWO/nO+phNyB2IraY3HsOd40/4xsW1D1BFBInMyLDabpFKEqcQFwj94i9o9H5lqCWgAf3YXfT5AcZtLkD3obMLmE7AZZd/shivLuwLFsRl5YlhfebNpvXmNqaVAQ7YVjGmELCUYeYL4ijhqLbsEcvKfg8Jg29jvjGjBMkJT5AqwiiOwCU0dhL1DdMkznpBMXXmjCb3izfhDIvBd6Kw5JMAX8QTEykLKRai0BbWhoENUabK6ZcIRKIqzduNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 17:51:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:51:39 +0000
Date:   Tue, 13 Apr 2021 10:51:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 5/7] mm: memcontrol: simplify the logic of objcg pinning
 memcg
Message-ID: <YHXaJaMUtXF/Y2pD@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-6-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: MWHPR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:300:12a::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by MWHPR22CA0070.namprd22.prod.outlook.com (2603:10b6:300:12a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d3b8c31-e715-4364-b9ff-08d8fea4c9c7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2631F30A7CEEC7D7C93E0FFCBE4F9@BYAPR15MB2631.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROjBfrhX7OMlLucVLbdOy2vEz37K8TvYLrXEwowzEgQyz3rqvlUSdLiPHzBlcSHS+z++jwsdgdn3NABy7allamyT0Njp0dTHSCgmL62UWy1D5nj55tfD7f6mdeosDapzI7f8h9QWyk7O7lJBuui5mM+ziiVy7rVgWfw9/hy/oEeNLcYh2khnRPqLjJ7UdVQWa0Rndq/iRQnc0ESkHd++S5tAgMKIitRfTMfDONxDEzLvnrWYVdMk6d0UNCUgL1CU5lvln0xKTr2BOAkeGpkahPbBMiMrJ1uqcft3VSR40tolBuIwFcaKHkDriJGm4ALrr+/Hx+rQOVFZKuRdKYn8CeMqRGi/IXMrhod2Y3np6hqzpVlNUTjcEtgChIJOhN7msmkNmtl8qyKtDUTpyst+E/bREVrEUsNtIQhovxesyskJTRELcxVRGWRdt2WKhsGg/ReQWJdiQk3zal0xk7bnLeaYVD2V8mMFWztCY2yPQW28MCSAtTDMrprc15DNKblUGJzea2sxD09lNDye2jGPzzJsucLwU1l/1msVo01oSzauCz66ZgUl7Wif0Kja343WcPEP/pJQRspgx5pmj47mqhaNDj8YV5gp1mV9rO0je2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(136003)(346002)(186003)(2906002)(316002)(6666004)(83380400001)(16526019)(86362001)(66476007)(9686003)(6916009)(6506007)(7696005)(55016002)(52116002)(5660300002)(8936002)(7416002)(38100700002)(66946007)(4326008)(8676002)(66556008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G0eMs8ZbCMKMcSDrJgW1wliPjFwnLYcgYp5cM+60cXhkrCANv8od04HrX5to?=
 =?us-ascii?Q?xNC/o/Z4pQQolz3+vfwmWPwZh6wAZ5ZTgacoV+MYZg+tGcvU3zpCcjTLK7v5?=
 =?us-ascii?Q?92YrpPUJgFRs6oKGs4Fbp2Wm6uaIAVfYYSzFtmyW2nkeWEyIztY4HwzEXKyO?=
 =?us-ascii?Q?vRF4pIz0A7iDYfAHaFYvdf9A9SH4jimaJsyK6ZdSxSNAz4eysRsyDDWRnhvv?=
 =?us-ascii?Q?xQlU1PuJtbFL7HtZipJ9qvI/dlqTLzU3naU1qvI0ZBeZ8Fst7ZExcXYa5qWJ?=
 =?us-ascii?Q?RNms/MmzmMlcE3VKOo2g/Cnd7Ao29lwbys/nCwCzBMc3ThdCsnH1yFE80+MJ?=
 =?us-ascii?Q?wBLvmmxdGlsvUSO+/z0qH+82ptxdalDPfOhL0Rug4QAOoJEfG9uHiGunybvZ?=
 =?us-ascii?Q?fxkKYpncRzmVozFUxBmJsZrBOgzO7ZkHfPI6UIEQOJQhUQ8yQcInkRhg9Na+?=
 =?us-ascii?Q?kc33MgIFl8E8lM85JfOambczvjm3zafM2ePNTkNi+n5WBH7KToLSfGHrQpAO?=
 =?us-ascii?Q?rANzFqaIfD/dR0m/7QE1OA/VFEsltySkrpvdrDf0m/XYiyamXQ9ldNwJcIa6?=
 =?us-ascii?Q?RICYZau/mzgAawZLd3Ur44UQh81OrgC6cubDHdJmClkQ2RzKZ+MkwbaqZG6p?=
 =?us-ascii?Q?ef0m2Gz+hFkBdg7U7wW0xT+0LBlJuIjszx/tYpRMOKPpZcqqHJSCRv7CEqPG?=
 =?us-ascii?Q?iT1neqjETeQeMSQMtrG15bI1VHlSONTJFT9EjkNF6srILWpf/iiJtjsUWXST?=
 =?us-ascii?Q?1tOUaqU27tlCjSOM9nMZO7VdO22e/LqV5WGJtCxP2xKKcwQxBmr1fJ2ns31X?=
 =?us-ascii?Q?SfPnieiqetNr6gm+QZlyyrWnal+lRxE4C7YHWF4hH1waObjSmLXBlMGg4YOd?=
 =?us-ascii?Q?EC660ZkTHF87JqlquLT2TyJ6rAfKWo23zeo3cPlCRrQ8XdMimN+ahnoyFc2I?=
 =?us-ascii?Q?OY/f+/LBZ+hz3Gy0Qt2tQaGkp94YF4D2K9MoAZsHb9ccZ7GarhpRTybYMHC8?=
 =?us-ascii?Q?d/9J2i6BKm6PXT7R6jD4/u8KvJGJ4GTBXkIjdxlkdl+Q6bebpXTeEL5+kHsm?=
 =?us-ascii?Q?iHlt4JhDg2cmWK3ovAS7o9RY54LEkMh0bmFAdMlVtDWPNb50A1ppB5ii60Y4?=
 =?us-ascii?Q?2Sgy3eL0EaZHxbctomUhYMTDrnfLNqD+UolfjUaL7KB/CriM/+JY0zkkTW74?=
 =?us-ascii?Q?509XuIwG5kItEi30F3PG/UDZP+283JIliGlOa5c8HB6Oa02K9AXh3b0jKKh9?=
 =?us-ascii?Q?NiwNr9uCGTI63CWSUMrunYV22UHm9tXvySYfzDXRa9l4mRqYTf//wAB9udI0?=
 =?us-ascii?Q?eK5/7tWJEiyhmsvdASaaXOeHz3AyiUnzdd/fW4jBIrV6vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3b8c31-e715-4364-b9ff-08d8fea4c9c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:51:38.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hz1yoi7VK/IK+rtJlHBu5+yzd/gT2a+Zbrvy5ThcA8KC9HAn7YpmWb9mK7+ovUhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2631
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FG4wUGB4q_NuWTJ5716wJ10FgZ5vzXTL
X-Proofpoint-GUID: FG4wUGB4q_NuWTJ5716wJ10FgZ5vzXTL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:51PM +0800, Muchun Song wrote:
> The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
> the css_set_lock. We do not need to care about objcg->memcg being
> released in the process of obj_cgroup_release(). So there is no need
> to pin memcg before releasing objcg. Remove those pinning logic to
> simplfy the code.
> 
> There are only two places that modifies the objcg->memcg. One is the
> initialization to objcg->memcg in the memcg_online_kmem(), another
> is objcgs reparenting in the memcg_reparent_objcgs(). It is also
> impossible for the two to run in parallel. So xchg() is unnecessary
> and it is enough to use WRITE_ONCE().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It's a good one! It took me some time to realize that it's safe.
Thanks!

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/memcontrol.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1f807448233e..42d8c0f4ab1d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -261,7 +261,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  static void obj_cgroup_release(struct percpu_ref *ref)
>  {
>  	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> -	struct mem_cgroup *memcg;
>  	unsigned int nr_bytes;
>  	unsigned int nr_pages;
>  	unsigned long flags;
> @@ -291,11 +290,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	nr_pages = nr_bytes >> PAGE_SHIFT;
>  
>  	spin_lock_irqsave(&css_set_lock, flags);
> -	memcg = obj_cgroup_memcg(objcg);
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
>  	list_del(&objcg->list);
> -	mem_cgroup_put(memcg);
>  	spin_unlock_irqrestore(&css_set_lock, flags);
>  
>  	percpu_ref_exit(ref);
> @@ -330,17 +327,12 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
>  
>  	spin_lock_irq(&css_set_lock);
>  
> -	/* Move active objcg to the parent's list */
> -	xchg(&objcg->memcg, parent);
> -	css_get(&parent->css);
> -	list_add(&objcg->list, &parent->objcg_list);
> -
> -	/* Move already reparented objcgs to the parent's list */
> -	list_for_each_entry(iter, &memcg->objcg_list, list) {
> -		css_get(&parent->css);
> -		xchg(&iter->memcg, parent);
> -		css_put(&memcg->css);
> -	}
> +	/* 1) Ready to reparent active objcg. */
> +	list_add(&objcg->list, &memcg->objcg_list);
> +	/* 2) Reparent active objcg and already reparented objcgs to parent. */
> +	list_for_each_entry(iter, &memcg->objcg_list, list)
> +		WRITE_ONCE(iter->memcg, parent);
> +	/* 3) Move already reparented objcgs to the parent's list */
>  	list_splice(&memcg->objcg_list, &parent->objcg_list);
>  
>  	spin_unlock_irq(&css_set_lock);
> -- 
> 2.11.0
> 
