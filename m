Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0742FE2E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhJOWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:32:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:60404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235751AbhJOWcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:32:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227889494"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227889494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="716663859"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2021 15:29:52 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:29:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuMbr7t5yElSs35DVqR9FeOZ/A7dm0IAYOUe25EFEXLwqtp2h7kWAmEjHBiRx5L+9qqHGQVq83DcvPna8mIPUyMUdb7m7pargjDmZ/6t/UQHrvNB+lj1703ZtgcAfpIGTie9tFFBYL2YdBDxhqDyWOy56FgzEF6t3rt5Z51aBfUHTaP4c8xfa7KGw7yXrxSUxu1I5b0OL9ezaETyZ+MzrvQr7OV5CbqLrRbV+XanM0X3EeD1NpsQGoHnOYLbXoO13OPF+TROPzEsfj2Gc2k9orWE1tJNA5eG8bc3jbYfPuT9whPFCQsSn0u/IVmAUdJG1PTFe7nQN4mB8KV09UB04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brT/0JooAdPiz8tb6N52DHAWDLTmxByVRCFAbkyLsso=;
 b=l9Eu6+clBH3lEH5ljHH31sX5hUiCS1uSGpA9+JjDBSwLbPd/NLIRpuVHH6X3JMVmqUo1oH0C2AOU9qcW8qJf1/NmpAiDaYUGvHSIxpMPqlp433J5VxNY4R50nqc+9+9BIBWRvUg1NZZNYTcvAIyswc6J5G7NZhPQUOYKiRm+RrQV5G0IobYV0DFoBh9LfMge1Ir70AYLcNK+nevUv8BKsf+z07adZFwfyqOYk1pt2yOZh0Vso95GGaBykhpy3hnRQfUasRCOQM4m4nyyWcwjqW/v5FZi6ztjj39TVMOFu+69VyaeWHzPvfv1aN8+DTYK2cw2CR7+MJCyoUePTpNlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brT/0JooAdPiz8tb6N52DHAWDLTmxByVRCFAbkyLsso=;
 b=eWDGGmhhf98IgjHH6FjF0QxwdwZ+aWaprFpv8u0KpZX1iV6updu0MWpqZy7mCmHoormE99GiuO8VjJs49CN+zPeXxVpIvxqNKss/P9I8f+RksYkTGV2qBrNDh6YfeTaX1WbBgIHIEZdZzQSHBUZumh8GV6mHjStW1NLDB/zhkf0=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1299.namprd11.prod.outlook.com (2603:10b6:404:49::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:29:49 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:29:49 +0000
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
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
 <20211001160302.31189-18-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <afe6b5dd-49eb-558a-dc1d-09408d200874@intel.com>
Date:   Fri, 15 Oct 2021 15:29:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-18-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 22:29:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5dcbee-0dae-4d8b-46cf-08d9902b4c99
X-MS-TrafficTypeDiagnostic: BN6PR11MB1299:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB12990DCE498B1303EF9A7828F8B99@BN6PR11MB1299.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X26hBqBx3BaGBn99Ip/Ly1wbO24vZWeRutbfIfLXIHVD+Gjj1pqZQzLSEoK4GHHslByjJtCyIaLLJ48L9sn6HWlEerP1/9n0MY0QrxFvqIcx9frEHH8JO9CItEF5PEVN7yST/RpwQBi0bndzwXsn8TcEfhI+qTAkr3ohnlIqb81ZkJGOPS2tN1KKRAzEo6Wb9ytMWHdGlpHKPM6imAGLP+VTmSL6/NWS2z/Hb73aQF7N/Gy8LF/AaoG8bAdYs5c8J97LPTD14kl3Hvqn1pr3tICOmblFTJsFTZbVJgbIB9NuORv8PODxj7QKkIOMihX2BdEi0h8HnJadfK2SoUyohproz56r5LHkmynr6+Q+LSBZgnW80RDxAK5UkSiJAXoI/A+VXihct0kuZ7mtRDuTy0zF7z+FkQlIbEK/wVM0PHaRFYyufSWM5tRLCi4Hjm6BtJzRx7A9zpKkJpDP+4CrNyAbiPExuby8nl70zcjvL8dj6EbgiWragLBgawC/XvIC7JChSoRcggc+PUZ/D6S8+HSdhIfAgyuUrXS5MjJipYyCcrZBAtve3DJ2pOhTHeJgPuxMDoI/ynBdBU5409wSZ7TWBvMvj5BO+Ft9JOraGEixbkKU2hQCe/NHgDDFmXhkJtQ1MQyjsHZv9a8H9A1xdyYofuin4jpRE4l1BcZGC5hn28m+941SAmF0Q0u1ZYAjuA8MJvZSVPnhDTGKNH+zatzfQQ6HvCrMB2Qvz38kNJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(186003)(316002)(6486002)(53546011)(36756003)(2616005)(956004)(44832011)(8676002)(26005)(86362001)(82960400001)(54906003)(31696002)(16576012)(8936002)(7416002)(4326008)(31686004)(2906002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFreGRmM0VWUFlveW9hQ2RQQjNSM00rQ1B2OWpiYklTZm45ME9wVllPYUtC?=
 =?utf-8?B?YkZPREpibWFxdWVqd2haTlpCTHRNRmNDa2hrQk91WWRtY2FXeW9WNUdqS09a?=
 =?utf-8?B?M0xlbnY1OERiL1N1M3dXWmJySExmZWJ5Q0JhczFQRDM2RjRCNDgxbm85SmpG?=
 =?utf-8?B?NnFnNW13SEZ2NGI0bDdzMGl1UUE4VnZ0eDMrZ2xIY1dRTFZYY3NmZHIvVG96?=
 =?utf-8?B?OXBKSGQ2c3RKazlNTXRubU9hTXQ4VUxqdjE2eklSRURqakVVcEpsdis3SmVU?=
 =?utf-8?B?Vk9KZVF2dUZxRU5KU3ZWcGRIL3RzZDMzalN5SVd4K2RsNllQb3lxR09KNUFr?=
 =?utf-8?B?dkU4YVE3bkUvd2xMWlhQL0U5aU1uQzc1eGYwaG1wVEFrVENYcThla013SHJF?=
 =?utf-8?B?RFJ6ZjFUOFFuamJwbHZueS9tNnBnVU5zRCsxL2E5eVpvdUNvU2xKeFpXZlRz?=
 =?utf-8?B?cFJPZld3d3l6RGNjenZyZ0NlSFlUSjRxRWRhZjd6ZU1jczZlS1BSQ2RXZy9F?=
 =?utf-8?B?ZWhKaytZTENXcllmWGlFaUY4VUpoZUhIbFpld1pNUHhHckZQalhGa25hNEV0?=
 =?utf-8?B?dzQ0dWs2MVVEUC9VSS8rbkN3SFhYNGlHbXhnL0ZSNHgyL0ovcjlmZTYwOXY2?=
 =?utf-8?B?c1d3V1liNHdlTG1mUFNtNDZFOUNYTDZpVFBhTElmcnVlUnlPK2tUa05JRmJU?=
 =?utf-8?B?TFNEbTdVSU4xeTJId1dWSzdZbFAxYjA3Vm5uUjJuTWl6eXlHa0Q3eDFweVdM?=
 =?utf-8?B?WDJMeEIwMWVFcE4weW00ejh0Y1p6cTlXVHBtSTFGcnpvWkxabk5uV3VRcmtX?=
 =?utf-8?B?SWQzS0NPcG5QWXd5N3FoQ25DQUY0YUVQbmtOZTJPNm45Sk9seDJxQi9XNjRz?=
 =?utf-8?B?N2hTSHo0TkEyajhvWXVFL3R0cmdUdUsrUDFQblhHU3VEUHlBeGJyVGdMVlYr?=
 =?utf-8?B?ZVYyWWJxcDJESWJneWxqTlIvM0pKM2kwMlFqelFNVnZsLzNnYUthdWxQcFFR?=
 =?utf-8?B?UjdIc0dTb3padGdmTjYweDBFWGhkTFB1T0V1UW9ISGVjckdnK3Bab3JqLzll?=
 =?utf-8?B?eE9TNEIrOTFabGpSZjNsYlpCTDB1Y01oQWliTko1eTBneFQ3cmwyaVNmcWxx?=
 =?utf-8?B?d0VKQkNkVDNEellXWDVGbDl1VmdyUnJYQi8vTlJ3T09CYnRpbE5RWHgvTDRy?=
 =?utf-8?B?YWJHVlMzTTNQZmV1dkdXQkgrUE1zK0ZocVpVeU1ORFl6N3VVczhBYUNwZk5G?=
 =?utf-8?B?cFVEYVk3WTdORCtSUnV3VUFJT1B1QWVweE9vWnRldjhzQ2F2TG02cEEybUpp?=
 =?utf-8?B?SFdQMmlBK0VVS25RNkcwNE94cVdUcnA2bTBtOWQ5aUNmc2U1WnFDQXY4emxL?=
 =?utf-8?B?TnZHSUJSSFRsN1NobkRLTmlka3lwcHdhaDVQb003SldTOWQzam52NEdWZC9Z?=
 =?utf-8?B?a2ZpVmgxb2ZnVUE5YXY5QitxODAveFdXU0Y0cGNQem5VdUNNc3paaVdpN2I2?=
 =?utf-8?B?QmppZ0FxY2s5QmQ0NUQzU3FTR2pWTVZENnZrMkpVa081V29OVjFWN2Nxdkw2?=
 =?utf-8?B?bXdCMHlyRUxJZlV5djJTQXJwcWVNVDRqU3FPT2YvYWJxZzFMN3g2bmI4bFpw?=
 =?utf-8?B?TE9MM2VpdU1aeUdJcGZ3UlAwMnNkbFdjMzB1cmJwTTJiZWtGSkduMGRQUnlu?=
 =?utf-8?B?aHJJRE5sWlJOQXZNNXJXdEk4cDMwYjllYTBvWFlSZ0xHQlBtcnVuZHhqcmha?=
 =?utf-8?Q?zsQHaigawCK/MW1qkosoftvkrKZengci+LICdfs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5dcbee-0dae-4d8b-46cf-08d9902b4c99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:29:49.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWswtmMVr3UoQkCWsSZuUnXIdvCZ90TOfRJFcWJ0DuOr4Kk9nTQBwXaDnwnYU1rcpRaUyncsTGYko+jhmjiHuIJngxuUZ8gWF3ecT1GYruc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1299
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> __rmid_read() selects the specified eventid and returns the counter
> value from the msr. The error handling is architecture specific, and

msr -> MSR

> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
> 
> Error handling should be handled by architecture specific code, as
> a different architecture may have different requirements. MPAM's
> counters can report that they are 'not ready', requiring a second
> read after a short delay. This should be hidden from resctrl.
> 
> Make __rmid_read() the architecture specific function for reading
> a counter. Rename it resctrl_arch_rmid_read() and move the error
> handling into it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Return EINVAL from the impossible case in __mon_event_count() instead
>     of an x86 hardware specific value.
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
>   include/linux/resctrl.h                   |  1 +
>   4 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 25baacd331e0..c8ca7184c6d9 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   
>   	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>   
> -	if (rr.val & RMID_VAL_ERROR)
> +	if (rr.err == -EIO)
>   		seq_puts(m, "Error\n");
> -	else if (rr.val & RMID_VAL_UNAVAIL)
> +	else if (rr.err == -EINVAL)
>   		seq_puts(m, "Unavailable\n");
>   	else
>   		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f3f31315a907..eca7793d3342 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -40,7 +40,6 @@
>    */
>   #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>   
> -
>   struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;

Stray snippet here.

> @@ -94,6 +93,7 @@ struct rmid_read {
>   	struct rdt_domain	*d;
>   	enum resctrl_event_id	evtid;
>   	bool			first;
> +	int			err;
>   	u64			val;
>   };
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 35eef49954b0..cf35eaf01042 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>   		memset(am, 0, sizeof(*am));
>   }
>   
> -static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
> +int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>   {
> -	u64 val;
> +	u64 msr_val;
>   
>   	/*
>   	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>   	 * are error bits.
>   	 */
>   	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, val);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>   
> -	return val;
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +
> +	return 0;
>   }
>   
>   static bool rmid_dirty(struct rmid_entry *entry)
>   {
> -	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
> +	u64 val = 0;
> +
> +	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
> +		return true;
>   
>   	return val >= resctrl_cqm_threshold;
>   }
> @@ -259,8 +269,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   {
>   	struct rdt_resource *r;
>   	struct rdt_domain *d;
> -	int cpu;
> -	u64 val;
> +	int cpu, err;
> +	u64 val = 0;
>   
>   	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   
> @@ -268,8 +278,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	cpu = get_cpu();
>   	list_for_each_entry(d, &r->domains, list) {
>   		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
> -			if (val <= resctrl_cqm_threshold)
> +			err = resctrl_arch_rmid_read(entry->rmid,
> +						     QOS_L3_OCCUP_EVENT_ID,
> +						     &val);
> +			if (err || val <= resctrl_cqm_threshold)
>   				continue;
>   		}
>   
> @@ -319,15 +331,15 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>   	struct mbm_state *m;
> -	u64 chunks, tval;
> +	u64 chunks, tval = 0;
>   
>   	if (rr->first)
>   		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>   
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
> -		return tval;
> -	}
> +	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
> +	if (rr->err)
> +		return rr->err;
> +
>   	switch (rr->evtid) {
>   	case QOS_L3_OCCUP_EVENT_ID:
>   		rr->val += tval;
> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   		 * Code would never reach here because an invalid
>   		 * event id would fail the __rmid_read.
>   		 */
> -		return RMID_VAL_ERROR;
> +		return -EINVAL;
>   	}
>   

mon_event_count() takes action based on return value of 
__mon_event_count() that I do not think has been taken into account in 
this patch.


>   	if (rr->first) {
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 04f30d80fc67..01bdd8be590b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -218,6 +218,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>   			    u32 closid, enum resctrl_conf_type type);
>   int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>   void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
>   
>   /**
>    * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
> 

Reinette
