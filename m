Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC916378CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbhEJMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:31:27 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:10849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237133AbhEJLL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXOlaY/yNSxCgAA7R7TgN9AonKuB5NfSwEU6mmkQR0R2/yUG3D+JC2g89g+LbpMCLtcum0styx0XjchKX7hWFZsnT6XTYz5LiztvchyE+gK08N+bRH7uOcAJSPnKnaczIELR46ldfprdNMmKmD95BDT2fpry5s9AAFAOuHb0Cw2rW4WfroH5VD77mfPwleGBK3c6dxXwsvD2GBk0spuEoZGbhFcqLGSQh0Tj4TvnLPYPrIIQK6bitzn8n3wf8c1vV+siKXc91+5MOvPv/Uv9KDM9BDqNiQhb3UXI/wTAjCRQxW0ZRZypHkhab8jYbkBFCRUTyLxfnug3fMqJ/cbwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5EIqz+tc8pqMjVznFnjkxWkEttk8FHb3tODQ7Fbu84=;
 b=GxBzIrQyZGPRP28QclPCqASVZjuALR8YLAi9SvvAkS6KX80tbsg/DRvo6t2aaLnE2ZtFeZoMVixQzG1n48+7CMdkAPR5N47MwaNyJgt05Cet9GhlqmDbP9rxM0P5SbmHolaY/N133tJVSQpl0fcNNbWLtI/MjtnvVQUerLXI2efmW2QE9Dusm+SiU/7LNTrOPOiwAMrD1mpY6kCAGGwnQyZIv5z8Ls439niFs/fjA5R0qoT/aLhvLKPZJhohb8VWEdR2pUivZAe9JW+nTaI36b9ezNRhsB/m9GyKuzdjWSQx/PIz+XYdIWI5dtJhNhopJRnbdMsRXt4h4wDt+C5AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5EIqz+tc8pqMjVznFnjkxWkEttk8FHb3tODQ7Fbu84=;
 b=Ekts39Few8ZxNah1sSmzzet8a9ZPwq0xPdY2WFY4C9bUa0BmvXLYEz46HdnrDlWTmNMKaAPsXkHNz57Lr/FvuF7yleUHvAI6LSgxd8gnXFIcebvNNehB3+sH5fsZUzB7CrYqn2QHap4nrJC3OJVc0c0L+xlML+Ma2IqUfOngpuE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Mon, 10 May 2021 11:10:19 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 11:10:19 +0000
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com, Josh Poimboeuf <jpoimboe@redhat.com>
References: <20210505190923.276051-1-rsaripal@amd.com>
 <20210505190923.276051-2-rsaripal@amd.com>
 <87wnsamvaa.ffs@nanos.tec.linutronix.de>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
Date:   Mon, 10 May 2021 06:10:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <87wnsamvaa.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Mon, 10 May 2021 11:10:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1772f9e-28de-4747-3576-08d913a43246
X-MS-TrafficTypeDiagnostic: DM6PR12MB4419:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4419B43331E9CAED8CEC7CD29B549@DM6PR12MB4419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sj9hYxMDxOQ/h8015jYyhi8QLrADVdK8xp9ox7bX8oQzyTmvExJMSt6o471LCxymKN+Uz0HF4aPXEzUU2IdIS5AC98mAFdgbMfDXIorl3DekBgbLYTC8OjXjzLC4y/j9wPNthw4NSPYQHQPNElCm309+5qwUaZmzjQDesLvJbm4RsSqxc4f9dxjoRy6ChfDqI1fQSwFEhh+9/hDa2B4NNHCNctMqXTrSpTVaIh7R614C+pzBNnDmkcqCkgKhhEE8GArTeq+CJLCLwunmKuHa76jz/c5cptVqszs9HnbBCN3TQI44ozTIOzBJVY4DALvVN3Mq9keE30/ydsN3lj7stq9i4521CXoHMZU69krKZi/yOlGgjRvOZouN/sduwybum/lOw81EF7pcpJFm+J1xDrVguIgGTd5DuI8TS+JRGoaSg5dxxrYR1KS1ASqzY4bCPJCeksotu8QXml+pzSuiCOiI/1poxscAEGzSV7E/uR4W+fayvZZr5UczKqRLkIO1TIVIZLWvbtlYNBoPFM4dYEQ4mPF5yUPe9Bi5ByaL5BP5306+nfFlH1tS2QIem0OjTU4s4HrZMSxvh/WoVEYyqAUds+AWN/D707GP2GNOZeEvBsvhcVvyLzi7pZu0eortIgND+cg0arRF03m3nvBu71sjI6Si7V+5bVp6nXy4NXDF4MH7Qfv8zGxfeZCnATpxogA7rzHJhSivgmWd2DQTiHopExQp27yeNDvMP2Ho8HyP+5f9MIY2PkyF1eLn9oiiwOVYZkCPvlpa4sApfQSMY5SeHSd2y00Zjj6m9jiWU/y4np2AOymzdxr0B+gp+/Pn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(31696002)(966005)(54906003)(83380400001)(478600001)(38100700002)(6666004)(5660300002)(2906002)(6916009)(6486002)(16526019)(36756003)(16576012)(66556008)(4326008)(8676002)(66476007)(26005)(31686004)(2616005)(956004)(8936002)(66946007)(186003)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXFGUjNBZi8vdTYxc2dteXEwMUppMjg2aEVxb2tPRU5UdnlzVHQzaGVqVlZt?=
 =?utf-8?B?Mng0K2YxaHAzSnFKSERyNGJqYTFodldtck40OTBIMnlIOVlaZmlzTkRDM21v?=
 =?utf-8?B?T1RrMXIwRUE2NVY2Ry9aZ0ZrbTJuWHk0L3ArM1FPS0hPT251SU4yNVNDTVJ3?=
 =?utf-8?B?aENxWloxTnY5VGM3SjM4ckg2cnpwaXlueklIWG5STWcvNDI5bFR6Wm5rSlJF?=
 =?utf-8?B?YkdoNU1ueDNvVkZ3RGc5NG1jN2F3V0cyZFFsbmtZSE5pdjFxZlFjWVRHQ3NF?=
 =?utf-8?B?T2ZtR1p5R1VVMXdHQWpmQk1jaWxray9jaUY0NVBVMmE1OWFpTlNXYlY0cGNx?=
 =?utf-8?B?U2xaem1YMFNnYk16Q09XV3lxZGNCeHplM2FUcFgzeVh4MEpld1RGSC9ROEIr?=
 =?utf-8?B?ZGZGeER4MUpLeEx1RHUyNVhLdTdCeEpFczcvNDRITTF3U1p6OEovM3E1SWI1?=
 =?utf-8?B?UUJaak9zQm1nUnFqelMzUVVjS3VydmVjeVZ6V0pQT2FGbXpkams0eWw1UENN?=
 =?utf-8?B?SjQ5bFRHVElEOUxlQ1BQdk5wZVRBZEg3RXJlQUZBUEhxRXFDVVQxV3J1cnlX?=
 =?utf-8?B?YmEwVTJic2VkK3g3b3Z0Mk5mWGVvUEJ6MlpsRHlOS1U2OURKUkNXV09pdzBK?=
 =?utf-8?B?V3YwRlYzcGhVR3p2VDdkODdIejdTb1RNQ1huTDNNaEdsYWg4OXJHc2hORzBM?=
 =?utf-8?B?Yy9sbDBnSWF5YjRjV1EwT00valFvZlFNOVdyYlZTcEQ5dXIvODltQ09MUmNt?=
 =?utf-8?B?endIZkZRZngyQUdLOHQ3aGJCY2NEaHFOelB3STZ0VFR2QUdadVBUb041RjR6?=
 =?utf-8?B?VnBpQmxSZjYzYXNyVjB4TUdwYm10RjNVT1E4ODFWREkvblMyQ0FLNWc3TVl3?=
 =?utf-8?B?MVVxWlUrTG1KN0duRXU5REYxNWsrWU9Qcmt1Z2JQREF5VXc4NjdGQVhKUXo4?=
 =?utf-8?B?RjFVUkJSZFpkNndiU0E5Z3U3bnZCblVtNUcyMnB4YTBySWNuM3VTVWsvcWhx?=
 =?utf-8?B?dEZxNW1NNklXUDBpWWV0T1FuRE9yQzJEcG1MWDg2Q2VUemhGZkg5VzdKcm5O?=
 =?utf-8?B?REY5d1hjemVIaWF5a21MaWtsOWhhUkFnaEdKRHJIUi9VdnJWTmxYVEtBbmta?=
 =?utf-8?B?NUVDSW50WmNBUDJ3K1RIc3lvbk5TT2ZWVTl5OUlicmFLdjJKNytLN1Y3OUJu?=
 =?utf-8?B?cHpuOEZyM2ZtV3BvQllyNnphWXFmWU8vWmVwazJEMUdzNU50aU5LTE5EMy9j?=
 =?utf-8?B?YWUxejR0UU9oQXJwenN6K1JEemtoZ2l3MWFKQitTdjlYV0p3Q0lIMGJNa3N0?=
 =?utf-8?B?MGdOWndJSjJ6TW1QVG1PQk0weDUyeHdwKzhaaGRtZVAzS1lnVkZLeEF2citn?=
 =?utf-8?B?Y0J0VmV3TXg2YTdDVUoxNGR2TERGZHNYYS94Rm1HRVhqdFpjMkEwNjhTdnNl?=
 =?utf-8?B?YXdJL0lvbU9id2cwc0NtK21xNzRiL2NaWC9oMDUxOFZoMHpUdVUwdnRLRFBt?=
 =?utf-8?B?S1c1M1gvcWFDakFzUXA3K1pSOEVpc0lPNU03VHFxZkFqaEVxdklNZ0Q1amFG?=
 =?utf-8?B?blFVYXpmR2pVejl2OW0vQkFXL0tLS09ZRzllR2RndkYzd2RLSjdXUDBidllE?=
 =?utf-8?B?aXdDZENRQ0hTZCtZQmpNQVBvUmJqQkpjQTZhRmp2L2JXT3hZYmUvamZreFdn?=
 =?utf-8?B?dzNTNzdUMGRVKzdSdTlMVDJjMTBOQmY1U09qU1V4NW1TSFhaS20ydGZCcVFF?=
 =?utf-8?Q?Rg5lwi1mYtChi6M+vSutmcWz+p3KhM5tCzMZE+j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1772f9e-28de-4747-3576-08d913a43246
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 11:10:19.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxytyJo720Vfv4sFfXsk9rWjJkv2XW8J4/NWUIQFtKcTtwbh8lm8Il2hC8gKKv4R9TlyOHGOez8Iii0latdTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2021 10:13 AM, Thomas Gleixner wrote:
> On Wed, May 05 2021 at 14:09, Ramakrishna Saripalli wrote:
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
> 
> So this is the new post spectre/meltdown/.../ world order.
> 
> What would have been considered a potential speculative side channel bug
> two years ago is now sold a feature which is by default enabled.
> 
> Just to be clear. From a security POV this is just yet another
> default enabled speculative vulnerability. The difference to the others
> is that this is communicated upfront and comes with a knob to turn it
> off right away.
> 
> There is also interaction with SSB and the SSB mitigation which is
> described in the cover letter, but not in the changelog and is not
> detectable from user space.
> 
> I know that you had it implemented that way in your first attempt, but I
> was busy with other things and missed the discussion which resulted in
> this being treated as a feature.
> 
> TBH, I'm not really happy about this because that's inconsistent with
> how we treat the other speculation related issues and there is no way
> for user space to actually check this like the other one via /sys/....
> 
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
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
> 
> What? Why is this setting this feature here and why is this not done in
> init_speculation_control() as for all the other speculation misfeatures?
> 
>> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> 
> What? See below.
> 
>> +		msr_set_bit(MSR_IA32_SPEC_CTRL, SPEC_CTRL_PSFD_SHIFT);
>> +	}
>> +
>> +	return 0;
> 
> So any parameter is treated as valid here. That's interesting at best.
> 
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
> 
> How is anyone supposed to understand that logic?
> 
> Just because x86_spec_ctrl_base is a global variable does not justify
> this hackery at all. It's just a matter of time that someone reads this:
> 
> u64 x86_spec_ctrl_base;
> 
> void __init check_bugs(void)
> {
> 	u64 tmp = 0;
> 
>         ...
> 
>   	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> 		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> 
> 	x86_spec_ctrl_base |= tmp;
> 
> and figures that this is a pointless exercise and reverts that hunk.
> 
> What's wrong with just treating this in the same way in which we treat
> all other speculative vulnerabilities and provide a consistent picture
> to the user?
> 
> Something like the below. You get the idea.

Thomas, thank you very much for the comments.

I provided the links to the original patches which treat PSF similar to other
speculative vulnerabilities.

Could you review them please?. The first patch is the cover letter.

https://lore.kernel.org/lkml/20210406155004.230790-1-rsaripal@amd.com/
https://lore.kernel.org/lkml/20210406155004.230790-2-rsaripal@amd.com/
https://lore.kernel.org/lkml/20210406155004.230790-3-rsaripal@amd.com/
https://lore.kernel.org/lkml/20210406155004.230790-4-rsaripal@amd.com/
https://lore.kernel.org/lkml/20210406155004.230790-5-rsaripal@amd.com/
https://lore.kernel.org/lkml/20210406155004.230790-6-rsaripal@amd.com/

Thanks,
RK



> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -111,6 +111,7 @@ void __init check_bugs(void)
>  	mds_select_mitigation();
>  	taa_select_mitigation();
>  	srbds_select_mitigation();
> +	psf_select_mitigation();
>  
>  	/*
>  	 * As MDS and TAA mitigations are inter-related, print MDS
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -891,6 +891,9 @@ static void init_speculation_control(str
>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>  		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
>  	}
> +
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>  }
>  
>  void get_cpu_cap(struct cpuinfo_x86 *c)
> 
