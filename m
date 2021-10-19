Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7F4330C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhJSIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:10:01 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:25184
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234669AbhJSIJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/JPv4mp6qnoebaYK6xv0o8SlbA/QKR/tMY2raR+gwyg5z7KU1+oyjVRyy41DyeVDaGnPo04GihmNqilD3q5FUvQY6FUlH0QJxOPQJ6Lk2Yv1WX5PG3LbQK25VRW/MSCa99aPXSMu8E5D0BC6FInAEmK1qTTmF8vCY2kFIwUaRlweWKHKP2Ye8XZpr/M4yo2nSrb8G1nONzxFW3o3cyur+O89hcLU85a3NT2YusKoEB3XJr1lXGELmdLjQ2MssVuMf8ZQyriwdX+bdKlNkcgWAegDQA2bDjjNAozfvKBVbh/7NHXhZleaDRkaQrE4fQiiI6OL/Xy6A/0xfr9Gpq9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwcovqp5sZKtOnzLu+CXRiN7fTns6CEBOEdMZUu6m4c=;
 b=b80QQvHjzHz05Hx2D9ZjrECWqa+cvZfSfXbhv7C4n1VCAauOcW2AOcbdgyVart/HqxBmG45P9NzpT+1/A561gsifLEgT3y03BD3P3lCA2Ok4hrUDYBdYgjeoFDl4VXC+JrvUgxPhDhxJg5I8h10ugzvbvNE65qWC7XhBXqMnrY5/30qFapjnGLYu8ppXGaVrSJ0CClf8miTLtFQH3fjJYxHH3wkWeNZoNwtjOAzKibkPVhoPjaCnOGm/7rAnWd+Q1bRs/jsKUEMXg4kPqOKkkzrr23ZKpNDmPsy1z5Yrn7wIdHNVHtvKn+s2pGB1p95JAu4284EXInxslezUSvUNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwcovqp5sZKtOnzLu+CXRiN7fTns6CEBOEdMZUu6m4c=;
 b=foJ67qQdndczouQnGIlDEgyavbnYE27xg5IXipKWx2ufq+84d34yJ6Mr8BtVTMdjlmaTClyOLNIElzuk6P2U58gdCqMacTbuQK917U/Lf8oWoJo/G3k1B5uN+7l3tEbZ+b3UXBDHfSYMdQKqzSAH7fTjt12XoxumZ9R5jMAaNB8=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 08:07:40 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 08:07:40 +0000
Message-ID: <e733ba65-da1d-28ff-99b4-624da1992858@amd.com>
Date:   Tue, 19 Oct 2021 04:07:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: Use of conditionals with omitted operands in amdgpu (x? : y)
 (was: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3))
Content-Language: en-CA
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Alex Deucher <Alexander.Deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
 <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
 <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
 <fbd8a354-4f09-ffd9-ae0f-fdaa16903bc8@amd.com>
 <65580f09-1ad8-07ba-b392-dc4aad2464ee@amd.com>
 <137ec58c-a8e9-19d4-c49b-19b6e0aad144@molgen.mpg.de>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <137ec58c-a8e9-19d4-c49b-19b6e0aad144@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 08:07:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a5d949-ca5a-43d2-ed22-08d992d78520
X-MS-TrafficTypeDiagnostic: DM6PR12MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3579CC6EEF01BBEDAE20496D99BD9@DM6PR12MB3579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSPY1Mm3aDdf2J79+Ip3J07VsmyAHAJvOMPAqPRCQzxBORbvL1jrowzZd0TeuWioDB6345SdMGtuCC0+dU5FFQkjJZOvoYj6M5CUfDwEgoEXm8cvWRYFHa1Oi5hLtYY6k1WmfTQpotIpFL2Mf9ohhbMVQ//8oEaijP5xej+WrbTBLYFaEuVSPjm+0mXBWF8wcey+HHigW/pI2dDjwoKlHYF6M7pYJM8JXCTIkYdRN9kwxDgPaORpGvrLwchVQqLA4Ya7/O3PpmF9Jt53CisckTgK/DBad2qcER1rlpppw1LDw1uRvZQ+o3zgPnq/PlMIwbWirV4jZXNsYOcllxEj1rNmiX9b2dpDAbV2ySCd/0WMORNNxMhPfCIookNrqfIRwHD6r5eunINC7iWaZk01gsGAuuwkSnrpF254Vfx59ZOwOyl9hdBwWTkXMlcBXqPlidzuEWKCUveMBlTwC7ehyW4jCkkLq/XHseO8RGVlNZjlF5+c4dJ8g3H5JdcekQROOrMghhNJul/kttZZ+fiktk1ZvgViMexdCaaDCRQyVXfMWA5Nui/Ikk2xd1ee/GXHEWDUS26ZKwkPY7KggiI7vQn029qipkvUmAkTtpdI5u5b41xfryPKRy0Et64m/GkLwBtSfqJulvrOsZEUCynCIj5s8vqr0i8yhx9aT4KXiMb9IVUzjnXhb72TqswIx+FyMFris67dwjGjwOkUJPIKyKuwl2iOlFbfA6v6FxHWi0vhkMeiOUqgiFF2oH36yBV5384VQRfzsyl78WRl0iEBxgG2WJY1wx3SXxKe8tFa/brcwRbBceRXg96hAXxY73jkMDmn1ERR7P5o+gVyK6WNLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3962.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(508600001)(16576012)(31696002)(316002)(6486002)(26005)(4326008)(2906002)(6636002)(31686004)(8936002)(5660300002)(38100700002)(8676002)(54906003)(110136005)(4001150100001)(86362001)(956004)(44832011)(66556008)(53546011)(83380400001)(66476007)(186003)(36756003)(66946007)(966005)(2616005)(3714002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUR2ZVY2OTBuSFNPWWx6cVJBNnZTa0N5RUJyd1E5SFI2dVFzSkVoR3BVRVRP?=
 =?utf-8?B?c0hDNytsWjJ3SFlKS2RGbGJUYm1SV2Zua3BzYmd1Rng3TC96cDFJb1lkVitZ?=
 =?utf-8?B?Tk1QajJkK3ZQWEFPQVdhTmVFaU5oU2NZWjF3b09vUmJBdU12Smg1RVZzUVJk?=
 =?utf-8?B?SWxUUHZXUkZHUDhVd0NzNG1WdXBMUis3WWdXRHlxK04yK1d2VnYrekkrT3VH?=
 =?utf-8?B?RWhlTU5qL2VpanU0M1V1REVLU1RZSUZ0ZS9BMFk4WlJPVDVVZG01OW9iUVZs?=
 =?utf-8?B?cFMxMnliL2MxV0ZEUW5td3BvQXk0L3dBVXlOWHNmeENVTWFPUUp3NHNoenhV?=
 =?utf-8?B?NjJFakNBS2ZCS2pmRitlcGhUOWE1Y0I5RFZrR0QwUVVJTHlVYzNCdFJ2cGU5?=
 =?utf-8?B?SzNLRTE2RVc1a29RSWJyV3U1bUZaVS92VXF6akFSbVNLYWh5VTBHdG5PS2gw?=
 =?utf-8?B?eHBJb2tNQllCcVdIQ1NROUNNRkFJY1JUNXBITExwZGd4enVLOHJYbDZTYy9I?=
 =?utf-8?B?YkR5N1A2NkdaN1MrcFJINmluaTBpYjJ2akZGaHlESHd0R1A1MTdXdUY4bmNL?=
 =?utf-8?B?RnA5UlRmTDF4ZDI2RWxCNDdiNXFRaWppL3BEQklOdzlVK2t0NnFTaENEcHdi?=
 =?utf-8?B?UUIrMkh3M3FxTU9JdmxkWFA5LzFBMHpTOU4xVm84bDNXcjNlb0pLelJQTG1z?=
 =?utf-8?B?M3poeVhVOGc1VFlhTll0alBnYVlFQm9zbWs5SW1YcU05TkE5bVhrVUdYTy9G?=
 =?utf-8?B?MFJMT1VUQVlGa2l6cElydWpTOVAwWUFWZTNwZVV3OEwrUE5rMGg0N2dteWRj?=
 =?utf-8?B?WE5VTExqcEtPc1F4US85ZHRpUWZlT1dmVS9Ic01vZ3FMZUt0bFJ3cktXQnVi?=
 =?utf-8?B?MWlKcXBIUHNNeTZRdDljR2Z4QWpWMVk3bnoxdktEa2Zma2xrRnFEUjlJdzcw?=
 =?utf-8?B?ZHl6WGphMFBBVzZGNE1PUk5qcFdIQlZVeEFoZ0dTcG5BZVVPOXlrYm0zeE9p?=
 =?utf-8?B?OUFzN2FTN2dRZXRCckdlL2xBT0poVEJhZUxmSWNjQjBZS28yaEdPdUdWVUZu?=
 =?utf-8?B?bmYyN3FBYjJnbXI1SklJTFZkb0xicTVxaTFUcTZJalBoNFRsaDVBUHMyMDk2?=
 =?utf-8?B?enM4aklGZXlCUi9zQW43TmVaeklyVmg0TUcrWmVyYitBU2svRTFqWTN1dHpL?=
 =?utf-8?B?Sis3OTdCKzVsRXRBcmNpRllJZndDREp1Z3JCczdSd0tzWUZvWUFqa2pGYkdW?=
 =?utf-8?B?OWY2eDJuaGlsSHZLaVhESDZhZWd2ZDUyaldmQzBybG4rTVRDd2cyNkU3SUpn?=
 =?utf-8?B?bzU5M05sa0l1SmVxbHcxSURlK1pyTnVLK1Q1SWVUL2Y2d2w0QlRMMUYzZDVz?=
 =?utf-8?B?RDJ4ZWZVckJJajRyMUkyU1hsRHpFazhXQ2xWdHVqMTJuUG1PbjJiVjI0Snd3?=
 =?utf-8?B?Rit6Unhid0J1U2ZCMTJDYzdrSVFQQnFLVklzTzRMUUg3bFozMGdkbkpoM3VW?=
 =?utf-8?B?d2EvYjdTeDZZSldvNDdXR3ppSjEvaHU1WEdYOEk1a0JrR2NZNGtkZ0k5NWdi?=
 =?utf-8?B?Z1Q0b1pvVitaRzk3bmI1TTQ3ajBETTZid282SnpLQ1RFelFicUtkNE83MU9s?=
 =?utf-8?B?ekhCOTE3WFlRV1puUHBiSG1VZmY0OCs1Mnl6cEFlWWVMcFdPWjdrQVJKUXNT?=
 =?utf-8?B?TlNoVm1LNW9BUjdVeGc0QW8wSlJRcXFoRjU1NjRybXhXb0NlZ0dFSDkxNzRF?=
 =?utf-8?Q?kKNPqTm8kLMfgoVliDDJoVj6EBQ9RcNaF1AfOOs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a5d949-ca5a-43d2-ed22-08d992d78520
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 08:07:40.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxP5LfkZ15gggQ+uaQsZ0zaEzRbgxk27tz0dmhg2E/uHsFLhopv3gAlXFtUUzTcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+AlexD
+ChrisianK
+LKML

On 2021-10-19 03:44, Paul Menzel wrote:
> Dear Luben,
>
>
> Am 19.10.21 um 06:50 schrieb Luben Tuikov:
>> On 2021-10-19 00:38, Lazar, Lijo wrote:
>>> On 10/19/2021 9:45 AM, Luben Tuikov wrote:
>>>> On 2021-10-18 23:38, Lazar, Lijo wrote:
>>>>> On 10/19/2021 5:19 AM, Luben Tuikov wrote:
> […]
>
>>>>>> -			if (ret)
>>>>>> -				goto print_clk_out;
>>>>>> +			freq_value[1] = curr_value ?: freq_value[0];
>>>>> Omitting second expression is not standard C -
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc%2FConditionals.html&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Ca0515ae37fc64695640408d992d44452%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637702263078635669%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=cPRhR4Fcns4Kx%2BjkAjvN16xDk0jDEbkCO0EooJzEUlA%3D&amp;reserved=0
>>>> Lijo just clarified to me that:
>>>>
>>>>> well, i had to look up as I haven't seen it before
>>>> I hope the following should make it clear about its usage:
>>>>
>>>> $cd linux/
>>>> $find . -name "*.[ch]" -exec grep -E "\?:" \{\} \+ | wc -l
>>>> 1042
>>>> $_
>      $ git grep -E "\?:" -- '*amdgpu*.[ch]'
>      drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c: * Solution?:
>
> So for the AMDGPU subsystem, as the only result is a comment, currently, 
> conditionals with omitted operands are not used. So, it’s a valid 
> question, if the use should be introduced into the subsystem.
>
> The GCC documentation also states:
>
>> In this simple case, the ability to omit the middle operand is not
>> especially useful. When it becomes useful is when the first operand
>> does, or may (if it is a macro argument), contain a side effect. Then
>> repeating the operand in the middle would perform the side effect
>> twice. Omitting the middle operand uses the value already computed
>> without the undesirable effects of recomputing it.
> So, in your case, there are no side effect, if I am not mistaken.

The explanation you quoted above makes a case *for* using the extension. It's telling you that it is a good thing to use the extension so should the first operand be a macro with an argument, it'll avoid being evaluated twice.

>
> I do not care, if the extension is going to be used or not.

So then why post this message, if you don't care? Since your email continues after this, like this:

> The 
> maintainers might want to officially confirm the use in the subsystem, 

I've added the maintainers, Alex and Christian, as well as LKML to the To: list of this email.
I believe that it is perfectly fine to use the ternary conditional abbreviation "c = a ?: b;", as the kernel uses it extensively, over 1000 occurrences in the kernel. It also eliminates side effects should 'a' be a macro with an argument which evaluates.

> as using these extensions is surprising for some C developers not 
> knowing the GNU extensions.
>
>>> Thanks Luben!
>> You're welcome. I'm glad you're learning new things from my patches.
>> Would've been easier if you'd just said in your email that you've
>> never seen this ternary conditional shortcut before and that you've
>> just learned of it from my patch. (Or not post anything at all in
>> this very case and get in touch with me privately via email or
>> Teams--I would've gladly clarified it there.)
> In my opinion, asking this on the list is perfectly valid, as other 
> readers, might have the same question. But being more elaborate to avoid 
> misunderstandings is always a good thing.

Lijo wasn't asking anything. There was no question in any of his emails on this thread which is all about the use of "?:", which is a well-established practice.

Why are we having a thread about the use of "?:" ?

Regards,
Luben

>
>> I hope the find+egrep above is also edifying, so you can use it in
>> the future in your learning process.
> I hope, you like my solution without using find. ;-)
>
>
> Kind regards,
>
> Paul

