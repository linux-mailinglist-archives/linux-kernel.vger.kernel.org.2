Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA16442FE2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhJOWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:31:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:9620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235751AbhJOWbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:31:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="228278712"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="228278712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="627957799"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2021 15:29:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:29:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWZ4XIh73xpEMCjzpBk/ljCBnoLRwCvADscW8VJXCmyby0nrrKcm3JWLhVxX9NEuV5nKjAnzbHXFzqB9YUkUf/d94q1qm18ER1oHJM4D2iKlR8lQGK4d+bmp56mBBAA7VIIZJ2Psvig2HkzFZj0BMK4psaelyMGJl6FPsCZcXjebiNctkZjsxGendnUwwg/RVEiq9O3bHuw10Gs5yaTzy6mTakX3+1Xmzxi9+3cnW3wicsA2khSFleAZ6p7ccTOGHB/xaNBjHZM4uzt0bGyjKkhXP7CEhMf2/vc0f2shIHW3ISBX/UWbH1EejkHGrIsS/mWKIxZVG1L2TWnNu8qd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHOa8Z7vcMYpvhHJlGCisIstuFhniv/LAwP3o1HIpR0=;
 b=Jh+bdQEgkOJQu/Q5kWVHjJZL96A4Z65In44iWkRBk+UYCHz2YVbmbNf5agizLKRInNzMMB4EgPr9TI273n4obBM4AxS2dkLgpaHYG7efO47BPVi2uqIa6FO7xbHaAPQWji94yhM5SUeZxyofkGYP+V1+Xlhvwl7Ch//s3Vc5ylilkywMWxxtH5fMmSpFIU/ui0DLqNZ/hLeCsEUklsK3mX8qGyzt4eqALD010xPNUR4+YDoZUwL7lBBXZrOBLsQWZEjShbuZemUSYygVae/9xD5snxiSNfuhHRcyrEj9yjACySttK/lOTlqCSgJMUhkJsn1R+iwqgxRRtS7msMwErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHOa8Z7vcMYpvhHJlGCisIstuFhniv/LAwP3o1HIpR0=;
 b=l0saQZMQK816Fy3WuMvjD8Y/YBgPJmXxs9CZlUBoBQT7ufrOfeuu1bXxqm2qD7H5zVaV7uPJDYtkOeTATdbUWCTJMi8YwmEe7LbXqed4zPhfWV2kdYdV/ZVrb56MHefODjYlHCcfHZA/6d9HEQ13lepoMY/fXiYT5wcsDEIzXzc=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1299.namprd11.prod.outlook.com (2603:10b6:404:49::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:29:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:29:25 +0000
Subject: Re: [PATCH v2 15/23] x86/recstrl: Add per-rmid arch private storage
 for overflow and chunks
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <65451ca3-3770-b679-6569-a2d3b90f4b44@intel.com>
Date:   Fri, 15 Oct 2021 15:29:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-16-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 22:29:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c47b2f-74ce-4008-07cf-08d9902b3e4a
X-MS-TrafficTypeDiagnostic: BN6PR11MB1299:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1299AE3224F3FF3A73512636F8B99@BN6PR11MB1299.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqD2ZsBt1ehmKgHkpFKLMEgBn6cRtPMBJDhzdRxUwP1c/MiKB1dROK1qcTolfrkShxYkx0XtC+47Ym0O5+tIbFksclruRN/NEdXgIB1dltbgtLfSA6cbbqOofLNyLH+EQJuidQebXaNieMWfaOqqMiFsY9zdQSY/33L876ZEDa5i6dH8EUatrRN82nkwhqWFdL7jDl8yFOLmWvuUmvfSvuLHIw1k7E/8T4y4r4g5tnmZlNiFlQl5+v2yDulbVbxSKzZnJmEQfuN8g7V3JxlzjQ6HDu0NW5hn2MIKMpandETe3ZV/THRz/ccLoAt0/IURFQdBuL6PrNeQSDURO9W1lvjc1fLEciaZxsMbcVe/q5rJCwwzuhoScVpKYFMEG3xD0EWNaKNyGDXgmibyp9gcBdEU5D7XzV4BP5tRM1xs/PEzjSHfXdjJOsm58Dg9crEVFz5DJLTLAR4jKGpp9uB/ou7ryTJCf5ND9dAlNqO8i5gI2yMgqDJwqsaZnlVxw1tIB2OJqXdrftRjs05ZYV0P5Il2X/+f76OByt3FkqftBGxouTagvGFLVDsxFJ2G/+1u8KE0anH09zxKtyBBEOH3280mIGD4jM/BRWp2bBB8qe+MGldcoFZDnZGY/netDYTRZCRZwa84hbZi5oww88w0Eu4P6ehTNUX/AEAK1BoRkt5jeNfX7SEkwKc+s4TTUWaGl+iG0I0uHlt8XLQLxgAzWwGcD427fcPovoGq3uD2uPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(186003)(316002)(6486002)(53546011)(36756003)(2616005)(956004)(44832011)(8676002)(26005)(86362001)(82960400001)(54906003)(31696002)(16576012)(8936002)(7416002)(4326008)(31686004)(2906002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdMNzJYdmt3QU5tQW1ESlRuQlNPS05GWnRseDBRZ01RQjRQOWMxcnpKTzk5?=
 =?utf-8?B?OEJrREdGYnkrZk01cVlTWk4yYnRrbjB5ak0vN2Rqdk5mK0F3TkQ5MEZ6aFRq?=
 =?utf-8?B?Mk8rSVJaZ29pTlQ0M3VJQTlGMHA0dVJmcVJBajBJdjdsQ0NnMklweGtJMzJX?=
 =?utf-8?B?VkpNOGgyT1o2Z2R5ZHplVnBxd3U5b2Z2UVU5dTBHUXd3UW5TQVpJQ2tEQkNp?=
 =?utf-8?B?TU4xYXF0ejlVV0VLZW9TYm1BbGtMbGlDd0djaGRwa3BvVEhGbGh0WTFKbW1a?=
 =?utf-8?B?c0tGL25LVW1ORi9Ham95cEJmU0FjckhZWmMxSC9KU0pwNlM2Q1AwVnlSa3Zj?=
 =?utf-8?B?L0gyakRkditnNllsbDc0Vit0bTdOdjFZU1FRVFptcWdnVFFodzM2RlhOVllD?=
 =?utf-8?B?OC9DYTVKZTNpVS8wSVVaSTJQUGorWWVOZEQxTjRmWVRPVnAvQWFaVHhwUHZQ?=
 =?utf-8?B?elJKSHpkVEhtQnE3NWVFV280WGMzZElTb2dqVVF5YkJ2Y0tiN2ZKQ1h3dUlM?=
 =?utf-8?B?TDJ1Sks4OFI0WVFtWjlhM2wzbWlSbHhFMGNDQ3ZQODdGMURpU0ZEaGVVTDRT?=
 =?utf-8?B?U1lrdUVpK2krMmVOWmNvTkZNVkpYTDV0Y0VoOGxWejFoTTc3cGlidVhoSXJm?=
 =?utf-8?B?NW9rMXRDcyttVzV6S01ZQWhNTE1JMlFvcEZrcFFSZ2RPZCt4RE9IT0ovZHNJ?=
 =?utf-8?B?UHlsK2JYS1NHQVk1UFZxK3FhQnhCSmdrUC9ILzVFTE9SYUt5cTA3aUxLdGtU?=
 =?utf-8?B?NzdGNW1kVTFoNVAxelBsYXg5MVI4ejBVcUVEN2cwaVRpem1VTmN3NEs4bnh3?=
 =?utf-8?B?TkE3MzhWbW1Gc2pCZUVzV3VEUHJqdlNGOWRFUmF0d2MyS0ZjRzUwUUtvMjV5?=
 =?utf-8?B?bGswNTNnWk5yZGozWDhWSk0rbDNyQ1RDb0ZwOHk3dHJxS0htM2hBUEpPRkVO?=
 =?utf-8?B?TGkzanNIRzY4MXYrNmx6Vng3ampZY0V6aTV5S2JMTkFqWVpWVTdWUnE4MEVn?=
 =?utf-8?B?czU4eDkwdHEwbEE1VUVWeFBuYUlJTzA0WjJiZXRueGJ0QUdPWkVMcEZ2bE43?=
 =?utf-8?B?MXd0WG9UN0dsU0VYT1NNcUVUQXlSaTQ3MlFxRGZ1RlMydXY4NGljWnBZL1hZ?=
 =?utf-8?B?WVdxeDdVSUdhRER4OG5nNEZYM0RrM1ZrTzNrMmdMeTU4U3JNZ3M5bjBkOUtO?=
 =?utf-8?B?Z2xGblZFMStPV0lscDRFQklEOVRUU2ZTMnVOc0NJdjB5ZVlZcjlVdUZXNlhC?=
 =?utf-8?B?dlQzTmRkRlZibjhpRkZicktzNU54MVNrNUwrT2FFc0NSanJOZFNkcmFmM1Z6?=
 =?utf-8?B?V2Vud0NtZEFLdDRub29RaGtIY3BiTW1lSTBLMWorb2NDRlhrTTE1YVBGTDN6?=
 =?utf-8?B?RERUaWt0QnE1dlJqelNHeDVKT25hS2EyY2ZQZG1NNENFVzdWLy9yS01CTTRQ?=
 =?utf-8?B?K2NjMEpwc3ZVUXVINVBacDlvaHVSaFluakdnL1NtZ1VmcW1sKzR1QnhqV1RT?=
 =?utf-8?B?MXNVYmpvcVFpRzBySTFaMWpmRDdtQ01vUWgvR2dpQ0NyaUpFL2xDYkd2NHZY?=
 =?utf-8?B?bDczQTNhNjMrZ1VQTkluWkV3M0ZvQlMyYkhFbUZOVEZaaFAwQmdNWHlPTk5Z?=
 =?utf-8?B?Y1dKdm84ME03K05vaVFvWStVeENZajdPaFozM2duZHhuUTRCdHFCZElBcngw?=
 =?utf-8?B?SC9hZEl0cEFoMmRoMCtDU25EeUVLOVVycFBzRW1hcVVkY1d4ZE1vbTRldXB1?=
 =?utf-8?Q?1GDhRJ72O+xfao0VcpbuLM+Q/EiQluesHE21K/e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c47b2f-74ce-4008-07cf-08d9902b3e4a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:29:25.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzeFsUKUYJGw7QsAtJg9P8wE+SRL4my5g7qmtnu8VdGOjmgKPQ+V3Xp6n8e6lPvItSSO6UQ3XTi7CUwOl2kHX4STXCS7QvbAkVI+TPLCZsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1299
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> resctrl_arch_rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a counter. Currently the function returns

resctrl_arch_rmid_read() does not exist at this point and is also not 
introduced in this patch.

> the mbm values in chunks directly from hardware. For bandwidth

Could you please replace mbm with MBM throughout the series?

> counters the resctrl filesystem uses this to calculate the number of
> bytes ever seen.
> 
> MPAM's scaling of counters can be changed at runtime, reducing the
> resolution but increasing the range. When this is changed the prev_msr
> values need to be converted by the architecture code.
> 
> Add an array for per-rmid private storage. The prev_msr and chunks
> values will move here to allow resctrl_arch_rmid_read() to always
> return the number of bytes read by this counter without assistance
> from the filesystem. The values are moved in later patches when
> the overflow and correction calls are moved into
> resctrl_arch_rmid_read().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 34 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 583fb41db06d..f527489a607a 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -413,6 +413,8 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>   
>   void domain_free(struct rdt_hw_domain *hw_dom)
>   {
> +	kfree(hw_dom->arch_mbm_total);
> +	kfree(hw_dom->arch_mbm_local);
>   	kfree(hw_dom->ctrl_val);
>   	kfree(hw_dom);
>   }
> @@ -438,6 +440,33 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>   	return 0;
>   }
>   
> +/**
> + * arch_domain_mbm_alloc() - Allocate arch private storage for the mbm counters

mbm -> MBM in comments also please .

> + * @num_rmid:	The size of the mbm counter array
> + * @hw_dom:	The domain that owns the allocated the arrays

the allocated the -> the allocated

> + *
> + * On error, call domain_free()

When following kerneldoc please use "Return:" to indicate the return 
section. It will help to run scripts/kernel-doc on these changes to make 
sure no new kernel-doc issues are introduced.

> + */
> +static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> +{
> +	size_t tsize;
> +
> +	if (is_mbm_total_enabled()) {
> +		tsize = sizeof(*hw_dom->arch_mbm_total);
> +		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
> +		if (!hw_dom->arch_mbm_total)
> +			return -ENOMEM;
> +	}
> +	if (is_mbm_local_enabled()) {
> +		tsize = sizeof(*hw_dom->arch_mbm_local);
> +		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
> +		if (!hw_dom->arch_mbm_local)
> +			return -ENOMEM;
> +	}
> +

Proper cleanup on error should be done in this function. Please do not 
use domain_free() as cleanup for what can be done in this function. I 
see domain_free() as the higher level error control ... like when a 
wrapper function calls arch_domain_mbm_alloc() and then something else 
fails after that ... then domain_free() would be that higher level error 
handling.

> +	return 0;
> +}
> +
>   /*
>    * domain_add_cpu - Add a cpu to a resource's domain list.
>    *
> @@ -487,6 +516,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   	}
>   
> +	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
>   	list_add_tail(&d->list, add_pos);
>   
>   	err = resctrl_online_domain(r, d);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0a5721e1cc07..aaae900a8ef3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -303,17 +303,30 @@ struct mbm_state {
>   	bool	delta_comp;
>   };
>   
> +/**
> + * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
> + *			   return value.
> + * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it

Missing a ":"?
Please do not use "we".

This is a description of a struct ... can the doc elaborate on what 
"this RMID" means?

> + */
> +struct arch_mbm_state {
> +	u64	prev_msr;
> +};
> +
>   /**
>    * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
>    *			  a resource
>    * @d_resctrl:	Properties exposed to the resctrl file system
>    * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
> + * @arch_mbm_total:	arch private state for MBM total bandwidth
> + * @arch_mbm_local:	arch private state for MBM local bandwidth
>    *
>    * Members of this structure are accessed via helpers that provide abstraction.
>    */
>   struct rdt_hw_domain {
>   	struct rdt_domain		d_resctrl;
>   	u32				*ctrl_val;
> +	struct arch_mbm_state		*arch_mbm_total;
> +	struct arch_mbm_state		*arch_mbm_local;
>   };
>   
>   static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> 

Reinette
