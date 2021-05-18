Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743303878AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbhERM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:29:12 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:34784
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349082AbhERM3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOwPwjUNKc6aib11E5Ny5VEh6CslOE71tamHCcjf3ikkfDX8mfN04RaxLfb6gPuZUPHSD8hHAxG6X5i/4mG+xaupk3WmH2dVw7IJkrX6x65NUMCrLlet2i66f3DPL3yB0d2dg+NHN/ffnhjao+NEmHhGykzoRmj+5hgnLBn5Eo4hLahuymfMtyHU5/g4fDS19HTVjSzZ6KjbzVJx6Qp72itn9nWUqL98HbLwpNBLP6vie8IE+MJ3ihOf7yp94Bbl007sMYOJ4nccOS3AAQjIVb6BOABbTTSbnydszr6o+fkWkJazBKs0c0nFfOde0z+yyM/vxHFU8aHIZhchdGZDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHPYyrs5KjxXl8Z3W+WkZNoIXGJkf9EeFNgjoE97siw=;
 b=Ho90v/x7ZJ/Io5gyhWDYsRqdFl/Sp44HgguCu6FGTsQBgJWBp4eo+t+uigomlebpZZVrbeYO1e2FpkQ1jEr4iiEpX51oM1LeGXIT1kJJ4uox2ryrn7okVaF3UvpBntW8NaD5a4deQBcNeScgnBelJYhyytI7iuhp1dI3fh1aHzZL0U1Y4T+rcduwlNyR+lN2hfSmDZBuzHWLC0uGY5wf0VZ6g1bWn+rGcVBfMw+PLnJ21KY4B17F+JhxkmIoeG5hvSpNqrnWMH/YG8eXgTorUvTHNngSgjieOSh01wClXJIdLlH6P7x3PulbgcXUGsvGtTt5cEdfvghiqjXY5bo45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHPYyrs5KjxXl8Z3W+WkZNoIXGJkf9EeFNgjoE97siw=;
 b=noVdWdwuAVIJwaoVxRaE8IbspOfWtkJB82I8eNz2+5zrcuf5WBzjZ1ERuwz9WMV1zVYJopPsWcMNtFwlvui0D97qMEbLSJ8l+9X/iHkRfrOQbyEWqtuycKZZeBVFlEd2S4vVI3VPnN66NvjdE2QOCt/fKKMCTVhGGgORPtkBc4g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR1201MB2475.namprd12.prod.outlook.com (2603:10b6:3:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Tue, 18 May 2021 12:27:49 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 12:27:49 +0000
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
 <20c6fa3d-949d-156a-6d74-89829e3bffdf@infradead.org>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <5fee3f12-27f3-3984-ce33-60734190ff0c@amd.com>
Date:   Tue, 18 May 2021 07:27:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20c6fa3d-949d-156a-6d74-89829e3bffdf@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.215.231.172]
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.14] (69.215.231.172) by SA9PR13CA0161.namprd13.prod.outlook.com (2603:10b6:806:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Tue, 18 May 2021 12:27:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c6a725-10a8-44c7-3cc8-08d919f85922
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2475:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2475C51489DDD59103D97DE29B2C9@DM5PR1201MB2475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+3xcptMUGMrYgx+EEfc63wub/GYIISlwADt2dsgUS2BwPkONjYBt+poPfCP8SManUrjvVFhorYaf9/lX6DEnn474he60AmXApMgFpLzUr9xHBFUIQXl7bRsZMTuqQgIs0Yh180UrTlvTcrcvHUTmVkoIlPzcjdHo78IEJ5zFgNVxqWWFQQzoFjMZs0ikhcNg+VmzkBfu/PkqaXLQoFD8/VR4FGJce7Hxr55GtKVuDGQbZYrk0kX/bZtAllilvsq4VQ+yF2zZG3f73pzCQTiZtMCknpyCnrPlowlY2L/z8ZqgeeeCq7qfuRZPI8/+dDHbnQ0kOM6acViIMzds3dIx8WnYe4RF+RVMZqrkS5ULx39/IgQ3O2Tk5NRIoLaivdpZb//DJBkPGDM5M06U6QXhI+iuXXaq/ryuMuczu72uKN+KV9ceXBKeprlSe45V7Jw1Mxud0KCeXx/xP+vvaFCrCGZUgvQwVT7AdVRv6Aia59I57nEXJNIEhjPuSX7qC9sr2ie8kEe6i1VG6MRScueQ5W0PewzCpLcw6TA+4WNO23hSxtqIxC3fjxQTuP0C7MOxD5axhcVDZ7JX5t6laRaMTzES1jy14tY7iP8ZWoSwYOwBw9IIK4AV4ojTblPHv8F/5WdRRW0wxbcPvBZmwlMuXIoQQsUe2V1quMHJyF8bLEIA90kDsrbf6HXNobon5RG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(478600001)(66476007)(36756003)(66946007)(8676002)(53546011)(66556008)(31686004)(956004)(2616005)(26005)(8936002)(2906002)(16576012)(4326008)(31696002)(38100700002)(110136005)(316002)(5660300002)(6486002)(186003)(83380400001)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmlLSFVYNldHd1hkaCt5eWVaK3hEdVhhREpUTkMxZGhtOUt2Wk5MWFlHSC96?=
 =?utf-8?B?ek1BQjZUallDSDdnenNscW5GeWZnUHFGZGhUMWN1SisxWEJrR1VVaWVQSHVW?=
 =?utf-8?B?QW9WSzBwTVZmYzBUdDc0Vkt5cmdsNEM5a3VTY2c2M2wrOG4yMWluSCtuZnZZ?=
 =?utf-8?B?dHJaQU1Fbng1ZHpiQVcyUTJoK3NVVk5kTWorcGVMSFl6azM4MUhqTlRZQXdu?=
 =?utf-8?B?a09wYWNhVHVTL29HREo0SEVYSHhvZXIvbE1UQ0x6VVZFeG90MlVoS0xSYmEr?=
 =?utf-8?B?bjc2K0NDVXo1akdKYlJhVGlmVFMyeUw1R21JUFBCMkFpME84WTdpTlRyOE8z?=
 =?utf-8?B?WDdIQXp1RE53QTZmeGpETUVNL2hOdjhaazlVajNTQm5nczViZ0lPZXBIMEc4?=
 =?utf-8?B?bWh3YmVzRHpTRWRLNEp5Y2xBdVYxOXJEUm5JZXVTdkNhZVNEcU0xbTZMamtH?=
 =?utf-8?B?em8wKy9kZ2UxWnhtV1N6SGRHbVdLS3hhaCtvQWhNQTVKU0YvQU8ycVJDSmll?=
 =?utf-8?B?VE1jK3czRTJoYzdNYXpyb3lFdHhiQWZUQ3JObzFIcGMzNXBLcHU0OUx3enMv?=
 =?utf-8?B?Y3lYU0pheUowYjQ4UDQxUzZweTJlelhYY2Y4aXBOTG16bVVqbmNPVkhOTFQy?=
 =?utf-8?B?Q2VrQWdTZDlCWGJyUUhpN0hxTFZCNlF2dkVZMGJDMVppS0ZmQXBUWHIzMHpl?=
 =?utf-8?B?NllmK2EzWHhGRXJTdm53dm15Ri9VbUZpcnlkOEJXY2VuMk5UK09MbjdQSTI3?=
 =?utf-8?B?bUZYdnBSUWlMQm0yR0ExcmViWXhXNWhueExNZ1NSZzNLR3I1dzZGODJMYnBC?=
 =?utf-8?B?L09OQUxiUkU3WHlZTUxKSGYyZmpieEswcTZuVDdqcFVITHc4YkhKVWYyQkhU?=
 =?utf-8?B?SlFQZXJxbVVCaTRiU3E4cFlwbjVuNVlLV1g3dldINFVrZlMxdUhxSHBjM1Qz?=
 =?utf-8?B?NTlSV0RIL1VOaUgzemQwQnkydTNRMXdpODg4dlltczFMcmhheks2cGlvVUI2?=
 =?utf-8?B?OUxTenBNeCtWSXVYRmR3U21OVGtHM3JzUmw4MkhuMGpZOFhxQVNtdzVnZ0ND?=
 =?utf-8?B?a2RQNkM4TG1GRENLeHFnYWpWY2QwYTlyZjJSL0V0VFptRmkrQmhrSmFmNm5y?=
 =?utf-8?B?akp0Q0hmWnAwajZvQTRwOGZvYllGdy9BS1MxYUg5cGdjekdVT1FoZ1RnYzV4?=
 =?utf-8?B?L1FpaklJMUw1TnVRWWR4ajhkNEtWVWk3RGpOVGFYbERZR2lVb1lsVk94V21P?=
 =?utf-8?B?ZWluNU1YSnhwb3NpNVJkK0ozZlFvMmd4c2FveFVsaG0rVlNnRndIdTJCbXVL?=
 =?utf-8?B?QUUybGR5M2dYS3hlMjh2b0NJOFpmNVF4NXlIM3RPK0lTRFcwNVNyWmVldFI5?=
 =?utf-8?B?M3dsV2JjeW5EckhlakphSm9VdERNM3BockZwY1JncmxzdHRKZVgxbFE1cm5C?=
 =?utf-8?B?b0Rlcy81aEg4UlFPeUw3djNndU16ZTlscjZCRGF6Zkw1TVlyZG1GQ01CeG04?=
 =?utf-8?B?UHFUTGJqRUsycGt6NjEySGZReVFrNzFpYlZ1eWtCN3pyQXF1T2E0ck5FamxK?=
 =?utf-8?B?VWdhd2w0c2JJcDhXVVJtZ0hUL1poUWpvUTBISUZGeVhtOVl6LzNHd2dxVFJz?=
 =?utf-8?B?VjNuWTZhLzl4WkZ5S3NPM28ySGJyTFYzVGl4Um5BUGwyUUJNalVjTTY1M1Bv?=
 =?utf-8?B?c0k0b3BsOGo4NFZ1RUlHL0ZIUkhuVXl6cGxsYk84d1BHeU5CVEMyTlg4azEv?=
 =?utf-8?Q?hxuP86wxwkM6EXiB+2X/LY5CqmPXpw0QH682HKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c6a725-10a8-44c7-3cc8-08d919f85922
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 12:27:48.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO7Gl2BHRDo1QYDMou2iqTYhKrARf6+LNN2ZlUNvSmliYkm2fVqGg3L7qukCkr7r4Kil9S1pkKFQXbCUy+/UBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2021 9:55 PM, Randy Dunlap wrote:
> Hi again,
> 
> On 5/17/21 3:00 PM, Ramakrishna Saripalli wrote:
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
> ...
> 
>>
>> Kernel parameter predictive_store_fwd_disable has the following values
>>
>> - on. Disable PSF on all CPUs.
>>
>> - off. Enable PSF on all CPUs.
>>        This is also the default setting.
>>
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 +
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/msr-index.h              |  2 +
>>  arch/x86/include/asm/nospec-branch.h          |  6 ++
>>  arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
>>  5 files changed, 108 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..a5f694dccb24 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3940,6 +3940,11 @@
>>  			Format: {"off"}
>>  			Disable Hardware Transactional Memory
>>  
>> +	predictive_store_fwd_disable=	[X86] This option controls PSF.
>> +			off - Turns on PSF.
>> +			on  - Turns off PSF.
>> +			default : off.
> 
> 
> and as I did earlier, I still object to "off" meaning PSF is on
> and "on" meaning that PSF is off.
> 
> It's not at all user friendly.
> 
> If it's done this way because that's how the h/w bit is defined/used,
> that's not a good excuse IMHO.
> 
> Hm, it sorta seems to be a common "theme" when dealing with mitigations.
> And too late to fix that.

Based on previous feedback from Thomas Gleixner, I reworded this as a mitigation instead of as a "feature".
In that vein, all the mitigation code moved into bugs.c like other mitigations, similar to
spec_control_bypass_disable with an ON/OFF but no prctl/seccomp/auto.


> 
> I look forward to h/w that doesn't need mitigations.  ;)
> 
