Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4467632E49D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:19:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320BC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:19:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5688545wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9NaXk4dB/rdZ6Q95jjM7mfrL2gEwIE0c0/Z44hytAfo=;
        b=Hke56nsGOFEllx5nEFlQ7K+8nJcZqv81lMbYYK+j9c6hfvFkV0FjZaCRpSVajwmF+R
         GZI+CjXTUC11H+imXOfNZqJatZHa91SDJqqugfmJxerX+JAeHe+eouMn7LVUzLloMZCy
         Y4IstHkPHM+rYlCNbPNB0sj7vjLnL4KEYrJVSLVisFxOSi6R726B8fXb5oXCXB9I9bq2
         2+Oq6rlaGwmdFyXaKFVHQ/pn5gsCxAGrhZbZJdG/H4IV5ZAGFXeZyCIhfEqItEsMnpZK
         hTfK/LsgFCRdEU5+il/a9i52RVry3xDajxqkQz/+XlgzeizorZEGs8mJE2dA/DXJtX90
         beeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9NaXk4dB/rdZ6Q95jjM7mfrL2gEwIE0c0/Z44hytAfo=;
        b=XSlj/AlY7a4VFDBK/Ft9UM3FYk6qetuDSqRC6E06+CR1buXb7NxdmKjPHdWh/HAPVm
         8SYH0S7mlnH8miFv0AfYwEzDs+GaGmsIC7zEybKTJVWDIYThjxy3o/GENu9dUaK0x9R4
         L01X54TMWSAhB8oUXv+UKoJKpCeXas/Zk7U5dV0vZfh3r0b/jzl6xxNnLUA1Nx8Nlsyo
         UwaWLXXlW+/RYi3H5c8oPxDmsEFOMOlS8L4IVdEdqyzfPbgh7SvbEutIj6qWQraHvfi0
         tyuUT2vpGunO5jKPHsyq3+sg3UhV22PTB0W8hmdNUa9kiSOj27N53osXgUF8+eqv6lVk
         VZ0Q==
X-Gm-Message-State: AOAM533fMYMEsr40ekN6q4yrHhjoPDUZR/hMJAeeDnI23AJC+kqFkZvB
        dD7HD8iH099ccEJ/OKbWjSFeFjMF6sd3jg==
X-Google-Smtp-Source: ABdhPJw6DQo57kVctbf9LdrGa50qhXc9YYge5k8O1RQjCtdYNLIQRZq/GIm4f3DRItMYIea2ZkfHSQ==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr7629124wmf.2.1614935938869;
        Fri, 05 Mar 2021 01:18:58 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id f7sm3478937wre.78.2021.03.05.01.18.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 01:18:58 -0800 (PST)
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: fix RX MIX input controls
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210305005049.24726-1-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <901874d6-9b1f-714b-31bf-0e1e61956890@linaro.org>
Date:   Fri, 5 Mar 2021 09:18:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210305005049.24726-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jonathan for testing the Mix path!

On 05/03/2021 00:50, Jonathan Marek wrote:
> Attempting to use the RX MIX path at 48kHz plays at 96kHz, because these
> controls are incorrectly toggling the first bit of the register, which
> is part of the FS_RATE field.
> 
Yes bit 0 is part of PCM RATE!

> Fix the problem by using the same method used by the "WSA RX_MIX EC0_MUX"
> control, which is to use SND_SOC_NOPM as the register and use an enum in
> the shift field instead.
> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

This looks good to me.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/lpass-wsa-macro.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index f399f4dff5511..bd2561f9fb9fa 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1211,14 +1211,16 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
>   				     struct snd_kcontrol *kcontrol, int event)
>   {
>   	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> -	u16 gain_reg;
> +	u16 path_reg, gain_reg;
>   	int val;
>   
> -	switch (w->reg) {
> -	case CDC_WSA_RX0_RX_PATH_MIX_CTL:
> +	switch (w->shift) {
> +	case WSA_MACRO_RX_MIX0:
> +		path_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL;
>   		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
>   		break;
> -	case CDC_WSA_RX1_RX_PATH_MIX_CTL:
> +	case WSA_MACRO_RX_MIX1:
> +		path_reg = CDC_WSA_RX1_RX_PATH_MIX_CTL;
>   		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
>   		break;
>   	default:
> @@ -1231,7 +1233,7 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
>   		snd_soc_component_write(component, gain_reg, val);
>   		break;
>   	case SND_SOC_DAPM_POST_PMD:
> -		snd_soc_component_update_bits(component, w->reg,
> +		snd_soc_component_update_bits(component, path_reg,
>   					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
>   					      CDC_WSA_RX_PATH_MIX_CLK_DISABLE);
>   		break;
> @@ -2068,14 +2070,14 @@ static const struct snd_soc_dapm_widget wsa_macro_dapm_widgets[] = {
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP0", SND_SOC_NOPM, 0, 0, &rx0_prim_inp0_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP1", SND_SOC_NOPM, 0, 0, &rx0_prim_inp1_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP2", SND_SOC_NOPM, 0, 0, &rx0_prim_inp2_mux),
> -	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", CDC_WSA_RX0_RX_PATH_MIX_CTL,
> -			   0, 0, &rx0_mix_mux, wsa_macro_enable_mix_path,
> +	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX0,
> +			   0, &rx0_mix_mux, wsa_macro_enable_mix_path,
>   			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP0", SND_SOC_NOPM, 0, 0, &rx1_prim_inp0_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP1", SND_SOC_NOPM, 0, 0, &rx1_prim_inp1_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP2", SND_SOC_NOPM, 0, 0, &rx1_prim_inp2_mux),
> -	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", CDC_WSA_RX1_RX_PATH_MIX_CTL,
> -			   0, 0, &rx1_mix_mux, wsa_macro_enable_mix_path,
> +	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX1,
> +			   0, &rx1_mix_mux, wsa_macro_enable_mix_path,
>   			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   
>   	SND_SOC_DAPM_MIXER_E("WSA_RX INT0 MIX", SND_SOC_NOPM, 0, 0, NULL, 0,
> 
