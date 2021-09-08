Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A8403317
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbhIHDx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:53:29 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:55776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232366AbhIHDx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsSR5tNsAcGO1QLrg0n1X5xge0qP6bePv6qYcBYOVyHPoYbI4/6Anv/4lrzURX82g8K3miVOgQdAIHPZqljnf+txoBBBHrkc7+0F6YUVASNZkB+Jfe0RdJaIwge9VxvvGk4szaPg82kK5J98VY1Ogp9XuLfXSCzkPCtEIT2aK4hk9bZdb6TZsiM/heHzTn7Zj8AWSWSV8YQIUfXXcppnmgY4N38tDxwuoyOPqpmUbNMunXWz0A+u4mt00n4WOoxktLseZDHbZR6k1gAgd9dQaEdCTC8Ak9DfRPk+clhgvmdqV+rV2xGlOWg5+G0KMe32q0areVix2jFeuLzqHLwv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+tZqLGmIu4qsYXv0ELh6QY+B1o0EK5W2BviFiPSrFn4=;
 b=WoasAbeXWoSTCcEs8Jf3KEdz7SbSsdxPnKKRKx1ip/nfhaSfDU5vuGFwPxsekT5j03VbHxUwKw0Ykl4Z0h0aCsmtyRHmG6kHnq4PLSXFL7wlK+vvFzwVJlPdfU4lw3QnS+gIlLEjSXZJUUdjLc/0DwQkJAHvMQRVmsBVVD3oU/ZtzeEZIf+EZRytiIQukQxuiIcGHVTRZmk7qDLCFob2wMxNRJiOURfryCqBUb/74/0dw+6e2VMBxM406poAK/glsuHUDOGm4RZfhVSaxzqUcZjnYq+WmbyjEuVwIp8phPJPIwdc5mGWVzibg6an4lyKqpKNmBE0yLufDhvXsMuq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tZqLGmIu4qsYXv0ELh6QY+B1o0EK5W2BviFiPSrFn4=;
 b=qrGdD+FvjzjnNuJxf4W1EXQB78iO4aUgPAaq5+ViveVNTG94xaw4qG/ZYM29YCjEMmBxvioB8oCXAsjvr8dyfA14OgPTlZ214yvMPHoOeN7J+qD34bBHpe0x4T369J34IPXaej5xRzeBdFHz4J86a2oBwZiZWrvEgxMuu1Di+ng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 03:52:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 03:52:18 +0000
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
From:   Harry Wentland <harry.wentland@amd.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx@lists.freedesktop.org
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
 <CAHk-=wh37UWTqUzbh5qg_x9pFgqBVwpdq_Kf+hnB5mqEUkrjmg@mail.gmail.com>
 <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com>
Message-ID: <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
Date:   Tue, 7 Sep 2021 23:52:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com>
Content-Type: multipart/mixed;
 boundary="------------99E2F0ECD613DF830129E884"
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (209.195.106.179) by YQBPR0101CA0270.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:68::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 03:52:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a155e2-74c5-4eac-0887-08d9727c0d8a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5428AC71B5B5378E2D0D15868CD49@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKyR4Tqj8jmdYgpU2DEldm4mGjUnSNAwvC8T7E/tPmTK8eGWA442SIm6FWpQwwE23Vplpiy7Rg2qXNn5LQErwU7xvsbfP/9vhVYNz0NUVL2YNlSEoXN+NhSqUOAYPAwV7TlEIx8TMUcAFX/VyBLqflDhLQOWN3zoLOCyM+R6cwLWSbEHM2iB5h0KWSoI9Pxn0uf7WZ/N/Ros5RHTmoV3iS2iampfb//X871rsmYeyNsYtVUo/8m76OCn9r5/LpjcBWeqD3rRB6FMcILbkbVkWvADHsHfPW4VR1yVksTnAs0IesvfjSGUwKk+PtnN4UDDs+7wGrTtN//OM9DZ7jdJSDh7xtZTjsfmnerj9K6KPHL7UQAwUWcVaLQL1vdBMXwGdSVpmoHPGVj+4lxMcaRtpHEj2vnMmrAgmv2+asPOUkR+BcYAbfqBzz6vvBXwm5JqeWO7kc9RhoUKue38Ju25mul+UYmGfWHqH8vpRGK7uz6k7Waus9M8XZcGgw0u5HRiPjgXDwpa88u85ErVQ1ui6EL5AgxkCYxRajejUHWeX/txz2m5BhUvUWuWv8VLPuIas9aqqBv5hb4NXbpiOCL13MRnWEyRADaDu5Yo4gI1cExSg/vhHm6Y9354LKdT421mSZ0r0qpvQGVcXZrV+CDZDwoX5kPiIBc9W9w6XMK5AktNS0+RzwTKIaHaawB/5u3r7VPPIWYXUTDxEUYH7DaujwF3SmplNIqvfhdHjGznFeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(86362001)(316002)(4326008)(8936002)(5660300002)(186003)(110136005)(16576012)(478600001)(6666004)(235185007)(36756003)(31696002)(44832011)(8676002)(53546011)(33964004)(38100700002)(2906002)(956004)(31686004)(26005)(54906003)(6636002)(66476007)(66556008)(66576008)(6486002)(66946007)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1V6a2lzVU52Y1B5L0o1cExhbUE5ZkhzS3dOa0p1eWkzTmRWUHU5cjY1ZUZ5?=
 =?utf-8?B?WWRwMXlxOUI2K3g2OWg2Mm5JbXlOVUl5U0ZHaFBSSXZGRGJEdXRWSTNTN3lp?=
 =?utf-8?B?a2NPa2JRM1BxMm9rSnVqMkcxQVVlUFRkNTJCMkRhOWxoejJUQ3BXcWM2RXJp?=
 =?utf-8?B?Z2REYnROSzl5bFUySEo3aWI3TjMvSFVJSnpKVEZBaDNPTXZWYy9kYzUyV2FU?=
 =?utf-8?B?UUQ4U0FmU1M5VDRHVHh1WXhVREpQbkJyM21kNHc3VXZKTkxHYzR0dkhkYVdH?=
 =?utf-8?B?Tld2SGJwZHowbzRxRHA0bjQydUFpTGlqbXJ3T0VFR25DdkdwMEM2dWt6WjBj?=
 =?utf-8?B?Q25lYTJiUTMwRUZEM0JNZ2srbzVMQXFFQklZYXltUnJoaVVYZW91S205RGNN?=
 =?utf-8?B?UVRvZFk4SHoweDFLTkhFYU4ydWNjQ25VNmVOMUszZlFoZFVDa2IvTjUxeE9q?=
 =?utf-8?B?NGMremlndFFDblBMYm9EWnBVS0JiYldsSmZKckFPSnNQVEtOQ0lCdkl5cE8w?=
 =?utf-8?B?bktIUzl5djJLUFhENVdVTmpmMTk5akVVN1kvdStNVDBHaHpnN1NYSWVqS2Jl?=
 =?utf-8?B?L3NPQ2MycGhrY2hFeWVFMXY4MmYwbExjMUxNOWt5ZHFKL0poOTRnNTdzSVdt?=
 =?utf-8?B?eDgwRkVXTFlGR2N0c0N4Wm1MRFRSZVhEcWpaVjRYY2w2OEo4c1EwNkQzTXdT?=
 =?utf-8?B?QW8xTWZ0WVQ4KzRnMWJQbStVWmROSCtSbGUySjlQU2tFK0tyd3ZqSERXQ2d4?=
 =?utf-8?B?bzRYTlp2L0ZHVUpGdXJMTUxzc2QxU1dIcjZqOFZSei9FYmdEUDcwbWZ0RXE5?=
 =?utf-8?B?NnB6SHg3T1Q5YVpWWXJpNWMwUUxaVWJNQ09pcnd5THdhUnQxUnJHZEd1TFNv?=
 =?utf-8?B?VE93NFNsSnluYmtORlJUUGdJZFlqMUpORmhxKzcyQjVHWE51UFlhSU9KeGpD?=
 =?utf-8?B?ZUsxMElLL2tSbFpaR1o4N3pOTlFjYXVoZ1dsdE5OVTZ2VytDRGdwNyt5MS9a?=
 =?utf-8?B?Yitwemx1Wm9hejZxMmlNQThEL3pHbm92c3IvTGhLTE9jZGNCSnVNQXpNUW9F?=
 =?utf-8?B?Skw5N2lFdjhZb3l6VWE2bEtlYmpobkpaZzdFM1ZubFRrSnpCRmRmN1Qxc2sx?=
 =?utf-8?B?K0ZaeHFLc1ZKMFM4TjdQSWtHNmIvR2F4OEFPbGd4cnloaXEvY2tCQm41aWlL?=
 =?utf-8?B?RElQUkJjR2c2ei9LWE9WaXF1VnhpM0xNVFZjYlQ4YTVjNUdnckI3MGZCNTZH?=
 =?utf-8?B?RGxyOUFCK1greEhYM2FRNGt4QjFSWjJhcFo0WENTajZRZnVZaEt2UEdrMXNJ?=
 =?utf-8?B?MGxOcysvSzJxRFBNVlEyMjJFdzljVkl6MnNQRE5HeldNN2Z2OE9raE1zYm5G?=
 =?utf-8?B?b3dtV1QrdS93THZJSUhlYVNhRVRYYlRhcy9hSU5RWDZOUTJBQ1ZKQUxXa3BN?=
 =?utf-8?B?WFlydkJMOHYzejR4ZFh3U1B1WjJJY2cvZzFIeVRzaEpvMzFrV0Y2SEVqSjVv?=
 =?utf-8?B?aVZZaStkYXZwOHNZK1dVV2V3Mi95K3V1OXRjR0V1amF6dkhPSE1wMjAvbDc2?=
 =?utf-8?B?dEV0T0EybGlpbTdaamZvZUlpVndkbk1kbU1Vd0I2MzRKTi9vN0RDa2VhMkcw?=
 =?utf-8?B?RzdibjVUT25jcFNIeHJ1bWMwelNWSDFQWml6T1FlWkgvMmExRVNzeWpRZDJi?=
 =?utf-8?B?aWplZlpRUkxxZ0s4cFlXR2xReHZPd3RONGREbEgzbG91eFpWYnVRZWRseTFs?=
 =?utf-8?Q?/nCf2QJRli5pRATQ7RSAqEqupanWS14QV2904oj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a155e2-74c5-4eac-0887-08d9727c0d8a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 03:52:18.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TE8R6Ib4gLPAxE/xpzTmHsFC7MFudraR84REk4SdQIncOJlM4Touvcw0AGOKW+9K15a9xIvS6R4nT4y0kn8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------99E2F0ECD613DF830129E884
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 2021-09-07 5:07 p.m., Harry Wentland wrote:
> 
> 
> On 2021-09-07 1:33 p.m., Linus Torvalds wrote:
>> On Tue, Sep 7, 2021 at 10:10 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> Do I know why? No. I do note that that code is disgusting.
>>>
>>> It's passing one of those structs around by value, for example. That's
>>> a 72-byte structure that is copied on the stack due to stupid calling
>>> conventions. Maybe clang generates a few extra temporaries for it as
>>> part of the function call stack setup? Who knows..
>>
>> Ooh, yes.
>>
>> This attached patch is crap - it converts the helper functions to use
>> const pointers instead of passing the whole structure, but it then
>> only converts that one file that *uses* them.
>>
>> So the end result will not compile in general, but you can do
>>
>>     make drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.o
>>
>> and it compiles for me.
>>
>> And while gcc doesn't care that much - it will apparently either
>> generate the argument stack every call - clang cares deeply.
>>
>> The nasty 720-byte stack frame that clang generates turns into just a
>> 320-byte one, and code generation in general looks a *lot* better.
>>
>> Now, as mentioned, this patch is broken and incomplete. But I really
>> think the AMD GPU people need to do this. It makes those functions go
>> from practically unusable to not horribly disgusting.
>>
>> So Harry/Leo/Alex/Christian and amd-gfx list - can you look into
>> making this ugly "make one file compile better" patch actually work
>> properly?
>>
> 
> Yes, will take a look at this tonight. We definitely shouldn't be passing
> large structs by value.
> 

Attached patches fix these x86_64 ones reported by Nick:

x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1800) exceeds limit (1280) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1352) exceeds limit (1280) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]

I'm also seeing one more that might be more challenging to fix but is nearly at 1024:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: error: stack frame size of 1064 bytes in function 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]

The attached patches build and boot without error or warning on a Radeon RX 5500 XT.

Harry

> Harry
> 
>> It *looks* lto me ike that code was perhaps written for a C++ compiler
>> and the helpers have been written as a "pass by reference", and the
>> arguments used to be
>>
>>      const display_data_rq_misc_params_st& rq_misc_param
>>
>> and then the compiler will pass the argument as a pointer. And then it
>> was converted to C, and the "pass by reference" in the function
>> declaration was turned into "pass by value", to avoid changing "." to
>> "->" in the use.
>>
>> But a '&arg' thing in C++ really is a '*arg' pointer in C, and should
>> have been done as that.
>>
>> Of course, it's also possible that that code was simply written by
>> somebody who didn't understand just *how* horrible it is to pass
>> structures bigger than a word or two by value.
>>
>> Do we have a compiler warning for passing big structures by value?
>>
>>                    Linus
>>
> 


--------------99E2F0ECD613DF830129E884
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amd-display-Pass-display_pipe_params_st-as-const.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amd-display-Pass-display_pipe_params_st-as-const.pa";
 filename*1="tch"

From 353a23b14584705cb194d9bfc91010caacaf42f8 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 7 Sep 2021 19:40:06 -0400
Subject: [PATCH 1/2] drm/amd/display: Pass display_pipe_params_st as const in
 DML

[Why]
This neither needs to be on the stack nor passed by value
to each function call. In fact, when building with clang
it seems to break the Linux's default 1024 byte stack
frame limit.

[How]
We can simply pass this as a const pointer.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  6 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |  4 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  6 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |  4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 62 ++++++++--------
 .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |  4 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 72 +++++++++----------
 .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |  4 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 68 +++++++++---------
 .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |  4 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |  4 +-
 12 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e3e01b17c164..4389b36f0760 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3152,7 +3152,7 @@ void dcn20_calculate_dlg_params(
 
 		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
 				&context->res_ctx.pipe_ctx[i].rq_regs,
-				pipes[pipe_idx].pipe);
+				&pipes[pipe_idx].pipe);
 		pipe_idx++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 2091dd8c252d..8c168f348a27 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -768,12 +768,12 @@ static void dml20_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 void dml20_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
 	memset(rq_regs, 0, sizeof(*rq_regs));
-	dml20_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param.src);
+	dml20_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
 	print__rq_regs_st(mode_lib, *rq_regs);
@@ -1549,7 +1549,7 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
index d0b90947f540..8b23867e97c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
@@ -43,7 +43,7 @@ struct display_mode_lib;
 void dml20_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 
 // Function: dml_rq_dlg_get_dlg_reg
@@ -61,7 +61,7 @@ void dml20_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 1a0c14e465fa..26ececfd40cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -768,12 +768,12 @@ static void dml20v2_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 void dml20v2_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
 	memset(rq_regs, 0, sizeof(*rq_regs));
-	dml20v2_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param.src);
+	dml20v2_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
 	print__rq_regs_st(mode_lib, *rq_regs);
@@ -1550,7 +1550,7 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
index 27cf8bed9376..2b4e46ea1c3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
@@ -43,7 +43,7 @@ struct display_mode_lib;
 void dml20v2_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 
 // Function: dml_rq_dlg_get_dlg_reg
@@ -61,7 +61,7 @@ void dml20v2_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 287e31052b30..736978c4d40a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -694,7 +694,7 @@ static void get_surf_rq_param(
 		display_data_rq_sizing_params_st *rq_sizing_param,
 		display_data_rq_dlg_params_st *rq_dlg_param,
 		display_data_rq_misc_params_st *rq_misc_param,
-		const display_pipe_params_st pipe_param,
+		const display_pipe_params_st *pipe_param,
 		bool is_chroma)
 {
 	bool mode_422 = false;
@@ -706,30 +706,30 @@ static void get_surf_rq_param(
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir;
 		unsigned int full_src_vp_width;
 		unsigned int hactive_half;
 		unsigned int src_hactive_half;
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_half  = pipe_param.dest.hactive / 2;
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_half  = pipe_param->dest.hactive / 2;
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_half  = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_half;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_half  = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_half;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_half  = pipe_param.scale_ratio_depth.hscl_ratio * hactive_half;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_half  = pipe_param->scale_ratio_depth.hscl_ratio * hactive_half;
 		}
 
 		if (access_dir == 0) {
@@ -754,7 +754,7 @@ static void get_surf_rq_param(
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -768,23 +768,23 @@ static void get_surf_rq_param(
 			vp_height,
 			data_pitch,
 			meta_pitch,
-			pipe_param.src.source_format,
-			pipe_param.src.sw_mode,
-			pipe_param.src.macro_tile_size,
-			pipe_param.src.source_scan,
-			pipe_param.src.hostvm,
+			pipe_param->src.source_format,
+			pipe_param->src.sw_mode,
+			pipe_param->src.macro_tile_size,
+			pipe_param->src.source_scan,
+			pipe_param->src.hostvm,
 			is_chroma);
 }
 
 static void dml_rq_dlg_get_rq_params(
 		struct display_mode_lib *mode_lib,
 		display_rq_params_st *rq_param,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8
-			|| pipe_param.src.source_format == dm_420_10;
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8
+			|| pipe_param->src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
 	get_surf_rq_param(
 			mode_lib,
@@ -794,7 +794,7 @@ static void dml_rq_dlg_get_rq_params(
 			pipe_param,
 			0);
 
-	if (is_dual_plane((enum source_format_class) (pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class) (pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(
 				mode_lib,
@@ -806,14 +806,14 @@ static void dml_rq_dlg_get_rq_params(
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
 void dml21_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
@@ -1658,7 +1658,7 @@ void dml21_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
@@ -1696,7 +1696,7 @@ void dml21_rq_dlg_get_dlg_reg(
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(
 			mode_lib,
 			e2e_pipe_param,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
index e8f7785e3fc6..af6ad0ca9cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
@@ -44,7 +44,7 @@ struct display_mode_lib;
 void dml21_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -61,7 +61,7 @@ void dml21_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 0d934fae1c3a..2120e0941a09 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -747,7 +747,7 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 	display_data_rq_sizing_params_st *rq_sizing_param,
 	display_data_rq_dlg_params_st *rq_dlg_param,
 	display_data_rq_misc_params_st *rq_misc_param,
-	const display_pipe_params_st pipe_param,
+	const display_pipe_params_st *pipe_param,
 	bool is_chroma,
 	bool is_alpha)
 {
@@ -761,32 +761,32 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
-		surface_height = pipe_param.src.surface_height_y / 2.0;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
+		surface_height = pipe_param->src.surface_height_y / 2.0;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
-		surface_height = pipe_param.src.surface_height_y;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
+		surface_height = pipe_param->src.surface_height_y;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir = 0;
 		unsigned int full_src_vp_width = 0;
 		unsigned int hactive_odm = 0;
 		unsigned int src_hactive_odm = 0;
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_odm  = pipe_param.dest.hactive / ((unsigned int)pipe_param.dest.odm_combine*2);
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_odm  = pipe_param->dest.hactive / ((unsigned int) pipe_param->dest.odm_combine*2);
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_odm  = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_odm  = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_odm;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_odm  = pipe_param.scale_ratio_depth.hscl_ratio * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_odm  = pipe_param->scale_ratio_depth.hscl_ratio * hactive_odm;
 		}
 
 		if (access_dir == 0) {
@@ -815,7 +815,7 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -828,28 +828,28 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 		vp_height,
 		data_pitch,
 		meta_pitch,
-		pipe_param.src.source_format,
-		pipe_param.src.sw_mode,
-		pipe_param.src.macro_tile_size,
-		pipe_param.src.source_scan,
-		pipe_param.src.hostvm,
+		pipe_param->src.source_format,
+		pipe_param->src.sw_mode,
+		pipe_param->src.macro_tile_size,
+		pipe_param->src.source_scan,
+		pipe_param->src.hostvm,
 		is_chroma,
 		surface_height);
 }
 
 static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 	display_rq_params_st *rq_param,
-	const display_pipe_params_st pipe_param)
+	const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8
-	|| pipe_param.src.source_format == dm_420_10
-	|| pipe_param.src.source_format == dm_rgbe_alpha
-	|| pipe_param.src.source_format == dm_420_12;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8
+	|| pipe_param->src.source_format == dm_420_10
+	|| pipe_param->src.source_format == dm_rgbe_alpha
+	|| pipe_param->src.source_format == dm_420_12;
 
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
-	rq_param->rgbe_alpha = (pipe_param.src.source_format == dm_rgbe_alpha)?1:0;
+	rq_param->rgbe_alpha = (pipe_param->src.source_format == dm_rgbe_alpha)?1:0;
 
 	get_surf_rq_param(mode_lib,
 		&(rq_param->sizing.rq_l),
@@ -859,7 +859,7 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 		0,
 		0);
 
-	if (is_dual_plane((enum source_format_class)(pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class)(pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(mode_lib,
 			&(rq_param->sizing.rq_c),
@@ -871,13 +871,13 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
 void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 	display_rq_regs_st *rq_regs,
-	const display_pipe_params_st pipe_param)
+	const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = { 0 };
 
@@ -1831,7 +1831,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	display_dlg_regs_st *dlg_regs,
 	display_ttu_regs_st *ttu_regs,
-	display_e2e_pipe_params_st *e2e_pipe_param,
+	const display_e2e_pipe_params_st *e2e_pipe_param,
 	const unsigned int num_pipes,
 	const unsigned int pipe_idx,
 	const bool cstate_en,
@@ -1866,7 +1866,7 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(mode_lib,
 		e2e_pipe_param,
 		num_pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
index c04965cceff3..625e41f8d575 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
@@ -41,7 +41,7 @@ struct display_mode_lib;
 //            See also: <display_rq_regs_st>
 void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -57,7 +57,7 @@ void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
 		display_dlg_regs_st          *dlg_regs,
 		display_ttu_regs_st          *ttu_regs,
-		display_e2e_pipe_params_st   *e2e_pipe_param,
+		const display_e2e_pipe_params_st   *e2e_pipe_param,
 		const unsigned int            num_pipes,
 		const unsigned int            pipe_idx,
 		const bool                    cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index c23905bc733a..57bd4e3f8a82 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -738,7 +738,7 @@ static void get_surf_rq_param(
 		display_data_rq_sizing_params_st *rq_sizing_param,
 		display_data_rq_dlg_params_st *rq_dlg_param,
 		display_data_rq_misc_params_st *rq_misc_param,
-		const display_pipe_params_st pipe_param,
+		const display_pipe_params_st *pipe_param,
 		bool is_chroma,
 		bool is_alpha)
 {
@@ -752,33 +752,33 @@ static void get_surf_rq_param(
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
-		surface_height = pipe_param.src.surface_height_y / 2.0;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
+		surface_height = pipe_param->src.surface_height_y / 2.0;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
-		surface_height = pipe_param.src.surface_height_y;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
+		surface_height = pipe_param->src.surface_height_y;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir;
 		unsigned int full_src_vp_width;
 		unsigned int hactive_odm;
 		unsigned int src_hactive_odm;
 
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_odm = pipe_param.dest.hactive / ((unsigned int) pipe_param.dest.odm_combine * 2);
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_odm = pipe_param->dest.hactive / ((unsigned int) pipe_param->dest.odm_combine * 2);
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_odm = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_odm = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_odm;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_odm = pipe_param.scale_ratio_depth.hscl_ratio * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_odm = pipe_param->scale_ratio_depth.hscl_ratio * hactive_odm;
 		}
 
 		if (access_dir == 0) {
@@ -808,7 +808,7 @@ static void get_surf_rq_param(
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -822,38 +822,38 @@ static void get_surf_rq_param(
 			vp_height,
 			data_pitch,
 			meta_pitch,
-			pipe_param.src.source_format,
-			pipe_param.src.sw_mode,
-			pipe_param.src.macro_tile_size,
-			pipe_param.src.source_scan,
-			pipe_param.src.hostvm,
+			pipe_param->src.source_format,
+			pipe_param->src.sw_mode,
+			pipe_param->src.macro_tile_size,
+			pipe_param->src.source_scan,
+			pipe_param->src.hostvm,
 			is_chroma,
 			surface_height);
 }
 
-static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib, display_rq_params_st *rq_param, const display_pipe_params_st pipe_param)
+static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib, display_rq_params_st *rq_param, const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8 || pipe_param.src.source_format == dm_420_10 || pipe_param.src.source_format == dm_rgbe_alpha
-			|| pipe_param.src.source_format == dm_420_12;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8 || pipe_param->src.source_format == dm_420_10 || pipe_param->src.source_format == dm_rgbe_alpha
+			|| pipe_param->src.source_format == dm_420_12;
 
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
-	rq_param->rgbe_alpha = (pipe_param.src.source_format == dm_rgbe_alpha) ? 1 : 0;
+	rq_param->rgbe_alpha = (pipe_param->src.source_format == dm_rgbe_alpha) ? 1 : 0;
 
 	get_surf_rq_param(mode_lib, &(rq_param->sizing.rq_l), &(rq_param->dlg.rq_l), &(rq_param->misc.rq_l), pipe_param, 0, 0);
 
-	if (is_dual_plane((enum source_format_class) (pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class) (pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(mode_lib, &(rq_param->sizing.rq_c), &(rq_param->dlg.rq_c), &(rq_param->misc.rq_c), pipe_param, 1, rq_param->rgbe_alpha);
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
-void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_pipe_params_st pipe_param)
+void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
@@ -1677,7 +1677,7 @@ void dml31_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
@@ -1704,7 +1704,7 @@ void dml31_rq_dlg_get_dlg_reg(
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(
 			mode_lib,
 			e2e_pipe_param,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
index adf8518f761f..8ee991351699 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
@@ -41,7 +41,7 @@ struct display_mode_lib;
 //            See also: <display_rq_regs_st>
 void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -57,7 +57,7 @@ void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 void dml31_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
 		display_dlg_regs_st          *dlg_regs,
 		display_ttu_regs_st          *ttu_regs,
-		display_e2e_pipe_params_st   *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int            num_pipes,
 		const unsigned int            pipe_idx,
 		const bool                    cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index d42a0aeca6be..72b1957022aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -49,7 +49,7 @@ struct dml_funcs {
 			struct display_mode_lib *mode_lib,
 			display_dlg_regs_st *dlg_regs,
 			display_ttu_regs_st *ttu_regs,
-			display_e2e_pipe_params_st *e2e_pipe_param,
+			const display_e2e_pipe_params_st *e2e_pipe_param,
 			const unsigned int num_pipes,
 			const unsigned int pipe_idx,
 			const bool cstate_en,
@@ -60,7 +60,7 @@ struct dml_funcs {
 	void (*rq_dlg_get_rq_reg)(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 	void (*recalculate)(struct display_mode_lib *mode_lib);
 	void (*validate)(struct display_mode_lib *mode_lib);
 };
-- 
2.33.0


--------------99E2F0ECD613DF830129E884
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-drm-amd-display-Allocate-structs-needed-by-dcn_bw_ca.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-drm-amd-display-Allocate-structs-needed-by-dcn_bw_ca.pa";
 filename*1="tch"

From eece72e18fc9afb237f11077c0c57d82c59b1d1f Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 7 Sep 2021 20:22:13 -0400
Subject: [PATCH 2/2] drm/amd/display: Allocate structs needed by
 dcn_bw_calc_rq_dlg_ttu in pipe_ctx

[Why & How]
dcn_bw_calc_rq_dlg_ttu uses a stack frame great than 1024. To solve this
we could allocate the rq_param, dlg_sys_param, and input structs
dynamically. Since this function is inside a kernel_fpu_begin()/end()
call we want to avoid memory allocation. Instead it's much
safer to pre-allocate these on the pipe_ctx.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  55 +++---
 .../display/dc/dml/dml1_display_rq_dlg_calc.c | 170 +++++++++---------
 .../display/dc/dml/dml1_display_rq_dlg_calc.h |   8 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 4 files changed, 121 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 0e18df1283b6..e64145b0a32b 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -459,9 +459,9 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = &pipe->dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = &pipe->ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st *rq_regs = &pipe->rq_regs;
-	struct _vcs_dpi_display_rq_params_st rq_param = {0};
-	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {0};
-	struct _vcs_dpi_display_e2e_pipe_params_st input = { { { 0 } } };
+	struct _vcs_dpi_display_rq_params_st *rq_param = &pipe->dml_rq_param;
+	struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param = &pipe->dml_dlg_sys_param;
+	struct _vcs_dpi_display_e2e_pipe_params_st *input = &pipe->dml_input;
 	float total_active_bw = 0;
 	float total_prefetch_bw = 0;
 	int total_flip_bytes = 0;
@@ -470,45 +470,48 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	memset(dlg_regs, 0, sizeof(*dlg_regs));
 	memset(ttu_regs, 0, sizeof(*ttu_regs));
 	memset(rq_regs, 0, sizeof(*rq_regs));
+	memset(rq_param, 0, sizeof(*rq_param));
+	memset(dlg_sys_param, 0, sizeof(*dlg_sys_param));
+	memset(input, 0, sizeof(*input));
 
 	for (i = 0; i < number_of_planes; i++) {
 		total_active_bw += v->read_bandwidth[i];
 		total_prefetch_bw += v->prefetch_bandwidth[i];
 		total_flip_bytes += v->total_immediate_flip_bytes[i];
 	}
-	dlg_sys_param.total_flip_bw = v->return_bw - dcn_bw_max2(total_active_bw, total_prefetch_bw);
-	if (dlg_sys_param.total_flip_bw < 0.0)
-		dlg_sys_param.total_flip_bw = 0;
-
-	dlg_sys_param.t_mclk_wm_us = v->dram_clock_change_watermark;
-	dlg_sys_param.t_sr_wm_us = v->stutter_enter_plus_exit_watermark;
-	dlg_sys_param.t_urg_wm_us = v->urgent_watermark;
-	dlg_sys_param.t_extra_us = v->urgent_extra_latency;
-	dlg_sys_param.deepsleep_dcfclk_mhz = v->dcf_clk_deep_sleep;
-	dlg_sys_param.total_flip_bytes = total_flip_bytes;
-
-	pipe_ctx_to_e2e_pipe_params(pipe, &input.pipe);
-	input.clks_cfg.dcfclk_mhz = v->dcfclk;
-	input.clks_cfg.dispclk_mhz = v->dispclk;
-	input.clks_cfg.dppclk_mhz = v->dppclk;
-	input.clks_cfg.refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
-	input.clks_cfg.socclk_mhz = v->socclk;
-	input.clks_cfg.voltage = v->voltage_level;
+	dlg_sys_param->total_flip_bw = v->return_bw - dcn_bw_max2(total_active_bw, total_prefetch_bw);
+	if (dlg_sys_param->total_flip_bw < 0.0)
+		dlg_sys_param->total_flip_bw = 0;
+
+	dlg_sys_param->t_mclk_wm_us = v->dram_clock_change_watermark;
+	dlg_sys_param->t_sr_wm_us = v->stutter_enter_plus_exit_watermark;
+	dlg_sys_param->t_urg_wm_us = v->urgent_watermark;
+	dlg_sys_param->t_extra_us = v->urgent_extra_latency;
+	dlg_sys_param->deepsleep_dcfclk_mhz = v->dcf_clk_deep_sleep;
+	dlg_sys_param->total_flip_bytes = total_flip_bytes;
+
+	pipe_ctx_to_e2e_pipe_params(pipe, &input->pipe);
+	input->clks_cfg.dcfclk_mhz = v->dcfclk;
+	input->clks_cfg.dispclk_mhz = v->dispclk;
+	input->clks_cfg.dppclk_mhz = v->dppclk;
+	input->clks_cfg.refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
+	input->clks_cfg.socclk_mhz = v->socclk;
+	input->clks_cfg.voltage = v->voltage_level;
 //	dc->dml.logger = pool->base.logger;
-	input.dout.output_format = (v->output_format[in_idx] == dcn_bw_420) ? dm_420 : dm_444;
-	input.dout.output_type  = (v->output[in_idx] == dcn_bw_hdmi) ? dm_hdmi : dm_dp;
+	input->dout.output_format = (v->output_format[in_idx] == dcn_bw_420) ? dm_420 : dm_444;
+	input->dout.output_type  = (v->output[in_idx] == dcn_bw_hdmi) ? dm_hdmi : dm_dp;
 	//input[in_idx].dout.output_standard;
 
 	/*todo: soc->sr_enter_plus_exit_time??*/
-	dlg_sys_param.t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
+	dlg_sys_param->t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
 
-	dml1_rq_dlg_get_rq_params(dml, &rq_param, input.pipe.src);
+	dml1_rq_dlg_get_rq_params(dml, rq_param, input->pipe.src);
 	dml1_extract_rq_regs(dml, rq_regs, rq_param);
 	dml1_rq_dlg_get_dlg_params(
 			dml,
 			dlg_regs,
 			ttu_regs,
-			rq_param.dlg,
+			&rq_param->dlg,
 			dlg_sys_param,
 			input,
 			true,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 8f2b1684c231..0561374cdada 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -231,22 +231,22 @@ static void extract_rq_sizing_regs(
 void dml1_extract_rq_regs(
 		struct display_mode_lib *mode_lib,
 		struct _vcs_dpi_display_rq_regs_st *rq_regs,
-		const struct _vcs_dpi_display_rq_params_st rq_param)
+		const struct _vcs_dpi_display_rq_params_st *rq_param)
 {
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
-	if (rq_param.yuv420)
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param->sizing.rq_l);
+	if (rq_param->yuv420)
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param->sizing.rq_c);
 
-	rq_regs->rq_regs_l.swath_height = dml_log2(rq_param.dlg.rq_l.swath_height);
-	rq_regs->rq_regs_c.swath_height = dml_log2(rq_param.dlg.rq_c.swath_height);
+	rq_regs->rq_regs_l.swath_height = dml_log2(rq_param->dlg.rq_l.swath_height);
+	rq_regs->rq_regs_c.swath_height = dml_log2(rq_param->dlg.rq_c.swath_height);
 
 	/* TODO: take the max between luma, chroma chunk size?
 	 * okay for now, as we are setting chunk_bytes to 8kb anyways
 	 */
-	if (rq_param.sizing.rq_l.chunk_bytes >= 32 * 1024) { /*32kb */
+	if (rq_param->sizing.rq_l.chunk_bytes >= 32 * 1024) { /*32kb */
 		rq_regs->drq_expansion_mode = 0;
 	} else {
 		rq_regs->drq_expansion_mode = 2;
@@ -255,9 +255,9 @@ void dml1_extract_rq_regs(
 	rq_regs->mrq_expansion_mode = 1;
 	rq_regs->crq_expansion_mode = 1;
 
-	if (rq_param.yuv420) {
-		if ((double) rq_param.misc.rq_l.stored_swath_bytes
-				/ (double) rq_param.misc.rq_c.stored_swath_bytes <= 1.5) {
+	if (rq_param->yuv420) {
+		if ((double) rq_param->misc.rq_l.stored_swath_bytes
+				/ (double) rq_param->misc.rq_c.stored_swath_bytes <= 1.5) {
 			detile_buf_plane1_addr = (detile_buf_size_in_bytes / 2.0 / 64.0); /* half to chroma */
 		} else {
 			detile_buf_plane1_addr = dml_round_to_multiple(
@@ -998,26 +998,26 @@ void dml1_rq_dlg_get_dlg_params(
 		struct display_mode_lib *mode_lib,
 		struct _vcs_dpi_display_dlg_regs_st *disp_dlg_regs,
 		struct _vcs_dpi_display_ttu_regs_st *disp_ttu_regs,
-		const struct _vcs_dpi_display_rq_dlg_params_st rq_dlg_param,
-		const struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param,
-		const struct _vcs_dpi_display_e2e_pipe_params_st e2e_pipe_param,
+		const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param,
+		const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param,
+		const struct _vcs_dpi_display_e2e_pipe_params_st *e2e_pipe_param,
 		const bool cstate_en,
 		const bool pstate_en,
 		const bool vm_en,
 		const bool iflip_en)
 {
 	/* Timing */
-	unsigned int htotal = e2e_pipe_param.pipe.dest.htotal;
-	unsigned int hblank_end = e2e_pipe_param.pipe.dest.hblank_end;
-	unsigned int vblank_start = e2e_pipe_param.pipe.dest.vblank_start;
-	unsigned int vblank_end = e2e_pipe_param.pipe.dest.vblank_end;
-	bool interlaced = e2e_pipe_param.pipe.dest.interlaced;
+	unsigned int htotal = e2e_pipe_param->pipe.dest.htotal;
+	unsigned int hblank_end = e2e_pipe_param->pipe.dest.hblank_end;
+	unsigned int vblank_start = e2e_pipe_param->pipe.dest.vblank_start;
+	unsigned int vblank_end = e2e_pipe_param->pipe.dest.vblank_end;
+	bool interlaced = e2e_pipe_param->pipe.dest.interlaced;
 	unsigned int min_vblank = mode_lib->ip.min_vblank_lines;
 
-	double pclk_freq_in_mhz = e2e_pipe_param.pipe.dest.pixel_rate_mhz;
-	double refclk_freq_in_mhz = e2e_pipe_param.clks_cfg.refclk_mhz;
-	double dppclk_freq_in_mhz = e2e_pipe_param.clks_cfg.dppclk_mhz;
-	double dispclk_freq_in_mhz = e2e_pipe_param.clks_cfg.dispclk_mhz;
+	double pclk_freq_in_mhz = e2e_pipe_param->pipe.dest.pixel_rate_mhz;
+	double refclk_freq_in_mhz = e2e_pipe_param->clks_cfg.refclk_mhz;
+	double dppclk_freq_in_mhz = e2e_pipe_param->clks_cfg.dppclk_mhz;
+	double dispclk_freq_in_mhz = e2e_pipe_param->clks_cfg.dispclk_mhz;
 
 	double ref_freq_to_pix_freq;
 	double prefetch_xy_calc_in_dcfclk;
@@ -1160,13 +1160,13 @@ void dml1_rq_dlg_get_dlg_params(
 	disp_dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end; /* 15 bits */
 
 	prefetch_xy_calc_in_dcfclk = 24.0; /* TODO: ip_param */
-	min_dcfclk_mhz = dlg_sys_param.deepsleep_dcfclk_mhz;
+	min_dcfclk_mhz = dlg_sys_param->deepsleep_dcfclk_mhz;
 	t_calc_us = prefetch_xy_calc_in_dcfclk / min_dcfclk_mhz;
-	min_ttu_vblank = dlg_sys_param.t_urg_wm_us;
+	min_ttu_vblank = dlg_sys_param->t_urg_wm_us;
 	if (cstate_en)
-		min_ttu_vblank = dml_max(dlg_sys_param.t_sr_wm_us, min_ttu_vblank);
+		min_ttu_vblank = dml_max(dlg_sys_param->t_sr_wm_us, min_ttu_vblank);
 	if (pstate_en)
-		min_ttu_vblank = dml_max(dlg_sys_param.t_mclk_wm_us, min_ttu_vblank);
+		min_ttu_vblank = dml_max(dlg_sys_param->t_mclk_wm_us, min_ttu_vblank);
 	min_ttu_vblank = min_ttu_vblank + t_calc_us;
 
 	min_dst_y_ttu_vblank = min_ttu_vblank * pclk_freq_in_mhz / (double) htotal;
@@ -1197,59 +1197,59 @@ void dml1_rq_dlg_get_dlg_params(
 	/* ------------------------- */
 	/* Prefetch Calc */
 	/* Source */
-	dcc_en = e2e_pipe_param.pipe.src.dcc;
+	dcc_en = e2e_pipe_param->pipe.src.dcc;
 	dual_plane = is_dual_plane(
-			(enum source_format_class) e2e_pipe_param.pipe.src.source_format);
+			(enum source_format_class) e2e_pipe_param->pipe.src.source_format);
 	mode_422 = 0; /* TODO */
-	access_dir = (e2e_pipe_param.pipe.src.source_scan == dm_vert); /* vp access direction: horizontal or vertical accessed */
+	access_dir = (e2e_pipe_param->pipe.src.source_scan == dm_vert); /* vp access direction: horizontal or vertical accessed */
 	bytes_per_element_l = get_bytes_per_element(
-			(enum source_format_class) e2e_pipe_param.pipe.src.source_format,
+			(enum source_format_class) e2e_pipe_param->pipe.src.source_format,
 			0);
 	bytes_per_element_c = get_bytes_per_element(
-			(enum source_format_class) e2e_pipe_param.pipe.src.source_format,
+			(enum source_format_class) e2e_pipe_param->pipe.src.source_format,
 			1);
-	vp_height_l = e2e_pipe_param.pipe.src.viewport_height;
-	vp_width_l = e2e_pipe_param.pipe.src.viewport_width;
-	vp_height_c = e2e_pipe_param.pipe.src.viewport_height_c;
-	vp_width_c = e2e_pipe_param.pipe.src.viewport_width_c;
+	vp_height_l = e2e_pipe_param->pipe.src.viewport_height;
+	vp_width_l = e2e_pipe_param->pipe.src.viewport_width;
+	vp_height_c = e2e_pipe_param->pipe.src.viewport_height_c;
+	vp_width_c = e2e_pipe_param->pipe.src.viewport_width_c;
 
 	/* Scaling */
-	htaps_l = e2e_pipe_param.pipe.scale_taps.htaps;
-	htaps_c = e2e_pipe_param.pipe.scale_taps.htaps_c;
-	hratios_l = e2e_pipe_param.pipe.scale_ratio_depth.hscl_ratio;
-	hratios_c = e2e_pipe_param.pipe.scale_ratio_depth.hscl_ratio_c;
-	vratio_l = e2e_pipe_param.pipe.scale_ratio_depth.vscl_ratio;
-	vratio_c = e2e_pipe_param.pipe.scale_ratio_depth.vscl_ratio_c;
+	htaps_l = e2e_pipe_param->pipe.scale_taps.htaps;
+	htaps_c = e2e_pipe_param->pipe.scale_taps.htaps_c;
+	hratios_l = e2e_pipe_param->pipe.scale_ratio_depth.hscl_ratio;
+	hratios_c = e2e_pipe_param->pipe.scale_ratio_depth.hscl_ratio_c;
+	vratio_l = e2e_pipe_param->pipe.scale_ratio_depth.vscl_ratio;
+	vratio_c = e2e_pipe_param->pipe.scale_ratio_depth.vscl_ratio_c;
 
 	line_time_in_us = (htotal / pclk_freq_in_mhz);
-	vinit_l = e2e_pipe_param.pipe.scale_ratio_depth.vinit;
-	vinit_c = e2e_pipe_param.pipe.scale_ratio_depth.vinit_c;
-	vinit_bot_l = e2e_pipe_param.pipe.scale_ratio_depth.vinit_bot;
-	vinit_bot_c = e2e_pipe_param.pipe.scale_ratio_depth.vinit_bot_c;
-
-	swath_height_l = rq_dlg_param.rq_l.swath_height;
-	swath_width_ub_l = rq_dlg_param.rq_l.swath_width_ub;
-	dpte_bytes_per_row_ub_l = rq_dlg_param.rq_l.dpte_bytes_per_row_ub;
-	dpte_groups_per_row_ub_l = rq_dlg_param.rq_l.dpte_groups_per_row_ub;
-	meta_pte_bytes_per_frame_ub_l = rq_dlg_param.rq_l.meta_pte_bytes_per_frame_ub;
-	meta_bytes_per_row_ub_l = rq_dlg_param.rq_l.meta_bytes_per_row_ub;
-
-	swath_height_c = rq_dlg_param.rq_c.swath_height;
-	swath_width_ub_c = rq_dlg_param.rq_c.swath_width_ub;
-	dpte_bytes_per_row_ub_c = rq_dlg_param.rq_c.dpte_bytes_per_row_ub;
-	dpte_groups_per_row_ub_c = rq_dlg_param.rq_c.dpte_groups_per_row_ub;
-
-	meta_chunks_per_row_ub_l = rq_dlg_param.rq_l.meta_chunks_per_row_ub;
-	vupdate_offset = e2e_pipe_param.pipe.dest.vupdate_offset;
-	vupdate_width = e2e_pipe_param.pipe.dest.vupdate_width;
-	vready_offset = e2e_pipe_param.pipe.dest.vready_offset;
+	vinit_l = e2e_pipe_param->pipe.scale_ratio_depth.vinit;
+	vinit_c = e2e_pipe_param->pipe.scale_ratio_depth.vinit_c;
+	vinit_bot_l = e2e_pipe_param->pipe.scale_ratio_depth.vinit_bot;
+	vinit_bot_c = e2e_pipe_param->pipe.scale_ratio_depth.vinit_bot_c;
+
+	swath_height_l = rq_dlg_param->rq_l.swath_height;
+	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
+	dpte_bytes_per_row_ub_l = rq_dlg_param->rq_l.dpte_bytes_per_row_ub;
+	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
+	meta_pte_bytes_per_frame_ub_l = rq_dlg_param->rq_l.meta_pte_bytes_per_frame_ub;
+	meta_bytes_per_row_ub_l = rq_dlg_param->rq_l.meta_bytes_per_row_ub;
+
+	swath_height_c = rq_dlg_param->rq_c.swath_height;
+	swath_width_ub_c = rq_dlg_param->rq_c.swath_width_ub;
+	dpte_bytes_per_row_ub_c = rq_dlg_param->rq_c.dpte_bytes_per_row_ub;
+	dpte_groups_per_row_ub_c = rq_dlg_param->rq_c.dpte_groups_per_row_ub;
+
+	meta_chunks_per_row_ub_l = rq_dlg_param->rq_l.meta_chunks_per_row_ub;
+	vupdate_offset = e2e_pipe_param->pipe.dest.vupdate_offset;
+	vupdate_width = e2e_pipe_param->pipe.dest.vupdate_width;
+	vready_offset = e2e_pipe_param->pipe.dest.vready_offset;
 
 	dppclk_delay_subtotal = mode_lib->ip.dppclk_delay_subtotal;
 	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
 	pixel_rate_delay_subtotal = dppclk_delay_subtotal * pclk_freq_in_mhz / dppclk_freq_in_mhz
 			+ dispclk_delay_subtotal * pclk_freq_in_mhz / dispclk_freq_in_mhz;
 
-	vstartup_start = e2e_pipe_param.pipe.dest.vstartup_start;
+	vstartup_start = e2e_pipe_param->pipe.dest.vstartup_start;
 
 	if (interlaced)
 		vstartup_start = vstartup_start / 2;
@@ -1276,13 +1276,13 @@ void dml1_rq_dlg_get_dlg_params(
 	dst_x_after_scaler = 0;
 	dst_y_after_scaler = 0;
 
-	if (e2e_pipe_param.pipe.src.is_hsplit)
+	if (e2e_pipe_param->pipe.src.is_hsplit)
 		dst_x_after_scaler = pixel_rate_delay_subtotal
-				+ e2e_pipe_param.pipe.dest.recout_width;
+				+ e2e_pipe_param->pipe.dest.recout_width;
 	else
 		dst_x_after_scaler = pixel_rate_delay_subtotal;
 
-	if (e2e_pipe_param.dout.output_format == dm_420)
+	if (e2e_pipe_param->dout.output_format == dm_420)
 		dst_y_after_scaler = 1;
 	else
 		dst_y_after_scaler = 0;
@@ -1334,7 +1334,7 @@ void dml1_rq_dlg_get_dlg_params(
 	DTRACE(
 			"DLG: %s: t_srx_delay_us     = %3.2f",
 			__func__,
-			(double) dlg_sys_param.t_srx_delay_us);
+			(double) dlg_sys_param->t_srx_delay_us);
 	DTRACE("DLG: %s: line_time_in_us    = %3.2f", __func__, (double) line_time_in_us);
 	DTRACE("DLG: %s: vupdate_offset     = %d", __func__, vupdate_offset);
 	DTRACE("DLG: %s: vupdate_width      = %d", __func__, vupdate_width);
@@ -1408,12 +1408,12 @@ void dml1_rq_dlg_get_dlg_params(
 	DTRACE("DLG: %s: dpte_row_bytes          = %d", __func__, dpte_row_bytes);
 
 	prefetch_bw = (vm_bytes + 2 * dpte_row_bytes + 2 * meta_row_bytes + sw_bytes) / t_pre_us;
-	flip_bw = ((vm_bytes + dpte_row_bytes + meta_row_bytes) * dlg_sys_param.total_flip_bw)
-			/ (double) dlg_sys_param.total_flip_bytes;
+	flip_bw = ((vm_bytes + dpte_row_bytes + meta_row_bytes) * dlg_sys_param->total_flip_bw)
+			/ (double) dlg_sys_param->total_flip_bytes;
 	t_vm_us = line_time_in_us / 4.0;
 	if (vm_en && dcc_en) {
 		t_vm_us = dml_max(
-				dlg_sys_param.t_extra_us,
+				dlg_sys_param->t_extra_us,
 				dml_max((double) vm_bytes / prefetch_bw, t_vm_us));
 
 		if (iflip_en && !dual_plane) {
@@ -1423,12 +1423,12 @@ void dml1_rq_dlg_get_dlg_params(
 		}
 	}
 
-	t_r0_us = dml_max(dlg_sys_param.t_extra_us - t_vm_us, line_time_in_us - t_vm_us);
+	t_r0_us = dml_max(dlg_sys_param->t_extra_us - t_vm_us, line_time_in_us - t_vm_us);
 
 	if (vm_en || dcc_en) {
 		t_r0_us = dml_max(
 				(double) (dpte_row_bytes + meta_row_bytes) / prefetch_bw,
-				dlg_sys_param.t_extra_us);
+				dlg_sys_param->t_extra_us);
 		t_r0_us = dml_max((double) (line_time_in_us - t_vm_us), t_r0_us);
 
 		if (iflip_en && !dual_plane) {
@@ -1550,15 +1550,15 @@ void dml1_rq_dlg_get_dlg_params(
 			disp_dlg_regs->refcyc_per_meta_chunk_vblank_l;/* dcc for 4:2:0 is not supported in dcn1.0.  assigned to be the same as _l for now */
 
 	/* Active */
-	req_per_swath_ub_l = rq_dlg_param.rq_l.req_per_swath_ub;
-	req_per_swath_ub_c = rq_dlg_param.rq_c.req_per_swath_ub;
-	meta_row_height_l = rq_dlg_param.rq_l.meta_row_height;
+	req_per_swath_ub_l = rq_dlg_param->rq_l.req_per_swath_ub;
+	req_per_swath_ub_c = rq_dlg_param->rq_c.req_per_swath_ub;
+	meta_row_height_l = rq_dlg_param->rq_l.meta_row_height;
 	swath_width_pixels_ub_l = 0;
 	swath_width_pixels_ub_c = 0;
 	scaler_rec_in_width_l = 0;
 	scaler_rec_in_width_c = 0;
-	dpte_row_height_l = rq_dlg_param.rq_l.dpte_row_height;
-	dpte_row_height_c = rq_dlg_param.rq_c.dpte_row_height;
+	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
+	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
 	disp_dlg_regs->dst_y_per_pte_row_nom_l = (unsigned int) ((double) dpte_row_height_l
 			/ (double) vratio_l * dml_pow(2, 2));
@@ -1650,14 +1650,14 @@ void dml1_rq_dlg_get_dlg_params(
 	refcyc_per_req_delivery_cur0 = 0.;
 
 	full_recout_width = 0;
-	if (e2e_pipe_param.pipe.src.is_hsplit) {
-		if (e2e_pipe_param.pipe.dest.full_recout_width == 0) {
+	if (e2e_pipe_param->pipe.src.is_hsplit) {
+		if (e2e_pipe_param->pipe.dest.full_recout_width == 0) {
 			DTRACE("DLG: %s: Warningfull_recout_width not set in hsplit mode", __func__);
-			full_recout_width = e2e_pipe_param.pipe.dest.recout_width * 2; /* assume half split for dcn1 */
+			full_recout_width = e2e_pipe_param->pipe.dest.recout_width * 2; /* assume half split for dcn1 */
 		} else
-			full_recout_width = e2e_pipe_param.pipe.dest.full_recout_width;
+			full_recout_width = e2e_pipe_param->pipe.dest.full_recout_width;
 	} else
-		full_recout_width = e2e_pipe_param.pipe.dest.recout_width;
+		full_recout_width = e2e_pipe_param->pipe.dest.recout_width;
 
 	refcyc_per_line_delivery_pre_l = get_refcyc_per_delivery(
 			mode_lib,
@@ -1824,9 +1824,9 @@ void dml1_rq_dlg_get_dlg_params(
 	}
 
 	/* TTU - Cursor */
-	hratios_cur0 = e2e_pipe_param.pipe.scale_ratio_depth.hscl_ratio;
-	cur0_src_width = e2e_pipe_param.pipe.src.cur0_src_width; /* cursor source width */
-	cur0_bpp = (enum cursor_bpp) e2e_pipe_param.pipe.src.cur0_bpp;
+	hratios_cur0 = e2e_pipe_param->pipe.scale_ratio_depth.hscl_ratio;
+	cur0_src_width = e2e_pipe_param->pipe.src.cur0_src_width; /* cursor source width */
+	cur0_bpp = (enum cursor_bpp) e2e_pipe_param->pipe.src.cur0_bpp;
 	cur0_req_size = 0;
 	cur0_req_width = 0;
 	cur0_width_ub = 0.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.h b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.h
index 9c06913ad767..23d4f30826ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.h
@@ -33,7 +33,7 @@ struct display_mode_lib;
 void dml1_extract_rq_regs(
 		struct display_mode_lib *mode_lib,
 		struct _vcs_dpi_display_rq_regs_st *rq_regs,
-		const struct _vcs_dpi_display_rq_params_st rq_param);
+		const struct _vcs_dpi_display_rq_params_st *rq_param);
 /* Function: dml_rq_dlg_get_rq_params
  *  Calculate requestor related parameters that register definition agnostic
  *  (i.e. this layer does try to separate real values from register definition)
@@ -55,9 +55,9 @@ void dml1_rq_dlg_get_dlg_params(
 		struct display_mode_lib *mode_lib,
 		struct _vcs_dpi_display_dlg_regs_st *dlg_regs,
 		struct _vcs_dpi_display_ttu_regs_st *ttu_regs,
-		const struct _vcs_dpi_display_rq_dlg_params_st rq_dlg_param,
-		const struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param,
-		const struct _vcs_dpi_display_e2e_pipe_params_st e2e_pipe_param,
+		const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param,
+		const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param,
+		const struct _vcs_dpi_display_e2e_pipe_params_st *e2e_pipe_param,
 		const bool cstate_en,
 		const bool pstate_en,
 		const bool vm_en,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 45a6216dfa2a..4dca14b598dd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -366,6 +366,9 @@ struct pipe_ctx {
 	struct _vcs_dpi_display_ttu_regs_st ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st rq_regs;
 	struct _vcs_dpi_display_pipe_dest_params_st pipe_dlg_param;
+	struct _vcs_dpi_display_rq_params_st dml_rq_param;
+	struct _vcs_dpi_display_dlg_sys_params_st dml_dlg_sys_param;
+	struct _vcs_dpi_display_e2e_pipe_params_st dml_input;
 	int det_buffer_size_kb;
 	bool unbounded_req;
 #endif
-- 
2.33.0


--------------99E2F0ECD613DF830129E884--
