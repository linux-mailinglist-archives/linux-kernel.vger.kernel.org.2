Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8B3F5EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhHXNJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:09:48 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:38369
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237436AbhHXNJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prv+33VMpUHBP4jUTA/zXYJpGIPeVJb9ZyCbzPtyFVGdMCp/2Ve02UIYgvjtINyqokj8p8ZKPIhDH/HXDClU6ca2SNNhFqinh8gM/M3hdYE356RNyIiLbu4sKZatsQQvwKgK9ZqRxpufaH6agsf+6nj0vxckM9C48qsUwGwxleoNyvrWJqyfW7hgdGGAT6oMDx9oW4hF+Q31ZTugbmsoGdF1v3SMrQEya+LzntSNkuHGvyYGj2dRMeWFSyi1I7hFV8NRuOSMMZKXxvybP11lNwPR3zUqZLZUcCHlugTcjjHyZSKCwrQMa7UEPkGJ7dye/cboT44fVAg3zR0aJMAjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgW+XzqPoDve8l+OhO8k8SsQ8pR+e/f1FECW+2PA44o=;
 b=ALoRzGn6k38YtqGxnOlNSdDk3XL6ev479/Cms68WwDGICdTLLW78oUSbUm9roOz+l0H7gkVDi4DBePDnJn1N5FmnRb2SKyPJxxcyiLSih7ma7ti5hWMPEmnm60/PoJSTqUdMrYfijRu5hCzOHLomgK09X0oJOahPfZyqWskIWJ9bMv+g1VArX8qBHctkup+8OY9o3ddFdLZu8BlV/ggXf/DCT0CukCMAv1IIQMCRy7BG4EbyxdCSS5wOZuP5J6yz4HgglaSk+jO8qcCF4f9o0flvXM6t5c7oK873OhVqxZS+JSAju4lHaS+HDFBJQ5sQo7+w2BumUrTP42e/l8hh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgW+XzqPoDve8l+OhO8k8SsQ8pR+e/f1FECW+2PA44o=;
 b=Y0+N9jMZBSkRPJkEWyM63NfQ+TzCFWa1eHNV2wYlZCUBLwf8g3HeHRV4mvFBZMJ6oIa6QaFo2FceR2btwgpvWG0v55PN8U54K9SgJ0rAkK1YwpoGOg+4AdKvoGP/Bs8Id3gix5OuS9QcueUDV20ESyk4MCE1C9iVOUiDjNP6aE0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 13:08:55 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 13:08:55 +0000
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
Message-ID: <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
Date:   Tue, 24 Aug 2021 18:38:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSS/F9kcQcRKlNJ5@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::28) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by PN1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b41a9f8-1014-4c89-5908-08d967005332
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52082D6677913A3D23877C3C97C59@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjbxj20MWElHlxTZ81zzLSOeQXsDcwGp0B5fhUQZO3vCKbnb7oLqZ+U8mQf9ROqYogMYjlrTsgR7AWOm0xD9HxwJyPIkPOPe3FDxUTOsQixHPq3PCcUC2bdBFA7JRT3jO628fUvn2J5r+RdEovMQAQmhZE/pJOtaarMqtkCSnytW3P/LSetnZRsyNj887JdZJIAxFHdU0N2nPoZn/wfMAwsTepzj9GZscOeJQgHyLlSzcQUrc//JT/IEJ0f6oY4eQckiwCFNtyLFfQX95hvGGipmk7No69/r/y43TBJ/rwlJwd6xSpnyB6m6dTIv0FPT4gWpr4yGmZREFh0lGI3NdhgoDGN7W7ZxCftJphJBzyaMyPx6mRGdsbJETEUv4VMVQNjW96EYzNZfMVaMkjyj22GviiCpzgQzD7Pwfj6jRu1lgKR3VlFSwONlRy2zpcoJE4medW72gFMXBbP5a60PRle+7ZYm8xHiGkVgPHJxsc/vvDEVPIFPzTYkITGnj0tqe74FX+Jp+f1uHKEDlxJK2nbe8vacAeZRSYUs6si0/+ILfkM4C0ia3LlC/yd+srrpCMMCvFSG4VLVvoHbDkoSLSiVOcUAqoW5HcUuCNcRrv8c8bTfEdw9UoQZkV+VXV5S1SRhNwTTeiRZ1RuBSRjn3QC4ra09+HKiCZMuQ8ycECbuXdyhLBgLW2uF5a8EVBo2MRg+aaXeYtEUrX7pCegq2tRRUtX2bPPeUND38FsmDXJi43mdjLz3aBBNU+buWI/11PVmuSwk9tMIuthILbGFpa24fHKb4F5nqTU2+wNiyBIlu38iUqFjMY8LVSFuYAIxusH36uFdKSY1HhGXTNTj/hqJ4rybNVkiruUKCp17NTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(66476007)(66556008)(66946007)(186003)(4326008)(8676002)(956004)(316002)(6666004)(5660300002)(45080400002)(54906003)(26005)(2616005)(966005)(110136005)(31696002)(6486002)(36756003)(53546011)(31686004)(86362001)(38100700002)(16576012)(478600001)(8936002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBSb0hrSktQcWRPeCtWMHFoN2tCeXpiZkRZdWRtQk5KSU00R0NBb3VBZXlr?=
 =?utf-8?B?NFRyanoxVTIxU1YzR3JZWkltNHhTM2JVWFppN2ZTSGd5eURyQ3dHdWZmVWRm?=
 =?utf-8?B?eWxYUGFUUEJkenIyQ1o4MU9naWFpMXozVG5DeWp1dXNMM0RZWDRBMGZkaWk0?=
 =?utf-8?B?clQ0MDBhZ0xoU1d5Nll6a1EwWmFnL1Y0NEFFNHMxTFY0dm1CSHVzMmhIM0J5?=
 =?utf-8?B?N1Z2VHF1SjZYZmZKNUhneDdrWFhIdGxaYjJFNjJacGVEVXh3Zk41emxWRHBt?=
 =?utf-8?B?Ri9wck9XVWdUZ3hzTVZkU05jU0kvZlNiYklSYWpNVnBxTTc0TGtSOTFhbytz?=
 =?utf-8?B?YUxpQnI3YkR1YVRkYitmZ0pscGRIbXVzdURCMlBJU096cFFyQWpNVHRob2NT?=
 =?utf-8?B?bVZMSXBISS9UZUVtanRKd2FCUTYxNlYrck5jTUcrZFNaK0FSUEhhbUhkWDRs?=
 =?utf-8?B?ZDUwNDhsVUZpMTVKZEk0VXZFTC9wOWt0allWbStmZno2UnV2OGc3VFpTbmFC?=
 =?utf-8?B?eUx1WFBvWTIyOThkaHpuOHpsV0dVYlVZRnFyWVUyZWh0aU5aaEd1Vmdtc1Bs?=
 =?utf-8?B?MEtxdVBCUGVZYVhKL0xZR1R6VjdrbXJsK2lKYkE1aXdaMTc0RjdHZlJUaEI5?=
 =?utf-8?B?a3VqRDlSdW5ONnNzbE9vVW1ZZGExSnJCUStKYXFZbDZxVFJleVFaNkVqUTBO?=
 =?utf-8?B?TitkRklPem1XeGwzWVF1QVl1MmwySWdHc1VBYWpGbzJZc1dQSFJpd3ZMTFVL?=
 =?utf-8?B?WUJ5OHI4T3VKYmJIYmFKT01yeXN4T0E0Sm41YnI2bUNPQjFWbytNNWVFRjhL?=
 =?utf-8?B?Q0J4MUdJVUtEckJGemRKOUtFSnJiTmRqcGt0d0FSOVhQQ2k4WnBBd3UwcUc0?=
 =?utf-8?B?UXNhOGVIUStDSWpLWWNFL2Zwc3RjUjg2enB1SERTQ25ZMEgrUkNhSk5NMVFz?=
 =?utf-8?B?cXJteEw5aEo4T1crWkk5dXhyT2htbW9WTnE0eWJheGhpZ2NSSldCRytVbE1X?=
 =?utf-8?B?ODVOS2Z6M2ZkckJwQktFYUJYeVhmZHNnTXBOeFhpWjVSOThpUksvdmVKV0hj?=
 =?utf-8?B?QzdGM0dac1lWU1NscGtjSnNTSW9NYzJYRzNqY2p6UUFTR1BtVUpsU0N5Z0ZI?=
 =?utf-8?B?VVB5cjdsVTJkL3JjN3IxekhSMjN2VURiOWo2Wjl6SEs3QU9zLzB2Smp2OFRO?=
 =?utf-8?B?aTh6Z3VtOWZTY0QzbVJxMWE3Z2VqNWY4M3hxQTZDcG5UOHU3R1lRNWk3TmIv?=
 =?utf-8?B?OFJzTUp0TGJ2b0FvRHBXS3dvMWsvTmNtVjgzT1VTNndjTElZN0lUQ2N2NDZ5?=
 =?utf-8?B?VzFFUUF4UitLeE5BQlVMSUZ4WU5DRFB6K04yWjk0ZThVV2N5U1o4QXVWUFdO?=
 =?utf-8?B?MU1qTC9ZY3c0L2E4NjhYSDB2RitZRjBZUGRMNWtQWDdBTk4wd2h6MnoxcVdB?=
 =?utf-8?B?b2NZZnV4Ry8wZnF1WlZUdE45Y3VEVnowNVBwY1krTHF6VExKc3VXSGpiMGdk?=
 =?utf-8?B?UFVNSkFOMktMZVowdEFuY1lDZ1NpUXRGZGsrVHJNSUNzRFF6VjJDbVB6aWcy?=
 =?utf-8?B?dGd5OCtWN1U0QmpOb3lOcFI2dVVMVzlZY2FwVmh3N3hsbUVuUjIybE9kRW9z?=
 =?utf-8?B?d28wQWhWZXkyb2tQeDhJeWVoeWxhWlFucU1WaTF5WUhGY21hM2lMN2VsRHRl?=
 =?utf-8?B?eTRnUXpEc0NzNkhkL1VtZWFmLzdyZDN6aU56OU1JUlZHWGJDdG8wd0NGV1h6?=
 =?utf-8?Q?6mw8wX0hL9grJw89HaRhu3YTh8AmxprETREQHk7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b41a9f8-1014-4c89-5908-08d967005332
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:08:55.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibPPMDSxive4wXb/RLk3v35ccTSsruQVdaeWkYnZx6JzbWogihq3nKgiMySrdfnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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
> and that randconfig has:
> 
>    # CONFIG_SUSPEND is not set
>    CONFIG_HIBERNATE_CALLBACKS=y
> 
> leading to the module export missing.
> 
> Change the ifdeffery to depend directly on CONFIG_SUSPEND.
> 

Hi Boris,

Thanks for the patch.

As far as I see, in linux/suspend.h,

extern suspend_state_t pm_suspend_target_state; is declared under

#ifdef CONFIG_PM_SLEEP

Without CONFIG_PM_SLEEP and with CONFIG_SUSPEND it may give variable not 
declared compilation error. Sorry to ask , but are you not getting the same?

I remember giving a reviewed-by for this one, looks like it never got in.
https://www.spinics.net/lists/amd-gfx/msg66166.html

Thanks,
Lijo

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
