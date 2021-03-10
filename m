Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71E53347FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhCJTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:31:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233746AbhCJTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJTHMO009456;
        Wed, 10 Mar 2021 11:31:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qatbM7XiHRK2l6WnNxmpMotP1GwZrnLcSzoKLRxOJZo=;
 b=SIKVvAVfSQo6o8RmOlQ9hImSBymm1lqguoNFVsEE26yAIAaJRB2udru24tm20+PzFp6I
 x/SKxbpFjIGwDBZBEeuhAlMZLb24EBsCBuvrscLxToSnEn7U9FerT6qzOXPtK9YTvraW
 MQbZ01ie6a8KlN61n1s6Qfi7QTOUak0fgQw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 376mhbcntp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 11:31:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 11:30:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmk/5zKdQXBK+bgdDEobwTD9Z87I2jdAq7v2yRxcPXn5MRluN0gWvbEeFiRNqi0zyn1tUcCXXSyEoNzDl0eOhTOJTjV+uISNtjWPNz5SeJSd+9pIzWrob1jTtqO5uQCfXDw3OpJQSclklxhDFmy0U81hBo44yew0CckLVfDLGsGJuxX9dcerUY9DC67KvAKLv78Awd/bKlk4ao8LndF+LqXI82qlFv9KlPrJVP+KyPoRcoVZbDcCI/vEgeIlJ9g0M2vC2Y6r5JNopBfns4UvL1pTAnfFB5wyocaH1KP+vhTSJTGdYdEml2lBBdK99O9rJ0ooAL7E0sZ7z7rU/CznXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qatbM7XiHRK2l6WnNxmpMotP1GwZrnLcSzoKLRxOJZo=;
 b=RwefEljLkzYJcvqeNjjjAGA/pFJn2Qx3OEo7576kFxy1LWW0CMlv4vKkG+Rbw4t3+P8tojIncrfOp0TRpzUiyWpPe47kdlek8wWJQfQ/My2sA677/2qJBE4VFB+gaY+90ZDAB7flKouEZGNlg4A41l0uroBr9CS6D4ODD28nsOYLI90Z0DA6cVj4V3qz8aL1Ba6QMlUq4nCtq4hd5iP8Tc8h+dzAj+OObNZATxuAR6+Khrq1ZkWdPzjJC1YlFtK6D+HHF5bzvMY6EQcxLE102/I2mO2GuWWj3+qrhHTdi2qfVNqFSCw4i0m7q5nQqc/VX3iGmI338ycnxI51kGi5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4273.namprd15.prod.outlook.com (2603:10b6:a03:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:30:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:30:55 +0000
Date:   Wed, 10 Mar 2021 11:30:50 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v3 4/4] mm: memcontrol: move PageMemcgKmem to the scope
 of CONFIG_MEMCG_KMEM
Message-ID: <YEkeamViToqIyVP8@carbon.dhcp.thefacebook.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309100717.253-5-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:9b45]
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9b45) by MW4PR04CA0032.namprd04.prod.outlook.com (2603:10b6:303:6a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07623fe5-1a42-4382-ae61-08d8e3fb05dc
X-MS-TrafficTypeDiagnostic: BY5PR15MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR15MB427392722F86F13916DB50C3BE919@BY5PR15MB4273.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btf76MNML01WDopxIT6xD3l4TTp8JkeW8+kN6C4OXc5AW81UM3k5mp/OQ4kjJQl+v/dFFySpL/acn1C5mQDCPONY1o3N33cjUH65zLY4tIXjCNwISjIILlaK00RDJRjGADCvN79SEuDzxtmPx53vB6ODx/fILDS0ggllOd+wg/kJIqKwhx6X6NwU/AesxGiZMY77uNvzimDYxOn66JN2+XWuq4zUo69+roxJ755XtVww20IfZ0eoY7TdVAm16M2mXJ0etgXDRO0RA64Z5pT5m/JQma/0z2ck1yDE2woVqplBTLf/Q7G1g57tZXoRLmBr5lS86GvzwXDvpkWHBEjIaOMlUASXIYNh7vKhmwJ2VccgI0J24KCcDJr/PQzRwRZ6D3TSZkt8zIviC0XJPiYmhnvXrmMvg55mvyz/sys6gKvGnHVmINvAYslcZ2NWlXPBudQb7pUaQ0tvzPU6zm1HX+k9sM4rjN9GqczTmvnX4XN6/ZX8F++MoIdVrk51oFwccLslN6w7RyryQCzQyiXXdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(136003)(366004)(376002)(186003)(6666004)(5660300002)(478600001)(86362001)(55016002)(66556008)(316002)(6506007)(2906002)(66946007)(7696005)(9686003)(52116002)(6916009)(4326008)(66476007)(8936002)(8676002)(16526019)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OLX+QlAm2qRMuyXCPIQVou1Jza1J4LWdDeFhsrSYwu706ikZOmebE9bYa2K7?=
 =?us-ascii?Q?ieDyFs0E/C8euGTnv0SFlAwkFFsGNQ9E17j9ipL3lmdagE+GPmTEDMjUSoZq?=
 =?us-ascii?Q?zXONHWqWAFNVxo35nJP7fBwEURp5/31LC6yGW88A7QmawnIuK7j/KUctsYTh?=
 =?us-ascii?Q?EPjXeibnp6q860FBkEin7h9n7Gi+ZDWg6RInrJIouTSRVJlob5yXnNQFAPdu?=
 =?us-ascii?Q?H3gjTj6W77jLbK0fILom4rQofodKbYyjPAfSDa7TyK2qmkMkSzrWtSgVpvP4?=
 =?us-ascii?Q?FXZ5VeKqtnEuRIwlKB54xthddb6oqbhs3VgRixWaHkUrTS/7SN5pDgvOWXqO?=
 =?us-ascii?Q?31bEGhxd0IBLcMI3SmtLBcfISFBf1lGQwkSFPq7hdhbafk+DFugq5fiw1CO+?=
 =?us-ascii?Q?yoCeC/LafrHeR1nOGdQokMLFl2MjFkMACrDPtDe0Y0p52FTXBKZH0c/x4S/W?=
 =?us-ascii?Q?AHQvYKI11lg+4M7/fIYSZWnYg5/9H64MFjnygO+vZWVQWuMtRoZfu3NFLpOg?=
 =?us-ascii?Q?AKJd0Lp3Yz4eo9eoukeSB4yQKshEpccHtXBOFndy6WJ+QeBDtTzoAicJBGjw?=
 =?us-ascii?Q?oyY8USUNyK0ZA+H3W51HYya74WFXw1yoYXl0Hi2rmAm8c/nPGMah8jCshTmJ?=
 =?us-ascii?Q?OphsvYflPHW8TB3+iUNzBg8ZT5tbTOjslxwTJyvoSODv5pCwvQW+cqoQ3m9e?=
 =?us-ascii?Q?CAB81uyjF+LgXVE08n0Z0Twr8Y+ijEemZO6PC59WfTws6Og92DzFwjmkbZeY?=
 =?us-ascii?Q?H8MuBYRX6pTwXaZbPp5fXNkdu54TB+f+l+kpdcZVlPhBt7cAINrtspk9Ixbs?=
 =?us-ascii?Q?YsxsO0PyKfl9pNSVZ+VsifHakEEvx47SUWeVpJmcbaoqYNSz29rm+2vH3LwX?=
 =?us-ascii?Q?0/NjK2e0pDwG6XVJ7PR0yRg4FSu6XwhNpw+nv6EjjOrd94uEphQ4wVOI3kZn?=
 =?us-ascii?Q?wIlwTsuv4Of5vQcSdm5vOgUDG5e2SmohTtbXEZ3BjoLzr3s5ZpVF7fSqNDgP?=
 =?us-ascii?Q?Qwppej8r5irUPtjcFWvThJOoZbpUZHORrODkyx0tKQ/yBiNYZz7hNIC7JjUs?=
 =?us-ascii?Q?MqPtX2yj2VegfeEtKdGFvTHrPTVxnblCW4kNufISFpcrgSHKKQUMWTU+xdgc?=
 =?us-ascii?Q?Oyjt9ADBGFWiaxsHSPK3dkdnfgyzt8arslqurey/J2pGsxqXHuo7YgSco3wY?=
 =?us-ascii?Q?1wnVoRFS2vZh2XTpfUwZNnBAkxjgbTqyeFToGWhCh9KeNjrhrdkCMXTAKVNM?=
 =?us-ascii?Q?17IJ1HvUczBl74uWL8c6jQBRRUud6Bsz08TeKgf0ImpqpdvnVmg+Tmn0/OZs?=
 =?us-ascii?Q?L3L5JJ1s0jcsvvr/R456XP72Spg0EKm02p72Mw/JlcG72A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07623fe5-1a42-4382-ae61-08d8e3fb05dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:30:54.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbBoGggpJHUdJLuYeiz0CI4S7YI0u24LWic7w5Z1cyi1UjpeIBQ4fpSVaovVBxtP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4273
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:17PM +0800, Muchun Song wrote:
> The page only can be marked as kmem when CONFIG_MEMCG_KMEM is enabled.
> So move PageMemcgKmem() to the scope of the CONFIG_MEMCG_KMEM.
> 
> As a bonus, on !CONFIG_MEMCG_KMEM build some code can be compiled out.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Nice!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 07c449af9c0f..d3ca8c8e7fc3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -469,6 +469,7 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
>  /*
>   * PageMemcgKmem - check if the page has MemcgKmem flag set
>   * @page: a pointer to the page struct
> @@ -483,7 +484,6 @@ static inline bool PageMemcgKmem(struct page *page)
>  	return page->memcg_data & MEMCG_DATA_KMEM;
>  }
>  
> -#ifdef CONFIG_MEMCG_KMEM
>  /*
>   * page_objcgs - get the object cgroups vector associated with a page
>   * @page: a pointer to the page struct
> @@ -544,6 +544,11 @@ static inline struct obj_cgroup *page_objcg(struct page *page)
>  	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  #else
> +static inline bool PageMemcgKmem(struct page *page)
> +{
> +	return false;
> +}
> +
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
>  	return NULL;
> -- 
> 2.11.0
> 
