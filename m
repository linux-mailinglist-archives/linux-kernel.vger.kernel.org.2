Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C6439076C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhEYRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:23:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhEYRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:22:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PH7xYK010655;
        Tue, 25 May 2021 10:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sndNyLDiue/kQDXaAVVkwPdXmiCQYKSgaaGRbbQmpj8=;
 b=BOx/zo7CiK6Axs2+qtxEFcfyf10SbrBKfOZSiVYwvJ/mRtNjKXSJXsEadr/Cu2T6ElLH
 eRqT1e0e2Fv8VooO2DjlQo+TQsrIdqZw58NK+kM23wYBRY/tDzStCHZQc6vS4Jl1PfVf
 T5FMERy9ndyMh+UrukwtN+bQmHUai9x00E4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38rr054c0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:21:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMDByNJ3BBrlzF/zMRQe3hhMuIj5A2++t3BRzvCoomMN9nWcptfYj+J80mm52myVZnnmfIYJKSXP643DEK80NqgpBk7WJTY81/sFwc5WDeCJdCHe2M1neIj46eH/bH5MfEv/OjP760APrIl3iY1SRHLFcB/Bbp+oT+399hgOsuEEfdna6+VBJ2oJO5JLfz1ZondKPnL+GWRtttgTMYl44IHdd4I+Ve8cFm5waeGZSVt/XzNDaYI8u4Lggk+auyjl5zJU+4aVMXvncpkcETYY47xEQKuFoTWhlutM2KbJ6VL1xqCcM1Mm9FnSzS8LDPmtRVMFOTp9Oy/G6WnaZEdJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sndNyLDiue/kQDXaAVVkwPdXmiCQYKSgaaGRbbQmpj8=;
 b=cGU732EF3C6gwtM5vNF6mzPFwifk/QjSc4jz6YTkh3N9i/uCwZRbLGqG9zBbRfpnq4sKkM30GVw9Ycp6JM7eiz7qyHqxDFGCmtR6P25SfAfoAIN3MkrVwQBgfbcHOatk0uiKtQigaNDJeunpmjf5svDQn0sFVZSQIXvL4Pu4smSdj0CzLIyEAopcf8PSWHZMGz0oxL9Sml8ePp0TYyi3GJGLRsLm1xzITlFR+WNuQZorxM12wGHNUXc3zlsZUW7kcLShcNo6wbYuThFxKaklUXFUkepQavZsqKM6sA2tZ4TEsASsxm1pbpLHy0OqcePTHJIXWHiE5Z6kZnLIjgPWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3288.namprd15.prod.outlook.com (2603:10b6:a03:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 17:21:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:21:14 +0000
Date:   Tue, 25 May 2021 10:21:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 02/12] mm: memcontrol: introduce
 compact_lock_page_lruvec_irqsave
Message-ID: <YK0yBhDj+9zJlz/d@carbon.dhcp.thefacebook.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421070059.69361-3-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:c10]
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c10) by MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.2 via Frontend Transport; Tue, 25 May 2021 17:21:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07184d2d-8d22-41e5-2d87-08d91fa17fc1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3288B1395D9CA0738A222F70BE259@BYAPR15MB3288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfyNib4o4PQKNI107CaxWjnHBeZ1M46XuC5iUXFM3ZOMhh3l5RZhFvLcvF0SPOwHBO4i1V+B84OtitSQ5LyL63u12VewKmsel8hmNpr7fk8+3gfOU30OcUvTzd3UQ1lqXShaOfyPaIGVArSF+MtjI+9nNAZjcKVDX4IonKkkeftOB8eNk32Ef/l0OmXRlj6wVYAw5GEOBNQClDqtIsim95juOk+UYKDFnOPwDSo9XGk066QKJGz/KmoeE27vK9MPXAZEG6AEAGTQyzwyCa84r/tZXDB78ZpkdgWZej0ExlwkIbTOWui78n05Ul4ZW8JzXY6UnhI8EvNvogDG5xw/coAYhOcuhsgsKkniCEnpTCV+CW70POhAouhCrogUg2bdPNrhUa2L5ijT58xOqHpS4H1d24mF4UuC26zWv5MnjiLvP90ObPaXDkOEqrNCF7KqL3VaYH3hWIGicEVLSYMgX36S5qXGSIVII3hRSyTUd4fQ8eph0xkHCXWjxya0S2lVQHZyCF9woHCdSJOUidw52hFRRGBELVfvhgr7op0VMKny0CS+nouY7E+n0uZsw6Jwnxo6bVNXjSfr27I7a49oCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(9686003)(8676002)(6506007)(66556008)(66476007)(16526019)(7696005)(478600001)(66946007)(83380400001)(55016002)(52116002)(7416002)(8936002)(5660300002)(186003)(4326008)(86362001)(6916009)(316002)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VUMkDK/6fa6yhkkIgD0N38o5mha7Lfyuj/ZVVXQTapk5jMN79zJfI/ICrE/o?=
 =?us-ascii?Q?F5zwD+ZdyIQXDcPuaEpTyzly31877//XvjiaSEG5IBpWoTHEUC7kl5AKFREG?=
 =?us-ascii?Q?uwr06OzsHXPkD021VwBJ/EMROaxxeHe5EVXx60/mVxMZqFa+R/VGN/jxMMar?=
 =?us-ascii?Q?kQZ9RrQx9wDg3ROG/LDGmEqiYl5ugwhTZBxO2wTiSZ0DZGezlwyK5KGZ+lFH?=
 =?us-ascii?Q?+N/SXSi2cIxEGBPae6Q/vxxzru5b5F8nGScq4fHquscJh326CAFbWeCIqZSa?=
 =?us-ascii?Q?o6yuNRaBu+SxEUpB8zOc5+4c1PR1HAySgBinBUIyOM6sKrZCFPFVgkg1NlDO?=
 =?us-ascii?Q?N4Ym6WIoE1V1V1fanXYFfB8Wu4AHUjMxEc7+z9esu9FZD784uoHndIsAcas2?=
 =?us-ascii?Q?BqWK1DyEjResykLPvMGvkXiDFTYjSwKxMUC6xCGVl+1rgqYXBDQ9fugL3kZP?=
 =?us-ascii?Q?iC/3k8TnHpAwTtfjx2LBW+N8iXTWPlGdYizMFhQBC+tXmG/kFT/dwTDWrC9J?=
 =?us-ascii?Q?unMaaMlDHqKIQ1Hhdn+972U/UN/4YTOWdxhclzifsvd3Wbhc4z02D59DBASG?=
 =?us-ascii?Q?asOxOO52Sj4TF2kdM2Q6Js1NHcZkXZ0x7GmXnW/tYCtISqrb7UFh3AhEe8c0?=
 =?us-ascii?Q?DdhM8UMHv2034MMU37hM8uhtj8WZFwImjmed1XmqA3MUSwDQ5/O+S9F2pida?=
 =?us-ascii?Q?KtAGFR2AZUhJH43QaWJpMm6VLGFlF71zXe1GaewoAsBYsF9jB7H+ugesuCuj?=
 =?us-ascii?Q?BjTKGsyRuHeQo8GiCfSVQtPC+xIwxx4CqpxlWufXi+3ZHbXYiFKiLYnUGQvS?=
 =?us-ascii?Q?qngYU5yvVoW8BR89NB+N3/jLtJFzZGkIpVPSbZf3WgZNybJW7hBJ/GsqmAIZ?=
 =?us-ascii?Q?/dNxQyy5cHJrWqJb6Mu7xVL8bN31Tyb0KcR9yRORr+pEgb8UxxP9Of/hq+c/?=
 =?us-ascii?Q?Z9vQ5StBwW1ntoGZCDiyzp9bxCBzwfU+RK/ER/ZdzCBoNSZYxbdNKRatzctL?=
 =?us-ascii?Q?vum09Tryz9o7pKTrX8FcIV6Jk3FpPcHZelrmO8RjgQihpcpUL96nf6XViA+Z?=
 =?us-ascii?Q?xs1XTZk9+PxilK88PyxO6tZbfzxBkDTtIyFFBB2BAqW5A0Pmi8DgrMpio4y+?=
 =?us-ascii?Q?nM0tomRoFxwSUndjfw6PZQQPxcyGy4Y1HJTjcKQKj3vdxSngCN3x6LFMTMvD?=
 =?us-ascii?Q?Lfc4fKEhHD8bofOtp7xMvYOYNIzbSrRBPmmAhGaNTTcMfkkl5cqFwGUPyDzX?=
 =?us-ascii?Q?3HBUB6+wCZ+W0IQYMQSM2TuyH/mwHJwQP7QFwaSVn8BQ1URjCKYHy4jLvi4N?=
 =?us-ascii?Q?ZvX2S5ciGVXo299lWK8z3GFnaz7L3JevMUGfs3A0e+VY8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07184d2d-8d22-41e5-2d87-08d91fa17fc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:21:14.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17GrHELJYAdrHuF9VlEw9TT0vvYSg3QXM0UvHJF2ImuR2aDxUhr9PL3Oi4ysHM8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3288
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: mJ3Xh3PiC8DKI5V4eJyJcUF__8AXwy4X
X-Proofpoint-ORIG-GUID: mJ3Xh3PiC8DKI5V4eJyJcUF__8AXwy4X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_08:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:49PM +0800, Muchun Song wrote:
> If we reuse the objcg APIs to charge LRU pages, the page_memcg()
> can be changed when the LRU pages reparented. In this case, we need
> to acquire the new lruvec lock.
> 
>     lruvec = mem_cgroup_page_lruvec(page);
> 
>     // The page is reparented.
> 
>     compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> 
>     // Acquired the wrong lruvec lock and need to retry.
> 
> But compact_lock_irqsave() only take lruvec lock as the parameter,
> we cannot aware this change. If it can take the page as parameter
> to acquire the lruvec lock. When the page memcg is changed, we can
> use the page_memcg() detect whether we need to reacquire the new
> lruvec lock. So compact_lock_irqsave() is not suitable for us.
> Similar to lock_page_lruvec_irqsave(), introduce
> compact_lock_page_lruvec_irqsave() to acquire the lruvec lock in
> the compaction routine.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/compaction.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 1c500e697c88..082293587cc6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -511,6 +511,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
>  	return true;
>  }
>  
> +static struct lruvec *
> +compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
> +				 struct compact_control *cc)

Maybe compact_lock_page_irqsave() to make it more similar to
compact_lock_irqsafe()? But it's up to you.

Thanks!
