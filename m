Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4336EC73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbhD2Od2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:33:28 -0400
Received: from mail-dm6nam08on2080.outbound.protection.outlook.com ([40.107.102.80]:12257
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240564AbhD2Od0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYombHQEmxv4nrTmma7TUlx78v4cChmX4oAVw50kK4Q2ticzZavtYhIa3E4Y/bX/gRtLkLF84odc70Gb+K78hfR3j/ofh7yE8T1mjaFIE1SllBgKDtL/ErVyh/3x+WtDmJVgslKIlyoGWbwbn3RpEEID0Fb8VOAgUGPESRNbynjWpgXJX9AJX19P5VI2ruKeAoH1/O8iRVVkSsQYBnBv5/6Ukicv3IDGdmvIDyrpj6mhNBToAP7rfVTHfpZBm0K2IKIMFyy4EuYJOBOsCiJxetXFN5hkHmn+PV6pLvW9f2BRw3e5l4BOOLeWw8JMeQnQSGKoOGg4BkpY/B+OmJIIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jToExw5jUBUAUkUDUttH+6n8m49NtZfR4QxnbculwTU=;
 b=HSojX0ydDILAdTRxm15rf//siKF0ApKkghuM9Tfxlux13V4mSH2Sg+d53D/hR8np8HiEPwFhvcH4SlpAXEEa+L/Mr7fBrGbd2aFBk1GjDuy4tSh45ihd4qT5vL0NBnrmWgOWIj8ZZ/0Z61pw61MG1U7PDG74/eSqIo8RrkUCx7LjrnpqSNd/n8jP6J2z1QXSV28fVRiek8iPg3jrVRJ3UOavzz6JmOlUNmDcXPrXnooh8I8llnvv6KrOB5/q/iQ1khmbl4yCpSuXjY082oUtjpqgGXTFZGGFHO5mgWpBv2XjTmp7TmIIenGzc4l44QhH+V+m1zrqc/0nMH1nrrx5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jToExw5jUBUAUkUDUttH+6n8m49NtZfR4QxnbculwTU=;
 b=TmfIufNqTJAL949YGCTlsGqt8QpiPJ7xUyIC8nw1EaFIIlN8WulK9gKg8HvZUopUNUdaEmfz8u30SPyG8zd2se6VAv+5lGJqTFNow1G2PBI8yl5TufYcpTxqL3cHBiEuaQdIGRKFzk/QwS38sdUuoHv4ZLQlPXLfshqHFHtVmho=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 29 Apr 2021 14:32:38 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 14:32:38 +0000
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
 <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
 <84eddb82-7626-c1e0-78b3-a92b5039e011@amd.com>
 <238f41fd-2f7b-cfa0-b538-2a659c38c7e3@amd.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <75258a4d-131d-766a-b20c-b3cc5ee65817@amd.com>
Date:   Thu, 29 Apr 2021 09:32:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <238f41fd-2f7b-cfa0-b538-2a659c38c7e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.26] (165.204.77.11) by SN7PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:f2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 14:32:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e307f9cb-714c-4100-9022-08d90b1ba34c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195B16098A4FC101A3677F09B5F9@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRN8kQ1I7JjLQmj2KylpNoE4eIhjA10Ig4M1oHv3F9LYm/JsMcaLR+9EhwGPJbelEmdqWe/7n74mOyeM47HPhMSiFVhzHkCjO59FOt3qo8Lvk96ziORkY11JwgHZzsKJJMhw5s1X+87A/EDI6rv4ozhPOi9Wdh1/9BOqGyJ9O/0shpZ5ShNFsqap2dMGMa4GaEincx4bpmxvrIA4VmnmgMXGVqSaF6slAhX+8pEpLoBLs5jMYwltdlmm5GcWDrEbnisPIBKCX2zKJ4P1TgWQdTg18mKUMtF2KAQwob+DaJUUXPfevKAAi1qLavX4fQ9g0QR3owoFIm2W0ciIMSRXTARxLIaAxwTb+kYPO8OtDzBknHrB9M8Mc+IrpTfs4axTJFzJTz9IGEaJK7EK/x7ghU5YD4qkQ6sYCHk6DXPRuZwapU9/lEb3MU660fMjhUqJJDZORlVx7wHuqxXlesC3Jj6dZ4HoqkoAoAvcvqETgnbZhROw8OGaLyttXhSGyOdc6kopkg58s0EwuA8ybJALYmBAtb1m8wjAF9vorsdgZ+UeePy8s2w8T/oHmfqx4M+wLWM18OeXNfG5zD8YU4NFBNTxiwnEGvDOn68aPsT3RFw9eUoNCliU++7vQyhtU5f8cMCHVI/e8NqeNEJzuHcChvPvh3571/8xZBdF+dyabZiQQ85+jzCz1u2tHCwGsc+y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(31696002)(956004)(5660300002)(53546011)(66476007)(31686004)(16526019)(66556008)(478600001)(186003)(36756003)(8936002)(316002)(2906002)(38100700002)(6486002)(2616005)(8676002)(83380400001)(4326008)(66946007)(26005)(16576012)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a09tUmYwYXQ4N2tpOFgyY3hZb3J3Vlp6cXNtTVY3SnI4eEorangxaHhCSFhr?=
 =?utf-8?B?RFNyak9YMGNXYWZPaEFKQVRzOGtCdmhOUGVBc3pLaDBJMWpDUEQxeE5kaUp6?=
 =?utf-8?B?RXZTRDQ4RktpMmcvQWpyeE9TUnV0REpjS3dQbUhhZkh5T0xtblhQd0Z6WnRD?=
 =?utf-8?B?U2t1cmZPM25OZ2l4czVmMEdrZGdNSytTUVVEMVliUUY4SlB6akVGK2g4UExa?=
 =?utf-8?B?MTZaT1ZRa3FNdkxWSlZqeHZzWDl1SW5qU3VGdHAwTFI3KzRFLzU1dXpBZURl?=
 =?utf-8?B?M1BuZUdIZ3pPUzdIUzZzOUh4dXhIQ1pCZllVMVdLQWtGaUNhTXl2R29BUW54?=
 =?utf-8?B?SXVkM21uL0g3MGRVQ3BOOEI1WDBucDM4dlZodi9tZmlTU0diQXFrOTBpclJj?=
 =?utf-8?B?ZFEvL3lONEhmZmdIS2xHdVJJbFhRUmQ5QlBZWHU3aHpGNFpDN3MrWUdMNDRi?=
 =?utf-8?B?UUU2NmxVVVptM2M0SEtaSFFhdENuK0NnQWp5SklwVk1pOEZvWlFxNXUvTEtC?=
 =?utf-8?B?c3JWZ09aZTFiRFNab21NMldCOUI1Y0RPeUxKaHJJekNFM1ZQdVBNRzBNWGRR?=
 =?utf-8?B?eFh4d3hYZGdMR2lIaGFPd2VsYXo1YTFSNHpaSDN2TEhJY1cyd3BtZzExRkE0?=
 =?utf-8?B?V3RMMEVPMmlWbFVEUGxrSHhoeXFWNEZoVE9icEFkbU01K0J5WS9nTThZS3R4?=
 =?utf-8?B?VW5JaVJ3QnFnNVBRaVFNSWFaMFkwVDZsN0VRUDNwSkY3WDBrRUl5d1FjS3JH?=
 =?utf-8?B?d1dtRWxpWkMvYTZwWnUzMWJ3ZThkeFNZemppYnJXcTRFMFdtUCtrUkFoUkVE?=
 =?utf-8?B?RitjVjBBdXErbkZETlYzeHBsOWtLRHpnWDRDYjVLcnBLWTVSbG9HQ0R2ODNp?=
 =?utf-8?B?TnZNTnJKMW5paG9pS25vb25nTFdFbExyMkdSMitLMTlERldwODJQdndobGxX?=
 =?utf-8?B?bTRLdEozWHlRV09ITFl6TjlxMnZKUWJiMStJcGhlZVk0UHJGNm5lVS9vZjZX?=
 =?utf-8?B?bDE0bUtxNUl0WWQ4c2JUUjFNQ0N1Z1ppRUZNZXNCcGZSakdKbEsyVS8xdmFn?=
 =?utf-8?B?dS9JQ0JBOXBPdFdiSW1FVmpMaWl1VFZEdytyTCtScW11U0FoeEJtbVNaUENX?=
 =?utf-8?B?bmlKOFFBNWJEUW5WamkyU3dxUndFME83V2xzYjR5aWdDRnBxNmJLOXA4ZVVE?=
 =?utf-8?B?dVo2S1NWeVZlLzdDTk1DYVMxcUhrWEdTUFN1ME5pa2luWjVpZTF0a05nWnF0?=
 =?utf-8?B?NTMrWkFqdXRxOG1JaDFTTmVheGVld1pGaFBxdkZKWjNFRW1lNDVmK2lWbHpt?=
 =?utf-8?B?ZnlxRk8yYzJid2JXd3RxTGZZNDhRUTZrRExyekJCVGVDWDU4VkxTMmdVTG11?=
 =?utf-8?B?WXAwdnhRWEs0UFVEbVNpdWxNdDAwQXBKNkRCTUhmT1JsQ0llbVlYNDBHUEdi?=
 =?utf-8?B?NTlPTVorNnI3Vk5rbkFDbUdJaEREY1hVOHJ1VmMxckJkbE5CalgwL3ZCYTFM?=
 =?utf-8?B?Um1weTg2bHFRbU8yVEpuTmM2eE1mWFFuNTNoTDgvSFVEQkxPd25kajNIWldu?=
 =?utf-8?B?SFN1TTFMa2Z3ZW41SWovTGRpNXZsdGpNRXdIclV1ZXdYL0U4cGxuVzQ5akli?=
 =?utf-8?B?THlEaHlSUWx5Znp4RzFmSmR2K2dGNm5mZy9lR0UyN1NVSzJrQ1pMaHdUTjNG?=
 =?utf-8?B?UnhGdVRNU1V3OHRkVHB2ZE9qMnE3dWFJQkdNMC9qTEVSeUZlOGtRZFNjT3h1?=
 =?utf-8?Q?6vd2tAw7xmJ+UInMbMoqeeBWeLHlfm7auZMWEdy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e307f9cb-714c-4100-9022-08d90b1ba34c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:32:38.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBumoG/ooUfyvhsUeGrGCkktFYuEu2e/kMw76NekXBy8fMXFH0tpVPNdxPlq7N0Bdk7I+sTPHp/AaxF+512b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2021 9:25 AM, Tom Lendacky wrote:
> On 4/29/21 9:01 AM, Saripalli, RK wrote:
>>
>>
>> On 4/29/2021 12:38 AM, Reiji Watanabe wrote:
>>>> +       if (!strcmp(str, "off")) {
>>>> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>>>> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>>>> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>>>
>>> My previous suggestion about updating MSR_IA32_SPEC_CTRL meant
>>> something like:
>>>
>>>     rdmsrl(MSR_IA32_SPEC_CTRL, current);
>>>     wrmsrl(MSR_IA32_SPEC_CTRL, current | SPEC_CTRL_PSFD);
>>>
>>> And this is to keep the behavior of code below check_bugs().
>>> (Or do you intentionally change it due to some reason ?)
>>> BTW, x86_spec_ctrl_base, which is updated in psf_cmdline(),
>>> would be overwritten by check_bugs() anyway as follows.
>>> ---
>>
>> Since psf_cmdline() directly writes to the MSR itself (and it only does this)
>> if the feature is available (per CPUID), check_bugs() should be ok.
>>
>> My patch for now does not depend on the value of x86_spec_ctrl_base after psf_cmdline()
>> finishes execution.
> 
> Reiji is correct. What if BIOS has set some other bits in SPEC_CTRL (now
> or in the future) as part of setup. You will effectively be zeroing them
> out. The correct method is as he has documented, by reading the MSR,
> or'ing in the PSFD bit and writing the MSR.

Yes, I agree with his analysis and fixing it.
> 
> Thanks,
> Tom
> 
>>
>>> void __init check_bugs(void)
>>> {
>>>         <...>
>>>         /*
>>>          * Read the SPEC_CTRL MSR to account for reserved bits which may
>>>          * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>>>          * init code as it is not enumerated and depends on the family.
>>>          */
>>>         if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>>>                 rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>>>         <...>
>>> ---
>>>
>>>> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);
>>>
>>> Does X86_FEATURE_PSFD need to be cleared for the 'off' case ?
>>> Do you want to remove "psfd" from /proc/cpuinfo
>>> when PSFD is enabled ? (not when PSFD is disabled ?)
>>>
>>>
>> No, it should not be cleared, I agree.
>> But I did test with KVM (with my patch that is not here) and I do not see
>> issues (meaning user space guest in QEMU is seeing PSF CPUID guest capability)
>>
>> I see no reason to clear this feature and I will submit a new patch with this and other changes.
>>
>>> Thanks,
>>> Reiji
>>>
