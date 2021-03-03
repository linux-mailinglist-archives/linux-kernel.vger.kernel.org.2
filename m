Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0566832C137
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837029AbhCCSs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1835207AbhCCSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:02:36 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123Hwe50028424;
        Wed, 3 Mar 2021 10:01:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZiLe2FQD8KWfmHZgeOZnHprqHwqyjEilvIJF++JW96Q=;
 b=m28M/xgIKRQjA7/22BPY0P9jjRulIhBXRAvf8yLki0jDX5JX9Lp5mGR8xkmKWhB6Jr1D
 hGTBLeqI/Yv0fcPGYTvcxqyP2aUjdtzKXj4rTQTAhbi1kAYUz+yBis+l8HlgoDQSjOf/
 VG/JVWGqqKWpTZu28IEg7KwQvZVfkDOKoQc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3727gujm27-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 10:01:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 10:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPVow65mE7fupAewxhV8VDcJCQMhsUf1QbMfd/4zdu86vmna/a7OyZrdauiOobkbWG9RXh2Su9cDaD53yIpxjucqqEbsuh/7WksAc7beOVx9YkpyYLSLEMR0oA5Zzqr5Hh6tZsSRK5nDNnmrOWzBCXvfqyOY3gfeBHbyQEYguPkHT6wDewJ1Qy/5b9jJuUJ4N+8mwKTuP8GSt7pR2YGRQxZukZqwJozyiDwRuow0U94PAnyCaLrurpGfRxJjYtdqoT9iSUp8SCoz2sdN6R6ivHlmTIIuaK6irEwGI6AJCrTzb9mFsSTRmYJHW2l6mH5WKCmMznp+ECbh4ZlueVZl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiLe2FQD8KWfmHZgeOZnHprqHwqyjEilvIJF++JW96Q=;
 b=RfpSakIVDcp9h0urm5V3DOXoFc9z+AlxtTO5DULh0D7VwWLvNZWUsfKDUVaRBfKY/R3l89uGRzD755jyle7jSuOqCTO/UFl6gYbyU2FusKTi6GCETfg7L5Gx2tESmyORSwkyauUKcagrgCOp9VW8FfgMDH/S96XV9vftVvR/0qAOkSv9AzWtnaiDtWwGyDu4t+suLX/V8fjAtobOUpmNTrb3+Z17DBblnfHM7q1J02GBlaGZLhu4xVBQR5hVWxwQVNEIn9EQGBTbtzDlVBal1GKsXaJn+T3PE3DNaFbBqL8AJJOjb8wI9gNqZVe0nB2k8VeZzIJtRUv7NsgqMPzytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 18:01:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:01:42 +0000
Date:   Wed, 3 Mar 2021 10:01:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] mm: memcontrol: fix kernel stack account
Message-ID: <YD/PAVqLRWayfioT@carbon.dhcp.thefacebook.com>
References: <20210303151843.81156-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303151843.81156-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:eac2]
X-ClientProxiedBy: MWHPR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:300:93::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:eac2) by MWHPR17CA0053.namprd17.prod.outlook.com (2603:10b6:300:93::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 18:01:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc29de44-42db-4807-c7c1-08d8de6e6681
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159AED1A2F03803A0560A64BE989@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PdtfQNCdaPgSd2R9x1jDWHx0U8vOIWJaSg3l+Un+AedpMFX7d9eXE39kAEaf+riEO1CCP/yj3BauycwXPxbp/g9FYpwGWk6j76zxJ//FTS9qSMMQXH4QkYyHchISNzQY7Mb57y87q+LgxuXR400VxjDw/vyxoV8LOd2meVdEZUItiRAKiiJcVhZTxE5QxKiV17sTRh8Z48dmHA/H2gDmwN4gHIRdbaCfaSVgjMfC2ve/DOK9KCY5PKrFtE1RQWqLI9MUAQiCigu4w6rz8unaXDNs/GGrBsei5bjrMwzObeFZRFkl32CFRe+iozsmh3+JVbDKxdlLD0pLL+ypKgRZ0lqTrysSina2k9n7XQS43dEuWvnbD5dqtWlylW1TB0DHL67rGCpuNA/ft4Frpm3IvvLoPiLGXFmuuvewIPZ9DUNu32fSZsl52aCC/3Srmk9RPrk2DIMK5nVwdUqe5hk9R800aTdWWKQkrm37rTRRkNWlYrysz3lq25sTA0MbkGSyFgKwgwW2Z6zBUZWnszVLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(16526019)(186003)(5660300002)(8936002)(316002)(86362001)(66556008)(66476007)(66946007)(6506007)(6916009)(15650500001)(8676002)(4326008)(9686003)(55016002)(83380400001)(52116002)(478600001)(6666004)(2906002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AZHMgrFQxM2KreYs4kPNYWGeEyW7ydAt9LdwM+8dAHkRgdDv+9wTHC55NZsB?=
 =?us-ascii?Q?HRhC1WBx9FUbojj6zThh7lyucI59ZQUqmRhuW/aMVrZNMpHKa3u+FxjBkwLT?=
 =?us-ascii?Q?pTXCaCkragxBGqyxhii8rt2QvFzxqu5Yhs36dd9fulRS9jjl2/P9Hq2DV77F?=
 =?us-ascii?Q?qHhkVFiIEoqHXlu9YVlfTeRx2T/mLIvUGEBy++RpS2k7d//LBVYklOmLvSej?=
 =?us-ascii?Q?083uqnT0neAgzTH6iP+gPsZm2i/pwFP6Kk3H1jQh8T6vvdOq0u0S6SvoedX+?=
 =?us-ascii?Q?VqVO4LDWTcmWLC1CebLzPNILyko1btMvolC6objgngsM5/xazSCbGfumHeOf?=
 =?us-ascii?Q?jG2p3mYdxSkDE2dmOpWKQ+YqEAOQfzGGpVkRmTZE7wSAlr6Ynrc86olInZH3?=
 =?us-ascii?Q?y3zLpdZXrKPrZu4GC/A8qEYh5DzOM9Y9G8uYlQMyY8hL4ewwnNJz/KYgqbyC?=
 =?us-ascii?Q?txjnpOVUsOH9tteQwLSsicN/PZG1eo+Aqw31baaul8JdV8naWTR3FEWCuY0x?=
 =?us-ascii?Q?xNZ1tSF7rtM53e6kxEyZYlCcrfhMAUT2cPuNR86isTZFlq7qSMC+eFiiBPj7?=
 =?us-ascii?Q?dIcv1h5BEm1FQfniXl4DpyXkXrf032chq4FZAHiC5LT488yqkQPspM7PtF8v?=
 =?us-ascii?Q?4Xezz2p+ErBobRQwuWnc8JWAfL20LPiUcImZrErX0zNAjmQlCk+e1qCwt4+6?=
 =?us-ascii?Q?EeLaEoFQ/gFhb8Y7v0HV7EQMyN0nKhUWRy0u/UiBP6cogXN19aG5YAEOe7kf?=
 =?us-ascii?Q?PmOz6lYCnxlBiC5fyb0H0kqiRLkeCCnBUZ84eQe8InziemK2uxvSpQ5j0myb?=
 =?us-ascii?Q?8ltOa8Ii7n1YKmZdwTvCScK/sdGWjDmzmco8QhbQo0bvWNe6SfPgUWRQ8GDm?=
 =?us-ascii?Q?u3NFxjzBmlDF60bt53jpzO5XdnJfHfiZYxHFkSVubqR5umLMp5zXXkHmXVp0?=
 =?us-ascii?Q?jJMhWSK3EZsU5nEnW0EDaqUUgRzleZL3/36scyy1LFTJKSGMytaIMTwQubCx?=
 =?us-ascii?Q?1IWvWZjFTrM+D1GBdogH5P8rs/yg9lKYDh/66gDQBw9lpZG3ajXN/suFns6O?=
 =?us-ascii?Q?+lr1f/DAWCf3hqCVaOk1fISFtELDfABsgjntkUoY0Msq+atDuMvV/iqjTavL?=
 =?us-ascii?Q?8v54TH1oXdrUuXvd6lFDVz7hA0cexCXjseRdbeWWq1mNLQ6tQlCFmzuEYjo2?=
 =?us-ascii?Q?36xbuXD3Y4dGQCafjz85bMmoPtdthuKBlHbF4QYex6sAMMWZfLWCfqw9UWhL?=
 =?us-ascii?Q?79RyEu/aKHRKpLPDWfl/vraLJwuQm7iP2MxlY36ZsZkl8Nc0n4VjGDcY6qu7?=
 =?us-ascii?Q?4xRvzMQMxsbnkcwlQbRn7XDYnfKYBlqe6yp5e4W6ZqfZyg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc29de44-42db-4807-c7c1-08d8de6e6681
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 18:01:42.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35X2biIFx2Ix6t6hbPAz9D63Fs2orLVGzuvdiWqqAvTpyIxS9BmBP8YTKyGiIXlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_05:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:18:43PM +0800, Muchun Song wrote:
> For simplification 991e7673859e ("mm: memcontrol: account kernel stack
> per node") has changed the per zone vmalloc backed stack pages
> accounting to per node. By doing that we have lost a certain precision
> because those pages might live in different NUMA nodes. In the end
> NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
> some nodes while underestimated on others. But this is not a real world
> problem, just a problem found by reading the code. So there is no actual
> data to showing how much impact it has on users.
> 
> This doesn't impose any real problem to correctnes of the kernel
> behavior as the counter is not used for any internal processing but it
> can cause some confusion to the userspace.
> 
> Address the problem by accounting each vmalloc backing page to its own
> node.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
> Changelog in v3:
>  - Remove BUG_ON().
>  - Update commit log.
> 
> Changelog in v2:
>  - Rework commit log suggested by Michal.
> 
>  Thanks to Michal and Shakeel for review.
> 
>  kernel/fork.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211..242fdad6972b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -379,14 +379,17 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  	void *stack = task_stack_page(tsk);
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
>  
> +	if (vm) {
> +		int i;
>  
> -	/* All stack pages are in the same node. */
> -	if (vm)
> -		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> -				      account * (THREAD_SIZE / 1024));
> -	else
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
> +					      account * (PAGE_SIZE / 1024));
> +	} else {
> +		/* All stack pages are in the same node. */
>  		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>  				      account * (THREAD_SIZE / 1024));
> +	}
>  }
>  
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> -- 
> 2.11.0
> 
