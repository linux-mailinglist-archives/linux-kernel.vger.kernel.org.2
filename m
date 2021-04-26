Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EB36B714
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhDZQlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:44 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:38747
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234726AbhDZQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZI/CiS4XrtkWV0v2dlWiCpFTnIjXJ6jaAjB7tGQDzwi6sjNxd/bE5+Zj+7P3aqMtF9VdEHtI8zufc2eg2mTjA3OA49gmJENyAVobvZ+hKC6eQtoQigdtywNotRIzqPdtF6nrO5tNjy18AXb0mJicSb+qIL68ilsO5kBlmmHQ5hfm5SFA8agyGxlmSJmMG00t1Dqysa9soUhMj00BF4Z6nCssPiRMTDWbTrEE/1IEPSQH05Du+O5ac7G2dYGbV1bup4WPXggpiyymrxTg39vE/7dMH8PSjvYmWGUv9bjtjwnwaBmJi+P/CT7A2r+nXH2mwM67su0KvrpmuvEupqT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAUmj5qZOFC/Om6b7ejlp3wiow/Gfc8xUNpBW5MbcuA=;
 b=YZAJMoEm+MofMdI1vmnZfRwHGZ7YOME05o/iNVkjYAnsi1v3d+7d1SVoqPq+VtZ2zKHmT7TMmcZ64v20Klkd46eV7apjGH6IEl2ZhaXiPIlhjVmQuy91anVcZ8g8rPN0A5cKWbZE0YU0+0yJSN9NYAZZW6ypp2zPUQM5XUKjkK/b600CeIz7onXigI0hOIKXxiGmDwpcb0ZjBRIwiSLkuzZkCvb7nzCuAbkae66V2Eq1Kq7n8Qel2Cf4+xHISqWG1FvFa24HQyjBT9rWZHL8KcYKFjSgtM4LWQyiiqAx31alVyASqrWcU2y0nu6qlSjbxnTU4hLAEmmOlqovVpLg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAUmj5qZOFC/Om6b7ejlp3wiow/Gfc8xUNpBW5MbcuA=;
 b=Byq+BhGnSLiLCWEV0co1lYh3VSlojcoGoH6bgzMxW8ksbORkIm9haUbhXfqdcv1ZBSJaotk7N6KZPaMulu6OGz7L78Wku9Hn0p+txuGZ7Zp+wO3RapXVwddV32OxskJ4KhFIVSMeAONIF0dEey1MdFUzDTHHQLSm9Q6l+K7uXb0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Mon, 26 Apr 2021 16:40:43 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 16:40:43 +0000
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210422171013.50207-1-rsaripal@amd.com>
 <20210422171013.50207-2-rsaripal@amd.com>
 <CAAeT=Fzji_=m45ycm_rS6dFcp1M3yWLQAY01-s=WG-gj4znOog@mail.gmail.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <e73b3ec8-bd8b-35eb-0adf-b292939e55ca@amd.com>
Date:   Mon, 26 Apr 2021 11:40:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAAeT=Fzji_=m45ycm_rS6dFcp1M3yWLQAY01-s=WG-gj4znOog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43)
 To DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 16:40:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa3e3df8-735c-40f9-79b1-08d908d208e0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11307AC098F6B5D2394CA64A9B429@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2Oz5y9gL5u+luPNLqXAFQjRUsoop29Ptk7GNeuEYsQx2l8bhIT1UV35oLYJBOYXrgry4WUOqCoX5NAgW7e1HEpzWxKceSMB9UzRZ+FZO5320GhZ1pfpjglDw+3bV3fWKM8a8rCQBK1HtwjbKiwgb1giwa6cSY1f2RyJENaT4ciT9C0dUJa2xS9Ta33yEhHrys8Ixaugyr2yFKYmWS4gJooGnzNGpsW+gYf56YxGFFXuhkxs+9iB08RmOetgTEVtU/hZ4dH8UMhsDa6J/lVNwRo3wL/YCWv7GaQLtAR1sCLhjaqJQa11/QYt2TSwEkmVxsiEOdqvUwlZlNhiz5yeQNnfsL4hXD5akKSLMAuM+1UWLm5DYBdF1jdT7zYYZbnO2n9CGDQ5J4Prfgrj7parQ6gnZNvdE8A4G3C/KTlRuTnB9PvJORE1P1EwlCZx23AxnCQ3GupIiXz4FP8fD2KNruYnvlZCpYz6NwiEt1mjwU9Q1LurGZWJV82pUdGVVDozEjFfQchkax6oiuH3aWRXvgdCJRVgRoZrpPAT0gRoZ+E+vvJRlG2duthqH7Y15mY4m1VpHTztGx/QNkOQQK7mz9b1wMola0ClFhPzI1IVj6cwW11X26N/QSoFHOYbDlK18ZA2bgISH8WPPUCNKQ1jpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(316002)(186003)(16526019)(478600001)(5660300002)(26005)(2906002)(53546011)(6486002)(38100700002)(66946007)(31696002)(83380400001)(8936002)(31686004)(6916009)(8676002)(16576012)(66556008)(66476007)(4326008)(956004)(36756003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MFZSSVEzTDdXdnpjWFZYSFZEWWFzMSs3R3dETjI4Wmpub1BxMTI1WGJIY08w?=
 =?utf-8?B?QmR6QzY4K1VLNmE1OGprdDJNd3FOcTMwN0hoVnFQeStPVWwzdG55V2QwQ0tx?=
 =?utf-8?B?QzdhRDRJZzludVdISW5ISUhGdHpFODJOUkdFR1hERUFmL2dRTzRrT2pSSTcx?=
 =?utf-8?B?R2o2TllnOVpPZ1hiKzR3Y3YzK1ZndHRNa2VEbWNYOHN6ZFJHS0ZHU2hUM3ZF?=
 =?utf-8?B?VU51eFZZcTRYNFhHeU1HbHcxcXVHVkVzRnhQN2xZNkprTDF1dnk2cW90eE5D?=
 =?utf-8?B?QjFzMGg4WVAwTnc4bTFqSnp6a29XNkVCTnRqb3phaExzK05iekczWFJHWHJS?=
 =?utf-8?B?QUpJWW05dlExd3BEUjBEU0dCWHdPSzZUanAzMGl5R0FTK2FVTmR6WVN4akJD?=
 =?utf-8?B?QzJiRGtTb0dUZUZiQXhobnY4Ly9QcHRmM0xtOC9USklUWWFmdUlrajlRbjJE?=
 =?utf-8?B?VzhQaDNRNytvcWJKY0k0aDVocjVRemY2bU45TVl1bUhDY3ZYMUUrd2dqSWlS?=
 =?utf-8?B?ZjBvL1lNYmQ5WUE0L05EeEV1OHFLRmViUkJvYXRhZ3Y0bkppUzh5SGlvWFAz?=
 =?utf-8?B?UllSSDluMUJ3VWQxZHc5N3AwdU9ndTlNNktSYmNEUDVWSU5VYnI5eUdWUkVz?=
 =?utf-8?B?a2lqczNMRE1wb25rcjJmVzFoenpLdFNBTDFBcjkydUxHTm5QUHZSNnFteTl4?=
 =?utf-8?B?djdFZTFrNU8zOWxUS05XZXNqVjRkd1IwNEp4UlRrMW1PczF6K2NSVTYzUzRz?=
 =?utf-8?B?QWMvWFMxVFRGVW93QU9zRmQ5ZWdaL3JwVzh2eVd1R2hBZXV6NlZjZzNkRUJ3?=
 =?utf-8?B?RHB2d1V2eG9iM3didS9PeU5US1lpU1JySjRjSjFUcERjY3VrU0JHdXNvbThp?=
 =?utf-8?B?UVV4UDhxcmtuOStJRW42VEtRSUcrVHFKaXRNNXAzL0VEWmtKb1pDV09EbVFn?=
 =?utf-8?B?bUhvZkFHQUVnZ3VFekRXWnBGV2h2VEIxZmVVaEpnMVhOUFdNVi94Q3FrYnpT?=
 =?utf-8?B?TThhTi9DVTBoSkp6RjlvVFhlMWkvTGd4QmYvdjNqaDBzVERtVE11RDdRZm1Y?=
 =?utf-8?B?bnV0cTRsK0dDK2RjWVhwTmdxbXBucVdRNnR5TndUdE5jb08xbkYya2h4SEdM?=
 =?utf-8?B?NUg2eUpRWC9POGFoQ2hoK2VOT0N2Q1drUWlZRkpLalJIMWxEZ0lYZFZhTWR1?=
 =?utf-8?B?b1UrMU9GY01pNTBIcVZrM1BKTnkraytTSEFjVFhod2RHcExabU1CZk14bHMx?=
 =?utf-8?B?ejE5RHlOQSt6SklNR1MwbTB3QlpBa3Ezemw1czZKeWpub3k1ZUIwK080aElI?=
 =?utf-8?B?REpKOEhGVGN2MkIxL3NUUGwveWJnbm9ROGs2TVhFUmVtUTQ5N3AzdUg0K29x?=
 =?utf-8?B?ZEczRWdtc0g3K0dZaWtDY1h0WjlwR0ZKVWw1MTJuK01KejZKbFdNekdqcStp?=
 =?utf-8?B?UFJ0S2UzajNWeStaa3BkL2lpbkRJQWpVM1VYUWhCRUVxdTdrZE5sNEVhRXhw?=
 =?utf-8?B?U1lhY2NOZWQ2M2tuMnlqQ2xSTEpjM2ovd0Y4U1QwcHZhbnRaRVgxZkxmY3RX?=
 =?utf-8?B?dnJ4N20vaHE5YUhxaTR0ZTRwbHI2TlBQWFdUNmV4b20wSUdQeWc0cEU2cUZG?=
 =?utf-8?B?cXA4UllORzZMZGZrejEwZERjcTRPQjBqRm55OGF6UFd2SWpGY01JYkVnWmtH?=
 =?utf-8?B?cG4rSmptSUE1TEp5QWNEbkZzN083aG9OOW8wMldiRCtxRmV5QmpkRlRSU0RN?=
 =?utf-8?Q?tn1j+JRwe3/u915FTAO2DB/PTvRALO/iKfXx3sh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3e3df8-735c-40f9-79b1-08d908d208e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 16:40:43.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXTyzo22ZiGrQHImmiP5TJoyuftZLvvYA8g7XBVuBVCBvvhR89M7k38sV8kMBzmUPW8dr2JeZ/g7b+VhAkkzHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2021 11:28 AM, Reiji Watanabe wrote:
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>>                 break;
>>         }
>>  }
>> +
>> +static int __init psf_cmdline(char *str)
>> +{
>> +       if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +               return 0;
>> +
>> +       if (!str)
>> +               return -EINVAL;
>> +
>> +       if (!strcmp(str, "off")) {
>> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);
> 
> Shouldn't X86_FEATURE_MSR_SPEC_CTRL be set if the CPU supports PSF ?
> x86_spec_ctrl_setup_ap(), which is called on non-boot CPUs, doesn't
> update MSR_IA32_SPEC_CTRL with x86_spec_ctrl_base not having
> X86_FEATURE_MSR_SPEC_CTRL (i.e. if a CPU supports PSF but no other
> existing feature that makes the kernel set X86_FEATURE_MSR_SPEC_CTRL).

Reiji, that is a good catch. 
This patch unconditionally sets to bit 7 even on machines where bit 7 is undefined thereby risking a kernel oops.
I will fix this.

I did test this code on a Milan machine and verified that with the setting to off, the SPEC_CTRL MSR was showing bit 7 set to 1 and with on setting SPEC_CTRL MSR bit 7 was cleared.
I tested this with both spec_ctrl_bypass_disable kernel parameter and without. 
I verified with {sudo modprobe msr; rdmsr -a 72 which dumps on all CPUs.
But I may not have tested this patch on a non-Milan machine with both settings.
I will make sure to test it on non-Milan machines before sending the next version out.

> 
> Also, since check_bugs() reads the SPEC_CTRL MSR to account for reserved
> bits which may have unknown bits to set x86_spec_ctrl_base
> (if X86_FEATURE_MSR_SPEC_CTRL is set),
> I'm wondering if psf_cmdline(), which is called earlier
> than check_bugs(), should do the same instead of overwriting
> it with x86_spec_ctrl_base | SPEC_CTRL_PSFD.
> 
Ok. I did not think of that path. I will go through that code and fix up the patch.
> 
> Thanks,
> Reiji
> 

Thanks,
RK
