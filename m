Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A1334B43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCJWN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:13:27 -0500
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:61537
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231935AbhCJWNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:13:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg0z0+KwQW0tRZOdOPFJ4fzfyVLxyaHX0meH3DJ6DKirpqHA3Td3yKljwiI51HerZwn56fQ28ub/0zXPnLtVnqjCi/4LAAeQ3//Ptl2F8oNNSJBCk+1kNGs69UBcaxNRYJNIQNAeXBrSkkHx/teO76wv+6600qAbF5MTHTIIE8uTgXNZ9MLZlbCAqotdcoZE6xKHB6Sw5FV/yi1IJ1N3+avWc3u8aEnz47nLi5uo54nRM/dR54ibAOByzedJnNYonwlF4oJBUIhKNIcg5UGce2JqxQGz5v+Y38lA1y3ByZBh7xp92QjZfdvO7VPTswyXL4p2jPWm2QIFM8J2U9/Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwicNcXD2jg9hvu88GTUQA4CdZmdYWgyd7Jc6RuucMo=;
 b=BIq0RyqskJIX2xaBFbhpmiG8zvRl7u1QacyMpkHRjjJy9JKQ9yZniDjK4wTyHCrNDBssIEbrkTQ60W/iEyMnl+OVbWHdOHXAvhO+jkm8nOo8vPj+VbgBlTPzSd9HykNBM/FbFb18h/WL5aI9VPZXmASpOaKBNi0hSMDi2YUFH2q9GOafr/cs4omqUjkNAWFBzooGrQRILHvoBk0V8M1SSnhr+O0HS9Ik/z9WF7PE9FIDeIpGSPPCERJLosRULDwTUAQQMevWRMwXHHalPILl2hRrGQKhdds0ltDSK84TB+PxalR8iDmz2oyPB3X5svjuTsR8Ivyiv3IX6dRL/f/FWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwicNcXD2jg9hvu88GTUQA4CdZmdYWgyd7Jc6RuucMo=;
 b=kjeo5hQLtigBBvJuJEAFd/eE4OFNEydrXuhxx4M6HDBNNf44muulcnWM+XTKdW1rc6YEF2wQW6XHd78K8knrrKWFZ/p9uYM6/TTXVN7JpCd+u3QZhJ9wes5sVHt28A16rWMqNQIE97nLwAjywPwpEFWIq7d5gDpXQgNQkp05jUU=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 22:13:03 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Wed, 10 Mar 2021
 22:13:03 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To:     arnd@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309165018.26213-1-Felix.Kuehling@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <67f7c50a-cc5d-073c-b91b-8c9641e2aa8f@amd.com>
Date:   Wed, 10 Mar 2021 17:13:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210309165018.26213-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 22:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dec9903-fada-4d73-f057-08d8e411ac2d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4898E097A00964E02D54F24992919@BL0PR12MB4898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PAM/7SSIpcbBLlcAA46ba4UGN4EOFjoECCnEPZGgw5zna09OXv2GlbGlmp510a77vMqtNPpnRm9SDO1hibDktKus0gavWyuUfsS+nP9rSqiUcet3es9katy3uSVA3LpO/7EaALxJ8HVFvVolWeVJZ/tERkrMxyM80M0N5YVPB0n7P8NnLcya7V/zzkw3TUNOUMlXsp4+cHeGt9Z4/x9qkCcXZL8KjF4iLQ3jMhn6jaiMbFf8zPVa6bJVLrNx2E1xOASHoKqXUamaT4dFomwtHzlnaCbV1f8uXIKkiKjLw0A5rYWSBuuz3WBZtR4sd9ansEKtbXsGQDIbII8Zt5HPcPyq/BfoRKQtTpTiZVr5H7w7RRbfZypn2wtnQWxc72qJJKqDU5JPQ1x1a/YR9di+9xsVghG7f4f0YTGnSwR/Q0uWueLZzZ3XABTKFcUJNeS0h8HphAnBAWCfA1GyNgWsl2WnKzONj59OVygRbLUM9ERAg5RqnCAtOPvvqmHFuCE0vKkhOEIT0vASGIXpdE6HdWUnzW3cUiT+ZUhCROkGhwmKMj3laVDAAqll7wP+ZOnqRRlRc5V/P5tJFoG4hcqK1D3ITFT1qdchguIAm79kfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(26005)(186003)(16526019)(956004)(86362001)(6486002)(44832011)(83380400001)(2906002)(66556008)(6636002)(66476007)(31696002)(31686004)(53546011)(36756003)(66946007)(5660300002)(36916002)(2616005)(4326008)(8936002)(478600001)(8676002)(316002)(52116002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkVzUGVmZ3dubm1NYS9mY0pBVHczYXhTV0tBSjVVa2RrM1pCelFjMWFwQUxt?=
 =?utf-8?B?aytqbzJETHNuUE5ITlhyZ2tmdjhOR2RPTG4zUXpGcFBnbG9OSWJEcHhSeWpk?=
 =?utf-8?B?SmZoWFNaLzVsWjk1SkpDSWtlQmZDc2I4ZWVNWklsWDBxdjdsMEVjd0puelNE?=
 =?utf-8?B?Zkw5MVd3ZEllbW5TclYrYW5OVzJpZSs0WUpFU091S3lHVEU3WjU4QmNpR1dS?=
 =?utf-8?B?Wll5aWZrL0xIQmlOQlh6cVFQOHIyb041OE5PR0FJQ2NzWDBKVnA0eEViWjBD?=
 =?utf-8?B?MDlob2tOeDlsTktxZzBUV3RwbjFxTVAzZ3hid0dHNWlXZFFJMU5QdGp2cnFK?=
 =?utf-8?B?WVc1RUJqVXN5V1BWeE5raHB1NWVWdkdPM0h2OG5UZm5zczFYYnIyZkx5UXFU?=
 =?utf-8?B?Q3FhSGc3QXR5dVRnYnBHanVuSi94eDFOZ2pGRWZTK0FWMFhCaE82QUI0MXVm?=
 =?utf-8?B?S1poenJDY3doQnlsZTQwZit5bGZTcmtmbE4wUU93ZzJHakFKNmpmMW9tMkpi?=
 =?utf-8?B?Zm9sWFB4RHFuL0RvVTZ1NXZOVGVlcnZxbXhHemwvMkFIblRhR1kxM1pCd09H?=
 =?utf-8?B?aVJiNFM4a3I3S1lFRE1aQ2VjeWVaQWxtSzBIRWRES1dpNE1PMzFyL0tzUEVL?=
 =?utf-8?B?RWlWTnN1N0dhK3J0NTdzUnNMSExqc0o2eXBvNXUrZlhmT21FL0M3NkU1ems4?=
 =?utf-8?B?NTZlNVh3bE1SZW0yaDZXTGNqZlQvRldEek1LR2h1YXZmald0bW9xZmU3MTVv?=
 =?utf-8?B?enBGODdHVTNYMTdES1k5TW5HZ2xwNmM4NkRDQUIwS3Nid2Z4LzB1OXJUZnJV?=
 =?utf-8?B?M2V4MklLZUF5eUJlb1d2RDI0cjVua2JlOGFyUlIrWUYxWVRBRWdESzJLbHdE?=
 =?utf-8?B?ZmxETkd5cXI2ZHJ5ZS92aXpSaU9CUXB0bDJWSzZvWlNpbjNMbHZ6SHJYTVpV?=
 =?utf-8?B?T3JPdDVwY1dKdCthQVdSNHNEckYzVldnbmoxOHB5UzNpbVVQTU4vTzlqUGJx?=
 =?utf-8?B?eEM2VnJtUmx0Z1I2TW1BemZXS2FKNW9jaEtLcDhUcktPMlpLN1BoMlFVaFJR?=
 =?utf-8?B?SGZEWng2cWtMeXFnZzZPNFdUOUpQOVlWYklpR2d3aklZYTMraE1NSDk5MmFE?=
 =?utf-8?B?c0NxQ1B0K3Jkb2dWZWFuMXBEcmZtOW9McmdyOEk2UzFkTjZ4bVBpU290UzdD?=
 =?utf-8?B?OE43ekZCamQ3eHVIdS94eTVuVnJFOXBzZmhtMDBHemNvVzBCejZnVWhTQ0Ix?=
 =?utf-8?B?V28zOExBYjVVemcvUzhPUGtlclgwL2dSL0RCMU5FcTBFK3dTT0VvWlB4TFBv?=
 =?utf-8?B?anFETGJJYkJjbUwwUWFPaFNEMko3RWx4R0RmdkZFZ1BvTjQrcTFLVjJnL0pV?=
 =?utf-8?B?SGhHL2NuV3o5cmFCK2FFVmY3S3pSR3Nnbzc2RngyaWljVUV4QTBHNmV6Z3Z6?=
 =?utf-8?B?dHJoSFhnNEFzOG9OMVArb2xlMXMzbXlEaVpGMnVHanNWcHpRcEpsQjA0ZlNv?=
 =?utf-8?B?YmMzSEkweGZIYUNLWHRKVEVnODRFOS85eElGZEhncnUrbFVWdHdTU2F3VU9E?=
 =?utf-8?B?Q2I2SmZJaEVJdUlnYk4vL1NkdmlQWUtGTjdxV1Z2VXpSR2RlMEIxL2RBbWl4?=
 =?utf-8?B?MXFJZW10cG5EV1Aralo1MWpyckhvZE1lU0h3TXlKSkFLbVUydnBwNnR3VFJu?=
 =?utf-8?B?MWZZRE9KMjJFRmc2eXVybUlZMW52RUwvajN0UlRsUUlTY3g1NStZN1JidVIy?=
 =?utf-8?Q?G/YPP3Zsv3pFoLxpy4/YCl5B9ZK3bHy2a7p79Ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dec9903-fada-4d73-f057-08d8e411ac2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:13:02.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwKm36tU1Y6/B+9//dVUFTpFK0wtp5nIb0coORX1p+W8s2olfVwgKrChZLTnIBU2JtIM/NqtCAbnBB7nLZkg/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-09 11:50 a.m., Felix Kuehling wrote:
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
> Use IS_REACHABLE to only build IOMMU-V2 support if the amd_iommu symbols
> are reachable by the amdkfd driver. Output a warning if they are not,
> because that may not be what the user was expecting.
>
> Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Ping. Can I get an R-b for this patch.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.h | 9 +++++++--
>   2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 66bbca61e3ef..9318936aa805 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -20,6 +20,10 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include <linux/kconfig.h>
> +
> +#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
> +
>   #include <linux/printk.h>
>   #include <linux/device.h>
>   #include <linux/slab.h>
> @@ -355,3 +359,5 @@ int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
>   
>   	return 0;
>   }
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
> index dd23d9fdf6a8..afd420b01a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
> @@ -23,7 +23,9 @@
>   #ifndef __KFD_IOMMU_H__
>   #define __KFD_IOMMU_H__
>   
> -#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
> +#include <linux/kconfig.h>
> +
> +#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
>   
>   #define KFD_SUPPORT_IOMMU_V2
>   
> @@ -46,6 +48,9 @@ static inline int kfd_iommu_check_device(struct kfd_dev *kfd)
>   }
>   static inline int kfd_iommu_device_init(struct kfd_dev *kfd)
>   {
> +#if IS_MODULE(CONFIG_AMD_IOMMU_V2)
> +	WARN_ONCE(1, "iommu_v2 module is not usable by built-in KFD");
> +#endif
>   	return 0;
>   }
>   
> @@ -73,6 +78,6 @@ static inline int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
>   	return 0;
>   }
>   
> -#endif /* defined(CONFIG_AMD_IOMMU_V2) */
> +#endif /* IS_REACHABLE(CONFIG_AMD_IOMMU_V2) */
>   
>   #endif /* __KFD_IOMMU_H__ */
