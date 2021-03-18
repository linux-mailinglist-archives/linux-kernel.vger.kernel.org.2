Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1511340074
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhCRHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:50:03 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:58533
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhCRHte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKnmZMINavqPzoAz+tNCkK16CBQbajMOJ3+WBONzjui3Qn0GtBMpXYqCTJ/KcgD0i0qWAbYBRshX7kIB630GMBPcNDx683W3wuhmyg9We1qaMCdGXxpE2Gfb/PP5PvuHhBEyqeJwz7/ilRKNIewOl+Kxqke47HH88I7aM3na5ybdSdM9xZ3ujKd+9tDyjc5Y/qQwf58mBVzJ2CGvYnMg+5rg9kcViYQ5mUzpLGnCq52J9k+LjVC0ipOPsVLXi+Jim1HWm94y6cjd59KBmUI+MhRymYikVODJWmu3/fFQ6avWgcGNFfLbck7MXUGZ5igLiLWEFjJBafO3pCmfvMeRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSG35hspwYlyZM+ee6Tpkd8Ve7LaePnc5N6SpJD0ZK4=;
 b=LZLLIAFZoZr0g1R8CcmMv58WpbnpSi3mNutrdv1xJajr+qonZIVma6pzDwUHgkSgUg/rULcX6ruyOs0GpMXx/K35FzX7Q1ABWtlqBn3MVTpRZHKpJUwWQ7XznqXkdXnBpez8r3yaBbXzQ7eixniL33DGOZHpFHPh/RQNCVlou44qukuoFpab9llRkyeMQR9iI6z8Cg8BHqKOC6mghMReg7CCb6P1/ltzGX0svj2QNjUHQYu2Nz8+c6OnFqgrauNIEeVdITmRkoomoRnWWWik6jjGIKfhyaMObTJkuyZYBXpDmFF+DMNC0NHGXpBgEtmG0Mu/QOnLGA+b6vgdqOvIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSG35hspwYlyZM+ee6Tpkd8Ve7LaePnc5N6SpJD0ZK4=;
 b=qN661akNs0p95qlIs57DWzwIjn0yKQr66PSi3XhJBf5vIYquiR7g6MZT0BqgX4abwIx8zS7BPIGlZghqkDi1zDY/eJ4XKbpaDQr4lmlQxjI9J+kyt8fhmWOGKka6YI6wszIjnlFYfoz3NFsRAFYQIake4Bth2I7TgNfGjJQQ9q8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 07:49:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:49:33 +0000
Subject: Re: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
To:     Daniel Gomez <daniel@qtec.com>
Cc:     dagmcr@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210317160840.36019-1-daniel@qtec.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bb94b582-a720-9c4f-3d37-d1f7fd29da44@amd.com>
Date:   Thu, 18 Mar 2021 08:49:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210317160840.36019-1-daniel@qtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:44e7:a99a:b86c:e453]
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:44e7:a99a:b86c:e453] (2a02:908:1252:fb60:44e7:a99a:b86c:e453) by FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Thu, 18 Mar 2021 07:49:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac835032-6be9-4c91-1098-08d8e9e25e56
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109FB49431AEC71F98EAF8283699@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN4+nQeDvkQs5mRo1Tle2lpdSdpw+xOLuxJnGOWFLWhv34xeEvRzbXva/Bc/z4WbcpGcXk3w0nPXKsCSolH4ZrFpYP1yi9D94Ua18z3a8RGwj5ZrHQHB0QuYfCCOzvdN2BZXy8pIx3k/7C6NAETpi2NcIg1d4PTRmkyv6IoIV7mQD3ls27TG2eS0xUTFu2eEFgY3yiifY5HVdQlBJr3mD1r6mkssLGFHjSAG1LWrsuoHXWbuv56nEShlUqJAezggRYwYJeGElWz/W1Azwn7N6w+3DiYmSCrJQYqjZ3doXSr+NHSg/MrGKBMPJL3/ZQOdtGdynXPEIgmcfOPEwilf4suF3eb24tV1eZ7by5FTd1SFAyQnMmAMCrWj8U77HzDvWKI65f3pFiprCY4PWmuOGFmrSkJGAGZWLqeuJ83L1GCMxilY4cB14XUP8isF2adx7GyEagEZeaOGW14HK/B0D/e+RYib7s6sCR8SgmZyl1Ma7LtjcZnv4fcDFDDwZiWkOnsTBNHwVvujN8tdMfhYNuy+MFtlc2Gm4taavM1CgmWLuaMtKFtnBL96KSct+dlFLHCv30WBZRl/vxO5uTj9eEiwzR8FSa6EceJNGntaM9ikTOJ0zsozr80HeF/Rtpm4oo2e6RUYHGrql7V+qc78KlvBYVsYZWY3JQ5yQKXn1ZB3zI4lShWvSTH+3JQ2h1hp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(31686004)(478600001)(16526019)(54906003)(8676002)(186003)(2616005)(52116002)(66556008)(2906002)(66476007)(36756003)(6916009)(6486002)(5660300002)(66946007)(83380400001)(4326008)(31696002)(38100700001)(8936002)(86362001)(6666004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajlKdC9IMUpUMlQxcm9wdkMyU0VuMTU4VEtLRkVrNVdweFBlVkVDQkdUMDFz?=
 =?utf-8?B?MkRjc2tzL2QzT3p4L3U2ZVZaanVGQ2dtYUNMZ01VMEdIK1dDNVVySEtHY2tY?=
 =?utf-8?B?VytMMngwVEFpTENKTXhFM2JDeTZCK2lYMW1Xd2JXZy8zRVdSY0h4bmhlOG13?=
 =?utf-8?B?WTlXaXJBalE3VSs0eHFjc055bVF0aHRiVk1ya1VvUU5rdzBLVkVXcjlsK1JS?=
 =?utf-8?B?eGFtNFh5eWE5bTcvVnBXZDlXNXh0ZmUrN29ndXZpRVQ3ZGRHM2pyTVlJSHo1?=
 =?utf-8?B?RVdxTDR5aGRNcXgwTkVaR0huMHIzQWdQWnlGbit5VXpRUEFnNXAxYXorYVpY?=
 =?utf-8?B?QXZxOGNXdG53NlEvZXdVRFNmZDhkcUF6RXdwS3hRSjlrVTF2RzJlRlJpVVEw?=
 =?utf-8?B?dXNYODkxMXpHK0hJeXlheCtBMEF0KzlpcXZ4dmd4UzNoejJGdDd0WFp4VDU1?=
 =?utf-8?B?VE1IR2V0Q2dmRzVlOHVFQW1WTzdrbWhRL3pra05SR3REeCs3S09jUG9EZ2NN?=
 =?utf-8?B?Q2JiajJZWUp2SHVvVDN3c2tJTHNKaTFmclFuai9acEpIZ2VHSWhyN3JOY1k5?=
 =?utf-8?B?SjhVZy9UZTBoaTBXZFBrekVGWjRTRW5tVGJoWjBhVWRVbHc2OU1OcHczYmNo?=
 =?utf-8?B?RnhHaFlMQ0Y5S2t3R0xiOXRVcWJ2eXIzNHlXamwvcW9UT3ZKTGVZYmQwQ2Yy?=
 =?utf-8?B?ZUpkSUtXRGUrS3hmbGlRVTNUclBSWEYvaVQydHJ6a0ZuWWJtcmljenRIajlE?=
 =?utf-8?B?TzlKTWJCS2NHVUhEYmF6dm1FbFMrYUVuNldCZE44RVIvRkczU3pxazJadFBm?=
 =?utf-8?B?ZHM2bHpVb294dXF1cVVrdFlZR1VybmV1TlFYY0RJVFNGc2ZGQzB2b084d0xU?=
 =?utf-8?B?RUtiTkw1SWJEanUzMm1lYmZ4dmRpOHo5L2kzZzUxOWtBMG4zRHJ5Y3U3andH?=
 =?utf-8?B?OWJ6TDJrTW80K3psUW1mK1VmSnFCbFA5Mkd1cXB3aUtGQnBwMnNEUkZiWUVN?=
 =?utf-8?B?a3lhZys3bitlTVBDTmFqSm40ZHFvY282blFmVHp0Y09ZNXVRYjU2T1lLUlNl?=
 =?utf-8?B?aFhoZE5SMUJkNGtKZERrZi85bVdlZDgzTHY1SHFLVlRKT2xJYnlXOHluWmw3?=
 =?utf-8?B?YmtIeE51R3p6ck1NRDNhN0dWZW0rT1F4NjFOdzBhK0Q2VkRWZEw1MzRtc3Rk?=
 =?utf-8?B?RTBhdnV2cWFIbWxBdkU1VlBxbmN3dHJOcnlrazMvRXJxV0RMOE11UjZPbVcv?=
 =?utf-8?B?VDNUemNiVWJ5RExFY0t2TXpWK3cyelY3WFJIaVBwNnR3T3pGUU4vLzh0bjRT?=
 =?utf-8?B?bDQvSEVPVnhzYnlETE9McFBvYWdqdDljVmxPeWZMMjJOY1JkMFFwQzJzc3FS?=
 =?utf-8?B?UVhUVE9LRDF2VEcvRE1sRm1naGpnTExxWENBOFV1dCtVcEIrblVabk5KOHBK?=
 =?utf-8?B?THEzUkJLbjZpbEdCZGNzNnRBUkRXVVNPaGlsWjkzTHBUeGo0NDh2TUZWNnVP?=
 =?utf-8?B?eTM0ZCtvUDkxZWRQV1lWWk05UG5IM3Q2K0tKOVNIczYyQVp5UDY4Zk4reW42?=
 =?utf-8?B?UVRhNnhFNjhLTlo1MXF4NVJETWxWRUk2MW9qUDZ5R2E5Z0JMTzMxb0hzWjBG?=
 =?utf-8?B?UmFNN0JVc3F6VjBWNWd3NHRpS01FWkgyL21EclltMEZuTVp2RUpiNnlpU3B4?=
 =?utf-8?B?WHlLT3ovYU9pN1VZUDBtWE5pc1ZnelI5eWl1Y1g2WFdYS1hpc2x4OUlHNkgv?=
 =?utf-8?B?U2FveVZXa1VwTjgzaWROT21pQkx1Q05MZWdxVVYxeUNxRjAxVG9kbm9WdThU?=
 =?utf-8?B?SFB4bDRmSVltZDlkbE9lQnFKY0JvQkU1bUZWdDNmVDB3dDRrTGRxaEFleXpR?=
 =?utf-8?Q?jV4Q3u0Rz/SXk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac835032-6be9-4c91-1098-08d8e9e25e56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:49:32.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRzLk4yabELiRd3PYFgfPx/oECNLDXKj5Nrfcj35J2nl2AVEl+GttB5RWbYfgWKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.03.21 um 17:08 schrieb Daniel Gomez:
> If userptr pages have been pinned but not bounded,
> they remain uncleared.
>
> Signed-off-by: Daniel Gomez <daniel@qtec.com>

Good catch, not sure if that can ever happen in practice but better save 
than sorry.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9fd2157b133a..50c2b4827c13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1162,13 +1162,13 @@ static void amdgpu_ttm_backend_unbind(struct ttm_bo_device *bdev,
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>   	int r;
>   
> -	if (!gtt->bound)
> -		return;
> -
>   	/* if the pages have userptr pinning then clear that first */
>   	if (gtt->userptr)
>   		amdgpu_ttm_tt_unpin_userptr(bdev, ttm);
>   
> +	if (!gtt->bound)
> +		return;
> +
>   	if (gtt->offset == AMDGPU_BO_INVALID_OFFSET)
>   		return;
>   

