Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8232AD70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837641AbhCBV6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1581604AbhCBS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:59:40 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 122Iiiqu026311;
        Tue, 2 Mar 2021 10:58:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vWgcOfqUaWjNw49VbbdqEwGEjGFrwkKR7CY2v3MoBiA=;
 b=MqpxFlg94ciNy3PVUfC9VUu0ThDFeagAxaeKKOx02FyAiqAYQ85TYNuMXBhPLqtzWBVT
 3GVUsuyCzA5dbk4oVQ1qhyoHtLquDS6pO6QuVIHBqIL7NNEvFMgIpgcG8K1iTerPyhrC
 pRGgDdmEkfjMU9pooVf7EwGanNyzMi5FFmk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 371trm85ma-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 10:58:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 10:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxBP/byFxm9dj9RgU4OamIHahwJApozx1jmVDfwBAkepqFKt34qK3QjJvtr63nB6tKAzguqnPqpm5G630d2E0fbhVQEcnwyEalrBDty0y7PFtnMfFdrf6kayVY3k24/3DibSIm1j9Nf6Zulamf1B5DAx55XoXuuaklouSxs/VsQHbuouavZym/r/W3KL8s8O3I6xReEUJfrnEzc9JsuBFdMCKz3ltKsF1W6jaxBjdyJPTVe9sAk2CXy5gwBEgcGBZAA+37QNlA+M7JJIjpYlBecEwqPAi6nnySGD8wtu7X843A+MPYfCXFMDFbz2mgCGiQnOeegp0PtdRx8XpYTyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWgcOfqUaWjNw49VbbdqEwGEjGFrwkKR7CY2v3MoBiA=;
 b=B0rY9rFSC9W5/Pi14lJ1LtUbBTCwUIJYLFDRhfShXDgSb8rZ8AkrAirDGbJ4/8vJLh5qgoGC0MAU04O9kXMfQWI9IrWH2Ta2BdYsWCjjnb1qfFazndvXy8wF07SRyA5dVYOsbp76KT3GzD1wCMRJhf+fSCwn9Kqr+iz5h311UkpeEMy+YOPukXpIlSQQEimNPmvYAfE5ASR13Yna9iEbbiDnDI9zZttmAglGhS9FfcTFfcWacGRa+6QcBY9qsP6bxyWdQfqjXrcmNgqwb6YJxLO6MFC5zUnbPW7soCd/WXKoNdgCaNw/q0MSU1qon2i1w4Ic/RiDQKEpPs1yd8z7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4134.namprd15.prod.outlook.com (2603:10b6:a03:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 2 Mar
 2021 18:58:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 18:58:40 +0000
Date:   Tue, 2 Mar 2021 10:58:36 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
Message-ID: <YD6K3HghLy5glOgi@carbon.dhcp.thefacebook.com>
References: <20210302081823.9849-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210302081823.9849-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:68d2]
X-ClientProxiedBy: MWHPR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:300:ef::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:68d2) by MWHPR22CA0014.namprd22.prod.outlook.com (2603:10b6:300:ef::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 18:58:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a73330-b278-4f4e-f862-08d8ddad31a7
X-MS-TrafficTypeDiagnostic: BYAPR15MB4134:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4134BFAC574D7573D6681AADBE999@BYAPR15MB4134.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4cqQ8xB4wA/b3DZ6S9VCrFsysJiXxYe6/wij8Hv6uPBgbi/BMQxbEPcH8aiL/KWmMcoxak42Wo6OCG+zDrFltgG/S9KiyYhj4/B4jfThO59TzqYKcqjCmDJypp7ITS84LuxLfqph3+JvhETZNmUF25HkLjCJyObYeUnZyFijGb6DecaPRXTRGDxoZqLZWOtSIdzZEPg8jroM9QUo5Ck+efWHiZdaJ1Y6228lDxKyFP7CkxHgcTNq663iKMDERgDIVHH+v7IMeEXHB5J2/E/AWu+gzds9UT6z/sCWRUB8S8LH7HTnFoP6kWOQJMLAcIFLSOdtd1GqY53xFGwfIGNYwjLP1fs3lUPH8DiG4Tnjkf1bFShlCYxaHQI8f44gE1EttwOeID2ixV6nxYtvhALpFyJOhSeu8k5pynmFlB34QNmqoHQu/btd/FWZ4ize227knYR1zs1DdgWjLlfMeB41sl/JYOp7a0tAHu4HylejIUkXeIRVEt0C+HOul87I2FfvGeR7zLO4s6Cx1CyEeNWMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(83380400001)(66946007)(66556008)(66476007)(2906002)(52116002)(6506007)(5660300002)(4326008)(316002)(8676002)(478600001)(16526019)(8936002)(186003)(6916009)(6666004)(55016002)(86362001)(7696005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OpsZVGzU0qiluG+77iBS1UIVZ8VMRp9A5jMBW3s3ojHEoC8HnUj2cDuGffk2?=
 =?us-ascii?Q?WImvBHlpfrPSxNoc0zKWjOBq5yU5BEXKkkLFKHGugS1483fL0vDN2BkD7y4P?=
 =?us-ascii?Q?B2LRx2VlTeINBGJAwMTQIDpWMQPs7Pkfle6yNxDtQ8A9aAXlIkMQTb5SuPxD?=
 =?us-ascii?Q?gItKdv+KEpJ/XmwXQgPbTeTnU7gqx0B1U6xxZ31v0FbnGpUhXRUGTZFS6piv?=
 =?us-ascii?Q?XwU0J9VNeW6JT0xFLoCRMVTr9EgETNDvn0haQZo9yGM1JZN7j4ahKIJ3Usff?=
 =?us-ascii?Q?o+vig6sduO2NcV5qkyrK/jDQR0XX9aD/rQKrS4m0DAxB3U2PoEj6iPo97GTr?=
 =?us-ascii?Q?rXoVs7JvvLTJiWQ4OPaTHlcs2JDfU69XJGdSKLpQLhOCzFF6lSXlYpHPh9op?=
 =?us-ascii?Q?jyMLnIab+YPkLcNsD+bw+rCLSZz9iDffWulq3T4ICGUhO4E/iLaiC+8PCuVg?=
 =?us-ascii?Q?w0F8UT0YAmqAuL/u3zSNCIxFhzZSRxiU3gRdbhndjS12sLrHu8nwewv231lt?=
 =?us-ascii?Q?rU4GhNhZXunk0oHON7xFEShNansEnLGjTPEVNDJJAK5epogywuGVfPtMwkGY?=
 =?us-ascii?Q?ZpsnqZ9YFv3oL4T9tNI9HDk7hfwaXxYgD5SKHWGyk66RoQs+t65MM9h3GLEb?=
 =?us-ascii?Q?4VEi/FG5MuKrPRiYi2uoX2i6lMPvITVmtMGeP3l7+Yrt6oiOKHBAit82AQoM?=
 =?us-ascii?Q?sdI6wPiehaHkV3AmZkSJf88GcUmpYnDc/kRZ65yeImHv9F2NRqzfARAqk0CT?=
 =?us-ascii?Q?RPDcNdBhqcHMZ8mG4SIc/PnpwA2q0Sh0jCYMT3vJwtciHgTBDa+SRRX78Zbo?=
 =?us-ascii?Q?++lOQjN/NA1XPQcYTiFf/yCUWel55pDVY+qFu2g9FQG9fDAiZeOd0/AB9Bc2?=
 =?us-ascii?Q?Gg9z5o7p9S246DsBOb1kOWkF9MzYvRu7pHP4Jm2pqUuFGu2S5BQunx//7ZHD?=
 =?us-ascii?Q?yhZyhLbK0K2I6RGmlV0UO/1J/Ei7GbLbPQRLNIHxvy+dA8Hexn41IoUCEq5z?=
 =?us-ascii?Q?RJyXgQAIQCHo80zEPrK32EECYt9qBxpgO3Jb8nuZX0Mm4P9vnNRrYFXkibPc?=
 =?us-ascii?Q?fAtNQr2X35yfHjrrNBwDA+pacbHj05Jtx+XvtM8Ja+w22Rnhu3gjHN/QECCD?=
 =?us-ascii?Q?nVOvYj8w+dMHrH2nzQa8X/2FgKnsBEwizlWu+02/wY4uSIugQA5+ijjZRyTb?=
 =?us-ascii?Q?7K2V5/iD8dM/AWXk9k0JNvAHWYlzCM0KjCIdpks5t9FpIXGJZvTy5DqLCXeE?=
 =?us-ascii?Q?jbiioSvOXjOeLza1pMa3JgRBN0syuk//wrxMUgnB9GeFyeOO17uyRRoMRk0Q?=
 =?us-ascii?Q?rX5+oLGhmeRGqz3hGYtNAUhUCW/bJj9FqeVJJ0viiNfulA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a73330-b278-4f4e-f862-08d8ddad31a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 18:58:40.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa4PKu7NaG5Mu5Gr1xR2GX4bCWNSMx3M4JCPuzgAMmV8sEXCPz7xDDL6s3BtN/79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 04:18:23PM +0800, Muchun Song wrote:
> CPU0:                                   CPU1:
> 
> objcg = get_obj_cgroup_from_current();
> obj_cgroup_charge(objcg);
>                                         memcg_reparent_objcgs();
>                                             xchg(&objcg->memcg, root_mem_cgroup);
>     // memcg == root_mem_cgroup
>     memcg = obj_cgroup_memcg(objcg);
>     __memcg_kmem_charge(memcg);
>         // Do not charge to the root memcg
>         try_charge(memcg);
> 
> If the objcg->memcg is reparented to the root_mem_cgroup,
> obj_cgroup_charge() can pass root_mem_cgroup as the first
> parameter to here. The root_mem_cgroup is skipped in the
> try_charge(). So the page counters of it do not update.
> 
> When we uncharge this, we will decrease the page counters
> (e.g. memory and memsw) of the root_mem_cgroup. This will
> cause the page counters of the root_mem_cgroup to be out
> of balance. Fix it by charging the page to the
> root_mem_cgroup unconditional.

Is this a problem? It seems that we do not expose root memcg's counters
except kmem and tcp. It seems that the described problem is not
applicable to the kmem counter. Please, explain.

Thanks!

> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2db2aeac8a9e..edf604824d63 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3078,6 +3078,19 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If the objcg->memcg is reparented to the root_mem_cgroup,
> +	 * obj_cgroup_charge() can pass root_mem_cgroup as the first
> +	 * parameter to here. We should charge the page to the
> +	 * root_mem_cgroup unconditional to keep it's page counters
> +	 * balance.
> +	 */
> +	if (unlikely(mem_cgroup_is_root(memcg))) {
> +		page_counter_charge(&memcg->memory, nr_pages);
> +		if (do_memsw_account())
> +			page_counter_charge(&memcg->memsw, nr_pages);
> +	}
> +
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>  	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
>  
> -- 
> 2.11.0
> 
