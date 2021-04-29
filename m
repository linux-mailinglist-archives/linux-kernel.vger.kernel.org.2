Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171B36E46C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 07:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhD2FOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 01:14:11 -0400
Received: from mail-eopbgr760083.outbound.protection.outlook.com ([40.107.76.83]:47110
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231356AbhD2FOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 01:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwCGvsq3uNl8WHyep+6xvQCexDJpquZBCW/HZ7oFgZIqcofjW08WuAy1NxVYs+D6CRvoPuEIz1Wu59vkxN4ggL1x8qp5u6DnGvkq+vNwHA2nfpiDvwJafsb7Sa1HK4+eOp6P2sOY2LUEgSIr3YUWnrW++UEcilaegNRHdM/g4uB0c7iqH//bSkzUsEyeHDy4XMdjklWCGpbtxCiU6R0Ul3n2cs5sxgyKFer4o+gswgy4wO0Ge7UCY48OxstruRr+W0auYe2fVvwdNdYm+5uovCIvil8ZbHUAqeonnH4OAbh8g9Mm1COCSjUnTRuQNMLLuvDYa+2wc182SXWYQp2gDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz4r5gcronc2UMo+q9X3Cm9iKrIWLkKsmUIy9M2Elvo=;
 b=dVNYJ0elWvMz3s4Ldk4rS84DvM0aM/ivvIXhmRpvZpU3dK9CcTg+sMN/Ijgw54LKgFNuDV/blA9wo2bqK1x+vNepjWAKEAG9DWXgtaDyEwrFlkmD7hZvfbTNebBF6e2Umgbodq/ciLI8PnKv8M3FWJYLhdqG6d5CQc2vFOPsxbLMdoMU46t8IQC8u/QjdD59m9WtRi6Pjhw9mcLtuel2q/s3lZmZ/96NmwUJTOcqekutQ4rIKHSb3+6f+VYDC6k4yTtmy3J7NfeGKKT6+7/09V5n2D421J0jTvjE5MnAvfv/uawygYhAeu0FwGQsuk3VzpasEq0Fx1vrGmdmCl2szQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz4r5gcronc2UMo+q9X3Cm9iKrIWLkKsmUIy9M2Elvo=;
 b=ZZTr285kmOTXeqV+zKcz5V52m8DoxUaVijiDvk+CfrABmXV1rg3u3XGemnMEM9wE+vsYLcGFEpj/TE9SMbsw3W2kSp8G2rBDiZqOzAg8PhdSEYLUriAS/iBSIcH5riPS3SGbWmxmOKRhwjTuftfZF2rdMoVbokzvBCV27wVGsj0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 29 Apr 2021 05:13:17 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4065.026; Thu, 29 Apr
 2021 05:13:17 +0000
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b8135c13-591c-12b0-d5fb-900e146ffbad@amd.com>
Date:   Thu, 29 Apr 2021 00:13:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210428160349.158774-2-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.1 via Frontend Transport; Thu, 29 Apr 2021 05:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8c37c3-e510-4dbf-8250-08d90acd7f3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4942EAA3972DE6A33B297A9EEC5F9@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aI3fT8eujqngbzIqmecQvMlSdaIc/cZO/nHkilXx/8BJ/FpP81KBVwTnFlOcoDgIdQkLEBFTXl1RGXD51XUX1qSWNp2zrHq91pLdSutxtHKjiOAeILGRQvpR4R9o1wI/vbKnGopdd4J74NRTRB47QEynZxhkhVRwdeNbEXr3rbZsGlj98BGnOhgQNl3gJOw3tul0uX8U0loXYDWtbwga05fig2wwiejQX/Mgdn4J++1ZDbxPJNS/O5yzXWiK8uTfkBtymM5hxqIPf8t+mGjoKtHsH/gkRjQuMhK2YDwLA8EG1C1MxRNhJmWCY0MqCQ0XM9F3CUo/78/OqbBujaiP0l4E3Mh0cLQDPI4fw36lTcw26pXxEwBqvc8qhl4bc0UAoZXriEe1mupMKt43ZbJ9j3lGMZpC1uQnLX4Srgwj4p7gwrROFwQxmf8OawCQGYY6sMjGxTYlo600jziUuNE/UxrRvtZemQho4t48bJ+oMhkrgVxM+tV43Al7tVyuIwXAa4mWoGZk7XgQARM/lJwwLC4gmeGiGZcE75fzkzpAba0eKY2QAzRAPCVyw8KauRu7JiwSFnEaqd5IEqqaE6mdQwGVku0c/UiOysxsYSvYP/ZSPUhIEBsKMDbJxV7IyPFojVTLpLUOdyzLEoioJHa7Jtdcpu2goyphAtX1X7jybZdIqhwyO8U9LypJgCi9U2/3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(16526019)(316002)(2906002)(36756003)(186003)(38100700002)(2616005)(8676002)(31696002)(5660300002)(26005)(86362001)(53546011)(6512007)(478600001)(6506007)(6486002)(66556008)(4326008)(110136005)(66476007)(31686004)(66946007)(956004)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NkdzeDc5WnFWWG5EdG1qUzFIakZKZmRKNjFuVVE4OTJFQ0NqM3NqY0hsYW5P?=
 =?utf-8?B?T21lUXE5a2kyZVpMRTFwb21qSkcrTWY3K2tlMDk2T0ExY1J5K2FvNVZzajRW?=
 =?utf-8?B?ditTMFY4L0ZtZ1Vpa09SWFRGNkxrbWlnZFhNNmZ5blppTERsTmNkV21TWFNW?=
 =?utf-8?B?SFR3NWxPZHpSaTFxK0gxQWQvakowdzhuQW9zSUd2YWNkMWpVWEhmS1Eyd29j?=
 =?utf-8?B?TUkrOVpsbFNDN2FNM1RFVmRiY3hXVlp5MDdKQW03TktjUzV6QkpNZVhYOUFM?=
 =?utf-8?B?OWpxNCtqdDFzQ0FKY1NQSytIU2drVUd4WHAyZEdCeVVWVHhpS096WW91N2xC?=
 =?utf-8?B?eDdHSFpiSkZlRG9YbkpYNWtKeXJlZjM4eU5LY0UvZHUwNkY3T016ckFuZjNR?=
 =?utf-8?B?NkdOL0draXc4TWIyY2N3VWRCamJiSlpWZzI3MERUTmhYTjJacW9kNHlmRTFy?=
 =?utf-8?B?UmpOUHBjQlNzRDVIVm1DSU1NdUtubUlDd1NZYkZaQThrQ2hHZUJVSEwycGtt?=
 =?utf-8?B?TTZrM2Jpd1FnK2tmaXdiZ1h2TU55SEdYcEczYlZTOVAwQkpPSXdzbmM4aTd3?=
 =?utf-8?B?YzFPQllwVy95bHA2ZlpyM0lzZDJIK2NTNVZaVHV4NmxuZHhNeG9JR3JIWkVI?=
 =?utf-8?B?NnMrSTVWakI0MVRYVk9yekphUkltbklBWjN2R2FpR2ZBc2VjWHdiSmUvaFlG?=
 =?utf-8?B?ZjNnL05VdVdkeEk5cElyUmZjN2xlVngvcGQ5QjRUN3ZmejN2NzhvbFZGU1NZ?=
 =?utf-8?B?dDRFd3BBTVJZWFNvbU5zeW0xQmhQTitwelpVWklDdGoxTWdSd1JXYmJhOFpL?=
 =?utf-8?B?MmZYVmo4dVBhNzhXLzhCaGhqa3d2S3pqcWx5UDRpR2plZTRCN0pWMUdONkFP?=
 =?utf-8?B?S0ZXdGVMK2docWNsS2k3MnNBVFpNQTBLdjJQSis1N1prMEZyNGxDNjVmVFJY?=
 =?utf-8?B?b1MveVh6bHdrQksxSVRMb0V1ejhWUkhUdTNYMW1BeVBCMy9PK1ErRTZ0UENz?=
 =?utf-8?B?WUhXQWRwQ0kxWk9QREwxYzJOb2VTTVBRZEJvTFdzUVZPK1BOT1Buc1FuSlMy?=
 =?utf-8?B?SHREWFJFNksrYlhDcWIzeG9mV0dHUUFzVDhYVVdOTngyQWJPU29EOGlTamxK?=
 =?utf-8?B?dkpJeCtxTW5SaXV6c295UGUvTThycEY0bE1ZWk40bVRsNFR2Mm9EdHVpKzl4?=
 =?utf-8?B?Wk4yVE1ZRzdaK0h5dkI1eXkxZjNjNWEyWDBwZmVJcnBabG5zWkpJdkJORTli?=
 =?utf-8?B?VUh1dkZ4YUc3WnFhUXhBY2RpY0kvaEtreUhuV0dNdUdmakVGR3JnT0JKTlMx?=
 =?utf-8?B?ZEhJNGFVVVJDckNKcis3Zngwc3orek9vaVhQa0U1QnZTa1VHMThCZFY4Z2Zr?=
 =?utf-8?B?TFpoMXVtS01rNzlOdFVoelR5dW5mVkJzWmFieFhmQWtvaFVNbE5kaldwb2V5?=
 =?utf-8?B?eWZxOVBNWk11ZzcrbkFxaFZ5aHZzNzZOUUd3MVFvVm5KSXBBa3ZJcGNzb2d3?=
 =?utf-8?B?OXhNcHQzWlM0SUFUeW5lWmdLWkpmQnVGaWxUcy9hc2NNb3dNbjJJLzR3Lzdv?=
 =?utf-8?B?V082aHhBNDNMTXVrUkhreVZKajVObVIrVkg4ZFNHcGpJQVMzSmlwNEZrUSt4?=
 =?utf-8?B?SHBPa2RmYjFHa0FLVTluZjhOMHJyN2RKL2loOUZiTENvZHRNWTg5VXYwYkgr?=
 =?utf-8?B?VDdORUtOclhEUXpGdU54T0lCb2JoYUU4ZU9KUGROc0dING1kSGhCS3FNWnBn?=
 =?utf-8?Q?cA74QBKEug7EFRexf02pHxa7BwUkX+fHDQUgOoR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8c37c3-e510-4dbf-8250-08d90acd7f3f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 05:13:17.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYNPJdrebFVs1sar+1Lo8AyanCP8jtENifCfbAMdj9vZDtHcvS8Co9sSPAnAIBfAY133SHbqfqQuUZrScDX90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 11:03 AM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> Certain AMD processors feature a new technology called Predictive Store
> Forwarding (PSF).
> 
> PSF is a micro-architectural optimization designed to improve the
> performance of code execution by predicting dependencies between
> loads and stores.
> 
> Incorrect PSF predictions can occur due to two reasons.
> 
> - It is possible that the load/store pair may have had dependency for
>   a while but the dependency has stopped because the address in the
>   load/store pair has changed.
> 
> - Second source of incorrect PSF prediction can occur because of an alias
>   in the PSF predictor structure stored in the microarchitectural state.
>   PSF predictor tracks load/store pair based on portions of instruction
>   pointer. It is possible that a load/store pair which does have a
>   dependency may be aliased by another load/store pair which does not have
>   the same dependency. This can result in incorrect speculation.
> 
>   Software may be able to detect this aliasing and perform side-channel
>   attacks.
> 
> All CPUs that implement PSF provide one bit to disable this feature.
> If the bit to disable this feature is available, it means that the CPU
> implements PSF feature and is therefore vulnerable to PSF risks.
> 
> The bits that are introduced
> 
> X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
> 	If this bit is 1, CPU implements PSF and PSF control
> 	via SPEC_CTRL_MSR is supported in the CPU.
> 
> All AMD processors that support PSF implement a bit in
> SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
> Forwarding.
> 
> PSF control introduces a new kernel parameter called
> 	predict_store_fwd.
> 
> Kernel parameter predict_store_fwd has the following values
> 
> - off. This value is used to disable PSF on all CPUs.
> 
> - on. This value is used to enable PSF on all CPUs.
>         This is also the default setting.
> ---
> ChangeLogs:
>     V3->V2:
>           Set the X86_FEATURE_SPEC_CTRL_MSR cap in boot cpu caps.
>           Fix kernel documentation for the kernel parameter.
>           Rename PSF to a control instead of mitigation.
> 
>     V1->V2:
> 	- Smashed multiple commits into one commit.
> 	- Rename PSF to a control instead of mitigation.
> 
>     V1:
> 	- Initial patchset.
> 	- Kernel parameter controls enable and disable of PSF.
> ====================
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/msr-index.h              |  2 ++
>  arch/x86/kernel/cpu/amd.c                     | 20 +++++++++++++++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index de27d5a4d994..0576e8a8d033 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3950,6 +3950,11 @@
>  			Format: {"off"}
>  			Disable Hardware Transactional Memory
>  
> +	predict_store_fwd=	[X86] This option controls PSF.
> +			off - Turns off PSF.
> +			on  - Turns on PSF.
> +			default : on.
> +
>  	preempt=	[KNL]
>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>  			none - Limited to cond_resched() calls
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c94316169a3..e36e6bf2f18b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 742d89a00721..21f0c3fc1b2c 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -51,6 +51,8 @@
>  #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
>  #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
>  #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
> +#define SPEC_CTRL_PSFD_SHIFT		7
> +#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
>  
>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2d11384dc9ab..c9b6ba3ea431 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1165,3 +1165,23 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>  		break;
>  	}
>  }
> +
> +static int __init psf_cmdline(char *str)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		return 0;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "off")) {
> +		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		setup_clear_cpu_cap(X86_FEATURE_PSFD);

Why are you clearing the feature here? Won't this be needed for
virtualization support?

Thanks,
Tom

> +	}
> +
> +	return 0;
> +}
> +
> +early_param("predict_store_fwd", psf_cmdline);
> 
