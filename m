Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2136FCED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhD3O5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:57:18 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:61834
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229969AbhD3O5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKwNxyD3jEJLVJZh7223Mv6bCfAfnOdy5buoFof5AvzIQ55+R+TtwlHnpNkdDtV67gH5K/mfjCrA8eHlvjMuZKigxpOIFC/YVqZozKdGf5/EkQOZa/xivHS/WTyszJu8QUEkncq42Np+vmQlOLANGPVlFuTUCXq82Gj5mFdHn6XCeUaoIwT9ZJt5BjY9BZIa+0nim4O/5bK9i8uSzjMjViV7zMVEdRbu/876rUeXZWOFmsucA0gjK5qDFoYTK72oM8beHr1qL4LLT96+NnlTiO00wF3FKpygrLGuKOZCt9I+csofjFWgkyYfk5HF+V4ckN7Zr+K/gLKzSFyAw+W+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVna504P9QfulXC8eQ7cPN230BWCfJ7G4/kHh+zH9A=;
 b=ZQtc5IJeX8SsKMErI1WROSrm7jv4TISxbDnkdPQMYzICoUW8RAZzVbqbIy7ccXJ+ja32RmN9Ez8Ox4gWDf5aNILdT2AaFVAbk4mfjM4AlIs1OO1+AoFdIl5Zl26JhMtautcI2/Xhh7e1Ogrq4mCJSKUqM0wyHn6e2KQNIMcjON6WsIFVp/h1zyoVLHRLY+p95RF2l2QMJdQYphndNWi+XuGPlEgFALL99stE6QWzIl53ym9qSqvgiPvFlUTjU3XPxC2WUNzpaMqYHRe59PasVbiZaqWVctbZQddpYF9FFWb7uBg97fIlWub6+x6qYpCWkNTHZE53zMlbS7iU0raoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcVna504P9QfulXC8eQ7cPN230BWCfJ7G4/kHh+zH9A=;
 b=wYI2l30gTskhocxSazc63g+8QFccbBmJXe5pU0SDoJ6/oNUcEwmfjHfsaSUYyVsmTT0YCLezanCuUPM/OmMOx4Vrmc6SMShufPhfU8qh+SE5mWqO3XQWmhpWvRXib6Rpb3wxB7R9IzwVAsg2S4+dKxIH9cxvIgIrcU/4eRqYsUw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Fri, 30 Apr 2021 14:56:16 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 14:56:16 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <4eb6b777-0fba-cd6a-0481-28b800e278f5@amd.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <502ab6e7-1d1e-32dd-75ee-56d1ed73a93c@amd.com>
Date:   Fri, 30 Apr 2021 09:56:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <4eb6b777-0fba-cd6a-0481-28b800e278f5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:805:f2::40) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.26] (165.204.77.11) by SN6PR04CA0099.namprd04.prod.outlook.com (2603:10b6:805:f2::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 14:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94cf0e49-960c-4202-bd68-08d90be81afe
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473272E018EF669094B20AC9B5E9@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rZtKbGrmNL6BS1LQZ8SeovReYh0DhUianP1MLG232kzrewkzxXhWD5nwxNuADvA8Wn9YwFlpTzVc58s7AmIrxJcojjj8dA6qt85Yb1R6oF22hQAopal9hZGLOvI5aH4ci4Kk8/cit0cmjlLqG7I1nFI7Cx29XtbDE9YiLGexZyOrOx9GNZPDFuVm+53AvsTU/1NNryz5tW9IpvKoRGjI66Sojow3RMfujllIbo0hXE4kaeV3e2qaZSPxk1+9E0r5zwCJA+8IKAsnqBgZIp2yOaz/T7rSwQSPAZjh9VJI/ddU9F2SG+piWU0Y41+1KZlCuzpFHuMmwl2Hfq5C4O6hZExaRIyYntO8/EQLDVCqn3P6hl2oeXplvBC2ZJmySHyxHA8jWCA4RS2hVzE6gCJH2kcklPirVQ1bG9lT7A0R6hKKru6TnBo9bda0ZvD1bsjgr3noyqsSsYC3+O930kV2UxbGxaHvu5YXgKyoMtFDMuIRifxsZqDILXdEvr2biwrtqbNQYu8Htjns+dwyE37CL3+9QjvbzMYWh44LNROp7GoqMEX1DjaKVSUqe4cT3lf85CkOoDzSRGW390Ry5ROM5QlBcks5vqdQy8aaHJQ+wBpQ7bAzOoP2gj0agzpn1PchgHJbAlRccw6KFRlwWRJuvcRcedgfX8CbsOzeca0YGnnAUiwn9kQJuGK33RzDJHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(478600001)(66556008)(186003)(66946007)(8936002)(2616005)(16526019)(83380400001)(26005)(6486002)(4326008)(31686004)(110136005)(66476007)(8676002)(316002)(16576012)(38100700002)(53546011)(31696002)(2906002)(956004)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MXRpT0dVNjluMVkyQldVSEVOUXlpakgzQmFxN1RQVGtMQmxQVVJFS0wyb3Fr?=
 =?utf-8?B?TWl4R1k5bGNBV1RDOVNQVURDZUlWYURvV3VNNmNkVm5LM1hCenVQRTErQU8v?=
 =?utf-8?B?Rlc0bVg4alJheGhvQVlRaitFS2E5K205Z3VVNjRyemJHS2wvS0VqYy9STlFE?=
 =?utf-8?B?a3JkZ2JTOHNudlA3VEc3VW03ZTNmV2llZHo4bENna0Rqek54TTdKVDRVblU1?=
 =?utf-8?B?VCs5WHdaRzNTYjZTYk8wN2YzUWs2cEtia21MODlWYlpjMVVDSjlXa2JWcHox?=
 =?utf-8?B?RUMyRmtKSW9vSW9FWXN1RzdIdEt2QVIwRjZQbWw2bG1hbXc5YlFLRUJvZkJV?=
 =?utf-8?B?OWRZTGcxUjdMMGhINUxSTmMzNXphb0wvUDV2MXJxOGhFSk5lakVKWEVhTXFB?=
 =?utf-8?B?aFZNR0FTZHc2SldKRTJHeEhLeUFnVW1hRTB2V2xBNjJVS3lCbU55ZmRmKy9v?=
 =?utf-8?B?eHpSclcwZGlPb3NZWjVaK0lTWEdGNEVpRFVlYmFJQk1GTkRMSC9Cb0tvclYr?=
 =?utf-8?B?Sy9yQ09tY3hiRWdzdittSE9zZ24vR1VSRTgrUEk4a2svd290R3Q1L0lpcFhT?=
 =?utf-8?B?NzlGazJpVitaRVhmaGxYSGd3Sk80MlpSR0ZUT05XTCtUclJQdnllUDZDcFcx?=
 =?utf-8?B?ZkliV0l5RG5OY0xDaGQwMEt1aGlXZzg2bDlaZEc4WXBWVXZDNnNiUm9HUXFi?=
 =?utf-8?B?OC9PYzg0Z3hJRzVVVE1PL0FWUlhXZU9iS0hwK01uS0NnUURJUHM0WUR5bDA4?=
 =?utf-8?B?QzdYSjVkbWgyOWVDUHpKNkhUMTJZT202RkU0eUc4Sk9mNDJkUzFHUGdJc29O?=
 =?utf-8?B?SUJPbkFOY0UxTWF6bFF2cGEwMUJ3S05zZnBXUzlmemhNYnlyVWZZaWxTRDNv?=
 =?utf-8?B?aytLaElYOUY4QUF2SzUwMVM4RElQV1VNY2p4dDhLZzVmUzV3ZENoUHV4Tm1r?=
 =?utf-8?B?OUc2bG00RXAwK2NGVEdwTlJGOW1YVGFlakF0SUJtaFg2UTVFZ1VLaHo4cWl4?=
 =?utf-8?B?VjNrZis2Sk5ybUtFTnlpSVpJZGRyWUhuREpCOHhqWk5VOWFPWVlIYWtnaENW?=
 =?utf-8?B?Z1h0Ukd5c0lOQmF5UURycUlMMm96ZUd5eFhjQ01ZMUNWZmFqbEt0ZG8xdmow?=
 =?utf-8?B?UWQyRnNaYkx2U3c2MXVNcldxQXF2N2l2cmFHUFNydWFjT1NGWVQ3c0NKTmg5?=
 =?utf-8?B?ZFlpSVg0NnlVRjkwdnllSjZENVpuaEhqeFlhUnUvZWpTTnFpRlgySDZJNE8r?=
 =?utf-8?B?QnEveHo2Y0ZaWW1xanRWR3diVlZXcmJSSlVRRkh4M1RKVEJ1a0NwTGExeG9x?=
 =?utf-8?B?c2hxQVoza1ZKcEdpbmlPNDBUVzJTc3JwTXNrayt2cnM0OWNKZWM0dHZpak5O?=
 =?utf-8?B?N0JueDdyQ3k4cGZEcTcrU3Y1RE9OVndvYkNkdEhUNXF6T3laQ202NTRsY2xK?=
 =?utf-8?B?VnU1RVg0aUl4Y3ZCWWp0SXppczNZTjVMNEI3bFBySFNqS3g4bXFzMXlQYURC?=
 =?utf-8?B?MWtacmQxVEN1OTVweklYYWhHSHp0QmVta2ZkS1QwTUU1NncvcGd5MHRFZU5v?=
 =?utf-8?B?STdUc1NFQUJHeUdtYVlsNlM2RmVJOHFNeFpod2dqRmg5bEtZZmFTeGVrOEZo?=
 =?utf-8?B?RGNWYnduMHltM3lYSTQ0UmZGODZ6dm9va2Y2UGJ6ZWwrVzV3emFLQ05JcVJL?=
 =?utf-8?B?UmlhaTZzL1owTkhhTzNkQVRXQ0pOTnI5b3RsQVlDRmoyY0FMZEZjYlQvTXZ1?=
 =?utf-8?Q?eB599jOI8AroQ0vEkUSYTfmSusG1DP2CfusfyG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cf0e49-960c-4202-bd68-08d90be81afe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:56:16.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCOA8tJp9hlU7mDjsqx9zSX89qMDExhGl/LSCIllDR6ge8vc+jrcLDr/Lv7uuxA16na8y74xnyCdEi6MjFtN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2021 9:50 AM, Tom Lendacky wrote:
> On 4/30/21 8:17 AM, Ramakrishna Saripalli wrote:
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
>>   a while but the dependency has stopped because the address in the
>>   load/store pair has changed.
>>
>> - Second source of incorrect PSF prediction can occur because of an alias
>>   in the PSF predictor structure stored in the microarchitectural state.
>>   PSF predictor tracks load/store pair based on portions of instruction
>>   pointer. It is possible that a load/store pair which does have a
>>   dependency may be aliased by another load/store pair which does not have
>>   the same dependency. This can result in incorrect speculation.
>>
>>   Software may be able to detect this aliasing and perform side-channel
>>   attacks.
>>
>> All CPUs that implement PSF provide one bit to disable this feature.
>> If the bit to disable this feature is available, it means that the CPU
>> implements PSF feature and is therefore vulnerable to PSF risks.
>>
>> The bits that are introduced
>>
>> X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
>> 	If this bit is 1, CPU implements PSF and PSF control
>> 	via SPEC_CTRL_MSR is supported in the CPU.
>>
>> All AMD processors that support PSF implement a bit in
>> SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
>> Forwarding.
>>
>> PSF control introduces a new kernel parameter called
>> 	predict_store_fwd.
>>
>> Kernel parameter predict_store_fwd has the following values
>>
>> - off. This value is used to disable PSF on all CPUs.
>>
>> - on. This value is used to enable PSF on all CPUs.
>>         This is also the default setting.
>>
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/msr-index.h              |  2 ++
>>  arch/x86/kernel/cpu/amd.c                     | 23 +++++++++++++++++++
>>  arch/x86/kernel/cpu/bugs.c                    |  6 ++++-
>>  5 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..a4dd08bb0d3a 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3940,6 +3940,11 @@
>>  			Format: {"off"}
>>  			Disable Hardware Transactional Memory
>>  
>> +	predict_store_fwd=	[X86] This option controls PSF.
>> +			off - Turns off PSF.
>> +			on  - Turns on PSF.
>> +			default : on.
>> +
>>  	preempt=	[KNL]
>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>  			none - Limited to cond_resched() calls
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index cc96e26d69f7..078f46022293 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -309,6 +309,7 @@
>>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>> +#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
>>  
>>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 546d6ecf0a35..f569918c8754 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -51,6 +51,8 @@
>>  #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
>>  #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
>>  #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
>> +#define SPEC_CTRL_PSFD_SHIFT		7
>> +#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
>>  
>>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 347a956f71ca..3fdaec8090b6 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1170,3 +1170,26 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>>  		break;
>>  	}
>>  }
>> +
>> +static int __init psf_cmdline(char *str)
>> +{
>> +	u64 tmp = 0;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +		return 0;
>> +
>> +	if (!str)
>> +		return -EINVAL;
>> +
>> +	if (!strcmp(str, "off")) {
>> +		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +		tmp |= SPEC_CTRL_PSFD;
>> +		x86_spec_ctrl_base |= tmp;
> 
> With the change to bugs.c, this should just be:
> 	x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> 
>> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> 
> Then the whole rdmsrl/or/wrmsrl could just be replaced with msr_set_bit().

Agreed. I was just being defensive here.
> 
> I think that would do what you need.
> 
> Thanks,
> Tom
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +early_param("predict_store_fwd", psf_cmdline);
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index d41b70fe4918..536136e0daa3 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
>>  
>>  void __init check_bugs(void)
>>  {
>> +	u64 tmp = 0;
>> +
>>  	identify_boot_cpu();
>>  
>>  	/*
>> @@ -97,7 +99,9 @@ void __init check_bugs(void)
>>  	 * init code as it is not enumerated and depends on the family.
>>  	 */
>>  	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>> -		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +
>> +	x86_spec_ctrl_base |= tmp;
>>  
>>  	/* Allow STIBP in MSR_SPEC_CTRL if supported */
>>  	if (boot_cpu_has(X86_FEATURE_STIBP))
>>
