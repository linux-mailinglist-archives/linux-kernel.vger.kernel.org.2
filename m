Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0E3B0975
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhFVPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:49:50 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:2305
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231876AbhFVPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdc0O89IamGcwjAhLMvw00224U32iOHbZwjx5gGZhDc39jxvEx0onhZLcjh3VYh7COiBQEcNPYsaFCyrBJDdiVbn64PaXy+a8igGTNnwLam17LFqD0fuXGdv6xt20BhW1zaTH5u6VVvpWgOrfDn1Empiy5R427OOd24F64gRRzfeuQ+jzUTXHxgjuftUJPb1Uz+XnQ5YAlH50ErLlJvJtp0oROZ+fk2pXUVLrKY/kKvEGROE8tbF9wPHnDbunteBsAe/rRPaCTctWqczNEDMaMvCIgVsPnlZbPEjP9yxpToJJ4CrKZV+m6WzCplY6JurHFzFM6xCfiUtkRsTAXDTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMJPzCl5Yy9aF3QpHYPzF8aPjnvH+SqebXBnPYGWiI8=;
 b=d3X1pxvnJrqcjJzbe1qTlhit+YcwstzQmfgdDH03yxckFxgPueoW83mbqRzDVqjlqixZM68jiytkDPaJcKy7ALuacwwmsHNyTwg7mLT9OmtNCgJpeZ9MI3jqAEBioLQ3NrhWi7nhEvoyybPEEMilOGb6lUzSGBv8izEphzIREfIGbKbo2KqvrPI5557KneopJaFe1V/niwW+Bl4TboZDk0NQoj0I4NIFJoPUBsIN9JiPHnIkS1vAJZKBJO5ZF/ElK5ngj5pgiwQ5t7r+GVf49ahMvBmysmJIA+Bc+ormBbEY/NwcEPR/5TV27rq+9AZwiacbJjuCPdvH8y/9XJf4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMJPzCl5Yy9aF3QpHYPzF8aPjnvH+SqebXBnPYGWiI8=;
 b=bDTPhN0POymBeEIZ+NKZP9VegyIqB0lxoAYLFK1iJAxd+U1up+q8X000SDnUCFj4KcjOeH4GfjnsiDJA3csHoBn77zGIQiEs+//xMR8ifYXbYlfAY2/Hbl/o8TF0yiH/vo4Xpu4b3qG/QS3fQ+ajWHek83hWT0XwFkJcNnDO1IM=
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 15:47:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7%8]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 15:47:29 +0000
Subject: Re: [PATCH v5 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
References: <20210617175820.24037-1-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <13acef27-db86-58f4-844e-7e3fc4f825c9@amd.com>
Date:   Tue, 22 Jun 2021 10:47:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210617175820.24037-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SA0PR11CA0149.namprd11.prod.outlook.com (2603:10b6:806:131::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 15:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd077235-4dae-417b-6cf8-08d935950ac5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4379:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4379C1BA3980DCD79A1DD0F295099@MW3PR12MB4379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzourCquNcwW6sZIaZh/afV+1hK5lL9RddYxxkJSs7flrQWGz9pwMUUZGMscumUCkCtlzZUmxtRkWe2cqi0H07m/OTk96p4YsWA+j83ENuFp9VckUfXTIt0xJIRbOuqo0wTAAbk4wfW4bU4fPIM4/Vq0WcMR/mhHyykvvmiQczvKP4+joBdlb4f8ExrrNEpJzzQA5TamXUEvXxIw7/8qP52gz1XRJcl8xJTShLibMN6x22+9K6hy42BNPA5kjPTFC0tya7vAdHy5DD65EeFMqvOycgE0VEPpKmgNiykdBYtsTIxPcTEBhZSUXE+YyDIJjtLQUT2H+X21HHxbxFkJGeIxxJ69eJZQYlbgfMacZd5ATECIJBXLNe1Xy3c3c3HipU2OgYzKEJngcyfYwzQzoqXPR3tUWK2AJo6BDftJoqx6AenvVvrZ7qcctH9+rPQ3xGbG30T4a1xWdde7TVLo7wUI5MksFe/6q79m2poejFNaCa9dN60gact+BL9I+oqA5rvn7lkNZPqERq0o7qVEwO1rZ61Bts4E6wL4PzVSEZEuOGylGN1AI6xth/Ei8hiko5oFIpzspcTGaHuDexl8AAIJI7tfjm4sKD/FY2mqbVmIsalxvqkSJ23Xr39c4acr3pDi5B5xEZSGe7wijDlKE2C5sdKlI84YYRqENJ/x4zUqgiO/fcTJAhgFjDwjNdHMDi8AWSbglpUjCqdBO/TpcUTWGT6ouV0IbThAFb/RS5ZiBzlzN7oGUwN7lqDhjJSEp0g/r0GZBxQYPz/n1E2a+tq3rJZfD8hKOi60WApCVZCSNdIz4sLHnhpdxtKeSt7FLe6RCQzFDvofcicVUyFeJEt5lDh+HoyhZ5KLPselcHGHYFYjbHRKS+YwXj1nSlcN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(16576012)(54906003)(316002)(6486002)(8676002)(38350700002)(956004)(4326008)(36756003)(2616005)(31686004)(66476007)(66946007)(83380400001)(44832011)(26005)(7416002)(8936002)(38100700002)(186003)(478600001)(966005)(16526019)(6666004)(66556008)(52116002)(31696002)(5660300002)(53546011)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBnbjJxTy9hMmhQQi9MM0pBSlNoTkNtVjFBSnNzRTAvRlFCQldXK2lvQ1d3?=
 =?utf-8?B?MkIxYVFEeFc4cnorTlRha08rMmJ6bDFaalIzNnNER0hmNVZaeVJJcW0zM0ty?=
 =?utf-8?B?U0xpV1doNzZBZU1HMCtRQmY1Tyt0OHVMaDRiRGVSNnJCT2lxYmMvcUdnYVp3?=
 =?utf-8?B?OENsaUx0NUZ2OGtuTjM4Ky91OTNIVk1BL2xnckZXcm9ONnJCbFVHZHhqOEI2?=
 =?utf-8?B?Y2xhbHdXMWVqN3pLMU0wWWhRbWEreExMdW5mTDdIaTZWYjNpUkdpN29LRk80?=
 =?utf-8?B?ZnVBWE9YallnZEh6NmJ2bXpGMllla01IL3M0MGwxNFFGWG9kNTlNNERWQlRW?=
 =?utf-8?B?MzVLbFgzeHdHaExRV3FSY0lxazA3amY1YjFueG1kcTRyd0FsWjNMQXJVV1hX?=
 =?utf-8?B?T1RNNWxrRVNjaGZlYzdzWmFKSG1iYW0rNkFMaHVCSFluNG96Mm9ZWDdXbFpx?=
 =?utf-8?B?Rk5Iam9PMForQ3dVUHNnUmpkUlJCaHp5dkJwQ3kzZ21wMFhCTEJuUExnQWNN?=
 =?utf-8?B?UUZxUFlCYzc0RzFXVFpKQjVRRXFBTHRNdTkzOUNsV3dCWFI5bFRvTmwvY3hk?=
 =?utf-8?B?RU9UTGpTWjZGeEh2aE56SmNCWlo2Q0NDV2FFaUhaclBnZExhYWs1MkRaTWI3?=
 =?utf-8?B?MHR4dkpET0l5YkNWSWRoT3ZkR2VPUmZRTWZLakFGendEc2lBamhwQkFZTU5v?=
 =?utf-8?B?cC9FYjFEdnd4b05kMFVIbFhJempIa2EzcVB0RmllSzhxU2xFc3lVc0kvKy96?=
 =?utf-8?B?RVJCMTArT0k2Yyt3emIzcy91UndZMGUvNStjNENpSFJmNEZBOWxsWUVFWUV1?=
 =?utf-8?B?SVoxUHJLbWlxZ0NBbnFGWkswbTdaUWw4bWtZTDloeDRTWGF2K0xVazlCd2ZZ?=
 =?utf-8?B?M2tCZFczdDRZVi9aYWlkaHhCMGZFQnMwaVhNMXJHUXYzVHRwV010SUh0TlZs?=
 =?utf-8?B?Q0hlQzlnU0d2V3RwUk1tdVVOOExuaFlLZHZjcjI2a3ZOUHJwbGpnN2pNVFFT?=
 =?utf-8?B?Y1JkaGdNOWIweGppTnhXUU94ZjlTTHZDMWRNT0NWNTNGRjUrK2l5MU8zcGEr?=
 =?utf-8?B?czA3OG5wdTNGYmFreFRJalozNjdZRlJ0RER0UHU2K3A3Mmt5aEkwL3czNjE3?=
 =?utf-8?B?RnM2OHAyNXp2OGNUVUcwQndqU01UcXhtYXVzQmZyZW5GTEVvM25wSUZXazcv?=
 =?utf-8?B?enBhdkNGbkg2cy8vbXlVbEUrTXFkSElPNGw3a1ZjSHFMTEFWbFF4Q2NTZmxk?=
 =?utf-8?B?T05QSlVoZTk5dHRwRmFWNm9DT1pnTXNoWHp2RzBSajB0U3cyN2hYQW15eVJp?=
 =?utf-8?B?bVcvZlg4enNjV3ZtakYzOUNEN0RrWnVjYll6OFlSMzkzbGR2K1J0Y3R5R2hV?=
 =?utf-8?B?WS9VTW1BanZ5TWxzVW8wSlk1RVNQd1NYdlFvMHNQeVhGcXdZbUFYR2NlVTlY?=
 =?utf-8?B?QlZGSVZxakxKK1U2elFNZWd5ZGZQcDNkNGdCYldablVocWZmcTNWRkJrWEJn?=
 =?utf-8?B?ZDlFOUkrd3ptQVl5elhFRWJIR05VcGRPdHAzRnprV0RwQm5FN1dnaitsMm00?=
 =?utf-8?B?TU1XTGFTeW04Rno5TUlWMFhFS2JLcnJBTy8rNDcySUJ0WU8zUUw3R2JGZGhk?=
 =?utf-8?B?dFYxMjJLZWxTYmlwUDBiOHl0Qkx5SlU3ZXhtQ0o2WDU3ZjJOOHgxOGJFeHhk?=
 =?utf-8?B?U29zV0JHTmUzcXcyalg1Uzh4RzZDQnFGZW5ZNXVnVFlvcExIanRRdythVzFB?=
 =?utf-8?Q?OQIQbPIcdhKQ9B1XCreLBdfGdMH68zyjz6tdq/X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd077235-4dae-417b-6cf8-08d935950ac5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:47:29.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gcf6UY3PQQgl4iKGzQIWwNQhni02zK0hnFnT75oSwuGTpQItkS+FbsfsK3RTHhNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James, Thanks for taking care comments.

Tested on AMD box. Everything looks good. Thanks

Tested-by: Babu Moger <babu.moger@amd.com>

On 6/17/21 12:57 PM, James Morse wrote:
> Hi folks,
> 
> Changes since v4? Padding in the schemata file, typos and variable name
> changes. The schemata file padding is to ensure that if CDP is supported
> but not enabled, the file looks like this:
> | root@resctrl-cdp-v5:~# cat /sys/fs/resctrl/schemata
> |    MB:0=100;1=100
> |    L3:0=7ff;1=7ff
> 
> Changes are noted in each patch.
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
> 
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
> A side effect of merging these resources, is their names are no longer printed
> in the kernel log at boot. e.g:
> | resctrl: L3 allocation detected
> | resctrl: MB allocation detected
> | resctrl: L3 monitoring detected
> would previously have had extra entries for 'L3CODE' and 'L3DATA'.
> User-space cannot rely on this to discover CDP support, as the kernel log may
> be inaccessible, may have been overwritten by newer messages, and because
> parsing the kernel log is a bad idea.
> 
> This series is based on tip/master's commit eb7f1579243, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v5
> 
> v4: https://lore.kernel.org/lkml/20210614200941.12383-1-james.morse@arm.com/
> v3: https://lore.kernel.org/lkml/20210519162424.27654-1-james.morse@arm.com/
> v2: https://lore.kernel.org/lkml/20210312175849.8327-1-james.morse@arm.com/
> v1: https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Parts were previously posted as an RFC here:
> https://lore.kernel.org/lkml/20200214182947.39194-1-james.morse@arm.com/
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
>   x86/resctrl: Add a helper to read/set the CDP configuration
>   x86/resctrl: Move the schemata names into struct resctrl_schema
>   x86/resctrl: Group staged configuration into a separate struct
>   x86/resctrl: Allow different CODE/DATA configurations to be staged
>   x86/resctrl: Rename update_domains() resctrl_arch_update_domains()
>   x86/resctrl: Add a helper to read a closid's configuration
>   x86/resctrl: Pass configuration type to resctrl_arch_get_config()
>   x86/resctrl: Make ctrlval arrays the same size
>   x86/resctrl: Apply offset correction when config is staged
>   x86/resctrl: Calculate the index from the configuration type
>   x86/resctrl: Merge the ctrl_val arrays
>   x86/resctrl: Remove rdt_cdp_peer_get()
>   x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range
>   x86/resctrl: Merge the CDP resources
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 276 ++++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 164 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    | 232 ++++-------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  44 ++-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  12 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 457 ++++++++++++----------
>  include/linux/resctrl.h                   | 185 +++++++++
>  7 files changed, 776 insertions(+), 594 deletions(-)
> 
