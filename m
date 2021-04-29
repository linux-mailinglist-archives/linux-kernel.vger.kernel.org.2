Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE836EBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhD2OEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:04:09 -0400
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:11433
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240263AbhD2OED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScDKf9K24Ax55cmbRnxJUQxjCsvJH/0iYkumaICo4fHGk9H4LsVze1L4WFHVtySQA5o7qLXPJYDDBHCfiOxY1dVsafxmf+GJ3olyR7CUQoxw5t5lXKhXwFiOQhRGe1Kaeh9c0t4eMKajCRW8QUVS6D1sdaYYRgOqYwoo6m++ZcPCUkYT4TT4Zt8ky5V8GALvWnJ4IW9DYBTwIa0brIvWJQ7DGGcnNoqzmrTP32jE+6COxUZLs5Uwrgu+PakFyhePi9W4B8RUiJfHbGB4nbpEGFqpQKSB7uEaeumzSCzy9G1pZZgRDBAKEoIEVj7cRwCF3bJC2XVE7PttK7M+13dbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtJus268LdmzoJleuOxtG8o0x2rS1omXzqwLckZsJDI=;
 b=m0PUn47NXcmpfL8o69i/iK5ZwFfBBVFiD0UDKJOnEHeD1NTkExvnyuhgZdDyJknoGjhXA5p54iB7qw3xujkjLJQek4RgKlOa/fMJTHd3TxSsyuKfQ5WXPzSnviNFPZyd9CN6au/24yj9Y8ZY4rvUY5987XWcI+1CpnATgcRTok1aFgfU/i1tzIEQwPt4gZ1+Lxy6lqa/Tq0niahlP5NW3oaRLoyuQVLsttiMs+wsLX7Oe3dkziq+D0E0zQ7OywvoYkh3E6IUdpiClMm3RKm70dlUUExri7awfElQvi+XNs5fQ/RUvidyK5bukzYFKsu7OcrcR+rV89xCKzjxnHrj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtJus268LdmzoJleuOxtG8o0x2rS1omXzqwLckZsJDI=;
 b=uwd4o4FDiwF09I+FYoYAb+H65c3/5xlHWEeNRiTITXsvH9xbLG+OD0j4GnrHLzb5Car5Og68XTBzhinAnsiDaFvOxpbkpj9D/dTG/SZ94r4X28cEAC39xlZTyI4IK0px6Vvhc+hwFqjFhlZQM7P1aYv2+3igGIeAEEz0bNQ940c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 29 Apr 2021 14:03:14 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 14:03:14 +0000
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
 <b8135c13-591c-12b0-d5fb-900e146ffbad@amd.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <bfe3ea83-fa20-9f51-deb3-3005150d0774@amd.com>
Date:   Thu, 29 Apr 2021 09:03:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <b8135c13-591c-12b0-d5fb-900e146ffbad@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:21::21) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.26] (165.204.77.11) by SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Thu, 29 Apr 2021 14:03:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e351cefd-1664-497b-cc90-08d90b1787e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1724A6267A06579286C509509B5F9@DM5PR12MB1724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPPMCLjVoML+yt2PIWwBLD3lbBoUSnOcOQuNNjDCsflrh/CyD9ZJxtaMEkI13A/zTI2LfKSFlwhPtrduyLaJwOJuSz4c10mEqnzOdLvOrY1fnZ5sI1asnezyXf9ziWnygAqrZDCuIuDZq5ib87gBsUZa5aqBV5foKJbHIqh5iBw4vYWhNs9JbeE3YR7r/75K7YbJjBBcnVKNA7tFh0WtcFDL5a+ItOCIfHDgbLZgkOn01q6zLxj9l5I5Kxmqf/BcGrbu8bWPCPE537WL/OcUGhPfghj4BdzbR9/Cma/b/M/W1xY8fcGWRyPQlB5gfb9HCoCJ112Mx9csxASzN+QrSbkrPk4EBZ7aWz9MZJrtS8CqckjKlVraatG2beXq7O1vAUd9CHVUt/l5hXrVVHlRC+0yeSQxOTt5ITdVa88PHn5utxNsGWe2EllWdWVr1LjMbSFyU/+fVa2pzY4nFu3mm1Q+izSwzYClU4GyALGJGBGEOoflLKdcx/8LX//yevx929lVZ53F8zMfRVYemTkCMQ6F2S70WJKdfAeMEIAKOZm7N1hNUHzgWok1Y0eyN28+8yfz2EXDexQFulJNVvdQLE6VXpR9e3EnJq+TD7N6sq4fWQAaTFQhPVAE3gKus1w6zc+odQXS5xIfW3RjdQUJSL4F0TFc2hWCaYt5e6eKnthmHDgipDp6LjNVIF3Z1uV5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(110136005)(66556008)(6486002)(478600001)(316002)(8936002)(36756003)(66476007)(4326008)(8676002)(66946007)(5660300002)(16576012)(2616005)(83380400001)(31686004)(26005)(31696002)(186003)(2906002)(16526019)(956004)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K01zTmkydEd3UFBSUzkvT1JFL2wxRlE1RFRkcUdkQUxuUUpKUHdGdGR2Y0xs?=
 =?utf-8?B?a3pMOVRyb1ZmSFNVQ0U4Zk5QRDVwVkpSWHVrc3ZXc1c2dmxIT3F5OWtlZ3Uz?=
 =?utf-8?B?WnFvN0k0R3ArdTIxcGx3YzJ5cll4UDRWeXAyMXpKY0RzMXFnd3E3QmpLa3pk?=
 =?utf-8?B?ejllUXlDVXhHaSttRnNxZmtPSHNpNTdWWmZTMCt0QjVPL2p4YmVKL2FYcUM1?=
 =?utf-8?B?eDNGbFRyM2ZCVlEyMmExTVFWbWJQcTVpdUhBWWJ0UHVTaU9YM040WkFPRHRr?=
 =?utf-8?B?UlJwM3YyMk9JcUxpelRRWDNMNjRobmlEN0dqa05aUUtWeDhCYXJSakF6Nktk?=
 =?utf-8?B?dHliOGl0aWpmTnIzaVhXYlNSN2N1OGJiVTVhUUZmVUlqaU1pdTM0MUtqL081?=
 =?utf-8?B?SmtrMXdrUW9oTkt6dk16dFpLb2E0S2Q5T3dVY3NXWGlkQ2NqVzZidW1yOEhN?=
 =?utf-8?B?T0RaaWxMWWNPV2h5aStTdFZpOVJSRHlnL2ZQNmxndjN2RDNrNjBJcWVNOVJl?=
 =?utf-8?B?b2ptQXJJcnVQTFRFWTU4bmMxZ3FubjR5ZjMrUksvamxFVU83Z1l4VS9paDRN?=
 =?utf-8?B?anEwc1dBQzZJa05rWUI5TG8wZTlyMFplYkk1cFpBNm85UWZYVG9WVGFnTVFs?=
 =?utf-8?B?M3c1Q1dIZWpZdkNvWndJL2tCK2FwdnFtcDlxRHlEbmRtWEFWeEp2cmowZ0N5?=
 =?utf-8?B?cDV5SmtjZFdzWFU0YUppV2VaOW9mUTdaOUZFcnhENGt4Z3JUKzZ0QXF3eXJm?=
 =?utf-8?B?MDlUblZJWFkzdWVkTEdMcDhueFlXTlNPWndkY1VhYmY4ZHE5N2c2Si9iQUNy?=
 =?utf-8?B?ZnViSkNwbG1OWUgrdnR5L3I3azF2d3VmQ2pWRERiNGpNYi84ZmNLUlpYYzM1?=
 =?utf-8?B?dUpaZmxFY1hGM0xSYkg0NUVxbmtyd3kvNE1UdDdzKzlRa1NMWHh4aDYwZHpM?=
 =?utf-8?B?aUpPT29aOHNIU2wyaDdvWTZaVjZweDlacEh1TWtwMWlPaXFKMjRUN2lnYWV0?=
 =?utf-8?B?akUvaU9lRTQ2S0ZPVFJSamlYOXBoNk5aN1VTVGFYb3kycVN4cUlWK3lHNEht?=
 =?utf-8?B?NHFlcUxDR0NvcG9RQ0ZOTlc2RDV2WnE5ekhHNkxucXg0alVkTlZyOGRHVlVy?=
 =?utf-8?B?MVBsdVhaVU1HRFF1M2F5cy90SktHZHVkYnVncHh2WlpEUGY2eUEyQ1lpK2dt?=
 =?utf-8?B?Z25La2FHRmFCcERSR0JiOWw1WEY0RnJla3Q2eUpPN0VKbHFTZkxwOGpyOUJm?=
 =?utf-8?B?OHdLZDRybWNMLzU0T1JZOVA2QzFTSHBuSmorZzd1WldvRWk2NXUrajYvRzkz?=
 =?utf-8?B?SVZ4Ty83bjV3WmRFRmQ2eUhpWS9jSC9YQ2hLbm9xNUNrOW41Zk1QeDkwYmtB?=
 =?utf-8?B?QlpEUGxqVWF5MmtTYnlsK2VsWVBZT3M5NGhOcFlzUkVoZS9jZGhmUytYTHRD?=
 =?utf-8?B?akVoeXYzcERHeHdIS2Uxb3RyN0Y4eGJVRHZ3SnBrTlBMSlRvdGpLU1IrTXUw?=
 =?utf-8?B?QXZMYm93eS9Jbko0THYybFdISWZvY2dSeTdBdXYzMk1nR1JNTTNnZ2NKcFh0?=
 =?utf-8?B?ZnZXSDJTUzhvbmFWbk9IYXlvaWhsbUk0eUVzRXV3NXJlemFPUHdZcmNldU9L?=
 =?utf-8?B?c25pVVZRVTVUeEhDMUoyczduTHg0VldwUjNUUkVHTmNYYjc1SXFZVVZ6QTl6?=
 =?utf-8?B?QXVYNG5uQUFFb0FFNlluNTdsd0g4MGxkWkxuYzFoZE85alpjeHY3eC9rc0pz?=
 =?utf-8?Q?zBeIFIboStDan5l9c1/3PwoSqlUxBNjNy18CaOE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e351cefd-1664-497b-cc90-08d90b1787e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:03:14.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcg+627WzKIYjGwo17WwaaIk7/yghphDOKbehSKDVfCz4QYK1NkDOHzMvqQdzzU2Yt0W2n690LxvV19q5Q/FxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2021 12:13 AM, Tom Lendacky wrote:
> On 4/28/21 11:03 AM, Ramakrishna Saripalli wrote:
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
>> ---
>> ChangeLogs:
>>     V3->V2:
>>           Set the X86_FEATURE_SPEC_CTRL_MSR cap in boot cpu caps.
>>           Fix kernel documentation for the kernel parameter.
>>           Rename PSF to a control instead of mitigation.
>>
>>     V1->V2:
>> 	- Smashed multiple commits into one commit.
>> 	- Rename PSF to a control instead of mitigation.
>>
>>     V1:
>> 	- Initial patchset.
>> 	- Kernel parameter controls enable and disable of PSF.
>> ====================
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/msr-index.h              |  2 ++
>>  arch/x86/kernel/cpu/amd.c                     | 20 +++++++++++++++++++
>>  4 files changed, 28 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index de27d5a4d994..0576e8a8d033 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3950,6 +3950,11 @@
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
>> index 3c94316169a3..e36e6bf2f18b 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -313,6 +313,7 @@
>>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>> +#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
>>  
>>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 742d89a00721..21f0c3fc1b2c 100644
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
>> index 2d11384dc9ab..c9b6ba3ea431 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1165,3 +1165,23 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>>  		break;
>>  	}
>>  }
>> +
>> +static int __init psf_cmdline(char *str)
>> +{
>> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +		return 0;
>> +
>> +	if (!str)
>> +		return -EINVAL;
>> +
>> +	if (!strcmp(str, "off")) {
>> +		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +		setup_clear_cpu_cap(X86_FEATURE_PSFD);
> 
> Why are you clearing the feature here? Won't this be needed for
> virtualization support?

Yes this feature is needed for KVM/virtualization support.
This feature should not be cleared.

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
>>
