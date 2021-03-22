Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845FC344080
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:10:29 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:42465
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhCVMKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:10:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO2HlJf6CswHrYmUqApypDdhzQm+UoORzl1uQcfUeEgU1sszp/sxBKrYK/UzRTGW+kY2p6paletljGeAsz+lwC+KEsKmOGzW23lMcuFVXI7SCinaTls6Y2iTS9UeZmD3swDQq24th0MNAIJNr/5GdWwQBgX+USsrBaKpxo8QF7TjOnMIbb5yFGD8GcZ8+4D+lz0a2PWhb8v9QmICTa+6mDw5QrT/k1713ZmtWURSpXNSTptXxC52Q2uljkJwhHjPpAKxiE6EBkfOUXt8wgrwx8Q6nLy3tNK337wCDkoNR6P1aR+01uCEEraE1VeGvXkuxPVE93HHSHCgI4rsHJ38pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nm/p5xvXGjzKL2mUIwyLINlYKVwzGXwhWzn5rcknOA=;
 b=ZenD+sJALvlkOz6GAsWRGCnvl6Ts+YNkk1x23ZZbp67WmXc+Q5J+EmbUTsIv+Z8C1IBEPFmZkj+RrUuqjB3adsF3csGQ6v3kvMFo2PHHhk7TLYDv+qf6/z6fKiGGY1k851t3QFIIfkTO223PGDg7Tg7XTH2MqklqsF9pxsmmUmepQZTuynhrzafi1Ncs4Uosy/s5GuIEkqYUrF/iPh0+XnV6kfTSKP4e9CG54ZCxR28OejUYxhhNtpxJGefi4wHmV39Iiq4rj1FEonRSf/OcjnMpEHIH+FlXxBIJql4IPDx9OhFT5CNc2IcsE7BZRcm89OghwKOhlM0iBsjopsQL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nm/p5xvXGjzKL2mUIwyLINlYKVwzGXwhWzn5rcknOA=;
 b=KmGs74kHsxFrkzslDIkaDnRhbMK7UoHkFpRdn4W+RjovjrEk5qEe/up06dU9e50BvxGIQ4Gm6KyFlEjwPap3j+YK5v5yIJbc8IFJMMnh6Nez7gFxaZ4ZO0nRAbjdDH8NA7iCVSJk7deXGd4lIqFkY3m46FyPuiB3Q2HbT3Z/2uY=
Authentication-Results: yeah.net; dkim=none (message not signed)
 header.d=none;yeah.net; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:10:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 12:10:00 +0000
Subject: Re: [PATCH] drivers: gpu: Remove duplicate include of amdgpu_hdp.h
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210322120227.60953-1-wanjiabing@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <de34c5b1-1827-cc91-f719-a36a33717cb9@amd.com>
Date:   Mon, 22 Mar 2021 13:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210322120227.60953-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e345:6f8e:fa4b:2c52]
X-ClientProxiedBy: AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e345:6f8e:fa4b:2c52] (2a02:908:1252:fb60:e345:6f8e:fa4b:2c52) by AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 12:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71821be1-7f2a-4abb-989d-08d8ed2b6a7a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408DECD0650C3C5924C678783659@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlHluiudD9HW3/pU/Z2H/U/SZsJxRO5TnVSGPzMlrvZSY7Q+EkQU5RAskZtAmFGeIuUkIlZ5rmT85JfWuI+wiJH06Q/jMEBoOB9c6lPzYWZeX96baQXvYmB/fA4QEkCumpM0vGqoswemWfkMLM81+h/pG8zuS5x/6X0KOdavnbsBoNg4Y3RcxOnsMDvoWpqYXN/y4lvoq58lJhhUMLbzXIc/2085Xr7Bs0nDSGuHIDOiUyxjqTHUdAxryloyePFemuOb+Bopmg7yDtO64xspYJ8Jq/EK1YhptlplDrFojvDEirQa/X6qJHlax8SZxH5zE/0PtDOvUn54QKrnvk0W/izAnqJFsyFbwPr8pYKFhpKsz0RXWZqj200Zqskyosfy9U/09bTCRugY4gZgKmwP6458lbiNVBxJaFmRUAufKYCq3sjvMH3S6K2+LPoXxjOEsRdbKYisU0M6/AJmjNHFPKdIRA5CJbRCc5iFCz4o5zdrI+w1RHhSBfRZ+c2beDayjojNZQR5HZ9Q0G9OZAVAsnHPBaTzegmnujO5VXNHRddqajEpsGH39t8htcrnk3vdb0o+D0UGJ8mSMfVeBrnugkjevGydna+n1DvXpxHZ3lfeE3i3tCtgiHhze7mPWSBwoML4roZapYgyQMTqyPc1kPbWv+hkcB5DJqlplufkQhAdpKVPyig87luURCG5jhqCtLob2UvDSYk0tDam7kC6GLSQY8F4zWoNJOuwjqwUX2UKxx/4XV6oll4xVdVKSpG4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(86362001)(186003)(5660300002)(2616005)(4744005)(2906002)(8676002)(31696002)(8936002)(16526019)(31686004)(921005)(110136005)(38100700001)(66574015)(66476007)(4326008)(36756003)(66946007)(66556008)(316002)(52116002)(83380400001)(478600001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnhkckluQ0JjV0RNbWxHN1lyN2dQM0VaUHNmZnVvaGo3anM0WlgrWkxtYndG?=
 =?utf-8?B?NDd4aU9hdGU5SStXbnZsWkRzYjlkUnZSVk5tVUV1UXlETzVVWGp4c2NkVWVX?=
 =?utf-8?B?THJOSHJmSDRPRUdPTzZ4blRORUkzaHZ0OUIwdmxmZFFBZmpQWkJFcFl0aGpP?=
 =?utf-8?B?NVN1aEMyS2E4TzZIUmo2WlZyNGtKQzd3R2dMWVdCZDkyOVZsWUJvaWt4WUJk?=
 =?utf-8?B?dnlVTWdnN0NON3dDRFUxazZVaWxUN0pya1l5UzQvSWFTVmJtbW9lWk85VnJl?=
 =?utf-8?B?Zi9xamFXcWJ3MHJ3Mzl3Q0VXSFhOVXpyVExsTlhSdDAwWlhCMlhIM204N2VS?=
 =?utf-8?B?U2JBTUQ4NHZHNEwvN2VLcE52d05NaVhJUVhlQU5VUmhpck1uNzVxaTBkVW1v?=
 =?utf-8?B?L2FTYnQ2U2Y2eUJyUS9RZ2tYNEVxTHhxNTg1Y1BWOWJ4dHh0SHRYR2EzYkZq?=
 =?utf-8?B?Mm43TUZaVG5LTXhGTHIvQlIrbFJKUUdUNzhYM1hZL2ZKN2xNRHAwYTF1Zkxj?=
 =?utf-8?B?RjVueHkyNDNrQUlManl3elBPSVg1YWw3S1lneFUvNzAxSm9QdENCK28zcXVL?=
 =?utf-8?B?N21UZFh6UWdiN0hSc1RTSlBJTHRndFQxK05Va0ZFdDVDOEVEdWFQV1l3a1RX?=
 =?utf-8?B?eWc5MjlXSU5mQWRjZElKNmsyakdtajlpMTZUZDBVVk5heSsrazZaQmhCdHNV?=
 =?utf-8?B?bWZXWnNpV01YZlVHN0NROHFBd0F1SEFjUHNMMlZlbHRCM2hCSWZUZ3dHRDlk?=
 =?utf-8?B?cUU2K29uQitCSnd6YXlZcVpPVUlIdnQ3MENGYUFxaHd5UDBHQURxYlZiZXRk?=
 =?utf-8?B?eFZ2NTZBZVVKM3Q5KzJlemlsUndQT2xwS0I5OGZxeTNKRXZWS3JUMXdUbGVL?=
 =?utf-8?B?bHZlRzQxWWJLNkVFTDJ4Ly96TzQ0bngyRStsdmNTajlXbUwwT211MG9hWDM1?=
 =?utf-8?B?UWFMWXZCcGQxZmJRZXRqWWM2L3oxeWxzc2VsMlBmOUVLZ3Y3V3dBaEsyMUZj?=
 =?utf-8?B?R25kQWtMYkZ2OE9PNUJlOVVsYTdIaXB4TnI0SHFxaFdpci9VLzVoRnhrTmRO?=
 =?utf-8?B?ZGFkNVNEdXR6RDZhYmU2N2FyL3oxLzVjY2U3TTZSSThCWlJPc3pSeGlycVdP?=
 =?utf-8?B?cldTRURqZFJDYkFkNlRZNE5jQzhBQWRvTEFROERQc3dXRVhaaVlLa0Y0cUNs?=
 =?utf-8?B?RVAzNkxGLzBia3haQk5xcUMxdlp2RlMybDNoT0U3VVhxR3pScGZBTGlUZDh6?=
 =?utf-8?B?QjhVcmNuK1gzTm11NjFiaWJpNmVXMTA2QTlWeHpUenhqNiszOUpML01wY3V1?=
 =?utf-8?B?bGlJQ2xGUFB2OVBrQmhqTys0bURHM3NMUUhpQU9CRmQ4Y2hGckFCTmVBdFZY?=
 =?utf-8?B?TUZ2YjI3RTN5S3hFV1hXdXlmZldhNFhJZXhxYUhEbHBXNzNHZkNLNmNpZkVQ?=
 =?utf-8?B?alJiSFR0QmlxUGY0OUl3SDhNdTZzcDUzTy9CbDZ4UndQa2dFcnlVM2hMekps?=
 =?utf-8?B?WDIrZUFVR0ppZXZHdndmWnRQVDRPcWtNY1NxY0w5bVpnV2FGaUJYZzBnTGNj?=
 =?utf-8?B?MHBIYUJQWVFKRittSE53dVIzUDZFSGFUMTUycTBTMzMzcG1vaUxwK3VpK1lt?=
 =?utf-8?B?MVl5RGdQRjYxMTJ1OWNwQ2hJNVpTMmkxTWZMUTdaMG55dkU3NEJoalV3VUNu?=
 =?utf-8?B?aExqWUlvSjVJMnZtZ3JMMDRtQkVtUzVwdWtTVm1vK1hCTk43cHdVZldVR3lG?=
 =?utf-8?B?YlJhRG13NGk5WTFTUis2V1Q3RGdHR09qZ1dSSUw1SDlRSHhlZHZYc2FqdDNL?=
 =?utf-8?B?YXJHcDZaUlZMbjZoRnR5SmUzdEJEMER6R25wVmtncHB5SzJFQityZnVpK0M3?=
 =?utf-8?Q?xKU2P4cdNaJrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71821be1-7f2a-4abb-989d-08d8ed2b6a7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:10:00.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxFl/rEfF+ZOGIbqp5F8+86XLbSVYzdua/DIZey9yOQRPpf6Yw6UjYxEA0ZOFAGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 22.03.21 um 13:02 schrieb Wan Jiabing:
> amdgpu_hdp.h has been included at line 91, so remove
> the duplicate include.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49267eb64302..68836c22ef25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -107,7 +107,6 @@
>   #include "amdgpu_gfxhub.h"
>   #include "amdgpu_df.h"
>   #include "amdgpu_smuio.h"
> -#include "amdgpu_hdp.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   

