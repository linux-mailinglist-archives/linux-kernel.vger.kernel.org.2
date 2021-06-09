Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272573A0E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhFIIDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:03:52 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45951 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbhFIIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:03:20 -0400
Received: by mail-wr1-f42.google.com with SMTP id z8so24341292wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=G2EK7hq7OuAZ8vK1o6rU1XG0kTRV9Kntzv3xlza+n0A=;
        b=QfFOHuv40ZGJkmXc7S7b/QxXuUItWu1HFIvmg/6K2HiGj6AdgllxXtIKShavGF4sF7
         A+YU1CCxsSxAO2qnWKJ1wAaajH7OkrQEjRcshVZESRYj3zFVS08MWDZI4+FHfXOrpAqR
         AbWSwSWt7iPxkW4lVLzCKLC/VAytorCFe+A13wcDv1UNel4sxRb2kADMMXTLwt7CApMC
         N9O+Bqmyx1FDzxa1+LX7aevzSKZn9mYrvW8Kk15N5N4vibIHU38CZF29zv2YImIppEKp
         8jXFmJJmyLqbENa/3dzXA3XsxefpI2yBOaiuh1Qw3xwlaFyTNFmFJPsSxVOPo8SPMD7u
         U5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G2EK7hq7OuAZ8vK1o6rU1XG0kTRV9Kntzv3xlza+n0A=;
        b=MMAGbmy76T3cxhlXQCvhXIcAOTgNdNYxO++SS/q8R+ge+bVNRWfdWRf5B5zR7p5lP5
         L3twEZe3CjBIGVAKM++Z5F9R7xVMYmg4h1r1wwMmrgRiSXq3mV2yFSKAhEaDR4ftXvjY
         QKWz4udWxEDsYLmtZ8WsPotgP1VkFrenVbT5Sqh8PcUxgV6iBJ0teOQzlOQx9u58K9X7
         Pz/L4xnhZDZgWPxvhpKLVInW07izBTR264Hy2nWpnYyi0HM3Td+LM+FFMxhUkvo/XHY2
         7QY4MIuIVNrnuinDDHJxQeIVroxXEki1IwTxIUrhzko7/YrqTlMz+X3JIvi4eccAxZCH
         UyPQ==
X-Gm-Message-State: AOAM533dpChIa80iGivlT4JnGUldSsd0WOATI9UP4FnaG2pc2hvNoB2X
        E/5fqUWKPs7WwYtJ4DbEEmS/nQ==
X-Google-Smtp-Source: ABdhPJwDiSHpwAb775A9EfjwDdPIkboWLp2SbzF44VTUmPYbQADeCfsM36T8Gw3e0Qk1hmzim1pZfA==
X-Received: by 2002:a5d:4bc9:: with SMTP id l9mr27231725wrt.97.1623225625800;
        Wed, 09 Jun 2021 01:00:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l13sm15145069wrz.34.2021.06.09.01.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:00:25 -0700 (PDT)
Subject: Re: [PATCH v3] ASoC: qcom: Fix for DMA interrupt clear reg
 overwriting
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <20210609072310.26099-1-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f8be85f2-719d-c19d-b5af-c97d7def2f6b@linaro.org>
Date:   Wed, 9 Jun 2021 09:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210609072310.26099-1-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 08:23, Srinivasa Rao Mandadapu wrote:
> The DMA interrupt clear register overwritten during
> simultaneous playback and capture in lpass platform
> interrupt handler. It's causing playback or capture stuck
> in similtaneous plaback on speaker and capture on dmic test.
> Update appropriate reg fields of corresponding channel instead
> of entire register write.
> 
> Fixes: commit c5c8635a04711 ("ASoC: qcom: Add LPASS platform driver")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

LGTM

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
> ---
> Changes since v2:
> 	-- Removed redundant variables.
> Changes since v1:
> 	-- Subject lines changed.
>   sound/soc/qcom/lpass-platform.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 0df9481ea4c6..f9df76d37858 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -526,7 +526,7 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
>   			return -EINVAL;
>   		}
>   
> -		ret = regmap_write(map, reg_irqclr, val_irqclr);
> +		ret = regmap_update_bits(map, reg_irqclr, val_irqclr, val_irqclr);
>   		if (ret) {
>   			dev_err(soc_runtime->dev, "error writing to irqclear reg: %d\n", ret);
>   			return ret;
> @@ -650,10 +650,11 @@ static irqreturn_t lpass_dma_interrupt_handler(
>   	struct lpass_variant *v = drvdata->variant;
>   	irqreturn_t ret = IRQ_NONE;
>   	int rv;
> -	unsigned int reg = 0, val = 0;
> +	unsigned int reg, val, mask;
>   	struct regmap *map;
>   	unsigned int dai_id = cpu_dai->driver->id;
>   
> +	mask = LPAIF_IRQ_ALL(chan);
>   	switch (dai_id) {
>   	case LPASS_DP_RX:
>   		map = drvdata->hdmiif_map;
> @@ -676,8 +677,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>   	return -EINVAL;
>   	}
>   	if (interrupts & LPAIF_IRQ_PER(chan)) {
> -
> -		rv = regmap_write(map, reg, LPAIF_IRQ_PER(chan) | val);
> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_PER(chan) | val));
>   		if (rv) {
>   			dev_err(soc_runtime->dev,
>   				"error writing to irqclear reg: %d\n", rv);
> @@ -688,7 +688,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>   	}
>   
>   	if (interrupts & LPAIF_IRQ_XRUN(chan)) {
> -		rv = regmap_write(map, reg, LPAIF_IRQ_XRUN(chan) | val);
> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_XRUN(chan) | val));
>   		if (rv) {
>   			dev_err(soc_runtime->dev,
>   				"error writing to irqclear reg: %d\n", rv);
> @@ -700,7 +700,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>   	}
>   
>   	if (interrupts & LPAIF_IRQ_ERR(chan)) {
> -		rv = regmap_write(map, reg, LPAIF_IRQ_ERR(chan) | val);
> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_ERR(chan) | val));
>   		if (rv) {
>   			dev_err(soc_runtime->dev,
>   				"error writing to irqclear reg: %d\n", rv);
> 
