Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65535A752
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhDITpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:45:52 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:45313
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233883AbhDITpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3rQjvwPxScjPO7pL5iVB0J1YGqXfNqZKcEcDkszElRNjWlN3sftzCLU50e15AZvJUtviy2waj6xVr1YxoAtxP7GwSqiM2nVtaCwHwgh8Y0J8hJQxcYFTKF50qUiI8yPj29MGFfTqQm9BOHBXHRPkMJLDppEuFw4ZwYDnm71RocjEy8xK9t5XSCUCrORrIDAwj5x8BTuD/DMMj9oMMFXevBRXjOm/6TkGuSuM2O0nQarJUs8EnLlXOJL4i9lUhoaKdL/5ICZauebVVMSFULn3T2zCNkX+1qSAnAggE3xkSbTidKTmxgWBbTKaht1DNI7Pgs+jE6vt5Tc0xb+xh+RFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46jakSF7IDnZoeI4ZYCHWmDh7b9U16nkucjgxjhN0nw=;
 b=kM47TW4xETCgtYZxQ8C+KdUiKe5/v2xpjkTUI7Ow1+GAMpYcqjvee3VjanIQEjtHHEow6GB8LawWJke68nmSs90ebAtVtPEkAzl5N6ed8V2fP0BuZgnMoPPS83rnnpeWcONMMsDuV8KiUvX5wIKsRh0Ih00DJThKHjcl2Zh0Jx1a5l+FQMJtzD2ZKC7Xc8nXkFZt4cBHgpAQuD6zF7Cy6cMak0HPSiANbDGfzBgy6FD1TNT5YSIPS4cM6fkuwzH9tjr22BqzBmFq/khZDp4LLZLUHc8ANSn5d6sHbu6vNPo9X9tL8cUGSrxHVNxRTccl2FKIegygEesxivP/bI6ouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46jakSF7IDnZoeI4ZYCHWmDh7b9U16nkucjgxjhN0nw=;
 b=fJgSsXO7Pi6M/wyjyKG5z7/NeZTfBFDtIJCgcm9PgyohpxXpWQ9EdvLUZmyukCbjMPhquhU/noK7voP9BDj5W+Yi3s0WdNeykuKXjZIorbAJNACHqs8CDvDIezd3y2el0HSgN58/9EwpCr3JGJoRUvvjMyxk/JwFEqTDaEczXd4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB3434.namprd12.prod.outlook.com (2603:10b6:5:3b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Fri, 9 Apr 2021 19:45:27 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 19:45:27 +0000
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com> <20210409174134.GH15567@zn.tnic>
 <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
 <20210409193929.GI15567@zn.tnic>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <9dea10b1-bbac-3ed2-6255-8453570d857e@amd.com>
Date:   Fri, 9 Apr 2021 14:45:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210409193929.GI15567@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.231] (165.204.78.25) by SN4PR0501CA0103.namprd05.prod.outlook.com (2603:10b6:803:42::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 19:45:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 890c0d2c-d557-4771-0de3-08d8fb9005d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3434D5E0E9A8B6D1F4EF4B4C9B739@DM6PR12MB3434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7CQQcxbsB/Whndz++nXdxLm/aaDEU0ylVM2jEvemD7Q9wUo/zvIrmjrCt7wNNKII6YK11yIR1Xeaq5wgMjnBmIlMsLfKdRy59Vk7bg0QlVgnQVwT0ly+qIscggQTCrV9Ev/u5NG/zqIWCMapFoYDRqda2wmd8JHmQ3ICyzg9p3RwNQI9cg3qscksFjDqr1tIOeoqVc7RK0vsoz62FBjzpKd+LFmD+JLJcx+ZPKMcW6wjfagd/LL9hIicaZmumqjOsa0Jbd10yMxrl6dqtZS5gPs/OHhHw0Att7HoC+sutps/+U8dXHzyMNpuZoSaUfbtLHOdV9aMnmuiTMrSFm/+sYXiBp25x0GTL1QOg4TNb8Xc6J4mDy401kn8yYlBkiuD27tiw/TkGx7LRYyAR/8Z5fdXaXB5IahsrEbgtlz49S67gdok+77uI6AV0B0Ty9Vd4buJq1J7RJGx9VxsURZynvdVtM0xoemxU/LzJr9v1UUgNSgPbBH98ECqG3cfBcB/OMNJzB9NrYWO2wjR4WC8V0B9FFGqg2SWmMUdLfY07NLPi/1oJVOczuSAFZXKH1C3BgmHe6NJu7/yARALUV7H94h7CItJWcBGvpgK/9SwVpwybWoBDOH7vXRaom04dBsJom+sz0eLu+1bW526gYnTDtXC9Q6p2Yo4MJBdN71wW6oxryAa4u86tHw3Ic1XydaVuj4U017ViY2U8iMEUn6n2SWvWkV6LLL9wASsRQz+Mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(6486002)(4326008)(6916009)(54906003)(38100700001)(16576012)(316002)(8676002)(2616005)(8936002)(956004)(5660300002)(2906002)(36756003)(26005)(53546011)(16526019)(186003)(478600001)(31686004)(31696002)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTNHV0ZMenk0U1VKM3VxTGRYOEx6YVdRbmR0TTNETkdmR1pBTXhZWGNyclVF?=
 =?utf-8?B?d0w4eExIZEhBbTRlUDBVV2pvcEhlMDhZcm1zZFUrYkVERXVwNks1UWVvWE4v?=
 =?utf-8?B?Z3JVYlZlclJjRnR0V1RSbE13ZWRRa0hXVTNoRk1UcTQ5ZzkzUS9kb3pmVytk?=
 =?utf-8?B?MDVUSjFTWFVwV1JLZm9DRlNlb3QrMVBNSnV5NmVYSHIvSkJ2ejNabVdIS0Vr?=
 =?utf-8?B?YTVUS3FBa21DbUQxR3Q4ak1SUU9USUIzYm9Lc1J4b1JGTWZpWE4yMmhPZTJ5?=
 =?utf-8?B?WStxMDA3NEEzSUJvVTFjQm1PVXRlWHNCeWp1QVhyWkRMMkhTaVNOaEZVbnph?=
 =?utf-8?B?RGROVkJjSnZrWkMzYXVOVU9qNitQTlg5eFlCRmFFaThobGhxSjA1UGtiVkM2?=
 =?utf-8?B?VVFRZnJLZWhOMlVTYks5YVlpMTZrRkdXaE5qQnQzQVB6eVpPNDZQUElmcExM?=
 =?utf-8?B?N1ViVXllZFJtZU83bGN1YWE3amVyeHhvaTZXY2Z1N0pyeUR6ek95RmJNdGtp?=
 =?utf-8?B?cEI1ck1vZ3lTWEdOSTR5R0d6ZHhqWDR4dHcwV0lTL0NGU25wWDJzMmlOZ0Rj?=
 =?utf-8?B?aXVqZVMzUGVKenVoTDlXbHB2NUF1d0RyaEl4bmluYnk5RWhvRkYwaTllbHhD?=
 =?utf-8?B?Q1pxd1pzMkF5N3QzNklzZGU2UmtvMDVPeHc5bzJTdmthY2JNSERTdnNLNG5v?=
 =?utf-8?B?VXY0cmJEdCtYcVBVa0pNVmVTNUFrSzd6VzEyVzFtbFpSY3B5TVN0YVRHS0Vw?=
 =?utf-8?B?UVFOc29WckdOUFd4OHFVWkRER1FMYUxDNkQ3OUxiV1pFQ3hONjNGMWR0b3lm?=
 =?utf-8?B?U214bm1RTzRYT2ZXdnN5TXpZNnVBSEQxMnZDa3hjNlFQSFJad3d0cmZDU292?=
 =?utf-8?B?d1ZkSTVFRzlZMHFpbmloTmJDd2xRL0FuZTRzZndFQy91b2RBSGJzaXh4Y1dQ?=
 =?utf-8?B?cUhPOVhvaTN0aHhxMEc0TzRUUDNwNFQ3VXlSbnlvRWkwYVV6aG9rUnY2aEZ5?=
 =?utf-8?B?NkV1d29nSC9JcFV0dnVKUFgxV1RvaUtaN1JNWjhnK2NKbnRkMG1yTDNDbXdu?=
 =?utf-8?B?eDNMZDE5ZEFxY01TNkJRWm1YS1l4clpXeFlDQWVDYnFrRDhrOUJZcVlWaDdR?=
 =?utf-8?B?SGJ2N2d1ZWFWckxUMko2ZU1vR2R0QU9DYVdsQTMrT1k4VXZPK2x0UDdnNWRN?=
 =?utf-8?B?aHkvcDVRRzIyZjJ5S0tWUUVtNm8rKzB5S2VoQzcra1FJVExCTmlKSGR2bVhh?=
 =?utf-8?B?cEhYR1JmaVF3SitMRDhaZi9hWlZSZlZLOC9SVzB5RUxGd01GL2pIcW1iUXND?=
 =?utf-8?B?QUtvZGQyMWFYWE9yREt0OTRUb2tWSEU4RlpvSUdvUEY2Vk5rYnNSVHJGRHFQ?=
 =?utf-8?B?Q0RZMkRqVFdzNlBLc0diejlCQjF2VEMwNzl3LzBFbXh1NlhLaGw1cHVVVzFq?=
 =?utf-8?B?c2FaUjZxWnR3cGdDUCtCZ3N6aUlTZGtpLzgvZE40NlJsd0F2RENpNkx1MmNS?=
 =?utf-8?B?L2RPaWpMOXAzVWoyVXlTdmNheWgwdWdTNVd2ZktLRTVUMlVJeFJZWUV4SDZ0?=
 =?utf-8?B?ZjMxNGZkNVFVYzlUY21rdE9vWGtJa3lLcU5VTzNCSE1kRktMZHJmSmZYUHhu?=
 =?utf-8?B?eWJuRng1UnMwbFMxbnM1bTdrZlRPS2FhSXdBeVBOa09PS1Z3OEdlSE51eXg1?=
 =?utf-8?B?UXQxZkVwa0pTdVNkMlNRaEF6VDhEN1YyUlhwYmdnVDkvSE05NnhxQ1BoOE9V?=
 =?utf-8?Q?WjrhsJ3SH/gTX/irpiZBT+3cJlf0zWGY5loNw25?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890c0d2c-d557-4771-0de3-08d8fb9005d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 19:45:26.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZ652NXqBbZJwp8a8/GSp2PvK0JcVLMh0HuxtlIcIokw/1EclzlyE2tg4U9CwxilfxjFlneOLlUdzYhhmVFvtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris, thank you.

On 4/9/2021 2:39 PM, Borislav Petkov wrote:
> On Fri, Apr 09, 2021 at 01:22:49PM -0500, Saripalli, RK wrote:
>>> And I think you don't need this one either if we do a "light" controls
>>> thing but lemme look at the rest first.
> 
> Ok, and what I mean with "lite" version is something like this below
> which needs finishing and testing.
> 
> Initially, it could support the cmdline params:
> 
> predict_store_fwd={on,off,auto}
> 
> to give people the opportunity to experiment with the feature.
> 
> If it turns out that prctl and seccomp per-task toggling is needed then
> sure, we can extend but I don't see the reason for a whole separate set
> of options yet. Especially is ssbd already controls this.
> 
> AFAICT, of course and if I'm not missing some other aspect here.
> 
> Thx.

Yes, these options should be fine for now.
Like you said, if we get the need to add prctl and seccomp, I can always do that later.

What do you think auto should default to?. 
In SSBD case, I believe auto defaults to prctl or seccomp.
Since we will not have that here, we should choose something for auto.


> 
> ---
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2d11384dc9ab..226b73700f88 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1165,3 +1165,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>  		break;
>  	}
>  }
> +
> +static int __init psf_cmdline(char *str)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		return 0;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "off")) {
> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> +		setup_clear_cpu_cap(X86_FEATURE_PSFD);
> +	}
> +
> +	return 0;
> +}
> +early_param("predict_store_fwd", psf_cmdline);
> +
> +
> 

All the other mitigation x86 mitigation code goes into kernel/cpu/bugs.c.
I think psf_cmdline() or equivalent also belongs there and not in kernel/cpu/amd.c.

Looking forward to your feedback.

Thanks,
RK
