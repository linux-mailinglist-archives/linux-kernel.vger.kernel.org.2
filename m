Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85A742FE23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbhJOWbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:31:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:9595 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235693AbhJOWbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:31:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="228278625"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="228278625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481859718"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 15:29:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:29:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhAyyP9Ono7Exf72xUZJgfU6js1q+jAgDlJLogvPKUPjAmMLzCUqykIp3zZg2o6XacWRo5WMaG1k44E8yY9pZmG5H5uBM8rLwyQWk5N2gPLWbI9yblbFew1fIoRllgcfybsc9E46YIVqxCDi6BzYmtHN7jz7MlODgqVBmT1seCsa45FNVwsGpr2euDPkRtR3f398eNFu9TcZOS74VENKiWOAEoN0X8yfDztWiCppzO+70iVck80i0/86S3z0vALIre6LdXCBf2NDzsxjP4GGlYNIYr1vTd3Ia1GvuwEEYP7oJTr4IhE+XtK5fv3jDLzFqAdsdiP5kl1sEIsaOmPdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5+vLo0AlXDILh3Rd7pJrzH4FXKb9x7b3AGRP87RU1I=;
 b=cuWCJ3eyjnMJWRmoAvqVoEg6tuhs9I2A614efmLSmcfvWJhbu/TA1XzDMiQNg8LvVYOx88nShygo/f4iWL3ItyMxL/t3mEcHQEDoaIU3J34Kr9vk6ThHjjWmvOuBxLjjKzUu6LCZNWbsviEuAQEvuHoCDhZMzZLMEuDABzO8GtK7KzyEbYuUaaxtteHpIGnTbeNfWV+emooGFmFl2KsW1p5bPt+GIOoMOok3dijL7431mNXTLptlalns96jvHH+z90ol2n+2Bum0UXjYKuxPdzwlgdsYQ6+rQB8bslZXMn9qBNWnOaVinkp+0zGYGGka3VvVidQOaE5fPGIfh36jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5+vLo0AlXDILh3Rd7pJrzH4FXKb9x7b3AGRP87RU1I=;
 b=gNcSmzURmNdz4I76QACeBmjAMes/XUvGtBDyrDgmGmuZeDsOIFd1PZTz1OPomV+KWbWn5T7QhhdJzlgjR7JKYNMJmKcmR9cifQxEXPRIm20Jo/ZfoSqhwHrhV9HxWoJXHG1gzscbD+FzSb/oA9k3Ol/22SmHXkDDF+yEm4Ge5lI=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:28:54 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:28:54 +0000
Subject: Re: [PATCH v2 14/23] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
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
 <20211001160302.31189-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <091863be-f15c-18cf-9f1e-1f447f216098@intel.com>
Date:   Fri, 15 Oct 2021 15:28:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-15-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 22:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f68fb27f-b352-40a9-21bf-08d9902b2b6b
X-MS-TrafficTypeDiagnostic: BN9PR11MB5291:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB529182BAE755AEA6CE4FEAAAF8B99@BN9PR11MB5291.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xKTz2uXfeJozvsCxPDrBaGKsLJn6Lv+y9UaZInRspg1eaoUyBUux7A1Lj9NPMRsSGglQ/RpfSMUiPYIP7CANy7LNKCvR0lxv4qte2Y3B7Lp81kZXrIH8wuudLCwVdK1OceeoLhM39Xhtiu3TrrlEnibHEKX/UMA/yLAAYXmXS/DqPIhOA0t1HqDmI0u9WLyJtZQ5Xg9g5aMXCjSzu8xl7UWEPWHyKtRtqXhwu6cUw8JHZxZrCWeufZi8rwd0tKyMiTx3NBcYjJB/cExglgRfuwsXsjTOK4pgkOfY3PON4m7HKgYNLSwwf/YZDjQ12spnsJbP3AjX7tuR9BfkWKs0avn4Iqr+ilcQzmOCAmA70itEUtZig6tPyMca7U03jQIJQtXseJkNcnrS2AiqPML0VZcTf/AqRp8mcSueSmb1h7255xu0hX5wqTrbWnTvPdbrKHm9reCQXlOMOBPylgyXt6Np5TqTunNK0RUBEATseo1DrkmGxj3HZnCYb6g8uvgr4KpQzb9B6qniahzRFiNy6Aschn+Qv7f5OZqZzTQoIvs7lBrrv+Ye7MMFxXTJ/HuHNSVB07MNG7Sj+NIBx77j//WnqgdtjQ1WIBG3HqwKuXR8eUvWn5IOqWOnDJxLzhDMtR0csTH6ID0bPOmWANr4DzvhkT/EYIUa+cWzn+ecLEyygkEmXs4M9Z9BfPmhzsF8Gjk8Z9T/HlL2KVAlCcXQfZzQbMcrfAC0gkCkVCIZHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(31696002)(44832011)(54906003)(8936002)(38100700002)(2616005)(956004)(2906002)(66556008)(508600001)(16576012)(6486002)(31686004)(316002)(7416002)(83380400001)(8676002)(53546011)(66476007)(36756003)(4326008)(82960400001)(5660300002)(86362001)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNwM084Y0dQUW5mTHBVcVNFNTFPdlhkdjVFYW1YTkcxNFcwVkhnY2NVZWV6?=
 =?utf-8?B?Z3hEaFlhUGJpZ0s0Z3d3OWVHUFVjaEMzWEVHRVRqUjVtQXNCMSs0R2QwQzBT?=
 =?utf-8?B?VXVjTFBFKzNZSlcwMjk2RG9mVTV6L1drWFB5TVNMRytyT1kzVkFBS0VRRlhD?=
 =?utf-8?B?Y0RWNEVSUy9hYjRUZUhqY2luQTNtQkdvRFVNYW5uazI1WGlicjNlRlhCRHFq?=
 =?utf-8?B?ZFo3MDFyUk9VMEZhRUdCNU5qU2hMRklJR3ZkUW8vSmcvSE9SNWNQZmVpcWpZ?=
 =?utf-8?B?RTBNR0VjUFlndDBOTlgxMUZqSkYwMkZGRktEc0FmNXZoSHhLbmhIUklZaUth?=
 =?utf-8?B?dHpuVmRlRXprbWk0cTJpbXBMaEpxNEo5YktOZ011UHhkNnpBK05aRkVKVXRK?=
 =?utf-8?B?aDRnb2NzcFlEUlpsWlZEUnJhNzNOV051WjNuT09KMitVM0hSbzBrRzU4WGp1?=
 =?utf-8?B?ZDUzcldRN0h0VFFUR1BFZTJublhSYzdmKzFJSURYeFBLVTkyMTJyTWVMSXpZ?=
 =?utf-8?B?N2VXbG9MMDlnN0ZDNUhLR0VQRDBxNkExUDdXME5aS2VqRGRuRTlSN3A5WWFC?=
 =?utf-8?B?TDBWODZBZUN4TW9jS0h1b0lSWTVHSERuczF6NXpvd3RzRVVkYWF0K3VURWlC?=
 =?utf-8?B?eHpWeTA0VHNIcDd6SE93WmduYjlsZW1vLzZEYzl3enRsZ2w1bG1odW1PelMw?=
 =?utf-8?B?bDVBNjVHQ01hL2doV2d6RjFaa25pdm1xeWlEdnc4Wnc2N3Z6Z2UwSGloNGxn?=
 =?utf-8?B?SmtYTC9SSmUxazJmM0hsMnZRUk85K1J1bEtWVkJZM2l1SUk2RUQzYTc0UUN6?=
 =?utf-8?B?OFFlZXNvbzN5ODFDb1hHdE92Uk1oUUdnNDBTSlZabU5TVFJETjVlZStuMC9s?=
 =?utf-8?B?WWNvbU1zTTFvRHV5bGNuckVCaVRyWm9PVmZmK1FhV3JjRm1rTjloUjlMNTVm?=
 =?utf-8?B?MER1Z1Z0VXFadW5GMUFSVFh6U3pGZ3hEK0hTcDBRWGhuQ2lmMStLRXdjMFVT?=
 =?utf-8?B?VEgvNUxVK1RiSHNNVWlLa3ZtVXFHZ0RoU0xFUFZFaExvaER2a2VBQmRjRnl0?=
 =?utf-8?B?MCtrL3h2MWFIbnpIL0IyaGZXUHFYUHZER1dMRUUrN3JOUEdBajluUXZSNkpq?=
 =?utf-8?B?akN4WVlXekRqUndmSmsvVkN5YUNpbCtoeUh4T2lIdldyS3VlMDRoK0hKZGwr?=
 =?utf-8?B?Nnp4VmlhLzZYVnVwVnVFY3hrb1N1K1ZjazlDRzF6NWdyNEs0YUdPbVZGbjk4?=
 =?utf-8?B?Y2dBNVd0NXIwK1lpekNkdkhOeDY5cEpjME55VmFSY3RyQXhFUnpQVDl5TlNG?=
 =?utf-8?B?YWZzZDYrbVRlZ3VIMzcwSTlhVCtXSW55SHRpemVZRnFFYzlXRlRtekcrbkJm?=
 =?utf-8?B?N0YyVUI1RnhLdU0wRGFHRWRVc005UC9GWEZyU1dGL2UzNUtueFI3U2ErMktq?=
 =?utf-8?B?alhUZlBwVGRITGpDSnZ6Rk9DZHNiK2d4ODFkTEtrYTVyVU1EbGdhZzRzbFdI?=
 =?utf-8?B?L0hYTDdaL1k3bzZsSmF5dm1OWlNuTDFMVkNtRE5ua0c3QlpFdENFaE0vVVZ0?=
 =?utf-8?B?dFNYbzF2NjduZXhvU2hXNitjSUVIN25ycWwxL3NSNmJvMHdIWTV6dngyMFQ1?=
 =?utf-8?B?NjJMNC9MM1J1NEMzZUhvNHd2R25pL0h3SmFwdFd0Tzk5ZXNrZGM2RW4wWkhG?=
 =?utf-8?B?SUgrY0FoM3Zvc1N4NUdhTVN4UGM3VWZiT2RRaHp6V24vYVZGQWZ2QkRFUzEw?=
 =?utf-8?Q?4CnVk93vFwH3IR5Rmzx4pZr8RKgHUH5rP3iT2uz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68fb27f-b352-40a9-21bf-08d9902b2b6b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:28:53.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIJ34eBZy/mhLac85G5frz9k+hkGrxko8ZUdi3vVxy7zpD5DatqtN5NNIytLyxDAgSjnZK8HzrkDX5m1b8NlL294PMq/B2B9Il4pIPFo6eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
> second. It reads the hardware register, calculates the bandwidth and
> updates m->prev_bw_msr which is used to hold the previous hardware register
> value.
> 
> Operating directly on hardware register values makes it difficult to make
> this code architecture independent, so that it can be moved to /fs/,
> making the mba_sc feature something resctrl supports with no additional
> support from the architecture.
> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
> register using __mon_event_count().

Looking back I think 06c5fe9b12dd ("x86/resctrl: Fix incorrect local 
bandwidth when mba_sc is enabled") may explain how the code ended up the 
way it is.

> Change mbm_bw_count() to use the current chunks value from
> __mon_event_count() to calculate bandwidth. This means it no longer
> operates on hardware register values.

ok ... so could the patch just do this as it is stated here? The way it 
is implemented is very complicated and hard (for me) to verify the 
correctness (more below).

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * This patch was rewritten
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++---------
>   2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 1b07e49564cf..0a5721e1cc07 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -289,7 +289,7 @@ struct rftype {
>    * struct mbm_state - status for each MBM counter in each domain
>    * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
>    * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
> - * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
> + * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
>    * @prev_bw:	The most recent bandwidth in MBps
>    * @delta_bw:	Difference between the current and previous bandwidth
>    * @delta_comp:	Indicates whether to compute the delta_bw
> @@ -297,7 +297,7 @@ struct rftype {
>   struct mbm_state {
>   	u64	chunks;
>   	u64	prev_msr;
> -	u64	prev_bw_msr;
> +	u64	prev_bw_chunks;
>   	u32	prev_bw;
>   	u32	delta_bw;
>   	bool	delta_comp;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 6c8226987dd6..a1232462db14 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   
>   	if (rr->first) {
>   		memset(m, 0, sizeof(struct mbm_state));
> -		m->prev_bw_msr = m->prev_msr = tval;
> +		m->prev_msr = tval;
>   		return 0;
>   	}
>   
> @@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   }
>   
>   /*
> + * mbm_bw_count() - Update bw count from values previously read by
> + *		    __mon_event_count().
> + * @rmid:	The rmid used to identify the cached mbm_state.
> + * @rr:		The struct rmid_read populated by __mon_event_count().
> + *
>    * Supporting function to calculate the memory bandwidth
> - * and delta bandwidth in MBps.
> + * and delta bandwidth in MBps. The chunks value previously read by
> + * __mon_event_count() is compared with the chunks value from the previous
> + * invocation. This must be called oncer per second to maintain values in MBps.
>    */
>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>   	struct mbm_state *m = &rr->d->mbm_local[rmid];
> -	u64 tval, cur_bw, chunks;
> +	u64 cur_bw, chunks, cur_chunks;
>   
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
> -		return;
> +	cur_chunks = rr->val;
> +	chunks = cur_chunks - m->prev_bw_chunks;
> +	m->prev_bw_chunks = cur_chunks;
>   
> -	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
> -	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
> +	cur_bw = (chunks * hw_res->mon_scale) >> 20;

I find this quite confusing. What if a new m->prev_chunks is introduced 
instead and initialized in __mon_event_count() to the value of chunks, 
and then here in mbm_bw_count it could just retrieve it (chunks = 
m->prev_chunks).

>   
>   	if (m->delta_comp)
>   		m->delta_bw = abs(cur_bw - m->prev_bw);
>   	m->delta_comp = false;
>   	m->prev_bw = cur_bw;
> -	m->prev_bw_msr = tval;
>   }
>   
>   /*
> @@ -509,6 +514,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   	rr.first = false;
>   	rr.r = r;
>   	rr.d = d;
> +	rr.val = 0;
>   
>   	/*
>   	 * This is protected from concurrent reads from user
> 

Reinette
