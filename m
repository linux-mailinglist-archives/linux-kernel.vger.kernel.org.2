Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0299325015
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBYNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:00:18 -0500
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:30529
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229491AbhBYNAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV3gaEW9aZAes8TgoDbiuiD2IHWkyIzwAaAvQ3aLw/idQWwu+c7XEvUqkM5WhaWSEQnz3rW6NgWFBrp+lYGMPLWu+AEoJSo7Ofi0JGM7ZqKTBUn9azkqYl7YGUQ6lp7Ol5GOo6M7zXEO2nfP2ZCvAUFxLmHBicZhD9LMLOLWT8QjBvvIvVThcGz+1HtxUWSn1/NbJBc7CECwXJPaFHKZtHxpWgGRATO4LpYTcQuTVEDQNYOaKNxKQcNtxJF9RSC8HR6PglfYgkyg0U64zjrnYT6jV5zbmqy7Q8tv4YYtVcC1y3lMG7lQvloP7MUgpiDOYP3gwHcOXcXkJLsvcdgRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csLA0EYmNI7s+YrBG25wMxLYxseNS33cY62HiLhdGVw=;
 b=CVWBi7jI6tQjq+oHZsukV8tDSfaI+uRx4Jma69qMEFco55CdUGvJruXdZFqCfMzU4WdXspdeiugQ1wfH2pn2VvZvxFApUXdTt3YkbXDidNdrp/faTa5yZLIv9oGtzY5dqBJrFYr+NTEPFwL7MRU5o6GzN6c6ocJeNKff9YcGvFNbTMyn1T7p6RqOBgU5WwcMGEssOpnk+irEZ6M16gvqj9NKXvWqAQ2wewTeYNEZ2z6w92SXJT8MfyjI/KDU2Ztfwgj2Of9bELnBlPYXufXRoBiewPxL+iMx5y6ExsdGfz0Wh/RsJRMMgcWiX5LjQCpCdVeTHZCRtGbk7bR9q9Bk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csLA0EYmNI7s+YrBG25wMxLYxseNS33cY62HiLhdGVw=;
 b=nG/bj8YnMBfnMJiIQt9ltfBk0ApTXU+W9NxhY1ZP1oZ0ud1rVRbJt/RVzD7uyVY1zV168MkFjAqD3nUDLalrZv0mJScwg/CS3hTNWSQy6kGt2rO9iaRhJP0ndm7GffQNKjmp2IwTcdI3qWfZcimWXhJbZdNu8jQnyB43baNk5CE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 12:59:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 12:59:16 +0000
Subject: Re: [PATCH] drm/nouveau/pci: rework AGP dependency
To:     Arnd Bergmann <arnd@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210225125301.1723047-1-arnd@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c41b175-6da2-6801-43c2-c4038c08b228@amd.com>
Date:   Thu, 25 Feb 2021 13:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210225125301.1723047-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fc8:43:f4c0:95af]
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af] (2a02:908:1252:fb60:fc8:43:f4c0:95af) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 12:59:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc8410ad-d4fa-4f1a-3380-08d8d98d27e6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4756:
X-Microsoft-Antispam-PRVS: <BL0PR12MB475687714BEB832EE58729A6839E9@BL0PR12MB4756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJbgtcvqeSO4J0QQsQv700GOQO6DDCnoTvOsGtD9ikyJLnzwmfArwyginktpZ8tYR9BXSJ8ynHsl0KhtJS6cRCnBGY7pWzjks2KO2DtN1f0J12PYTohZIg1WfZDhs1lW176fHWzrVo4d2OpcPmD1c4dx9rcmIJOyB+8UGRMmCfHw27xvUVMK3ZqiOjV4JFC0RTlQ3m792Ltwlxl/CAXw6FglnEk423v8FZNh7vs8gwKjhKDBitUpYxuE8vAPf4422W00dVxyYny+Z+AdmMJFxWGcJcVYpz7jQ8EW9TWLEsf8VncKSC8TFCiKZkFECv4XsMU15wjWRTaJ/ugVw2m4W1UvpB49vGD9HuUfiAdCflbygniCpv1EaDMC07jP49N01PGdePOCat5TRA9BR3Y0nazDxntBgbJ8Q0REuJJjt2rRiL6RQJDqqwNEcOuCAdxP1qh2q9llj3InM6WyfJlO2KxmKIo1E80CDAPfXYhoi4bS644YYDZtypcW1AkUuzYTi2a/eAPB7ZCBGLttDfrHCWlv0PaEkIYO56lUdzW59p69Ddiujm/A/ZZgp5XYMQciTJSeqBewufUwc/cWo7BHaZ4vGWVhYB6r+YJp1V0NPGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(186003)(4326008)(2616005)(31686004)(52116002)(6486002)(83380400001)(66946007)(2906002)(478600001)(6666004)(5660300002)(66574015)(36756003)(86362001)(16526019)(54906003)(8676002)(7416002)(110136005)(66556008)(66476007)(316002)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T09aR3h3R1RFU1Z5cndLNGxCVkJYUVR1QWFHUVgyYlh3UDJQQ3RxYXc2bHhj?=
 =?utf-8?B?V0dwbURDZ3hDcHhJdUJ1TmxzTVkxMlVEU0NlWjkrbGs0T1RFK3paUkZEU2NJ?=
 =?utf-8?B?ZkV2Uyt6ZjNEM3JaT0ZpTVU4ZUtubms5bUV3SVhyUi9kSXMyRE1ZTjIwSm9Y?=
 =?utf-8?B?RitiaFFIWkFMRlcxTjFMRlB5ZUdvZFhkRGJDTzJDenJCZG56N0t5MFMyYmxw?=
 =?utf-8?B?amsyZXhycS9JWk9ZcURvMStvcnU0b1B0cEtwMXcrTWdCVjlMVnJWTHV3Ym5h?=
 =?utf-8?B?QWRWWXNWQXIyc0RCajJRYjFTb1Z5KytUVVB2UmRGbk5RaGJZenZEbXlzWjcv?=
 =?utf-8?B?dEhYbFRxYk8vQlYrUUt6d2JYRlJVK0pLWjByTU4yVkdUVHMxZlJsNGMwQ3My?=
 =?utf-8?B?Q1VtQVhZS1A0S2RHUExiWE5IVlNxcndNVHdONEduZURRSWttTmJsRXdUcDZq?=
 =?utf-8?B?QkRoWXhZZE9jT3dNeEZWcklkNjExbFdSZ2NYbkFSVDhjRW44bzhpcmJTRnBO?=
 =?utf-8?B?bzlpYnpzckFiMHNuUFZxMU05c3p3aE1WZnlOWEJHVGdUK2lQaXJUSzlvaXR1?=
 =?utf-8?B?dTErSTd1NTA0Mi9zVTRkVGRUTG1Rc2Y5eUJFMXp2YUh4YVJZczBXTWlJeDVv?=
 =?utf-8?B?UHhTMDRCOVBib1hsdmhkMzIxUFVyQnA1N3V6R2N3dC91UFFJZGxGV0J6Rk5K?=
 =?utf-8?B?OU0wcXNCc25xTzVqQm1HcWRSU1FralRkQ3gxMjA2dWh0M3p2RmswZVd6RlNx?=
 =?utf-8?B?dXNTdE92UmltWHlseE93THlrZlpGQjNONDYzK29DM2psallZdXBTaHJDalMr?=
 =?utf-8?B?S1VTTkoxU0lQQVhGSkczVFRpRE5SNVRxNFNPWGpxaWxWZG12RjlmYzQxVzRv?=
 =?utf-8?B?aFowazJCTlE0MTRSaUpuUlpzUmlyZEE1dVFYQ20yQzE3dzJYUU40Z1FTZUQ3?=
 =?utf-8?B?TWs1VVpMWTE0RVMzU0UrQzFpYTZaK1pDeHNVTzVZT2Q4TnpRNXNOSUR6dGoz?=
 =?utf-8?B?UWxORXl1b0NIR01GMG1MRFR2Q0VwV1M5K2pnS1hKV1hQUnBqaFh2ZmwrYXlX?=
 =?utf-8?B?T2tSMXozTGg2TlQrU1VIUDNwTTA0QmhJTmdiY2lyVTNrQ0lqY3Y1aFBiaW5q?=
 =?utf-8?B?SEVXY0tCUCtWR2dNT0FyYjFxUkU2Yi9SdmtrbDNuQVdDMzFJZi9TM1lZY3Ex?=
 =?utf-8?B?YUkvYzZRK21oaFh3WXQ3Y2ZGZDRGdjdpQm9HeWN0NFhGaVBYaVk2SlI4K0Jo?=
 =?utf-8?B?NXowclVlTFVGQ3c0UlBFcGkzOWV4ZWQrdW9NNE9QYnp0QnpVQWFaZzUyYlhn?=
 =?utf-8?B?bkV4cVNhWGZ4K2piU2FtZUZ5RkhCd2hpR01LbzZrOTFXbkVZWHFvR21YVGdx?=
 =?utf-8?B?c3pJSENJTm5TdHcwdlREQUloaWtZZ1hsa1c1M2VwZ01wZm14Z2EvUXNBR2NO?=
 =?utf-8?B?QmpMc25IY0hYU3B0ZlNRSk9hODVEdE9ERm9WbmpWQlgyVmd2L1FMYldjUzFi?=
 =?utf-8?B?N09NVDNkUTBYWFVLQTdhaWlHK0kxUHZKaDRVbDE4YWJ5RHl6alZ4RTAyR1Q5?=
 =?utf-8?B?ZUNhb1lVUGtTWC9tRUZPNHNFZ0xrR3hCYlFFVzZtNExsSGg3bHlrN1pXRnZQ?=
 =?utf-8?B?Y29aUUszQjVlMk93UDZOaTF4V1BuWGtCdHdIbHVYbFV0d0FNQyt5SUgwNmNY?=
 =?utf-8?B?RjQvK1RlTWVaL3NONG15ekNlSkI3blR0WU9MRFh2WGhhek9pRHdzNm01ZmJ0?=
 =?utf-8?B?OHJWa2hiV1NhVHRSQVZFWUh5NEVlajRjVEpScUw5a1kzV0pBbERESFJlYTlq?=
 =?utf-8?B?QWR0T21uT09CQ0FVa3pqNy9uY0dudjU2RndHM1ZVYjh5Rk1UVzNid0dKZmF2?=
 =?utf-8?Q?2DHyuwAB302Ra?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8410ad-d4fa-4f1a-3380-08d8d98d27e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 12:59:15.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGzcu0bgdQm3TBwXC3AaHsYSVzw/XOYAwA/ayCrfLXS310jET6jQocr4VxkGBWlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.02.21 um 13:52 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> I noticed a warning from 'nm' when CONFIG_TRIM_UNUSED_KSYMS is set
> and IS_REACHABLE(CONFIG_AGP) is false:
>
> drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.o: no symbols
>
> I later found this is completely harmless and we should find a way
> to suppress the warning, but at that point I had already done a
> cleanup patch to address this instance.
>
> It turns out this code could be improved anyway, as the current version
> behaves unexpectedly when AGP is a loadable module but nouveau is built-in
> itself, in which case it silently omits agp support.
>
> A better way to handle this is with a Kconfig dependency that requires
> AGP either to be disabled, or forces nouveau to be a module for AGP=m.
> With this change, the compile-time hack can be removed and lld no
> longer warns.
>
> Fixes: 340b0e7c500a ("drm/nouveau/pci: merge agp handling from nouveau drm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/nouveau/Kbuild                 | 1 +
>   drivers/gpu/drm/nouveau/Kconfig                | 1 +
>   drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c  | 2 --
>   drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h  | 9 +++++----
>   5 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
> index 60586fb8275e..173b8d9d85e3 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -15,6 +15,7 @@ nouveau-y := $(nvif-y)
>   #- code also used by various userspace tools/tests
>   include $(src)/nvkm/Kbuild
>   nouveau-y += $(nvkm-y)
> +nouveau-m += $(nvkm-m)
>   
>   # DRM - general
>   ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 278e048235a9..90276a557a70 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -2,6 +2,7 @@
>   config DRM_NOUVEAU
>   	tristate "Nouveau (NVIDIA) cards"
>   	depends on DRM && PCI && MMU
> +	depends on AGP || !AGP

My first thought was WTF? But then I realized that this totally makes sense.

We should probably have the same for radeon as well.

Apart from that the patch is Acked-by: Christian König 
<christian.koenig@amd.com>

>   	select IOMMU_API
>   	select FW_LOADER
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> index 174bdf995271..a400c680cf65 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: MIT
> -nvkm-y += nvkm/subdev/pci/agp.o
> +nvkm-$(CONFIG_AGP) += nvkm/subdev/pci/agp.o
>   nvkm-y += nvkm/subdev/pci/base.o
>   nvkm-y += nvkm/subdev/pci/pcie.o
>   nvkm-y += nvkm/subdev/pci/nv04.o
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> index 385a90f91ed6..86c9e1d658af 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> @@ -20,7 +20,6 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   #include "agp.h"
> -#ifdef __NVKM_PCI_AGP_H__
>   #include <core/option.h>
>   
>   struct nvkm_device_agp_quirk {
> @@ -172,4 +171,3 @@ nvkm_agp_ctor(struct nvkm_pci *pci)
>   
>   	pci->agp.mtrr = arch_phys_wc_add(pci->agp.base, pci->agp.size);
>   }
> -#endif
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> index ad4d3621d02b..041fe1fbf093 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> @@ -1,15 +1,14 @@
> -/* SPDX-License-Identifier: MIT */
> -#include "priv.h"
> -#if defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODULE))
>   #ifndef __NVKM_PCI_AGP_H__
>   #define __NVKM_PCI_AGP_H__
>   
> +/* SPDX-License-Identifier: MIT */
> +#include "priv.h"
> +#if IS_ENABLED(CONFIG_AGP)
>   void nvkm_agp_ctor(struct nvkm_pci *);
>   void nvkm_agp_dtor(struct nvkm_pci *);
>   void nvkm_agp_preinit(struct nvkm_pci *);
>   int nvkm_agp_init(struct nvkm_pci *);
>   void nvkm_agp_fini(struct nvkm_pci *);
> -#endif
>   #else
>   static inline void nvkm_agp_ctor(struct nvkm_pci *pci) {}
>   static inline void nvkm_agp_dtor(struct nvkm_pci *pci) {}
> @@ -17,3 +16,5 @@ static inline void nvkm_agp_preinit(struct nvkm_pci *pci) {}
>   static inline int nvkm_agp_init(struct nvkm_pci *pci) { return -ENOSYS; }
>   static inline void nvkm_agp_fini(struct nvkm_pci *pci) {}
>   #endif
> +
> +#endif

