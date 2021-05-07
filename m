Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607413767DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhEGPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:25:04 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:3097
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231540AbhEGPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:25:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdiVqVo3rfVU7p5lx9MZ+l4nk1cWnTfI4z6xojAXz9JlFwzzoGKVlgezlKzFpS89QcT3OwYvpLMvfIKJEfGkNAPjf4Qk7TQlp2t9f034whZsHPgudxFN0HEUmT8ShidxWght3OAiXEyQ8/4pDffyp1dpVcYwYIRWAMNMaQqdi+IfEPTQkf+Eq1yRhUiqaQuudONK4kgz5zFMB8zEV7UgI6pTir56CZQOm7GVBgh9Z/Bj58oIDA5o3EWs3bKGkUYczBdFEl3LRyZ+tbQDe6rRGguFx8BkMyIyNJsNjUuzvfpplDBTMMS+SnofK/Y0Nz375/qyp95Xw/4/qUUxNCMuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oBS5sjvSqh0oc/HolwnCsS5hchhMZlOFEM/LyLrf3A=;
 b=favVY/ID5zBMzldH/dYYmR1Luw9DIErG1Wwmd8Zxl5IUXZGDwA0SgNXfTUWl7htGTnJG+9/rCdY9YD+w96JDONQ57LqgTL/FtHgr5mcGNC/u+qal3yA8ZDGHZaiOxHFc5BGDfRHl3/P10Ow6nYdv1d2nB9VXoTAkVCUzBqgGCYavkUz9gfV8EBVVMA7py5d5u8fRB8p95mXnU9a5ONwhRyKctgNhatYCDhgAuQURZXqBh8OuIeeMdWG2rhtA68vaNApJaoCdpCvS7gYMYcpPSvanWQ4y1zvP9Mu1pba4aH78uswl4tK0CwqA2Kuu+aF/76fABa5PKkysCDZgDazcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oBS5sjvSqh0oc/HolwnCsS5hchhMZlOFEM/LyLrf3A=;
 b=R0J1JCXLHuQDwPcYDK/oD9lKzqdmexJZeA33DlchMjuopp7DGVvteLyy3F5EgNIZw1O/obZMLQ6R8ZT4xoRKGT5XsIUUvwQaL+mNFBe4tr5TxmC5iGfmR9asO33w7w5eORdQYWMdXQcsn30dffhQ5pmKkTtWiwXAe+EpaQ8oMKM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:24:01 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.028; Fri, 7 May 2021
 15:24:01 +0000
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
Message-ID: <661f2603-1db3-9601-617a-6cc44b6e94ab@amd.com>
Date:   Fri, 7 May 2021 10:23:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <87wnsamvaa.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SA0PR11CA0185.namprd11.prod.outlook.com (2603:10b6:806:1bc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Fri, 7 May 2021 15:23:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8296a299-09bb-4e50-90db-08d9116c23ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4401414E0DE8FB56C15FC3AB9B579@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3CRbNmTWe/5ESKc324O9cLFikmV6s+8FF4FqxJlql0U4YVGFvNGUFBneQQNECEscoNy/BztuHffZa4jxJG+ZHuFki5qWBjcaIAh038Nn8hAVuS/oGgMqCr6e/l8J4pV30XV4LkZ7gh/x/MsSbksTZfoloGbu2+sgZDSRU2vjHdetvGQotn33MmQjFWaWs0bxhK5yryrOyY2C6Ybcum6BTdQeBfWmBjRQv2VM3WzV5QN8ac0fnzwYuvmFqyalkU7nkNBLhmoEcHGPOYl24dA2zGdKcwUghg0Gwr3EwyCD3T9EB0JKACLRkQn6RHddhuVb5nToxw44afoq8xkbZ/sGyfCLO2wJpCEm43vekihiZO4G+0vLpCfFm52+LI3Atvjif7e1jgQCpTV5js0vHYINHkIgMi1boLh4deocQhTz1WuERAZhWi3Bf4cRqyBVrNe5a69FmvaYLYeNU1Cd5B5WK+grml04GVjofBTy/vPHIZ2oQj63ZwHbABbrkEwtou71ptCjjhG98CyrIyenTznEFHU4PQ669fxPbr2S1c33RsYQSj4kfEDuwKnSCaoTessxerEFd1Zme5n3Vtk6InwPIznUVOu6FBTpFtXEVu/g7a0S3Gy1bxjjKHAdjgWfVhHchWZ0jxAraMVRMnhcGY4v60WbGzF5WZ9mUtuHWwCC+X715HsY43Pzo5t5aP300kS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(8936002)(2906002)(66556008)(26005)(54906003)(16526019)(6916009)(66476007)(38100700002)(16576012)(316002)(66946007)(83380400001)(4326008)(186003)(8676002)(5660300002)(36756003)(31696002)(478600001)(2616005)(6486002)(53546011)(956004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkhMM3NQdU91WS9KQ252N25kTDZOcEs1NTZmdm5mQ0ZWVnhBWGhTRk5SUjNN?=
 =?utf-8?B?OGdYaTUyeG9UVjhHWjdqb1pkL010VXhlbE9Oam1taUlRaW8yRWtibmZGSVQz?=
 =?utf-8?B?SDJVVE12WGl6NG0rcFRaMmo1WlRsSmx3dlYwSEQvWVJVZGdEZWlWYmdKVlZG?=
 =?utf-8?B?cXE1b2xWM2pTY1g3Y091WU16YWJ5V0JnajhvTUF5YkJZMnJqSEYwZ2Fxdjd0?=
 =?utf-8?B?cFJGSXpOMUs1TFZRSW9OTDZqUGd1eE5hRlFZdkE2c0F3cFp1NXFCVDN2bGJI?=
 =?utf-8?B?RWFCQ2JIOFZjbG9jcTF3V0NnMUo0WkZLc1R2V0h5MytiTnI4VG1WUEFnUFZB?=
 =?utf-8?B?NFdtM3pqaHhDczNRN1FvVjU4S0E0L0UzTkNvNjlLbXNiclpwTWl5b0UzY2J1?=
 =?utf-8?B?MTNueFlDMFNzMHJrbEROam9EOWNsaHl6ZVdVSS9LNm5mYzJVZ24vK2VTRVBF?=
 =?utf-8?B?cjBkTU9zUTVxOCs2Y0NUdUY2OC9QYmZxVC9reDZuaWRnd0hJbEl1ZEhtY2dO?=
 =?utf-8?B?eGpIUFZNd09wd2tKQXJyV2JjZnp1L0plMDk0QlF5WFZLWUd0Qi81RHhlaWlx?=
 =?utf-8?B?bWNQTnJuOGMxcHdQNmRoU3lQZVBzWjBVeEd3Wk5GQ1l3YVlYZ3hnMHVqaVEw?=
 =?utf-8?B?Zmx6cjZkR2YySkZKd3dZZ3Fqc1IxUVRvYmJoTVFlZGJEQmc1M0hGQ3gxT2do?=
 =?utf-8?B?c3lmNVhDdzBXdFE3aE8yc29nK3dRQm5RNUVBenhpc0VKbFphZTNpQnU4TmpD?=
 =?utf-8?B?UU5oUERPbHhqTGhIS0gwcUprTlE4VGI3MTNFcDgvcUorWTJyYmg3L3U1RkZu?=
 =?utf-8?B?SEV2QWI0a1lLWVdTVkx3TXEwcGtNT1BmTFlLbjA0V3FsVTF6MC9tSTkvRk5k?=
 =?utf-8?B?WFdvaFBMZkUzNFJtekgxVVRMM2tuRDJ0Q0tQM1BJdWNpY2VFc2dZNmJoMzJo?=
 =?utf-8?B?TTFqRXlnS0xmTHgyUHNBeXhwd1JaRHRqMEJ2WlV1ekpDeCtITXdZbkd5aU1C?=
 =?utf-8?B?U0xBTVVrTnArVlZjSWp5alRpellSWkFuTFNPN0h1enRlc0FWTjI2aWduN0JV?=
 =?utf-8?B?c0FONzdBcjArM1ZsQ2RSNk5PdWRhQU5PaEVKTHVnNlNnZGRmNWFEalJaL3dS?=
 =?utf-8?B?QlI3SVdMZVlTSkNWNmwyU00xTXZFNDlOcUY4Z2NzREpuaXcvVG5wQS82a1Fx?=
 =?utf-8?B?TkNMYll2MnY2SUJoTkNSK1lLYXVuVzh0QUc3djhWNG85cVp3MGhSamNSZmw2?=
 =?utf-8?B?bTM0aTZobmVjRmxnek1jcDBpVitldjlJTEhjV1ZjbFBjYitpYVVIYnUzdHIz?=
 =?utf-8?B?WitDWW1xVGxHRlBsSTlkeUJWSUxtSVltM0FkS2NnMWVWZElKYkFTS3RYQzNP?=
 =?utf-8?B?Q3dPclFLeFFOcUdPR3NpbGdIdVIzUkYvbW0vODZSRWpoK2UrM1JuZnBxajFE?=
 =?utf-8?B?RVlwQzltTHdiTXFpUjl0WUthUXVlNTFvakhkeDF2cDRPZm9heTVBSWdIWllm?=
 =?utf-8?B?RmFKUWpvOWwxKzlVRGFHQk11MWkrcU5DVnNSemJoT3pteHNFWW9qU09vMVd2?=
 =?utf-8?B?VFpGZjJVcjMyamJFMk92dkJHRGRXazY4RzlTV1dMeWZPekhVODJlblJzTmM3?=
 =?utf-8?B?WFd3aFRPMG9xb2lud29YVDJnQnVOS1RSVitlMDB1QVUrTDVaSHRrUktGOUZI?=
 =?utf-8?B?RU1ZSUtlemV0VEVGVnlQbDYwdW52a2tEdkRiL3A2QTRSS1NmVFNjaDFlNVha?=
 =?utf-8?Q?S1MsUrUZrrZnnQGWi+ysuRZQsBpiU9EhjTjY1I+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8296a299-09bb-4e50-90db-08d9116c23ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:24:00.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4KYkHcVrpI/+UPWRCuRFBXO8baYLCnX84Wg43p9NkwLhLyJDrBfpkAhXaAboXMmn+RQhqLHPfpi8WZC58TaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

This patchset has come about to try to give the upstream community an initial feeling for this feature
with very simple controls (on and off) to experiment with this feature.

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

First patchset indeed was treating PSF similar to other features but it was decided based
on reviews to trim it down and present a very simple set of controls.

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

I agree and the first patchset did indeed treat this vulnerability just
like others. It was converted to this patchset based on reviews from the upstream
community.
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
