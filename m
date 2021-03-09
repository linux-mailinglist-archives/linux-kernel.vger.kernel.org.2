Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572C331D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCIDVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:21:05 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:39648
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229980AbhCIDUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt8JHL5NrYtj8eDFSmQgnCbF/aM2Ep+WoPi+buaDvS7M7XoxxJiy1y1QyGYnTEDt1URyN5MgOxR0B8m5Gt5wJvcdcJoqZWgqTWTZe4bmKo9XnfQLV+0ONPS6oo9am8meXYCWoTn43qCCPSQKUivcRxLLr00Wm4ffA+crnlb3thl6xSzifoNIKPAA8H+cWORoXdvCTl3J3rf04VYxeTGCsIJkm2gQu697JEaeuPVgJu1fNdEaQcbF/anLktrNXxiKWTWHF+zzshiF5g5PxsD24+tRBucinfFnAC+K1nkvW1gwVTVqw8a3BJa+hAKqgF/cS9ytRVx7yT1N8cRn4BeWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK/Lqpd/FQpFnueqYnPRrnbvqskOj+Tb2HPn1njEFxM=;
 b=K5JHMUzWzDp2aj4vhm4GJE1BfyG4Xcdew9YZNQoCOJWW8uGF3eT5HQ4Yn0jZYJE0esrSspAAnA0fgYl86+BHOKAaxgMRYGndagdN/namg6VEXvMawJlbL6uPZqceTxG87W6JYB51qVuiGKRpBqagtrVsKNwZJS19ClAQOAr9EUbnPF0OiERSixWSZ6+rr8eCVBJ4p2ZKU2z6Hj+rMoL8OrUtvQuSAURKcX2O56ARuu7VUbXM+PTLthiJBxSU88zC0LfL2eGR8rWlHt1VzkY0TR+zGKRuflJXxl6S6gFwoIxpCcAMIwzFv9RJJ1cYYHsbNtvsr5R4lFjASvnqESyLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK/Lqpd/FQpFnueqYnPRrnbvqskOj+Tb2HPn1njEFxM=;
 b=4eAUfWQ5i6YVCaBA3F6ag4lbnhygQV2Oc6siGE1Kk1pOLHnfcW4Sm43OJwgMHYXnUfQwhiEZRIBukO5741v9397QabnpoZNBJy6GWq7yeLIR+3YpUh2+VdbRZFdU7s+1dJaRRZ2fqVFNdzeadSdayP/RdY4DlvkQGQpQWTCXKiI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 9 Mar
 2021 03:20:43 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Tue, 9 Mar 2021
 03:20:43 +0000
Subject: Re: [PATCH] [variant b] drm/amdkfd: fix build error with missing
 AMD_IOMMU_V2
To:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philip Yang <philip.yang@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210308204606.2634726-1-arnd@kernel.org>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
Date:   Mon, 8 Mar 2021 22:20:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308204606.2634726-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 03:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf3e2b84-1d2d-4d98-9873-08d8e2aa52a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39355BFDFBBCEF6E1FF07F8792929@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxJvblMCZqnxl9u8myPx3E77XvEbTrVoiaietNUESJYJWyqRQyDpIaKUd6opih5idOV7o8FC3O2qPb5xi6MZDelDlOc3Rf+5LvOyQ38RhLE1rAYFxsLPuK6PN6uPPZNyrcW14WmYrxfy2r+Chjo4YbcOAK+6/fHuhH9bxS/HcIeA84OdAqB2eel5C4ouZDuQ9FHhr6O5IVlFY3RlUDZiEaR6gtNUvlpM2wuQYS6/ige7g6tK1JK9Zvq0nXMJbeBiaqrj1ILQE05kPxeQSPHoiOpSgG153MD8D2gnTFq/RVVQ/pj4bduPrSpjNFQndaENUqIILR5Zn99V7QvC4zJxwo4XfleGwj9onjkhN931eP2Bsmj0OXIJ5biW8ipqVSfuQbViyYne4E9ujrV/b7qUZ5CC7skUN8h7UzkpqDnOvbjpRw7xP+oRiq78eexgubNNUK19sFPvi+OAFO3/VUpE6SzX0ACw0abcSqLKF9Ee6h1d9C1p274kAr0AqqPHjQefyeqz02dZKooMaQerM7uk1G2EhDxrVKuDOPGt/iXFm0syBI2vKrSTLbG6PVRYVXXX+NOgT4szPgaNOILRRevF/ARZmZcgcUvFB5odVUPbuMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(66556008)(66476007)(66946007)(6636002)(86362001)(54906003)(478600001)(6486002)(186003)(31696002)(26005)(316002)(110136005)(5660300002)(52116002)(16576012)(4326008)(36756003)(31686004)(8676002)(956004)(2616005)(8936002)(16526019)(44832011)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWo0KzFnUGlpVm5MSFFORzdGQUZkSk1QbzV5SVNzSldsOWlyS1IxRnIzVEZR?=
 =?utf-8?B?MzhLeCtBaTc2WGlQK2QxYmpnWG1JWm42dTJtbmNLTVZNZjNEVUtZZU1IYmpW?=
 =?utf-8?B?TWNJRFVoaldHU0hBYmsxVjZvZGwzOFlvNWZ6L0ducWs3V04ra1dUOUkrK1I0?=
 =?utf-8?B?TVB2b0FJOExnYUpuVThQeCtYaE0ydFJFV253VkdOc0ZNbEM5TVMya2RWSnhX?=
 =?utf-8?B?RUNta0dRcHZyK2JYRlBSdmtjRWw2eHA2blRkOHJYM0cySDZUOXUxcFova2Ri?=
 =?utf-8?B?R2VUU3cxSnpnSWhpM3o2QWhIakkvU3lybXo4Z0RGc1pFVVAwSU1rd1F6elZs?=
 =?utf-8?B?OGxoVkU3eFh0Z3FGRnpXY1FRK2d5ZG8rM0NHM3hLSHpaTW9pNzZiUFpUYUds?=
 =?utf-8?B?WDVLWm1hTDBMT3ozd0JPS1Jyd0ZSNTd3QUFLRm5HQnpQdUFpQ0lrTGMzcHcv?=
 =?utf-8?B?V0srd2kxd3lmWXZWOHVyL0JnTzJwSVNDZys0RE0rU3k1aEd1UjNTdm5BY2Mr?=
 =?utf-8?B?Z21UaE92TjNQam5aeDdqQ3J3RlZ0SzRITjgra2lYcFVLSnhOSk9zUVd0aGZk?=
 =?utf-8?B?S0ZlLzRCWkFnSGcxdWxveUp4UGt2Z0NybWdSc3NuVldBcDZvOS9JaHB6N0Y3?=
 =?utf-8?B?am1JWnJsd21ubEJBVTJIaGhMdjB1a2FvMjV5VWNRNDF2bW5Ucm5LWVRXMkdp?=
 =?utf-8?B?WFF0OEExODh4bkViclRieGlSY0ZsY2FaR2VrbjBmdUFRd1dMZG1YYXc1RUxp?=
 =?utf-8?B?b2l2NWJRQ1ZXRWlHb2tPL0VuN2ZpaUo1OTlZdEhZQUoxZ2xSOW1wdndTSSsr?=
 =?utf-8?B?d3M2c3lrV3I5Q1k4OGtwbGxPSXRyTytFOTVwd3VVVUdwckhaOTEzVFdaZFBy?=
 =?utf-8?B?NDZYUUJvcWVkclFsL2ErbFNPRkYvY3UyY1F1WC9pbm9ZbXBpUDZhSndzdnZX?=
 =?utf-8?B?WnZFb2FpUUZIUkhReStjV055LzNpZ0htS0FoR1RWc3g2eldYR3VpRVpJS0sx?=
 =?utf-8?B?MXF1YTJZV3dkcGFocHErSzV3WDM5RmNsaytWR3JUamxoaks2UlVhQ2JSVVJM?=
 =?utf-8?B?aWpORmF3VGNjMFlMUnIxYVU0M2lpQXpxbFRUdTF5OWNTMVJvTmxpejRxWkdX?=
 =?utf-8?B?M0RDZ2RvaWZjaktrMkUydGxUaENXanYvUWJmM3NCQWFKQ2lHTVk5OGdoRWNM?=
 =?utf-8?B?SjI0M2NXNnlHWkhlWWUzMDlmUVNsM05YY1hmSytmT2tvSHNpTGczMjRYSkpL?=
 =?utf-8?B?c1I4UnEvU09aa0tqK2xIZjVjbGJwcGMzN0Qvb2RFNFp4NGFza0N0ZlFXQ1Fq?=
 =?utf-8?B?RFlHRjl6RUIycmJZMnRtTHBRb0hwNllXWG1KcXJTWm5UemwyVWU1NVVSc1pv?=
 =?utf-8?B?TmFnYXBxeTRaVEhjNTZPUi9aZ20wdXNBU01IZmxCV1RLbXJiYncxcWZ1WlNI?=
 =?utf-8?B?b292Q0U4VE5IUVlMTGJSSEZoZitNUFI5VnJwbTNNTEdsR3JwVGowbkpGZmxJ?=
 =?utf-8?B?MTljR0dCazZ6Mll2bTVSLzQrOHcyRmRQRUl1QXJmaTFGbWpFdzRiMkU0c0RT?=
 =?utf-8?B?eW0rU3R4dVVQK2c4V1dXdGIrQVJvQmRYZlFveittL2JmTU95ZitFeitoZVMw?=
 =?utf-8?B?SWxKTXZxeTVNVHMwMFdyVTY3dlBXMHJFN09KZ1BCY0ZZUHY2aENXejA0NDk0?=
 =?utf-8?B?VkhXWWJtVzU0Ti96K1ExTWt0dXlQdS9QeWV3M05LTThmZXFJdmRnVkJuSHU2?=
 =?utf-8?B?SHRFL0paK25wSlZVNWNIYlJNd05rdWNoUW1aMWt6Qzh0dDFuczZRam4ybVNh?=
 =?utf-8?B?aEJJRDdqTmkvZkVEd0lxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e2b84-1d2d-4d98-9873-08d8e2aa52a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 03:20:43.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIE9utE2rrLB4g+dEVo2L0/nAT/p23KVLZOHjLXPn+Prg3KMKRcs9ic0FdKYlZTxEOoo+YQlfOcEVGYoXha3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-08 um 3:45 p.m. schrieb Arnd Bergmann:
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
> Change the 'imply' to a weak dependency that still allows compiling
> in all other configurations but disallows the configuration that
> causes a link failure.

I don't like this solution. It hides the HSA_AMD option in menuconfig
and it's not intuitively obvious to someone configuring a kernel why
it's not available. They may not even notice that it's missing and then
wonder later, why KFD functionality is missing in their kernel.

What I'm trying to achieve is, that KFD can be compiled without
AMD-IOMMU-V2 support in this case. I just tested my version using
IS_REACHABLE. I'll reply with that patch in a moment.

Regards,
  Felix


>
> Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index f02c938f75da..d01dba2af3bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -6,7 +6,7 @@
>  config HSA_AMD
>  	bool "HSA kernel driver for AMD GPU devices"
>  	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
> -	imply AMD_IOMMU_V2 if X86_64
> +	depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
>  	select DRM_AMDGPU_USERPTR
