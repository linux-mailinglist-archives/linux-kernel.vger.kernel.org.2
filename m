Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6808936A29D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhDXS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 14:29:52 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:22688
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232339AbhDXS3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 14:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGGdXMN/B2r6CHgw/nwjkR1UgTH0V4DX+QS+YE8qBSZzBXwte056ETFiHGXGSI22uhM3YO8PBP5KucLwU0YSWyp/KA7V76n3AGRLQXCtkKoTpH255PBx1tpceX8diP6d7sRMNqsbeElfBleyF+pEvAcikuja3ry3RTplQ1Yhqgs5r8HDSqGaYezkQkWnG4/LQ3bhdU29enRhSij6FbnsG+eZbTsQNMIMlXgyV1B9AE8OZJPlRG9BRZjN/+FZb2QCbUcXYKcKsS8/lcbKbphffxEx1+wqZ/ta776QFa5dzbn+UcX6a22OWyjO41z8bpJu5uz6d96iAcQbB94AVzg/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeVahdx8dzd4rfcjfUsC03w53cnIOt9FiI00xkG9wvo=;
 b=JWweL95wTa4xfz49mMsIEqrNZRk0BzMcji+slv1Ua+9OJz93+SAIA2Dnuv0lXkVfzPa8pwUyAq3MTO/DAt1wirfMsQdSAWsMU7sXeS4B595GYWNXW/wmDjZMIEI6tRmPAYDyRfDs+q50GKZYdWMQ4cmmfCbhC6vJoRSXZDZ856beLRQo68deS+0J1fc+FwnY9q0E9l3B5UYFpTiwJ979AS713A5TB+iASaeYc91Ygr7amlBb9C0PLrRsP7gM/42p446vXhmlho8IMXao25gurwP4xt2bcXyNnjVv+hQAUTGRuk2ndU7O5ux0mX1ciqHqHf6XmAVovgDIfww5IBLVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeVahdx8dzd4rfcjfUsC03w53cnIOt9FiI00xkG9wvo=;
 b=r0NPF2OW88fXSlz8vrUy8zpLfXsTjMHSWPidODVHN6yUi/vhDvCZH6goeF4fPWAXRJ65sehaOC/+ix1DFZHncct3PhrW5uSx4tfCBefkHIFoAeQCtfD3jaMIfR9llwCgNJjrjMg83LABMGsSUMZV/qoVZoTx2Yu8iN2xPMMnvHM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Sat, 24 Apr
 2021 18:29:10 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Sat, 24 Apr 2021
 18:29:10 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Added missing prototype
To:     Souptick Joarder <jrdr.linux@gmail.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1619257220-3905-1-git-send-email-jrdr.linux@gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e58be0d4-5a4a-e631-169b-ffb547d066da@amd.com>
Date:   Sat, 24 Apr 2021 14:29:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1619257220-3905-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YQBPR0101CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::28) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by YQBPR0101CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Sat, 24 Apr 2021 18:29:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c1bc4c-2af3-430f-3f4e-08d9074eda6a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4689FD56DB3759DDFC37142C92449@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NajFOwGSt0GP825jhYZQIymmID6+zXbaddSvs0wHtqxgNhcVDx3Kue1VRgNnexpxnMTUN15rgzjtPCpZGvEPrw/YoUEE/eDLEnc83BDgYrA6yKvlyNnd2pmRWN4MnFbAjKwleoV2t6sLvdHyeA9SyyYPY17bQiJe5AWXrKXhaJ2UovqEOTOEJI12MpdEXyi0Apa/A/oMxaaIznM9WlG3qpDqioMmBIoMiPF2EWkqLFc/mk8+OQp660tiIvQEYqyIz6sj9u3ONOLc5a3ZvkXStbG3aJ0CxV9n7D7cT6hT7xFsgsN0RE2AF/NRDYC9UwdtB3WSJHJiKEirWZhl50bqcm2rF6SkTdKbD+3cCvCQETzzkSQK6/3W+m4I6nAlLFooBcs1+/o4D1qmwRNWuUfUf6nmLlv6AHBIGZezp3b85OMroVrNIQM3f1LQjM+yemtQlBntEmgHM6EKqZJGxDrNU63qGmQNOxc9b3IfeNFQDhSlrGUTGeX5ty6CELwNhKZ/LlLWvyIkJLHZOnhQK1LodRMBHN+oPiEMdi3YaHLAqeP5GqLWgqecOy+3wMZFR2GJqKhzC2DQbu2ngZiLKtn5roTWlwWnaKxeAEJph8ppO5+qWzrPl/iWGESzvjtkLSYgITiIO12gxqUZqIINW7sO8TYKczyKO763+3mAsb4c0dgUNxCBojjHURJrpplUXhCl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(5660300002)(38100700002)(31696002)(478600001)(31686004)(83380400001)(16526019)(86362001)(4326008)(66946007)(16576012)(316002)(36756003)(66476007)(66556008)(44832011)(2906002)(186003)(956004)(8936002)(26005)(6486002)(8676002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEJWTlM0ZHduc0xPeko2cGVwMm5kNC9RTVhkb0lRQTZZa3RGcGxKSFZoR3p0?=
 =?utf-8?B?K082QnV5VUV2K3pSeWx2M3lGS1YvK0FKaVEvVC9pQTBrNEUwdEZUdERhT3VM?=
 =?utf-8?B?MFNwSU5qOEExcWgvUGJLOUhVSUFFRzdSNVhqRm9RMHZmem43Y0JROWhwenFx?=
 =?utf-8?B?bFBjQzhEVjFzTzdFTzlZbS8rY3RIcDFydXZKYXZ2SlVFWTZhSkRvK2xNa0Z5?=
 =?utf-8?B?QTNRelpHbHloVUswbTlnalQyaGJMS1dlMWM5ZnRqamxkY2l6UDhFZU1SelRQ?=
 =?utf-8?B?N1MrcUFzSnhacnQ4Q2R2ZWdXVEIzcjhHSm82TG9KTWZGV2gxajdFY0dPK3Fh?=
 =?utf-8?B?NkJVZ2Z4akFaaDZYK25veXJLWGpiQ00zajlQNVA2OTA3NUV6bDBTZXZ3U3lW?=
 =?utf-8?B?K1UzTzI1WVpnRWp5eHZ4cVZhMmh6enhoTFcwcFhuM3VFbnF0eU5Mb2dkQ2hC?=
 =?utf-8?B?empvTGF5aFREeTNxemlhVE1lMmNJTHMzT0pJUmh0dGpxbDNrbmdFY2RHSDQ5?=
 =?utf-8?B?ejZqa2ZJbGNwakEzMGw5SW9KQXkxZ2QycW5hQVR4elBFUXhFQVB3ODFFYW9i?=
 =?utf-8?B?QkxWazhVMWtlcDFLNWVuYmlvaTRONExjazdXTnVPNy9FRjE4ekZhaDFZTG9V?=
 =?utf-8?B?NFY0Njcxd3FmNnZ4ek5QaVpFUTFCaGdVVHRZajN6MjVFSmRGbThRNlF5bzU4?=
 =?utf-8?B?STlzQXd1MzBObUlCc044eXZ0NEF0aGcydDJ0OGVReklKdkZrZ2dsb0s3T280?=
 =?utf-8?B?dDhaSmF2YzY2elFTYVlnbkxTVlFsa1MxNStlbnl1RjJHZVFGaGc2ZkhSOHNI?=
 =?utf-8?B?VndtdWZFZUNMMzVkMUYxMTR4RTluanJqYWF3MlNUUU1TM2h2VytaZFRQcDlt?=
 =?utf-8?B?cmZqYU1BKzhiY3lpdlhESlk3Yit6ZmZ1Nk1rRnFOdkNGL2hQdGlTZ0dzWnhQ?=
 =?utf-8?B?QUo2YUhhQTd4ZDdnbnIrR2JMZWUvMnIxN3M5MFZpNkcyMWhXQTl2bkNDMTlL?=
 =?utf-8?B?MVFJZm5SKzJ5aFhDditURGcxRFdHZWVUTnJEQzhEYUVNeDJBbVBSeVBOU0Mx?=
 =?utf-8?B?UUh2T3RnRXh3SHRXYTBrOEE5M21GQ0VCMlphWlllaFBldGFJKzg3NmxuNzgx?=
 =?utf-8?B?SmdBNjZEdnA5cWxIdVlFdkJZUVZsMzY4dWNybHFINFhieXBEWlZkb3FRSHB2?=
 =?utf-8?B?aitORFBsSU9hY3pzRHVTM1RuK1I0RVhaOGg2VFVQZEkwNzFyZ0x4YzJvWXBK?=
 =?utf-8?B?VnV5d2VPMnFFS3VjbTZIcjJna0ZDV0lqa3EyMUQxSHJHNlZxYUVsL3pPZXgy?=
 =?utf-8?B?MnlEcjd1MktFVVFudGhTanY2Z0ErMnZ4TUVCTFZWVzBhMVBWWlVLNmJGWm01?=
 =?utf-8?B?VG5KelpkendhNFU2TzdXc1dkd1hqSXQ2SzhHMzZ5TjkrcTRwanZiRjBhZzA5?=
 =?utf-8?B?S1ZIMUhWVTl0QjBVVWJ5eFZqTGMveDZGN1NpeFZoYkxENk92TFlkUDVTQWpV?=
 =?utf-8?B?S3lYQ2ZqT2tBbTM5SWpZamllZ1N4WTk3WWs1S3MxTjNwaXNjRU1lSjN0VThQ?=
 =?utf-8?B?SkZRMWIxQ0IwaTFvRUpkTml0MEwrTSttUVRpYTFtNGRBb3dMS2NDdzcvbCtO?=
 =?utf-8?B?cUhPUjZQR2VBZG83QnV1WVJ2Z2ZMTnJRcWsxbHFFMWprZWpCU1dtLzdpRUcv?=
 =?utf-8?B?dit2VUR6TmdhTm4zTTRqSjVwek13NC9PYm1ScU5vMWRWbDNFbS9pcUZIOWEz?=
 =?utf-8?Q?Qq2/SLxiMrHjUm25oXQngubXN0MZobAEM/NO54A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c1bc4c-2af3-430f-3f4e-08d9074eda6a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 18:29:10.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAovljCTcRJYr3Hb6Dgc1YQTDDcE6PVEvUwdsCrFBbUial1DuwV9THixC5M97Bow//OlIcl9BcpoM+UnR/M3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-24 um 5:40 a.m. schrieb Souptick Joarder:
> Kernel test robot throws below warning ->
>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:125:5: warning:
>>> no previous prototype for 'kgd_arcturus_hqd_sdma_load'
>>> [-Wmissing-prototypes]
>      125 | int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void
> *mqd,
>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:195:5: warning:
>>> no previous prototype for 'kgd_arcturus_hqd_sdma_dump'
>>> [-Wmissing-prototypes]
>      195 | int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:227:6: warning:
>>> no previous prototype for 'kgd_arcturus_hqd_sdma_is_occupied'
>>> [-Wmissing-prototypes]
>      227 | bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd,
> void *mqd)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:246:5: warning:
>>> no previous prototype for 'kgd_arcturus_hqd_sdma_destroy'
>>> [-Wmissing-prototypes]
>      246 | int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void
> *mqd,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Added prototype for these functions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied to amd-staging-drm-next.

Thanks,
  Felix


> ---
> v2:
> 	Added header which has the function declarations.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 9ef9f3d..6409d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -25,6 +25,7 @@
>  #include <linux/firmware.h>
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> +#include "amdgpu_amdkfd_arcturus.h"
>  #include "sdma0/sdma0_4_2_2_offset.h"
>  #include "sdma0/sdma0_4_2_2_sh_mask.h"
>  #include "sdma1/sdma1_4_2_2_offset.h"
