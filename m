Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF932BB8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380896AbhCCMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:37:52 -0500
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:53857
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1582418AbhCCIC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:02:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czFsSHY/7NcQMiP7IH8+z0snkve9/Wa7n4YLmvuwQEPS+Yx+h27ea/gDRrsorBp8rsY2iZ6t9aSUeI9PBdZH8xZRI12Om2fGfwaiB332/+dIG/fgiV/p6wqN/RcUMIRvK+zGqdbj7JqCP9l9FjxtR/BGwTfwjoy01lZrRh9ZBqc335fa9oQ71qACVwIL1Gf2IFvV6lJuEnggQe0M9l+rOk/fCShQNfWR5nFjaQgQq3EN5KuAwdZQTU7gNO4ItPsr5pWTwA7XEUEduqHlw0ZcLqVrCjkyqaaBXvdkIxw2QnBPik9Hqykr1VLCPTuZtm+/kbc1TaMFCTE0E32g4xPl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c/eFbDqiB2hc2oe9NDk6NS58MoeDPeXIpx7EwxDuUE=;
 b=ete4AjNz94XPvstpMIClh+838QC2enqq+/pdD8In0uaNdLEFgmMiH/T+x0KvvFeD3C5CeOA6ZtVe/LVHOjnXx+G6xOsRpLxRqy+ALkqie5+7yche8AWOPzdf4zZs7/cmMbv6lC9mFa9vof3Ja5ZA3oxxKDDDD38SZnDZSLbgv24JQOvVyYCIn3sHNmhuRATO5zd1uyn58fdyRN4Hz8STNPE+fmvOuxuzgBRDMe1+zE1WqkMidunW94ujorobkd+6xfIRyWamoLD5f06iXwhfB5+rG9N8t3gk7qt7Sn5cPByu/OEbQ8gjTEytdOiQ22cDPpxaem9hU57kTB5bwLMPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c/eFbDqiB2hc2oe9NDk6NS58MoeDPeXIpx7EwxDuUE=;
 b=QO3gG+TjZOxXb5BJIJp2Jd8ChpOg6tT9WgCW03g850g2orWFtkSbRLiW+LWKJ724kQfPFGEDXM+OhU7WE91CuynZeoW2tMf1swtfn6nyirlGk5XfV0p47hDDMMA5AqE5ThLr6P7o/07xn1L7K2JCmQElL2t+5BaP5Mlm+OcNH+Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 07:42:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 07:42:38 +0000
Subject: Re: [PATCH] drm/radeon: fix copy of uninitialized variable back to
 userspace
To:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210303002759.28752-1-colin.king@canonical.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
Date:   Wed, 3 Mar 2021 08:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210303002759.28752-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c1c9:255f:21eb:6396]
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c1c9:255f:21eb:6396] (2a02:908:1252:fb60:c1c9:255f:21eb:6396) by AM0PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:208:136::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Wed, 3 Mar 2021 07:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fe420de-c9ea-4ae7-a9ee-08d8de17eb1d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43209200A9EAA3D2D374B8D083989@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boSItL5OfBcD4mf7NV3IgMfIeONtyx9pFtWZ3fBK5oiOXSDlIoNRPp6sgXPHWTfsNK0z3+Q/Z7LxLCDdlj/smyDo1e0Hr1pzEkGBE7vorMDrVgs2Ei1Q8U2GClOUj79VmO1dRdz+jHFt7t5G5nNGNAF9I0U2kkzEjLt2YAYPXL21lxbtvEz7yZGFVIa8+dAnSdKdjSCSXQ3P0+1zeTtpPAUK29xaukqtdpwa/YGv+ckn2sveat3UhbU78l0x6DIZGcmYj3RT0ySasw6pn1R84Nc6Gj1gD1mrwtN+HlaSEhKY6Kn4JMSQpDkYqhbd0uR+O+AtpSJtb8jYowRQ1gHGHGEemNk2AJfuxfD/YwtuejEUUrgdnsqJD7HJWqd0nVUOvvf0/QivfmwhEfl05qwd6M1XA6Bt5ezqHeCZzuowSjYtgKvKop8BbgjeQOJpK0vpu+4Bems6TEoDLKp+Wbw6Pw9bBrkldcZhXGvslHnY6XK5uu18ClOy5owSg9dRjnl+yKeSvFpU5VTzC/HR+Tc3tlk5aE09J0G0XthMHuYNZS0SaFFxD+N6gP4AkgjnGndZoiEzDg7KEE3g5aurwj7boFK/1QIlpIv8jgIsVUCtjJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(2616005)(66556008)(31686004)(66946007)(8936002)(66476007)(478600001)(16526019)(186003)(6666004)(8676002)(4326008)(86362001)(52116002)(2906002)(6486002)(31696002)(5660300002)(316002)(110136005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rmlkc0xrZ2U1OUdweWEzTGg0UytpTkFmVE9uRGRTWEpkQTF6N1lHYi9ZVm9U?=
 =?utf-8?B?NkJOSWJFZk9lZVhUNVVCYk1URUZTekxocG1ZYytkLzlFNEpGUlg5bjc3V3BO?=
 =?utf-8?B?S09nV25MR0tXd253bjc5TFh2dDQ3WnRTT2V1RVQvVkFJQnlVayttYkVrZkN0?=
 =?utf-8?B?NjJiRUFneTBuSVJuWDJtN2cyVVFyYURDZlY1RXByYW5wb2ZMOUFtZWNiYVhN?=
 =?utf-8?B?UkpsRXpwZldOcVFQMFhxZS9oczVVUmdUN2VPaGhnL1B5WHdpUXRYSjZQNmx2?=
 =?utf-8?B?b1lDMHJVeUUybThNUGp5SnlDamkveVBzSHFOK2hkR0VqTDg3MEZtMWJaU0Z3?=
 =?utf-8?B?ZG1mR2NLaXZJVmx4SnJSNEpBSGxZQzBHc1BQYWZsK201TWl6aWZRS29SdVNq?=
 =?utf-8?B?QU8zTTVxTzRiZS84N205UFRrQ1lpalJhdEU0RmhxaXVHM3NjOXByZEJGcDJN?=
 =?utf-8?B?aDhsdGsxM1BrNWR0VTlwS3podWRpY3hYWmRnMTBrZjhWakw2THFhZ0U1OXZY?=
 =?utf-8?B?bis1NDFhdVlob2k0ZW9lK2tqOWh1bjVBVEI2clhTeE9aSW5tOGY5ZmhHV2gv?=
 =?utf-8?B?aEljdjN6bVJQaGE1ZGVSU091MjhiYUtHS0o1SVc2RG9xV0haNmY5a3lML2FN?=
 =?utf-8?B?MTl4YUtRNnFJM1VLRGw4TEJOUis2ajF4TTJVcW9uREZ4cEVzQ2FCMjgvclVL?=
 =?utf-8?B?ZXlNUFNQNTIyc2dWWVh0UUVXQ2xnUEhEM0JFdU95SjZEK2p4cytraVZEMEdC?=
 =?utf-8?B?ZnZPRkEzYU5sSk9mWEJNZEdBaUd5WTNGQml4Z2NPalBlaEduakFkYTFka1Z3?=
 =?utf-8?B?VTNkQ21vblBmQXJQTXlTellwVWk2ZG9MOG9TYUFBNDJsN2poVzdYeVB2MUF6?=
 =?utf-8?B?Q1dXUVNnYi85Uy9RMFNDaGI2ZzdnUXNkSFlCUG1CcWxQL3JUSktGOXJNcm9X?=
 =?utf-8?B?OE9CcXdVZWJqVHlnYllrQ0sybndsTXFaNDVuRXgwMXcrQ0F4OXRUQndEVldI?=
 =?utf-8?B?YXJucndxOUJ3Tm1sYmdOemNzQ0R1bWgvK3UvZXl5U0VSdWtFUy9xQ1d6eTdE?=
 =?utf-8?B?ZEhqT0t6WERoclRheFRabjFtaitLdk9mZzA3WHk5eFFLMkpDZkxYdzZwK1Jx?=
 =?utf-8?B?ang0Y3hzeU90YU9MbVZEa25WR1JXb3I1Z1dYYnplT1hTNjF0NjZ6cEhvYUtz?=
 =?utf-8?B?UVIyZCtaU2RYSHFnallVeWpGQ2tuellKY1dZNmlwYWtlbUF1b2owZG95Y0JE?=
 =?utf-8?B?bzQvOHVIaUJFYzB3NjNyNEhYcmo0Rzh2S3ZXYWtMeXpoWGZtT3pwbVpFd2kv?=
 =?utf-8?B?TmpzbllxUHJ1Mk9oME93ZmF3cVRhY0hITTVqTzNlb3dtTW1kY3NqUXFGc042?=
 =?utf-8?B?Z3kwOTlaR1JURU02Uk5iOGcwcUEyMTl3TlErRHZCNWE1MmVNaXRVOG5IR2hF?=
 =?utf-8?B?OWs5R3VTaVZtdWcvQ21YUFlNSkNyZWJkSkZwcit2VFZnMEFNT001enpVS3Zq?=
 =?utf-8?B?a1hBcnhNU3B0aVZhNnVyQ3NGZkpGaEZFbTJIWjF2NU9VZTRKK0o1VG1CRWQ3?=
 =?utf-8?B?NG4yRVV3UEVDZysvZjk2Ti9id3pzZEV2YVRPTmNtc0txSDh6TU13d2lrS2ly?=
 =?utf-8?B?WHlMNHkzZDZFVnNoN0FxZkxvMUNVb1pEVHpnanMxcENqOTUrR0VXWmMxbTRo?=
 =?utf-8?B?alByN0JyM3RoT0RtYVVqOTRwSm02VlFuY0I5M3lIOTg0eVFoMHNKSGVtZmpj?=
 =?utf-8?B?MG5kS053QllRamRnTE1iSVNNUC9tWkxLYlhoM0JObVA2ck90U2dnOXN5MUVJ?=
 =?utf-8?B?M1BLTlRCSk1kaEhXMTdjUWNzcDJ2b1ZNU1U4dFhDYWtKSGppS2Y1elNpS21P?=
 =?utf-8?Q?dCEfZWH8ePaq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe420de-c9ea-4ae7-a9ee-08d8de17eb1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 07:42:38.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qNw/7SZiLBTjV5/Zn2xULgCcuFHF5wkR95kJwX64zlHkz2J0s/dnSIJjPKSh90E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.03.21 um 01:27 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the ioctl command RADEON_INFO_SI_BACKEND_ENABLED_MASK can
> copy back uninitialised data in value_tmp that pointer *value points
> to. This can occur when rdev->family is less than CHIP_BONAIRE and
> less than CHIP_TAHITI.  Fix this by adding in a missing -EINVAL
> so that no invalid value is copied back to userspace.
>
> Addresses-Coverity: ("Uninitialized scalar variable)
> Cc: stable@vger.kernel.org # 3.13+
> Fixes: 439a1cfffe2c ("drm/radeon: expose render backend mask to the userspace")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Let's hope that this doesn't break UAPI.

Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_kms.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> index 2479d6ab7a36..58876bb4ef2a 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -518,6 +518,7 @@ int radeon_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			*value = rdev->config.si.backend_enable_mask;
>   		} else {
>   			DRM_DEBUG_KMS("BACKEND_ENABLED_MASK is si+ only!\n");
> +			return -EINVAL;
>   		}
>   		break;
>   	case RADEON_INFO_MAX_SCLK:

