Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4087362470
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhDPPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:52:12 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:42144
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233995AbhDPPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+m/MAOQyUpkTv/j9gsn9G6+fgo+AYHsfTQjlHy5yMgySUtlv9iDNwOC8sZPN/9vDzArrgCcDdVf0dyftPsFlJSGOJTwwkfgaa3BtHPmU/XYw3k6QuTYXRipDWE3/oIuSHCdUMzx7z3jYfgu4WeTkVDTq2J4tp+lO0mUYOeLWfXrhhPLxozw4VjCRiJiaUneBVGjngFYmtdVNsgVg0lpoABV5OVG3Kr00+Sd3Jk5RdqkIvoSnmPol+BsD9hQtePM9G2xfPFmam4zspcWqvfaI2R0r8R/Mk8e3fbdkF+u+Ix2liBe1xcw56jgqXfIxxE5A4Lng75UpQYowm7WndCsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJc8K5cGuQmsfC7EsVlKixq6SJ73FuB7y7sZ2y5RCvg=;
 b=k2OVvNjGlbnZXbwLHmHNIaPSemVhSp4VE592O8UZaj/UgJ3YgeK6HVz8VQ04m8J1Jb3WNa1bd3dXN9wI2OSS3lno3Gc1ZAVK1UsbMPmPS5UnaQH/hniNattuFy5vEvQJASUjWsOP23LC8d3mBK9v2yEXlesQdKFbTBp8gGR9GxRnPd3HPRENO8JZcvK+DHpYim6YSjlQXBz1XdZIdRq+RPqaOa7fekXh9HkPG+IEDuGdww8dZGlrzy0fg0ge7hvfXSkfTqY1atDPhFkK7EgSBwOA2FGKWjhzBjXIf83wznAT9VRpetDMKXjjwReH4FPpS1vLZoGY1/Rdpn/bvpNpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJc8K5cGuQmsfC7EsVlKixq6SJ73FuB7y7sZ2y5RCvg=;
 b=K+BxSAoNKcuvz057/WEqw8CbkmSvgXmN814L2S4J6lqWvaUqui9I0S4RGOzzj5s3AzXs8cdzkLMMNFcqrv7ZVMsCYhvvG8kWbfE4FdrL85YAxWOCt5V5ZX2r4nCZfuVSx966GJyr+IG2vwhP5gwiSQyJo2lsOr7AaubGKnSYeCc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 15:51:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 15:51:45 +0000
Subject: Re: [PATCH 25/40] drm/radeon/radeon_device: Provide function name in
 kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-26-lee.jones@linaro.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a368fff1-88a8-1515-6bac-5fe51eb0e059@amd.com>
Date:   Fri, 16 Apr 2021 17:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210416143725.2769053-26-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:5d8d:1198:63ca:8fe4]
X-ClientProxiedBy: AM0PR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:5d8d:1198:63ca:8fe4] (2a02:908:1252:fb60:5d8d:1198:63ca:8fe4) by AM0PR01CA0173.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 15:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f128fa6b-0058-4852-7d6f-08d900ef890f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4095C7365995FE5848E66D45834C9@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/O0h0D32VW6M21EwMraGl9/mzNwTV/cq4W2XiLUH7tNm9k4ahR0hV1UhKoGlmkyvX4AzUGXEiemmDVjfVy3B7k/H5KzhbT71YV0Y5l2HjIAaL9ENxee9WHbRWSYq19Fkc2MpoelS1cH/+TeN91/6WndneMSX5wzElkt3N7mQEfL1BBHqLB44S8+VQFRA4KSFzt2QUPV9X5Oq7u+si2EurUp+FL7Cih7iPgV7vaJejNGHX7fbAOMJQplMcMgCDENoN1cpZtMNiwnkJ37LRA1voX7gD4xKmXgkjelhKfBt9EQ7VSc7paUja/vCc2OxEszvb+Nw182K6+JnzGxZi6d2EY3osQ7uZTTsQR42hLJXoWgpOTypNvD1ZZnrfiGdtcEUbZpQt0OlDtfnzGsN3YeOLT/xU/x8hWRT99rGvf6Qgy0Gs4ovogBtiJ90Z3JVUAOq7/BhjL9nTg5QOz7zpqXXIzCcPYAjjMvxKBqGxDOATVFWCeGfkcJumAK/TEyr7mvOY5NILtYrjw3OJ3EfK0JPKq4PzMO8ubRHiPBAeTM6VwR2jgSbkXWZBY7MF7WQjSWTd3lsF52GnNnzrfKTPGLZLBiZcdPMu3uI1rHa5BUY0La+Nz/cwIdW7U98Vk8+n+4q/bSWeccJgmvh8Wro5LWK80g98OWqMx9D/we6Yif9ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(2906002)(6666004)(66574015)(316002)(83380400001)(5660300002)(6916009)(54906003)(36756003)(186003)(8676002)(6486002)(16526019)(31696002)(86362001)(52116002)(66946007)(2616005)(66476007)(66556008)(8936002)(478600001)(31686004)(4326008)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHpVSXprOGZyQ21mZnkraklxVmkxeDJlWnZYaVZFY3BHK2dtaEdkOGVlZG0v?=
 =?utf-8?B?VlJ3TkFrWW9scnU3cU1kNWhBSVRqdFMrRGRCV0ovQU9mSWZTQys1S3lCeFBC?=
 =?utf-8?B?Umd6d0F5T2VERW5EK216bG14dGdnVVEwUWROWFRYaDlHZE5sc0ZKWXVGcGRj?=
 =?utf-8?B?SjZuZitzYTBTdDFjL3hUdmRBWnduNmJOamZWNVpacEdobnV4dWZvMVpTTkRF?=
 =?utf-8?B?aTI3d0twVDltUHlmRVJVQldaSzNJeHVBbU1DSHMraThQQnR2eWJKZ2syVElE?=
 =?utf-8?B?OVNBbnI1cXVERkNlbVpBSXgvNU8xcTJiSjA5ak4wTlJCRmhKcU4wNG1zMXpB?=
 =?utf-8?B?dGJUcmlleHFkdmVNSm4rcTVmVExwdSs3US9wMDMwdEdLMVk5eW1yVmFpTVlm?=
 =?utf-8?B?V1hCRldtWTFWazM0ZTBSVUdtU1pVc093K0tOZGVscldteDd1YjNNNHh5L1cv?=
 =?utf-8?B?aVhmN1N6anZyTTM4eTEwWm5oQlplb0wwMDdvRW5FTS9wcWRvVGM5eVhhUW1W?=
 =?utf-8?B?NmxMbjJBUGQ0VEJqMzhPNzZTS2J2WWJsRmYvajhUUG9hQkNZTS9ZbUtLenZo?=
 =?utf-8?B?d0VYRE9QMzhsVG9CRS9rMVFtd1JSZTQ5Q3hGRVNvcHhFN0VLQ0NvZ0RZT3JV?=
 =?utf-8?B?S0VvU1pVdXE5QkVLV3E2ZjlQdUU4a1dNaVlIazlWTDlQNjB3M0lrUERQZkU1?=
 =?utf-8?B?blk2RDVRSlIzSzBTaEJCRW1ZWEc0eHF4a1hRQmwrQjNDSnc4UW55QzRXS0Ft?=
 =?utf-8?B?czFCS3JNK2tWd3BkYWxscGRpbjBQSkMySFYzbkY4a1dESnA1SHk1RzhqcEdI?=
 =?utf-8?B?T3lBTTNibVZzdmg2RW1rcG5sRDh6ampGN3JCaWt0anBQVTNtb1lOOTRZRDVR?=
 =?utf-8?B?RmZvV1dYdXNzSjRYOVhLUW5SeVVnN0ZCdjJ4M2pEZlBMZ3UyTkE5a1pyaXRy?=
 =?utf-8?B?aWVMSFppTXBCVVMxaElFdGhwRWltZUQ2cStvSEtNZXNVTHFsdkF6bjdwMTI3?=
 =?utf-8?B?WXlYSUZWZWJUWXN4cHY3SHdybmxvc2FMekJpaHJSTHVCeEtnWEVWY0NBZzJ5?=
 =?utf-8?B?SUtqd3hvZFZlSXdFMjVTL2tGcTJKbXQ5R1hHRFl5MmF3Q3FrMnNIdVIveTZ6?=
 =?utf-8?B?cFcwU3plY0lVMitSWDk4ZllodzlNNXZCVWJhbnd6ZHBZdWhIV0tRaUo2c2gw?=
 =?utf-8?B?dGk5Ui95WENnU3RXZUY3WkhyL2VIcnI3bFBRQm1BajFQUjY0UmVYWHJrUHVy?=
 =?utf-8?B?NnJ5aWQyalJFTThwN1JZdWFTeVFXcTlaUWZyTEdwVFUyZXJiU0ZBWlAyamMy?=
 =?utf-8?B?NUpIK2tkZVprb1B5M1RRd0MyNTBaekNseVBOM2FSdlN1TGM2QUVHekF4anlt?=
 =?utf-8?B?M0JqWTFMZ29ydTRPQnF0QmxLUmJrNE5QSkZycDJ3N2h6YVNDTlUzTEU0MERu?=
 =?utf-8?B?MDZSM2hsTUpJbkFBQWxXbmZsRmQ4RmZrZGRoL0ZkcGdrb2g0ekpweFNEZ0ww?=
 =?utf-8?B?TzZHcUZzQ1IvMjF3WHFUMnFmNmVYazJqTXlLY01ZZmdPVFVLR3lVdnlORGY2?=
 =?utf-8?B?MDl6Zk9XSzJOOENtOHA4czlyaHkxVjJ3M1N3NFpSY2RSZENFUGxkdXNjSEJW?=
 =?utf-8?B?NVR0QVNCUnRBVzBndHZRQjRiVXRzdGFxZFR2aDVWNG13UHdsM3J1VEl3NFpH?=
 =?utf-8?B?T3h1d0ZwMzF5U2tibVh6MHQ3UlVQZzZnSTdDN1pYN0sxazFGRTJFSGNrMFU0?=
 =?utf-8?B?YitEbDZZZ0dsY0RJdWRKMHNqL0RjK2d5bDdhbU1iNG1OVnMvRmtaSStWdjR5?=
 =?utf-8?B?WEVBQ25iNVduVFFZUEZ6TWdxMTFPSTZQa05mdHZmZDQrY3dxY2syYkM3OXZU?=
 =?utf-8?Q?WivisRqXmfeV/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f128fa6b-0058-4852-7d6f-08d900ef890f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 15:51:45.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rTP3clGiJk8wz0ZzX4gUJ2U3FFN5nm8+B+Md6v3wwGTmHzaavcAag1Clq3+gnT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.04.21 um 16:37 schrieb Lee Jones:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/gpu/drm/radeon/radeon_device.c:1101: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index cc445c4cba2e3..46eea01950cb1 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1098,7 +1098,8 @@ static bool radeon_check_pot_argument(int arg)
>   }
>   
>   /**
> - * Determine a sensible default GART size according to ASIC family.
> + * radeon_gart_size_auto - Determine a sensible default GART size
> + *                         according to ASIC family.
>    *
>    * @family: ASIC family name
>    */

