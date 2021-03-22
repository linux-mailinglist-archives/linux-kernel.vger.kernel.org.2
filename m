Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F006A343AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCVHl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:41:27 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:36736
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229993AbhCVHk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adZq1ZiiNQKyJUTQOxjZcqejNwfbBBh3j+u0FNfwLf6488kkf7a4+v3ggVoyp6ulKS9i6DaTB6tn8IsvpHnswLw3nBxH51JnvaCrVXt/gq7Lu2jl7NsPZ4NSLGacqCUUD+CZnFadAsy7izP+m0tyIN5VHwqSrSvdC76C05aeqV+rIoCFaAi9lqExZMDWWEmjHzHTFbZ/mtEBvpj1ejj6Sjb/8cjWNF413L9TNhh9IL006wdNht3N6PbzEdSJpF9XI/aKhvRjLYbYSpfj6KaaJzxFZwCIMyTuZLi/GGc/PSseQOQ2t3XNG+JsBy8l25ARUp5SPdhjl1UO+3uIPL/YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKFIcEkCTVtadf7yiLbe8kqzTRHCS+Seg7bUjJ/Zs8s=;
 b=AF3Jhm6cbiBA6sf+SYjYKRWxmBaI6j2fECCkBik/bC72mGF2XdpBEEoBx0J/J09DHNGCrygS7/fDXxUe1a4h8XCFudI5GxkhaqWd5fkxQdPdJ0KSSYUvfd50N+/gKcZy+3z37hOof/ah3Id8xSV39WVGi9hUF//2IGguh4MT0KWRSsI91BgrQHU8D9KrQs7v04U+/3mE5EI2fUM3SEV5lvCWOaa7g2QyqzDsH1A0y3XbpzTuGU3G9fUb5VwPCcn5LoJuw2v2TZT+7/607fJcA5GI9PVF1CvTOkY2Zev/ZFu2RG8gJTtfE5uxl/YL8FEaklGJ7i3nN+tKUsR68JGB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKFIcEkCTVtadf7yiLbe8kqzTRHCS+Seg7bUjJ/Zs8s=;
 b=gRSJ0CQoIIUOBBCQ+svLjsPptVRgOzole04C9qwRHhC6px9UxIlSLfRaiMWaIi3Qn7aCEVjRQzesPqy5k3eQ6q+pR+/YpTRlKZq5hjY7CoR6sQ9VMP7y1l3pQ6fmneeDcjGDgo8d5cUHrVvwpnwUM261Xmzu15x5ikZYaMN1dhU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 07:40:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 07:40:53 +0000
Subject: Re: [PATCH v2] drm/radeon: don't evict if not initialized
To:     Tong Zhang <ztong0001@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210321151907.367586-1-ztong0001@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <259c234f-ca6a-7f9a-8df1-69055f2fc1b6@amd.com>
Date:   Mon, 22 Mar 2021 08:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210321151907.367586-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e345:6f8e:fa4b:2c52]
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e345:6f8e:fa4b:2c52] (2a02:908:1252:fb60:e345:6f8e:fa4b:2c52) by AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 07:40:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d96178c-1e47-46f7-2014-08d8ed05d0e7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048B4D3EF6CF20DC5C0796F83659@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drYmQrcW48AeYgUcaJBakhis6LhPmoR/KFKyzyrP5JCwB7mrD1hw/suaeINMv3ryVvaHMDYv45+0fZhEadmRWsHxGfK++5dOPB9MA7URYwwmahftwFid2Mb7bE+dEL65CilF4zlLJYt1jqCSRwtSJZHen7uEqp32gDG4Y0l0eQh15QfUw39jZ+OJF3sFqBMnPQtkywig/48lCZgZylIgJMqR13Bi4jkR03cV0YEc4PmEvqbDpl0ST42A/KD3ehuK1RXuKlc+r1ZfMWv/UCDzUk3IrD9VuG5M6ykXcyAk/EexAfYshkCvsy2ZjuiX0krBqQq5wrJT1zWdy/bdSXHBMo2LJRG6pdtX2ZAExsvVH4EiwPlabboM6GNH1yRdRXibhiS2pCRgf5pfrAFxhyM2/TMpsmN1uvuc/AUXz/LosHgEMY6Gj+6FVk1hxy8ghmKz9MpEqamQ3wfeRd2bnRr58/he9MUW7R/O43RuVwCVvA0IY5E+bLBJb6+O4wexUMqUu8so5D7nTKfImUmvgN0Dl0eiQSDjzTq/bRT5fMUF179nN+q7WfTKXqYf3ZdTvjVxkO13rZlfvYSI6P2BNCCUee7ubDwhzRsFNRXkTLVzD81IagyJh1goSdnGH9xYMcu/83vcS2TJbzc6ZqD3vYAQ8PGZgNn0m2AHxvwDFHdiGL2Lmtv5F/kUqM3ugA5YA3H8ZE4bUVsTrtbPIU3wZH0lWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(66556008)(36756003)(38100700001)(478600001)(186003)(66946007)(52116002)(16526019)(86362001)(8676002)(5660300002)(8936002)(66476007)(83380400001)(2906002)(316002)(6666004)(31696002)(66574015)(110136005)(2616005)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWlrVVZDbFZKWW5tUFJBcHluV09MQVJ2dWhDa3Z1dmtQQVB5SjRUaUdibm44?=
 =?utf-8?B?S0NQbEZna283UDAwZjZVZFg3VXRCd01SVzFLU2svQlN0TVdCNlpSb2lNb2JL?=
 =?utf-8?B?cFAxblh6VWhDWnk1QzZBeU9BVWU4SzdocnEydzdMQnQ1TnJobWlVenhNdDUw?=
 =?utf-8?B?VzYxemQ3OEhxNXZSdm56YnRVV1RlQ25vYkhKR2ppUUpmL2JZNFc3M1JWQ2d2?=
 =?utf-8?B?M0g0SW9xM2UvZm9RTDJWZTlvc2JHcVBuSm53WHBCSUZ3d3ppSGg0aWtUZVVM?=
 =?utf-8?B?d3JpdUNNTUpkYUtwLy9EbmZPaWdEQnFWOVp3MHgxdnR4U2x6SXVDMkJoMVlU?=
 =?utf-8?B?Y3FsaEJhU2h3RUVrOXhpOG9Id1hzaTFRdmt3Y1d6cy95NzNVR1dWekJlVERE?=
 =?utf-8?B?eDFXZUtDY1cxaUtsUmxlNWNjclZweUQrZ0o2WnovVXlqVGRRQVhVajBGVTFY?=
 =?utf-8?B?alJXNmx5ckNRbW02bnY5Y05hYmI1N041Y1JFckczanlTU1pmK3pWTEdFdzdZ?=
 =?utf-8?B?Q2ZhVWJpVmZqK1pYM2duU3I5cTVIT0NrdWVxQlBEaW5oQ1YyRnJHYUU0YWtW?=
 =?utf-8?B?T1Rra29EaHlTQXAwTTV0QkVJVkF0SXE1M0ZiMGFMNloyUUNzUTVTZkxSSjVY?=
 =?utf-8?B?bzRyTmtveE9kdFZ3bjNoVEdjU3BMR04yOWxkZ3ZyNURjamYvTHNkWVBvTVM4?=
 =?utf-8?B?ZG1vY2ZQUXR4bGFjbVNUNHJ3bkFlY1NPUCszdGs3TFN5akFNWXVNTlh0a0I5?=
 =?utf-8?B?YWZITlBETkFQUFc5bUZWelBWeHd3SVV4ZWFJVTNKbTdsSEZMUmZqdWlkNW1I?=
 =?utf-8?B?Z0MvaXd2MllGZ2xkbDFOQUdxOFFFaXFnMzB3T2dubDhrT2RjNTNrUk8vN216?=
 =?utf-8?B?NWUxZWdlRzhnWVhlb2tuU1BXc2ZXMkQ2K0xETXRKdGVmejFxZVdrWHpuenNt?=
 =?utf-8?B?S0JsL2pKN0txNUNZbWw3UG12OE9xano1RlFyaHNLN3Q0R1JHTUlwMzluYkhD?=
 =?utf-8?B?SExMelI0TGtLU09PNFNHYzF3ZVBhUnpEYTJzbzRaWTZFUG9MeGRYNTVYekV1?=
 =?utf-8?B?NklYcDc4S016VTU5OUZmNjE4ODBYd2psL0lFKzBVNXpmUUpzVW9vTmorRXZ0?=
 =?utf-8?B?TThKODcra3RnTXkzWVlkVE15TlYxcEVicURjT2ZybHRISTdlTDJHS1RmZGUy?=
 =?utf-8?B?L1crN2ZVeUZyZlg1VDJrKy9jNndOcDBadGozc2pYRk8zVFhNVXR1YWJvTlpT?=
 =?utf-8?B?amR2WEN2WkFxZW9RNENaeUNWRWVCaE9PTUZid3hMWC9tSVZYcDhJQjI3RlZT?=
 =?utf-8?B?aDgyNDhxOCt3aGJWa1YwVXpzUUpQUldEQnFUYjd3RVRWTmh5bTh0Rk9rWEJr?=
 =?utf-8?B?UmxTMlF5TStkM0UxMmVNWXVqY2hiTm53eGIvTXhYbzZVeVYzMDNUMnl5T0tJ?=
 =?utf-8?B?YkNtcS9USTR3aXo0Y1h1aGJNRnFLY2RyUmsxZWN4VEJQc2VuN2tQdTJ3ZCth?=
 =?utf-8?B?VTFtNmZsbWs0dU9LaUo2MkF3WTJlQmpyK3ZBZG41dVIya1dXZmJ0Wi9NOTFl?=
 =?utf-8?B?S3VDS0lCWFg2Wjcrc1JmMzhibzFZNmk5YW9QenlpdDZjb0hMRnNiVndrYlNN?=
 =?utf-8?B?L1ZuS3Rodzc0QmlLRWhEb2VDTGdYZk1wMjBBdWdmUnhPUEpvV2NVQlo0OXJ5?=
 =?utf-8?B?VG9TRmx1Qkx5TzZUUEZiSEdtSTJEQ0FBZFg3SG1Nc3BGaUFmbjM2cjlRS2dE?=
 =?utf-8?B?elQreWF2eS90QmhRYnZiZ29KNTBWK3Zxc09iL0tCN2JxTzkzRkNUOVF2N0ZF?=
 =?utf-8?B?M1RvQnBQcEd4S0xwdFFHTHkwTzJjRWwyTVBkb3pHUTBUakVUcENjNjJMeXEy?=
 =?utf-8?Q?UoNO6j/x7QTJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d96178c-1e47-46f7-2014-08d8ed05d0e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 07:40:53.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6wReA1elZHla9VRkkz1uCWr1Q0zebwo4uTGAuZD2h5R6YGl/qGo43OvdaqFAFPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.03.21 um 16:19 schrieb Tong Zhang:
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
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: coding style fix
>
>   drivers/gpu/drm/radeon/radeon_object.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index 9b81786782de..499ce55e34cc 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -384,6 +384,8 @@ int radeon_bo_evict_vram(struct radeon_device *rdev)
>   	}
>   #endif
>   	man = ttm_manager_type(bdev, TTM_PL_VRAM);
> +	if (!man)
> +		return 0;
>   	return ttm_resource_manager_evict_all(bdev, man);
>   }
>   

