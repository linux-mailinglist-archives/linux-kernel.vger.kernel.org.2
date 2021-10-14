Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D876242DA82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJNNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:35:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70068C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:33:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p16so27237117lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DX670cS5phCvDQLx3T743whZZwRjd/in8iOIX3rB6XQ=;
        b=Z3DEwQvmJ1TfKoJ2dBFXH1mqVWhkZmcioOroxnN/POQZMZ1jel2+i+jnHUsieV1XBi
         Ud6AHfJARWt7HOOIZNC2w8anCflMmLjbZNcMFzBYqNRZyVY6DDy+MWyXCvBYh/JOedbC
         ZF+jynw26e9JFpuOcCFWgzC14ntG+7mtxwvBzAfOqBV5euyIUw43Vhr9ZrzSDEYVFQNG
         0NuEIRRs/rxbCrplu44/WUoMDnw8XdU/Ak7X0PATcLSP3GcHP7nmiUr9dWUTL+HwRaBL
         mNp96K8Dgw0SL0gHRYNwW5YjkUwJD6VDkYNGHnywFdZYq3r4/zy6hmKNYT3l6ydyx1Yj
         qUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DX670cS5phCvDQLx3T743whZZwRjd/in8iOIX3rB6XQ=;
        b=Arl1OdMWC0ItUgJ0gOl8IduENpxa1Q/nmux4AvgtYWKe87sqCzjM7b6sXP3krbU0pb
         pNvImMkI53WFQTGkjLl6R7bzwjpknArWdUCD1D5/Bc/cPuQLPA6rZDlI7CL03GxOjuNs
         Y7ojTx14reWMWpMqRylpOoK12uT3fPegJUFoo6ZAqI3UllFeopdN2ws1nl0r9Kh8F8tI
         q174zAtj2IXvLoOe3Hqd3ZBiX+j4/CAvEP8Ei3bs3oB4YjADun8Q64u5iqc3z+vqku8d
         gA86h34HfFipV1DUw9aJP9yIv4zCgUl62+dy0o1q07yANdfRB0EnMsMnjjKLcYBApHja
         A1rA==
X-Gm-Message-State: AOAM531kMlyhJbc/1BA30o7H8GWLGUbZJ1icTHdVmpSfM79JOoo2jiGv
        yrOxg9h/SOFrPNKhmxx7mTh5vQ==
X-Google-Smtp-Source: ABdhPJzpDVfwZXhJGDANIIHEgLk2g2w/JDjdDth7w2YvSqUG3bjNmmV/IhBY/bheKThItFWTOUxeNg==
X-Received: by 2002:a19:7616:: with SMTP id c22mr5030684lff.450.1634218407507;
        Thu, 14 Oct 2021 06:33:27 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t20sm265427ljc.40.2021.10.14.06.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:33:27 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] drm/msm/disp/dpu1: Add DSC for SDM845 to
 hw_catalog
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20211007070900.456044-1-vkoul@kernel.org>
 <20211007070900.456044-6-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fca3eadc-91db-c5fc-110f-423efc1638ce@linaro.org>
Date:   Thu, 14 Oct 2021 16:33:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007070900.456044-6-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 10:08, Vinod Koul wrote:
> This adds SDM845 DSC blocks into hw_catalog
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> Changes since
> v1:
>   - Remove DSC_SDM845_MASK and use 0 as feature mask
> 
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index b131fd376192..6423a2fe6698 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -821,6 +821,24 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
>   	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, 0, sc7280_pp_sblk, -1, -1),
>   	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
>   };
> +
> +/*************************************************************
> + * DSC sub blocks config
> + *************************************************************/
> +#define DSC_BLK(_name, _id, _base) \
> +	{\
> +	.name = _name, .id = _id, \
> +	.base = _base, .len = 0x140, \
> +	.features = 0, \
> +	}
> +
> +static struct dpu_dsc_cfg sdm845_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400),
> +	DSC_BLK("dsc_2", DSC_2, 0x80800),
> +	DSC_BLK("dsc_3", DSC_3, 0x80c00),
> +};
> +
>   /*************************************************************
>    * INTF sub blocks config
>    *************************************************************/
> @@ -1130,6 +1148,8 @@ static void sdm845_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
>   		.mixer = sdm845_lm,
>   		.pingpong_count = ARRAY_SIZE(sdm845_pp),
>   		.pingpong = sdm845_pp,
> +		.dsc_count = ARRAY_SIZE(sdm845_dsc),
> +		.dsc = sdm845_dsc,
>   		.intf_count = ARRAY_SIZE(sdm845_intf),
>   		.intf = sdm845_intf,
>   		.vbif_count = ARRAY_SIZE(sdm845_vbif),
> 


-- 
With best wishes
Dmitry
