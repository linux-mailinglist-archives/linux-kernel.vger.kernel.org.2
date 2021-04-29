Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2536EC53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhD2O0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:26:52 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:62560
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233862AbhD2O0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQfFY6zSUHrYR8RFUH+MPROqE+4oK5y0Tp/kAfB+6hccX6dJp6TENQwpgTlokemM/Y56i5DForCgHkTftsJuWMuSQEV+Yxiai97MShAqZmH38XTNH0ZfElo0oKbHrqGPGeirxDny8DboJTZgbSQ7CjZPDua7wZZ3iN1IVpM2XBisDv8uxrZGjfbFzViAs+1mn++A8/rUdql2Rjcx7rcT8u0BuFGLvbzOI9MQs1utTLn/G6gY/mpk5//mjtM87DBUNZnsMI+p4ibpXKqrLLm4A1Xk4LEgQwqWY/oQaXVYLy5BMG+U9FxQwCMxrG3pKyfTjqUmoyS5OK4TGn38DM67Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aB2zqbX+KGnsRgMR2xSxOTX7Yg/ML1sMvrPVtrZeiM=;
 b=nQuVBRnkRPdIQgLrHqw8dry/JfTMFOu2Bd/ti42B6hwDuBYyHXXkO1xfnmGAjQBctDQ/PLsvbf+pVy/upOz8rnOqiXn6S28hLvyR+lEe/UxA3XNYu+PQFoZdLUfzXtI9QXl0gqpGJ/umm74NY2tWo4KjVI4akPyXcIwXZ3x2KAShZzEfb+E6NVbm7j0qKlA/FcPYL30tO3gDRn/Duh0lq47vyp4eCVGumqTPaqXdjtBRyckDbBePRkFucZM+spULZZ8+iVD/PEYIYXkWckKMPpa5VgzXtUBBb/PCYe5UUqb2i7GlMg+4izY1YCsvgrva5s21N8bUCJfslA64Tr3eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aB2zqbX+KGnsRgMR2xSxOTX7Yg/ML1sMvrPVtrZeiM=;
 b=EXZeieBSF2gMu9SLGZGpRLHDRMVO/TRC7zmt5L+LbF6P7K4zx1yrU7QwHz+xXlcBFcQ34y7Yb9XloMdjkEA0Z6w8KAJeLrXgf16A/9kDo7jaYTlUeNokPJZy6C0o4GH+8XeDimBg/8XVqK8rd/Kc12ginyaYuvV3IsUfpXHYzh4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 29 Apr 2021 14:25:55 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4065.026; Thu, 29 Apr
 2021 14:25:55 +0000
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     "Saripalli, RK" <rsaripal@amd.com>,
        Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
 <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
 <84eddb82-7626-c1e0-78b3-a92b5039e011@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <238f41fd-2f7b-cfa0-b538-2a659c38c7e3@amd.com>
Date:   Thu, 29 Apr 2021 09:25:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <84eddb82-7626-c1e0-78b3-a92b5039e011@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:25:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d28de8-bbd1-43ea-1286-08d90b1ab317
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39623888CEE29B136AF0E04EEC5F9@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iHHwNjUoOMZ0+SjDnPIG9TvceE39gY4YbVOWo1+hJFngLxi9+BEy4Zbogx8em+iEl6oazacFJkUIiCUoR2REtjuOSSkD3Kg7S9jbOy0tUwy3YsXNdNIgg4nEGtaVsNqEvMXvOSeNabNwQ7BYLyoZGYM9G+eyrob2yhj40ciRaJB30W7q7wzUDJqOyRX5l3CHWnoEq8QI1iGc+y4xn+aXiM+lBKgDShZYC/76v2nhBmRF5BB6/o4l661NzOrJ5qrQEApqLacHsToDL5gsY1va/YaGVFaw1DkQ3Nv89UR43brU6Pikbsk4hbkhlmo+4E3genYbES+sqs6imgNfg0HxNtpiLW4GqhsvnZudzeueVBrUYXDX2zSuoS0HiqjFsBKBOPqie84Y4TN1189CGHkF+7ESheXuVs70z1C6y0PzlnbgHHlIE65FoV1HoS77jSsCAX4xm/Tj549PXAATi4OOyMc84eQSw7+hleKIBoHaTmf4mq4WIScO/u+LdFWHqYiwWG480kG5Nj9H9tP+j/UQ8MKHspA3qBnNNdbKIeWrZzAdzTBAlstpbQpg1zyU3FG551nyMYNwxu9sqjF12BgddTzAz/eZMMgEf4nQhQ/WPWAmGpawn4vDIJfzYlt6G/hyyUbO+te978OicMqyiEvIlt52JiiqfaXmyl1HwWnJkOM0rZQgvBCadM2DVZ2aaCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(316002)(110136005)(6512007)(4326008)(186003)(66556008)(86362001)(36756003)(31696002)(31686004)(2906002)(5660300002)(83380400001)(16526019)(8936002)(2616005)(6486002)(8676002)(38100700002)(478600001)(53546011)(956004)(66946007)(6506007)(66476007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N09PWGxzeituZVE5SjJ3aCtOL3J0TG1KTTN1MjYvczI1SUpyNURmN2k2clFn?=
 =?utf-8?B?OE1UUVNQRUhsdURFQ1NlSG5VWmFEa3dxZk9XV2lmanFaUS9rR2NqNnRNaEJh?=
 =?utf-8?B?QUszOUY4ekprZ2NTVndSYXZ6bXhWeWgrTTRObmEwdStHelhaS1U0Rng1U2VS?=
 =?utf-8?B?Y0krRFVldTJmSkZNZGE4aDFPT1JGZC9XeG9vRW5Od25lSUsvMUwzTjU4YkFZ?=
 =?utf-8?B?eU5VYS90emxhRWpJTmZPWGhHSEZaRGw1M0Z1VmN5aUs3TVB0M0JoRG1MWFFB?=
 =?utf-8?B?bmRKVW9Cck0wWkhTMWhSVXN4bktNb1hXKzAxcWE3SjJOblcrL0hnZURPZ0xE?=
 =?utf-8?B?ZVB4OVBoVFRadDRuS2RKNlJWQnlMQTV5RGdxVTBQRjR0ZHZNTk9jelNoazFN?=
 =?utf-8?B?UktZNUpZQmtDaGhkNTgyZWRkTmJmME1OWlRjRTFtaENwRjZ4cmExWjhlSkhG?=
 =?utf-8?B?dVVZd0hhRVovWHlvcXN4eWFQTGJ5ZExJakdWU0QreXRQbWlSUUM3WjBDbGVz?=
 =?utf-8?B?aVdOWElYUDdsSkZ3TGtHaVFxTkVzM1g1Tmx6UWc5QWFaY2VGYUtGWTB5RmxC?=
 =?utf-8?B?UkVUU1NZcHc1SEJyRGtMRWZaWGtSOXVHaCtES1VPTWxCV3YvNm9ZU1haUlc0?=
 =?utf-8?B?bjNzY1c1bVZvNUs1R054cTVMZVV5QUIzVkpCNjlCK3NueGt6U0RpdElQeC9G?=
 =?utf-8?B?bHhWTlV1MmZ4ZGIvTU12SGxCaG9weDNxNFd4UURTTFc0VG9DU1Era2JvT0tX?=
 =?utf-8?B?QXhtWllVdlhxY3ZFNzJVdzd0NDViMTV2NVRVeTh4Nk9JSmVsSE1nS3RDWHRT?=
 =?utf-8?B?NVFRS0FUQVdFWmRBT0xDNEhWZ2ZEc042WlQySTlLVjF6OUdjbXl4NlRxdE1i?=
 =?utf-8?B?OTkxeVFMa3RDQkNCd1U3UmJkZlpNRjYrdW9aSWEzSVhpazZpUFQvaGtIaUNO?=
 =?utf-8?B?OEQzbDYwRW15Nm5FSEpjSExSNHU3WEswSE9mZmNkeU9iYnR0QjFlZzhTc1VI?=
 =?utf-8?B?UklvdU5vZGpxYUY2SFZ4T3VHR2ZxQzJtSTkrVkVnTW1tZllKUlExSS9BcGFq?=
 =?utf-8?B?c0R5SDRFa09NQ0hKSWVYNUpzNnJRRzV5RjRGNGJQekdIdDA5TlN3c1JqVnk3?=
 =?utf-8?B?RjR0VDZrOTZEZWw3Q1lWV1c0QVB4ZjNna0MrR3oxcFFQa2lkekk4ZUNab1ZF?=
 =?utf-8?B?VzlndjB0d0F5TGRoeEt4Ym5wMzBMU01tZ3ZtMDh0SmlCdG9ub0paK1JLY0Nx?=
 =?utf-8?B?MXlBUjRoQXBPQS84YVUwYWcxQ2paYlZWUHJZRXAvd0ltZDlINVpVK3VvM3N1?=
 =?utf-8?B?ZFVsNGNWYUhsRXA2c2dReXJJK0VjcHZCb2YrZDVHUEhMV0lydXFpcUtJcm1W?=
 =?utf-8?B?WTVvVUFTdDRyRXlqVlIrV2hGdXoyVTYyRlBxdWRNYVFyZmlnbzFFaUQyTzlF?=
 =?utf-8?B?eTRjZks0cWJZTWp5NVNxajhaNVhFcTEvNm0zaUxPTmtHa2UxYXVuSE5BODFn?=
 =?utf-8?B?MFJodWRzbEd1RHh3NGhaTGdGdGRPek5zcXBxby9PSkVXdzlwU0RJS002akla?=
 =?utf-8?B?V0Vzb2tYKzFSUlcxb2NhOG5XaEtrQ1pIVzhiN1ZzaERSNDZDV3pOalpHY1dU?=
 =?utf-8?B?V3lxR1pleTExUmdjV1JhYWRrRUdVZGVxVFp4LzZSOHlDcWZpci8zY2ZIT21s?=
 =?utf-8?B?WjVNNncvOWlDckhXa1VZRm9zMlZDK2JxUXZaLzBpSUhQcGNSNGhyZnNWakFL?=
 =?utf-8?Q?KdjQnXuNgX8tG/fNnl8rfwbI5MNfMdkJIrq8KtF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d28de8-bbd1-43ea-1286-08d90b1ab317
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:25:55.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf/3ATD5jtWtsu8Mu/DqFJfLLv3CRCW9UA+re4xpL9X8y6vCB3NcIc5inVd7PMNengeSTLmQXF4uWbKCAX8eMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/21 9:01 AM, Saripalli, RK wrote:
> 
> 
> On 4/29/2021 12:38 AM, Reiji Watanabe wrote:
>>> +       if (!strcmp(str, "off")) {
>>> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>>> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>>> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>>
>> My previous suggestion about updating MSR_IA32_SPEC_CTRL meant
>> something like:
>>
>>     rdmsrl(MSR_IA32_SPEC_CTRL, current);
>>     wrmsrl(MSR_IA32_SPEC_CTRL, current | SPEC_CTRL_PSFD);
>>
>> And this is to keep the behavior of code below check_bugs().
>> (Or do you intentionally change it due to some reason ?)
>> BTW, x86_spec_ctrl_base, which is updated in psf_cmdline(),
>> would be overwritten by check_bugs() anyway as follows.
>> ---
> 
> Since psf_cmdline() directly writes to the MSR itself (and it only does this)
> if the feature is available (per CPUID), check_bugs() should be ok.
> 
> My patch for now does not depend on the value of x86_spec_ctrl_base after psf_cmdline()
> finishes execution.

Reiji is correct. What if BIOS has set some other bits in SPEC_CTRL (now
or in the future) as part of setup. You will effectively be zeroing them
out. The correct method is as he has documented, by reading the MSR,
or'ing in the PSFD bit and writing the MSR.

Thanks,
Tom

> 
>> void __init check_bugs(void)
>> {
>>         <...>
>>         /*
>>          * Read the SPEC_CTRL MSR to account for reserved bits which may
>>          * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>>          * init code as it is not enumerated and depends on the family.
>>          */
>>         if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>>                 rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>>         <...>
>> ---
>>
>>> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);
>>
>> Does X86_FEATURE_PSFD need to be cleared for the 'off' case ?
>> Do you want to remove "psfd" from /proc/cpuinfo
>> when PSFD is enabled ? (not when PSFD is disabled ?)
>>
>>
> No, it should not be cleared, I agree.
> But I did test with KVM (with my patch that is not here) and I do not see
> issues (meaning user space guest in QEMU is seeing PSF CPUID guest capability)
> 
> I see no reason to clear this feature and I will submit a new patch with this and other changes.
> 
>> Thanks,
>> Reiji
>>
