Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F0437BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhJVReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhJVReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:34:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946A7C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:31:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so5302687ott.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NdCcEj3PQ1bSpldMjLwEN3JoStNQD+ubKy36Yp9mF0M=;
        b=q0LQrc/wGBXmiKj/RyHesnEzYh8mTjgiOvYHpCpRd2RT4zjdU+KBicZlik3m88fT+g
         tDAamMRVWB6jedcWTZqwxsxaz/bYrkO24u7s2BEslArhCjdsoW8dIb9UTHsJiaMw6PJ7
         Ao5asku6lZxVZNSsIbBM+pVVFra4C/+/mwguONcV8fF7BiZsRReLjbSN2K5aA41vhyuc
         6um0mtTqjkYsPP9h3UfRavzth5DSnWcJ9z9uxDZlJrePphgdK1286AO/Tox+GRvJcZ8j
         4uXqvHZ870D27w1iigPbPghKCh8AIPWXxdkq8gngDCXTEXMqz5yQip+kE65bGDqyHgVq
         fh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NdCcEj3PQ1bSpldMjLwEN3JoStNQD+ubKy36Yp9mF0M=;
        b=QdHyy0tTLzJuw+LK/c10H+v83y7kCT4GL8dL4toTV/q9dFcLUnbuGNaMmS/LSC6T/g
         EyjaeqsedZPdtS6m+jmcbqFzRBMYubkGwtMVZ3rTNIiRWiJPhNiNHY4HdorDvzQeKsHp
         uCilq2AnY2FpxVPO9yZ79uxxeDkNAd8C09CLvoEUZTMEKNGwjv6KuCMsz8WAPx3c4CFO
         jbRtbCeZVm4ATg1Qxe1uSmFifTvgQZ8SbjrtrhAOJq7+CKP7wmjn4NKOvpq+G7eyRpay
         WrnegpdJymuQU8INe9MwyRgFlyDjMf7wThhRkFE8B+Tr7ztTI2pMwPrHDCIe+WViqmOf
         mUrQ==
X-Gm-Message-State: AOAM530bKqgCTy2PGbVBYw3gQq9clsRlp0Wvo8FUSDbIK9DBLaYnZTWP
        HcJ259KmHP3g22428f/dzWOvFA==
X-Google-Smtp-Source: ABdhPJzqDb4w+uJkD0GXRjIt+ZwbZP7VGzGbNvmmxXex3ghcbB07uJWFLlHB8h7If8Bvg2c5Ao6JWg==
X-Received: by 2002:a05:6830:2466:: with SMTP id x38mr949048otr.339.1634923907844;
        Fri, 22 Oct 2021 10:31:47 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q15sm1733708otk.81.2021.10.22.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:31:47 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:33:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Lypak <vladimir.lypak@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a5xx: Add support for Adreno 506 GPU
Message-ID: <YXL16V17upehvUwt@ripper>
References: <20211022114349.102552-1-vladimir.lypak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022114349.102552-1-vladimir.lypak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Oct 04:43 PDT 2021, Vladimir Lypak wrote:

> This GPU is found on SoCs such as MSM8953(650MHz), SDM450(600MHz),
> SDM632(725MHz).
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 34 ++++++++++++++--------
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 ++++
>  3 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 5e2750eb3810..249a0d8bc673 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -441,7 +441,7 @@ void a5xx_set_hwcg(struct msm_gpu *gpu, bool state)
>  	const struct adreno_five_hwcg_regs *regs;
>  	unsigned int i, sz;
>  
> -	if (adreno_is_a508(adreno_gpu)) {
> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu)) {
>  		regs = a50x_hwcg;
>  		sz = ARRAY_SIZE(a50x_hwcg);
>  	} else if (adreno_is_a509(adreno_gpu) || adreno_is_a512(adreno_gpu)) {
> @@ -485,7 +485,7 @@ static int a5xx_me_init(struct msm_gpu *gpu)
>  	OUT_RING(ring, 0x00000000);
>  
>  	/* Specify workarounds for various microcode issues */
> -	if (adreno_is_a530(adreno_gpu)) {
> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a530(adreno_gpu)) {
>  		/* Workaround for token end syncs
>  		 * Force a WFI after every direct-render 3D mode draw and every
>  		 * 2D mode 3 draw
> @@ -620,8 +620,17 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
>  
>  static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  {
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	int ret;
>  
> +	/*
> +	 * Adreno 506,508,512 have CPZ Retention feature and
> +	 * don't need to resume zap shader
> +	 */
> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
> +	    adreno_is_a512(adreno_gpu))
> +		return 0;

Afaict all other changes in the patch adds a506 support, but this hunk
changes a508 and a512 behavior.

I'm not saying that the change is wrong, but this hunk deserves to be in
it's own patch - so that if there's any impact on those other versions
it can be tracked down to that specific patch.

Thanks,
Bjorn
