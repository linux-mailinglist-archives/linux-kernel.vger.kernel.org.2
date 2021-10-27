Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97243D307
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbhJ0UoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:44:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:3334 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbhJ0UoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:44:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293723409"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="293723409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="723521137"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2021 13:41:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 13:41:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 13:41:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 13:41:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 27 Oct 2021 13:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyZYfgyLbd1PtKxEPn/IERA/MtLPidKJCjmZx2ujIdl7rueGKdws2dI/VzexudOUzX15h8D8Yoj6H/L09mo1gbetIbBH9rRSbyJJXFw+2EbcZLOsMRtj9+PUWTdk5co/b2sgqM5JorSyqqgY6Z3J21eU0uLiTseosKDC3gbNm0ZS+CViGHn9mZx1naDHwlgN6rrE6XQf6krVpecGKqLng/zqMAeKGW/fbXepHALfV7co452FhB08mFoMnpUeLwYaDAiovpUilOH0htaIlc7N9BYhCF9Da7MdCqIW2TBtlrUBiw8+xZBpENxEs79yHkj4ryScqnvnY6poKyMbJyAuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf4vta9Z12jl/yX668ZsIyH2Sp6xYiQnEp3JgwHaF5Q=;
 b=JZxuyWrT12boucupzI3Of7FQVJvGmjoJIAmmwas3Lkn4LHfbMJGAtGN/sJXgKU8wkf7g4zpp1L2gjqhhhOoksXEuErJ0ETvv9In9XQftZ/Y/dRF8DrHN+YBv4jkkGxha1pvr+IjEBnIoxukBGHQ00UiJR1ntYrEweVXmF5sdxQPgmedCbUj8G5ugZulN+Wu/Y6LH6OdlLPSMrHKTVoyGU5IycMQL8zYZoO5sx8nxA3Iz3xtOjtxgeq5O8kymDvgF021flMAKNQdRzFv6jeZtVl/AFPs7HxmMKta1lAB1nkc5tsGtHX+WzSyQo1ntecxc4TumZ1Qtvu6tdAL2kBvFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf4vta9Z12jl/yX668ZsIyH2Sp6xYiQnEp3JgwHaF5Q=;
 b=OVBquGFEuCpPXrRVcieLRm7RSfzbNtub3yDhEMcvWS0B16CqTnpd44p/LU6AjzWJzdT1xpxRuNqkNEqCsbG4eR0uef8Ua11RRlbB61W5TyqHP8yV1tgl9rYhIhgFtLbLHbHTUuqj8IfkyVT58DDJ6OGl9dHdUDb30pF3dGGitoc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3923.namprd11.prod.outlook.com (2603:10b6:405:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 20:41:52 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 20:41:52 +0000
Message-ID: <ecc4420f-5a28-cf1f-2537-b651a31e6db3@intel.com>
Date:   Wed, 27 Oct 2021 13:41:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.1
Subject: Re: [PATCH v2 14/23] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
Content-Language: en-US
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
 <091863be-f15c-18cf-9f1e-1f447f216098@intel.com>
 <f59842eb-887d-4134-c913-75376bc35fd4@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f59842eb-887d-4134-c913-75376bc35fd4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:104:5::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO2PR04CA0183.namprd04.prod.outlook.com (2603:10b6:104:5::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 20:41:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3554584b-9c82-4e0e-4c95-08d9998a34a0
X-MS-TrafficTypeDiagnostic: BN6PR11MB3923:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB3923628765708502A20BC7A2F8859@BN6PR11MB3923.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inH0OBeeFocsEG4Y9rKLY70Olygjsly+P3HAjBKdH2b7WpgHogaSedOzhOIe9rbYvu0Ixlwq2+eSvZrKYQb+0xK7P/B9F6ZenrMWtwdmKe9ZqTQ98ntJiW1Juvoo6OFwRGCMeNIgyXbd147FXZ8NsMpMqVtR2ZAgxHZufKb8N7ztGxL1mAdds6j1MVpTXAzW/iU78OWhHlnLS4xwOAuYg6OTTZ7/RIRSWL8BebIpYpEdwUT1i5EcLcUpA1GVQ0mq+SC83eYa9z5h9op7okj3otcwNojOgiwqmrZaSRbeMVBoKIA+H+JiIG3o+0ZQBMZrF8IXEaGPCgZWtxXq7qixbDaJ2v6h7Jx3iR270ZmnDLwU30Hoef4D1XpPIWqXocaHOyAprl/Dv/rqpLnxbBvAVifp9R3dYReONMVuy1W1QtXnFvH+h9B1obXJZIoDRLD4EvIVg8bo/lgxv0jJR1Z+dizCM6tgTirHbGFqwLWmKcPx5q8j3e3CR5X0iVdBJ5qRwDVoLw4eO3WU1nkWybGmGjpQvg/oaPyrgJjICGARhjuvUaMhATDkY8YG2DbszED9ZjWp9pXPc0hIC20I6c2YqRvUTnjbPBVwxebvt+lLxP2yZBgzpzd4tDNgP4L804fTbVsQUSrxjqWLKXLABynjD72mGEjNUf1Ii1bGN+TV0WobdKOFA2ELs4pln4027CPte+dch3lYRi5V81BK7MemtXJ6G3BdcBTaQnFXS0tbaoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(956004)(2616005)(7416002)(44832011)(186003)(36756003)(8936002)(508600001)(8676002)(26005)(66476007)(31696002)(83380400001)(2906002)(54906003)(4326008)(16576012)(31686004)(6486002)(53546011)(82960400001)(66946007)(86362001)(66556008)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNiNHVHUVFxNmdOcWF1eTBnUldWME5ITWEwMzQ4NFZWcGQyQXlhYW5Ob1gr?=
 =?utf-8?B?bnNmZVZuRm1aZ2R0R01qMUprMmQ0M3ExSFN3NktDVGgzTFNBaERWdzVFYjhT?=
 =?utf-8?B?YW4xSzlZckg0WlltYzl4YVUxT1NRdWdmL1RwSHgyQ0JnaEhabXN1T0hCbTRG?=
 =?utf-8?B?eDJxaU10VWhualcyYnBhZlhBbmc2V3E1U216V3c4MTR3dlVab0ZsTXh6K0Fs?=
 =?utf-8?B?QzVCalVndnk3bnhyRE9sbU5CYzkwSE5nZFMxeGxLQWo2Y0RSREZyRGo1Si9x?=
 =?utf-8?B?a2M3cWFjVkxxZzNjRWNhbkR5Zk5VeUwvdm1HZ0hWWU5DNFJ0amRvcEdzOVdm?=
 =?utf-8?B?YTlxVE13L0dleDlFd2pRNXdTcW9VV3FpUUhsSU1COUo4UzM1M0Y4L1FxWjlZ?=
 =?utf-8?B?TElnWTNubW1ZL0dDYkt1OHA0dDdLdmlDQzV1R05sK01TS2cxVDMxd3pUYWw4?=
 =?utf-8?B?QnYvT0ZmZDB4T0xlVklkVjlxYU55VEpBemNSVzNKOThvTTVkS1M2a3lkazhV?=
 =?utf-8?B?d05oaUhmbStSd3VIWUxJbVhwRXFTb1JyZGdiZXEvdEhwRkFEcG1yajdkclRQ?=
 =?utf-8?B?UE1tZmdnNUkwVWcvOE5BcmNKQ1hjMjlSWU9pbk8yVG5wdzl1K2RpU25lMWgv?=
 =?utf-8?B?L1VJRDBQcENFZEk5UTN4M01PcnNvbzBJYXFIM21ERU1TMFRDcTRVNGF6aUZ5?=
 =?utf-8?B?blNWZmpWMERnZVNCbmxzK2NJaENXczZYa2laYlVrdjl3MGhTUzJvZEN0ZjRo?=
 =?utf-8?B?RDNYd05HVnlldDVNUVNXM0hhTUU1QnIvc043aDU3N2hoWFV2WTVxaWFrbmhp?=
 =?utf-8?B?ZG56blpsWVc3VUpEM3ppWXJ0VWR0ZnppbjJWWjBvTnhTOEZaUGtNWGJZSW5U?=
 =?utf-8?B?Q2RuK2FqV3F5NzRodFZkTG1ESVlIeUdDcUdBbm1ObTRrRTJtRGxSVXRqRlE3?=
 =?utf-8?B?Zk00ekNGWXN3aE82aXRISjZMRC8rOEdVT0x1VTczcndPVTJxYzFsTGt6R1Bk?=
 =?utf-8?B?SFptZWhkU3NqZmVNWUhpZFA0S2VHeUZRd3VpbldGaVJTZXhxOEpQakRWNmZo?=
 =?utf-8?B?WC9VMFlDN1RVRWE0QmtBMEx6RlJHV0VyRnRRRkhMTmswTVppZEFMc2xzVUYv?=
 =?utf-8?B?Y3dOTjdRV0VsL2txK2FZbkdxc2ZIZ3g2T0dSRk5LcmdId2dUZFd2NDNWMktr?=
 =?utf-8?B?STgrRHhZcUJZa0NENXBpSVNRTkVsMFR5TUtHV21HbVdyalhiL2t2R3FzZnc0?=
 =?utf-8?B?Uzd5c1MyN0Y4WitQd2ZkUFk3QzBudW12OXNPRXl6cytLQlduN2d4MmxscG5i?=
 =?utf-8?B?WkplWnlYcmNPUFliVTJpdkpIcUtTNi9EZ3lOSjdSMlBvTXhOMDQ5dmxJeFBY?=
 =?utf-8?B?Rll0ZXZrTGRLZ0RjL2ZjU3IrdHJiVlcydi83aWNxTm1sMTI3MXIyTkhUSDI0?=
 =?utf-8?B?ek5qSmJpMFk5QnRwcEVCcEhPOEY2MVZkSTlHQUQ4OFdPcmFZbVhhUVV5WExD?=
 =?utf-8?B?RTZEclFjcmxrSTB3UUxFUGlSYU1YNFJ6dnJjbGplUGNmbG50b3h5SmRZYzVD?=
 =?utf-8?B?c1FJdFh1dEtXUFFZZEtpSyswR0tDK1VDMjFaRXNWL2w3Sk5JVWp2dFJCVFQ5?=
 =?utf-8?B?TS9zLytDYjAwZTJuZnZwTkRpY3dSNlNkelZJRTJyMmhzM1JRcXFzNUhLMlJn?=
 =?utf-8?B?dGZPQnIwanFvcXhhUU1BR0Q5UDh4cDdUWGZUSTdkZzJXaE5STDk5U1ROQ2RO?=
 =?utf-8?B?NG9kMldoZHBRazRWQmdrR01qMXB3eC91TkY4QlBpbkZKZHhwMFl3T0szMVg5?=
 =?utf-8?B?djJ3UzhBRG40TFpuWDVCVEhhMDRxNVBBVEw3U0NLZWNxek92R3dpK1JtMXd5?=
 =?utf-8?B?RE5Cdjl0ck40QldoMi9acjZMWTkzN2lCVmNFZ0xQMHJmRURhRmVzQVdXRE1E?=
 =?utf-8?B?U0RnMDAySnl5YVlLaHRxMGtZcmpocms1Vm5yd3E4eWZqRzFQcTFoL0FjdU1L?=
 =?utf-8?B?eExSSGdHaTJLWlBRbUJKNjg5S3BFUE5jVkFMNFNCOVdxcCtLUmx2cU42LzZn?=
 =?utf-8?B?SEFueFNoNGpHVXlKc3RRT2s2UVorSm1XL0l2eEM1Ui9IRnNlMDh5aGszWE92?=
 =?utf-8?B?ck80SDZER2lUZ0lxUXkvSVFVTzYyT05seGtIVHFvanVLckRZU1RpR3YxRXZs?=
 =?utf-8?B?VG9LMU9CS0ZXVUtzVzJCb0MydGl3NldCQitmcnVWRDAxK0xQMDdsSnRKV1hj?=
 =?utf-8?B?TVJhczVkOU81L1VPamRvVWV2eVRBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3554584b-9c82-4e0e-4c95-08d9998a34a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 20:41:51.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNaPkyBrDsCrWyONqKeYwJe1uo7kXXQczj3XpRqnJjph7k13g+ZLgh9NmUxUJrBg5vDXhaThzsFVUbRNVjDM/GqrH7gMgQhVphUMn8/uqOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3923
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/27/2021 9:50 AM, James Morse wrote:
> On 15/10/2021 23:28, Reinette Chatre wrote:
>> On 10/1/2021 9:02 AM, James Morse wrote:
>>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>>> second. It reads the hardware register, calculates the bandwidth and
>>> updates m->prev_bw_msr which is used to hold the previous hardware register
>>> value.
>>>
>>> Operating directly on hardware register values makes it difficult to make
>>> this code architecture independent, so that it can be moved to /fs/,
>>> making the mba_sc feature something resctrl supports with no additional
>>> support from the architecture.
>>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>>> register using __mon_event_count().
>>
>> Looking back I think 06c5fe9b12dd ("x86/resctrl: Fix incorrect local bandwidth when mba_sc
>> is enabled") may explain how the code ended up the way it is.
>>
>>> Change mbm_bw_count() to use the current chunks value from
>>> __mon_event_count() to calculate bandwidth. This means it no longer
>>> operates on hardware register values.
>>
>> ok ... so could the patch just do this as it is stated here? The way it is implemented is
>> very complicated and hard (for me) to verify the correctness (more below).
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 6c8226987dd6..a1232462db14 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> 
>>>    static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>>>    {
>>>        struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>>>        struct mbm_state *m = &rr->d->mbm_local[rmid];
>>> -    u64 tval, cur_bw, chunks;
>>> +    u64 cur_bw, chunks, cur_chunks;
>>>    -    tval = __rmid_read(rmid, rr->evtid);
>>> -    if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
>>> -        return;
>>> +    cur_chunks = rr->val;
>>> +    chunks = cur_chunks - m->prev_bw_chunks;
>>> +    m->prev_bw_chunks = cur_chunks;
>>>    -    chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
>>> -    cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
>>> +    cur_bw = (chunks * hw_res->mon_scale) >> 20;
> 
>> I find this quite confusing. What if a new m->prev_chunks is introduced instead and
>> initialized in __mon_event_count() to the value of chunks, and then here in mbm_bw_count
>> it could just retrieve it (chunks = m->prev_chunks).
> 
> (I agree the diff is noisy, it may be easier as a new function as this is a replacement
> not a transform of the existing function)
> 
> __mon_event_count() can also be triggered by user-space reading the file, so any of its
> 'prev' values should be ignored, as they aren't updated on the 1-second timer needed to
> get this in MB/s.

The resource group's mutex is taken before __mon_event_count() is called 
via user-space or via the overflow handler so I think that 
mbm_bw_count() can assume that the prev values are from the 
__mon_event_count() called just before it.

> __mon_event_count()'s chunks values hasn't been through get_corrected_mbm_count(), so it
> would need to be rr->val, which is what this code starts with for the "number of chunks
> ever read by this counter".

The value could be corrected in mbm_bw_count(), no?

> 
> 
> The variable 'chunks' has been used too much here, so its lost its meaning. How about:
> |	current_chunk_count = rr->val;
> |	delta_counter = current_chunk_count - m->prev_chunk_count;
> |	cur_bw = (delta_counter * hw_res->mon_scale) >> 20;
> |
> |	m->prev_chunk_count = current_chunk_count;
> 
> 
> The 'delta_counter' step was previously hidden in mbm_overflow_count(), which also had to
> do with overflow of the hardware counter. Because a previously sanitised value is being
> used, the hardware counters resolution doesn't need to be considered.
> (which helps make mba_sc architecture independent)

This is the part that is not obvious to me: is the difference between 
the two individually sanitized measurements the same as sanitizing the 
difference between the two measurements?

Reinette
