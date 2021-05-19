Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2E388EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353584AbhESNVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:21:12 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:6539
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353578AbhESNVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny4NJHDbD2AVU/G2q3bov9jTSr/wnonjbDLQIpaOH+Hi4b1fp74HXCWwZpTTHAsCUp1ovwjaZvQBZX8VnpSNqRPRgMEq5uYDtngWKGC0Y5+hHliwno796KKoDIwsX38Xs63smPyIGqRgKIvkdG/coyroKwiqzd8wsKtBCW9yopIcDZ9LoiAqm/cewlLWi6T9rYMG62e6O9mjInVu7BiYyfp/cGJjndXzE4l0rkdBe6NUSsLKo9KhZKuSZEkFZyUkQhvpbCLiLjBz9O4w7ItYl6iNr5+4kawFi6Bg7YwwRujMvDjvWttxZYzHK+pkzzk7Zzp3uxPGooFgOj9l86Shsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrGaaRLEvwGoQ/qqAQiREmmaJKb/foRwW2K4AcvFi4c=;
 b=D9URxOgKyU2SjMF1ZZhHvlnHewngNDsZtLH68WI3AOcfB/C82r1OO5V5MHYjbsi7Rw0EDO25UXAZacTRXgnH0UR1I3EPBbxW1bR5FsvIJyBnXLhD5rGVnPS36IKnuysRC+vcg75nu7G/ZZS+D6U0ON9l22rdBscXjun6oVtDdf42a9tNqhIPLsYPGbX4IzLKCmLdSg73J5pTwETw53ylG+L7tZvRVT1kQmkI/W0G0rNInvfCrSatCvv6Y/BLaP4DpnYdiQ3GJ/hcaKt4efo8LQci/atE9tg//LmlTj3qkvhF2v8wknuu7MdEuRcpBwaFC1gDIyH0flrIJ2A7Tmw5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrGaaRLEvwGoQ/qqAQiREmmaJKb/foRwW2K4AcvFi4c=;
 b=CvH8ZKbEQaZg5fvk5nnMXH2K0scSybkBhnA4EZ6P/MkybOq8d1DHqyD10U28PN0loIBvI6b3C3hLp8pfTZd3WbZvl0HPoBUKK8zGYKJQPpW0OfzK5mey8obUwDBwuUR3bgn76FwS6Y3Hyof21YSyhjzddHePVgnv7NjB94vrnMY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Wed, 19 May 2021 13:19:50 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 13:19:50 +0000
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
To:     Pawan Gupta <writetopawan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
 <20210519053848.bsn5x5dzz5jjqu25@devbox.home>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <448ebe52-f8d5-1e5a-c128-dfa3feab725f@amd.com>
Date:   Wed, 19 May 2021 08:19:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519053848.bsn5x5dzz5jjqu25@devbox.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN4PR0501CA0120.namprd05.prod.outlook.com (2603:10b6:803:42::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Wed, 19 May 2021 13:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd32ff2-737a-4cde-9fe9-08d91ac8c7f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4139AE83D5BBEEBD7BDC3C589B2B9@DM6PR12MB4139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWdrZY1fbEmjWmB4pfp5a2tiEFYLW+8omvECeHUW4imjIxH+GTi2Ky8O44Qj917sVCOLw2pVphgenaoep+ZHvzOYOUDHBTwRo3xzN/rqbU9erFhXDGidox/fPoH5S2pMex3KNKcWi9gD48/R05r+fjy5UVsE5WKn6CIKrbcywLwfPylU0K2N/D8HitxZf9J04rTRjnZE4b646kqZcoEJkXCoY+Vh9884eDO+K7VBMn48xFdm1Tgu4JHG/WhQMbZYkb79nzXlLEnh8GpxXny6PImu96BgRZQJT3p6jofPjPAFlBpWSEp6DQGdj79ifTc68uWhvVNO8cXouQ2XEJXzybp+PRuNl0zlUBHcvxR1D0uz6InUVeIsHUyj8tP6qPSe7eO3HrPSmIwgiSvbBo7o7rGz2Lt044X3DTvbQIXjpWFwGZid/36gO3HV3KLV8Cqw4Vhs8Uk8HyWRBO17fiWwR87vlN1pJoZUWSnp0t6wJu4ORqcJhO3LwElGq9D6UxU6YKrEqUei5fehqQf77XuNTccSqSOvQ8M2dsajLZn5rKZg2OS+vWoxTuYyeUUwLg5RMbS1SY78vXR9tSFo6vYXA96H6Q8W8dqmpzGL31ocRLLyoBheHSdNtX+tgc+5wxB9yuUGeL0OGhkJOOr1yjMf5ahSnoZ8MsWQ9hhmvv/QCVnvMTOSveDf1eDlsD2Khr7u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(5660300002)(186003)(16526019)(30864003)(38100700002)(956004)(66556008)(66476007)(2616005)(6916009)(4326008)(66946007)(2906002)(36756003)(6486002)(478600001)(16576012)(316002)(31686004)(8936002)(53546011)(83380400001)(8676002)(26005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dWw5STBJQ3EvZ1hlbHJzTURUaDBmZnQrNTdPRmRyRUVHOTVIS2ZzSXZJV25m?=
 =?utf-8?B?c0hRR3lybXNDdzh5N2NBeXFwVjVBQlBaZFZncnk3K3JPSXBTbGg1RVEzeXFZ?=
 =?utf-8?B?MXZjcmxwTGp5WkdZWVBaU3E1aEVEMGVVbDgvN3hLWmk4c2paMUlHYm84U2Ni?=
 =?utf-8?B?NXFHVStHSEpJYjFYVW90eUtkb2IyS3ByVDdqNGExd2lpQzQzOVpvTnpKSDZn?=
 =?utf-8?B?ZFZISmVaSnhuUVFhdExxNkpJaVNNZ3FzT3lJMUIrcXl3Q3oyVHZiNnZHOHBS?=
 =?utf-8?B?T0ttMC92UHIvaGg5N3p4cFZEdGppNDVKZC9qQmtFVDJYbEZ5dUFKZmVkRk5N?=
 =?utf-8?B?TGxFUGFNVDJaMXluaDF1NjFTZ25Bb0ltZG94WFVRaEpaTkdJcmxyaTZoNDk0?=
 =?utf-8?B?YStscWNQTDdrQW5YOGs4S01IQkJYL2JNUGJVTEJMTEpjRGVwdGRaSTBwVC9N?=
 =?utf-8?B?ZkZCYW9pbnlVVFNKRUZOT2tIZSthanpzQzU0WW9LaGlWeGdmbGQ0NnJ0L2FO?=
 =?utf-8?B?Z0c4SmxpWE1LajV2S3V1SkpxeVZXdFNKaVVWL1RjRm8rd3lxUS83RDJZYkZr?=
 =?utf-8?B?bjFqV1oyWUFDMjZQYW1QeXd1a1FBeDYwaG96M21QVTd5aVMyR3pSVEN4MVJZ?=
 =?utf-8?B?MTNPZHRmMHB2aFo2cDU4MExpL2QzNUZzcGdPbzRXT3BBcE5zM3p5UForNHha?=
 =?utf-8?B?Zm1iV1RYMGVjUk5zMkUrV3Q3NEZaY1cyc0ZJQlErcXB4alYwejV0V3lJK3Ex?=
 =?utf-8?B?MGpZMUtkbHE3RmczNGJHd29uM05PUW5VTkpIWEp1ZlZxVVpFeDh4QXArQUM0?=
 =?utf-8?B?enFjSFN5ZGlsY3lEVXpXSVZSSVlTTG52R0k2dHgrMElrVng4dTNrUHltNHMr?=
 =?utf-8?B?MzdpWkJiQldvQ2JpdHJUbm40Zm85dHlMeTgzV1cvaGt5dTNuT2U1WU0xdEVp?=
 =?utf-8?B?NjhmMTBaeWgyY1ZvR1lGY1lqTDgwb0c0VFlTY1NnUzAwTXVsRkdVaDgyVExk?=
 =?utf-8?B?NnFXU0pzOGNxWkhrcmF1M1RCN3hma3ZwdHVxbjVwQTNlTGx0enFleUFPRjJF?=
 =?utf-8?B?eXpiYVcwN3lxZHB2LzlibSsxSWFYbWliNnRNdDd3RG42TzRXYlNIUlR0Yk5q?=
 =?utf-8?B?WmFEbHpWNmRnSnZJUk5ldVlBNTBzVm1mWWJQeTlsSSt4b2dZazA5V2puU3FY?=
 =?utf-8?B?dXZJeUdtUHczV0orcmYzOXBrU29Hc1J5c1N1YUU0MWpHMDZsOTRSU041amFn?=
 =?utf-8?B?UTZ5UFZSYXdjbk5jelVYRU0zekViN3VsK29yb1VrUU0yUEwxZ0R4SndmWTFW?=
 =?utf-8?B?T3dMak5PM3NEWjFnbk5oNEh1MlU1Mjd6cGU4ZVpLN2paWG1VaXVYK0RtRkdj?=
 =?utf-8?B?WlV6MkswSUNxL1gxYmJ2TTdYUzZOZGUyN0NQclJCRXY2QVpva1pLRHJ1Q0pi?=
 =?utf-8?B?TzViZ3Fla3FSYnM5TC9qR01BOGZFUGJQQ0l4aldVeFdXZC9FMUFPOFVmZzhW?=
 =?utf-8?B?WkNISVFjS21oMktIMHdsMXVjVDFRNStUN2JzY0tBZUIwS1h3anlzeDc2QnVE?=
 =?utf-8?B?QTV6cXA3WGVWbVBqZThKQ0srUk9IL0pmR05tNXRYVi9rZkNlTFgxVXFEbmFE?=
 =?utf-8?B?dWdLaDBUWHoxYTNMNzZBQ0o5bWVqdHQzRHNDUVZzUWxrQkVlK25nVW8yOXpa?=
 =?utf-8?B?L3EvdDI5d3UrbnN6ZHJYeW1CallpY2JyK0pLdGlud2F1Q1VhTHBUaFBpUWhh?=
 =?utf-8?Q?Tde6wtGkk4G2OYNY+tHiY2iwhM/gURcXpezThA+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd32ff2-737a-4cde-9fe9-08d91ac8c7f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 13:19:50.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2c0JRX+u1SN+r2GWZZ7JJ8yWHeseD2IbBqHWlRPrQgpjrO9guhBItdyfihZinMpGqtPSDlPjcia6vRfTTej9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2021 12:38 AM, Pawan Gupta wrote:
> On 17.05.2021 17:00, Ramakrishna Saripalli wrote:
>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>
>> Certain AMD processors feature a new technology called Predictive Store
>> Forwarding (PSF).
>>
>> PSF is a micro-architectural optimization designed to improve the
>> performance of code execution by predicting dependencies between
>> loads and stores.
>>
>> Incorrect PSF predictions can occur due to two reasons.
>>
>> - It is possible that the load/store pair may have had dependency for
>>  a while but the dependency has stopped because the address in the
>>  load/store pair has changed.
>>
>> - Second source of incorrect PSF prediction can occur because of an alias
>>  in the PSF predictor structure stored in the microarchitectural state.
>>  PSF predictor tracks load/store pair based on portions of instruction
>>  pointer. It is possible that a load/store pair which does have a
>>  dependency may be aliased by another load/store pair which does not have
>>  the same dependency. This can result in incorrect speculation.
>>
>>  Software may be able to detect this aliasing and perform side-channel
>>  attacks.
>>
>> All CPUs that implement PSF provide one bit to disable this feature.
>> If the bit to disable this feature is available, it means that the CPU
>> implements PSF feature and is therefore vulnerable to PSF risks.
>>
>> The bits that are introduced
>>
>> X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
>>     If this bit is 1, CPU implements PSF and PSF control
>>     via SPEC_CTRL_MSR is supported in the CPU.
>>
>> All AMD processors that support PSF implement a bit in
>> SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
>> Forwarding.
>>
>> PSF control introduces a new kernel parameter called
>>     predictive_store_fwd_disable.
>>
>> Kernel parameter predictive_store_fwd_disable has the following values
>>
>> - on. Disable PSF on all CPUs.
>>
>> - off. Enable PSF on all CPUs.
>>       This is also the default setting.
>>
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>> .../admin-guide/kernel-parameters.txt         |  5 +
>> arch/x86/include/asm/cpufeatures.h            |  1 +
>> arch/x86/include/asm/msr-index.h              |  2 +
>> arch/x86/include/asm/nospec-branch.h          |  6 ++
>> arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
>> 5 files changed, 108 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..a5f694dccb24 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3940,6 +3940,11 @@
>>             Format: {"off"}
>>             Disable Hardware Transactional Memory
>>
>> +    predictive_store_fwd_disable=    [X86] This option controls PSF.
>> +            off - Turns on PSF.
>> +            on  - Turns off PSF.
>> +            default : off.
>> +
>>     preempt=    [KNL]
>>             Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>             none - Limited to cond_resched() calls
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index cc96e26d69f7..078f46022293 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -309,6 +309,7 @@
>> #define X86_FEATURE_AMD_SSBD        (13*32+24) /* "" Speculative Store Bypass Disable */
>> #define X86_FEATURE_VIRT_SSBD        (13*32+25) /* Virtualized Speculative Store Bypass Disable */
>> #define X86_FEATURE_AMD_SSB_NO        (13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>> +#define X86_FEATURE_PSFD        (13*32+28) /* Predictive Store Forward Disable */
>>
>> /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>> #define X86_FEATURE_DTHERM        (14*32+ 0) /* Digital Thermal Sensor */
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 546d6ecf0a35..f569918c8754 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -51,6 +51,8 @@
>> #define SPEC_CTRL_STIBP            BIT(SPEC_CTRL_STIBP_SHIFT)    /* STIBP mask */
>> #define SPEC_CTRL_SSBD_SHIFT        2       /* Speculative Store Bypass Disable bit */
>> #define SPEC_CTRL_SSBD            BIT(SPEC_CTRL_SSBD_SHIFT)    /* Speculative Store Bypass Disable */
>> +#define SPEC_CTRL_PSFD_SHIFT        7
>> +#define SPEC_CTRL_PSFD            BIT(SPEC_CTRL_PSFD_SHIFT)    /* Predictive Store Forwarding Disable */
>>
>> #define MSR_IA32_PRED_CMD        0x00000049 /* Prediction Command */
>> #define PRED_CMD_IBPB            BIT(0)       /* Indirect Branch Prediction Barrier */
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index cb9ad6b73973..1231099e5c07 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -198,6 +198,12 @@ enum ssb_mitigation {
>>     SPEC_STORE_BYPASS_SECCOMP,
>> };
>>
>> +/* The Predictive Store forward control variant */
>> +enum psf_mitigation {
>> +    PREDICTIVE_STORE_FORWARD_NONE,
>> +    PREDICTIVE_STORE_FORWARD_DISABLE,
>> +};
>> +
>> extern char __indirect_thunk_start[];
>> extern char __indirect_thunk_end[];
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index d41b70fe4918..c80ef4d86b72 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -38,6 +38,7 @@
>> static void __init spectre_v1_select_mitigation(void);
>> static void __init spectre_v2_select_mitigation(void);
>> static void __init ssb_select_mitigation(void);
>> +static void __init psf_select_mitigation(void);
>> static void __init l1tf_select_mitigation(void);
>> static void __init mds_select_mitigation(void);
>> static void __init mds_print_mitigation(void);
>> @@ -107,6 +108,7 @@ void __init check_bugs(void)
>>     spectre_v1_select_mitigation();
>>     spectre_v2_select_mitigation();
>>     ssb_select_mitigation();
>> +    psf_select_mitigation();
>>     l1tf_select_mitigation();
>>     mds_select_mitigation();
>>     taa_select_mitigation();
>> @@ -1195,6 +1197,98 @@ static void ssb_select_mitigation(void)
>>         pr_info("%s\n", ssb_strings[ssb_mode]);
>> }
>>
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)    "Predictive Store Forward: " fmt
>> +
>> +static enum psf_mitigation psf_mode __ro_after_init = PREDICTIVE_STORE_FORWARD_NONE;
>> +
>> +/* The kernel command line selection */
>> +enum psf_mitigation_cmd {
>> +    PREDICTIVE_STORE_FORWARD_CMD_NONE,
>> +    PREDICTIVE_STORE_FORWARD_CMD_ON,
>> +};
>> +
>> +static const char * const psf_strings[] = {
>> +    [PREDICTIVE_STORE_FORWARD_NONE]        = "Vulnerable",
>> +    [PREDICTIVE_STORE_FORWARD_DISABLE]    = "Mitigation: Predictive Store Forward disabled",
>> +};
>> +
>> +static const struct {
>> +    const char *option;
>> +    enum psf_mitigation_cmd cmd;
>> +} psf_mitigation_options[]  __initconst = {
>> +    { "on",        PREDICTIVE_STORE_FORWARD_CMD_ON },      /* Disable Speculative Store Bypass */
>> +    { "off",    PREDICTIVE_STORE_FORWARD_CMD_NONE },    /* Don't touch Speculative Store Bypass */
>> +};
>> +
>> +static enum psf_mitigation_cmd __init psf_parse_cmdline(void)
>> +{
>> +    enum psf_mitigation_cmd cmd = PREDICTIVE_STORE_FORWARD_CMD_NONE;
>> +    char arg[20];
>> +    int ret, i;
>> +
>> +    ret = cmdline_find_option(boot_command_line, "predictive_store_fwd_disable",
>> +                  arg, sizeof(arg));
>> +    if (ret < 0)
>> +        return PREDICTIVE_STORE_FORWARD_CMD_NONE;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(psf_mitigation_options); i++) {
>> +        if (!match_option(arg, ret, psf_mitigation_options[i].option))
>> +            continue;
>> +
>> +        cmd = psf_mitigation_options[i].cmd;
>> +        break;
>> +    }
>> +
>> +    if (i >= ARRAY_SIZE(psf_mitigation_options)) {
>> +        pr_err("unknown option (%s). Switching to AUTO select\n", arg);
>> +        return PREDICTIVE_STORE_FORWARD_CMD_NONE;
>> +    }
>> +
>> +    return cmd;
>> +}
>> +
>> +static enum psf_mitigation __init __psf_select_mitigation(void)
>> +{
>> +    enum psf_mitigation mode = PREDICTIVE_STORE_FORWARD_NONE;
>> +    enum psf_mitigation_cmd cmd;
>> +
>> +    if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +        return mode;
>> +
>> +    cmd = psf_parse_cmdline();
>> +
>> +    switch (cmd) {
>> +    case PREDICTIVE_STORE_FORWARD_CMD_ON:
>> +        mode = PREDICTIVE_STORE_FORWARD_DISABLE;
>> +        break;
>> +    default:
>> +        mode = PREDICTIVE_STORE_FORWARD_NONE;
>> +        break;
>> +    }
>> +
>> +    x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;
>> +
>> +    if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
>> +        mode = PREDICTIVE_STORE_FORWARD_DISABLE;
>> +
>> +    if (mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
>> +        setup_force_cpu_cap(X86_FEATURE_PSFD);
> 
> Why do we need to force set X86_FEATURE_PSFD here? Control will not
> reach here if this is not already set (because of boot_cpu_has() check
> at function entry).
> 
>> +        x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>> +        wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +    }
>> +
>> +    return mode;
>> +}
>> +
>> +static void psf_select_mitigation(void)
>> +{
>> +    psf_mode = __psf_select_mitigation();
>> +
>> +    if (boot_cpu_has(X86_FEATURE_PSFD))
>> +        pr_info("%s\n", psf_strings[psf_mode]);
>> +}
> 
> For an on/off control this patch looks like an overkill. I think we can
> simplify it as below:
> 
> static void psf_select_mitigation(void)
> {
>     if (!boot_cpu_has(X86_FEATURE_PSFD))
>         return;
> 
>     x86_spec_ctrl_mask |= SPEC_CTRL_PSFD;
> 
>     if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
>         psf_mode = PREDICTIVE_STORE_FORWARD_DISABLE;
> 
>     if (psf_mode == PREDICTIVE_STORE_FORWARD_DISABLE) {
>         x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>         wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>     }
> 
>     pr_info("%s\n", psf_strings[psf_mode]);
> }
> 
> static int __init psfd_cmdline(char *str)
> {
>     if (!boot_cpu_has(X86_FEATURE_PSFD))
>         return;
> 
>     if (!str)
>         return -EINVAL;
> 
>     if (!strcmp(str, "on"))
>         psf_mode = PREDICTIVE_STORE_FORWARD_DISABLE;
> 
>     return 0;
> }
> early_param("predictive_store_fwd_disable", psfd_cmdline);

I agree that on/off can be simple like what you suggested.
My patches version 2 to 5 were in fact structured this way 
but implemented in kernel/cpu/amd.c as it was deemed that that was 
the file logically speaking to put these changes in.

Later reviews suggested that since this mitigation is similar to spec_control_bypass_disable
(although it is a subset of the above), that it is better to have this in kernel/cpu/bugs.c and
structured similar to spec_control_bypass_disable hence this patchset.


> 
> ---
> Thanks,
> Pawan
