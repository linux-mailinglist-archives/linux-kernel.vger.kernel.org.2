Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548936240F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbhDPPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:36:26 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:2240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235293AbhDPPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJd9uO5FbzshGw4PBIiDFAe7kcXo1Z5PdyOa5AnmzZ88sXE51dao2x/MvWyjjoTGpX3fMxw/HuB7wXzZT9gH1j6rfd2J/ANwN1xJuTVZXQsfz3dNe5HkIT1txNUf69ySzAovq1iVbGMbm/YFw3rDpCnn/+E/cPDNFB+Tc+PsRGX1hYfA8VMiCnGqHAwooWcmIRVRLeD139Xf9OSYXy0yTES1ME1RLugI40Avf4ggzDX2MnxUfMzAQXmX2YePWd9s4ADAdTT70g/0wJFGWIYSSQcGTsS4djUaHJ/Wu789KbKQ2mP7fGdQPc2p8HiBjqTRTi5FZQrXKkRLrot8lVWf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE0IppFtLOvsZDHaSdx08OBv/yfH5beTvGciLWc+Xqc=;
 b=MB/Y2tyK91yCw+tJLeoimZNPVXk1yY33vJBftUKTwooBCcMNAPOAG8qzujsOlVztYmBbqaAAMOPpBIpUUg3w3NSwnizgeTkdo3Pd5b5jpWtRAJyj3dG0NVKioUhZSCbcT6BohPgUWMKClezY5vpsOt5wFDMIc/Lfj5aplA/ROvyBpHjTN4W/vyPWFhy3bYyzyQUsk7vh44neiRRAUJNvi4NRaKmclyKX9V4j3/6APm0qW7DoD9umMfp3YbmZPVeJZB9lv32VBLBS9Ptqsft7sT2fbADogiDbhT0RDNUkPLNV8wCdyXiARaeeoYETgHj2KC9gxq7doFxJXbmk18Fy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE0IppFtLOvsZDHaSdx08OBv/yfH5beTvGciLWc+Xqc=;
 b=1g55HoAOq8t80YqPZzN9qFdOSGd2InnHFhiHcazLEe/8JIcRETnlevwsKFEexe06XyTVtvoXGp8sxoWtjiCQ3GT5GVJI8fdYswbEtOSMIbOoQR4puYjuwKs0HT8Ht/5p3wAzuQlsz0w/Y6DDdUwJzB5fKaXNPQpiZy36Ge0TsQw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 15:35:57 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 15:35:57 +0000
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of
 function names in the docs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-32-lee.jones@linaro.org>
From:   Nirmoy <nirmodas@amd.com>
Message-ID: <eeb39756-40de-bc34-f814-0eb2b0ee0c1f@amd.com>
Date:   Fri, 16 Apr 2021 17:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210416143725.2769053-32-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [217.86.110.98]
X-ClientProxiedBy: AM9P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.98) by AM9P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 15:35:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427011fa-87be-4322-e04d-08d900ed543c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2468255E6C585CD91671333B8B4C9@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNiZra1bwU/TYneK8jOSu5WgJspeOmJXoxaWJZgC0HgxlP+a1oMxlSIKXqpAe40/uJ4qeo8n0x5FjPGXlPXNRessHMvWkZMHvtqURVBSHM4xD7wxxXxoqQN95NRxa0Y4NwSz03nxofuIjDTeSfq7gXIlgY60kErLfb5qYllLaNhUTufP9etjaUV7fsLum6Q+9UhvHpnAL5WrAdzYiVVb5/2euWzBIsk3qsBZA49hvHPpQLzzU0SJRRpnJ1WS185Y9KAbljVRxyOoH4rBIJCnZya7KekBTP827tvhc2HYPXKeTYT2ihPpLWsXPZkS5FIhCA5JErlxKjj1Kz9liD6uWUJQXEut6epFoNaqV5zZqDPEb6fZ+pRWk4w2dIgVWKc+rAoeXlD6kox+Sx99BO+hm59Snill5G6h6oyn9yyqep7RLTRQG5YUmlaoK5gSuj1aPyb9m+r/g/Ip3xyuB+7+qHK8AyJRQUBt+nBrs7keyQIQeKGS8hQEgJ+I7oFdgEkO+tIeVk1Zfjs8CukerlpUhwKSayq+Z5klw6dB6Iu2xPv/O9EgW9xfpA1pS/GtiS1VLNkk++sfdWIPKUPBK2Yl5wRAIBOWPSrrIe6vignduBPqUmUw6fQkiuUhFCNtmb6MaXxPmLteGvf2wx1Sq3ROyefoQe92/ruzK0UCGzKerF8zOJ6fe3ctUB1rrb6extg/EkQ68c7rJf51qzJvIp+lBJNjKuN2QznPWMYmp7ZTvSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1463.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(54906003)(31696002)(83380400001)(52116002)(956004)(16576012)(6666004)(66946007)(316002)(66476007)(2616005)(66574015)(5660300002)(2906002)(186003)(6916009)(26005)(16526019)(31686004)(478600001)(66556008)(38100700002)(36756003)(8676002)(8936002)(4326008)(53546011)(6486002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MjdDVkIxRk5LWXVnRkcydUtzVXYyeE9aRUlQRXlOM2dTMEtFWW9HakZDcUlv?=
 =?utf-8?B?QzRRMEhKZStIaG56anB5bmM3a2tXRk9oc2hhc1ZONVJTc0tPNG9ma0YzZURm?=
 =?utf-8?B?bVgydnBEcHo5dzZzV0VPV1ZNWDI1KzBwb05IREp6cWo1ejhydWZlTnJKc2JI?=
 =?utf-8?B?QjF0NTd1eDBTUERpY0VkSmVrSVowNEpmd2xKQWZJUzBwQ3JscHVqL2VRcWxp?=
 =?utf-8?B?a2tlU2NIeUIwMmw4ZDlGek51bG5SMGI2clpHc1VROWYvc2RoNUlKZm4wRStj?=
 =?utf-8?B?WURiQ2lGSlZJTldQUnd3QitpbmNmVzZCczdjbWVRRXVPaVp4VEx0UGhWRlBH?=
 =?utf-8?B?aUdmaHp2NHVrU3lkSmJMZGFrVitUQnVVMVhuM1JQR0VlVThWRGJhaTY3Z1Ja?=
 =?utf-8?B?K0g3ZEtIa1NNRlFLNWJCeWhWRUsrUkZ0eFZReWdiOTlGODhhaysrUWozSFVM?=
 =?utf-8?B?MGxXb1dxU1ZNYU56SXh6T1U1cWlGNzVSTS9mZm9na1Vpem9YNUUyUHNLaHhX?=
 =?utf-8?B?Ti9naG4yRTdEb3IrYVVnNk54TTk1QzV0SGJUMzVoQ3R3Nmsxc0x6ODJYb201?=
 =?utf-8?B?VytIZmFCQWJIbUsvYndzaHh6Yi9YSVhiRzFVRlE1dllRTVp1WkIrZ2RjRVFB?=
 =?utf-8?B?ZEp0ODFnZnZqSzJIb3pneGRoWE5qTll5akNvaUVvdWs3aDk3bnRjajFraFU5?=
 =?utf-8?B?bXBwSFhxaWVxR1l6V2p4ZlR6VGFjaXJHQ3ZRRWVhQUp3TzRpOFpJdDVqTzhw?=
 =?utf-8?B?VTJqVWR3U1ZPYjc3OUVhWE9ROE5MaWNNNXNHekhxc29oR29maWdYcDhJVmZR?=
 =?utf-8?B?VklyU05tWEhqcHo2c0gzZDBRcTNQeWE0Rk1YaUh3dnJSR2tzV0ExZy96bVZ6?=
 =?utf-8?B?eWZYaVkweWFoUzE5WHdXOHg2bzhWVHVjRTcyWERQV0FKRDdvUk5XSmFjOE41?=
 =?utf-8?B?Y2xlbVBjUmZ6N3JFNDF2WXE4SjlCdmo2UDUxQlBYYy9YUlNXTXFQbERxZGNC?=
 =?utf-8?B?L2xqTGs2RlpkRlU3NjI5SkJONU9WV2oxQkppOG9KcU1iZDA0VTF5eHlBRE14?=
 =?utf-8?B?MFRZNi8yZGdpMHo4VEV0YTAzRjhFUVV1RXVIYm5RY2JvdjFQb2VoU1pWcU0y?=
 =?utf-8?B?bFdKOFM3THRibFhqRWdFa3l5Q1lmMjFWVyt4MTBEVU9kMU1rdnVacnd6NTFR?=
 =?utf-8?B?Qll6b1I5UGdHUEhjai9XaXJDQ0J4R0RIRVZCUGN6Tmh2RHIzRVdRWVJqTGxW?=
 =?utf-8?B?NE5LSFZ4QWVaWnJXRGphZFdja1YvaXZEUWk4SVdSSEFEWHBON0VjcjJDR29O?=
 =?utf-8?B?ZWFrZGlvR1BHVnkrTDFwcy9BZi9xL1ZqVVVzNlpYVkRPbkRpSFV4bkJkeGxD?=
 =?utf-8?B?c3JncHBiK1dSUmZ0N1RqU1UzMkxlUEowcnVoZDI5Z3NNaWhmd1BxRHJNUEs1?=
 =?utf-8?B?V1gxYVhVWVovckxlUStpcTMwTVZGZXlMaE9VVUdvaCtCV3grTGhXZkQvSEZm?=
 =?utf-8?B?VU4zNVdQeEZSTWJZeTVBTStqOVNNMlI0SkZQTnplM0ZQUS9JQjQ3SlNtcFBN?=
 =?utf-8?B?WVYxaDJJb1pmNTZFeDc2ODBHeTZRRmdIL3o3WnpjTjg0cllZV05IZzkxQzNG?=
 =?utf-8?B?MEU0ZUxJakF0ZnQ1RUxWckZNTmdpU1ROblVvcHl1dTAzR2dZUVNoSXZkRHV3?=
 =?utf-8?B?SC9Sd25JRTlIUWRLYTM0bjZVdDdSeDFJQXlXcmYyT1pTcjJoQThKU0dxamhl?=
 =?utf-8?Q?VdwYFiagm4+j/+R6UCc71kkiJYpDNAHPJC75qtr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427011fa-87be-4322-e04d-08d900ed543c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 15:35:57.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPJctv23M69RNSGwtp+BjTkr0DKrzAW5kR3nfcsEhQ1nGnlHp2wikTIX02bpLc1xoUV7LEf9RgRJMzJBsgZa1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 4/16/21 4:37 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:73: warning: expecting prototype for amdgpu_dummy_page_init(). Prototype was for amdgpu_gart_dummy_page_init() instead
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:96: warning: expecting prototype for amdgpu_dummy_page_fini(). Prototype was for amdgpu_gart_dummy_page_fini() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Nirmoy Das <nirmoy.das@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c5a9a4fb10d2b..5562b5c90c032 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -60,7 +60,7 @@
>    */
>   
>   /**
> - * amdgpu_dummy_page_init - init dummy page used by the driver
> + * amdgpu_gart_dummy_page_init - init dummy page used by the driver
>    *
>    * @adev: amdgpu_device pointer
>    *
> @@ -86,7 +86,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_dummy_page_fini - free dummy page used by the driver
> + * amdgpu_gart_dummy_page_fini - free dummy page used by the driver
>    *
>    * @adev: amdgpu_device pointer
>    *
