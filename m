Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD0419262
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhI0Kof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhI0Koe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:44:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB7C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:42:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 136-20020a1c048e000000b0030d05169e9bso78388wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bl3l80PLJwDnjPoaNYbvG3Z+vfpuSPjJGAmYGrPl1Y4=;
        b=kDhQYXhctmPax8BWT4MUKhzXGoZ8mPx8LMLOINhqUYV3MUr4X0A/ZLvxTikNd6/CA8
         WvBFrCd1W/Wnl0wf9u1H9Tb1Yb/C0Ud0C1JWmey+IcaZvCuAjJc2M5GgPuIFR8H5YcI0
         6f9L6Y5scExb76lRh4gJt+2rp52cbmlZWbogJQIm78QLF17Jbek0MGib2KUpFkoDG7MR
         4oIxmxM+E5kEO1zKdYS0ZcOyjoFfON66Jnpww5Q6aSWfebCLXkkicXZbwG3tbGUvEbgJ
         VCqOT21vRQoqaUULj/6I5NLuv90AGBsvVxhpsgN3rkKqM8puquBoZOANORH09LfxsiRl
         i5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bl3l80PLJwDnjPoaNYbvG3Z+vfpuSPjJGAmYGrPl1Y4=;
        b=6YPc/a5rXhsezFHPKQWuzThkSqOPCAWhYAiLMurihLlRyWGJ3Js1k1QzLpFysZhhV+
         G0Wd1BtjzbBdbFW18/Njp+3E+qF58p2TfesMLLf+N9lKBY3DnFjZJPAUDlXo5bk36gMH
         Jbrqe8AmFEUcJPSQs1P6Ik2bguhOesIbZZnxIf5oNVZw0RpUC9ieboyJfFMi022mLqN4
         QDhFzVvDlz8GuiF9fFgKRnX9jRvAKnrnAaGCHZCsVcYQClJfSO8UfNr1biFTKMr9PnHF
         gfU98LqpZPpqX0/L2Zw5mlj5KylVWAZVw2gNQTqtBLM/SRfP4jaBa0PiaWU1eMShp+xu
         mWug==
X-Gm-Message-State: AOAM532ANeJZnhk9kjKtfjd4Ue7yvDZmKgmW5a1ZOtY8Iw1szb1RpoGQ
        NBvK1QNEEigchpRNrnptaTn4UQ==
X-Google-Smtp-Source: ABdhPJyPrHcwo/l44zFRoQnD/3cTUE6JBsBv7AeTjSfz3ViSTlBXNAeTSvaNS50OEFWy78/iNPp4+w==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr15176884wml.109.1632739374619;
        Mon, 27 Sep 2021 03:42:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i18sm16528281wrn.64.2021.09.27.03.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:42:54 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] ASoC: codecs: tx-macro: Update tx default values
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <agross@kernel.org; bjorn.andersson@linaro.org;
 lgirdwood@gmail.com; broonie@kernel.org;robh+dt@kernel.org;
 plai@codeaurora.org; bgoswami@codeaurora.org; perex@perex.cz;
 tiwai@suse.com;srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org;
 linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org;
 devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
 swboyd@chromium.org; judyhsiao@chromium.org;>
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
 <1632313878-12089-5-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e65c77f4-766c-a5ce-9cbd-f1697c1be28c@linaro.org>
Date:   Mon, 27 Sep 2021 11:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632313878-12089-5-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 13:31, Srinivasa Rao Mandadapu wrote:
> Update mic control register default values to hardware reset values
> 
> Fixes: c39667ddcfc5 (ASoC: codecs: lpass-tx-macro: add support for lpass tx macro)
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index e980b2e..66c39fb 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -279,7 +279,7 @@ static const struct reg_default tx_defaults[] = {
>   	{ CDC_TX_CLK_RST_CTRL_SWR_CONTROL, 0x00},
>   	{ CDC_TX_TOP_CSR_TOP_CFG0, 0x00},
>   	{ CDC_TX_TOP_CSR_ANC_CFG, 0x00},
> -	{ CDC_TX_TOP_CSR_SWR_CTRL, 0x00},
> +	{ CDC_TX_TOP_CSR_SWR_CTRL, 0x60},

This does not make sense as this register only has one bit to control.
Why do we even need to change this, can you please explain what happens 
if we do not change this?

>   	{ CDC_TX_TOP_CSR_FREQ_MCLK, 0x00},
>   	{ CDC_TX_TOP_CSR_DEBUG_BUS, 0x00},
>   	{ CDC_TX_TOP_CSR_DEBUG_EN, 0x00},
> @@ -290,8 +290,8 @@ static const struct reg_default tx_defaults[] = {
>   	{ CDC_TX_TOP_CSR_SWR_DMIC1_CTL, 0x00},
>   	{ CDC_TX_TOP_CSR_SWR_DMIC2_CTL, 0x00},
>   	{ CDC_TX_TOP_CSR_SWR_DMIC3_CTL, 0x00},
> -	{ CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0x00},
> -	{ CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0x00},
> +	{ CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0x0E},
> +	{ CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0x0E},

These two registers should have default value of 0x06 as this has only 
one clk selection field with bits 2:1.

-srini


>   	{ CDC_TX_INP_MUX_ADC_MUX0_CFG0, 0x00},
>   	{ CDC_TX_INP_MUX_ADC_MUX0_CFG1, 0x00},
>   	{ CDC_TX_INP_MUX_ADC_MUX1_CFG0, 0x00},
> 
