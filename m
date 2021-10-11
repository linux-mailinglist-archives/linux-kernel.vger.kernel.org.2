Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BC428856
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhJKIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:09:01 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:25185
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231300AbhJKIJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Rc2Dih3BmxzZ/FAlx2R1eCQDQ3DBsaF1hxWeyxqNQbC5mCilMv49g/W+CVDdZCvuzM3YPlS0ZGSzIf0y0ZpUSguAWGdUDzofsQN3RmQt7trKhMSvUL4/LfJfI3yDoOQfz70KCfzJO6JEm8tcbJrSQqhNBFG5Hp7dGZXurimu74IaMEhTQNqvw4cpGxywOlQXJBGhhKkpPA/As+xFzcd+Syi0H5vxLGfsaCsTmmK6ctziYUyDh5+dDcVIM3jQsu3dXn+VTB2PNIWV0ZflOXCBOp+63zOEVAWgqhY9az1GFS6eZYkbeWX8e6Mp1UwCENqkgcaHvO3EkHliiG11Zg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsWKwyLeZoFhwbyXQjEel+E+H2cWalQqmw5dAjvSxlM=;
 b=JV/b3Y/FaZYqAL6z+ciS4ssWS6JJHUw+KoB2si392EDlaVrDxMRngmvjWB7CwuFi3nxVbge/wkY4PTjy7qsZVTQfhj/MpSMHkrxlMJPyskyKY2SEzcBNrb244sRkozb4OH2N1RmA8a9RveEonTJjx6HOaP/KcOPE9yrLPBVuw/1aCvsQvnq2uJeuGGwvUgtnlAQyE0wcuV2MZ5K+4pG0JTNkwU5jkHM5L71oOb86AwVq8t13F4UjU0dtkGWE2XxAI8NNcHkohGXrTMqCYttDagjXVwM0K06y1UUIbEqsKdzSHSpjMeE3qfbvRpQlbcWVP3Aa4PuMU2ibAs+hHcCjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsWKwyLeZoFhwbyXQjEel+E+H2cWalQqmw5dAjvSxlM=;
 b=EVaNGaLELwksLlXcwqPdvCg8NDQ7LOVI/+5t+RJ2NXFcnXz/ilDqCPQH0Hpbf0D8DnVlfdnvv50ru54GY0MrCgDaNDuP0q3MGsm1IwrfKOnpmaqgmiqGPBcQupMetAZ8xyRfn/Wz5Kb1ibwBr5yWwlgtZUlc6WQYJPzpgFWJnX8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 08:06:58 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e887:8ff6:34b5:99b3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e887:8ff6:34b5:99b3%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:06:58 +0000
Subject: Re: [PATCH 13/13] ASoC: amd: enable yc machine driver build
To:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        Richard.Gong@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
 <20211011055621.13240-14-Vijendar.Mukunda@amd.com>
 <7d58fea8-cd45-c25d-300f-1e7438079c94@infradead.org>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <b104b4e6-dfed-59ea-f9ec-90c0f2c103c8@amd.com>
Date:   Mon, 11 Oct 2021 13:55:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7d58fea8-cd45-c25d-300f-1e7438079c94@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
Received: from [10.129.9.123] (165.204.159.251) by PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Mon, 11 Oct 2021 08:06:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3529b95-b9c8-4cf2-5a96-08d98c8e18d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB446534DB5D909AEE8E44142397B59@DM6PR12MB4465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpqPLMmDgCgDUQra5eZ3rFWfNjCbSHiiRYCLKNygsGBZzcCT8CFl1EjVpg+oqzZuUhEGVC83+nDAU9nQRkbKU5W412OkuMetZiMxGMe3M7CQ5oH0Md7J2CqGtHQsPEAu8fwugRRZExQwCUYF1zLr9AkL/vDF0RjE3QZqub9Co6xLW+3q9uF9KPLQ/DbA6l8a2efr/JChgpPkr2DZYObWT0cLUl8k969PKUwIeb+fKsSXhnIDd/WDnJzFb6sRDJcRmB4c4efDjYOatf7a9yZj8uKLiGY+l0V07hZVHGUY05zTAaIfxsZwl9YdDarjgWSXFdOgoeSTptxfsF83XjQMDH40WjXXWKrzFroQIXnEV11oToclKg1p1T/P06ZejBp561a9pwuSwmw8hFc2j4T488bR1F0BuufhRz6JM7hKg7ROEBs4DSkFTCzNl/taZCdJSTRmGaoLlqi+FXqZHAbjAlLRDF5gaITtYcHhw5OK2HE0rjl5bUSW0JNfKm+Sk/+5H9eZFChc8Rhey/PKo1shrxs12wYQ3b+a4A3YF9UwE7lLphJG5S2UKm2NToAvlPEJ++N2B+MWRgS5NXToAkV90HOAI4gi67RyXDwQBCv0EiJ4OUAdceGLYKnnT215sMMTNnKaVVVlHCvGljCnu+ZaFgtb1ibynJycruxT/et7vRqZGhJYrcs2e5Pwhdz4qZaJdb2gBuC8pVjSl6f0C4m2sOkC2sHa0LzUBEjKG3Y4vIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(6486002)(508600001)(2616005)(316002)(36756003)(2906002)(53546011)(66476007)(4326008)(66556008)(8936002)(5660300002)(66946007)(38100700002)(26005)(31696002)(31686004)(8676002)(186003)(16576012)(956004)(54906003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JGYVBUWjAzTVJ0WEgrRGcrUzFrbjBiN2RybHR6RjBBNUpFM3ZnaXZFSXhS?=
 =?utf-8?B?WE83eSt3S2E5azMzZDNtR0M1S0I3M0FDZUVtbHE2d0t5WktQZldseGNLbE80?=
 =?utf-8?B?TFM5SGgxMGdIQzdLTVpvcXVRRzNzdm5TdUlBMk1uYXVxWGVTOUNuYmlnczRl?=
 =?utf-8?B?S2MyRzMrZ29kR3J2bUZZK3V1SHp0aGRTRDh6YStsMVdWM2lJajNIUHdXR1dt?=
 =?utf-8?B?cWIyclNqL29BeVh5YnRhWjJLS25iK3VwbTFadkllN2ZzVEViTFpwQkl2Umlm?=
 =?utf-8?B?YXFlajNjZFVVQWE5NVNubUdwMW5lSlFHVFg4TEUyNmJBTHNlOWcwSHZuZFlH?=
 =?utf-8?B?TVpCL0lmR2lKQnJLbVpRcS8yanpGM0hDNVN0REVBVWcrUTdNc05FN1NEYTRF?=
 =?utf-8?B?RjRzclBzWEZGaEhMaHQ4Y3NGMEJ0bVNaN2QyaVZtZkhMT1kwUmxSeWJrbGZS?=
 =?utf-8?B?MU1Vb2prZ1dEZHp6eXMvK2xkZnhzOCtaeC83RWVPV3BZUzFWcVhxZU1hcnNL?=
 =?utf-8?B?Um9zK1c5S3VSL1MwRTVWLzN4dkFOZGdpUmY2dHZNYTI1R0RhcWZWa3JsMlZP?=
 =?utf-8?B?amxxSTdySkhrZGZOSG5LMnc0c3owWngxM0dEVndKb3pYZ0grUEo5d3FHSnBr?=
 =?utf-8?B?ZEhoTjFpVmhIQ3FOL2tDMWU5NG1uSy9ndDB6RzFJRUNHeTl0NkZ0WnN0VXox?=
 =?utf-8?B?TGlkaTdSYXV6MTZqMjIxWGNFVkJqZVZLM3o3S0dSc3RuMnRPcVM3a3dLWVEr?=
 =?utf-8?B?Vmxwdkt0RXNranduK2NvaVR6UmxEa1MxOS9wM2pIcEhPcXJOT3cyU2Y3NnRH?=
 =?utf-8?B?c2lBRzJONCs4S2VMUlAzSWtKWjlIYXlJUklJV3cxUlp2bjBzTnR4VmIxVGRU?=
 =?utf-8?B?aEZ3b1UxdzNhOEpXM3NjNEw4VTB5ek1FZll5TmwwZURzT3RReWE2SXNrZTdF?=
 =?utf-8?B?Y2Q4bXFEdkJiZWpQUEFPckx2YXlPYVFmSFBjanEwZzN6bjNHenlZWFlKLzVu?=
 =?utf-8?B?NEpQZTFWMUhOcEZVanFheXJrK20xY1VIckhsNkxLRFp5R0VmNExIa3pYalRt?=
 =?utf-8?B?V1MrV0k3SzFjdTNPNnNKVnFNTkU5akd5bkRBbHhQMmZvQ2dtRmE0RTllbldl?=
 =?utf-8?B?TENkWHR6WXIrYTZPZjVBYUxiSk02SjR4eHdGSmxPcVU1NmhNbUJBNVE4TjhK?=
 =?utf-8?B?SUNxQnc3VlpsUmlyaVcyMEpQWmNzUXI0elZJTllmZ05vcmlCU3lBZ3VqSUxU?=
 =?utf-8?B?MmRFVytIV1k4TWhjRUQzUUVBWmE4OFNjZGJ0UnZEaVpPVDNyUFQra0ptNVVY?=
 =?utf-8?B?U2hkaTlyMFZ5bW1sNTVlYjdZbFNRVEVyMjZlOVQzNEM5TFFaNEd6dVBOc1ZE?=
 =?utf-8?B?UEdYYStrKzByUVlxNWpwT2NDTWpIU3podWk5enBzMHUycUp3VG1Lc01yS1R0?=
 =?utf-8?B?Z1J2UVVWR2lUKzR0QW9Cc0loaFVKRlFQTVFyUjJPRXdZa0NTQzl0MHJzUVFO?=
 =?utf-8?B?V0hkRDFsZi9zdnY3SVVBc2UrTk1CTEhhZTNqSXhYM1U0cHpFZnpEODI5bDBH?=
 =?utf-8?B?R2RUM3VlaUNrTTdDOXdBN1cvZDRPbEprT2o4a1RRWFJIcU9UcU1MOEZGVFV1?=
 =?utf-8?B?bTR2WWwvNlNQN3BMUXBSZTV5anVMQTZrdklONG8rVytuMWx0SU1RWkx4OUVS?=
 =?utf-8?B?am9MSWk4SlB6dEsxYVFVKzZ5TUtOTnI0alVnekxMbWZ6NnU1aUZ6QXlsbHg5?=
 =?utf-8?Q?rqi4iotiavs+zkBtyWhT89WcIyhihn8uUkceZSg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3529b95-b9c8-4cf2-5a96-08d98c8e18d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:06:58.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYfVbkPS+D3csdjVfC9htkcLERLFLxRGGB0JaRhWJfP/R3vWBZ3/Hb99jOxiVp2HWKZw834xgWTKZP/ncJ5mMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 1:25 PM, Randy Dunlap wrote:
> On 10/10/21 10:56 PM, Vijendar Mukunda wrote:
>> Enable YC platform dmic machine driver build.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>   sound/soc/amd/Kconfig     | 7 +++++++
>>   sound/soc/amd/yc/Makefile | 2 ++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
>> index 42825e8ad2ad..864d80f14421 100644
>> --- a/sound/soc/amd/Kconfig
>> +++ b/sound/soc/amd/Kconfig
>> @@ -67,3 +67,10 @@ config SND_SOC_AMD_ACP6x
>>       depends on X86 && PCI
>>       help
>>        This option enables ACP v6.x DMIC support on AMD platform
>> +
> 
> For the help text above here and the one below:
> 
> a. End the sentence with a period ('.').
> 
> b. Pay attention to the documented/accepted kernel style:
> 
> (from Documentation/process/coding-style.rst, section 10):
> 
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
> 
Will fix it and post the new version.

>> +config SND_SOC_AMD_YC_MACH
>> +        tristate "AMD YC support for DMIC"
>> +        select SND_SOC_DMIC
>> +        depends on SND_SOC_AMD_ACP6x
>> +        help
>> +         This option enables machine driver for DMIC endpoint
> 
> 
> thanks.

