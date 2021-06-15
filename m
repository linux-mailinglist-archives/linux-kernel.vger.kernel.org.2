Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D63A881C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFORxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:53:07 -0400
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:57633
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230322AbhFORxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEsavKHiRB3yyxudOniSzgOotznM8VbEIjgygBJnwN1Rx8IQrL5C9lZkTqeoofBmA2GSrK/+jbPIGjXOI4SnX/nWgiy49kplnzTe4RMBvfZ6B7OxHQ2SAresp5Ne5R702wh2QCQvTwTiJlWRSEJBfdpUhcdD3iZsWz1eLHQW7IB7i6A+FSD7w3LhekLATICBy//yB6lpPJIXWYgzDrJJwBrFM7+xPbfVLTU/EIyflS1N6uyTI1xQVIk8t14oW3fdS9qus6v70gQlLNLhGt8DkV2ghsUqN67gsELeNV5pkRmVwqAYM7Na1sQzyUuzApgkqx4yQKd30D+4K5DbutxHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49qsxuHpZe3/auS6KX1rPVrc9jgVDQxrc+4m0w/4B5Q=;
 b=UVDtUnQsxOlXdEHFlYN9lPFwUjlr5ia+8E2STIogHB0K6dKHDcMLvcgRKYP+Hn5yqHYiUySQ7ni04d9suMx/e56OgUyOLc58Nu9lTCGhs1WIyADD57iTLdQBe9ENt30oJRcz1jirZr2z9SxkVc+gWbSxkNNE1ZLy89XsLE9KUlTpJT3tgQtlrxZrqRAeKKUl5ubCDXDbS+cvCdVyb+nSbj8IUbg+ZmTitWuKtHYc+91XBjlRIE36OBfEeNBVFefkiYbWynFvbXRkTOOW1JgIkFca5+ROFvhSg5G5uQPj0/YjP+M0AotBty4aBDpniYZrwrqEWC8ZtjR2mgjhyN8w2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49qsxuHpZe3/auS6KX1rPVrc9jgVDQxrc+4m0w/4B5Q=;
 b=Fwj7ajuJZYdm7pfp8y1uP8VrPOcijLvLN7AwpGh5XaA1nB0eqZG1kiMrwCYU1PPqJyka9mI/zmhXx80bAYck6hWbt0NiarhFBm3UfqrDCQqjdLQ4tImC1XNtn+XBPY/PDIvjO66EPfMrUHA2Y+XcLbOxxviiE/oX7NX7zwnaqBo=
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 17:50:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7%8]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 17:50:59 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 00/24] x86/resctrl: Merge the CDP resources
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
References: <20210614200941.12383-1-james.morse@arm.com>
Message-ID: <18859c3b-a060-5358-a4cd-2a0081b3442c@amd.com>
Date:   Tue, 15 Jun 2021 12:50:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210614200941.12383-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 17:50:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96821835-21bc-4ca0-60f4-08d930262279
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2524:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2524784962C88E173A6668A995309@MWHPR1201MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKgkreXVhVsTuTANFiLzKPkTssAjgIbIhtaPGNfm73e25y3fwsOhghGklbDMMFQ+FKoUZF3j5bVNrzCU1DJ/iZiK4ikZ9OWw35Q1sFNMmHwIrsdxsn1l6dFsNCOlI78ZWl2vRUHvfule26mxN0IH7gqNDuIH1CsgWpQqDdb6bNlbpOsTpPmA4J9yL4VQ582W2tUMO0NVC+1a9lO/RU6H7RdCMh+68oDHqXcaUkelLokZJ7n6/rI29zTeTaoYhbhBAq2KnzXMza4qi79Ym+iTWA/k4PFdeFpf+cWjlkxr8esvr4fQY19xK3g5yhBdri4RvA3BIMXlcW0sGjds6y/1jMCz4HQYFSER1kkLa320oy2ASyEGiV4GTcYHl6Ik/UOhnUaqkJBgUjuvMMFs5iAZHzGQueizWTmlTKNBZ5nJDR8DtTHVuH8rMijZfyCPZD9In7HWEEEBEmj9SqVkXqhwiPPm7z3Oyn+n8GVmkka6yfhfN2TA+/UjbdmP2gwIc86QdgGfxqSM/RVwwmpyqstTItd2FEncZFpZv3krK83EUjZHpL1cSHuFlGWvgEJqmOwmH7tbbghfDLzwc0e5wfapnisD1pWxHipxIZCcQiZ5PLxSoOueHtKPYt4K+ZLL9hA1gK6ru/B8pX+AbS9oZpIlhNJ6flgpa2DyIcfSq43CZe03LHNt5xf1m4ZzIKxZnDACLOEzFi0e7NGOaVlAN75UoSHGV5gmV+vJjyQIuARk5P06GrW3QGrVtqij17B2ntdfH3tXWMTwIJyqGOM7uis6b9OMfuiMQQSRpWnf0Zld3IqJ7FMXWeLYIkRjEyz3OWLDo2t1TA5mJO8tS3h7JTnNX9QgAppIg0OKQWnWNsWHB7AKJYJ1v6uIlwzJL6YJeneI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(26005)(53546011)(44832011)(6486002)(86362001)(956004)(4326008)(8676002)(2616005)(186003)(52116002)(16526019)(31686004)(36756003)(16576012)(316002)(31696002)(2906002)(5660300002)(38100700002)(38350700002)(83380400001)(66556008)(478600001)(966005)(54906003)(66476007)(66946007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZ0cEM4TVYrYlp6bWJ6Y3J5OEcvRXE5QnN1ekNOZzd1SmFPRnF4cHlZK0ti?=
 =?utf-8?B?bnptL1JiWDNsVjZwazJGa2tIUkpicEJVNy9pVXJMRysyTUY4bFI0WDlwWDcr?=
 =?utf-8?B?ZnhYYkFpVms0MlQzdkRLU0tjZ0piQ2VObzZTaU0rdkFXdjVsVTVYZzBjOWpm?=
 =?utf-8?B?eWNIUUFCVFFoaGRuVk55MXZoV2dZOXZIS3hKRmxoVDRqTzRBWENrbG9hVHpF?=
 =?utf-8?B?YmZEMStrVFJ3R0xLTUdZL1hXb3pvRFdiNnFFTXM5MU5ZR0RUNHBid1doUk5m?=
 =?utf-8?B?WnliY3FCUzFIOG04NElwWitkVzJ4bzM0T2NZcXZrYnpHRS80VG14L254OC9y?=
 =?utf-8?B?UTRIOUc3SjFuTVl6YWlzNjJaLzl5c1JMT29uSk9aRnpxajhHZEpEZkswTFps?=
 =?utf-8?B?SDFMTEtBTlN5RE9VcmVpSmJVU2FxaTJRQ0lmVkNabTFtcEhnakpSM2FvQ1RK?=
 =?utf-8?B?UzBBaTBlcFBwMVM0SlQxWFNPb3lMNXV1b1dnMDVSODRrZnUvVDNSTWY3UVJh?=
 =?utf-8?B?WWxxcGVmcldsbzlRUWR4ZVlXTFFmNmJhYTJ6amlDdkxqZjEyN29EbVg3b05C?=
 =?utf-8?B?NmpKam9nS0FZWUt4dm1aZmo1alpibm9UZFlhK2ZLY3hqRXJWWk55a012T2Nh?=
 =?utf-8?B?ZWxOWDhCNUUzV1JuU3A1QzZwSTRwSTAwTlVjZklKQWVhQjRQRXhqQmJVZHlv?=
 =?utf-8?B?dkx0QnFNRE1nM2ZXZ0ZibzhVVUZPUC9mQVNMU2lYV3BNdlM4UHFhRXhIYkZI?=
 =?utf-8?B?TDFNU0xlSEVoelFpYWN5MXJYVGxuRFdTNy9yakxtdGU1OG9ySFNRSzdZMy9L?=
 =?utf-8?B?RVFNWmhUbkREb2hWckdBc2VRTkZML3pybWhGVk1sUjBuZmFQTkxWSUdqNk0x?=
 =?utf-8?B?TUFxc0pBamhRTXRCZFY1Rm5HczNObkhNSVRxNzFFazZHcEdiTFkwc3dRcTVy?=
 =?utf-8?B?aUJ2T3dycWhVWDQ3TFRpaVpJTjJHTkZFeURTSTVteVM5dGhwdWZob1NiMTdI?=
 =?utf-8?B?ZWQrR25WZ3dXdWdXMFdLUW1XaDlieE1iR2dhSGc5WlJzaUk4dTIxOVpwNDFX?=
 =?utf-8?B?WHBKZ2hYNlo5aXhmME1aYnVlUWFoWFM5REJIZ2o0ZTNuR1U3N3o2a2xFR0FW?=
 =?utf-8?B?UHpOK0xEUE1oM3hOQWp4NjRCM1hpa0RzSUN2MVZYZVRoaE5oNm1zY2QyU1Q4?=
 =?utf-8?B?ODdWckZGVFUzMGpYUGk2c0srQ0dwZVJaTWlLa2ZpQy9lTUVEcXgrbzB2NkVC?=
 =?utf-8?B?VitNcUNhT2lGc3E3dnY3cEROVkExNmpac0xjSThhenpBRmpVNmJwQlEwd1J2?=
 =?utf-8?B?RVAyWlhzWWJzU284U05yQVZqSkN3bWxnVmZ5Qm4yaVN4YnNUUFV3dS8wTlZy?=
 =?utf-8?B?OUhRVVdXdWlIbTU3QTVMblY4UzYxUWtxWkxWS1RmVUZsVnNWZVpRVDMxQ0xs?=
 =?utf-8?B?SElYNmFvUVlGV09hUW1valdncVRRSTFwSW1oeUpacE5sK0ZrMjIxYzRWSUkx?=
 =?utf-8?B?UVhVVnFHRkZCVkJMS210LzBHc0Z0S1lNU2hTdHFkUGhkZXdDZFZrZFpvWnEw?=
 =?utf-8?B?U2lEblpkV1pobTdEQnpZbkxZZFJrQmVscDJxNlVhbTBNazFLdXUrWGlGcFF0?=
 =?utf-8?B?ZjZ2ODZ5OTVDUGFyK1lYdVQ5bXBwSGxSN1doZUFpVk52aFhNRFBOclhMaFVm?=
 =?utf-8?B?ZjVsRlh5bXNxb29PU3NQeUk1MGpOQUQyN25EN2tZb1dUUXFlcGdxZWZhUDQ4?=
 =?utf-8?Q?C7+hDdFRfzi8blzCXovTQclaooBUP2e9hn+hqZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96821835-21bc-4ca0-60f4-08d930262279
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 17:50:59.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv9ttmBDoOm+7sKRr3sS7UEgcDpUUTOsonm+R9IxQH9OF9FvzhZU2dO488Dzsp8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
Thanks for the patches. Sanity tested the patches on AMD machine here.
Everything looks good. I have few comments on some of the individual patches.
Thanks

On 6/14/21 3:09 PM, James Morse wrote:
> Hi folks,
> 
> Changes since v3? Fixed  the 'unsigned u32', remove a few spaces and fixed a
> few spelling mistakes.
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
> This series is based on v5.12-rc6, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v4
> 
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
>   x86/resctrl: Move the schemata names into struct resctrl_schema
>   x86/resctrl: Group staged configuration into a separate struct
>   x86/resctrl: Allow different CODE/DATA configurations to be staged
>   x86/resctrl: Rename update_domains() resctrl_arch_update_domains()
>   x86/resctrl: Add a helper to read a closid's configuration
>   x86/resctrl: Add a helper to read/set the CDP configuration
>   x86/resctrl: Pass configuration type to resctrl_arch_get_config()
>   x86/resctrl: Make ctrlval arrays the same size
>   x86/resctrl: Apply offset correction when config is staged
>   x86/resctrl: Calculate the index from the configuration type
>   x86/resctrl: Merge the ctrl_val arrays
>   x86/resctrl: Remove rdt_cdp_peer_get()
>   x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range
>   x86/resctrl: Merge the CDP resources
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 269 +++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 164 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    | 234 ++++-------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  44 ++-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  12 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 448 ++++++++++++----------
>  include/linux/resctrl.h                   | 181 +++++++++
>  7 files changed, 758 insertions(+), 594 deletions(-)
> 
