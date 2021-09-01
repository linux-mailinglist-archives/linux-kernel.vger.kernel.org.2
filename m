Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC903FE4D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbhIAVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:23:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:41761 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231886AbhIAVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:23:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279883131"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="279883131"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="461094738"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2021 14:22:48 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:22:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 14:22:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDLnFzr0qytGE0WW0y0kHYFwRcN4J2EpUBu0Mj5wxovM8soltH6UKtd5+azbjSoFznwEcQxEQNBEqY25ZQNM1Ca65OFg9WIbzaGok0NEjckMOYFDpDjGILeqVWnT3NqN6cq7VXaHqW+cad/b+UHyD6cnzHX924V80Bn3eMEjANyXuxJ5atrxBKA0hSyMoUdSgdpRox+YZ9LrXuYOsEZyz2vYsdhyqQ4KtrLDrBFcd15ADI/kQUV3sLrJlykFRBh4LWhrS6gCoAQtdRMljoPVgbqUcGxt2GU+oQEwylJJrfaFrcz4sxEykRyN1MpJPZ0GkmP3SlhJrXfiTEUc1BgaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpunRPiawz6fPxK7Q/XactewxnXnyVLg7+8Pw1EM6Ig=;
 b=TxTUl8WSu6gi47yuRWEnB05EdrCkYaE8NnUA1XK4toTcQM1DZuVAEAgHah8K6s63GaKjlZ96QB38EeSzVPn5AYtc4X9EEi+ekWTB/qRRfs95jM2Iw4prffgyxZWfzDVF+Xl62C4hKXL5DWTmB3nYp9V2M/4Fq5m7qSwBQcDcWf54xUFihEqmaDjekXHTDwkRv9nO/ysae+KKCneElEgP8Swex/UhF7Hpw8OLGEgc/NefmIYdmLvh8R/bTO2fLrxtxcBAhIgdJUeUwZ5/fCOm8aP6id6S/O5BmikDo02GStBAanpc1Ez4IAzYCITaPtWQk8OYNUt90eV8R1wEja3oDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpunRPiawz6fPxK7Q/XactewxnXnyVLg7+8Pw1EM6Ig=;
 b=PQznskxsTiNRTdNQXIMPPTrA/Eu/j4oaeDSsqknhWB66UepTDtuze+BKaIMqbwuFJTvGxhpGvVyIpyoRcx7R7dN4tpkvBcCRtyHG+u6EcSdKWo47jOl3UA84nf50gVnEfBZIKb1QA6LrdqUpbUZoFP4+i7MyfuDB5HpXOsLTN6g=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 1 Sep
 2021 21:22:41 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:22:41 +0000
Subject: Re: [PATCH v1 05/20] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
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
 <20210729223610.29373-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <638a0c73-ed1b-c4d6-f5f2-2af3c2e39a35@intel.com>
Date:   Wed, 1 Sep 2021 14:22:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW4PR04CA0292.namprd04.prod.outlook.com (2603:10b6:303:89::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend Transport; Wed, 1 Sep 2021 21:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6f0343a-d8ba-4848-716f-08d96d8ea154
X-MS-TrafficTypeDiagnostic: BN9PR11MB5243:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB524328FC9D8AE05D9382FBB6F8CD9@BN9PR11MB5243.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdJERFw4HKQTaNfDVqHW40IlCQyJjoKV0dd8er8Fd7mZgtbJIFp+tI2fKT6HUu3THGJGfVM+iTFkzwH96vB2QAWPKMpcfKmxKE6qzjTRZICJSbFftsux/sUxx7wXIcdhPKWL3fy/pnP95rmOIcDaTUOs+dUkWL7bxdrLDLSkP0TtyypII4USKvyL2KR+3JJkP3NbrvroEWEDDlsgKta3F8ii+RkaoKY4Uu5YkTTBGcyO/UJBKd2Ly85UWvmY41od6hpXrSnCfYziBOcJg61mzhN5yI0k6vSdaPfrVsJoA5571P29ODol1kMEApuSrcH2uj8HVUK1J0aQP76JSglWsrM7aD4MSfqQdPPQcjhhWivs8P15gdnwTdjr+7Xv8HhxY9zA1McXQe3PRDR1DTZ5Yftpr7Rs6BkwveQPEbkZqpA4LGZjLbfuMfFcnQyT7lsIo+MEXMDAVqwV3Sz86C+nQkfE0s0XxP+ID1jIdk7Mpg8Q23+8c5ISxsV70kEN3aIB2wzn43O8rcteEhdlOp5Oa9uwWgsfPwedx/ZiZ6uv8qvTnCyCrTCZ7Uu3zxQELKDe/lBnBtW8lLCwjvA04NzUOu97iXkCQj+RW0PpcuW01vbqiWrmz5Wm2vEPO+d49dx4hrgdYDZQfAA+RI1ya3X8Zmo4z2BQCuJNCasHx0gsYqMn5ytuhBkxEOn/V6rxSr9ne/GmLEC5BiEAn8kX50efkhnozvyTgFWFzcOfz9n39ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(16576012)(66946007)(53546011)(5660300002)(8936002)(31696002)(2906002)(44832011)(54906003)(6486002)(4326008)(66556008)(956004)(26005)(8676002)(36756003)(316002)(86362001)(6666004)(2616005)(31686004)(186003)(7416002)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFaVlpwcXNQa25mTEFQTCtPZFNXQ3dqRzBuZ3pOTTRXT3BVcVcybUJyaFY5?=
 =?utf-8?B?QmMvU1JMbzY1RnRlU3J0MExvWk1PNDcxKzVuRFRmOGJQOFVaOWEvbXZHZzhw?=
 =?utf-8?B?a1VTejZwUGxFUm84dFBXaFBnOVpIajM0cmphc0phY3RSKzd4K0RzTEttNUt5?=
 =?utf-8?B?VmluUjdUdG01UVo0MkJxbzNwR0duQ2dIY2hFOHNBMHZIQUhzZEtBcWFOUGlR?=
 =?utf-8?B?UW5PaGJLeTlsWFpxTm5iMThPNjlDMjJkRG5NdFRHUlJhd1hpZ2R3aXUvSGZY?=
 =?utf-8?B?OFRkYkhLNVRKRFV0ekNBL20rWGV3dXRvN0xCK3Q0MzF0UTMzbHNNaURwVjRv?=
 =?utf-8?B?NXRzQ2xNcVMxOHIwNWtpODE1MTU1SHdWckFPdmRZN0RhelZRM240ZjErem1M?=
 =?utf-8?B?cDBsL3JEQ2Fram5VR2lmTEhMaitQeGhRL3hFK1FEWUx4WklJZnJaaUxjNTVJ?=
 =?utf-8?B?c0I1TnRzRVUxVzhDaEVJNGFRODF4YTQ3YmVJWGxLRXBleG5WVjBxSmo0ZlJ1?=
 =?utf-8?B?TjFrYVA1MWxSRExtZ2h6MXY2TVVwcS9UeHc5WXBJSENtcVVmMzNFdWdiRkY4?=
 =?utf-8?B?T1ZjcWdyaHpmVWphUHNPcGlERVh0MURVeE5WcmhscWRQUUVseWV1bG1OTjNZ?=
 =?utf-8?B?TzFxazVrMVZLeE8zSjBNcWRXNDByNXdobFVZOHNKREtoS2JxZWtDOXpJaHl6?=
 =?utf-8?B?TTR4TjVlUmhqKzI0WEQ4QS8zQ1BWUmhTenAwTG12S1d3dEs1WHNGbzFKMmM1?=
 =?utf-8?B?aVViZEVlVk40Ymg3MkR0clVOVHgwekVlcFdZOUd6alpYTHpiYnJOTytzN20x?=
 =?utf-8?B?M1pEeTNnSVJNT3N0ZTl5ZjROT3N5RFFDZzZRU3ZsL0ZHNHErOWhJY2FteTVu?=
 =?utf-8?B?QitoUW0rdHJ5ZU9JZi9UMWxMdWk4aE5kaUdZZlJjeW90cmpsQ1lNTkVKek1r?=
 =?utf-8?B?K1k4Q251NXV0Y2FwSmQ5N1FqUjlPYTV3YXJGWTNBamd3c0RjY1ZPaFdHK0tM?=
 =?utf-8?B?ckJnc2JXS251aUtvWXVzeDRxek5mL0ZaTlRxaEdOZ056cm1YUnFDeUt2bVR0?=
 =?utf-8?B?ZHk4Qmt1eXJuS2J6anZ5RnFReC9pTDNydnRnUWh0MVBlcjU1LzV4bjZ3d0tS?=
 =?utf-8?B?dmdhKzA0Z1F0cGFsK1Q1ejcvaVVaWGpYMng0YzJwSys4cEQzVEx2eHRJZ1cr?=
 =?utf-8?B?NmUzejJGMFFXWXJkZUJkUEo4YmVPOHBMbk8xd0FvWE5rNnI5ZVFIVDZkNHNC?=
 =?utf-8?B?eVdHdHA2NE1vazNHeWZnV0NOYkhiSzkzdDBNL3ljZ1pFR0VJSHZNaVhzKzh0?=
 =?utf-8?B?WUgwTnlBU0Y4dW1QZnVmMFdZcXlPcDYrKzZ0MHNETHo4L2pobkY0TkhaMTlr?=
 =?utf-8?B?amc0OUVvWHc3NzhJTEJvVXpVMklWRk9vS3F0RUZmMUlvNklpc3ByQ1NZNG9B?=
 =?utf-8?B?dzFaVHlES0xNSTM0MkxWR0dCZHBSKzVIbUp4VGtvWTFGWFBiK2FlWldPZ3Zj?=
 =?utf-8?B?ay9uNFI0ZDREWWFRNEsyaDNaYVZoaGxDR25ZdEsxQ0JrVDhpekJGOU41Q1Y3?=
 =?utf-8?B?UkpWdXdDdEdxdHgrVVJzWWxqQktkSzRoUnJjTEN5d3JCMTQyTnFjMFNESFow?=
 =?utf-8?B?L3JwOEZLWWtXSXh1TllBTHVURzRPL0t0d0VnUFVOS2JXV1RuYkhKQ1VjRyty?=
 =?utf-8?B?T0dpclptSUt6ZFNpNlcyZ1hOT1VCcDJoVVBPc3FxV1ZDRU15cmVGaUZ2dlBC?=
 =?utf-8?Q?ZsR027LVOxZL7F4AmIugeHwnXCyvgDzmr4VSUXt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f0343a-d8ba-4848-716f-08d96d8ea154
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:22:41.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6dO+PuLRFGfVNkZ4bRpbwMFEdTywPGlo0JhZmFmrrGO6p815CWPYaEgSPbXNvp3JSuF8EhCPrSV9mfBzMf/MHiYwlYJRdoIcLSOH5dSls8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> To support resctrl's MBA software controller, the architecture must provide
> a second configuration array to hold the mbps_val from user-space.
> 
> This complicates the interface between the architecture code.

This sentence seems incomplete. I was expecting something like " 
complicates the interface between the architecture code and ..."

> 
> Make the filesystem parts of resctrl create an array for the mba_sc
> values when the struct resctrl_schema is created. The software controller
> can be changed to use this, allowing the architecture code to only
> consider the values configured in hardware.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 -
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
>   include/linux/resctrl.h                | 13 +++++
>   3 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e12b55f815bf..a7e2cbce29d5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -36,7 +36,6 @@
>   #define MBM_OVERFLOW_INTERVAL		1000
>   #define MAX_MBA_BW			100u
>   #define MBA_IS_LINEAR			0x4
> -#define MBA_MAX_MBPS			U32_MAX
>   #define MAX_MBA_BW_AMD			0x800
>   #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cf0db0b7a5d0..185f9bb992d1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2030,6 +2030,60 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>   			     struct rdtgroup *prgrp,
>   			     struct kernfs_node **mon_data_kn);
>   
> +static int mba_sc_domain_allocate(struct rdt_resource *res,
> +				  struct rdt_domain *d)
> +{
> +	u32 num_closid = closid_free_map_len;
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	d->mba_sc = kcalloc_node(num_closid, sizeof(*d->mba_sc),
> +				 GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mba_sc)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_closid; i++)
> +		d->mba_sc[i].mbps_val = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +

I had the same initial reaction as Jamie and noted your answer to him. 
Considering the intricate flow here could you please add some comments 
to these functions that explains the calling flows in support of their 
safety?

...

>   /**
>    * struct rdt_domain - group of CPUs sharing a resctrl resource
>    * @list:		all instances of this resource
> @@ -53,6 +64,7 @@ struct resctrl_staged_config {
>    * @cqm_work_cpu:	worker CPU for CQM h/w counters
>    * @plr:		pseudo-locked region (if any) associated with domain
>    * @staged_config:	parsed configuration to be applied
> + * @mba_sc:	the mba software controller properties, indexed by closid
>    */
>   struct rdt_domain {
>   	struct list_head		list;
> @@ -67,6 +79,7 @@ struct rdt_domain {
>   	int				cqm_work_cpu;
>   	struct pseudo_lock_region	*plr;
>   	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> +	struct resctrl_mba_sc		*mba_sc;
>   };

Why is this additional abstraction needed? As I understand the usage 
struct resctrl_mba_sc would always only have the one member so why not 
have mbps_val within rdt_domain?

Reinette
