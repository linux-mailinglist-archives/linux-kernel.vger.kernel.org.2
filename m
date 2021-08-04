Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77983E0409
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhHDPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbhHDPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:20:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04CC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:20:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x17so1425093wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wkTZ3Cvpq95tTZxxGhMCSQ7ZSKfjC1tE+mWWe/3jYYM=;
        b=qUZNQdiUlWR4fZqQO2qEpJtqRJQ4OvzIr7Kuz9UvfnzaGHos0+g8dvDCMYOlI5J7GU
         eeasVfDunhWAcLlMXsqm2G+7tMA4Tzwj+S8NId/qQa71KiYOCauH4JQ8SyB8aLK/YNdL
         B7NKOYK+N4ZYH9L7tlrd5tkaYuAnrJna9N6lZCUSpA4un6DJCTEZER4MySW9f2alcjoD
         adI9r0igmhMxhG98XiyJoix/FjnxEvEs+dyMVVkaJtjz/IVDBwkjCmEoDWcuW17yRy3X
         0AxR5OTFG6mqSwU6Vp0VkcNjL8y/xZlU5ihBkwmRic9rvY2yPICUqX80937llq8ad+Ob
         CjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wkTZ3Cvpq95tTZxxGhMCSQ7ZSKfjC1tE+mWWe/3jYYM=;
        b=TuyamI+r871NmN8l4UcDWcZGhXPz5WbYym0ZbVBvMAhPjphQFUklgqIewQdUPxNdEB
         U9T6Meum4KzK0x1AVLuX2EQBJ0HK9OmlxNqu4ue1IKgtSNRJoLTS0BIKuHyhnXPl0POy
         4aTAFo4cx8CC7ak9hDC7V2U1vBH7BXDpR/yYD2OSYqpY8/j83tI89yxAXo8pnvLtlVO+
         B2r1lT6p7aAfz0ZZ96jUpcnF8osx9YXG1icsAMhP3IZ+/azl7Hsd0S0UrtCIUYrz5fvZ
         CHc7vQiMS8zw1vZF7Urxzg1kUB2YloyknKvbHw1R+LwT79tMhHWTh1tlCWgQKydt+Sxf
         BJEw==
X-Gm-Message-State: AOAM532i4VlTRXP6IkW+IA8+qtifbCWyangrwq9s8Qgsa1y91/NP0WQN
        E13S0BHzHlHAyVKaSTjAP/Oat7dmtRhzag==
X-Google-Smtp-Source: ABdhPJxlJgsrspf5ejM/fhtSz3NsEDL5vJUuMjql93SBjwME2huq7rwsShUGxl7Fjxqnn1rhr3EBSw==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr154955wmq.138.1628090440673;
        Wed, 04 Aug 2021 08:20:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l4sm2876434wrw.32.2021.08.04.08.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:20:40 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
To:     Vincent Knecht <vincent.knecht@mailoo.org>, tiwai@suse.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        stephan@gerhold.net
References: <20210801072951.1403241-1-vincent.knecht@mailoo.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c1ef8096-0aa6-9b26-951d-cb673d03cf50@linaro.org>
Date:   Wed, 4 Aug 2021 16:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210801072951.1403241-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2021 08:29, Vincent Knecht wrote:
> This patch adds external codec support on secondary mi2s.
> It is used for headphones on some devices, eg. alcatel-idol347.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>   sound/soc/qcom/apq8016_sbc.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index 08a05f0ecad7..53460272eb1e 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -30,6 +30,11 @@ struct apq8016_sbc_data {
>   #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
>   #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
>   #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
> +#define SPKR_CTL_TLMM_MCLK_EN		BIT(1)
> +#define SPKR_CTL_TLMM_SCLK_EN		BIT(2)
> +#define SPKR_CTL_TLMM_DATA1_EN		BIT(3)
> +#define SPKR_CTL_TLMM_WS_OUT_SEL	BIT(6)
> +#define SPKR_CTL_TLMM_WS_EN_SEL		BIT(18)

Can you please add suffix to these defines something like:
#define SPKR_CTL_TLMM_WS_EN_SEL_SECONDARY	BIT(18)
so it becomes more obvious, As we have 4 possible values for this field 
[18:19]
same for WS_OUT_SEL.

Also you should make sure that other bits in this fields are cleared 
before writing.

--srini

>   #define DEFAULT_MCLK_RATE		9600000
>   
>   static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
> @@ -53,6 +58,13 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
>   			MIC_CTRL_TLMM_SCLK_EN,
>   			pdata->mic_iomux);
>   		break;
> +	case MI2S_SECONDARY:
> +		/* Configure the Sec MI2S to TLMM */
> +		writel(readl(pdata->spkr_iomux) | SPKR_CTL_TLMM_MCLK_EN |
> +			SPKR_CTL_TLMM_SCLK_EN | SPKR_CTL_TLMM_DATA1_EN |
> +			SPKR_CTL_TLMM_WS_OUT_SEL | SPKR_CTL_TLMM_WS_EN_SEL,
> +			pdata->spkr_iomux);
> +		break;
>   	case MI2S_TERTIARY:
>   		writel(readl(pdata->mic_iomux) | MIC_CTRL_TER_WS_SLAVE_SEL |
>   			MIC_CTRL_TLMM_SCLK_EN,
> 
