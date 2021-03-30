Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2318934F251
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhC3UhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:37:23 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:18527
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232286AbhC3Ug6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb9oRn2m9f+SBD552DJwnUDTCHINaHb9RHB499ik17jIXuXbkBMT3FGWZt8OLDuGzy+bkBc76VmJRcv791i21gUXrtKBMoNLMcQCNI9/At50smmNpFG0KISEEL+HkHwtCVkY9cBs5k1cObB0gHcck9iKwakPVsRH/8ghSpsWO3lfmrHYLHMxQOcO6zlGsN1PcUGHdLlQQ9Lf5rtk7dH+pho01Wt8ELXpWe8ecHyDLAj9UW9CIaitiu6en5dk7UH5uSLoi3/XhxSVBtjIabno2Ca+sVpzYUc+iBzyV4se4cETP19EFy+j+8HoMiAyo6dPMeVwaXpDj47Mdz1ydVLPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yht8HtJek+Z4IIJO3/UaAbXuaa7Vw1dkGx+j+L1EGmI=;
 b=iFSI2zAHWri+6t5UBvt1Mu/qe9Qqq/F7of9vJFoO5+UFXwTHKQVp7/eKc1dCvWFeYQm4pFixM7cguoVihGFW/v3tzFprKTUf204ifbAgfX8R3pHS10OJVQzZGLjzbsJFmsVxpwT0lK8nGvQ3QphQWGYvrXq4e+xQRTavNKxotk68YBAuIlPVhZVVmCqS2SnaHjeCmdikWLNRouAsxUIgqWWGamcTgGDubepAFWHMxrIzNSFGDge+qs8SZjbiufwJJPRaQExK35qB4306WnaTpywDKsmGqoKhz9xBTfoqTp+NiUAZyHM4tkaI93r2l1jVfMv3NjUInKKhivj5dzSDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yht8HtJek+Z4IIJO3/UaAbXuaa7Vw1dkGx+j+L1EGmI=;
 b=kulvZ3nyTtv58+kF0eAQOMke8Wrbb3k1uoO+1LFR9wrKo8xQy4LgNBdW0xQ0DCq0tAs6eraeMKMbc1//nhbI+TcVV5zZ8qmcCegxav+KP8o4G8a+ZuItLAEOWDdMU1GCYbMGC94G1dvmCnRgrDGR6gYDlL8iMLcYgGhFJOQrp/U=
Authentication-Results: os.amperecomputing.com; dkim=none (message not signed)
 header.d=none;os.amperecomputing.com; dmarc=none action=none
 header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 20:36:57 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::487b:ba17:eef5:c8eb]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::487b:ba17:eef5:c8eb%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 20:36:56 +0000
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
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <7a6cd831-4a3e-9f2b-b403-9a4d5e1b719d@amd.com>
Date:   Tue, 30 Mar 2021 15:36:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:802:20::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN1PR12CA0060.namprd12.prod.outlook.com (2603:10b6:802:20::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 20:36:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2344768b-6890-4e7a-062f-08d8f3bb8f9a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4558:
X-Microsoft-Antispam-PRVS: <SA0PR12MB455866712284B1484224DFA0957D9@SA0PR12MB4558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rS5u90zYHFe60Zh3MzlZ74Nr9iw8PIhDQLx3e29hpDfrTzx4Cjeh8vmZWMaYwZi8L7xeKhBG0thaBmFEPeIvSfW6KuP9b6HNy36+ttIrLWqHDCEaetfWq8taHsA/umduFW+6b/5j/cmXWIsNYjMjnH7saGj4u/oIjJJAZcdqoElC3vsTJq8ncxMQc39zFOJAGVbsyfaCGf1sY6Bnvcuz5DNieZqBFQjgQGu85mgKP9bvsjtz77doHkBH4PzvT5IxIN1wQLp8R7zpDK01lKvgCtpH6U1LYdlmD1yHpgFeKwwjs6OV4D0xoOP68F5haTslEBKK7unvwvSSyWhsAmYNXgFWNQGIDb9x7BZwm1d2fieOH+8GpDq0GOLSj8Lc4NZXwNUUf72Agr+5HCEshw364w1b4Uay7BP7TVE19u4XaSp4BzqNYSxmg8xdVf1JAZBb0w12Xu1m9HP7qDEMN3oqfu8f2hGB1S4/RU/UyN3afWzUapNsEXhqlxV2FkuYn3qde3e+iK9sPzNy/ZWHriB1UNxXcURA5yAORkZEtFSkiXcNbMAtYzye1fw+eqWPbuH5iIHVmLsIloYRKFXt9xoX8G38FlgUWKIn2XGW/CyZawb3ZUtIpdUzvMTQztVJJ+UvTI/L0+ENs9xRhZpB3THZ8wh4uGzzX05YU7DdanwqtduV/o2cZyDWYl92Fddr7KhBoHcqkDmno3zzpOC8s50B718YXJs72UoeM0hi0wp4TAdYK0o6iEexXJ3LRVw6jfTsoKZUoPYaoh9+SVdK2hkDdM+KMccS6hhQtyXf99/1R7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(2616005)(38100700001)(956004)(186003)(16526019)(7416002)(31696002)(83380400001)(31686004)(26005)(8676002)(16576012)(4326008)(5660300002)(52116002)(54906003)(6486002)(66476007)(966005)(316002)(478600001)(36756003)(66946007)(53546011)(66556008)(8936002)(44832011)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEdwUEVlL1hlelJabjJIK0F1d1hjaTQ4YUdlbDhYWmhsWXdHVmtNKzdabGpU?=
 =?utf-8?B?K3AwdEVERjBIbFJKeXpwc1hLR1h3VnRMUHZENVRWWDRxcjVJSEFGd3BWZ2ht?=
 =?utf-8?B?ZkV0VUlTV3p6RkpGejE5dEtDUUErK2M5cmJPOVlDSFY1Y2Fhbnl5b2Q0QlZW?=
 =?utf-8?B?c0d0VUpVaDdFamdvek1mMXJRczBzSGR4V2xjeXVsd3FQMWVjbllQRG1oMHQy?=
 =?utf-8?B?cVhYQVVldnEzWnFNRmtwUEk5WGZSbjFycGZBQzNHRHo2dXlwNTNWcUZ6SkRi?=
 =?utf-8?B?KzViQlBsd1V2Ny9IRjZkS0ovL3g1a2F4MlVvZndwc0FMOUh6WXJGQ1JSY2w4?=
 =?utf-8?B?VGdqSytQUnJhb21CYXpGV0JYVW5VVS9zQVRjYlRDUkxlclFndWtuN3krdW1B?=
 =?utf-8?B?SERBSVJvSG9WUUhkcUY1aDNuai9nV2hhU1YzbXBYbVg0bkxUOUxmQ3IxenM0?=
 =?utf-8?B?RGh4WHZEanVJcGFnRWdRSjJkdXFaZjRMNTh0ekFJUkd2MEd3QTU4RG02OFVr?=
 =?utf-8?B?aFhhd3dGbkg2aUc0TnFlZlp2dkxFUEs4dWdLQTZvNDA0bU5VQnlwZmJGcEJO?=
 =?utf-8?B?dDZRbko0Z24wQ0F0bzBwMXk5MFpVL283c2k3b2tENnpSeGxKWGI0OUlKUG95?=
 =?utf-8?B?RGlFYUFXRXg5bFhHSk9FaUk4Nm5IeG5aYVJXU3R5d1pTM2prdUw0U3hpZXNr?=
 =?utf-8?B?Yll4SCtIY0w2MlJnY1ZwaURDRm85SU1Lcm9wb1VyYWZYRTlQM1lqcEozUjgx?=
 =?utf-8?B?aFlJa2k2R1VtMDZoMjRLcFdqZlJsZytVVDFNYktvK25OZEhrY1hNdGlpSm5s?=
 =?utf-8?B?UHNrQUJocUpac0xKQStqNndVSnlVaGRsUk52UkQ0WnkzWkZtMlpyRjBKOEp0?=
 =?utf-8?B?N0huNW9yN1FjS244UjNNSkNJQkJOS3E5Yzh4ODRLTC9laW4yTFMyZHk5d3gx?=
 =?utf-8?B?bzFNSzRmZmZhRDgwSUh1R0NDa3J6QS92Y2YybTBPRzFoQ2g4UEZvS3pnRkJp?=
 =?utf-8?B?NFVmaXZzeVpTMGozdGpJR0FaUXBubUx0TG1nNkZwUVR6OEI0STBteDhOenlQ?=
 =?utf-8?B?V0VrNTBjOU5qeWJEd0RUWTltcXZtU0c3Z0tMaTk1ZjRDK3VONXBqNmxlTEpo?=
 =?utf-8?B?cm1EYUcxbzd6SzBIYTZsa1FEOUQyUk1qUXUxeEpWMVlyQjhyT0MyTXNRSTFt?=
 =?utf-8?B?UGl0TXpsMkNHdjFjdFUrc3dTRURoTE1zbnBsR0pEV1JzQW45cWg5TSt2NTIy?=
 =?utf-8?B?SmpyeUJNenRJOFBWcmYxNDl3RTM5WkZteENUVGY2QVVxRTRSNVBHR3dBYlYz?=
 =?utf-8?B?bk56dDJlUGt3MktIKytLQTR1WlhKVkVhc1pmNzdWLy96UzErdzUyWEdGVVJr?=
 =?utf-8?B?VENycS9CeGdNY0hrbzZzeThWQzZlRllyQTVaMk9xV3BMb2xzRTRIWFNjTnl4?=
 =?utf-8?B?RTliY0QyOVV5c3huSXpZVCs3WjFWS0c1ekp6d3RlZnFHOGUyTjBGd1JaN1hU?=
 =?utf-8?B?Z01HdVdyM2tFMmVSZFA1Z3VwVlJpVGRDejNWdzd6Sk5CMzVCQ3Y2UldQSGcw?=
 =?utf-8?B?VVdPZ1NmQVR6ay9vUHhOOG8raTdlVEZzN3A2R2lJeERFOTU5N1VSK1ZzREtU?=
 =?utf-8?B?OXF5ZWFHSmVvRXJHdnJtc0ZldjhmbjZDdmxjOFhrRHNnTXhHaXhkWG5hZXho?=
 =?utf-8?B?N3F3UFpBL2NGOStkckVmN2sxc0dCYTZUSlpyOTFKU3owT3YxbWhzMEw5TXJz?=
 =?utf-8?Q?ZsCHsiiPDpt5osdVRbbIsMfraFlDYDt1G34ofOl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2344768b-6890-4e7a-062f-08d8f3bb8f9a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 20:36:56.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92rsMONhhdwDLR+LvubJdFpODAXqf9Go/Kkq1KoZbOY9tyInPrlqT2fWQqjjP/dp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
Thanks for the patches. Few comments below.

On 3/12/21 11:58 AM, James Morse wrote:
> Hi folks,
> 
> Thanks to Reinette and Jamie for the comments on v1. Major changes in v2 are
> to keep the closid in resctrl_arch_update_domains(), eliminating one patch,
> splitting another that was making two sorts of change, and to re-order the
> first few patches. See each patches changelog for more.
> ----
> 
> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
> behaviour is all contained in the filesystem parts, with a minimum amount
> of arch specific code.
> 
> Arm have some CPU support for dividing caches into portions, and
> applying bandwidth limits at various points in the SoC. The collective term
> for these features is MPAM: Memory Partitioning and Monitoring.
> 
> MPAM is similar enough to Intel RDT, that it should use the defacto linux
> interface: resctrl. This filesystem currently lives under arch/x86, and is
> tightly coupled to the architecture.
> Ultimately, my plan is to split the existing resctrl code up to have an
> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
> MPAM can be wired up.
> 
> x86 might have two resources with cache controls, (L2 and L3) but has
> extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
> if CDP is enabled for the corresponding cache.
> 
> MPAM has an equivalent feature to CDP, but its a property of the CPU,
> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
> its the ABI, but this isn't how the MPAM hardware works. It is entirely
> possible that an in-kernel user of MPAM would not be using CDP, whereas
> resctrl is.
> Pretending L3CODE and L3DATA are entirely separate resources is a neat
> trick, but doing this is specific to x86.
> Doing this leaves the arch code in control of various parts of the
> filesystem ABI: the resources names, and the way the schemata are parsed.
> Allowing this stuff to vary between architectures is bad for user space.
> 
> This series collapses the CODE/DATA resources, moving all the user-visible
> resctrl ABI into what becomes the filesystem code. CDP becomes the type of
> configuration being applied to a cache. This is done by adding a
> struct resctrl_schema to the parts of resctrl that will move to fs. This
> holds the arch-code resource that is in use for this schema, along with
> other properties like the name, and whether the configuration being applied
> is CODE/DATA/BOTH.

I applied your patches on my AMD box. Seeing some difference in the behavior.

Before these patches.

# dmesg |grep -i resctrl
[   13.076973] resctrl: L3 allocation detected
[   13.087835] resctrl: L3DATA allocation detected
[   13.092886] resctrl: L3CODE allocation detected
[   13.097936] resctrl: MB allocation detected
[   13.102599] resctrl: L3 monitoring detected


After the patches.

# dmesg |grep -i resctrl
[   13.076973] resctrl: L3 allocation detected
[   13.097936] resctrl: MB allocation detected
[   13.102599] resctrl: L3 monitoring detected

You can see that L3DATA and L3CODE disappeared. I think we should keep the
behavior same for x86(at least).



I am still not clear why we needed resctrl_conf_type

enum resctrl_conf_type {
        CDP_BOTH,
        CDP_CODE,
        CDP_DATA,
};

Right now, I see all the resources are initialized as CDP_BOTH.

 [RDT_RESOURCE_L3] =
        {
                .conf_type                      = CDP_BOTH,
 [RDT_RESOURCE_L2] =
        {
                .conf_type                      = CDP_BOTH,
 [RDT_RESOURCE_MBA] =
        {
                .conf_type                      = CDP_BOTH,

If all the resources are CDP_BOTH, then why we need separate CDP_CODE and
CDP_DATA? Are these going to be different for ARM?

Also initializing RDT_RESOURCE_MBA as CDP_BOTH does not seem right. I dont
think there will CDP support in MBA in future.



> 
> This lets us fold the extra resources out of the arch code so that they
> don't need to be duplicated if the equivalent feature to CDP is missing, or
> implemented in a different way.
> 
> 
> The first two patches split the resource and domain structs to have an
> arch specific 'hw' portion, and the rest that is visible to resctrl.
> Future series massage the resctrl code so there are no accesses to 'hw'
> structures in the parts of resctrl that will move to fs, providing helpers
> where necessary.
> 
> This series adds temporary scaffolding, which it removes a few patches
> later. This is to allow things like the ctrlval arrays and resources to be
> merged separately, which should make is easier to bisect. These things
> are marked temporary, and should all be gone by the end of the series.
> 
> This series is a little rough around the monitors, would a fake
> struct resctrl_schema for the monitors simplify things, or be a source
> of bugs?
> 
> This series is based on v5.12-rc2, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v2
> 
> v1 was posted here:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Parts were previously posted as an RFC here:
> https://lore.kernel.org/lkml/20200214182947.39194-1-james.morse@arm.com/
> 
> 
> Thanks,
> 
> James Morse (24):
>   x86/resctrl: Split struct rdt_resource
>   x86/resctrl: Split struct rdt_domain
>   x86/resctrl: Add a separate schema list for resctrl
>   x86/resctrl: Pass the schema in info dir's private pointer
>   x86/resctrl: Label the resources with their configuration type
>   x86/resctrl: Walk the resctrl schema list instead of an arch list
>   x86/resctrl: Store the effective num_closid in the schema
>   x86/resctrl: Add resctrl_arch_get_num_closid()
>   x86/resctrl: Pass the schema to resctrl filesystem functions
>   x86/resctrl: Swizzle rdt_resource and resctrl_schema in
>     pseudo_lock_region
>   x86/resctrl: Move the schemata names into struct resctrl_schema
>   x86/resctrl: Group staged configuration into a separate struct
>   x86/resctrl: Allow different CODE/DATA configurations to be staged
>   x86/resctrl: Rename update_domains() resctrl_arch_update_domains()
>   x86/resctrl: Add a helper to read a closid's configuration
>   x86/resctrl: Add a helper to read/set the CDP configuration
>   x86/resctrl: Use cdp_enabled in rdt_domain_reconfigure_cdp()
>   x86/resctrl: Pass configuration type to resctrl_arch_get_config()
>   x86/resctrl: Make ctrlval arrays the same size
>   x86/resctrl: Apply offset correction when config is staged
>   x86/resctrl: Calculate the index from the configuration type
>   x86/resctrl: Merge the ctrl_val arrays
>   x86/resctrl: Remove rdt_cdp_peer_get()
>   x86/resctrl: Merge the CDP resources
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 272 +++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 164 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    | 218 +++--------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  44 ++-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  12 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 447 ++++++++++++----------
>  include/linux/resctrl.h                   | 176 +++++++++
>  7 files changed, 741 insertions(+), 592 deletions(-)
> 
