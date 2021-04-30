Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B315370176
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhD3TxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:04 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:13664
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231250AbhD3TxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw+y0lKcJl7jLLuw3Gugvq/+K3ryy4CxZzNlDj9Q9VQ5f4Nk3vk7hg1uUMAroFnpoNUdw0fmw8UIvWOi0OE+QQvUlrGRAIhz1HEIL4zgCweV+JxAIriXjCDIOfFB2Ax6lr4/p55+RQfrMBsJJ9AQ6NZIxzCcmxNUQjwa+/l/TlFGKnnVWpzT96y4mX+6EKSWc3j30DHbJS+vSHulprHoLwPDkMndbYdlxS0dTG9k0wo9LAuKNawZUbPWMMcNv+CFYJon16rLx8GmApaDVFqGPvAAQ09BJP3P9x0ncIt9DSHsIdQqTNQ7jbIjHKJ0yJKInE2vdJBPagheU0WdILCpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEHSNNyCmUzMCcyhhAiIXC8Fzhaqn4RhZKTDhY39LGc=;
 b=ecu/2WYEiR9CyFzngr7LMvLXpCIr0+U0eeZFY9zBNkAhswlHBExKYYJeJRjb0nJwhOBPsWkxlYDUb1Oj7swJU/dFWWACApyrICc0T1FFPGt8/eNuBDzUBalCgOFETuCcCweAgNdpYQu582fZeOLQLDwnkywvB2+NHQk1SW5WT5qEJnhnHDuupHPMk+9C+fuDeGEYe+kK7rn6lObXnJYDV5lZcmLCF07AaVPqvaGxkzkYRT58yR2KdR8cFMpwymNFe9b2Jh6BxkNFqRNxGVg49TgCjcPG2lEhZx15D4hFg2ehYrDekmh4r7kt+UCD2GTTTwbefCNwmYvWEiNUgclwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEHSNNyCmUzMCcyhhAiIXC8Fzhaqn4RhZKTDhY39LGc=;
 b=wIHwzfyw3U1+9s4OQvjVa5dsM2R2FY8TkCRriueVHGNOHPlNWNx3GL7tjtXm7bxk/vk5fydFbKM0todK6f8HFG08frWKn2orzu5lJ3tWiiVa8Miz/aBLvWMY8TmgyidEp7r6Hx+bzLYng+2CtiQRmxuBGliMT7Ut2+OIyFzjGhE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Fri, 30 Apr 2021 19:52:12 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 19:52:11 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <e53887f8-c09d-28db-5041-bf8822370c46@amd.com>
Date:   Fri, 30 Apr 2021 14:52:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.26] (165.204.77.11) by SA9PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:20::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 19:52:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1b36aa-730b-4338-ca56-08d90c1171d9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195205E2AA4EF4C42ADDEAC9B5E9@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUNHYhbcLZuBRCwYvEK/MRx9nbzTuFcX3QRkVLen2hjeDCqDmIxqTcyqlWDJLLmNERDtVABYF6fnG5lhgvVH0TqsvFS92pfLNU5pCmV939cK/vRvKW5q2mrYjEfLMxTU01uJo/fI9Z0gyQkZ7oJBvb4H+aQN3GWCbQpdV6yTA6lRU2vWk232v58SJzN5c4PSWDP2jmoYqHAw5AOorHRkuQcFPpPoDBuvZUNwR3+0GJBqVaXYj9LY0SdbW2J8Nv25Lx+AxBTCUk726xYjtDewC4GsVT0U7EXqD2r44s3BlOd7I8APFlTyb9Et4ZGCVIxf1d0yaJv8S1dRG/gcLWrjsANxRP0FOlpOZDK1ErAmsxykgAgM0RPRnigqZCUXPFvUqwjNL4/wmFQSRhBkjnRUuUk91ziGIM18AI45tbcFbD20wJe3qT9+agg2GbxRsJuvNirkkBNY8fISOpdscWMeFxjY3xZta0j1h3oEc3Tj5iWyHaTq2OmAJHyKDgHMOQOmMQ13FzbiqqFvvv/iKwEXUdS7goehVEY5IsFJ3zGAZIdnJHWzvt1//4K7xCRKA5/01SQDg52OJ6+FSZQt700/o2WpKSPd0ErbzhBpa6WRDmzQsqOpr9csnIHjkQSUAHji2VzzSRsHi3Keab8aN73xqLNkNms8vazSaHvNFpAXwznt/KV2m6Fl5kDYcx8K4rSq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(31696002)(16526019)(956004)(5660300002)(53546011)(31686004)(186003)(6916009)(66476007)(478600001)(66556008)(36756003)(8676002)(316002)(8936002)(2906002)(2616005)(16576012)(26005)(4326008)(6486002)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RE12OGV3RldaUGtFbm42RnRwNlcwaUc0LytsOGtTTGQwQmp5OVhSQ0pQZmxE?=
 =?utf-8?B?Mnp5YVRobjZvcER0Ym9RS0Zid3h3aDhJSVc0RnZXMjJxQ045M25pNE8zNndX?=
 =?utf-8?B?NjZ4NFl1UHRndEk5Z1ZlcGxybWJRTlVBblFNYnpzSFZWenF5Tm1QSWVhcTVU?=
 =?utf-8?B?dERSaXBwSUZOaFZGYjhuMmRHZTlSaEZCQXNXSm1Nempvd2hFbExUcFVrZjgy?=
 =?utf-8?B?Z09jV3RKaDFYbThSS2NiY1B1cFhsTkczQnJSeW1LU1RlK1c0ZUVpU0tIN3or?=
 =?utf-8?B?RFNCUkxkYU9iSFdybzdxb2hiUGtIMkMzaXg3aDRyRnc1a0Z4K2d6UkthZW54?=
 =?utf-8?B?TUNuMzRDYUh4d0lIYmkrdjBRMUtWSXhnNEVIeU5FL2ptQnRYZm9ZdkZNZEdu?=
 =?utf-8?B?UXNnS1ZNQ0s0dE1JUklXendSOHhDckhUYml2V2lOL0lXWHRFSzdMSHFpZit1?=
 =?utf-8?B?NVhFaHhzdDdpZ1N2SWdpSFF1bE9kclRvNHBIMTZjWi83L3FBZElzU2FQOE4y?=
 =?utf-8?B?TUgwbnhTYjdCTGNWaXczOThnSVBYUUpYdm84ajRrYUx5M2pWbXZYSWMwRlMw?=
 =?utf-8?B?bjZRRmxrU2JZK3ZaRDZ6b0xEN3pnbDRaOXRTcllWb2s4QXlSSWNuNTJaWFp1?=
 =?utf-8?B?UC9WOXQybW1vSW1kMUl2dUF2aEtpQU1pbjV5Zlg2TjlaK0kxTi9hMmE3VDRE?=
 =?utf-8?B?NVBaa0VZWGw2OVVPWXhJTXpFYW43TmFqR01Wb3NaZjRyaHJHbDlFMHFKRGhq?=
 =?utf-8?B?NUFvQy9nK1NoQm1BeVlEVnYwTE0zMGg0TGlLOHIxY3pGMGJRMWcwUzE5TEtO?=
 =?utf-8?B?ZXJ0U04zT2NVWjlqZFZnaHUra2d5VWtZRUpFQnVicUdqcmYrTzUvUk1sRHVJ?=
 =?utf-8?B?NU12aFV0NUdhR29XUVNxM1VQVTFIY2lJcHZzK2MzZ2JHM1B1TlZldG1Oc0ZJ?=
 =?utf-8?B?U09xR3BEOVU4WDlNaXRlR1lTQVczWm9XellnU1pRZzZJRnBWRzNKaGk1WERG?=
 =?utf-8?B?UXVzd3RSYXl3ZGMwdnIrQUt0djRESTBVQXVMWTBPejU3UjNPUU5TUCsxU1kx?=
 =?utf-8?B?T1duV1RZRGxrMlBZcFdPd1lrcUpXNnBXRDR2SHBES3RrcTcvNWZnTkYvQWFY?=
 =?utf-8?B?L0RnRVVKUDJiUVpRTStYR2cwZW5sRXQweFdDSGVVMnFVQncwQTVyZWhOOHZT?=
 =?utf-8?B?YVl2WUdaU3lKQm9SMU9ZU3hnc3pZaUZtL0FUTnl4UEJRUmlHUXVoUjVrUm9U?=
 =?utf-8?B?QUV1SzNFRG1uWHFMK0F6TjdjdU54K0N1aXhLaDhPaHJTSkFSekY1Yk9ISXhD?=
 =?utf-8?B?eFlnVlR3R0dSQmFXWVhLM2VRSDFyWmM3SDZTRURXNjlSWkdCazdkRU9KanJ1?=
 =?utf-8?B?V1RIREtKVTJKcU5zVGZYMnk4azUrVlB3MVZwWmtBaCt3Rmovb2IrZWJKTWZJ?=
 =?utf-8?B?T1h4bCtxOG1CUU5qUnhzK0g4TTZoL2F3eTJML0E4L1VsQlQrNFd5MXpCUWNR?=
 =?utf-8?B?UGxmbmRyMVM0Qldpd2xtREU2VjVoTU8xWXJSWnJNdHFSTjhXc0xPMTRlWk5P?=
 =?utf-8?B?QmxyazdrdGdQejg0c1gydXhpSitQNlVFVmxFZ2UxWlpoSjBHVVRONWRQMTZj?=
 =?utf-8?B?Qk9scTZib25Qa1IzTTkyVUtOcWQwdFJiOEwxbGpLUWJEUEdnaHBQY3RSTk9L?=
 =?utf-8?B?OTNkVExzd2Zia0sxVWo0cDFUNUhMVGIwYUNhdVFpQU52eFE3anF0RTVnTTg4?=
 =?utf-8?Q?KpD5KWlrygbPZzRdTDt9dUhW84rlQXfMVh7EoUX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1b36aa-730b-4338-ca56-08d90c1171d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 19:52:11.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo8oXqHiuzN5c0Se6kxM8AL2IZyZl0iZN/TQRR9SUPWNYU/xTl8fPh37PjZz6aUTU2SSwUok7tBYal+qnj5KGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2021 2:42 PM, Reiji Watanabe wrote:
>> +static int __init psf_cmdline(char *str)
>> +{
>> +       u64 tmp = 0;
>> +
>> +       if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +               return 0;
>> +
>> +       if (!str)
>> +               return -EINVAL;
>> +
>> +       if (!strcmp(str, "off")) {
>> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>> +               rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +               tmp |= SPEC_CTRL_PSFD;
>> +               x86_spec_ctrl_base |= tmp;
>> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +       }
>> +
>> +       return 0;
>> +}
> 
> 
> Shouldn't X86_FEATURE_MSR_SPEC_CTRL always be set if the CPU has
> X86_FEATURE_PSFD even if the new kernel parameter is not used ?
> (e.g. set X86_FEATURE_MSR_SPEC_CTRL in init_speculation_control()
> and have psf_cmdline() do the rest)
> 
> Considering KVM/virtualization for a CPU that has X86_FEATURE_PSFD
> but no other existing feature with MSR_IA32_SPEC_CTRL, if a host
> doesn't enable PSFD with the new parameter, the host doesn't have
> X86_FEATURE_MSR_SPEC_CTRL.  Then, it would be a problem if its
> guests want to use PSFD looking at x86_virt_spec_ctrl().
> (I'm not sure how you will change your previous KVM patch though)

Reiji, you are correct that X86_FEATURE_MSR_SPEC_CTRL should be enabled so KVM guests can use PSFD
even if host does not use it.
I have this change in my KVM patch.

Thanks for the review,
RK
> 
> Thanks,
> Reiji
> 
