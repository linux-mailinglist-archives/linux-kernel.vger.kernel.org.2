Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF09132BE77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhCCR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:29:30 -0500
Received: from mail-dm6nam08on2081.outbound.protection.outlook.com ([40.107.102.81]:15456
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1444857AbhCCNrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5SIu8iylbzKIKFAtjPeKmg4NAxarUjVm4zfRFRSO1sYGfZaWon5HYd1vsyHKucFu5Wx496HZfCbGmN0Rh++9zsKG048tfnL0R7lclgqXlW6NTEDeKP1XAXNplHBH9/nhwATgm6/Z9sLIfaZ4oBOz+jjSN15rQHVBuojNGFTWm10lmz1Nktgp1e1ITxg6RvD2IuWVH9pjX4g9wwFVeLuyIBHTadUCwBzHmvfkhlEARCOgLqYThtYoWrogh1lWbm1SAjQ7AArnw5kXhlr0Cwg1eFoj4GMOw7Mzv5XpngVJyGgAxjicToyYi6GDfxvmB6Ley0hH2KEld9N4pqJb6vvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppPJpBkaUqMzkywLpy5T7pZTZrGlwQEtSpUVZ7PiBKU=;
 b=T6Dnh4wC9FCTUBgbO7lYJhk07JoaywdaNecTD1Uv1GJH7XBjEFsZppVJGO9A9lwmzAoEdth77TPphiWOBEBo3QVTF+no9X4ShH+zTG6MENFHZaWA7lTdmO6wX4BtWwjEiMqUJpiM84soHYxDDTQ+Q0k5Tz9PwCRPb9UQ63UULHgg0flEhTtaVEsu8P8SU0MB2mfWAZCBiuA1TV1Ztjr0YLzwmMdwZBmdGC8vh64mo/8P5q7o6TNG0oj4STEH8YA5P3ipE2Ap+tjetmGITCnWTmn7HO9l7396GfEwjLel+3TMwbUh48LGfMzAw3K8rI2Z86MY0DwudZ7iLxneW/rmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppPJpBkaUqMzkywLpy5T7pZTZrGlwQEtSpUVZ7PiBKU=;
 b=Uci23cHpRjK0/XRPQRa+0cdfHMO1VC1drbIo6EnFead9e48TCGAKftHQ91LdHj/EEzz+pc60BJGxbr4LXllF5k3d53RvfzUsqDg4HzqYBZyPSc5Gg6IyxuZRMIbfzx2UlOie4euKQwR1UbftRls4g1tGoSCdxnCgXCh0MbtBCNk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 13:46:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 13:46:16 +0000
Subject: Re: [PATCH 08/53] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <20210303134319.3160762-9-lee.jones@linaro.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <09d1c92a-559f-a071-123d-bb9aa25240c0@amd.com>
Date:   Wed, 3 Mar 2021 14:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210303134319.3160762-9-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fea4:8409:66bb:aad2]
X-ClientProxiedBy: AM0PR05CA0083.eurprd05.prod.outlook.com
 (2603:10a6:208:136::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fea4:8409:66bb:aad2] (2a02:908:1252:fb60:fea4:8409:66bb:aad2) by AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 13:46:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f56512eb-f23e-430c-bcde-08d8de4ab797
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23561627C7A51D899048D4C683989@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLmFpjXSLknfTXEkw+pKzTr5yeQm+H0jRUMwodw2Na8x97YU8ItOhSEoBZdPOelRaZcAqGM4veSU21yoFtY2WQVuFw0KAeDzAEHsw+1aNSQYp0pDQ3zaxpVgtLtV8zYkqRGM+lQqpXe4HL6V/TBjpP+pfd+VOWNAfg6WlC8NpktLCrnwEkMFnjdrMt8Z3vHQkOYqKBPFHtXLqZp68vpBO9BXPhfB6GyUCPVqMARtfL4ISdb9BUTEkk2KngNwAe6JETU84BM+f2hVRvuQMGBvhbtmt4u+5efre+tyTX0SoOdQzmvqGDke2jw4cxW4ij8TTuO//+KDqH/YTjrC8L0cTP83+la5Raha1r+2XsFTiU2dRxguTN62vuJcnzdx+XRKd/SLIP4mJkmsD8224u8m8iFqYwQ+A0Pbg4+ve+q2G58sgWh/qOqP55qQeQzwfJLpat8iaYV7s4/IhqAzemhj545YlwBcZGXDDTKKbBgTMg++Q+0L2ewwsznFYHTpA96VCDOLYqblf5MlJgXqbmxIWIVKkTkXV3ZEFRA6kPhXTTRueyXhIsVoDDLaNgNKPjIzwDs2Yv2P7Y1BdmJnbGAqtjZquvFDhY+a/4zS0ZRIveY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(66946007)(36756003)(31696002)(5660300002)(478600001)(66556008)(66476007)(54906003)(2906002)(31686004)(6916009)(16526019)(8676002)(52116002)(8936002)(4326008)(86362001)(83380400001)(6486002)(66574015)(6666004)(2616005)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmVQclNXZXdjS2RGYWhCOVJhMG5kdU9oYTkrMTJ3cVpKZU9vSVRXMmt4Um1E?=
 =?utf-8?B?NkRtYTNic1VWT0Q0SXF1YkhxSzE4SndaNnZYVEtYU21WQTc5QzM3Vi93NzhR?=
 =?utf-8?B?Qy94Njl2L1FySmo5SjUwOE5weWpUektNKy9ER2lQcEN1KzVYRUNXTzhDb3Jr?=
 =?utf-8?B?N2dmaDRyM0J6dW9Sd0ZSRnV0UmRJUnRyRllpRTM5K01WTXVjZEJNazN5V2ZR?=
 =?utf-8?B?SDZ4eGFydmVad2x6U3g2Rm5mU3RJQ0pyQkRoVzltWWkrYk8vQjZrVHRzT1lM?=
 =?utf-8?B?WW5sZ1ptanp2OHcraW5FcHpRcDRsazYwdjhqczNYUnpnUENTRWVBczVpTEF1?=
 =?utf-8?B?cWdVVTM1YWlOSU5sV1B0aUN0YjJ4NU1ZWXRzb1FoeHBKZ3hxNkMzbDlJLzBu?=
 =?utf-8?B?bGZFM04wNUh6K1BrWVlDa2dRTXk3QjFHdHVTdXIwdHg3T0NBRzBkTURGM1RP?=
 =?utf-8?B?eS9hRmlId3htbUdtWCt2SkFScUtTZEo2ZnZmTWt0bXMvczVXNWYra2hTOSs1?=
 =?utf-8?B?ajhzL2dNSmRGS3ZnYit2UlZSNW5LRWxXZDhTV0JrS0toYnhQSW1Oem9PY09T?=
 =?utf-8?B?Skl5UjlWUzVPOU9OVHlhOUpvWjN2b1JDeEkwWmFKMVpwbmlFSldqMUJqbkZh?=
 =?utf-8?B?TWNMMk1heXFTNFBaZ3VRM1YrYjRvVUh3WUZXN200V2dYMUlZVFlFV2Fqby9q?=
 =?utf-8?B?M1F0aDRCOGNJdWtvWmZ1ZjNoUkJ4WlluOERxeXh3SjY0ZGJEUHl5SEVzMmJl?=
 =?utf-8?B?MSt0eDRJSXpsYXZBM1pnMWlNY0JRVVROdDF0ejhzeGgzVzRKTUxzdFZVVjlU?=
 =?utf-8?B?a1dnd2R3akdxcEp6ZlZ5dXU2WU5mYVBZcks5YVJwcXlDT3pMSnlNK1RmaXlh?=
 =?utf-8?B?UEQrVUZJMkhLYlhFdnVKMEwvVVd2VExYUG1qeGJ6MHZtcldHK2ZIZFFxaEk1?=
 =?utf-8?B?b0sxSFBteVRvbHRzU3JGcTkyVjhCRFVmZnAxUG1Sei9OTGhnV1ZTMDZseDBR?=
 =?utf-8?B?aHBkcTgwaTFJNzdVWFpZMWU0RlhRWG02ekFBdnM2VWtxeUpza1pzQjNkYVU2?=
 =?utf-8?B?ZktVNVMwSDFIVFh0YjgxeVZwMmlXY25YcmFPMDR0ZFJNUU9SUG1VL3ZOR29P?=
 =?utf-8?B?TWFteC94QmhFQWFCUTB5S2hEeUc5K1lmcm5KdThMNm1WNjNRTWlZbHZGK0pk?=
 =?utf-8?B?VDBZazVCQzlUblpwU05Na0NvMGdBci95SEhTVDVpSjBBV2ZjQTF6Sy8xMFhj?=
 =?utf-8?B?UWpkM2JQbndBMTVwL2FKQ1JvOTcyRGRHZmlpeTdHWmNNdU54N0JDVnRtSU50?=
 =?utf-8?B?aVU5UjdGbXNsWmQ0MzErd2dWU3hmWUhXdEZOajFLL3NTSGdXZkdkZkNHVjc5?=
 =?utf-8?B?Z1JZZVVmanRjeUZMZFBoSVpZbUtHSzgrNWdjeDc4MTZ4NTF0RlFuN0RtaWxU?=
 =?utf-8?B?L1BWZ1NLcE9XbEttbExMQXBvWmM1SnRDakVKWFZNbGNWQXBKc3BpdG5NdkNF?=
 =?utf-8?B?TytZdFh2ejRVU1UvdFVpZDFyZmJqanprYmFITENnSkw1cGk3OHZFdW9ud2pE?=
 =?utf-8?B?THM3V05PdWhsSG1IR2JKcFNyRjdyL214UkFoTDlYT2tIcWE0aFVKY3oxdTZ2?=
 =?utf-8?B?ZXhSRnRYek9oWDgvT29WamUzRlJKUE9ucTA0SnBnVWxtazQ5SUNMQVBSZFZQ?=
 =?utf-8?B?SjM2d1BmdU5MRk1vM2lUM2w3Vm5PVTRxaGltWGRMRmllTnF6SnpXN0prYTlE?=
 =?utf-8?B?MEVkN2gwUXhCQjdQaTZJQ3A4N25nWTNqMGpFTE1YMVowS1E5M3UyRFl1Vnhp?=
 =?utf-8?B?OXdaTk5hRDdZRnJvYUZmR1ZBYnA0SGlUOVp1Wk9QUldBQXM1dTA3czMySUx6?=
 =?utf-8?Q?emz3Mc4/qrPUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56512eb-f23e-430c-bcde-08d8de4ab797
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 13:46:16.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtoLHauCksCiS5xzKZdtEsJZnvddfF93wbtdohLEcbQCVHBtFJWc6pBj05SNQE1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I'm not an expert for the DC code base, but I think that this won't work.

This function is not allowed to sleep and the structures are a bit large 
to be allocated on the heap in an atomic context.

Regards,
Christian.

Am 03.03.21 um 14:42 schrieb Lee Jones:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 29 ++++++++++++++++---
>   1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index e633f8a51edb6..4f0474a3bbcad 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
>   	int32_t num_cursor_lines;
>   
>   	int32_t i, j, k;
> -	struct bw_fixed yclk[3];
> -	struct bw_fixed sclk[8];
> +	struct bw_fixed *yclk;
> +	struct bw_fixed *sclk;
>   	bool d0_underlay_enable;
>   	bool d1_underlay_enable;
>   	bool fbc_enabled;
>   	bool lpt_enabled;
>   	enum bw_defines sclk_message;
>   	enum bw_defines yclk_message;
> -	enum bw_defines tiling_mode[maximum_number_of_surfaces];
> -	enum bw_defines surface_type[maximum_number_of_surfaces];
> +	enum bw_defines *tiling_mode;
> +	enum bw_defines *surface_type;
>   	enum bw_defines voltage;
>   	enum bw_defines pipe_check;
>   	enum bw_defines hsr_check;
> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
>   	int32_t number_of_displays_enabled_with_margin = 0;
>   	int32_t number_of_aligned_displays_with_no_margin = 0;
>   
> +	yclk = kcalloc(3, sizeof(*yclk), GFP_KERNEL);
> +	if (!yclk)
> +		return;
> +
> +	sclk = kcalloc(8, sizeof(*sclk), GFP_KERNEL);
> +	if (!sclk)
> +		return;
> +
> +	tiling_mode = kcalloc(maximum_number_of_surfaces, sizeof(*tiling_mode), GFP_KERNEL);
> +	if (!tiling_mode)
> +		return;
> +
> +	surface_type = kcalloc(maximum_number_of_surfaces, sizeof(*surface_type), GFP_KERNEL);
> +	if (!surface_type)
> +		return;
> +
>   	yclk[low] = vbios->low_yclk;
>   	yclk[mid] = vbios->mid_yclk;
>   	yclk[high] = vbios->high_yclk;
> @@ -2013,6 +2029,11 @@ static void calculate_bandwidth(
>   			}
>   		}
>   	}
> +
> +	kfree(tiling_mode);
> +	kfree(surface_type);
> +	kfree(yclk);
> +	kfree(sclk);
>   }
>   
>   /*******************************************************************************

