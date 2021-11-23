Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C461945AE89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhKWVkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:40:01 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:43536 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:39:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637703400; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: References: Cc: To: From: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=ZxlavI9NbXcvLJaF6cvSXVVud5NqFFeoEpqcsDMej1E=; b=R3MXgopPXWg4007XwXzxiI645VguMaadmk+BOCJl46qRGwIMr2CqEZfepyraqoxc8Tp+qXFb
 OoV8eYlsobT1039BR/iEF4dYrxb3BoLzpwBLFKm42ynVuevqQ4Too6DlJp33amI6nJs9qjds
 HnMLUVo8n6ZuJAxvMZd87NOjIYo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 619d5ee7bebfa3d4d58cdf15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Nov 2021 21:36:39
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A597C4360C; Tue, 23 Nov 2021 21:36:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.5] (unknown [117.211.32.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C484FC4338F;
        Tue, 23 Nov 2021 21:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C484FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <5c8e8c7a-46d0-62b0-e730-cc5b980cc21a@codeaurora.org>
Date:   Wed, 24 Nov 2021 03:06:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 6/6] drm/msm/a6xx: Add a few gmu buffers to coredump
Content-Language: en-US
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Douglas Anderson <dianders@chromium.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
References: <20211124024436.v2.1.I2ed37cd8ad45a5a94d9de53330f973a62bd1fb29@changeid>
 <20211124024436.v2.6.Ibfca354efaf274142593a6dbfbedb3de31918ff6@changeid>
In-Reply-To: <20211124024436.v2.6.Ibfca354efaf274142593a6dbfbedb3de31918ff6@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/2021 2:47 AM, Akhil P Oommen wrote:
> Add a few more gmu buffers to coredump to help debug gmu
> issues.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 157 +++++++++++++++++++---------
>   1 file changed, 108 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index e6f5571..0cb6551 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -13,12 +13,22 @@ struct a6xx_gpu_state_obj {
>   	u32 *data;
>   };
>   
> +struct a6xx_gmu_state {
> +	struct a6xx_gpu_state_obj *registers;
> +	int nr_registers;
> +
> +	struct msm_gpu_state_bo *log_bo;
> +
> +	struct msm_gpu_state_bo *hfi_bo;
> +
> +	struct msm_gpu_state_bo *debug_bo;
> +
> +	struct msm_gpu_state_bo *mem_bin_bo[2];
> +};
> +
>   struct a6xx_gpu_state {
>   	struct msm_gpu_state base;
>   
> -	struct a6xx_gpu_state_obj *gmu_registers;
> -	int nr_gmu_registers;
> -
>   	struct a6xx_gpu_state_obj *registers;
>   	int nr_registers;
>   
> @@ -42,7 +52,7 @@ struct a6xx_gpu_state {
>   	struct a6xx_gpu_state_obj *cx_debugbus;
>   	int nr_cx_debugbus;
>   
> -	struct msm_gpu_state_bo *gmu_log;
> +	struct a6xx_gmu_state gmu_state;
>   
>   	struct list_head objs;
>   };
> @@ -777,20 +787,21 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
>   {
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>   	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct a6xx_gmu_state *gmu_state = &a6xx_state->gmu_state;
>   
> -	a6xx_state->gmu_registers = state_kcalloc(a6xx_state,
> -		2, sizeof(*a6xx_state->gmu_registers));
> +	gmu_state->registers = state_kcalloc(a6xx_state,
> +		2, sizeof(*gmu_state->registers));
>   
> -	if (!a6xx_state->gmu_registers)
> +	if (!gmu_state->registers)
>   		return;
>   
> -	a6xx_state->nr_gmu_registers = 2;
> +	gmu_state->nr_registers = 2;
>   
>   	/* Get the CX GMU registers from AHB */
>   	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[0],
> -		&a6xx_state->gmu_registers[0], false);
> +		&gmu_state->registers[0], false);
>   	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[1],
> -		&a6xx_state->gmu_registers[1], true);
> +		&gmu_state->registers[1], true);
>   
>   	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
>   		return;
> @@ -799,31 +810,46 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
>   	gpu_write(gpu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
>   
>   	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[2],
> -		&a6xx_state->gmu_registers[2], false);
> +		&gmu_state->registers[2], false);
> +
> +	gmu_state->nr_registers = 3;

This is not required after rebasing on top of:
https://lore.kernel.org/all/20211103153049.1.Idfa574ccb529d17b69db3a1852e49b580132035c@changeid/

-Akhil.

>   }
>   
> -static void a6xx_get_gmu_log(struct msm_gpu *gpu,
> +static void a6xx_get_gmu_bo(struct a6xx_gpu_state *a6xx_state,
> +		struct a6xx_gmu_bo *gmu_bo, struct msm_gpu_state_bo **dest_bo)
> +{
> +	struct msm_gpu_state_bo *bo;
> +
> +	bo = state_kcalloc(a6xx_state, 1, sizeof(**dest_bo));
> +	if (!bo)
> +		return;
> +
> +	bo->iova = gmu_bo->iova;
> +	bo->size = gmu_bo->size;
> +	bo->data = kvzalloc(bo->size, GFP_KERNEL);
> +	if (!bo->data)
> +		return;
> +
> +	memcpy(bo->data, gmu_bo->virt, gmu_bo->size);
> +
> +	*dest_bo = bo;
> +}
> +
> +static void a6xx_get_gmu_state(struct msm_gpu *gpu,
>   		struct a6xx_gpu_state *a6xx_state)
>   {
> +	struct a6xx_gmu_state *gmu_state = &a6xx_state->gmu_state;
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>   	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>   	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> -	struct msm_gpu_state_bo *gmu_log;
>   
> -	gmu_log = state_kcalloc(a6xx_state,
> -		1, sizeof(*a6xx_state->gmu_log));
> -	if (!gmu_log)
> -		return;
> +	a6xx_get_gmu_registers(gpu, a6xx_state);
>   
> -	gmu_log->iova = gmu->log.iova;
> -	gmu_log->size = gmu->log.size;
> -	gmu_log->data = kvzalloc(gmu_log->size, GFP_KERNEL);
> -	if (!gmu_log->data)
> -		return;
> +	a6xx_get_gmu_bo(a6xx_state, &gmu->log, &gmu_state->log_bo);
>   
> -	memcpy(gmu_log->data, gmu->log.virt, gmu->log.size);
> +	a6xx_get_gmu_bo(a6xx_state, &gmu->hfi, &gmu_state->hfi_bo);
>   
> -	a6xx_state->gmu_log = gmu_log;
> +	a6xx_get_gmu_bo(a6xx_state, &gmu->debug, &gmu_state->debug_bo);
>   }
>   
>   #define A6XX_GBIF_REGLIST_SIZE   1
> @@ -961,9 +987,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
>   	/* Get the generic state from the adreno core */
>   	adreno_gpu_state_get(gpu, &a6xx_state->base);
>   
> -	a6xx_get_gmu_registers(gpu, a6xx_state);
> -
> -	a6xx_get_gmu_log(gpu, a6xx_state);
> +	a6xx_get_gmu_state(gpu, a6xx_state);
>   
>   	/* If GX isn't on the rest of the data isn't going to be accessible */
>   	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
> @@ -1005,9 +1029,16 @@ static void a6xx_gpu_state_destroy(struct kref *kref)
>   			struct msm_gpu_state, ref);
>   	struct a6xx_gpu_state *a6xx_state = container_of(state,
>   			struct a6xx_gpu_state, base);
> +	struct a6xx_gmu_state *gmu_state = &a6xx_state->gmu_state;
>   
> -	if (a6xx_state->gmu_log && a6xx_state->gmu_log->data)
> -		kvfree(a6xx_state->gmu_log->data);
> +	if (gmu_state->log_bo && gmu_state->log_bo->data)
> +		kvfree(gmu_state->log_bo->data);
> +
> +	if (gmu_state->hfi_bo && gmu_state->hfi_bo->data)
> +		kvfree(gmu_state->hfi_bo->data);
> +
> +	if (gmu_state->debug_bo && gmu_state->debug_bo->data)
> +		kvfree(gmu_state->debug_bo->data);
>   
>   	list_for_each_entry_safe(obj, tmp, &a6xx_state->objs, node)
>   		kfree(obj);
> @@ -1210,31 +1241,43 @@ static void a6xx_show_debugbus(struct a6xx_gpu_state *a6xx_state,
>   	}
>   }
>   
> -void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
> -		struct drm_printer *p)
> +void a6xx_gmu_show(struct a6xx_gmu_state *gmu_state, struct drm_printer *p)
>   {
> -	struct a6xx_gpu_state *a6xx_state = container_of(state,
> -			struct a6xx_gpu_state, base);
>   	int i;
>   
> -	if (IS_ERR_OR_NULL(state))
> -		return;
> +	drm_puts(p, "gmu-log:\n");
> +	if (gmu_state->log_bo) {
> +		struct msm_gpu_state_bo *log_bo = gmu_state->log_bo;
>   
> -	adreno_show(gpu, state, p);
> +		drm_printf(p, "    iova: 0x%016llx\n", log_bo->iova);
> +		drm_printf(p, "    size: %zu\n", log_bo->size);
> +		adreno_show_object(p, &log_bo->data, log_bo->size,
> +				&log_bo->encoded);
> +	}
>   
> -	drm_puts(p, "gmu-log:\n");
> -	if (a6xx_state->gmu_log) {
> -		struct msm_gpu_state_bo *gmu_log = a6xx_state->gmu_log;
> +	drm_puts(p, "gmu-hfi:\n");
> +	if (gmu_state->hfi_bo) {
> +		struct msm_gpu_state_bo *hfi_bo = gmu_state->hfi_bo;
>   
> -		drm_printf(p, "    iova: 0x%016llx\n", gmu_log->iova);
> -		drm_printf(p, "    size: %zu\n", gmu_log->size);
> -		adreno_show_object(p, &gmu_log->data, gmu_log->size,
> -				&gmu_log->encoded);
> +		drm_printf(p, "    iova: 0x%016llx\n", hfi_bo->iova);
> +		drm_printf(p, "    size: %zu\n", hfi_bo->size);
> +		adreno_show_object(p, &hfi_bo->data, hfi_bo->size,
> +				&hfi_bo->encoded);
>   	}
>   
> -	drm_puts(p, "registers:\n");
> -	for (i = 0; i < a6xx_state->nr_registers; i++) {
> -		struct a6xx_gpu_state_obj *obj = &a6xx_state->registers[i];
> +	drm_puts(p, "gmu-debug:\n");
> +	if (gmu_state->debug_bo) {
> +		struct msm_gpu_state_bo *debug_bo = gmu_state->debug_bo;
> +
> +		drm_printf(p, "    iova: 0x%016llx\n", debug_bo->iova);
> +		drm_printf(p, "    size: %zu\n", debug_bo->size);
> +		adreno_show_object(p, &debug_bo->data, debug_bo->size,
> +				&debug_bo->encoded);
> +	}
> +
> +	drm_puts(p, "registers-gmu:\n");
> +	for (i = 0; i < gmu_state->nr_registers; i++) {
> +		struct a6xx_gpu_state_obj *obj = &gmu_state->registers[i];
>   		const struct a6xx_registers *regs = obj->handle;
>   
>   		if (!obj->handle)
> @@ -1242,10 +1285,26 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>   
>   		a6xx_show_registers(regs->registers, obj->data, regs->count, p);
>   	}
> +}
>   
> -	drm_puts(p, "registers-gmu:\n");
> -	for (i = 0; i < a6xx_state->nr_gmu_registers; i++) {
> -		struct a6xx_gpu_state_obj *obj = &a6xx_state->gmu_registers[i];
> +
> +void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
> +		struct drm_printer *p)
> +{
> +	struct a6xx_gpu_state *a6xx_state = container_of(state,
> +			struct a6xx_gpu_state, base);
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(state))
> +		return;
> +
> +	adreno_show(gpu, state, p);
> +
> +	a6xx_gmu_show(&a6xx_state->gmu_state, p);
> +
> +	drm_puts(p, "registers:\n");
> +	for (i = 0; i < a6xx_state->nr_registers; i++) {
> +		struct a6xx_gpu_state_obj *obj = &a6xx_state->registers[i];
>   		const struct a6xx_registers *regs = obj->handle;
>   
>   		if (!obj->handle)
> 

