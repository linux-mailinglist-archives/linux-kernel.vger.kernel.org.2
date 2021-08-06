Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3E3E2A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhHFMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbhHFMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:06:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE6C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 05:06:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so10778384wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIkPlaepn7cVcLOlogP6tw0QtR3s5KOOKLFL6W1I1W8=;
        b=O7Esh5bM7oIRAVW8/fvggmwsEzQcwYSJ6FyLR+xYmRzr3lmCuVujcv1hegf0teu7/A
         K8aA60nMMx925AfIFzvofaxB6u3FegMJ4ySiqQa/VMG3PiKfk53WEDfwE/u1NjjvHm4n
         z/LiMy2qmkT2NKM49iiHGKeSs4ZC8RdzgEOhCSNK3T0dUEpBP1+1J3CiBXUmF3xOC+oD
         oVw19cTYJq6Ga5S878FJ8nALwWee6n+NiNgtvtwqV3mRnFz1h+7lyRwKMYJ9YP7grjfe
         ZktoAh5164GlnZJvrje+fdjDb6vIoa3VFau5aopcZ0+KzmoSkmd7/SEtzLgQqJOghFGO
         35jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIkPlaepn7cVcLOlogP6tw0QtR3s5KOOKLFL6W1I1W8=;
        b=LBGdXWhUI1Aii5j/8AI4w1GNkVu5CqhVwrYIlDSQVO2zw5uWyzUhNBRR2Nfwq6KeX5
         imrFvFM4TJs1sM3gsAO9WBUAsdxyUtCkRnmwl7p2uwI6ygP5HhmxBpBNLk73btg6EB5P
         yAEUZGXO+W4NxTlZofI8vknilxLRArVnuxo88NmLs8lWDorWLQOL+gKhB1FhhFMbrgco
         +LAS3gqOGS32AoIlw+4zR9ReKLGIiGnO3z4+iJUQ4OJjWkeu+41Y1U3tDhW0skTi3wgg
         SHXRmjyP1sIuQMhyYWJKOtDiGsPtQEOYTegM8bKCMwc/H8YR1UIcdaygbXbmCPLvpmkT
         ZSag==
X-Gm-Message-State: AOAM532aAU5JnBw9La8nqRbJtT5g1iiDcUYDoT/xxTuP+sslSX/j+KUa
        NVmwvm5HD6qsPuoZM9hgLcnGvg==
X-Google-Smtp-Source: ABdhPJxTl539JAuxpt6ru9+KOop6BTMQtlaB06v648QGj3hRa7CfCjgLIUyK4ar3zP3KVyDPnMY70w==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr10641921wrq.204.1628251579670;
        Fri, 06 Aug 2021 05:06:19 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id x18sm8335417wmc.17.2021.08.06.05.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:06:19 -0700 (PDT)
Subject: Re: [PATCH v2] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
To:     Vincent Knecht <vincent.knecht@mailoo.org>, tiwai@suse.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        stephan@gerhold.net
References: <20210806114116.895473-1-vincent.knecht@mailoo.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <facfd3cb-7546-ce65-c342-70b88b46b36e@linaro.org>
Date:   Fri, 6 Aug 2021 13:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806114116.895473-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2021 12:41, Vincent Knecht wrote:
> This patch adds external codec support on secondary mi2s.
> It is used for headphones on some devices, eg. alcatel-idol347.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Thanks for rework, LGTM.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> v1->v2: thanks Srinivas for the review, and Stephan for guidance
> - Add _SEC suffix to defines to highlight usage for secondary mi2s
> - Clear TLMM_WS_OUT_SEL and TLMM_WS_EN_SEL fields before setting value
> ---
>   sound/soc/qcom/apq8016_sbc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index 08a05f0ecad7..ba2a98268ee4 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -30,6 +30,13 @@ struct apq8016_sbc_data {
>   #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
>   #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
>   #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
> +#define SPKR_CTL_TLMM_MCLK_EN		BIT(1)
> +#define SPKR_CTL_TLMM_SCLK_EN		BIT(2)
> +#define SPKR_CTL_TLMM_DATA1_EN		BIT(3)
> +#define SPKR_CTL_TLMM_WS_OUT_SEL_MASK	GENMASK(7, 6)
> +#define SPKR_CTL_TLMM_WS_OUT_SEL_SEC	BIT(6)
> +#define SPKR_CTL_TLMM_WS_EN_SEL_MASK	GENMASK(19, 18)
> +#define SPKR_CTL_TLMM_WS_EN_SEL_SEC	BIT(18)
>   #define DEFAULT_MCLK_RATE		9600000
>   
>   static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
> @@ -40,6 +47,7 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
>   	struct snd_soc_card *card = rtd->card;
>   	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
>   	int i, rval;
> +	u32 value;
>   
>   	switch (cpu_dai->id) {
>   	case MI2S_PRIMARY:
> @@ -53,6 +61,15 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
>   			MIC_CTRL_TLMM_SCLK_EN,
>   			pdata->mic_iomux);
>   		break;
> +	case MI2S_SECONDARY:
> +		/* Clear TLMM_WS_OUT_SEL and TLMM_WS_EN_SEL fields */
> +		value = readl(pdata->spkr_iomux) &
> +			~(SPKR_CTL_TLMM_WS_OUT_SEL_MASK | SPKR_CTL_TLMM_WS_EN_SEL_MASK);
> +		/* Configure the Sec MI2S to TLMM */
> +		writel(value | SPKR_CTL_TLMM_MCLK_EN | SPKR_CTL_TLMM_SCLK_EN |
> +			SPKR_CTL_TLMM_DATA1_EN | SPKR_CTL_TLMM_WS_OUT_SEL_SEC |
> +			SPKR_CTL_TLMM_WS_EN_SEL_SEC, pdata->spkr_iomux);
> +		break;
>   	case MI2S_TERTIARY:
>   		writel(readl(pdata->mic_iomux) | MIC_CTRL_TER_WS_SLAVE_SEL |
>   			MIC_CTRL_TLMM_SCLK_EN,
> 
