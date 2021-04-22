Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F5368763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhDVToc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:44:32 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:53728
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236896AbhDVToa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbCUxAu3FZhk4JimsxLT/3MS+pjvkWqbGHHOCHpr5gpmmhlfk65pjpN392OxnBaRwECgJFOyIBab1+jdZzOlJHknLQW7H+smVAm+juCgUxZ42JNWXBZ1aNkVSxng1481kkraZecxSi2LQiGAwOF4MTy9PUVEoMPUd7oR0JHQ31ZlyJrdldDXnyL4KmtW603WKaAumuBO4L/OVwKjXnIsjZva/7v5S7QnPdyN9Ki+Sv1PyMnBCPej7hmRE51RLPM0Pyu4+qga+6zpWiOOzYf5MJYfr8wK8BCYTGO0CKfPB7DftF+Jz+S90HWl5BuCcpwkewCZ1VK8dpddT+ToulfQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yq+cv11qqPc4M0UOEL5/ziQQd52hOpSGeLEor1k058=;
 b=UiWyPixErF/qYkqEpMgi0v8Q2NmwBzthC5yI5JxYknxgdh7Wpqn20jz7buWPmm7/suxOf6NJt6Cxm03rCWZ9hC6N9v9EJhfv9Zt60+3c6fdJnpxT0TJ0tkrOVVxTjnOsCrqxNO4a/OHOQiUctoYCa+QvK9uTReR2c7UkrrmVCzb4R+Ne+1PWjUxA56U6E/naCM7Pc7DhAfHHyRcuCQ5hXf5MAVmf0J8ODM9F5qGCpJqzv2qAAXrpVH3FBQSxHVDaJXHtpmpfoQlMbcok2j8o/EvoZ+cfE8l4Z3TVOwm3psDwPRSC+7ducUOsZ1gvTq3qd3JJYcUYGS7GfmDJI2em+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yq+cv11qqPc4M0UOEL5/ziQQd52hOpSGeLEor1k058=;
 b=uUKNBZDECrCPt/BUpMyHbvMrWNnWIBzAhSbM2EGL3Nm78L+9PoVN6tqmm2axlXcjlMFg4xT9upNRWFP/jygSUrBCnpiSRCrC58xz2oQOcvk835pB9MgDsVFkykGyDGuYbZ3MZEiLNt4osRebXuhn6WEdIQ3Op1wU8Mj5e41CQEM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 22 Apr
 2021 19:43:53 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 19:43:53 +0000
Subject: Re: [PATCH][next] drm/amdkfd: remove redundant initialization to
 variable r
To:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210422124452.247714-1-colin.king@canonical.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cd3329b0-dc8b-c9e5-a4aa-b161dbf4a7cd@amd.com>
Date:   Thu, 22 Apr 2021 15:43:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422124452.247714-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.22 via Frontend Transport; Thu, 22 Apr 2021 19:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe748671-c8c1-4322-f41b-08d905c6f542
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24845FA1D8D43A5A95A6378592469@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCaNFfSkb1vG9+jKxKPqRIUjsb55obqO16p0Ay7EG/B0Y2c0NcCyOB7hs4wc4o5qBdLpDdExTBtEqfDj0RBXNWNUeUa+781qJi00z9juura2PXMwzPBq4gmKmtvv/miFeXQuOKG0TzJnxJYZsxtmG9lYmpeiodClMXOyt3DJLGz4vPauN4qAwx1wn7xWMoOA37S1L9/tl0vCA23F0qmav90BwDOe7lPp4GB7yKxVXQplQbl/tcihrUa34esvsTOcLKjPXtTBev+wynQCnLmgsmg3FxBwEn7ZdtFvIWl0WqN3g17v73Irip3DNHtMwTFNwTjnv98VR7/7bjrpJfv3SBtjlivcnlw0o24hwsx8LHlbk3Hwntm3owhlskpBPlSBoCXp+GCxkxLcmndj58Dh0Qo1Yy8V1eaavxh4wJpi2SGsR+b9RoQTYssxlgbsczrT4mExolDoe/1oTlCMrvwlrp/Vk2dstORlXTtJUVetI/A5nOOTp76QG3l2UB7gq/TYYbOYlleEw53DQBH+hd9qe+RrJAGOVrzGWean+TB93gvNiB/7GGygUHNweMbWP0Hn8kfbV5S+Qb5jR9GTG96dEYZyuA3MYrXZby5oezIMb9xm4sUKo7XRAtBdb4FDGYKOKa4b/2yBD/kVSJD/73xad6LSXYTNTHmCeUYPpcOuyIRtR6ojMEps91ClM91RTRKV44576M69yJOlIAyoA4hpbIhyFzs6CFqeH4ATVqFEOm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(66946007)(31696002)(6486002)(110136005)(31686004)(66556008)(8936002)(4326008)(956004)(36756003)(66476007)(186003)(2906002)(478600001)(38100700002)(5660300002)(8676002)(86362001)(2616005)(83380400001)(16576012)(16526019)(316002)(44832011)(26005)(129723003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZU9zdFdtNWgvZlZsb0x0Z1VzNFZIQm82d2l2cHpPMnpURFdFSmZtdTBhS1Ey?=
 =?utf-8?B?aDRuanovRE55a0xEWENnNkFEYVJxRitZb3ora3gwcGxQTXVWSjJibXlPMW52?=
 =?utf-8?B?QUF5SW80cTdhdnBnWStpMStpYktFaktQQzYzTmgwdUNoSkhoWHFONkpyZWMw?=
 =?utf-8?B?UUVxWDcyb3lZS3pFcEQxR2lTZUJNTzFzSUNvWUR4SVdNMmZ6S3NWRGlUTXVo?=
 =?utf-8?B?NURoMG5KTmdzbld3V1VCTDZ0b3hFcWFXZDdrSVNVZk1xWFZKQ0l5Y09hbFUr?=
 =?utf-8?B?M05OUWhzUkVJNzE0RnhuUjEvaUNndmVUd1hNTHNPbENjZ1liUW5YUjFtUUc5?=
 =?utf-8?B?TEx5RDNXZzVKRVk4by9qZlo1THBMYklWYW9hT0lYeERwYkxucUVqaGdobmta?=
 =?utf-8?B?UnJTUTIvLzFKRUpHc2k5UUhtMkFqN2UrNWZ0YmdncWFacVpYSUZjR3pFeHRI?=
 =?utf-8?B?UTJSdGJ6bWRjSk0xWVdxSHppczZsYTRsY1BiZHlsNlVBZ1hVaHk4Vit4WFph?=
 =?utf-8?B?bUlNK1QzekhENHI5OWlUcmxoNzhQbDE2c3A4eThuRXNNSm9icWtvVXczU1E3?=
 =?utf-8?B?cDBHQzU4M1QvcDJTWWszcStoZjlKMVRUaDhmTmdGZWhKelZ1d1hTQ21XaEdl?=
 =?utf-8?B?VHlLZTRGR0RPb3AyK0ltem00R1NqcThWSVQ4NHBPTmRPWDVob3RLc3hNNXNP?=
 =?utf-8?B?a29BaDlQakJqL0E2V1o0UDdCVWxkd1ZsRE04R3UvNzFWR1MvbTFCRDhmQlN2?=
 =?utf-8?B?VWxtWGZjaEVxY0l5UTlDQ2JldUxJdU90dCtWcy9OeS9KVEhvcWdYU1JPN3lh?=
 =?utf-8?B?Z25QbnNZT0JabTF4NVBHVVFmWmNwSkVWdjUxQ05jT3pXZlo4ZDVGTkFhQWk2?=
 =?utf-8?B?SzdhWmdWNlhkVUZ6b2liMkNMZks2TC9FZ0pFdEk4aytnUzk5bWpLK21aZXRu?=
 =?utf-8?B?aHNkb3lIbHZTdWlyRVRCVlJ4MjlHRFhwMXVrWkF3aVJHZHUrK0Z4bEpWYWI5?=
 =?utf-8?B?bjVjNWdwRGxSR21HclpVSmdkd0RaSFFUdFVXcEZBSXhrWUJVa3lMSG1kcGhz?=
 =?utf-8?B?RVJ1ZUFXWlh3TDVnR2U1UkxVRTltVWVnNEFjUmRZMFhGWVNJY0pWSHdJeE13?=
 =?utf-8?B?Q0lURmo3bmJrK0hFdlh4cGlBNEgzZ2V6dWNmZlpneGxIUGI0ZFJ0OTRCdVFB?=
 =?utf-8?B?UVoyMmRvc0w3K0Q0MHgrNFUxOXlMODVoQjcxckFweW12VFF1cWRkankzL2JN?=
 =?utf-8?B?UVp1UXo2Y0p1U2Y2NWRYbWtHZ1FjVktBakVka2FsamFSdWR0OGJqTXNuMWRN?=
 =?utf-8?B?ZGJlWFNxWFI4OG9KejhtRExBZTNCTWdNOG9iZG8zV0RxM1pzLytoc2daLy9B?=
 =?utf-8?B?V2k5L0dWRFNnSDBPMFNVMytWbzBiK1ZGazJhVkl5bTNhUFFSdGNRUVYzM05K?=
 =?utf-8?B?UDNoQjk0anVqSHVpWVJSZ2hXOFFtWjVmOVo2SjZ3ZllUMjNBRUVZQ3ZMOEV1?=
 =?utf-8?B?RXFQUitCT2NqRW0wM3hKSEkrUmZQaDNySVZFUXVLNE1aUTJSV2xjT2FnQkZ1?=
 =?utf-8?B?d21iSkFlUWdId0tHYkRVS1c2c1A0WlVEWk5aUjNxV3R4bVBLUERRNW4vNit5?=
 =?utf-8?B?KytWU1pDa3hNQmFHZEVyUkhvMExVR0RPQnRRRktlTWZYNVFpVGQzeFVnU0dH?=
 =?utf-8?B?TGZmcHZ3S1MxQ1IwdktGU29RZGl1Z3Exckg1eUw1bURHbTV6bEV5YlUxREEr?=
 =?utf-8?Q?IG51ikF4PvoZyLHjiGux3CqblT/AxrQ8cz5ekTm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe748671-c8c1-4322-f41b-08d905c6f542
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 19:43:52.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vN1811C7VBajz2U6wjFApjWQYnpd2oGvMULyzTdDeCJTnpInNnhOUotcp2VlUHvljJtBYMSqI7O4kxfKcBOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-22 um 8:44 a.m. schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable r is being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to amd-staging-drm-next.

Thanks,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d44a46eb00d6..a66b67083d83 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -303,7 +303,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	uint64_t vram_addr;
>  	uint64_t offset;
>  	uint64_t i, j;
> -	int r = -ENOMEM;
> +	int r;
>  
>  	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>  		 prange->last);
