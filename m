Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD142FE2F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbhJOWcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:32:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:47564 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238811AbhJOWcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:32:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227951838"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227951838"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="716664006"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2021 15:30:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:30:19 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:30:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:30:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVE3gHV93v8+5UHO1mnJ0OpMzd8et5ZL8VFZ5WnmZ8zqgdj+2+MGIZk/UVv3nhLGwzlHqHvXW/aN9xfpd2arCahbZeG7FpQAG5cPktGIiUHE+8mdVf9V9DMKmDV3a95KGuQNdI5sW1YnKT1g7VRpDJrCwJkTVouNGSBAu5cuD2lQPMPXqVXGJHLw9eUj1MRBpL2N/hYWc9xVJ8J4+UZvLymaU/eBTkGrHPt9lgxgCIgFCMml73hrOsB4t4mwS1YJkDML3QbOR0zCuuDC9qhXp6t1ngy4TzNRIXXIUqbC0okaNdhvj0lJlXNC4rI3x4f5tILIUle5PXssSxlpmryZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riL7bQimBC+FRHV9RnWRMrfQJrb1zWSoTIJNQI42Gv4=;
 b=YY/EgkYloiZw5ayiAANlzt3nHKhKNLFJzpsyfBgmy2sWEi0ZkcKoJc/P6eRKBsnHP+qU5Z+ur+O0LfZ4e2wMv6Kx3mP1hB5RBKSW+xdlSfKoNVn4+0ZaRoyltgOV/d/kSQk6uM0QcvepE17uzZcovk0GwfP5ATJs5qXpdMQLZjipVdaAfW7gK/ScPkQsI78jyXic/4WDGWcFlCalR13Jf//davw8fEf28FbE2IiwEyIR9h5P+nkDWP/+Nnw29WNPTJA+UkxUJ3cpR624Y1YE4YnLb+1jt5+3J1sQHfpAgGBnB9bc8xgMAY+h5SKb4tiLpqqNAUTgZ46e48QztCkU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riL7bQimBC+FRHV9RnWRMrfQJrb1zWSoTIJNQI42Gv4=;
 b=oIZMfBAWn+u+6Vr33oTpHWlgrPRq6Gyn7ZCV/Pl5T+9Jc2w8512+O+JjyQ+TMBF7LkC9AWcapfmRnzwTxcOkG3aeW1IfBQKeXiNqyhH1+t3FRL2Yl4Q7iuKfS2kQV1M5oRG91Phmn8O2fC/0UJ8H/HbUgoRGJINeaO5Q8S/EpHs=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1299.namprd11.prod.outlook.com (2603:10b6:404:49::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:30:14 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:30:14 +0000
Subject: Re: [PATCH v2 18/23] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
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
 <20211001160302.31189-19-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0d3d0869-c303-2411-ab74-76f7e06f9721@intel.com>
Date:   Fri, 15 Oct 2021 15:30:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-19-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:300:12b::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR14CA0027.namprd14.prod.outlook.com (2603:10b6:300:12b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 22:30:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b8965b2-74d8-4c77-4159-08d9902b5b7d
X-MS-TrafficTypeDiagnostic: BN6PR11MB1299:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB129999590E8BCC037AD6F2A8F8B99@BN6PR11MB1299.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obpmakZ6ckxL3B5sGV2teGrePNG4TNXwNcAgFPbQztEqfAGfKSNuGYGqZD7kcOClzACSb/BsG+2aFiMewx6OatG5V9pmP4iHY3qByLhq7KDcyxa1zy0iYx0at7dfGHboXi1hgd0IZ3qbdFJp79Gx2fcp/RQoCTpsU56ZqZud35XNoKhOjqlP43Hiu9QhvZlA5z3QQ1aGOd6H98jzt3dGHZOOCfadsIfXeasQ4UWrR2v3r0rAJcxGzsTkL/yYjyigvVnMDKljjQi3hRASUjYQvIF1wdkw0WACvwpB8+9XTG/nQrPfGX6l5HAtGBz3Q0EhaZ5E0dFesQI51MxIFZiOx7/bXE7qwenSWRfLgghBPthvgDfHni9t5VE+r0ItFnl6Fpwo6wH1JLOZGP15PEXQWlWXXn3x6GIeR8Jwu+Tt1XMcJAyg7u0q9iL2FRn0P/BC/kZZ6+y0AlEDZD+qdR4mQNnYQwB0ah7MPn3v4atBCdCGpR86LJ68w4l25j6vEo2wEetzLxxBci+/jeYApBUWyCKkU57CU0aCKEyx9o+lIyPm7xjKuEYtCrPbn4SBcvtoQosaY9LNKxTpHjyPdmijobuYpaYczcvZsQcjbFAjHyyU7OZTJRRuUNcNx1rOG/sgHjSqn5q8yHj5gMs2sWpOxk2YaSDFNVO/ztLd9nn6uNS5u2+xbIvw64c7jEa4vomp7hVsa5x2aQvovLNmD32rca368Jgrx5Md7kmbAZM1pw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(186003)(316002)(6486002)(53546011)(36756003)(2616005)(956004)(44832011)(8676002)(26005)(86362001)(82960400001)(54906003)(31696002)(16576012)(8936002)(7416002)(4326008)(31686004)(2906002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGxZNkx5Y2R1cHRBRHZuWHJsZTAzYllvSHJvbjNMLzZzQ1BFWkY1Nzh6T2Rx?=
 =?utf-8?B?eHNWc1c2NUwzeXY5YnNabUVxZWFOTjIxQWRwNk80VUF3YnYwaEFGWHk0MjR4?=
 =?utf-8?B?dDRUTzc2c1lENENIMU1oSWdrWEp2RHdCaEMzZ3MvYWh0MjJ3Y3A4cy90YTI4?=
 =?utf-8?B?RmVvd2ErODg3YzlWdk1tRW9xWU5UNzRMa3NadmNaTi9RY3FsM2tjYTdCbHRk?=
 =?utf-8?B?VGRleFJaNnZOaGVwejVvbGJ0QzMwYjRubXYwMklMNElNMGhLM2NId054S3RE?=
 =?utf-8?B?V3dySndsOFBIYTV1ZnE2L2pkL09uQ1VzNTYyWHg2eW9CQ3hvQ2c0UW81UXRU?=
 =?utf-8?B?NEt2K2taWVlGSEtjOGRoWDBtQVFSVG03L2JsNklxb1FZTTc4UndLY3U5NXNB?=
 =?utf-8?B?QTAyY0srWVppdUZYWHo4MkNRd0h6ckZqS3dzVkE5cStIVE9wUk1KclFieEVI?=
 =?utf-8?B?S3JPSkkyZkZBeVRUVlFzbXVjV0gyQzc1QlVtdThIQU9lOEphRzQrNGNkR2Rp?=
 =?utf-8?B?ZnVOOHd0TFExdGZ2QUcxeGIvVGJGLzJ0NHFEY1dUYzNwNXM5UjhEV1F6Qzlt?=
 =?utf-8?B?SXdCVk1YYUNoNjRrYU5mREd4eDkwa1VTdG5RMkY1TUJyUVJLSGFCOWpscCtz?=
 =?utf-8?B?T3RmVHY1cmg4TjU1bTAxb0V1SkVWMzJXRDVRSEZBSVI3R3RiWmJqUCtrOXgw?=
 =?utf-8?B?dUVuUmNYTEloWUttRHR0YUpIdzViRk1kM0F0VVBTb1NOUEQ1bGd4b3BEQmgy?=
 =?utf-8?B?MjJ4elVpOXdyaDNkcmpRUFp1Ui91SHRncDVlYVFMMHpQdGp4bXRBNkttcm4r?=
 =?utf-8?B?cTRoT1U5dk5DVU9saE9xaHhPVjZrNlhBZVl3YU9TbWZsbSt5elpDQzc2Skdl?=
 =?utf-8?B?bTkxZERMOS9ITjRxWDBPbVVSaGVpYmorODJZS1NMb2JrY0I0SkhHbCtLcktO?=
 =?utf-8?B?R0cyd3dTTjhKQjJYaU5HeEZSZkJ5bGJDMWNQRTlVbDJTbnU1RURLenJ0cTg2?=
 =?utf-8?B?Sk9kOEY4Qkw2NDBWdGVFNEdFYjFjbFBwUklTWldhbnh3SDYrUWVXRkhLcXpz?=
 =?utf-8?B?U083R0syUUNzTlFwRnJ0bHRmc2R0LzFuNUc0cjg5RHlzdXpMR3lwQ1VLazJu?=
 =?utf-8?B?UVZYYzFZQUtrN3ZPeHYrSlJ4NjRwY1JBUHZ2blFaUENRS1A2S3M3UzRWbHF2?=
 =?utf-8?B?RmRWbi91VlpyZ3k0SGl5ZTRqc1dBMGJGRWtiVEVKVW1BK3ZXc1NOR3BYeDdo?=
 =?utf-8?B?TXllRDluMW9GNTJ6WFZ4dmk2U04rZDl4RDQ2WCtpUVBSVjFCaTFmLzZhT3Jj?=
 =?utf-8?B?Z1FEdnVhK0RmOXpqb1pqdW1TZ1I5N1djVGVwVkorTW8xcWczUmxHOUtRRmlt?=
 =?utf-8?B?NVNNUWZUejd5eFBoMEpQWE03dHpSZFE1L25leHAwQytjYU5FRU9VZ2szMmdC?=
 =?utf-8?B?MjREV0xpcVM1MW1sanp4TXoxK0ZjbEc1eG4yYjhMZjN3V3VZeVJRdmhzcHA1?=
 =?utf-8?B?bWxLUU5icWpoSWhIWFh1MHZySDlFZTRsRHVlV0N6a0FrR1Z0T1lzUG1DOWpP?=
 =?utf-8?B?OVlBMlFkUU55WmV3K2VERkNyUFVIemhqUjk2UFZMREF4WTIyUlZ6bThyWWlu?=
 =?utf-8?B?THJIY3hhMEpJbmxwYkZxeWl1eGN2Z2w5aG44K2t6ZUdFNnExZkRsZTMxSk5V?=
 =?utf-8?B?cmFUb0lUVDRjd0wvVnNTdzN2TUE3K2hNZ0UvUW9FQ0lBWENobWR4S2pKRWIy?=
 =?utf-8?Q?M5JLx6rNb6lnpbXxwY5wk2jTgicdK3Ev9ASmNfb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8965b2-74d8-4c77-4159-08d9902b5b7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:30:14.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R8lfR6x7EwJ1FKRP7JEpVevGtob+vhZRh0QIZ+OrkxVBZI2AG0YTCBL2ctBFAcO8zqjPf9IOnk4/m67CJuOgiV32xxPJF3m+2OVcm+OwxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1299
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> resctrl_arch_rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a hardware register. Currently the function
> returns the mbm values in chunks directly from hardware.
> 
> To convert this to bytes, some correction and overflow calculations
> are needed. These depend on the resource and domain structures.
> Overflow detection requires the old chunks value. None of this
> is available to resctrl_arch_rmid_read(). MPAM requires the
> resource and domain structures to find the MMIO device that holds
> the registers.
> 
> Pass the resource and domain to resctrl_arch_rmid_read(). This make
> rmid_dirty() to big, instead merge it with its only caller, the name is

to big -> too big

> kept as a local variable.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This is all a little noisy for __mon_event_count(), as the switch
> statement work is now before the resctrl_arch_rmid_read() call.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 31 +++++++++++++++------------
>   include/linux/resctrl.h               | 15 ++++++++++++-
>   2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index cf35eaf01042..f833bc01aeac 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>   		memset(am, 0, sizeof(*am));
>   }
>   
> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_domain *d,

Please do not use tabs in the function parameters.

> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
>   {
>   	u64 msr_val;
>   
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +		return -EINVAL;
> +
>   	/*
>   	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>   	 * with a valid event code for supported resource type and the bits
> @@ -192,16 +196,6 @@ int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>   	return 0;
>   }
>   
> -static bool rmid_dirty(struct rmid_entry *entry)
> -{
> -	u64 val = 0;
> -
> -	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
> -		return true;
> -
> -	return val >= resctrl_cqm_threshold;
> -}
> -
>   /*
>    * Check the RMIDs that are marked as busy for this domain. If the
>    * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -213,6 +207,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   	struct rmid_entry *entry;
>   	struct rdt_resource *r;
>   	u32 crmid = 1, nrmid;
> +	bool rmid_dirty;
> +	u64 val = 0;
>   
>   	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   
> @@ -228,7 +224,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   			break;
>   
>   		entry = __rmid_entry(nrmid);
> -		if (force_free || !rmid_dirty(entry)) {
> +
> +		if (resctrl_arch_rmid_read(r, d, entry->rmid,
> +					   QOS_L3_OCCUP_EVENT_ID, &val))
> +			rmid_dirty = true;
> +		else
> +			rmid_dirty = (val >= resctrl_cqm_threshold);
> +
> +		if (force_free || !rmid_dirty) {
>   			clear_bit(entry->rmid, d->rmid_busy_llc);
>   			if (!--entry->busy) {
>   				rmid_limbo_count--;
> @@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	cpu = get_cpu();
>   	list_for_each_entry(d, &r->domains, list) {
>   		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(entry->rmid,
> +			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>   						     QOS_L3_OCCUP_EVENT_ID,
>   						     &val);
>   			if (err || val <= resctrl_cqm_threshold)
> @@ -336,7 +339,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   	if (rr->first)
>   		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>   
> -	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
> +	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
>   	if (rr->err)
>   		return rr->err;
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 01bdd8be590b..4215a0564206 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -218,7 +218,20 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>   			    u32 closid, enum resctrl_conf_type type);
>   int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>   void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
> +
> +/**
> + * resctrl_arch_rmid_read() - Read the eventid counter correpsonding to rmid

correpsonding -> corresponding

> + *			      for this resource and domain.
> + * @r:			The resource that the counter should be read from.
> + * @d:			The domain that the counter should be read from.
> + * @rmid:		The rmid of the counter to read.
> + * @eventid:		The eventid to read, e.g. L3 occupancy.
> + * @val:		The result of the counter read in chunks.
> + *

"The" prefix can be removed from all descriptions to match style of 
other descriptions, also in description of resctrl_arch_rmid_read() below.

> + * Returns 0 on success, or -EIO, -EINVAL etc on error.

I do not think this is valid kernel doc for the return section.

> + */
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
>   
>   /**
>    * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
> 

Reinette
