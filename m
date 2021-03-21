Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF283432C0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCUN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:26:40 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:3431
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229834AbhCUN0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU3FGdE37DNyhkEpJMHD1ah4ki4GNTkhcvNJQQmpX6YD8BRyzDAHZYH4LTYo/oVjG/1AdPp9B7mEKFfahk68upmC59Iyy1LOwVOxiy3E4rsmPv48DfzPhPBLE26Ix4sdtp3JcPQByh5bjhfJ8MOgqoAhgNWYdFfXFaYVXd5nNNsG6mJv0I3OX9PJ/xXiQDLAfIKJlmRWPOJm8fUC3B+X4uyICYtv3R/stYdwgJXVpTTXxnD3hv8TrZoSOgA++3Pqn8DXxYUfsLjy7eZJwqHLQhscLkpGlMP/ikm1TFNI8mEr98GHe0xgeZwQ1XGnJMV4lg9v1ZrwplY19dhs7JjZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5FYiCzLu8y1o2McsBXFFYb8R2qFtZ8bZeIVTf8T2Tg=;
 b=hbfIXzoRgi6+kGtBO2YGtcpYGTHvvvdYXa2USu+xdwmSy3OSixZFF0Cq+p5/KEQSkMX95lAKfQ8PGQh9ccY4Wreiwm+Bn2qZFMU8nKSXolcoZ9WuR6fSTnWI7OUcVGJy2rcxHCI5OsU9Tn0+Z+0EI4LKh6U0bCFsxU3php4yosyhmI2ID9OUT4tG23QhOo7B7pb6rW9SATBN7J8AfTjYn7NgVvCbqTEHTsJyGvqQgI+rK66Iij4vzpK3CY58Pyi9IJypmaO5G4vJJ8k7gKIAvChSyS34H0Ls5aXt7dgxOdXmhto4CJ737HMRtttq5K4XYPff0VVok0ejfALstXnYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5FYiCzLu8y1o2McsBXFFYb8R2qFtZ8bZeIVTf8T2Tg=;
 b=DeRGPJt76IEYO0ByF0vKFnEheC+HipafwkhG9pAnDK4CJcn9pUzPNF0Rxn40rSy4YaGjsRy4lgfJ+YU9h0WyI588DbHI/8tz4zp5I1noEQke91KUpir3dmzb6BetQV0P/xRebXyeCY9ySG6+cMgG5+PAOd/WCBmSGXkQTb7637U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 13:26:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 13:26:33 +0000
Subject: Re: [PATCH] drm/radeon: don't evict if not initialized
To:     Tong Zhang <ztong0001@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210320201052.114775-1-ztong0001@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d50c08e5-51d7-148c-464f-7699e6f6a115@amd.com>
Date:   Sun, 21 Mar 2021 14:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210320201052.114775-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e77b:ed9d:2e09:4f57]
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e77b:ed9d:2e09:4f57] (2a02:908:1252:fb60:e77b:ed9d:2e09:4f57) by AM0P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 13:26:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0a427cf-c3ac-4910-e607-08d8ec6cf16c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB369464B3ADCC2ABCA29D649183669@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0k7xk7KcdRHwj/w89y4pQr8SoZh36alwywaPsVqlthJ1VUh0DBwrP3tT+3yX1aKagWfLcKgj3l8uYnuLDizFv8a985J1jAN+jvz9zYQnixysI12xX3nijXzccuaQiomr0oaG6VlL8f9KVYUrVYXPl302FN09LZWocX6xH5ACssdGLXYo1oigTh/XEVoEJf77eZlNhWnTNg15h1zXsOQwo9Ycd8l0JQmeXvcPvOP/CX9FeyfdXqGmc0u9LE8s/F6zEs4jjFZG4X6UfCsvwDWGz+vkL0P0eJjiBiXhS5KiZ+fv+Av6b6gacQ+1w9voiJbfP6uH1FsLkY689nPwlgxhAek3Ell3jwpaYCk40MNSXKyupEyG5zo7mHowWPKEmSRuntHMtZBMCMCwduOhegooaGXoDw/aZmUmn4zGQNWjwfjz6h0xKtv9fXiFYpNIjyWSpHG7SZ8zdWyiqY+PQbomXHTZMP4IKKL4ZeT5WcpYxyBdjDkBfVD/HDfOx5T11t/oar+xofx8/XU1m72+FnkNPO62CMi/tvV7i1cI9AhGMrXfRowCTemNyjeuGyT5VlNxfqv78dpw7UfomsrF88U7OTIuWxc5kBr6Y/nY1tcWtQXf81idX6J3tq8xB8MjzTVOgjoswBueMk49YJuhMI0GZv8M4Uyq82ULes2CBE+E6WNUemSaUOy4zbsGAtdVO3O3/CLd7AW2mI4fzbyUj//sIxT56VP0LW8av88UYuW4Rb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(5660300002)(110136005)(316002)(6486002)(52116002)(2906002)(478600001)(2616005)(8676002)(186003)(66946007)(66476007)(66556008)(16526019)(6666004)(8936002)(86362001)(83380400001)(36756003)(38100700001)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3I5blIrL1RydGwvSjM1VVRndDdKVkhHcHVkUm9KZDM3ZVJLZllSZzVPV1Vz?=
 =?utf-8?B?ekZReFM4ZzdjYlNUM3RYM2xXYTNCTlFMbHdQaVNXa0JxajJnTjN5TkwwRDRZ?=
 =?utf-8?B?VkNDUVp5VmtBeGo0YzRNblUzbkhMemVlempQc1FIenhWWUtTMStISWNYak5i?=
 =?utf-8?B?TmxIOEVmUzcvTTNlSlRXSm9acHl3YndrUUpCazQ1bjN6SGpRTWVmdmxDOFZE?=
 =?utf-8?B?eURVM2dWL3cxQUU1TUdHUkVRc0lwOS8zNkdmRExjMjU1ZlJuWUVoekxoQnY4?=
 =?utf-8?B?bExwUmgrVnl3ZzdVV1NuOU1EQUlIcWZtQTQ5VXFiM3NObU1may9ZdVV1Tzhl?=
 =?utf-8?B?ODZreGkrKzZDVEJXTFBRT0JXMDE2cVRnZHFkbTE1YytSbktMTi85cGRYY1lT?=
 =?utf-8?B?aUI2em1XRy9SOWsxRUhWVFpZbUxFeU91cXNpblBSekNmMkFIcWpqY3JxSjJV?=
 =?utf-8?B?cDVhOUtxbXVrcWpBQktGTW5KYmxBUFo0cUJkMmxuQ0hDVE16RExRNnB6SzBF?=
 =?utf-8?B?TEE0WUtaWlFqVzZyd1pJZExWczZBaGMwRVlnSVhOWXJETmxGNDBIZkhpVEMx?=
 =?utf-8?B?by9xd3VPNnRxZ0VKYkRlei8zMlVWS0toMnNCbk4xSVR2T2h4UGpBUE9Bd0FC?=
 =?utf-8?B?TmtoZzVnMWVuSlFmUUU5bnRLRG41SDQyWXFPWXlDOUMyNVEyRTVSY25uc1p1?=
 =?utf-8?B?amFhck1uRjVPSjB5eEZGbDJjRzlpcjdjaDRXVDgyZytiZmRQWk9oRmlBUXpB?=
 =?utf-8?B?NDBoU0doR0FpOFcxcFpVN2c4OG9OWUxlam1JUFo2Z3dSdUV4d1M0RGxZQWpm?=
 =?utf-8?B?NGpKM1cvV3lnV2I1RG91eFRpM1dOL1FzMWtmcVBLWGxiMlVaVUo3M25yNEdo?=
 =?utf-8?B?ZHRPQWd2UDJQZCtzbXpoVXFPTDRrSURVWHM5eTNzRlJ1aVhHSVVqaXJTb0th?=
 =?utf-8?B?L2MxQzRVS3ZvYlFaSnlUdWZxY1VyRmo0OUtCWUxuWmhFYmI3Y09MOVp1WEph?=
 =?utf-8?B?ajR2S1VCZHFuREwrZHhlY3Q0MzZhQXhFOUNkOGpMT0RFa2lXeS9zOUMzbzVZ?=
 =?utf-8?B?Vm5VVkJFaDU1dzkrT3BpUEhhV0RJVWw1M29IeWxLanFXdS9mbnMzNmxiWVlE?=
 =?utf-8?B?b1pmWmxzVFVIbzhyQnliUlJvbjhyYWRJNlp5cnNha2U1SFpMdCtwY0YvaHE1?=
 =?utf-8?B?ODFmaGN0czlOdkhoL1Y0ZHhJZWY3WGJqYkgxYVlpZTVXUUNGZW5YQ3Vnb0Fw?=
 =?utf-8?B?WmQ2RTRETHgwcVgxaVFWdTZBR0NxRnQvZldQZzB6M1NVdTZsQWxQR2JPdEUy?=
 =?utf-8?B?bGRuM1BLcE9xTXFtQXdWdTgzeEFwM0tDTXkweEVJMU9jVGZCVDQxTkZhVTlP?=
 =?utf-8?B?MXR1cjZGS21sMy9XUXdkUlFlZWF1bGtxNFNOU0c1dEZmeGF0Z1dHZHYySy82?=
 =?utf-8?B?dEh5Y2JTNlhzbFdzbVN5R3ljemVOQUlyYWFCYnVPWnJ4ZGhQWkp5VjI4UEo4?=
 =?utf-8?B?YVMrMkMwQ1ZBNHhOUlpnWjQ1Q2sxMXFQOEdUS1RZWHZvaTliWklCbVZSbDFY?=
 =?utf-8?B?WnVOUGFiMXdVSURLUGdQUlFkdDdmazVFdlNjd0NRZkNSS3FMM1FMTlFNcFox?=
 =?utf-8?B?ZTRRU2U1WWR4K1FzYmhHR1NYSkNUWHdoSmUwRndHZlNrZitKeHhaWmY0VmRv?=
 =?utf-8?B?TEFHMitMZEpKNjE0NjJ1Q05CdFNJdk1OaS9wWXlDTHpURFRtTFI0MVMyZFFu?=
 =?utf-8?B?QUFGSnRuekJYVU9IcDhIa0hIeUFjcEwxSTZ6a3lmVVRYenUyWDVqNTRKSzlZ?=
 =?utf-8?B?UnkrQTR3YjZsY2JKeklmNHBQTlVvdlF0UklCcFJwSUxvZElqNDBpczZ6Wk80?=
 =?utf-8?Q?YorHda2Qfn+GM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a427cf-c3ac-4910-e607-08d8ec6cf16c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 13:26:32.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lczE23QlhioPIUgRRSkdhPOZLK6E16FBtZc/z5UNgna6mbs7Pq7tCuwtUzg2Swme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.03.21 um 21:10 schrieb Tong Zhang:
> TTM_PL_VRAM may not initialized at all when calling
> radeon_bo_evict_vram(). We need to check before doing eviction.
>
> [    2.160837] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [    2.161212] #PF: supervisor read access in kernel mode
> [    2.161490] #PF: error_code(0x0000) - not-present page
> [    2.161767] PGD 0 P4D 0
> [    2.163088] RIP: 0010:ttm_resource_manager_evict_all+0x70/0x1c0 [ttm]
> [    2.168506] Call Trace:
> [    2.168641]  radeon_bo_evict_vram+0x1c/0x20 [radeon]
> [    2.168936]  radeon_device_fini+0x28/0xf9 [radeon]
> [    2.169224]  radeon_driver_unload_kms+0x44/0xa0 [radeon]
> [    2.169534]  radeon_driver_load_kms+0x174/0x210 [radeon]
> [    2.169843]  drm_dev_register+0xd9/0x1c0 [drm]
> [    2.170104]  radeon_pci_probe+0x117/0x1a0 [radeon]
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>   drivers/gpu/drm/radeon/radeon_object.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index 9b81786782de..04e9a8118b0e 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -384,7 +384,9 @@ int radeon_bo_evict_vram(struct radeon_device *rdev)
>   	}
>   #endif
>   	man = ttm_manager_type(bdev, TTM_PL_VRAM);
> -	return ttm_resource_manager_evict_all(bdev, man);
> +	if (man)
> +		return ttm_resource_manager_evict_all(bdev, man);
> +	return 0;

You should probably code this the other way around, e.g.

If (!man)
     return 0;
...

Apart from that looks good to me.

Christian.

>   }
>   
>   void radeon_bo_force_delete(struct radeon_device *rdev)

