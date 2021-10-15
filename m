Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64942FE16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbhJOW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:28:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:63808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJOW2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:28:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208111391"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208111391"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="627957322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2021 15:26:31 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:26:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcBecr/i/5sqnCNuViDt1bFpO6dNupomjG9NdkkXFbg1P66Mmtb6x5S/FKd5lFST7eDKzhsBy/vG9YT2yrGc2Sht8mKBg3CXZS1B6pw/rAhw6P5dDFo3Y/Cg74jr6b1x0hAqG7kZHs8M8DV6id0n5tiqSq8UivyZiBuUIYYDtoQ5Ky+3d3FFvbM6e6BCGQ1Ft4JQ8gZvFHfKwH/72O67wrINQXLaLEU4TarnjgaEqALPMX1jTSGj5hd9Tsb/qMdKDEruvkh539+YxMR9CldlLGxoneJpp8n9QHjt4NF+qd7L9XnGwCpr9JxkdPQiYeO3NbqbUv8gsZijLwBeDEmIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkk5Y7Tw4dXt5+QXrFw03P2rw5bEPL6mUrr77iZIlNs=;
 b=NObZogiLBqtijb10iy5VJN7oA5lHLJCWKVWbEi0jQ8EFzd1ZIsRkcCq5TKRdPyR+/xMCq0ihOdVjkQQTenRAZ+o6MgfT5x5ZpSTG9Wn4cnBUNj9sxgkEj0vmblzw8vVDtJOo7zC1pxK0yfLW5+XTN1AhnF8yl/CWV23rbYgueayM9j6NbkYeyTpWJ8PAX6ZeiFzt74fXhkfU+58X4zrQ/9qq1HZL47vIXKIMw/SYrxpgcSW4vdSC2J+5I/ytZ9RjTbtWUrbXG/JyBRhi52nBYtcl0CNdO1afhMf4JVtf4EjOfWulCVPKRlzJ8rRDQgVOs8X6oj8mihxet2oi1LNseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkk5Y7Tw4dXt5+QXrFw03P2rw5bEPL6mUrr77iZIlNs=;
 b=avxDxcEcRB0ikag4YY12+IJZCZIzX22YoKAQVR/31oNEeMU+KrNNkqgE1RqXXp4QQGJgd//0Gpm3QuSYk1jvaa0cIbKlrAWljG9BiyKuFaoZawMK9j2uVF7aMB+Hu7vC7fDG5wkP5UZKsJUptKHrNBrhdvyQJ3YsSerlVSvVUdM=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5387.namprd11.prod.outlook.com (2603:10b6:408:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 22:26:29 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:26:29 +0000
Subject: Re: [PATCH v2 08/23] x86/resctrl: Create mba_sc configuration in the
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <facea348-2c54-fe52-09b9-8feccd15db2d@intel.com>
Date:   Fri, 15 Oct 2021 15:26:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-9-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:300:d4::14) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR19CA0004.namprd19.prod.outlook.com (2603:10b6:300:d4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 22:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffcce775-60a9-4ecb-435a-08d9902ad519
X-MS-TrafficTypeDiagnostic: BN9PR11MB5387:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB5387175AA36993599CC3FC1CF8B99@BN9PR11MB5387.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWE/ai+zcksPl7aoa/rD8g9gky57LrylsHoFnY/ZqJ/+53mIadaxVAcUlqs4pgwOz86gVDHV0DjKt0tbMGipsPq4JMxY5FfgHDXYNmeOPo7v7jSNTqfV1Uvpym1zsey4S44ut4i6aulLreyOWhhDuryf3QYEPMIvTF4t8F5Rf2X6a/UcH7cpdAqACFV4uPXSodeTKw0pyT+oSC3wDc5hWHYqU5ty0Zy24MI3a7bfJaog31D3ykLiXl7WD1z+Vmg7Z5Zlbl1KlQL1I7WMgP4GPpcLkL2HBXVxKY/zW5znZk9t7C3C1TjIz+37aov4gd52jzO+8gBo179v9JNUOdPI68NaR3Kg0BRT+3oTSZ5pLUpYAliyq3T/HGlgr1D/Gr0Q+EGIgLq+m+LR9MsH3+jFtlpqgWb+uoGrEh1FvXJaVKgH6jdWFhVk0D29kQSkrH0oBEWig7Koi/wfLX0o1J5NJWWjvTLfCrHL/Bj3rceKC10Fgrcta0GWFrIWQD/tysZqLc8TXz7j8MDsorKKziIvwwyuM2QHN7Xw57WKYJ5VWkNiZiZW0YX0do3+WlGe+iV/I7PfzaimeUwpU3pCTC3UyWwrAe4V0YEcsxmiXHgKDAmgd5+f2uL6hxUrYv6Nom7wz1UzkUzxS5LTlJ7IiJGRHctAJzkkNfxJUOuZ0CeQnrpNWoTLfaE5cNRxijCcp4RAWwhTpgnWZWM8LK09npuiaPi5/a0n+bWF6XqCOlbooB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(2906002)(66476007)(6666004)(82960400001)(8936002)(66556008)(66946007)(5660300002)(2616005)(44832011)(956004)(7416002)(86362001)(6486002)(31686004)(16576012)(53546011)(8676002)(83380400001)(31696002)(186003)(508600001)(36756003)(54906003)(38100700002)(26005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGg3Zk5aUUxEZjljdXA1ZXZxWnI3RGVzT3ZmNElsRit4ci8vNEpLVTVPRkhE?=
 =?utf-8?B?Z3pBOEtuaUNuVk9ZVjdnU0wvS2NGYzZ1OURhb0tuQTY3YS90cll2b1VqUjQv?=
 =?utf-8?B?L2NRNFI4Yml2ejZmZ2ZuaFh3ZCtaaTBwakREc2Y3S2M0U3Vxblk3ekpSRVNL?=
 =?utf-8?B?bzNCVFlzYm5teklQUUtOWUtqakNISithY1lTOGVjN3NIN3lIak1kTnBnd0ZB?=
 =?utf-8?B?RkJuYjd5WkhXZUNPcThpb0RvaVBVTzBMS214VzZQTkVqR3NtVG1MRlBhRkZy?=
 =?utf-8?B?dGtzWHJoRnE1dDFXUlZ2N3JGTFNVSWllWDZTbCtobzkraGt2L29XNVZyZzhB?=
 =?utf-8?B?b3dEZTlUczk3Vy9nc2VBS0lMMFJMQk16ZzdxZE1VbUsrU3E4WVZsL0V2ai9V?=
 =?utf-8?B?ckJqWFUrUVJaZ1lLWStnck9kRGRKWHpwb3BqalptdnpEL1N2c0RjdVFha3Js?=
 =?utf-8?B?NEVhTjFGY1Jhdnl3SEt6Ym5KL2ZBdU9LaDNTNHA1VHFpLzNrbU1IMHB0NVhy?=
 =?utf-8?B?VUQrRDJERW9pU3pBZ1p3T0wwQ1Q0SVhRd1ZTRGVVc3VwVUdlK3dzWENuTWRv?=
 =?utf-8?B?NmhHSzZuTSt2WktTemVwQjBNT0J4eUdSSURjcHBBWlY0M2hUSWhQeVN5UTJ1?=
 =?utf-8?B?RjN0Mm9ZVVZJK3JEUjIvblVxUU9tSFRNUHhJWmRKMHhtYjV2cCtMQy9EeHE0?=
 =?utf-8?B?SllWbHJjSm1FT045Z1F3SWZXM0F4c1liQ2VkbTU1TklRR3hsVmJEVFdMU1Z1?=
 =?utf-8?B?N2ZkWHYvZmNBbnNjQWwxb09TS2JVN3dndVl1QlZ0U2pUTkMzZGUrZ3I1NVJt?=
 =?utf-8?B?bFJRYUtSMlhCbjFwWWxSckZqOEo0TW9GZkU4WUp0QlRocHZRM1N2NnkzRU14?=
 =?utf-8?B?Z1RxakVzbDMwbzRwODV6Vkw3TktvdlVnbUo0aDV4bVpOZXpHKy9jUnVXVWRq?=
 =?utf-8?B?cGtrUGYvdDV2Yk9HUzQrRVRiYmt3YkpFRmdKZU5IU2RqMmtYZ20rbUN1RzVR?=
 =?utf-8?B?ZjZ6Zk1DcnhnS1VGTHFIcHFNOW9TZWFGWFRsRGJtTzBpTklGenl0b3B5LzRD?=
 =?utf-8?B?VnNYemI4cDArNGhuY0hDREplakVnQXJ1U2c1RUo4WGkwY1NuMU9JSE9oMkFU?=
 =?utf-8?B?a1NYZEV4cjF3MzJZcmh2bHdlRE5LTk1NOC9JTWM5cytPT3VZMFd0N1hteEMz?=
 =?utf-8?B?Tk1FcVN5bnZDdGJFR2wzU3NXOGpFampNWkFnSmRNMjZKWTNBZDN1VEdoWnNH?=
 =?utf-8?B?aWdWOTg3dGNYb3JkdnVjWmlNTHRUa1J0VEZpRTRWUFlsR25tcERHMnpqREtz?=
 =?utf-8?B?VHI2SzQ3dmlEL2o0MzFsYjFKbFQ4bE1UYUlnY3gvMWZKeUFtTVhyeFg2ZXdC?=
 =?utf-8?B?UW1kUVZ5eXNYN09iUGNZb1lvekpialJ4UmpOVHVkbmhtZkQxVFk3cytCdE5j?=
 =?utf-8?B?endEYVJxbjlsMkFqM2pxUTBGb3lsaGxlTm5GdFBGVVNBYmgwVmFobTBOd215?=
 =?utf-8?B?ajFHTkFXekNTVzc1VVBtRVBqTldzWEJNbzFrRk14citlVUkyaGIxazV1aVJM?=
 =?utf-8?B?eWlCdFE3T1Q4ZmZLMWpTOHp2SVBJdUhsdlFSL0VnSGpOeENyQnM3QWJndXlW?=
 =?utf-8?B?Z0RFemdMMHVnbk1OOFIzUmxRMWJ0U0xiNHRBaHkyejJ6YmF0R1UrVGF3RWhL?=
 =?utf-8?B?bE00WGFWVFZQOTE5VzdnYlN4RC8zWFBuZUlsblNlK29KNjN6V1J3c21YQzRI?=
 =?utf-8?Q?uZC44KVAxYRUtXJedr7tUkWhpSVZsLYEgDJ5L6d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcce775-60a9-4ecb-435a-08d9902ad519
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:26:29.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeHhbUcsn++jZrHkdcaqApZkRffPclVNfV825Q9bqyuzhApxPcNhLm7Uhn2OWK4Fkn0Jk/vQ+UMXj7qIXIGQqXZAzm/K+12nqojusyvD5hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5387
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> To support resctrl's MBA software controller, the architecture must provide
> a second configuration array to hold the mbps_val from user-space.
> 
> This complicates the interface between the architecture code.

This complicates the interface between the architecture code and ... ?

> 
> Make the filesystem parts of resctrl create an array for the mba_sc
> values when is_mba_sc() is set to true. The software controller
> can be changed to use this, allowing the architecture code to only
> consider the values configured in hardware.

This changes significantly more than just where the mbps_val array is 
hosted. It also changes how the life cycle of this array is managed. 
Previously it followed the domain, whether mba_sc was enabled or not. 
Now that it depends on mba_sc it is managed quite differently.

Could the changelog be upfront about this change and its motivation? 
Stating this would make this much easier to review and also the later 
patches where the original mbps_val initialization code is removed 
without replacement.

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Added missing error handling to mba_sc_domain_allocate() in
>     domain_setup_mon_state()
>   * Added comment about mba_sc_domain_allocate() races
>   * Squashed out struct resctrl_mba_sc
>   * Moved mount time alloc/free calls to set_mba_sc().
>   * Removed mount check in resctrl_offline_domain()
>   * Reword commit message
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 -
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 67 ++++++++++++++++++++++++++
>   include/linux/resctrl.h                |  6 +++
>   3 files changed, 73 insertions(+), 1 deletion(-)
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
> index 38670bb810cb..9d402bc8bdff 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1889,6 +1889,64 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>   		l3_qos_cfg_update(&hw_res->cdp_enabled);
>   }
>   
> +static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	/*
> +	 * d->mbps_val is allocated by a call to this function in set_mba_sc(),
> +	 * and domain_setup_mon_state(). Both calls are guarded by is_mba_sc(),
> +	 * which can only return true while the filesystem is mounted. The
> +	 * two calls are prevented from racing as rdt_get_tree() takes the
> +	 * cpuhp read lock before calling rdt_enable_ctx(ctx), which prevents
> +	 * it running concurrently with resctrl_online_domain().
> +	 */
> +	lockdep_assert_cpus_held();
> +
> +	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> +				   GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mbps_val)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_closid; i++)
> +		d->mbps_val[i] = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +
> +static int mba_sc_allocate(struct rdt_resource *r)
> +{
> +	struct rdt_domain *d;
> +	int ret;
> +

Please initialize ret.

> +	list_for_each_entry(d, &r->domains, list) {
> +		ret = mba_sc_domain_allocate(r, d);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mba_sc_domain_destroy(struct rdt_resource *r,
> +				  struct rdt_domain *d)
> +{
> +	kfree(d->mbps_val);
> +	d->mbps_val = NULL;
> +}
> +
> +static void mba_sc_destroy(struct rdt_resource *r)
> +{
> +	struct rdt_domain *d;
> +
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(d, &r->domains, list)
> +		mba_sc_domain_destroy(r, d);
> +}
> +
>   /*
>    * Enable or disable the MBA software controller
>    * which helps user specify bandwidth in MBps.
> @@ -1911,6 +1969,10 @@ static int set_mba_sc(bool mba_sc)
>   		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
>   	}
>   
> +	if (is_mba_sc(r))
> +		return mba_sc_allocate(r);
> +
> +	mba_sc_destroy(r);
>   	return 0;
>   }
>   
> @@ -3259,6 +3321,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>   		__check_limbo(d, true);
>   		cancel_delayed_work(&d->cqm_limbo);
>   	}
> +	if (is_mba_sc(r))
> +		mba_sc_domain_destroy(r, d);
>   	bitmap_free(d->rmid_busy_llc);
>   	kfree(d->mbm_total);
>   	kfree(d->mbm_local);
> @@ -3291,6 +3355,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   		}
>   	}
>   
> +	if (is_mba_sc(r))
> +		return mba_sc_domain_allocate(r, d);
> +
>   	return 0;
>   }
>   

Could this be done symmetrically? That is, allocate in 
resctrl_online_domain() and free in resctrl_offline_domain().

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5d283bdd6162..355660d46612 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
>   
>   #endif
>   
> +/* max value for struct resctrl_mba_sc's mbps_val */
> +#define MBA_MAX_MBPS   U32_MAX

struct resctrl_mba_sc?

> +
>   /**
>    * enum resctrl_conf_type - The type of configuration.
>    * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
> @@ -53,6 +56,8 @@ struct resctrl_staged_config {
>    * @cqm_work_cpu:	worker CPU for CQM h/w counters
>    * @plr:		pseudo-locked region (if any) associated with domain
>    * @staged_config:	parsed configuration to be applied
> + * @mbps_val:		Array of user specified control values for mba_sc,
> + *			indexed by closid

Could this inherit some of the useful kerneldoc associated with the 
mbps_val being replaced? That is, it exists when mba_sc is enabled and 
contains bandwidth values in MBps.

>    */
>   struct rdt_domain {
>   	struct list_head		list;
> @@ -67,6 +72,7 @@ struct rdt_domain {
>   	int				cqm_work_cpu;
>   	struct pseudo_lock_region	*plr;
>   	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> +	u32				*mbps_val;
>   };
>   
>   /**
> 

Reinette
