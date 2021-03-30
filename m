Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9134EDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhC3QVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:21:54 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:57147
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231952AbhC3QVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:21:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Suzc7gSHvl5+iG0TCuvKsb/6IenMj1PQmbmBc/8QxaP9y6qPieSeFM0+EX+4N5XhfIrqVR1ygczn1JmL+4qO2rNthU5oYzxk9G03SHCNwcuhsuxNmpUUBiQzMl2cJEkFb51nB22eC9njVt/0Le5a++89tw+GMVxFNAJUAV/059j/QQpT6TLSdRNdowSABFuC2saS3BjgvOiNoX0L8RbWdyTEYa3QMnGjjQL4zTf83IGJuLOwSvXoXoVselyCikZpJhrrzLkPl8AjBxRzAuWF0Qkx0TiDoTUzRuoV3H9KiCZhfkm2ULzfcGfMVOM/nr7C+JAOERJiWT9lxZhhl2ikGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eU1gY1YsSTw5eDxKOX/1Qf6m/LIY0K6DhRhE7sZG1U=;
 b=ZhSPB+5uBloGTdAnfiUOocz6EPW+ILAjGJV0AV90t7qjrYC3ff8yxTbKVDvbzd5NVZz0l0zC91fpCFm1w0heszV4/LQF2vLy2c5oJpJG0yd28lItbLFtfsw/2mGpqLe0EiWBQFnFr7ldeGti59r9rE7VUU1+8dAk124kyfkWk9KY8yCH8RCAY3ngIFFoLlz1SfsMYAlkqKXq7Rg8bRR4/CZWsDKLAY5gt/0Mk47qQ22LVad8i7XV4uC911WnNtQ7Tp0/+R6nNOOQc4McPzPHESfiGgxWNsDJLrf9oTgZQC7WE1ckTwVQKMqmwbH9KVjKRbPhJZXdtQYz+8dcBbJcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eU1gY1YsSTw5eDxKOX/1Qf6m/LIY0K6DhRhE7sZG1U=;
 b=Wkh5w3hOfMlajvC3JjQ1JrpsKqae0R28M6KMNoWTnrlBfi80XK5aXUJTObbLFNyYXCWeyHTgArCKFXRI7/BCNRik0ELaXP3ZooCJa1e1JHDV+HqE3ou1XdoC9LmW7DHomJImOTl2JxeEIg4LaxWoocoFxaZEYCeiUj+/4DGdano=
Authentication-Results: linux.ie; dkim=none (message not signed)
 header.d=none;linux.ie; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 16:21:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 16:21:17 +0000
Subject: Re: [PATCH 0/2] ensure alignment on CPU page for bo mapping
To:     =?UTF-8?B?WOKEuSBSdW95YW8=?= <xry111@mengyan1223.wang>,
        amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
References: <20210330153334.44570-1-xry111@mengyan1223.wang>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c5e3a40-9889-1cc2-583d-51f8c3294908@amd.com>
Date:   Tue, 30 Mar 2021 18:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210330153334.44570-1-xry111@mengyan1223.wang>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM4PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:200:42::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c] (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by AM4PR0701CA0012.eurprd07.prod.outlook.com (2603:10a6:200:42::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Tue, 30 Mar 2021 16:21:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe22bca2-8df6-4393-d7cd-08d8f397d832
X-MS-TrafficTypeDiagnostic: MN2PR12MB4405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44051FCFC319B2B7135AE209837D9@MN2PR12MB4405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJmShdqnrqRP6K3XjjTsC85krIRC3bKUHkNuJDu11h23wqkiL0rfLOiLSFd8IqMet4EMZwpA+4a+vjj3F/MBixUrCYJ52jcXLO7JFfwzjusqdKhKD2NPWthInTSLjYBQ6hhdEOdq6GmRx2Kjz+7WVU2ef+zSlT/VCQq/jmStFy4u6EeRRhF/oHypIX3/lWJlmD71yv4OMPw5pCgwpb2VQJo+0TDn6nztWV9MxNXSq3zlJPW2rCVEQPH947qMjk47u+vDrTylwm1nBUChvv4UD+mOV9f8tyTKG3V41/8MjlNZM75s1KPoTD2kcQZFiOSejQeONe/cPfVuLfhQBFbfG6qN8Ml583lbLBOtlbanxhuaNgekCqYhfbZdboGz3SjkIUf549ttgj9QjOyUp97D9BVubOM1w5/ZqfhAp+3qvwIRJC8DAlDPJkmb5Lu7Pc372pVILJC7dgbzgBc1e87bGJ4QOSKIL8l8RLpuO4PqRl3zX282ElJAhEN++EBEUZQaH5ctOr70nTUjjlCmMWsm5Kr2sQYLhAbo0d3ZQA+UDn5U4LdzIJO/lKRCW+zOIiFdyvNtZKDq7oBi5buYOIIM/iq6UMhkIbimuf0rfq9KE05xd8g6mFu8Cp04KO/LR2kodzOS9OUpLQYyko8LwZyLfNPRC9l3K4/rsDi2Tb5Q2bBPFWv/dNEKn5tv8Czck2gpmwGiQpUjQOvvzzMkTWdbKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(86362001)(6666004)(38100700001)(16526019)(66574015)(52116002)(4326008)(186003)(31696002)(478600001)(5660300002)(6486002)(31686004)(66476007)(66946007)(66556008)(83380400001)(2616005)(8676002)(54906003)(8936002)(36756003)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjYrb2hWa01BOGxXYTh0MnVJY0luM2luZDBIeDQ0UjNWVlJTL2Jlc055anpQ?=
 =?utf-8?B?VUVaK212cytpN29XVkVJclFIK2g0L1lISHBUbExMSjRsV0ZHSUpkOGpsS0Fs?=
 =?utf-8?B?YmVuSGY3MjVuRHRoWlI2YURmM3F1Z2JXbXhRbnEveEt5TDVjMytvd09iQVR5?=
 =?utf-8?B?ODNSNjdmdEJheU5sUWd5Y0xuSnJPUlV6T2ZmV1ZZMkhHWlljOTdZMkRjeWpz?=
 =?utf-8?B?VzhjZGVxMkZyQmQ1WFM4Y1o3di8waGlCTTZuUEJ6TlBoVUZJZ1RibDI5SjBS?=
 =?utf-8?B?Rkd4WFhXdGdKSnRIV0lTd2NOek5TbDcxeENiR20rSnhRbW9VeWtwOVhxRmcv?=
 =?utf-8?B?N1dSVWpVeW41NmxOQm52S2NoLzlzS0Fvd0xFRkQzakpmQ3JYeEx3N2lsLzN4?=
 =?utf-8?B?NlN6bk9ycERtNkc5emJTMUVaM2JITE9vZ054Zm9vR05pempFRGZQaTU4Z2pp?=
 =?utf-8?B?Y2lvbmluaGdZOGd3VnE4UnJWRlJPTWM1V2xoNW5ZWjhDQU5zN2VHVWJMVjI3?=
 =?utf-8?B?b3RwaEpTTHZieXVlazFQZGtLOGJLQ2tqUFRkdkd4azZOcENCN2d2SEE1MG94?=
 =?utf-8?B?WmdNb3pBQVZmaDZiRlp0UVJtODNVWGlZVjk3YTVOcTVsQ2FxS2ZHNzZlQmt5?=
 =?utf-8?B?SUdUVHI4VjlWWlk1aEtrcEtnQVJpRDk5SXlqSFBaK0lYSjhYcGcxUTc1QlRS?=
 =?utf-8?B?Z2ZZZnovOXhwcUt0UWIrWjBBOE0xNW9DWGlQODZmQWFoMFl5VThPa040OXRu?=
 =?utf-8?B?TGYveWZ2SzlsbmJxYlRLM2JKMi93czFtdnFWdHVMcWNOakNCY3A3ZWdZQlBP?=
 =?utf-8?B?QjJjemRJUmdGK3VJa1FiYVFpdC9iUWtVYWkwMkk3ejRYVWozSXJEZTA1elFC?=
 =?utf-8?B?a1NOS3ZZVmpJRER5SHJva2cza0Rqb2d6RnEwWWRZbnMwZFI1bGtSWUFoTGJ0?=
 =?utf-8?B?b0E3SGZkdkU4eWtwTEswdldMdDgwRC90VzRoU1RVeE82WDF4VWREUDk4bXRm?=
 =?utf-8?B?NkpMNDRJcDMyY1pUWXlVSTBQc1JabE8yclJDcnVlR0srN2VaRDd1YWJzMlp5?=
 =?utf-8?B?UnorbGF2VlRYekR6cVpsRTF2SDhTSVZ1V29XK2RKaStKUXVSeGw1a0ZEUk9V?=
 =?utf-8?B?cHJaK3hSUmRUak9NK2V6ZkdGdDZxRTZVOHIrdlU4UmhHMy9SamJEcW5DOXJL?=
 =?utf-8?B?c1kvOGFKUmhjSzhtMCswWlNidUZ5UDdNNTkzY3l3ZmhLMExpS1p0aFllNmpr?=
 =?utf-8?B?N1BadlRtN09yMVJVRExpVTFkRGM0M3AzZi9IdkJoYkllZjZ6cGtZcUJKL0Jm?=
 =?utf-8?B?Ym84ejNHMWE5d3pwWUFRRm1LZlhTSHZSa3lha24wRks3NFRpS3VWMnpTZWs0?=
 =?utf-8?B?d2ZjeGkxRXlCNnZIaEZyQ1dWNUhEY2pXNGkyYk41eUhTL3l5UzJWS0JZVHZq?=
 =?utf-8?B?VFJJNWlPSXF3akZYV3pxK2V3NEJNenBDL05vd3BxZFFabnpxSlhuRUZiSWZ1?=
 =?utf-8?B?QWhsZXZacDliUUtxd3I4L1hKMVVqK1E5MlFOOE9kbHZmYmZCOU1XNkhXOTlP?=
 =?utf-8?B?Z0R5dFByTHhmZ3NPWHNmalZNZS9jSkVSSUJJVHdZZ3lWR3ZHa1hHNjdTSEww?=
 =?utf-8?B?RzQrVTlDYnNCOCtXc2N3LzN6bzY2VlJOcWl4cDhGcmRZWElzQUZXTUpOb2Vt?=
 =?utf-8?B?ZlpadTZKenBGOW9hb3ZXMkpocnpMQnBGK3pBUDJIUUlmQXhESS9KYVlHMWhV?=
 =?utf-8?B?OUxpOGZGc0hORnZBQ2J3U2NVSHA3WGk0VWNRUUVKcFh5WEsyb3ZrK01RN2wx?=
 =?utf-8?B?Z0JkcU1PM1BOV3IwT2Z5Z2VqUm5mUmNVSVpyb0Z2VUdmVWNMOTFZMHV4MC82?=
 =?utf-8?Q?M2O+6y1AweMkT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe22bca2-8df6-4393-d7cd-08d8f397d832
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 16:21:17.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8xZcO5ipbOFqTt3vd5OyaCx2MdQo5BlBE7BhuzSndm10rYDc9dDRiuCv0ZUJJQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

Alex will probably pick them up for the next feature pull request.

Regards,
Christian.

Am 30.03.21 um 17:33 schrieb Xℹ Ruoyao:
> In AMDGPU driver, the bo mapping should always align to CPU page or
> the page table is corrupted.
>
> The first patch is cherry-picked from Loongson community, which sets a
> suitable dev_info.gart_page_size so Mesa will handle the alignment
> correctly.
>
> The second patch is added to ensure an ioctl with unaligned parameter to
> be rejected -EINVAL, instead of causing page table corruption.
>
> The patches should be applied for drm-next.
>
> Huacai Chen (1):
>    drm/amdgpu: Set a suitable dev_info.gart_page_size
>
> Xℹ Ruoyao (1):
>    drm/amdgpu: check alignment on CPU page for bo map
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
>
> base-commit: a0c8b193bfe81cc8e9c7c162bb8d777ba12596f0

