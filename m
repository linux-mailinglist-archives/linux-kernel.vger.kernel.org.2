Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC40440FF18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbhIQSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:21:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:41598 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhIQSVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:21:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="209939481"
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="209939481"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 11:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="701357660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2021 11:20:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 17 Sep 2021 11:20:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 17 Sep 2021 11:20:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 17 Sep 2021 11:20:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 17 Sep 2021 11:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc39je3onfPCdnEieXa5cGaGHKnE3ASJUnJr3XDbg/+gdj4yCnz8PWq3kMr5n/KcPka3/NOHBl4Oq2miy3N4TWMzJHCz6Ft5LLtQBrnHCdYS0bTfhiQhJS8J4jmNGCLDJjrSRNOoEA5HKSMqy2gtKf8AIIGsaP877t1YScXle1tarVu1yO0BxIdY3W84jMh0MvsXzvVIVthP6CLwiGpFMD5RVNGOGSDzFCIy40NxifWuD/ZkxK2PdwonyRxAdqbxaDLg97D2QbA/7yky+1Yg1IzKBI0WYVfbgGX0p+gXaGTOqNyO9HrOt3gje4XzqvKjqfdKaiNPkXxzApQHcJZhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RIPjrm21hScsm9YvVyClyQSe09nG907gXzz5+AHGQek=;
 b=nTZNYkxEV/6SddujRL8zRubl1/BVma7rpCYx+PuhlBRa1C76km4igpGAKqWjFXjpb6nG6MUUZ5DfeogKcJGX3mNoUHhbIQ/7f340yobPps6npOTD/eJzBqiOFUhVdKs/wiCf6rWjD2yTisvFlYqIiWpbxD+7JjH4vVvrw+7u9PaPq+tdNmJgqvpX17j/uVOooj/4VE+TbP7AC25AYLmYCgM+Q9DDuTglTlMMy30HjrMV9Y8/RicCx4+fBmSU8PYZ5eNAtWKJdB+wWlJYEbZriZuTrt5BBF7V82NgQ5/gyjWTNd4ESdFR+bLS/SQj5OWVstv7vY71G6uAOUnnoKV7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIPjrm21hScsm9YvVyClyQSe09nG907gXzz5+AHGQek=;
 b=m+EZyTtQVNN/rlNv/hBRTdj3orPFXBu1MDnoCf4g9w69PWEo6AGo9ZyKRSDckoUR5ZDCLxsBQwTb1G+kIbQ8RsJbq8lzehKx8Xf6g82t4vVnRZ8eytn+paucGnIB8n+e8Bf0+axFsbpbFdEQqk9eNGQnrVqX534cwnwaLTIEnbo=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN0PR11MB5743.namprd11.prod.outlook.com (2603:10b6:408:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 18:20:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 18:20:22 +0000
Subject: Re: [PATCH v1 06/20] x86/resctrl: Switch over to the resctrl mbps_val
 list
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
 <20210729223610.29373-7-james.morse@arm.com>
 <5be446b6-d6f6-dacb-4368-7c1e7aedc6cf@intel.com>
 <18228404-0f65-c5f5-4070-7ba256fb9b72@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <b211c9c0-5f4c-75b2-2966-2bc1b848ab31@intel.com>
Date:   Fri, 17 Sep 2021 11:20:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <18228404-0f65-c5f5-4070-7ba256fb9b72@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:300:116::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR07CA0016.namprd07.prod.outlook.com (2603:10b6:300:116::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 18:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e6109e-e739-41c0-b0d9-08d97a07cff2
X-MS-TrafficTypeDiagnostic: BN0PR11MB5743:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR11MB5743C3B157F7DFB1588C0BA3F8DD9@BN0PR11MB5743.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A86Ejq2qWGcyFjkAMN0uZiEuvCAjjAGsUTOyBWGlN7bPcuQ29c8pp2mPAH+l9GhKvO/wy5NrEVtVlaHoRuJCaF/IP8tAwH/52k5EobCVvyzPZrfmKzbsCX6T5ANK9i/9HyHX4svBqF8j0H3V4hBWaXauc3rKaD3wI5OnmmOOmR8C+xUP3YSvovYUfApZWiqPSQ3WcHeb/uXVUweZ+T+s+tuPOZg/PKSLgr+jV3wc2AAjPnMCwDJP0a3fsLhRujBkE1YA/S4cE3WTd99NCcgRBmvPHt4ZsXlcbzyyLCCkUIXPBY7r52ynX+APH9yBI/0+C9DEYJgzN2gsd1cM1lNg27bEsd81zdAnsGULu+yPjOBnFAcTWd+vigT0nTjBAelNCcGcmpNQj0XITq7cbJvmM2CFbV/IezE489QudbfLIar9zkvRuxaQsjg/yV7kv09vjnrNOdVsB2JpparD1PksTswLWzS1dwmccZQhiPtPS5YEDI5+fDrJKzTlFYz1FBbJK6PEm+KvCt1UUkLoOQZPcseCTT/jvwey/+KnkEC2PwONd7VaUvgxU0i7IL13PlkUBo9q5P67lBAKWZK+kEEWzyLD5luOpO4q4O3c8hR4FHGhZi5c7zqvCJ9BjtzRoZNa5t9thWgEwCe91nAS43ft2aPDPdKTKfbTP0a/YVFnZT9wrZRa6RqRFlywd2KY78BroPByH6h0AG858zQmuQmynm52jwUpquRrgFslA3NKgcuIuZXklntcyNtBa9E3U8tM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(7416002)(53546011)(2616005)(186003)(956004)(66556008)(66476007)(8676002)(86362001)(36756003)(44832011)(2906002)(66946007)(4326008)(31696002)(5660300002)(83380400001)(31686004)(508600001)(316002)(16576012)(8936002)(26005)(38100700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjF0Vy84NW1ob0xybEpNWUN3M0UxbVRtR2NodXJoOHRXcC9qc3Rqd2VoWnBm?=
 =?utf-8?B?WE1oblg2elpwRmlVR1dRRThBdkxIRGpiM1JVc25jQXB6aFVmczBpNkMvQ1dT?=
 =?utf-8?B?bEM1ZGFYdFVEd0l6TG4xTEhONlcrdGkvaWFPWWkvMmQ4bExEejJSM2pReDVL?=
 =?utf-8?B?R2lOdGk4L3BIaGlTYzdtaHdyL3NjZm5EUGhDU0pDWlNWcmI0RFJoWkU0dTI0?=
 =?utf-8?B?YXlzOFA2Uzd1TXJ3UFRYS0R0QVNQQnQ1OTZMNWREaVFOSTFxb1NYNndTTXFp?=
 =?utf-8?B?Znh5Y01BNFRJaERNZXFRSCsxUDllbzhERnExZnR0NjMyVENjb1ZsM3ZtbUU0?=
 =?utf-8?B?SS9EbWZDdG5nNFFsdlJoZlRYQXlBMnBLcG5oaWY1N1lqNWxORThNT3pnRXBL?=
 =?utf-8?B?MlA0bk9oQTZyOCtuTlROc1NxY0p6SHlSa0szR0NLdlZHQnBmdCtPeWlOU21a?=
 =?utf-8?B?aUo0V1AxZFRDNm0rODI0WnMxZnluSXRTdE1HVjkxZUNaUkRONHEyaElRVjhm?=
 =?utf-8?B?TG5qblZpYmQ5RTg1ckhXaThuL1psRk9xaDcvZEp5cHB5RE5aRVM0WjZYRDcw?=
 =?utf-8?B?dFEwZm0vTTNqRXhJdkdiejRkRXZpSWpXaUdTZFZCU0xBOGNFSnA4Z2xzOXcy?=
 =?utf-8?B?aXNna0pZQ0dJZFRxOU55cFJVWjJzeVJORE92V0VlRG9QUjRwbWM3ZVJLWWUw?=
 =?utf-8?B?ejFVMjY2R0x4N2tROGJ0eFR2T0QrelREZC9BTUZUUkFtb29EWGVtWENlbHMy?=
 =?utf-8?B?UjR3SW1yUmFQZmlJd1ZjeDhtUXhqM3dPbFRWNWd5MndnNjFTR1JEdE4vcmNu?=
 =?utf-8?B?ZnVjOC80TGRnamFaSmhEaGQrTkhGUFhmc1pWL0ZSeTh2OFNtck5xY1piK1BV?=
 =?utf-8?B?TjZlZjBzeXBIazJQbElqNkQ4TUQxNGFPenp2Ny9ycDAzTzYvVld4SWptYVFy?=
 =?utf-8?B?aTdjSnVXT2RKS0t2dk9kVHFvb3k4OFJqZjR5UjN0S2tqSG1xUVF0ZU10Mm4v?=
 =?utf-8?B?ZEVKY0tmZ0JzSTgxV2lpQ0N6WnNmMmlDbkk3YXpXNWlUVkUzNG5ZTHplcld6?=
 =?utf-8?B?SWYyUmVZUnRZNWJPZ3l3enJNOGZURGNCSXZLRlcrdjFDWHh0Uy9uRVZFQVBC?=
 =?utf-8?B?bUFDcG4wVEswV0hDRytTVHNRU3ZlbCt5MzhqSFVVNUlJbFR5aWExdDNWdmph?=
 =?utf-8?B?eVgrTUV5cUZlM2lpbG1wTXVXRFJuZ091Z0FQVGpsMXoxTEJiSEZRbmFic2d3?=
 =?utf-8?B?NDJTKzJwNHdiVGpLd1hidURtdXk1VURoOGpHZzE2UjFUYTZkM1BWa1cwWkRI?=
 =?utf-8?B?Qm1ndTBxODgwczlvcmJBZEpRV1djcG5WQzJ0cEtNZmc1b3VWL0JqaGc1ZmJh?=
 =?utf-8?B?emRxSExPdFk5bVlqc2VPT3k1b1NmbTB3YXBRZFJpcmdqMzBGOEZiaEdmbFBW?=
 =?utf-8?B?REsrajBVZFpyS2hvdG9RM1hVa0VqdWRJNjd4ejRrNERwcUxGMW0xYTQwTHpo?=
 =?utf-8?B?b3B5NnpaTlVSK3BSb0xYUklhcjkrRW9mN1l3ZjV0MVRpTUFBRlhSbmF5eTZV?=
 =?utf-8?B?YkdEelNyYXp1VUNDNU1SVFhsdGwwZklKRW93TWxaRmlLdUZES2tMbVFOVVY0?=
 =?utf-8?B?VGRkVmw2dWRJUnZDdk1PcEI0ZVJGSHk3K2pjdVRFTnNkOUttK1RObXBiaHZo?=
 =?utf-8?B?dUpiSGFLL2UwR2pydjVDaUNSZlgwWDZZSGlLMjZRaFE2b0dIWjhHeFVpbVZC?=
 =?utf-8?Q?afpRGXUTTV3WgdVgSI8rTyJPjMz+V0f5CngS8AK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e6109e-e739-41c0-b0d9-08d97a07cff2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 18:20:22.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o4ST8s3P+su1zOp4PGMJ1NACefYomqXeYhKxqcILPCVrqmct101xbNJRPa5GTiLjOFCjqO+t5LvatAtk2xV+0uKTWyX1nRSStt1jMamkZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5743
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/17/2021 9:57 AM, James Morse wrote:
> Hi Reinette,
> 
> On 01/09/2021 22:25, Reinette Chatre wrote:
>> On 7/29/2021 3:35 PM, James Morse wrote:
>>> Updates to resctrl's software controller follow the same path as
>>> other configuration updates, but they don't modify the hardware state.
>>> rdtgroup_schemata_write() uses parse_line() and the resource's
>>> ctrlval_parse function to stage the configuration.
>>> resctrl_arch_update_domains() then updates the mbps_val[] array
>>> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
>>> call that would update hardware.
>>>
>>> This complicates the interface between resctrl's filesystem parts
>>> and architecture specific code. It should be possible for mba_sc
>>> to be completely implemented by the filesystem parts of resctrl. This
>>> would allow it to work on a second architecture with no additional code.
>>>
>>> Change parse_bw() to write the configuration value directly to the
>>> mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()
>>> to skip the call to resctrl_arch_update_domains(), meaning all the
>>> mba_sc specific code in resctrl_arch_update_domains() can be removed.
>>> On the read-side, show_doms() and update_mba_bw() are changed to read
>>> the mba_sc[] array from the domain structure. With this,
>>> resctrl_arch_get_config() no longer needs to consider mba_sc resources.
>>>
>>> Change parse_bw() to write these values directly, meaning
>>> rdtgroup_schemata_write() never needs to call update_domains()
>>> for mba_sc resources.
> 
>> The above paragraph seems to contain duplicate information from the paragraph that
>> precedes it.
> 
> Looks like two commit messages got combined. I've removed this, and the below paragraphs
> as its already covered.
> 
> 
>>> Get show_doms() to test is_mba_sc() and retrieve the value
>>> directly, instead of using get_config() for the hardware value.
>>>
>>> This means the arch code's resctrl_arch_get_config() and
>>> resctrl_arch_update_domains() no longer need to be aware of
>>> mba_sc, and we can get rid of the update_mba_bw() code that
>>> reaches into the hw_dom to get the msr value.
> 
>>> @@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>>>          list_for_each_entry(s, &resctrl_schema_all, list) {
>>>            r = s->res;
>>> +
>>> +        /*
>>> +         * Writes to mba_sc resources update the software controller,
>>> +         * not the control msr.
>>> +         */
>>> +        if (is_mba_sc(r))
>>> +            continue;
>>> +
>>
>> A few resources can be updated in a single write to the schemata file. It is thus possible
>> to update the cache allocation resource as well as memory bandwidth allocation in a single
>> write.
> 
> i.e. echo "L3:0=7ff;1=7ff\nMB:0=100;1=50" > schemata

I do not think something like the above would show the issue. If you 
want to test this via the shell you need to use ANSI-C quoting. 
Adjusting what you show to something like:

echo -n $'L3:0=7ff;1=7ff\nMB:0=100;1=50\n'

>> As I understand this change in this scenario all configuration updates will be
>> skipped, not just the memory bandwidth allocation ones.
> 
> The loop is per-schema, so its not a problem for L2/L3. This would only be a problem if
> the is_mba_sc() resource had multiple schema. Only CDP does this, which the MBA controls
> don't support.

The loop iterates through the entire buffer provided to the schemata 
file and the buffer could contain multiple schema. This is more typical 
when interacting with the schemata file with a SDK perhaps.

Reinette
