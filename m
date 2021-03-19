Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470934249E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhCSS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:27:09 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:64865
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230057AbhCSS0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:26:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUeoZZVjbmYKeXAhcOR9RFr732RGjqsziE0D9l5VQ5uRtqWmGoqstuHbABImpqZwYB1SxzwiTZo9fdZlCl2sQJ4lA0hVHpwkPLf9fnNFtOh22TT4qenxVpt+aOx9mZyyrxI5KuZ8ED0Yu84rLUPhCo2Y7gOfKfyavlJygQe5XMAFW/iP04a5Njz+0vQtRA95Xqp7YX002jH6HZ2XwEO4XNJHwwyLeWK3VAsPZ/7lmJP+wpiOYfv4UrnNAOp5sHWeIj2oJqeYxVr8HtmfJbiuH2TPJVH1oFgyFJzZqX2O0wZhR/xZx3c0pHtkGfWtHCzJsPnBKzB3WV65aS2cKD/SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMWBe1koTd2f570RhxnJQl5CX4Sdq6U/HkBbOXJ0+bc=;
 b=d06Q7HHEPwFngCl0zOtWbCAaeOW/zATVkGfDsdQpqJsqsQoymzncGpI4Zzk/DKyilmBn4m0VcGtgVnlqmk3mYpA2UWWhbsJCVMiCNix8rGKWvSTCsmet3rTiAyM5BNQWbk4q1VBQbQLX05CbgbyTSZWW4uiU+YG9UD17IslMZhRrY67wBzabTKC3x1fLZ6TK24SM+/EoQKYknGeq4klPRV01fYXu4/FwNU0f9QTFFQ8SoNEZn2bKEOkVy9qTGxC8bGklceVQtFdx0m9+IcbfQ7sgrknFg9xzyKrFNKSQ0vaxu60mACAXc59Unay0Rv50KQHfTy1vWyzcFvMe7Lyrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMWBe1koTd2f570RhxnJQl5CX4Sdq6U/HkBbOXJ0+bc=;
 b=MZzyCK8lgqLhjmWaNH7aRNx/KAxoA9l5ApOOdPdjGnudXijcCIdJp/h9OfOxxUI8U57jvv4etVhITsF/85drOU/0UBQy4PwOb+IIAr+ROVfQKe2Ux35KaLNTyKb9/4NzStiCjiYRXccCAAnpltt9vh7TZG4CoFf17TKUcZw4M+M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 18:26:35 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 18:26:35 +0000
Subject: Re: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     Alex Deucher <alexdeucher@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-7-lee.jones@linaro.org>
 <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
From:   Harry Wentland <harry.wentland@amd.com>
Message-ID: <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com>
Date:   Fri, 19 Mar 2021 14:26:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Fri, 19 Mar 2021 18:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f13f36d2-4c7d-4ebe-6488-08d8eb0486dc
X-MS-TrafficTypeDiagnostic: MW3PR12MB4588:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4588DD04A94896526719FA6D8C689@MW3PR12MB4588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrBXrQe0K01ssnPP52ZRLmTSVgaaduPD4DXb47ybk35Q4iaLWEIbGsbHC0Vtnhz6373rKw7Qwp0VBwBriGY54ovBt0uhsFqzS2OJDVIZdeXfj6zYmtcN1sflAPJOGWAccIrHiObFXVF+1WyB8FwW6HoTjwSGgztXMMBA00bIqG+cGjABGRr+SAq2fuO6O7LW2yso1xwk9fPVKvqLtLAzAqAk2dxw+q+CGUFIQACPYR1tpPc1mh/WAdOU9fKfR2MZblz4z6vYkAvtu2jIEFn2218h4Sz+PhBX1mAvkhVuimd+2kwyh7yMGB8a5b14KLmtOCZWX9z9UUWfhw4sy3OPNDCmPF/zXR5D3pvLRscwDCKNfT/Np7rufnK0FZZB0k6hi8ltTDBJVLLWWz7mscREKXnKmx83AiVtveTQUF1klIiQWoeYmXjTpy14NPciJQMhJBRejWEANoqUYDB++e3wVzwq1ulAj6cWq3yviMxYsLjmNpJKxCypBZPFkQtFq7KK9/L/W3KaKKGUA+SxQMjyh4XaK4KYWgODn7MzsA54g/guHgGeIiRpo49APKRIKM2x3OIECjbEMPM2I9vHCWvC+v/HxfhglQKfX/NBq/wwm1ykCT/7+106erZKJ4/nWhd6sqkEOALy118zPljthYrcrTkIzmVeFqPaux0TNwHfAPZwsSLo77T2lKSuKBSNwkDc7g04XS3Nf9XEtKffu0OySEPSiZyVUK7e9VxQRJe6i4d0ROlUzN26CBoqBbrt/1GUGrURxVw4CBV34nTyKONvIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(186003)(956004)(16526019)(2616005)(38100700001)(16576012)(66946007)(66556008)(6486002)(66574015)(53546011)(966005)(316002)(2906002)(5660300002)(83380400001)(31696002)(86362001)(8936002)(54906003)(31686004)(8676002)(36756003)(110136005)(478600001)(44832011)(26005)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0c1a0U3V1R1eEpCY1h1alpmRll5UHFIUFdDNGtqc2NUNXJLakpYM2Q1b3JW?=
 =?utf-8?B?ZHd6Sy9XTm1XU3Ixa2tVVWp1amxLOHBOVy9MN2UrVG84UHhYb1Y1bkJiWDBM?=
 =?utf-8?B?aDY1eGxxbDNNekVDODJzc2dOcmpTaGs5L3k1S3hCeUNjZUY0S09MQlNDTjl2?=
 =?utf-8?B?UURDVU5LbEx2aG1NT1pxMVhZMkxKMGhYcFJpRlYvZkdkeVUzOXZxdUxHY0RU?=
 =?utf-8?B?dm5lK250aUU3dFZvdUVXd2pNcW5GZTV2aU5ITk1Ld3U0OWtENE1ZaytKTjJi?=
 =?utf-8?B?N29FdVdvVUFWZUNhcHBqSlN1OTFHd2xjei9pZzh0VmNWK25BRXZkSHVZR2t4?=
 =?utf-8?B?OUQzZHJJWVhxaUR4UVhhTjNlUnBES0VZbi8yQ3pMb283c2liazJhYTJ5bU12?=
 =?utf-8?B?TjR5czhTMkdlTmlvMWtTamRkdDdDM3BSNjdvWTZRNmZSMGFPcE05YU9HMXBQ?=
 =?utf-8?B?WkZQcjlkSGFrbXlLZXFHb2FibktxR1lHSmw1VlRjVGtmUU9lRS9sTTVaSUtv?=
 =?utf-8?B?ZDZneEU2QUpWNXltUFc1aFpWMG1CU3hJQm95bWVtU3FGemZiOElSMHZQWlhz?=
 =?utf-8?B?L1pRcWh0QklRTDBHeXd1UGtRbWMwdUlLRnBtVGNBNHF2dXBNSXdGcDNxM2xi?=
 =?utf-8?B?TDZwdU1tVWlhaGdNb0hubm5vTGgxekl0NTAvOTFYNWZwelhUb1B4SXdKLzJH?=
 =?utf-8?B?cUxFWU9XcU1kczR1Yy9hV2sxSFFOdGN6M1V5ZnlKS0pnRFZ1MExHclNCM1Jk?=
 =?utf-8?B?L3JiWitPU0hqT3ZyK0trWERMMUxsYkJVNEowY3ExVVNFeklGVm5sRmQyWU1B?=
 =?utf-8?B?NEl3NFQ5eDdLUDh1bWZDMTNsa0tWZkU4dkFFQm1sQmpMMFhVTVAwU3ZwRzAx?=
 =?utf-8?B?aTZITkxZaXhIRzlOYXRkeG5hMFF5YVZXOXhRRnhiNzd3NEcvZCtLRTVUSjFN?=
 =?utf-8?B?Z1V5dloySUtqWnFXd0NIVVhaTENYVUkxRWMvT05kRjdCb1hGUUVCcjVmZDBm?=
 =?utf-8?B?UmV2TUdqVkkycHUvY1BFWElwSW9XeVN5Qmc3YnBndzNjV0NXM1lZMzlZaGNj?=
 =?utf-8?B?UTBNUTYva3djclhXNlpwOFNVUU5qL0czMmorVDZ6NDJuN0tXeXRVUFJYOXNK?=
 =?utf-8?B?S0Y1Um4xT2NtSjBxeHdYUk5JRklDWXl2b01OdFFqUDNBOU1uNktKOGN2S0c0?=
 =?utf-8?B?TVdRWGx2WXA3Qmsyc1ZpdVVsRmpLb1JXOStRK0JxRmNud1BnRkRpb0JSS0No?=
 =?utf-8?B?OTJ6Y3liL2xKc1ppb1ZqQkgrOEt3TzJtbWVtdlU1amJJT29sWFVNOGZLWE5k?=
 =?utf-8?B?RUZtVml2OXU5VVJBUlAxZzBjcVI3VnZIZytFajlVRG9qMlhuWXpLdDhwK0Fp?=
 =?utf-8?B?V0VQUytZVWtHM3VvNzJVQ2pNMGFPcWVSRDhBQWxIVzJ5cXc5MThMd2V1SkUv?=
 =?utf-8?B?cHlKV3VwSStpam94Z0I4REkwZG5Rek1FOUtlZFlCMkhRVWp5bnpLVjJGNWVE?=
 =?utf-8?B?YlZJazA0U05zN2xwbjlkTWVLbklLa0xROXZWVzlJczJGbEJKdkQ0YVU4Qkdv?=
 =?utf-8?B?Qk9DeWY4NzdYWk1pejFHZ0xaaXc5LzR3Slh3WW5yMC82YlBSSmpTR01rQU9a?=
 =?utf-8?B?MjRvQk1GTWFZemQyR0RVZFNaNGRzbEExSDlSU2gyWnh0UDd1cUZxMFYvUU42?=
 =?utf-8?B?UlVaYnViUVkxOEF1VGYvSHV3MVZuZTE4TmZMM1psQ2o3QmxKRXBzQ2k2V3Bl?=
 =?utf-8?Q?H8TPehb4EAnmQCuTUetyc7jGpyoioqO6xuiZEzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f36d2-4c7d-4ebe-6488-08d8eb0486dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 18:26:34.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwGaIygZ5mtOoJPmfcKHLYvunQiLkhgfS+PWzjzxkUXO7myyewGPona3LOgRItqUA35JpfDnqHxq45NQim4YGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-19 2:13 p.m., Alex Deucher wrote:
> + Harry, Nick
> 
> On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
>>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Colin Ian King <colin.king@canonical.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32 ++++++++++++++++---
>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> index e633f8a51edb6..9d8f2505a61c2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
>>          int32_t num_cursor_lines;
>>
>>          int32_t i, j, k;
>> -       struct bw_fixed yclk[3];
>> -       struct bw_fixed sclk[8];
>> +       struct bw_fixed *yclk;
>> +       struct bw_fixed *sclk;
>>          bool d0_underlay_enable;
>>          bool d1_underlay_enable;
>>          bool fbc_enabled;
>>          bool lpt_enabled;
>>          enum bw_defines sclk_message;
>>          enum bw_defines yclk_message;
>> -       enum bw_defines tiling_mode[maximum_number_of_surfaces];
>> -       enum bw_defines surface_type[maximum_number_of_surfaces];
>> +       enum bw_defines *tiling_mode;
>> +       enum bw_defines *surface_type;
>>          enum bw_defines voltage;
>>          enum bw_defines pipe_check;
>>          enum bw_defines hsr_check;
>> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
>>          int32_t number_of_displays_enabled_with_margin = 0;
>>          int32_t number_of_aligned_displays_with_no_margin = 0;
>>
>> +       yclk = kcalloc(3, sizeof(*yclk), GFP_KERNEL);
>> +       if (!yclk)
>> +               return;
>> +
>> +       sclk = kcalloc(8, sizeof(*sclk), GFP_KERNEL);
>> +       if (!sclk)
>> +               goto free_yclk;
>> +
>> +       tiling_mode = kcalloc(maximum_number_of_surfaces, sizeof(*tiling_mode), GFP_KERNEL);
>> +       if (!tiling_mode)
>> +               goto free_sclk;
>> +
>> +       surface_type = kcalloc(maximum_number_of_surfaces, sizeof(*surface_type), GFP_KERNEL);
>> +       if (!surface_type)
>> +               goto free_tiling_mode;
>> +
> 
> 
> Harry or Nick can correct me if I'm wrong, but for this patch and the
> next one, I think this can be called from an atomic context.
> 

 From what I can see this doesn't seem the case. If I'm missing 
something someone please correct me.

This and the next (06/19) patch are both
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Alex
> 
>>          yclk[low] = vbios->low_yclk;
>>          yclk[mid] = vbios->mid_yclk;
>>          yclk[high] = vbios->high_yclk;
>> @@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
>>                          }
>>                  }
>>          }
>> +
>> +       kfree(surface_type);
>> +free_tiling_mode:
>> +       kfree(tiling_mode);
>> +free_yclk:
>> +       kfree(yclk);
>> +free_sclk:
>> +       kfree(sclk);
>>   }
>>
>>   /*******************************************************************************
>> --
>> 2.27.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel>
