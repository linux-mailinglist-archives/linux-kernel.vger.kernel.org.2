Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C113FE4F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbhIAVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:30:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:17032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343833AbhIAVaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:30:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="199104504"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="199104504"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="499117774"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2021 14:29:01 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:29:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:29:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8wrnwj/TGzKnB3+EpkaTHBMEzUjjugfgLisMwKTJLzd+GqvUFkvLto5/g+4YAPWn5vuvrp5XwT5CtShgsVxMpHssM9Ag8/nBHrzkky7+8kam1+27CXgzf/sF400eD+QuHnefRwCtKbE85qwlTtTZ9GPZXmlCBSzzFpksPtPjor7tR57NFYi0hO5kHdsfBmoCafVNhSfjZmaZ1fJOPzX7VbuN/Rsi4W/NqCvwLomPoDHqCCFxR+x+rU1wv4TlAO18TR6YKgxGpMHkT0balP+enCnpzyYgGMEyQkHIZ9ic2tXU8Cw9DmzbDluE8Ci6UlYLwflqzyeEmEUPL3AEjc0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyyPl1dr/7BMRLEjxVvBwknWDkDNpGtzJxFqJaD3LYA=;
 b=HGHP+1eycr7CPP50QG2ATZCLdH2J8LyL25DdcnEFihEWqyOBl0NgGl8m93wXk2yNfSDUyPyHbQscYDUugD8nVqXVmtB9DPfPeqUwsn64PmC8u2Ctx42BuFQG+HO0Kxy7BsUli2SiwQJaYz/3xLWhy7qvduN+t8WCduv8naLXDKdYPPY+RQH4V9HvoaupK5corudUkPWheZ+04YQ8OmifbXGFnKCjI5dwa9zqdH+/cl7cGT6QOFV34kb7ki8fiZl53HarDkKssgyHJvy6pG+D+4iwMgdgo3W6gREF17sFFXeqalzPEgvqo2sqziUjaT2/TdpfHToHf/gGmZf8Ey/lfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyyPl1dr/7BMRLEjxVvBwknWDkDNpGtzJxFqJaD3LYA=;
 b=vRqK5DlheRuVA5kL/0TH15IUYLIaKkaFc8Nw4gmwELGpQkrA/t5bzw2g8CXlTuplaKp+E9YQ29G6ujec3CGhxuO4s37rgo/hQKyXiUrOJgItm+wwBxBJmbnnQQ7ryA1dwbsHJbNLI/LZi2ar9fXPWKS7bnEkQosQnudPcj701H0=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 21:28:53 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:28:53 +0000
Subject: Re: [PATCH v1 10/20] x86/resctrl: Allow update_mba_bw() to update
 controls directly
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f236f685-8b02-10ec-04fe-8a50be086927@intel.com>
Date:   Wed, 1 Sep 2021 14:28:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Wed, 1 Sep 2021 21:28:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b19110-e0cc-44cd-af12-08d96d8f7f7c
X-MS-TrafficTypeDiagnostic: BN9PR11MB5516:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB5516E72FA3533DD44A58B331F8CD9@BN9PR11MB5516.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WhzO1AHetU2YUqU1y0piqKu1PsR1n0kSWgqVEXcXQaYDnSIfrMm5YT4GsXR5XjFG4T+VglVhOULRIJw5cKBQPFZiy2FTcRaxKA/8ssy/tPD7wVZ9W6FgxZ9cbqPt81OLaPjyGN5VaHHts5SqYZdoyfaFRpnUblTy9vc0uXJcJegeJ0yjtfaQzxvivrS6415p38eWXKz53FHK6HywpKjIsLa6Wv4enB8rtyc1JUuL9QImJNT0yBEudmjopKuY5YbeOTEy5hUJVv4qn5tyjcz+/MWo67nDUT5lWV9UzJEZ10q4zdO1oU0ScV+8xncx9ekIl6YiCIqHQU0LCVXwyMZP2+zDDRhsZTmDp5jB9l+OV8hqwqhzLaLE8tbc+kbZacnmng8qvdH3sNUerU81JpHv7A5ADkSYA64i0QyCkxSnRCx0cBAEtD1KoFdrQzDJuZFDf6QH7W9wjOVrPAda6/FSjDJiPBDP9T1WCyQRVL6VHb6trYSAOQx93i8+cG0DrAyKuSpAVIa5V9lHa+cNFFScLUAxYraHWUnP5fpsQVmWp6j6qrgbxFRoKdw3wLruwcQavhcaN5qb+P+sx6Yr7MmYAGxwInfyIrAs22Bq7EohghlHlHjV5Tucr8UeSBvfjQtQiwmsleK/ivUYeotCz+gvBJprmMFmWoqjapBAc10zLTbBbCui1/b9pYmjhEuc1bpR0dCIAFEaCQr9Xds+ZPtq01Hs+x/1W6yzZOvT8oVrZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(66476007)(83380400001)(86362001)(5660300002)(66556008)(6666004)(6486002)(4326008)(54906003)(66946007)(2906002)(36756003)(2616005)(16576012)(31686004)(8676002)(26005)(186003)(15650500001)(956004)(38100700002)(44832011)(478600001)(8936002)(53546011)(316002)(7416002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkpRSkZJVUlFVDJ2dnhqOGcycHZLMTdXTlBQbmFiS0lUcFU4dDNNNzNEVGg1?=
 =?utf-8?B?Wm56S2Jsc0g3NHN6aERHMWUyZU5DYkxDWk8wZEFsSitHbUV2a1luVW1tYlBN?=
 =?utf-8?B?ZE1JMCtEZllxdzM4VWF3UjJmc3FVQ2hRSXIvS0w2dnBJZVo5OUk0OTRSZytk?=
 =?utf-8?B?VHMxYk51c2t4d3JCd0dxYzBCSHcwMXVkclBuUkgxMFBWOGFCWU5TdDNGbzN4?=
 =?utf-8?B?ZFY0aDU4eTdVVnk1VVg4RWRlR0lNNGoyZ0tiT3p3MFlKTnZtSXVJUThxenlR?=
 =?utf-8?B?ZUZVOC9ZYUI5Ky9NTlA2NkowRVdIQWVGcDZWb1pWbXlzTjg1ZlJpSEMxOHow?=
 =?utf-8?B?K0t4Rlh1bnJyK1VuY29LbjM1bW02Sm81NWxYU3QzZ3RxVGpjNmlmR201VFNW?=
 =?utf-8?B?cnd6K1VuK3VsSEh1NGRjdmgwckg2WTl5MzBJeUVnY3krcmRROXFkQjhrbUQ5?=
 =?utf-8?B?NWdkUVFQMy9qTlZMRWkwaE1DeFRxWXpkeEZVT0pqRGVCREhYcVNDSEZ4dDE4?=
 =?utf-8?B?SHFwbkxFVWZkODZtTzRYZ0RXY2twN09QVHV5WGlMeCttcC9QWTE1eFZOelBG?=
 =?utf-8?B?Sm9QeWNXbUpOa2NsYmhzUVpuZ29UYmttNUh6Wmd1dXJyWW4rUElEcDRSWnE5?=
 =?utf-8?B?ZGlzWDNlSlJ2OVhsb0h5Mm5Xa3dhQjNIa1F2OVV1YzBLdHVBbWdEOURqanJq?=
 =?utf-8?B?QUF2KzBlWnB5cWJFN0hRZEdRMTRNVDRQZlFqTUF1WkVOcitleTlObjNTdzhn?=
 =?utf-8?B?TlA3K3FCMlErTkpsbXpQak9vWnlBRXN6S0habWh1bWdOSTlpUGhkdUthVkNQ?=
 =?utf-8?B?OXUxRm10YnRtRitXeHJibGtkZTV3UG8wcTZEVEYxbGJYekpyZGlFSzV6QUll?=
 =?utf-8?B?NU0wTWRZeUI2UE1mN3c0d1BEb0xtV2pZVllJUUpyYVJHZWVLVGREYW1oc1Q0?=
 =?utf-8?B?dFJTQWwremcxUEtLbVhzQThmSkxmZE9WY3l6VmxwTFNMNDVJQ2NiM3BYVFlz?=
 =?utf-8?B?b0hlVEpwSHR3L084dElMOC9CMmRNMFlteDFlc0RGUEJJSWtHNXRlZjZFVGRa?=
 =?utf-8?B?bHlseE5DUXN4Yy9iN2g1S0k3M1RYc0NZRC9pMlZpc3NzMFNtc2h2RG9Wdzhh?=
 =?utf-8?B?NEhvNmVyaE5MdTRBa3dla3c4K1cvcjd5YVVIK0JGQllGdjRJUVU1c0t1NnhC?=
 =?utf-8?B?ZzJTWDRJU3o4STJERElXYkhBWVJmbHFSVCtqVSt6b09KcDAwK3lQOXRmbVlK?=
 =?utf-8?B?bVA3aDRIdW81SGd6WUtOTjdyZGJRblVDeGtBYkRscE1VV0R0OGJZMm9zYTI1?=
 =?utf-8?B?N3NLSTg5TzMvSGpaUGxvSjhhQ3l1bzhiaE1qN3pXeUlZbkhyYUdFcFFmZEtV?=
 =?utf-8?B?c05sY3BBMjVEdlh2WmdDOHBMaFl3RHd2blYxSWJxdk81cG9UQkxoaGhOMEM4?=
 =?utf-8?B?andvRXBQVHZGNzg1UGlLNlFlYkxDYWZzUEFqQ0NaZFZYaUVMOE5BN1ZNK2x2?=
 =?utf-8?B?MnZPbHJhdC9vbXlVMzNJdzFQa0U5aEFyQ0FhVTUveU04LzBVUUQ4VWYxMmpU?=
 =?utf-8?B?UkRYY21KRU5HZzJDS3QyVlQ3QlBCUFlWOENDZVJ4c1dTSm03OTFnanBMYllS?=
 =?utf-8?B?ancvWW40Qi9QNTZIR1IvYXBGcVNkRnFNalRURnpjbUp0WlNUU20vNlpGMGYx?=
 =?utf-8?B?WWh0UnhYSFAvRTAwVjMvVi9VTTZUOGdpVnI3RmExZXpjT2dpZ0wvUmpVNjVI?=
 =?utf-8?Q?f+XZTkv/wNBcy8hdcmf2swW5ok7ZtgylWe1d4WT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b19110-e0cc-44cd-af12-08d96d8f7f7c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:28:53.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piaTrTx9sy/ziz20HmWld0Kf5v9z7wruyOj9NGxYOJFBB9eRUBX3aEIWZI6dOn0mumdKP6kwPzfOSri7I+yVKqtdITYOyZQojfCThFHBQdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:36 PM, James Morse wrote:
> update_mba_bw() calculates a new control value for the MBA resource
> based on the user provided mbps_val and the current measured
> bandwidth. Some control values need remapping by delay_bw_map().
> 
> It does this by calling wrmsrl() directly. This needs splitting
> up to be done by an architecture specific helper, so that the
> remainder can eventually be moved to /fs/.
> 
> Add resctrl_arch_update_one() to apply one configuration value
> to the provided resource and domain. This avoids the staging
> and cross-calling that is only needed with changes made by
> user-space. delay_bw_map() moves to be part of the arch code,
> to maintain the 'percentage control' view of mba resources

mba -> MBA

> in resctrl.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 21 +++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/internal.h    |  1 -
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 13 ++++---------
>   include/linux/resctrl.h                   |  8 ++++++++
>   5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e864dbc6fe3d..8a3c13c6c19f 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -296,7 +296,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>    * that can be written to QOS_MSRs.
>    * There are currently no SKUs which support non linear delay values.
>    */
> -u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
> +static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
>   {
>   	if (r->membw.delay_linear)
>   		return MAX_MBA_BW - bw;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 56789ea11185..5104f39928fd 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -282,6 +282,27 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
>   	return false;
>   }
>   
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	u32 idx = get_config_index(closid, t);
> +	struct msr_param msr_param;
> +
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +		return -EINVAL;
> +
> +	hw_dom->ctrl_val[idx] = cfg_val;
> +
> +	msr_param.res = r;
> +	msr_param.low = idx;
> +	msr_param.high = idx + 1;
> +
> +	rdt_ctrl_update(&msr_param);
> +
> +	return 0;
> +}
> +
>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   {
>   	struct resctrl_staged_config *cfg;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 796e13a0e8dc..1b07e49564cf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -528,7 +528,6 @@ void mbm_handle_overflow(struct work_struct *work);
>   void __init intel_rdt_mbm_apply_quirk(void);
>   bool is_mba_sc(struct rdt_resource *r);
>   void setup_default_ctrlval(struct rdt_resource *r, u32 *dc);
> -u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
>   void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
>   void cqm_handle_limbo(struct work_struct *work);
>   bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index dcf3a73e2c17..b178329d3661 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -415,10 +415,8 @@ void mon_event_count(void *info)
>    */
>   static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   {
> -	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
> +	u32 closid, rmid, cur_msr_val, new_msr_val;
>   	struct mbm_state *pmbm_data, *cmbm_data;
> -	struct rdt_hw_resource *hw_r_mba;
> -	struct rdt_hw_domain *hw_dom_mba;
>   	u32 cur_bw, delta_bw, user_bw;
>   	struct rdt_resource *r_mba;
>   	struct rdt_domain *dom_mba;
> @@ -428,8 +426,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	if (!is_mbm_local_enabled())
>   		return;
>   
> -	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
> -	r_mba = &hw_r_mba->r_resctrl;
> +	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
>   	closid = rgrp->closid;
>   	rmid = rgrp->mon.rmid;
>   	pmbm_data = &dom_mbm->mbm_local[rmid];
> @@ -439,7 +437,6 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   		pr_warn_once("Failure to get domain for MBA update\n");
>   		return;
>   	}
> -	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
>   
>   	cur_bw = pmbm_data->prev_bw;
>   	user_bw = dom_mba->mba_sc[closid].mbps_val;
> @@ -481,9 +478,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   		return;
>   	}
>   
> -	cur_msr = hw_r_mba->msr_base + closid;
> -	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
> -	hw_dom_mba->ctrl_val[closid] = new_msr_val;
> +	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
>   

This can now fail ... but looks to be ok considering the earlier test.

>   	/*
>   	 * Delta values are updated dynamically package wise for each
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 3c8522d63261..4fe2d5500315 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -205,6 +205,14 @@ struct resctrl_schema {
>   /* The number of closid supported by this resource regardless of CDP */
>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
> +
> +/*
> + * Update the ctrl_val and apply this config right now.
> + * Must be called on one of the domains cpus.

domains' CPUs

> + */
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
> +
>   void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>   			     u32 closid, enum resctrl_conf_type type,
>   			     u32 *value);
> 

Reinette
