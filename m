Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1B390811
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhEYRsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:48:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35740 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhEYRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:48:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PHkUbh013068;
        Tue, 25 May 2021 10:46:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xbzHaCEMJ3E53TmJA29ZMZ6/sd4EGCh2EMIMJUmccA0=;
 b=cAfGv0H8YI2/S+coYfwL3oue4fyJg7ERROR4o9nZTZCJxf8YF1xYddaiM9ltj/tgwFIF
 IgTmQrxK5/Ps/VBM/5iy2EgV+N6FUHYXQQA/IHI+k8ogdLpyG3GcE+MDDItUIHH3EfLp
 obEu5ZLkTF4FDPEx8K/Mqqy571X4e8vlk6g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38rprvcu05-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:46:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRvXHgIP4qz+RgTVRfH090n/7T1sh5fbDnCFdlUl0ey0UmEBVK9NTKlVZ+zwsSCw8HnE5xImgYxm3ejdJjpGE8DuXEJlbei9iNFY5RbiHK/K2hutQp9KsGunqk+m3YWcK9+d+J7NO+6XPepQworflemYfAFyeqkgFbAsBQEy4lg6SQYifyqIjVBZ3O5tA6OdI3paa6Gw9Bxni4Gzg65PitXxVIMYJJ5IA9e0Ipgbiwmh9XkuOhG7ul+IeDZ1fZSBlheS0Sf9rro60/RfyAPQaQxVqrb1RqqhjMg/Rn0o/s4YZYJt8HEg+/ifc+xxH42UOVK5NcfvvwQTmO4hZaMw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbzHaCEMJ3E53TmJA29ZMZ6/sd4EGCh2EMIMJUmccA0=;
 b=R8/IL1ovSYdEamnAO1YxEaIgfFEQWKfeUIcp+Q6POJyg2q4MlBagJE5uHhjIXFvOhyhuNrbTEacnn/LXlNXuKr9f81W6QaV5+gY+ag8sYa2oELuju4rDrW6MGAlbB6A9HV0tWh1HFM3jqF6xZwf9FrWJ7CQ6PGZfLzGBHs6DT0ImJq9PZJlxhnTek9GwfL1buBEBWeFghBlB7bdjc63tG+pZbFJ3qn1hFXrr15O0DSYI+pmOsFSajyAKvlbkprQXLzbLIr0AZq9TbiQ5aWNY8wjoLmilmeQ0rZTxcW86U+zSrgNkK+nRkVBDPOInwnb6CLhheKHUXT0nmDOnmpa/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2344.namprd15.prod.outlook.com (2603:10b6:a02:90::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 17:46:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:46:36 +0000
Date:   Tue, 25 May 2021 10:46:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 08/12] mm: memcontrol: introduce memcg_reparent_ops
Message-ID: <YK0398uCuWuAuSF7@carbon.dhcp.thefacebook.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-9-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421070059.69361-9-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:82e8]
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:82e8) by MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 17:46:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab1d3ce-cc23-4119-2f88-08d91fa50a9c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2344:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2344D97FD43C257421CD9071BE259@BYAPR15MB2344.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uPOKpcP68LAHpXf88ewlLqk7CLhc0b1xwUM7a+6iZ8YpbtRoIIhnGXrLnfQRB90Qfg5ipRR/4oCp4R5kLeLrVrqyU2m2/Z6CH+Nvf7tR2U2wIovVf4JOjgFD/OU/MWlJ/T8x9FcGq3zZ2IbZk8VvXakyQUnN0IE7YmAQ8DgkDmQTb2KI86ngS9uIMYNM7MKzsMHwgoP0O779W1WCPH//SWqSNdTEqOaoBc+Ptc+LuiqQjyYEOTZ/BTKI6qSMffwsVYPLG3JqTezoeHMb3WIRn4L2ZPhTFLz3v3o+j4lKvYawoZHGybd04wP6Nx8K+Cdjvl4ZzbnUhRfhHy0yWySs27NsfTeakHRgfXZz3UVv8cyzhMjSqMw/1MY0PRQ043RURPOPmz0XYN1zHnMnRKWJdm6zRzWzOBM4YQ5uuKJJipQp5JgHEEJdyORB0PG6b66BF2M/TQc+vMZmP6VRO8MW+ycy7cD/GJuDgQO+/Q8nw9d8pxnjSEXCqRROmqA1vL6jmghokom0ItcAV9usWdqj0niOPGOPdr2Q9ztXeucN6iA1c2zZqDDmDohYUf3WXa3gYHE10cp7+S3zNSMzF6UJ7IPyZuv2RrBRQX3tnSkc6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(52116002)(8936002)(66946007)(16526019)(6666004)(186003)(4326008)(6916009)(86362001)(66476007)(66556008)(2906002)(55016002)(316002)(38100700002)(9686003)(8676002)(6506007)(7416002)(83380400001)(478600001)(7696005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O8/8Cs3iJ+x6TE4hT0KsOreOsotbgB+j5cGTA8h165sM3xqHaeAF5/avJ4a9?=
 =?us-ascii?Q?7QdnmvBlsF/isfv9YTsPlQ3Sgtrs0Ah+iE3sflTltyT5wKz2gYEBADss6BnD?=
 =?us-ascii?Q?VUwLCQ296rhXwG1F4Qz2BC7wB+UYCpeELmxKkoZeqWNFhwQtJYgchyWZ5Ff6?=
 =?us-ascii?Q?95gXuc6QEVy7jgEXAEIS661c5RJGQHovpQ6elYKSypCLsOgEdqRSFbA7vWuP?=
 =?us-ascii?Q?uRY+GiGJ7cpWGlByiqTUvAXZvFA+XuAB9qRezvaGDbgrAJDFI3W08BY9FU50?=
 =?us-ascii?Q?+fhAQHtyA7qgOlghQevZ0+sJ8PKt+vnI6r/4abNTjhTgj/07bcKYw32CS0PY?=
 =?us-ascii?Q?7mTnRkvQXL1u5njQCCUKt0rcTA5nYjp3bJGBUNFIViTr42KFrSzH3i7yXBK9?=
 =?us-ascii?Q?ld/ZvGM2eLrcpHOn7suoGVjzHNWYyaze+3YYI8YBjbO8IuVuJgSS46XHdW2z?=
 =?us-ascii?Q?joSHw+HHRlSEcxeSpk5oTkizu6ek7HsT9cRdhaUtNX6Wz3skoimJurhP8n2+?=
 =?us-ascii?Q?pMoo1UlaynMvTITQOf4b3DMI0tFaNqHre97i8VGygwWSq12+uwuFC+FLa/1E?=
 =?us-ascii?Q?TB/tk1daYJgdqBQXSbuvn13idSORky6u5i0dE3k8JF1qzV46nropjA6LfaCv?=
 =?us-ascii?Q?ZgDNqAV+96yUfyPrf7ZFi+ACMm+bsz/ZUaupFptY+2xjmzSI9Y4dNV3QeIjR?=
 =?us-ascii?Q?U/TkhK4Yu1Lw1+lMDvvovrMAQwiOHIuVgkyC0j7rDw0+fcyv2pJNF0TKdmRI?=
 =?us-ascii?Q?cWo30DDflEQxeMinKACy/RfNNxcn0W7Um1UdQ2jPbVBPe2fRW146UaCfVCiG?=
 =?us-ascii?Q?DVAxqXa4B218l4v+nsPbCT2OrPGQoyhSyQrj9AGK6SkdFpQ28rbT4El9DYk7?=
 =?us-ascii?Q?6dM+UQ5bQntV5cTjWCczOLZ8uUTZBedmSphR+GQ3yO7Cw8c3rgNoLfvs2WoX?=
 =?us-ascii?Q?AFv3JYCH/BCozNiPxTv9M79FBDp119cAKuTnYnWEDs84GtxzHcXDJLzwnDcw?=
 =?us-ascii?Q?ZLGS5/bgHh+WemWXLgelmNXfxcN9NwQsNTB9yjDBOxOU41pgKmMWhR597Bzy?=
 =?us-ascii?Q?YaQJT8tKmm4UBuwTXEn0y0LER/aM+4z0Y7C4HCKmfi7mnnYvzPXSXptYyMC9?=
 =?us-ascii?Q?i8tFoxNhPS6NRaVS07fuFClyeDi5DPgkXS0wSes9gO7rOHIF6Oa0lfZV1bb+?=
 =?us-ascii?Q?OWCNpksQjYbqhx6WA0TeOXxyPMytlqCFTCk8QLuVFQyBFtKrCmov5rFXiN5G?=
 =?us-ascii?Q?ncChFP6P8hM8HT6sds5DXeCCFozC475nC8QnTl8s45mbRZWYtkvI52rfHxED?=
 =?us-ascii?Q?avKXs0v1piKFNo+pHMIuWb0YE5B9f7ogscvhrOK3IOtr4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab1d3ce-cc23-4119-2f88-08d91fa50a9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:46:35.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0p9MTM+1HRo4awQDeECd9amVM0bYI7F2W/h/Bmjb2VrWyltKb9PInSUEJHYp24l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2344
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uv1Oy2Y6OpXyM5xlQ4tjLZlU39bO52FN
X-Proofpoint-ORIG-GUID: uv1Oy2Y6OpXyM5xlQ4tjLZlU39bO52FN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_08:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=923 phishscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105250110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:55PM +0800, Muchun Song wrote:
> In the previous patch, we know how to make the lruvec lock safe when the
> LRU pages reparented. We should do something like following.
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>         spin_lock(&lruvec->lru_lock);
>         spin_lock(&lruvec_parent->lru_lock);
> 
>         2) do reparent
>         // Move all the pages from the lruvec list to the parent lruvec list.
> 
>         3) unlock
>         spin_unlock(&lruvec_parent->lru_lock);
>         spin_unlock(&lruvec->lru_lock);
> 
> Apart from the page lruvec lock, the deferred split queue lock (THP only)
> also needs to do something similar. So we extracted the necessary 3 steps
> in the memcg_reparent_objcgs().
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         memcg_reparent_ops->lock(memcg, parent);
> 
>         2) reparent
>         memcg_reparent_ops->reparent(memcg, reparent);
> 
>         3) unlock
>         memcg_reparent_ops->unlock(memcg, reparent);
> 
> Now there are two different locks (e.g. lruvec lock and deferred split
> queue lock) need to use this infrastructure. In the next patch, we will
> use those APIs to make those locks safe when the LRU pages reparented.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 11 +++++++++++
>  mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 228263f2c82b..b12847b0be09 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -355,6 +355,17 @@ struct mem_cgroup {
>  	/* WARNING: nodeinfo must be the last member here */
>  };
>  
> +struct memcg_reparent_ops {
> +	struct list_head list;
> +
> +	/* Irq is disabled before calling those functions. */
> +	void (*lock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> +	void (*unlock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> +	void (*reparent)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> +};
> +
> +void __init register_memcg_repatent(struct memcg_reparent_ops *ops);
> +
>  /*
>   * size of first charge trial. "32" comes from vmscan.c's magic value.
>   * TODO: maybe necessary to use big numbers in big irons.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a48403e5999c..f88fe2f06f5b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -330,6 +330,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>  	return objcg;
>  }
>  
> +static LIST_HEAD(reparent_ops_head);

Because this list is completely static, why not make a build-time initialized
array instead?
I guess it's a more canonical way of solving problems like this.
The proposed API looks good to me.
