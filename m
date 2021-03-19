Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925D342538
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:47:45 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:40160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhCSSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fef25QFH+t7x6HwJTsUfs2RGhHsHF46n0KU6HGvTzSNl6hsfk5kSOAqH+zxdnUgziBaiD3IakPHosLx5AWx9nSNHvtDQJE+6g6BnE/w+2o761CqIp3lFu2M/bIQ9014jFQifc/OlRyCNqlwvboE4b5Q2A/Xb1YO+2FOQ/xQLsDfg74ih51ewn41yTcdZ38nKoWrJN2jM4bxhXEz5mZwUm1mCDCs114sP2qfbsc8uw34xFxQXtmzVDcDt3V/dDUryhiO88yLWdTuzPnXJWWspAmcvW+CuGUi/tZBPqbjV4L0bzaBdBy+BtT9ydn13LaLd9C8Vm4QgHX9F6IbkshqOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pulu4mubeTBytftmvryz5yjdndK4N+RRJBC53bQW7Xw=;
 b=g4x520d89aADgcodCrcIHVYE1RMIomq9yuDaEYsOUVuGHoRU/uxAGcElZmRn+Fxr0zilHiy3XHT547/U9jbPBNR9MTRnjV74jgcuFvpfXDEfXdVpzgo7xltsND9Q3TESl+xxnDJPo4oZXdvOLqzZrlVTLfPmMYK44EeXo34iev7wxV8QJWPuQe4KWMRTTMwA7ZeM4rVIDANDarDxLA8cEzI2r9NKXaBmdQAOt06PMm9CmdjJRVzkc/zXM0U38rbbqNzvkj13F35hf3bjAox8aXlbMkwl9ABzyGz/3YwoERyN5YRPrID7LYrzYGwRppJODkvkl8rUrd33kzY8OkjG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pulu4mubeTBytftmvryz5yjdndK4N+RRJBC53bQW7Xw=;
 b=Xv094M7OIRLPx58rU5RvXzYl/OejSV9vuWIWOvyt+XGYBkA4ElcShv+rDnWfCkqzZkRr8jewqaSaLzwtOlp1ThRpcYCz6WsLZw5WPUHwzznm44EZh++rdMjLn+9NElfKNqiQCArGPlUBQ/p2OZQcIa4TNeC3tf7LopoJnBAAmVE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4753.namprd12.prod.outlook.com (2603:10b6:208:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 18:47:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 18:47:00 +0000
Subject: Re: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-7-lee.jones@linaro.org>
 <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
 <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a74c5599-e519-2b02-f16b-31e352872a31@amd.com>
Date:   Fri, 19 Mar 2021 19:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3d17:e42d:64f0:733a]
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3d17:e42d:64f0:733a] (2a02:908:1252:fb60:3d17:e42d:64f0:733a) by AM8P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 18:46:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0da24cc-9511-4c11-9e17-08d8eb0760f6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47533177003917225C9CDAE183689@BL0PR12MB4753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDwo25I+rJdwP29J3CwtEPvJ5skjf6IogPSeZ4Z5Czy8wOWMy0dkl9tGqiphH1Br01OeoIaX09c9eGOLLpfqSvd83jYdhP/s4DS/uen+syeaGd/RY94KFNanU0TtEy4DuSA8x1TeezDkzLIOMfw+CmHB8XEl2gu5M+yzK15AHUaka7O8sangBgaxpA2fZqMKWxI+ZXQbt8zpyDLLaG1+uaXlwZUZKrXPGw6ShFSfMXcnH9mGFT+EhI/aPehHenoKODdOMLjR7lfbyTt6t88XRCrOKkaBPvXQ+1SlskmJU4eetii4K68qJEqml5cPsBIKODTRW1ndR7DQMtbgZRunr7CWXJo1RsIUO3iGshQUQ0ravkQsJI2cBtfLu4mKSK4zY30vhHpfm3KUh1ubtIaVi4T+OIUC3IQHnbsl5gSH7sKWFVMaOiqwmS2UjdA6nNMZTX8XKpSsIKcfnQnMeIsSykDZmkNz4WAXj9vu8pmnKvgGaVNYpEU3ds23FLvmXlezmSiq36ZLmGKg9VsGj3H2MKVul7dTyd+SG7FL9ExqubUsoq9p9/i7wPmB0agFixNUiT8UDt9+zjXp4dc0pgIxhTIw6EnXSbD2/yxyq13H6kaf73+Fe2hGAyDlJuw1x+y6qjumeiwC2upX0efa8X4OWJdJx3AgT6nvIxkARJIpBbHKzexxD67pNtVFWKD4k6ko5strIJQifq9VEDZfOlcS4jRcAlIxT2sCntVFTaISXmKMv+50lLwqjnFYuDrToU4/fotRsWVhuSrdXYlLqjGWYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(5660300002)(66556008)(66574015)(38100700001)(2906002)(66476007)(54906003)(4326008)(8936002)(83380400001)(36756003)(52116002)(53546011)(6666004)(110136005)(478600001)(86362001)(8676002)(2616005)(316002)(66946007)(31686004)(31696002)(966005)(6486002)(186003)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEVWWGorK1hxVmxlQUltZHhmYlc5UWhta3VxVVNQQmYzRm90K3ZxbjU5L3F6?=
 =?utf-8?B?NmlxYVZJdTZDdkdGY2dVRmx1WXdBUG04VFRoYkpVa0ZkZUQ0SU11clBWaDl0?=
 =?utf-8?B?L3dyL3I1czV6UTdvVk9xNGlvc1htUGZFMkFYd3V3RU8xT1JCU3h2ZTdKZG5r?=
 =?utf-8?B?YlZXanUvRUxYTThZcVFDZkxRWEZRY09rNDA2Mmh2MzhIb2pKd2hJVlhweWR6?=
 =?utf-8?B?eVRoUmpxNGttcWdzQmtjM1pSanVoMmUvU0tJU29VeDhscDN1RFBwN01VVmQ0?=
 =?utf-8?B?dVR3Tm1ieHZ5ZFgxRG05cGhla1FKajU4bkFLR05vUFV0TXpxMjBrK2xvMkxp?=
 =?utf-8?B?di9JeEZZUms4eFBRbXQ1cTRUL0tYVCtHZUIzTDh6TU1TRmdlR3ZTekUvUHhM?=
 =?utf-8?B?TDZjQ1FrTWp2NVdlU2I3c0dFU1puWXMyalpuV3NudE9BdS8yeElmMm1tdS96?=
 =?utf-8?B?ZzVqNzlhaE9MY1NybFIzeEtpN0Y2ZVZ3UUhySFZHMGxrcDJDZzdpaDl1dkRh?=
 =?utf-8?B?bUhoVW9NVWY0TlI4U2VUNUp4M0Y5emJnbjlibWhuZmtjNGt4NEY3OE9hYkJ1?=
 =?utf-8?B?UXM4MFdENVJDWXpnYVpVRGlEcUZOVVhQbE1FYUxqMHcrcDh2R09tQitpeDlz?=
 =?utf-8?B?Z1REUXlUQXBRMlVVcDdFa2p6R2U3L0dBWDVSaWxVUnVzcWNxd1FDUDA0MjlB?=
 =?utf-8?B?SW1YNkZGMHNoblMreTd3WGJrRUt3Z2xkU0txVGxIQUV6dVlMWGdFYlZ5Y1R0?=
 =?utf-8?B?bTZWUml1TERPRGpGSFdIMVhVQXIvNFNVSUV5U1VhKzZFT2d5UFlsYVl5SVRV?=
 =?utf-8?B?TmxYRFhPbHhxQ25JMWs4WFNUclNJODFuQkdNdEVUZ1dkd3piL0FBQzdIVElR?=
 =?utf-8?B?ODhESlhUSEdLSENnZFdOUDRTVENOQWpSc3gzRURjTDhWYmVBdndzVDA3c2Vh?=
 =?utf-8?B?M1JqUkJsZzBIbnFQRU9JUFhpekUya2YxbXV2Ri9FQmRBYVVha1Awa0RjcnE4?=
 =?utf-8?B?UEZyeWJSOXY0M2U3R2RJTEgwVTBBZjNFdmZ6N01wS0tBTjdCS29la1YvT282?=
 =?utf-8?B?SXJFaFd4ei9pZUExU1AvSmdHSUQ1OVJDRkVJSy9IaFVtTGxZWkVvdkZ3VVZM?=
 =?utf-8?B?YXA5RWh4bDhmU0RvZmRNQzJTWFQydU9oY2FsdFkyT0RDYXNwVTAwTGZXVEZn?=
 =?utf-8?B?MmVZam5sTEwxVHFnem1nNXpSeENVOElnNHBDYVowT0ljR044YXFrWG9MeEVF?=
 =?utf-8?B?c1J5ZWxobkF3TUlxeDZ3ZVhQZENWWTZwQm44WEhtSFhkRG5FSHV1cTJqTGtn?=
 =?utf-8?B?R2VMMU4zcTNHZ2lBT09pcFB3a0JVa0cwU080dEtWWlRMSTdkeDBmSTJXanZt?=
 =?utf-8?B?cG54eXErQ1NrZFBLZ1R1dDZEMTZ0cEFCSkdjRHBNdEk5TzF4eFdJSjgySkhO?=
 =?utf-8?B?U1NadlA0STcwTmFNcURtVjNvWjd5QllQcDFuVGdXTndDeDM2NkFLN01BcGFu?=
 =?utf-8?B?NVdPVDdHa01MWWswdEkrUmdHWTNZaGNZKzMyNml3VTByUnAzRCt5eXVlZ1A3?=
 =?utf-8?B?eFUyQUdaY3lOMEZYTm1CalpBREJzU25mT0tSZUt0QVFQNEczQXhJdXJrM2JE?=
 =?utf-8?B?UmJBRjBxV2VpWU9sSk0rQWNreW9uMWNkRlF3K3FwMjBQbDFGYVl6S2J3bjZQ?=
 =?utf-8?B?NnlzclpNZ3hWMEVEcEZxS2JYSk5tMlV0WFdzcVduWkFva1J1ZTBMSFRvNVdv?=
 =?utf-8?B?SzRqQ1FJRHpJOThHVTZDU3dkZ054VzR5dEo0aXg0UjJ0dUFJRmE5TlJjeVZU?=
 =?utf-8?B?RDVwYk5takdJYStwT2JJK0pJMjZaVlZMMVFEZlRUZkxZTG12QXV2dWl3OUcw?=
 =?utf-8?Q?8r4Wkdb+yNTyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0da24cc-9511-4c11-9e17-08d8eb0760f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 18:46:59.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TpCKfIKimvMBoyBGkwhndR/7u6PLkeCBEH/FBr3lrx0hvPwO1qQy6PPJhmZhY7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4753
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19.03.21 um 19:26 schrieb Harry Wentland:
> On 2021-03-19 2:13 p.m., Alex Deucher wrote:
>> + Harry, Nick
>>
>> On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote:
>>>
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In 
>>> function ‘calculate_bandwidth’:
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: 
>>> warning: the frame size of 1216 bytes is larger than 1024 bytes 
>>> [-Wframe-larger-than=]
>>>
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> Cc: Leo Li <sunpeng.li@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Colin Ian King <colin.king@canonical.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>   .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32 
>>> ++++++++++++++++---
>>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c 
>>> b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>>> index e633f8a51edb6..9d8f2505a61c2 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>>> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
>>>          int32_t num_cursor_lines;
>>>
>>>          int32_t i, j, k;
>>> -       struct bw_fixed yclk[3];
>>> -       struct bw_fixed sclk[8];
>>> +       struct bw_fixed *yclk;
>>> +       struct bw_fixed *sclk;
>>>          bool d0_underlay_enable;
>>>          bool d1_underlay_enable;
>>>          bool fbc_enabled;
>>>          bool lpt_enabled;
>>>          enum bw_defines sclk_message;
>>>          enum bw_defines yclk_message;
>>> -       enum bw_defines tiling_mode[maximum_number_of_surfaces];
>>> -       enum bw_defines surface_type[maximum_number_of_surfaces];
>>> +       enum bw_defines *tiling_mode;
>>> +       enum bw_defines *surface_type;
>>>          enum bw_defines voltage;
>>>          enum bw_defines pipe_check;
>>>          enum bw_defines hsr_check;
>>> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
>>>          int32_t number_of_displays_enabled_with_margin = 0;
>>>          int32_t number_of_aligned_displays_with_no_margin = 0;
>>>
>>> +       yclk = kcalloc(3, sizeof(*yclk), GFP_KERNEL);
>>> +       if (!yclk)
>>> +               return;
>>> +
>>> +       sclk = kcalloc(8, sizeof(*sclk), GFP_KERNEL);
>>> +       if (!sclk)
>>> +               goto free_yclk;
>>> +
>>> +       tiling_mode = kcalloc(maximum_number_of_surfaces, 
>>> sizeof(*tiling_mode), GFP_KERNEL);
>>> +       if (!tiling_mode)
>>> +               goto free_sclk;
>>> +
>>> +       surface_type = kcalloc(maximum_number_of_surfaces, 
>>> sizeof(*surface_type), GFP_KERNEL);
>>> +       if (!surface_type)
>>> +               goto free_tiling_mode;
>>> +
>>
>>
>> Harry or Nick can correct me if I'm wrong, but for this patch and the
>> next one, I think this can be called from an atomic context.
>>
>
> From what I can see this doesn't seem the case. If I'm missing 
> something someone please correct me.

Have you taken into account that using FP functions require atomic 
context as well?

We had quite a bunch of problems with that and had to replace some 
GFP_KERNEL with GFP_ATOMIC in the DC code because of this.

Could of course be that this code here isn't affected by that, but 
better save than sorry.

Christian.

>
> This and the next (06/19) patch are both
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
>> Alex
>>
>>>          yclk[low] = vbios->low_yclk;
>>>          yclk[mid] = vbios->mid_yclk;
>>>          yclk[high] = vbios->high_yclk;
>>> @@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
>>>                          }
>>>                  }
>>>          }
>>> +
>>> +       kfree(surface_type);
>>> +free_tiling_mode:
>>> +       kfree(tiling_mode);
>>> +free_yclk:
>>> +       kfree(yclk);
>>> +free_sclk:
>>> +       kfree(sclk);
>>>   }
>>>
>>> /*******************************************************************************
>>> -- 
>>> 2.27.0
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel>

