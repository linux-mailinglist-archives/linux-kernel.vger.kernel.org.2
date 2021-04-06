Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA7355E11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbhDFViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:38:00 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:56704
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230309AbhDFVh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLgWnRWuatcBCnsEswwtKOeT2duRHB24CwvrncEa91gokGZjETOywd7A+oWPweL5JmDuc6yOUG0l3i/afWurjOVHgAToPnLIQvkmJSz11aL35T9E4D2ikbDatKV2ObuYKDI0GOP/8IqBw7FXFYe21hHU1CwevSADMDYD0SoDBccJz2bb+VcxbBsMTQfd1auhy8BV7TX+hLNJIJQNTt6eqQguWSnqJ9kQ23k7EZqGIMi2sUtQNNH8Vs1bQd0P5oTFg5fNY3mOaWqZHr+PJsh4rFqxW2zlQRjfmnekhtXF6DxDn/1fBwhNtBuxxpypqNQsL7yrYV8QDSIahci4jGGEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PhVTCri7Aj8C1z4otN4f5RAs8vTPFVc4d5pzXz4MbE=;
 b=SbleJydNd3Y7ZLB1Hp3DKbfDXlX0a9QYQRK76309m2LkBMfNltChk6272wfl6gfcvhL8cfzSedgtKZyRV3ow3lG9C/YTBp2q7W8DDQPxJLP/kDxQR373GBVGoYew3njaGlYkBn4Z7ezFbsC6B56Mz77EOZDqRYeO5q/RvfVo4emag7TysHk1f8iQIFCJ2f5gW5XowrMiCOh0JAO1oZazeg0/F/KjsTlUEA6NwIqhT9Ozbt8EZaqvMVEuxcvF6OfX5+0lu1jyEFS2gbBdNkebyyudXo6sTdLJicj+wH4+lSXQ6I3e0DGaITOJfYGVXwsYvLnI9li/HtYkM3tzNSf5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PhVTCri7Aj8C1z4otN4f5RAs8vTPFVc4d5pzXz4MbE=;
 b=DNnWRc3sLiRqSZWqODwPBPGRPVP41282VHOv2NuKKsiGDNBrRtoINn/8C4WloX6ASx0ViS6AmKYhQRIjaVV3KT+TJZvLDJPrdRGI0JBkpv32ktBsPXMEvM5+8A+FyqVDJAJAkGYcBCpiGN2IHsfDi3wJi4HcYpKtE8BotlU/p6s=
Authentication-Results: os.amperecomputing.com; dkim=none (message not signed)
 header.d=none;os.amperecomputing.com; dmarc=none action=none
 header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1678.namprd12.prod.outlook.com (2603:10b6:301:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 6 Apr
 2021 21:37:47 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::cbc:a446:67a3:5092]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::cbc:a446:67a3:5092%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 21:37:47 +0000
Subject: Re: [PATCH v2 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <7a6cd831-4a3e-9f2b-b403-9a4d5e1b719d@amd.com>
 <451ec473-8dfa-d2ac-40ef-a4f9bdc23ddc@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <a170dd9d-9c43-4525-9514-d18b3aacb94f@amd.com>
Date:   Tue, 6 Apr 2021 16:37:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <451ec473-8dfa-d2ac-40ef-a4f9bdc23ddc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0401CA0034.namprd04.prod.outlook.com (2603:10b6:803:2a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Tue, 6 Apr 2021 21:37:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 652f9c18-3203-4d76-feb8-08d8f944384c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1678:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1678411B35F045E322F4966F95769@MWHPR12MB1678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BGrcCTEfvHcbCt9O0taNDSW7E2EAIsssoyUH6b6E/KOKjatgj5XskUhyuE/Ee/12R90XqY/b8IKDJ+Jb4VuZR+decHp6zFuxfilk55obwYErIY1De60trW+yIqcxPFu3TtQNfD0MDyTrR4o8DRzMcrK4UtBnz95gYM9vRHPtItAVKS3O6KoLM+bK5PiWB9rAcupBmNnZT2H0wbKa7dlCbQb00ncp2xvIMkUFYqUgIcv4BrcxOWWmNEXIGVLHr5heydT1BVGEPATc3Ym8Z+IeVlHzDz2Xl/nfq2e01zaV+s0qL3PGRlS+avvI9RYrbYiDENPmJOLd/W49sOR1mGc/0665GP9FxtxAOLrWlRxYnoR1cOXliAWHlqLG+VfRD4Gqg2AxDVlq8nFha3zY7qrDIb3BspjKrc+MU9i+lhQvyFAb1G+ANtmhHl0ib+ubuGDP63esChk97A9dfHBYGWEPlNfopGyzL+xF3mI6xPWsKDgVSuquU6dsZ5tkT9y/0a0/x71SyuNwisEp6RGgVGUOoD1kR2ha3LF/3sKLxQYlFhNluGukECaUEGeAz14RPXN5j3mfCKBw4Javzs2A8m30UxW7Gscfkhwkkp8+r0a07guwzgQoa0HJv0SdWsqXyXLHZkEPh0bw3r5z0wSo1lC75fXkSsT9eU9D90ckGh2zJffMIGIVtaJYknNBJR4WoO5kZ0ukn74GIvTAgbndt05e73ki34Nsv9Tyrt7BvlWrGbx4abtyttvJHmHy3vTtEU5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2556.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(2906002)(86362001)(186003)(5660300002)(31686004)(2616005)(8676002)(16526019)(316002)(16576012)(31696002)(53546011)(6486002)(54906003)(26005)(478600001)(66946007)(7416002)(52116002)(4326008)(66556008)(956004)(83380400001)(44832011)(36756003)(38100700001)(66476007)(38350700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UDVXYUxVQUxmM1d4ZXIxMnJPOUpHdmpaekFVa1JkQStpQ1NwM3ZhTDRJU0Y2?=
 =?utf-8?B?VjFlc3U1S0RtMWFyUGxpMU03cDM0enNNUTNFck16Y0MvOWJjMlI2SVBtaVk5?=
 =?utf-8?B?MllyUmh0cnc0UFFEY2JyT1ErV2Myci9YK3lqYThORzBvcGJubEk3WG5GMWYy?=
 =?utf-8?B?NHpjdllUNVQ3YkpHUWc2MUdYQlE2WFBuZVJqUEdaOU42a0dZN2R1TFJkSHdI?=
 =?utf-8?B?N3dIMVZ3S29xSWplWU5pb1hjTXIvRTRwVE9VbVh6dkdUUmNwa0ZRVEFGRmVF?=
 =?utf-8?B?WUlqdm01VzhFTlpzL0VsVGtoNXZGZDEyR3paOFpxTVZ2V2xlVU9rUVpyb3ds?=
 =?utf-8?B?UTJMdFJQT0k0ZnFlS2c1S0xZbjNCUmI3Ny9aaktLUHcyc1JUblZJZzM0NGwx?=
 =?utf-8?B?SUUxUXpWdHNLSEF0Qlpsc2VUdFkyNE92aW9iZEJSWUtUcTRZR3NMWXczUlI1?=
 =?utf-8?B?ZkJOelBFa29ZT1hhWDRvSzFCZThSZ05yMDRCVllidmhyTTRqMmNhMDNRSzR3?=
 =?utf-8?B?MEZJdWpUYStMYzZHTlVoVGhReENxYzJWSnpzUGtIajNDWmVoR1FNd1RTTFV6?=
 =?utf-8?B?RHBsaE81ck95U3Zidm5oTlNQWExrODBwM0E2YjVjMUFRanI1ZDJzQXVBU2xx?=
 =?utf-8?B?MWNxOGJGcjVGZXRPZURBR3lLSDhUSVBPMjhDTlRuRms2SWJnUVAxd2RoRlND?=
 =?utf-8?B?WlVyaFZkdEc3SE9yN1Vvc2Jpaks2Zld0bHA1ZitJQ3VvZ3hidHdpU0M0aVE3?=
 =?utf-8?B?VHlGaTlRZ0cxOWc3ckFCMFIrU1ZJY3Rqbm1Tc2Q0NTl2dlZHK3R6ZHZFQVdv?=
 =?utf-8?B?TW81YXdUTFE0Zm1tc2xkQm40dzVQc0tyRUx5OVNqQ1FTR2dpRThJak5PWlJ3?=
 =?utf-8?B?TlVUbHgycE9uZFNTQWExM1o4b1lKeDc2dnU1VURJUThLTWZLZWZucFhQeXYz?=
 =?utf-8?B?MTRIOWVVMlJzSUZEV3VPR1BGelZjVGM1ZkZKcGdPTXF6aVU0ZmtrbFFjL0pu?=
 =?utf-8?B?Nlh6SW9GeEVRQlQyYi9NeEhsZktTT0dQaW01Wm1DNWtXOUMxa3hNQzJzY0Nk?=
 =?utf-8?B?ZS9IRUEwNmsxNnhEWDBvOG9LNTNVbzE3RkM5MnpiNisyVUo3UEtKQjY3SWdm?=
 =?utf-8?B?QURGMFZrNnB2ZTZsZHBPVVNrcEtMcHNmSVVxWXdKeGt0UlFXRTdsZE92VVRs?=
 =?utf-8?B?VDBFWHB1b3gyTmF0VU82RVA0TTZZNmZkekZ3MmhrUGxmMGFzUW0zOGxpUmZN?=
 =?utf-8?B?NkxQOTZSWTA0QVM2Z1dYNkxzVmVKcGZNbkw1OExrZjU3R2NNM1Q2VDdUV1Bp?=
 =?utf-8?B?UU1xZ2xFVk4rRERkZndZeksrQnZWYlRLcEttUEV0WnVuWkVLSDdNZUo2eE5C?=
 =?utf-8?B?L1p0NHFGdzJJbGlaU1dZZ3M2Y053Y0IzZDdYSTAxTDZQS2RUelk0ZVFlOWlw?=
 =?utf-8?B?QXp4Y3I2MnNXZEtkS3JTbnJ5NTQ4ZktuR3BqeGZyMjZMZDJaa05zZGRWdnpa?=
 =?utf-8?B?ejBVYWcxSnRUZ3NxZFRRTEZGT3JGT0RSdFJiY2lvbDl6UXlQbjcvN2JxZWtS?=
 =?utf-8?B?cTFKTW8wL1hZUWx1UDkxQ2dCQkJLUlgvK0FzbUhYaHQ5eWNVT1pkUjVPNm02?=
 =?utf-8?B?Y2Z4QmtFRUZlQzZiaGtkeGNGQkdna2dGVENENklCUkYybEVZMVhONDNxbVQ4?=
 =?utf-8?B?cU91emJGOFpNWFJzc3lJTnlxcG5qM0tLMllGaCtlaEZZNGhGMjMyV1VTNWZt?=
 =?utf-8?Q?JyB/+aw/WO+NkhWneeqvqvRfKLl84TOUaOXUhqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f9c18-3203-4d76-feb8-08d8f944384c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 21:37:47.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm6gn7pkNsgiBFWt5z7vb7t5i/IsBiuJ+8/D2EUcz6bHAtosw6pJvCt2qEFGn0ZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 12:19 PM, James Morse wrote:
> Hi Babu,
> 
> On 30/03/2021 21:36, Babu Moger wrote:
>> On 3/12/21 11:58 AM, James Morse wrote:
>>> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
>>> behaviour is all contained in the filesystem parts, with a minimum amount
>>> of arch specific code.
>>>
>>> Arm have some CPU support for dividing caches into portions, and
>>> applying bandwidth limits at various points in the SoC. The collective term
>>> for these features is MPAM: Memory Partitioning and Monitoring.
>>>
>>> MPAM is similar enough to Intel RDT, that it should use the defacto linux
>>> interface: resctrl. This filesystem currently lives under arch/x86, and is
>>> tightly coupled to the architecture.
>>> Ultimately, my plan is to split the existing resctrl code up to have an
>>> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
>>> MPAM can be wired up.
>>>
>>> x86 might have two resources with cache controls, (L2 and L3) but has
>>> extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
>>> if CDP is enabled for the corresponding cache.
>>>
>>> MPAM has an equivalent feature to CDP, but its a property of the CPU,
>>> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
>>> its the ABI, but this isn't how the MPAM hardware works. It is entirely
>>> possible that an in-kernel user of MPAM would not be using CDP, whereas
>>> resctrl is.
>>> Pretending L3CODE and L3DATA are entirely separate resources is a neat
>>> trick, but doing this is specific to x86.
>>> Doing this leaves the arch code in control of various parts of the
>>> filesystem ABI: the resources names, and the way the schemata are parsed.
>>> Allowing this stuff to vary between architectures is bad for user space.
>>>
>>> This series collapses the CODE/DATA resources, moving all the user-visible
>>> resctrl ABI into what becomes the filesystem code. CDP becomes the type of
>>> configuration being applied to a cache. This is done by adding a
>>> struct resctrl_schema to the parts of resctrl that will move to fs. This
>>> holds the arch-code resource that is in use for this schema, along with
>>> other properties like the name, and whether the configuration being applied
>>> is CODE/DATA/BOTH.
> 
> 
>> I applied your patches on my AMD box.
> 
> Great! Thanks for taking a look,
> 
> 
>> Seeing some difference in the behavior.
> 
> Ooer,
> 
> 
>> Before these patches.
>>
>> # dmesg |grep -i resctrl
>> [   13.076973] resctrl: L3 allocation detected
>> [   13.087835] resctrl: L3DATA allocation detected
>> [   13.092886] resctrl: L3CODE allocation detected
>> [   13.097936] resctrl: MB allocation detected
>> [   13.102599] resctrl: L3 monitoring detected
>>
>>
>> After the patches.
>>
>> # dmesg |grep -i resctrl
>> [   13.076973] resctrl: L3 allocation detected
>> [   13.097936] resctrl: MB allocation detected
>> [   13.102599] resctrl: L3 monitoring detected
>>
>> You can see that L3DATA and L3CODE disappeared. I think we should keep the
>> behavior same for x86(at least).
> 
> This is the kernel log ... what user-space software is parsing that for an expected value?
> What happens if the resctrl strings have been overwritten by more kernel log?
> 
> I don't think user-space should be relying on this. I'd argue any user-space doing this is
> already broken. Is it just the kernel selftest's filter_dmesg()? It doesn't seem to do
> anything useful
> 
> Whether resctrl is support can be read from /proc/filesystems. CDP is probably a
> try-it-and-see. User-space could parse /proc/cpuinfo, but its probably not a good idea.

Yes. Agree. Looking at the dmesg may no be right way to figure out all the
support details. As a normal practice, I searched for these texts and
noticed difference. That is why I felt it is best to keep those texts same
as before.
> 
> 
> Its easy to fix, but it seems odd that the kernel has to print things for user-space to
> try and parse. (I'd like to point at the user-space software that depends on this)

I dont think there is any software that parses the dmesg for these
details. These are info messages for the developers.

> 
> 
>> I am still not clear why we needed resctrl_conf_type
>>
>> enum resctrl_conf_type {
>>         CDP_BOTH,
>>         CDP_CODE,
>>         CDP_DATA,
>> };
>>
>> Right now, I see all the resources are initialized as CDP_BOTH.
>>
>>  [RDT_RESOURCE_L3] =
>>         {
>>                 .conf_type                      = CDP_BOTH,
>>  [RDT_RESOURCE_L2] =
>>         {
>>                 .conf_type                      = CDP_BOTH,
>>  [RDT_RESOURCE_MBA] =
>>         {
>>                 .conf_type                      = CDP_BOTH,
> 
> Ah, those should have been removed in patch 24. Once all the resources are the same, the
> resource doesn't need to describe what kind it is.
> 
> 
>> If all the resources are CDP_BOTH, then why we need separate CDP_CODE and
>> CDP_DATA?
> 
> The filesystem code for resctrl that will eventually move out of arch/x86 needs to be able
> to describe the type of configuration change being made back to the arch code. The enum
> gets used for that.
> 
> x86 needs this as it affects which MSRs the configuration value is written to.
> 
> 
>> Are these going to be different for ARM?
> 
> Nope. Arm's MPAM ends up emulating CDP with the closid values that get applied to
> transactions.
> 
> 
>> Also initializing RDT_RESOURCE_MBA as CDP_BOTH does not seem right. I dont
>> think there will CDP support in MBA in future.
> 
> Its not code or data, which makes it both. 'BOTH' is more of a 'do nothing special', there
> may be a better name, but I'm not very good at naming things. (any suggestions?)

Do you think CDP_NONE will make some sense?
> 
> 
> Thanks,
> 
> James
> 
