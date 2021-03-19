Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D7342496
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSSZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:25:33 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:19712
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230113AbhCSSZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrHmitYSQEdZEysuFOBu6BnxUNnz2U7p9gcbjRyNWjeG3OK3Xuh+5HmElYUXYWB1V0ss5F0U27fWsdz/LRJUrbzlM6B3uKxwJLFLkb0qiRuqY2/8u+8WKqSADTYLD/pKGtDJYXcS0PZB46J2TDlJehZmNJf/vNvazh92peOtHHplPQHQL1Hd3fy9FpF1n1bB2Dkjw8YKerO5SDO3S5ugpkXqQA9esTylQAd9fsmaecevjuXjr0IjBwkoduKOWGwI7F6+8dXmftnhYotyOLoHqUdh2FWMl6saUy3fvtRt7zKHLRMcmRp7LUiyWn3sc38p730BCASVbA9N5kDmY37H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPXCoGEhLkuRTQ2AqPPC32/NIYW0toBZsyeqxYvrrWw=;
 b=Yf/BW7Snjosk+jRJ0wYkdNOvamFHAAt+/EHMQNwwpL4/Xx0L8zLz6Cy3o3C51LaJOecrQxIvREY8c9c0c6AeCOMsXIQtNl5GT8FBLnvcEpigSgHL5JNAXOEbXOZlr+J4dTswJGgueX/PArOfMRJKkMBiivVPPOqYY8Blfp17QDZuuUA5VlJGBhzqXkbld6yv+55vCQpBqd16cGv8Qra3D8d9YmOPNolxsdWS+g5LRAJB1UHiqdUTMulCYSmrRuW+FvtLIwtz1Ecq5qSwHGIkpyo04yHFuyZDGFPuKBvNXiXQ2z0Z2VbmhsRi+0f6IqOdjE5V5wXCosFd79mXMjVZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPXCoGEhLkuRTQ2AqPPC32/NIYW0toBZsyeqxYvrrWw=;
 b=ZoctYrJL8Xgi6JrnOAMmmYvqJ35rrDAWSwF2pnq9CHVl7YkptnVzQ0VOl/AQqxjBiKg6kXVBxsYXZjyW99rPfQU2vM1Vq4Qoep/3Dwe9pnoRTeRWZYrQ08NO9r2J2wvswedVaoIsuzX9BiM/kqABYUTHCRf+MWdzkzExa6voYVU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 18:25:09 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 18:25:09 +0000
Subject: Re: [PATCH 08/19] drm/amd/display/dc/dce80/dce80_resource: Make local
 functions static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-9-lee.jones@linaro.org>
From:   Harry Wentland <harry.wentland@amd.com>
Message-ID: <d6248118-efb2-90dd-cf40-9cdff742a147@amd.com>
Date:   Fri, 19 Mar 2021 14:25:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210319082428.3294591-9-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Fri, 19 Mar 2021 18:25:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bf1be5b-305d-4c02-d228-08d8eb045396
X-MS-TrafficTypeDiagnostic: MW3PR12MB4588:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4588CFD0ED675771473DE8EE8C689@MW3PR12MB4588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8w16ZdPUlEOzhP1wf424+MNsV+Ec23RFrTbbSfUYSj/P4Cr21SBHVT0Xnwzi+avLSED2J+uhRDwYpBbqgN3qQCnzAUdJ96WkAdfd4Z4LZvcMJL51l5Mn2kqCx4K3Gbr3j+noX5HKV6ZPP+sH0fo0rloeEJ77Eki4ZfrXxhd0H9c/2YJAvjjlgQxt58efU3ieCkfoyPKDAnLmrV7Ow0ml/XgxdPJSGE5LR34bbNRzIsk5LlpQzMISMuc3q8GUrffsv4tgvEjNW2d3p3R5j1q8LApeIyTQHHFsimyNsav1v2Bm47eaJmjyhbSZ2QTQZAdbzqV8Y5fElAdzsHrrEjjPvTlSrDfS90MGrelG0y0UObleROWpdzUJNebGy7Z0hvdco1smASb6SiOapChVhhhmTfjhD5vzWbbmamY2Sh0nC5gUsnR2sSGl2QVeynJGkTBIUfD9Is0rvp4TeB3JUBg2mhTkUZcirH+L7k9qOQ+yXvYNcGFT6smLgQ5onPa0ztugaKZ23Y6g6U2zSIucvjYTu9l+81FHzZj61wOLpGHvgdxV496FxNEijEhXcZ3p+Yydz3Pd0phns1CuBlzgcfUaxmL064HmIpmQrAh9eF1eeSys/UUOUblx75z2PlxbNJ88JDNA8thjseA9DtDBXI6h21iD2Bb09tp/DfKGLZ4Iu5fTFbyW55q2bFvhL6Pcg6oZeeXrDzDxXCeilLoaqvZPBGA+WgDXdENphYZW+ZgtIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(186003)(956004)(16526019)(2616005)(38100700001)(16576012)(66946007)(66556008)(6486002)(66574015)(53546011)(316002)(2906002)(5660300002)(83380400001)(31696002)(86362001)(8936002)(54906003)(31686004)(8676002)(36756003)(6666004)(478600001)(44832011)(26005)(4326008)(66476007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cm8waU9wemNmS2VuNGtvUHE5enVYUmVGM2p5L1FjSWUvNmdVd1A0eDdpOENM?=
 =?utf-8?B?WnYxa0dOTHU4c05tWWVINlNXbExoaGwrSzBCZTNyK1VhMEpPdjNnY0N0UnJ0?=
 =?utf-8?B?YTU0cU1uSWFmdktvNEQ2NTQ0blR2bmR5c0Z4UXROK2tLNUlhWHJuSktUQlRz?=
 =?utf-8?B?em45RVU4K2FCSVl5NklFVEtDb0pYbVc4QlBFcEppeE8rVnJIUm5ZcHB1MTJV?=
 =?utf-8?B?Q1lNSHoxZHRJVHU5NWpEOWxIeElZMWF2K0NoRVR2OXhkVXNDR3l5WGViWFd2?=
 =?utf-8?B?dys1aVJ2WGg5Wk9XdGc2ZklGaEhtVDh4UXQxb2swTnJWa0UxWUd1QjdhTGxy?=
 =?utf-8?B?dGFpWEdUSmxvR0tLeUZIbDdNVkprVEtaQWNNMkVrNUFiTnJCVHQ3SWJEYkRP?=
 =?utf-8?B?UmhaNW8xOXNkM0JFZmdmQ0dFd1dEaVVvNi9VYlBxS0lra09ZZndLTzJmUGlV?=
 =?utf-8?B?UjNhN0gveUlOemZNTzE4RU1iNXBMWHNvallITEUwYjlJeHBWRkxqQ1UvUDNp?=
 =?utf-8?B?Mm9mbGlybWowazMxUjE3RCtvOWdkWEZKbUZwOTVNa3ZMeERFMmFoeWhnOUIy?=
 =?utf-8?B?U0w2Qjc1NkVlWHFHTFNQd3NiQjR4bTVRYlNZcHFlWlU5U05XVFZiWHRTYVZF?=
 =?utf-8?B?QVlPQTdLRE0xbFpJeVJ3L2FwbWRCalQ5aEd2azYweCtUbWE2OFBUS00xRUJl?=
 =?utf-8?B?ZDVhdzRVaUVnRmlWTCtKWUdPclJwSE05NXdEUlJHaUE1SGdvQjJPaVVwZThX?=
 =?utf-8?B?K2hIMGVmaGlFbU9Xc2hrekRtVU4vemdDdE93YkFoQnhVODJFSUlhL0svdFpG?=
 =?utf-8?B?WlNnUGVEcldsMVlHZ0tCdU8yTzFBRWRvcWZhYU84ZWRkZmh5ZU9GZnpmVXd4?=
 =?utf-8?B?TFc5N3ltZ0F6dkQvM29iSlJ1TjZHTUNnZUdsNUNnTExvRDdBeDNpWms1U2Fz?=
 =?utf-8?B?R3dKSVdreUkraGpPQk51WkRhTlhBUzZRWFdqemc1MzUrV3BWVWJ5c0tSS21i?=
 =?utf-8?B?VGhQSGw1bGdHbThGYW1QUXVaRnh4Vzc4SkptdXlPMlhiejJGQS9aZktqcHl2?=
 =?utf-8?B?eThJWU85TlR6aWpZTThvS1RSa2llSDdmdmxXV3c1Nyt6MlUxaTljVk0zM2Vo?=
 =?utf-8?B?ZllzRWZBN3FqTWY0TnQrUzdybVBPMTAxMW1NYmYzWTA2bUplckFFVWpWcUs1?=
 =?utf-8?B?RStTVmFjS1A3VVdLanBtNmVnNlgrMFR2c1pUb1R1Q3NWazl0elNlb2R4VytI?=
 =?utf-8?B?VWhRejArSE5zeG5mMkFTR202eTRCVkZ3QjJlRHBPaFNmNldpWHdSZVhRTHls?=
 =?utf-8?B?aTFNQlB6K3ZOcXF2V0RvcDZ4d1hVWWdMRVhJYUtJd1FHNmFPeVkzZ21XQklm?=
 =?utf-8?B?djd4TU1RSEJHWlhocUJ4eHZVL2tqR2xydzJXRFJGUnltUlAyYkh0cWRVbkdB?=
 =?utf-8?B?UCtvY0x6enRoemtUVTYxMEIrbUdBc2dkODEzd0tRUTFuT2ZPY0M1QjQrKzB5?=
 =?utf-8?B?MUkxWXFUdlc1K0tlOEE1TXM4WVMrK2RjbElRL0VlVVZ5MDFKcVB1OXoxL1RJ?=
 =?utf-8?B?UDNHcmxvWTBvbXBKdGFyUDE4YjdDcVRVMTFYMWJ2YUE0aUg5eHJzd0NxRXlB?=
 =?utf-8?B?T1NGWm1UVzJNMHFCaUlDZm1RbUVUSmxkM3h6Z2RqWDJDZlZTZVBQekNRWVBn?=
 =?utf-8?B?UUVqZzg1eU5namtqeGp4aWNHTys2bG16ZnNTbkRlNHA0SUhycUpHNGpJQUhN?=
 =?utf-8?Q?f9WRpAYCUPk9FZH3sz2+eDxgdGC9bf4V0dFde3E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf1be5b-305d-4c02-d228-08d8eb045396
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 18:25:08.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E7SORHnixYP6zPfU4aIQlm0ccpwVtSd1phalEO288BVBwHUImt5qiKGEA8/ZrxBqAhj2/T31wAtfs/GqkEGog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-03-19 4:24 a.m., Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:527:17: warning: no previous prototype for ‘dce80_aux_engine_create’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:565:20: warning: no previous prototype for ‘dce80_i2c_hw_create’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:581:20: warning: no previous prototype for ‘dce80_i2c_sw_create’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:715:22: warning: no previous prototype for ‘dce80_link_encoder_create’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:754:22: warning: no previous prototype for ‘dce80_clock_source_create’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:778:6: warning: no previous prototype for ‘dce80_clock_source_destroy’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:868:6: warning: no previous prototype for ‘dce80_validate_bandwidth’ [-Wmissing-prototypes]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:913:16: warning: no previous prototype for ‘dce80_validate_global’ [-Wmissing-prototypes]
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../drm/amd/display/dc/dce80/dce80_resource.c    | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 612450f992782..725d92e40cd30 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -526,7 +526,7 @@ static struct output_pixel_processor *dce80_opp_create(
>   	return &opp->base;
>   }
>   
> -struct dce_aux *dce80_aux_engine_create(
> +static struct dce_aux *dce80_aux_engine_create(
>   	struct dc_context *ctx,
>   	uint32_t inst)
>   {
> @@ -564,7 +564,7 @@ static const struct dce_i2c_mask i2c_masks = {
>   		I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
> -struct dce_i2c_hw *dce80_i2c_hw_create(
> +static struct dce_i2c_hw *dce80_i2c_hw_create(
>   	struct dc_context *ctx,
>   	uint32_t inst)
>   {
> @@ -580,7 +580,7 @@ struct dce_i2c_hw *dce80_i2c_hw_create(
>   	return dce_i2c_hw;
>   }
>   
> -struct dce_i2c_sw *dce80_i2c_sw_create(
> +static struct dce_i2c_sw *dce80_i2c_sw_create(
>   	struct dc_context *ctx)
>   {
>   	struct dce_i2c_sw *dce_i2c_sw =
> @@ -714,7 +714,7 @@ static const struct encoder_feature_support link_enc_feature = {
>   		.flags.bits.IS_TPS3_CAPABLE = true
>   };
>   
> -struct link_encoder *dce80_link_encoder_create(
> +static struct link_encoder *dce80_link_encoder_create(
>   	const struct encoder_init_data *enc_init_data)
>   {
>   	struct dce110_link_encoder *enc110 =
> @@ -753,7 +753,7 @@ static struct panel_cntl *dce80_panel_cntl_create(const struct panel_cntl_init_d
>   	return &panel_cntl->base;
>   }
>   
> -struct clock_source *dce80_clock_source_create(
> +static struct clock_source *dce80_clock_source_create(
>   	struct dc_context *ctx,
>   	struct dc_bios *bios,
>   	enum clock_source_id id,
> @@ -777,7 +777,7 @@ struct clock_source *dce80_clock_source_create(
>   	return NULL;
>   }
>   
> -void dce80_clock_source_destroy(struct clock_source **clk_src)
> +static void dce80_clock_source_destroy(struct clock_source **clk_src)
>   {
>   	kfree(TO_DCE110_CLK_SRC(*clk_src));
>   	*clk_src = NULL;
> @@ -867,7 +867,7 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
>   	}
>   }
>   
> -bool dce80_validate_bandwidth(
> +static bool dce80_validate_bandwidth(
>   	struct dc *dc,
>   	struct dc_state *context,
>   	bool fast_validate)
> @@ -912,7 +912,7 @@ static bool dce80_validate_surface_sets(
>   	return true;
>   }
>   
> -enum dc_status dce80_validate_global(
> +static enum dc_status dce80_validate_global(
>   		struct dc *dc,
>   		struct dc_state *context)
>   {
> 

