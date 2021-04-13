Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6C35E5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbhDMR5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:57:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhDMR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:57:41 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHraGB014367;
        Tue, 13 Apr 2021 10:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rOo94+wUjAiKIFcp9Er8QowcHUkCsIb2i8fRQt7O9Lo=;
 b=XLmgDjTIH1P03bt5343LGRNc8bVt8y8vF+iDvuWyMq6XVblW5BGVHlO9w9dlq1921ONy
 clcZkOz1Osc+i2sK8W8hfOb2e2weCkH4mu1qO+G6Fpv+Bs0umKwRFKEtDX0jJrnMISZK
 nQDi3dCJLmGCdrvecywF6g/PtlQm+7TKiw8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37wabfaa71-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:57:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7rN3JThH3kn4tVHy3Yu6Hba20dMScG4k752ZMGepXQOSxRv+0RaNm0txdID4wnlR9Vk8IuJfD0auu6aIAjXrk2JwiluVGB6sAVFFCXuyHBDU98olYl5DNUg+JUjIa/5RQbA+liB//qvSGU/qMFl2yY/H3YgH9HE9ltZNd+/5ZT3GE6gEMoWyI8YWYEiLQC+tHYqcV5m7BA8H/P9IIat1KdYiOoOKtzQDh6OlK7NzizLs5ayvJ4xEv725uATTI1fOAve9yn3DSc2QqmJPWclbmdx9K/fbANpro4TYbDakuq+ICGEQDzCHNjrdk4jEXf6xglIAGF7erH6UaraoD1B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOo94+wUjAiKIFcp9Er8QowcHUkCsIb2i8fRQt7O9Lo=;
 b=eE/vF3pFyy1cbL6XAz3yQjRYdOpFFn+e9qApqkcLRc5+118pdPq6rNArQKCgfcV0SjEz3iZcjKUOZE/Ss/OpIyUcBUdOcFC4hDKyTKs02d/EqFPfExPlkXT6TbDzlZ29eIu/80E+6PppVGvqHatfvX+if1dBtiDFQilrwPlYZ65UD5gQ6GHR9xqcwOmueVYQmxdu2g79Ia9kMlVI+3/oZap8tqYv/yT/sJDaC3KsWN5AKEGe5IBTm8cpT20Xah5QkoXkMRX37b+Nf2LWU5une777Sqie7267k/GCknRBN5deSCXFT5agopdyqFtEoNmFTE+KsOcm+W8yay9GRPJ/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4632.namprd15.prod.outlook.com (2603:10b6:a03:37d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19; Tue, 13 Apr
 2021 17:57:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:57:11 +0000
Date:   Tue, 13 Apr 2021 10:57:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Message-ID: <YHXbc6rrNJVbZpsr@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-5-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by MWHPR21CA0061.namprd21.prod.outlook.com (2603:10b6:300:db::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Tue, 13 Apr 2021 17:57:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f5eda2-f0ed-4e51-45d4-08d8fea59021
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4632:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4632723DECBA927403A17D74BE4F9@SJ0PR15MB4632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEvRvcfyB8TWX9h7g3PlPJv1bWsEytElYxVFR9tEVnXGPNoFzmarp+Tm5nLVjBhvP+ImZTq2nAMAyffQnLDXpPN1OV3i+EiOC+Q5NPwUbw07eedkU5+wFbC0GmLlQTEw3dvqONYjuZ/uwCHNxuZ2BqHTn5ZPTZjH13E6rhoNdI+fS3Ujn6S76pELjg+xW4FR+C2uBKYGTQ2unOP6IgpmQ5VzXRGig3Cw+ohWL/VhQWmx/OoJbjqqWflTCmlZOMdPGQdHxR+/+76XxRD0VlhXxqRDPbP0Y8PJxoM3/IsJawWTemKoTm2kxoeYVE8VT/HFgv7qfyFJ5BmdEgSUVla7Fn08AmV8pcimnyZRiUry8r7V+kWPpVfJj8WpVPTwZSqlyUdBm7ujGHnxrmgQYDw15iF9cdhFqdqUtdwQIkIw4lahWRwCuzynMpNQbq2AsFY1gTIL8xSWJnBCQY+95gAmXjbIB1AZbsbMkeIMQCr/4ZpnVQFIYVjjHD7P+xPyGnxBgqg5oXbfVPzl+lZUL6yHc5ce9hnbFLhcwxguZX3nnM/bvxBuySyw0+IV397co5w/E+A9cdBxuJ3EtdbpTwDgSDy2lsidwzNBlN2/JNjoBo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(136003)(376002)(346002)(396003)(316002)(6506007)(7696005)(186003)(66556008)(8936002)(6916009)(4326008)(8676002)(83380400001)(2906002)(66946007)(38100700002)(16526019)(5660300002)(52116002)(55016002)(478600001)(66476007)(6666004)(9686003)(7416002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BPXyNuL/VgPaUksXXrz4yoYLgoLKMpnoqggX1OYZtxTF9rytM6jVdlG39cL1?=
 =?us-ascii?Q?g53t37DUaj00NgtPq5IhKzRBDwJBhQocWqoHYtaX2vW5CqoH2LcjhD95mNsS?=
 =?us-ascii?Q?D93bFBfGFw+SYgY6Td9XRv4p0IT9+KcsCrF70KUTX3yZy+Ld250dAV2Am6w0?=
 =?us-ascii?Q?j2/17F3nt4fCXbXCm7mM8VSoDyDqf8/BMiqABkzNJCIvzwlKdbUSpMQyDIWW?=
 =?us-ascii?Q?lnxeh2dJMWk399t+cq9KD3HnAFVXA8LSVddEQn5SYafGr95h31PTLToIH3Vh?=
 =?us-ascii?Q?MuVh0NncXqAa5qHHAljjaMkNol26go8tORmfNl+rN1LAp2/Wd5iLtcFrMFkx?=
 =?us-ascii?Q?nmp1uiddzX5qEFIkbA8jNg+sS3KWPu4lBNp1wdFiacfABPpm6j0u+qoL1T82?=
 =?us-ascii?Q?7Ww115Q62WB+GI3tMdmsB9GbMHb80U2bfpqM5FvVtqvktjJZA0fIeG94x9zl?=
 =?us-ascii?Q?jjgad2/vfBZXChFqhzhsxLF6CIqGdLhyHi1+VYvOmR7Nqymx+WRaNIeP+Kj7?=
 =?us-ascii?Q?EJcKQ4qu+F2bqLS1657hceTsLP+bC1usg0lIeWU1jYTnvYuu5N5ZHSPWJ6Cw?=
 =?us-ascii?Q?3f+ue54xUTiLk31SrnTHXALLadF9uT6ZF3n3DhS6Rc3t0RAXLtTWoEmymBOA?=
 =?us-ascii?Q?5puHFKLXhXffQtlsOLNYhxn1+iaLcCDsVpVzOwKDy56ByxkAsFigde84RX0a?=
 =?us-ascii?Q?CHWlr+QAyU0xE4qDIYrMzCJD6YT0N5y1EEidtyyrKRMC5lV3JzjtOl4iUx7Z?=
 =?us-ascii?Q?jpqSTiQs35iDD+aYm4WuUwonlmWkxSUJTipb4Pb87ABUWLBF/KTjuXJHB23F?=
 =?us-ascii?Q?NbGGGrb6XqPcqJv/C2HvloRAfvIMkSvzIb+gn6zaUuS1kWghlR96oFeCXeJu?=
 =?us-ascii?Q?3048kjVBNfgjAwBc8DqprqOrCBgPwEVqBnKvqsfTPTULUTRfnoQ5SBWOsVrz?=
 =?us-ascii?Q?+MQ7l9Nr0nIB8lf4ZxyCJp5DxbLTCJRueV5Xh5wUhG0vx6ftwlh595h+8BI+?=
 =?us-ascii?Q?J9NBX4SxYQEMv5XPQBKXbVueRMk/Hn1V5iJOFECnhNniqQZKlKX/4tkTfPCv?=
 =?us-ascii?Q?oI6wU+saZkFCVcDpk0SbKy6GoDRfcYrzwDm3Fl3iBO+xrZcCgzPy0D42v/eF?=
 =?us-ascii?Q?VXr/h/OTOX5tkF9G9Dg+z7qEUH1uKJBcsdMkdNZc2g2FkbV6uqF4xDLtxyDx?=
 =?us-ascii?Q?j4CBShmPDt/rA7PbFzI7bcNf8MYZ0ferMg3wLy1Omx8o7QDu7PXEuNl4DOgl?=
 =?us-ascii?Q?xJNEL+pz9s6rpKQIolk5k80QGn7viuYxIdZue8j9uACHBMV3p2TmmkRlR/nL?=
 =?us-ascii?Q?C+S2LnUMchWO+K7C39GkUpN0zvzlMocJ5OdGLxzcr1fWCu4Apw9QG3h36x6h?=
 =?us-ascii?Q?ppCY0yg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f5eda2-f0ed-4e51-45d4-08d8fea59021
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:57:11.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRrZWgk7RD+vgk0ZHLZkwAouf7uYr1pYGP9lv9vje4RTE4S9FYNr+M53Kjv5AxCu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4632
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: BWSwapDFZbf__dk6FzhMBk5Civ2FjoyR
X-Proofpoint-GUID: BWSwapDFZbf__dk6FzhMBk5Civ2FjoyR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:50PM +0800, Muchun Song wrote:
> We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> to simplify the code. We can have a single definition for this function
> that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> CONFIG_MEMCG.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>


> ---
>  include/linux/memcontrol.h | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4f49865c9958..38b8d3fb24ff 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -755,22 +755,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
> -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> -					      struct lruvec *lruvec)
> -{
> -	pg_data_t *pgdat = page_pgdat(page);
> -	const struct mem_cgroup *memcg;
> -	struct mem_cgroup_per_node *mz;
> -
> -	if (mem_cgroup_disabled())
> -		return lruvec == &pgdat->__lruvec;
> -
> -	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	memcg = page_memcg(page) ? : root_mem_cgroup;
> -
> -	return lruvec->pgdat == pgdat && mz->memcg == memcg;
> -}
> -
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> @@ -1229,14 +1213,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  	return &pgdat->__lruvec;
>  }
>  
> -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> -					      struct lruvec *lruvec)
> -{
> -	pg_data_t *pgdat = page_pgdat(page);
> -
> -	return lruvec == &pgdat->__lruvec;
> -}
> -
>  static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>  {
>  }
> @@ -1518,6 +1494,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>  
> +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> +					      struct lruvec *lruvec)
> +{
> +	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
> +	       lruvec_memcg(lruvec) == page_memcg(page);
> +}
> +
>  /* Don't lock again iff page's lruvec locked */
>  static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  		struct lruvec *locked_lruvec)
> -- 
> 2.11.0
> 
