Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19A3F6160
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhHXPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:17:31 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:22526
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238120AbhHXPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:17:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUcIBQEbUq2yPOA4x5HljLYtArU0nvuoIF/bQv8L3B/7NDF55mPi8mDBtITfTInQV2Wjh3rm5xC8gF2PVvBi9LfTdWz4zePWSeu3q8OxVsWRmjeWW/INpBaojwvskMs2U2NzvWxAImg1tlU3m0kVeOKcKIPKDGtGf86ReX2Vi9eVFl9YtY9ya7Lx0ZZ1q2BKigxy0lmyqMAm8fXkSaU2EAmOuqVMtZsIc0jp/nQakmVPVnQ7HGooS0TT6lwSG9mbVISnlJPC4tVtYpeuj3rDGPiP8vfoVaq6R1WYFeEYJvlEnyI2wMg4LrW671Tn7j0Qgpdb1QWrbUieGDmBvhSFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DslQ9p3cfgLOmxjcQkEEi1FP0gZVI2QzAXZnRJBrLY=;
 b=nZHVnFxN9WIsVBnQLa00WZYXX9bHnSC+nZ/bSEFaRG9P5kRUbQTrDl5UUXdZn7rdjLBeU9GZOTWfxEg+XOf2bxk5NskZpuWjH7CbrEnyj327Z8fjq2O9rvASWIbhjedf1jpsKc2Zh5QPLpDsSreceO8Ht9sh61KTtGnvj5t5x1sRKol8i/kjZLA7pONdza3kT+/FeORUSqkF9SGU/RyBHam7kupcuGPBfmKmgDijoMsqBYYAty+g2tTxGARlP2QkIwJnx59IS5D24+bUAqGxJNHVvF9T0bGAWtaSSFf49htYVC8pe8rLFD7AEqoErRDLKVdwiJn5DH6TKmclWHkU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DslQ9p3cfgLOmxjcQkEEi1FP0gZVI2QzAXZnRJBrLY=;
 b=c2qaXGE0uD95XWXeCe3aZLYsfxtxv3nf4Vx+D6i77jTk4BNAgxT2XN8zdyRZKtNOg2ngHAZS9HFcrWZljVZKTC84YB6FuFQd3aBLt682hYUg5gigbvlekPAEASoPC5ceZWoTGwaz6kWIxDFi+ju/2Dego/Y2Kzcp9fd0X8Gf/O0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 15:16:44 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 15:16:44 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing
 pm_suspend_target_state module export
To:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <2d7e3536-fc3e-629a-4f0d-2ac5ccacccc5@amd.com>
Date:   Tue, 24 Aug 2021 20:46:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSS/F9kcQcRKlNJ5@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.9] (103.165.167.75) by PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:49::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 15:16:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f352827-4393-4f17-b1dc-08d967122e55
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52855C814E5353F926A0033197C59@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yJKSq0I6zVplINzYvCN3nJGxp0V64hPhLGQxCG0z+S9MWlVPBZbDMcZX/52Jhk68OoGfE6Z3bz0PGf1UcLBYFaJ1PwYzB1Vp6Q+K5KnhTp0Fu2rZFRITg+x3ZOBUiEgID+5UKVoZ9M/15CcF0wWexDdeggwJRkjaqxnngoXkfGn5hfMsRNZVWV8waARAUCzMqtBKPvzn9gv14RvzETSz01csnKmIGYBfMxGjTfTskMtUCkppDmLnQilK7531xknx+mp7VPDGXGGorPrxKhNb0rByYzoRoa8QYQDXoKFgXIcX6cmRG+1sAsuWufB6dRK/lxMcIo+/hIvmR9c2Af5jhF+t3eTifelZBW4yisSf6yPm5gIA8/CAwtEO+paXLD5DtlvNxvKGxYN39uudH402gTQ1uLwSR4N/aIgoxRLhmB0vSBJIdAsExOcw4Cm86KvDzWi+VRrGmZMgqqMoqnkQWc+7KKojFh07iX3F4o9nGxb74hviPGyVMtJqL3hdjJsVkYZo8UK5rRYLCFfH9JXav/eu8FCta3XxU3dC4iXW5dI4GJ5iPVTeyCWnmfK5A0dlIrX/ZKXRk4QXhfzv3BcD3E+nLLbtIEBkH8MuB6loPAO9P0VStC83JTPKzhDWv/udrecx5c5oD4sJLhOfNEw7CFav+hYmYi1Eo7q6QIuD6DAfhmYsnkbxN1fPDO3F1yFCyAxQv1nnA2QJLj+mCd6ydIQsHc6SQLG9wYvxboct+ib3iCx3KzwDotucBgqheYUcsoCgDT/+eZ9sMWaVOAdRR7Az8ljEONBKW8eb/atPo4ekDDedI9MKvJokCeqnH8G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(478600001)(31686004)(66476007)(66556008)(966005)(6486002)(45080400002)(66946007)(86362001)(110136005)(6666004)(54906003)(16576012)(38100700002)(5660300002)(316002)(2616005)(2906002)(26005)(8676002)(956004)(8936002)(186003)(53546011)(36756003)(83380400001)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VQS0RScE12aXlYd290M2xuRXBpdXJZSU5FYk83WWJ3d205WEtuTjVTd0lC?=
 =?utf-8?B?RlJaQzFYZjNKOElSbERpVFhZQ2trMGpqNVJ1Qll6NDdEaXdFZno0ZWhMT0pW?=
 =?utf-8?B?bTdqWUorczJMZTdvSVMwbU11Tmx3a3FaUU1rWDBvRGZ2Q1l6YjRTZEhOWVho?=
 =?utf-8?B?MDlJMVJuclhtWlVBTnZnZlFZOTlSbmFUek1SaXVLcmJuOFY2STdqeHlQM1U0?=
 =?utf-8?B?Qm9HL1BKUnNtbG1RM0hFL0ZpaS9tcDF4alR2czR1ZWxPaTJDSnZ3Q3RNYzJp?=
 =?utf-8?B?bW1KL2M4bFRlZW9nYWpEN2Urc1pxZ1pCSXBselIwT1ZPZkdwVCt3TXlTZ2Rs?=
 =?utf-8?B?cVhiYXY1Sk1oSTJTajhJMXh4WlROdGhabFVQbTBFaXpQM2tjOFhRcFBsZ2dD?=
 =?utf-8?B?VEJ2UVAvT3dBa0V1YW5FNUtOTzdacmdwRzZUZFdRMTJ5ZHBrR2RFc0RyMFNi?=
 =?utf-8?B?TDR1dXAzUkRhcHZoTGNtL0pDcHRPMUtReDVtOFVidDNVNmg3UjJucXdlQllV?=
 =?utf-8?B?ZUYvSmR5MWxpc2pwcDJHOERRc0RKeTd6NS9oRk9uRDd0eDVNRHlGWnI0dVEv?=
 =?utf-8?B?Z0NydUlPNDMxd1BFeXA4R2w5c0JhOUpaYmpCY1FENkJYUmR6NkhyMnhDWVF1?=
 =?utf-8?B?dE5maEExZmxsek90U2xBZldzUXFIVFZQeUoweGN0MW9LWHkvV1lHR2d0eFly?=
 =?utf-8?B?bnVxZGIrSmpjR2pQOTRUd0w1MW5hWFViVzlNRDZmKzBtdzFZM0xlajVXdXM1?=
 =?utf-8?B?Ti9BR2tDV3dnNDJwK2kyZHZHZkJ2b3B1ckluTDJNM1k0ZDc2ME8vYzFwb04w?=
 =?utf-8?B?UkplN3N4Sk5PcERIbXBTd1lPMngzQ0VrWkF0Y3FMYlN1bHhaeTRaMjcxbUlv?=
 =?utf-8?B?dklraDJJd1ZYVnlicitMYjM1RE1zamtWN3dKV1FHV3RER2lkZXFUS1Y1K0hj?=
 =?utf-8?B?V1cxTVEzNjVhYlozUDg3ZWdEZ0cxL3E0RDhtbE81UDRuN0NQYVdHeG52V09r?=
 =?utf-8?B?VE1lUHNYZnlsM3hqZGlvTHJoQW9lcHhDaS9YMnJtbVVuRldsTG84Rkc1Sjdn?=
 =?utf-8?B?eUV1OWlWQWFjTXdudjBoYnJiR2dCUWhOK0oyNThiSmc5b1ZRSWo3RGpBYlRn?=
 =?utf-8?B?SGI5R3pidXVFQ0Q3ZmdXSjhUd2xGNnUwRHpyYkk4cytkV0Qva05iYkl4L2NG?=
 =?utf-8?B?VGVOUUVyTmx5Qk1tQVpDNUMrQWhzZ1NZRklWdmNBQzRUZ1BTSWlQNkxSMWRa?=
 =?utf-8?B?ZWI5RWVCZll0cUZ4NW1xd0lVMkpIKytuYU9NbkRKQTZFMlhsWUxpMzQzYUpQ?=
 =?utf-8?B?dTBhZ3NjRU5ROFVWcFBzbW1JNm1RUHhsblRYWnpLb0JJV0pKdHl2Qm5iTXAx?=
 =?utf-8?B?NEpMNEpodzAvQWtMMU5JQkh0TGZpbVY4djNhKzl2TlNiWmZCaFFxandaTzBp?=
 =?utf-8?B?QXR3TVQ1Nlg3WG5IZUdqNmFNd0NPZWorSzNIUmt5cGcvcC9hdGNham54Q0Zr?=
 =?utf-8?B?U1VDSzE4ZUVDVmxiYUV2a1BObXU2Y1NGZnlzaXdSSU8zaS9wZlVqRi92a1d4?=
 =?utf-8?B?NkJFNmJiWmZDRXdCSG5sRFg5RHJoR3B6cFMrSzlPNGFLMlFLU2xYbE4xbDRH?=
 =?utf-8?B?Mm5PUGFkeWUyY01DeFloOTFFTnNUWENKWENBbURvUkkxdzJzdHNZakJQL0M1?=
 =?utf-8?B?ZHJyVko0SFVQZ2MzNUwyVENXWm9LaUoxQkxKNzhpMlp5MXQvZks1ckJxdkYw?=
 =?utf-8?Q?G7RDqUfVPJ/60LgHbrgGfWW+4EN4zi3HY6Q+1D3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f352827-4393-4f17-b1dc-08d967122e55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 15:16:44.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqFQnNrpTEeGmyReao6MdZ1q21HfvlKhwy0HD7XbCLgh83nM9T7C5ERdemwqwXEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:12 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Building a randconfig here triggered:
> 
>    ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> because the module export of that symbol happens in
> kernel/power/suspend.c which is enabled with CONFIG_SUSPEND.
> 
> The ifdef guards in amdgpu_acpi_is_s0ix_supported(), however, test for
> CONFIG_PM_SLEEP which is defined like this:
> 
>    config PM_SLEEP
>            def_bool y
>            depends on SUSPEND || HIBERNATE_CALLBACKS
> 
Missed this altogether!

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> and that randconfig has:
> 
>    # CONFIG_SUSPEND is not set
>    CONFIG_HIBERNATE_CALLBACKS=y
> 
> leading to the module export missing.
> 
> Change the ifdeffery to depend directly on CONFIG_SUSPEND.
> 
> Fixes: 5706cb3c910c ("drm/amdgpu: fix checking pmops when PM_SLEEP is not enabled")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2FYSP6Lv53QV0cOAsd%40zn.tnic&amp;data=04%7C01%7CLijo.Lazar%40amd.com%7C71b6769cdd574a05b32b08d966e37525%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637653949420453962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ai%2B95gtZz0r0pXYaUkG97tiuaiykEy8%2FB%2FtmHP3W4Zs%3D&amp;reserved=0
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4137e848f6a2..a9ce3b20d371 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
>    */
>   bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
>   {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
> +#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
>   	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>   		if (adev->flags & AMD_IS_APU)
>   			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
> 
