Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0836FCE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhD3OvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:51:17 -0400
Received: from mail-mw2nam08on2046.outbound.protection.outlook.com ([40.107.101.46]:30945
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230369AbhD3OvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LifaegqzvvM7c8kdPkGDyyt0rQeVHowkoucZ3JUOI+E+++syw4lPaOUIGLYBanTuqFSmxP/zu+H0H2u2AX2xfVENgMcUi46ZoEkmUNe+ykAcUDilowh7JPk73eBWsqRIgtr6ywCNkO85tOcf3GLBI7srbvJGKpGywbjtBvOw1fJLxMYO6DldwMAeMFSs80D95RrFhxbJWbYgPVpmF8lFkIDn0EEgCMyNetsRXM404Aezp1XHzLRxd6hLNnV274y0kOpap/jwNFuqdN/33v4dYRtcP1n10jDTY0XUg1tfoiWkdT5MDKGxskL3d0SGWj1ebWpNOy+YMAaPN1skaLLqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOhDWravqIQliHUne1T3go++LyGwh0UF1xPSLYt7Cek=;
 b=G8RUJZxrPB59QJvZ5tFDwvVLn8l50Ph6SgLNd6tD9qUR+85Xv3jM5c4L+rhLaPiW0rWNa84GrR2MsY90YBahv+lZg+qDd9nv8O/M22RvSUJpojf7mYjiWOLgFAr5/+AbUUqjoxkQKPQ8/XN0FpO9jVJfL//kOpAUOTQJXFEmHz6kl8nbPRII0EigReUSMiiFgdklQuUUXnr7Cxt7ZIOP6Lj7KhIF7Zl/gbSBGP0zzEqzlJpfAcukCza4S7G4V4NzzAwmr+CnB00TgD7g/w38U8q06ENZgx70nSIhiXetRQpvbe3+2WRYoRg48nh+2dDsEFZERVJHErCiDY/5XLWEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOhDWravqIQliHUne1T3go++LyGwh0UF1xPSLYt7Cek=;
 b=A+HZskxLWS0EJKodyeDFV6ufF93s0aK7JzD/2DvUSgotkUrArRqZj2k/rr2KBzaqH3zc9LnwaZJGeAhuM3lW22rkq2iydOfpSLPbtD8+EFoeGTJzJgfC+EkuAyt5czhDr20ftRyiNnDH0v5dTJ/ZSrTi7/KK181lWmiE34NVocg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Fri, 30 Apr 2021 14:50:25 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4065.033; Fri, 30 Apr
 2021 14:50:25 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4eb6b777-0fba-cd6a-0481-28b800e278f5@amd.com>
Date:   Fri, 30 Apr 2021 09:50:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210430131733.192414-2-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN7PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:806:125::7) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN7PR04CA0152.namprd04.prod.outlook.com (2603:10b6:806:125::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 14:50:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9882d7d-1e72-4827-5fc6-08d90be7497d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02178128A819CFFBC9AEC94AEC5E9@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b843JUVXRS7sOZ1nPkofbxTxyVNwBJUj7uWzz8GjWIRbsITSNM5riZtK2+8i69JkI2O28BVsAL+YeUMB0HkKfXDGG0Pnf7wURpi0FzfpOSVYihgD5lSV1YWGCLAc419ILQRUf0XFHKj4nhix+oYhnvt+UwPU5AlIPYwROYfuNjuJO2sooAeya18uRTRgat0lnhVGpALTBZV+qqLDL442pR7CKWN4uoWKpySnGl1man1x+ccn8pkxpxjXSEwO1pi6dsIRMQVrQ1vI5PBrF+hlZo4kOaZnNV37NFMXkV4xpMWoHGU+fWIGhI3JAhLQlAOTHKfuf433DIIYNSgL3sdsEoe+iJ4nehz8af/LixKhQkrCbLn8BIk9f6lb+HdMzyNzB0fSAKZ7mjkoIDo/yIhANT4gNlJM/+9qNXCFZjFC1wmpuvDp+X4oLBlJmuTgCajrd/YkViY6aEQDH/q9kjQgU3TRfG3ZYxF7aUdAf20McOGb0a1d+9kkXZFgb/hBaFYXqQPzf08PGV+xK57bap/0pLSF3QrMFBgCzQGagch4Nw5//7/fZDm7X8pudhBDeOgkq6xuQ7sXQorTj16d/VV37sEXALs9FlaT3yPavZwXODbpTdRsjse9pRdd1P657anyTKOYvzm05hZZdePwiN9OaS/+4mWHqNXIgqKZViWL+wQ122v5bOjpIgEh8GyD8gD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(2906002)(110136005)(478600001)(66946007)(6512007)(186003)(8676002)(26005)(66476007)(31686004)(38100700002)(8936002)(36756003)(86362001)(31696002)(53546011)(6506007)(956004)(83380400001)(5660300002)(316002)(66556008)(2616005)(16526019)(4326008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q3ZFSmpZcVBraWdWYzR0UGVhbVRpQUp5S0tFcnZOUXFrcm9rQUVGYXVENEpL?=
 =?utf-8?B?am91L05Kd1lPT2l2WWlCNnZMaU5YMDNwQVNiNFBHNVB1T1R0MldSc1loNmZz?=
 =?utf-8?B?NnpuRkpGSVJsYkVTL0pxY01wZm8yOWhhc01jcUFPNUNrRk11a3VOaXI0NTJi?=
 =?utf-8?B?YzJ3OFpqckpBcEo5dy9pRW03aXJxTFNLeVhPZVdRc2kycmZLNzZXZHJuc0RF?=
 =?utf-8?B?N2pDRFRNU2pnZE1CWFpQamFlcmxFeEcxZmhqYVllUWxIc2ZFTHFpTkZUZzVT?=
 =?utf-8?B?RWJFb2xMWXFpdWlMUFArY3BVWmFvRHJLOUNndTdMYU51K3oybUVQM1JpaWx0?=
 =?utf-8?B?eHQ1WDhlN21Xcmsrc3hIY2FCWVV0ZURGeUhTUEg5RjlBZTBTSFRuYllVNnlZ?=
 =?utf-8?B?R3A4Z2JobGN4SE9jTEs1NDEvN1E4SWVSNitPTnVhYUd1NnBhcTNtRjBjVU5Z?=
 =?utf-8?B?RXJJVHBNUUxtQmlUSTl4ZXUwUlA2bllpcDZnZ3NJVE43bWduSFIzam1udGR4?=
 =?utf-8?B?d0pJWVNWUi9oREpHSzZTRWlidVNkNWFySzVlenRleWNJaXQxclc1dzU4UjU0?=
 =?utf-8?B?SUVYSWF6S29hZW5scXBTWUZnc0NpTDBLZm9ZRFFKRkdVdndjRnhZaVRLSUR1?=
 =?utf-8?B?U1Q1WFZadU9SeXZyM0ZSVTNRTytLaXVOV3VaTEdPSTlILzBGZENudzZaWHZX?=
 =?utf-8?B?ZWRFc3NGVlBBbklyN0t1K1JpT25WbTNEMFpaekdIWms2cjBVMTRFZjVSaHBm?=
 =?utf-8?B?YnVkR3l4UjNiNWtJcFpab0t1eWF0Qk1zcXJHVk9hZVFoL1BqeTRCUDFDV0xl?=
 =?utf-8?B?YmpTU3pYVmNIZjVySEd1YVQvemZYT3F3RldocXdrcStkTXdySkV5cTNCRDZ6?=
 =?utf-8?B?MWRzNUNKRUU4eXdjN3hJdGpmMitMWUMwZm4weldFWUNSQjhUUHZlM0pwZFNr?=
 =?utf-8?B?Q1Z6THUralJSN1RjOGNEZ3gxMnFSVTFVWW5mZFZJTytsVXd2OXE0MThrZVBG?=
 =?utf-8?B?S2JmamJBUlkwbjkyOVNoeXphRXMyZEd1OVJwelVoMktqZ0Z5UytpNTNDdWJS?=
 =?utf-8?B?TE51S3F1ditCZjBGVlFaaTBtSkFmMWl2MVF1UCtsejg3QVVwUDVaeENuZHVl?=
 =?utf-8?B?VTNlOG5GeVIvY25TazZLc1BUNjZleSs2aVhMWEJQckgzeFZVRVZmZUJINE5i?=
 =?utf-8?B?NFRpcXFTdm51cGtpUmt5OFRIR0ZpUTc2ZXM4YlppNXRONGNYSzNPWEZpOEdB?=
 =?utf-8?B?dXh4T1hjWXNoaWt3OTE2MzZrRGJwWmt1dzBsbFAxd2wvY2JBZXZ2bk5FZWFC?=
 =?utf-8?B?V0FQZlErNGFKK3RuQnVwMkE1UmpEekRqOTc2TEgrb2ZsQlNIU0V6bUhERlp2?=
 =?utf-8?B?K2NDQWRGNTd4V0hOd2Z2eW9OQlRNeUdzcytEYXY3L3RLUGIxSHlWRUI5bElQ?=
 =?utf-8?B?NnNQenhsOEYxZkRxc0ZqSmwvZHNYWVRxTXd4SEdKT1VMeFFmWE95NU5TNWcw?=
 =?utf-8?B?UThOcmlDczlncmI5a09SRWdadHd3aGgwL3o0dWFvRkhRMUQ4WEhQcm01Ukk5?=
 =?utf-8?B?YnhRM1JXdHo1ZmFrZUFBdGRUYVZTVWdwSjlCWEhKdi9zWjRNd0N0bTFLVEFp?=
 =?utf-8?B?R3VBLytmbTlBMXdPVUJ0bDhBYUNWcWZVaUoxaDdJOGo3b2RmbVZ1UFR1SEVX?=
 =?utf-8?B?bzFNcGY5MUZoYitNMnJEZmRjM1JJK084cFlmNjFCZ1Fza0NHRFZPRTFaZENj?=
 =?utf-8?Q?iIm1rLM6+8k4eK+CMZnodi0KqmZ5GwTc84IXpUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9882d7d-1e72-4827-5fc6-08d90be7497d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:50:24.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOYKEnOBHubv2mKFUNYPanffwSx9yz7y9jvGxrMC83/f0JABq3Zbtsyob1YfzZdq6hUOSjWtb0XZnbP+x/BeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/21 8:17 AM, Ramakrishna Saripalli wrote:
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
> 
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/msr-index.h              |  2 ++
>  arch/x86/kernel/cpu/amd.c                     | 23 +++++++++++++++++++
>  arch/x86/kernel/cpu/bugs.c                    |  6 ++++-
>  5 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..a4dd08bb0d3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3940,6 +3940,11 @@
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
> index cc96e26d69f7..078f46022293 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -309,6 +309,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 546d6ecf0a35..f569918c8754 100644
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
> index 347a956f71ca..3fdaec8090b6 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1170,3 +1170,26 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>  		break;
>  	}
>  }
> +
> +static int __init psf_cmdline(char *str)
> +{
> +	u64 tmp = 0;
> +
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		return 0;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "off")) {
> +		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> +		tmp |= SPEC_CTRL_PSFD;
> +		x86_spec_ctrl_base |= tmp;

With the change to bugs.c, this should just be:
	x86_spec_ctrl_base |= SPEC_CTRL_PSFD;

> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

Then the whole rdmsrl/or/wrmsrl could just be replaced with msr_set_bit().

I think that would do what you need.

Thanks,
Tom

> +	}
> +
> +	return 0;
> +}
> +
> +early_param("predict_store_fwd", psf_cmdline);
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d41b70fe4918..536136e0daa3 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
>  
>  void __init check_bugs(void)
>  {
> +	u64 tmp = 0;
> +
>  	identify_boot_cpu();
>  
>  	/*
> @@ -97,7 +99,9 @@ void __init check_bugs(void)
>  	 * init code as it is not enumerated and depends on the family.
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> -		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> +
> +	x86_spec_ctrl_base |= tmp;
>  
>  	/* Allow STIBP in MSR_SPEC_CTRL if supported */
>  	if (boot_cpu_has(X86_FEATURE_STIBP))
> 
