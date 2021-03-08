Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F80331354
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhCHQZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:25:16 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:9259
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230050AbhCHQYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:24:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRrOfSWrwzJWJ3rQneliCKi+4GfiQBc5jvVGySxNP44WwVFBQ8Wo94vhsNjJsNlDReMAqWKm+Mo6/RSXmuHCHuGZ7YTraba1o6iZZJ8GEb6GE3X0lytYXXFke123ryCZh4s4PWiu/pYK7Va0MrDy7fBFxyw9vdlzjrxwUu0jHkoTMg1uT0o0cRybjN19c7ESsJhSZMnfs6LiBfbf0E8DvsEWBz4gzrFfo8X3p4Q+EugZ08g73nYTTjhk0EaeyOq7Lec+0mlgrEAbiSkKy+Do8GwCKBArpE57dYg17faSnna0V/dy9CxShHxvg9d3q0OYyCQ7NensAZdKzxsWfZ7jMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R/Fe1jdY1rNJaHR3PGcwJx1r6WV7g3RnZk+YCTihpA=;
 b=Ncfn73fdkvypKra114dFmZPSrF3k+5lGzCUAi8k8/fc1kbLSZo/orgzIR06MXgE9/eQEPXfUbLzwQbFNwWCJENXx82Uz9g7Qsrj8PlyYtzk1dTb55rOZ5uU5Q7BHdVhibj7alnIYXfVptkt2lJtshXW0IWJNvylpYJQqaiIRuaKktw3PAocbjJdzrXpUGDjGkaJuvrSVvZzKYPGypiUK/wo2MHJcMk2uajmvgxjlTM/NpAnZc204tCaVpW2Vk6DdTAXEc+toWqBtfliBpDLlzFp/4o/mSgy6DkJjBrmtnOoUXdmPpv1PhsritgM0s7BqL0HOrtwrE92haicU86a+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R/Fe1jdY1rNJaHR3PGcwJx1r6WV7g3RnZk+YCTihpA=;
 b=DrFhtXvhOMhL0EMvwadLSwfTBvSzCrcCAKT/La+RsJkQfX2JxDtviMyMc8J3i6cEtqnzhnz/gOmnuKIPXJHUBCtPqRFBJhMnPs8yvGgihMY12vv74y7OxqBpywnmHbk/rTdwmgpJcDvV26VrvocBfJxuJm/mK6KiY37ukAutiLE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 16:24:47 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Mon, 8 Mar 2021
 16:24:47 +0000
Subject: Re: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
To:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Philip Yang <philip.yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210308153359.2513446-1-arnd@kernel.org>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
Date:   Mon, 8 Mar 2021 11:24:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308153359.2513446-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Mon, 8 Mar 2021 16:24:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10706afb-a621-4419-9f73-08d8e24eb0d9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB245178EE7E40C6528245EA0392939@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZD7p/5BxGKXHi4Ph0fLSwWYZstsB8wt/MGTCWMkRAd6yPLwdGnwC9Aso3mw/io1OVyLt3S2eGULjMFwvCJ6MzoBlQP/hP5ZpZ1AwbS4MynOsKqio+Il/lv/0AQ/6FGBwtAQQoR5re8DALiOqXDkisZ5LBVswzEY2VQDlMOaAa3IcI5INwoEKSwYltHs995eIeOEjjT4bDH6mP0Jqjzf01X6fxMOVOVw7Xr1t1voDv2jCep55inn4v1TPzBnr+TTmDnlp29svW4gUjLMv8gREAhfJ7mw0UWW5N0sJkzX+gX2FiVilIOnJ2hDxjLxV7J6gCNpRc7nhKFT3H7FqR6z9JmKVF/u21FFqoD2owLctsg4Aaa4F4xXtTQfnsnUbB3wlLXIrXHnj113fGsyLiZEkc26V1oeuBmCWzkyK4xJfVfNHEjpnqiW5v6onKaIJJ3NnWux6DV+av7w+jwnD6gQPa4wMwm+ZglQCmD/RTIJ0bEPTiR7DHPtwtzBsv6qCWvavwK9V+RPH+YAwqg6VrBKyJ6rBTUxcp8/lg0LfUiwxgyLYOTruEQB/XCbLx43H1WqfgK88jvuSTvHdOteIa0GTU+0C3Q/xVRojRulVwjwcYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(956004)(110136005)(86362001)(66476007)(36756003)(52116002)(31696002)(2616005)(16576012)(26005)(5660300002)(54906003)(6486002)(66556008)(4326008)(8676002)(31686004)(66946007)(83380400001)(8936002)(478600001)(16526019)(186003)(2906002)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWpBNG5icXhFaUF0cUYwbzBGUklyQ054VDRLVlVnekFmM01aRlJyOGVtd2F4?=
 =?utf-8?B?NmdQVDR1WFdyMHByNytSUDZOcG9XckN3Q3Z0UWlkQXdZa3VVaW9YVHo1cSsz?=
 =?utf-8?B?aUJlOVhZV1JKQ1J3M2ZWbytZay9xRzlJSzY0VGpCVW5kdWVVL0htaWFHQ2Fq?=
 =?utf-8?B?MFNhM0dhY0RxNmFQZVNrUk5FaGtyT0lwckxKSkNtMWJpalVWSUJDanQrb1Ns?=
 =?utf-8?B?bGJMNVpPb3R6aFNvcVNCbWFMWktlZUgzVmoyR29LcXo4aEdoSmVHN1M2aXU0?=
 =?utf-8?B?SG94MjB0a3JETWZQTHVlRVAzQW9VOWxlYjluaE44VldZOHRDRkZISy9RZmZK?=
 =?utf-8?B?cktoMjZHeFRPZElwWWFGQXdpY1JublkxSzlzQzNEaVhDVk1PWDN4YmNIcGJQ?=
 =?utf-8?B?bWFlalNpR3BnZk10VVMrZjN4VDVXMk9xcVU3ZUFVSGZ2b1Bzc2QwM1hpdTRv?=
 =?utf-8?B?SnNVUzRZeWNidnl5RStIaEcwblhxMzI1emxVd0NyRGlIODIzZkJCbitJeG9Z?=
 =?utf-8?B?c25ZaTdLVGlRNDdKdTFpVEJtVmJCaWRGbzhUMjBoMmRySDZtTGduYW8xWEhK?=
 =?utf-8?B?N21xTUw3WDNpTE4xczBnc1M2dU1QMTUrMlMvcHdSMG8rdWRYQXRtb1B2Vnp2?=
 =?utf-8?B?emlTcEVuZFBmNHAveEVkcmJOWWJ4OGVJMm5pQUZNQUFjdllsRFFiTjdqYml6?=
 =?utf-8?B?VWZxZWtQME15VGswampNWS9iUEM4bEZ0ZEQ3THgwRFQwVmZlWkRZbDU4TUZi?=
 =?utf-8?B?dElIbHZkbzE3RldVYXUydWJTemF3dnF2K0s5Y1lPT0pYQWhwQ3pVWjdGY0V4?=
 =?utf-8?B?Z0FnR0VILzc3dEJjUytJNHBxMmphcDNYeWR4bGJMdWRNc2lUZ1FuRUxuRFRR?=
 =?utf-8?B?cUgyaS9nRUg3WHdiMVNPNXdJWmZzSTBiTzl2WTBqVDI2UXdxMFlWdnFhSEZw?=
 =?utf-8?B?blgwOHNLN1E1ZFdHNDNEaEZUZmV4Q2hXcmJ4WDR1a09rRkVSMCtVQS96NTQy?=
 =?utf-8?B?Q0xLZkZsK0lyMlRTOW1naFp1aXlzOVBnYnFvRURrOGR0ZDZYU1NyenJWVWEw?=
 =?utf-8?B?QlNsL05iQzJldlNhcDk4U3R3WEpnVngwQnhXakFma1duRTE5dWt1RmJselRO?=
 =?utf-8?B?UE9JcTVvb2tjbmpoZko1ZDZ3V0RnZGxWTjg1TmQ0M2o1eXdUTU94SzBkSk9H?=
 =?utf-8?B?b0xXRzF1NVlaSHA1d0ttRGVxM3EyanpLWkx6ckhGSzJCM2x4c3dTODlFVXNy?=
 =?utf-8?B?R0lLUFNaMHNZcTNnbVpkN2NEeEV2ZXRCbFNxWSt3VWlCZ1B0anM3RkFRaldx?=
 =?utf-8?B?enNHa2ZHZmdIQ3RPZHFUR2h0SmtlMkN6Tlc1NURQdHZNSm9nUkNwMWJSaExm?=
 =?utf-8?B?MU1tellJemdQTTFuT2dIanF2L1kyYXR3OUNkNzdheXVrSE5paGdjKzZXVHFm?=
 =?utf-8?B?ZVJHWW9Va3hMeE1oUmFpMDJmQXVTdjd1Q0FENkNmdkVEYzJRT1dvTDllNHQr?=
 =?utf-8?B?Q01ydzByeTF1UFRhMWRyN2xWUlM3WXJ2RU00Y0pzN0p4QmdpTGtRckhnc2du?=
 =?utf-8?B?U3Y0QXMzRDk3VnM5K3Q2S0l2dHlrQUZQdW5HdHMwV0F5N3JKbmNQend1MU1h?=
 =?utf-8?B?ZDBFZis0UVRHMXB1TnN4OCtZcEZ4K3hhOFZOVFc0MVlRWWs0UUdjY2lBY2sr?=
 =?utf-8?B?VEhCZ0ZHb2ZWcFptemsyK0JTejBJNHc4WFZKUFJpWUt3UGRiVjFmdVB5VzlK?=
 =?utf-8?Q?A+seudvXByXoGV80/ZhtHIL2mjg4fKFMRUMQ5lE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10706afb-a621-4419-9f73-08d8e24eb0d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 16:24:47.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7XMu9efW2SDQzZJQgPkUiagnhUJUc5DONgxkuB1CdsMq7LRHHvIDqxbSzpbmY6eYY6jeKhUfEFwA7uHtGKE4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver build should work without IOMMUv2. In amdkfd/Makefile, we
have this condition:

ifneq ($(CONFIG_AMD_IOMMU_V2),)
AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
endif

In amdkfd/kfd_iommu.h we define inline stubs of the functions that are
causing your link-failures if IOMMU_V2 is not enabled:

#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
... function declarations ...
#else
... stubs ...
#endif

Regards,
  Felix

Am 2021-03-08 um 10:33 a.m. schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
> against the exported functions. If the GPU driver is built-in but the
> IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
> built but does not work:
>
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_bind_process_to_device':
> kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_unbind_process':
> kfd_iommu.c:(.text+0x691): undefined reference to `amd_iommu_unbind_pasid'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_suspend':
> kfd_iommu.c:(.text+0x966): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to `amd_iommu_free_device'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_resume':
> kfd_iommu.c:(.text+0xa9a): undefined reference to `amd_iommu_init_device'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to `amd_iommu_bind_pasid'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to `amd_iommu_free_device'
>
> Use a stronger 'select' instead.
>
> Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index f02c938f75da..91f85dfb7ba6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -5,8 +5,9 @@
>  
>  config HSA_AMD
>  	bool "HSA kernel driver for AMD GPU devices"
> -	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
> -	imply AMD_IOMMU_V2 if X86_64
> +	depends on DRM_AMDGPU && ((X86_64 && IOMMU_SUPPORT && ACPI) || ARM64 || PPC64)
> +	select AMD_IOMMU if X86_64
> +	select AMD_IOMMU_V2 if X86_64
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
>  	select DRM_AMDGPU_USERPTR
