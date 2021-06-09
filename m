Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1333A0E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhFIIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhFIIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:12:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 01:10:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z8so24377563wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yeMGCtUgxK6t4A7+D+jzmV9juI4SVCPR/VjiQhoikOY=;
        b=SRf1eULIXhahYK8Dwzo8FNoIxxo6HuJvR3fP38pj0ee/3J/UIwJ7eaXEybnr+An1X7
         ldIP0yifHyV+xXeepgHNWmJG+xSDi/zzRX+JydP87oU1IZUycTP+QbxUAoQdSaS7UGcP
         XYISTU5I1G59Tm4pVGKUFUMHaVKmTbhhcSbHKoo1G1F02aOp++g6sgOyP5TtjR+REIqQ
         +FXTMmtZ5Ri2uFfil+VEhzfgdMydyb/tZgrI1nn5FuavmRmb/IPJLmVW2engTg2tOdxQ
         CzqAhzBQS526LJ2iWZOjgXwTGocMZnjWvtzdWzhCp/vArXo8xszneScYd7oCCRS5orfE
         aqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeMGCtUgxK6t4A7+D+jzmV9juI4SVCPR/VjiQhoikOY=;
        b=RuP4XZzZ2jRR3XQZCAE86HRpkDA73dTSiubCOzaTbXqMHN8JFv9MOeouyl+9bT2ljp
         RV6ZN6MnvPnmmRX+OR/eASEYycHPNObl0bi8T8c4gN2s/MFDtXF//eMYuXFeAhJBpR2H
         6ibRjv6AlfI/M/FLsfHoUFZtgKDgH0b9wfsa/uQRCfjub2L7++83k+mpWPQsIvPvA4pS
         Xzbke1aALficL6OmWeAl0+d2Q8eEHSFKORaHLg04fuvPjKHz4N2zcB+8yepHpNVc6NI/
         oaLTLQ2V8Mw0mkRmm1VxWAXpa1+Bvl5Fq4UWIg6fM439RDngyCeqluZQLiGV/sLr9pR4
         4jtg==
X-Gm-Message-State: AOAM5316p5CWChQeeARIMp1bC0u2NEGy04rZwbV4/JlcUfpHBlOWB5xs
        I5MEt9Ce9EQ2mxDC9umTkMHMaA==
X-Google-Smtp-Source: ABdhPJwiOv9HYqPqUVEfcTUiAMETCK+o02InNqPw0Xo7N42BXXYoQYoWr/ZBcbpROaU55/XTbngA7w==
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr18788612wrd.110.1623226249215;
        Wed, 09 Jun 2021 01:10:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e27sm23253335wra.50.2021.06.09.01.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:10:48 -0700 (PDT)
Subject: Re: [PATCH v2] ASoC: qcom: Add four speaker support on MI2S secondary
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <20210609071313.18206-1-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d21e8951-583c-562b-421a-54ec206610ef@linaro.org>
Date:   Wed, 9 Jun 2021 09:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210609071313.18206-1-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 08:13, Srinivasa Rao Mandadapu wrote:
> Add four speaker support on MI2S secondary block
> by using I2S SD1 line on gpio52 pin, and add channel map
> control support in the lpass-cpu audio driver.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
> Changes Since V1:
> 	-- removed set_channel_map/get_channel_map implementation as default kcontrols
> 		added in pcm_new API.
> 		
>   sound/soc/qcom/lpass-cpu.c    | 32 ++++++++++++++++++++++++++++++++
>   sound/soc/qcom/lpass-sc7180.c |  1 +
>   sound/soc/qcom/lpass.h        |  2 ++
>   3 files changed, 35 insertions(+)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index c62d2612e8f5..15d69e311b38 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -29,6 +29,14 @@
>   #define LPASS_CPU_I2S_SD0_1_2_MASK	GENMASK(2, 0)
>   #define LPASS_CPU_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
>   
> +/*
> + * Channel maps for Quad channel playbacks on MI2S Secondary
> + */
> +static struct snd_pcm_chmap_elem lpass_quad_chmaps = {
> +		.channels = 4,
> +		.map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_RL,
> +				SNDRV_CHMAP_FR, SNDRV_CHMAP_RR }

AFAIU, You would need an empty entry at the end of this list if not we 
will endup in a dereferencing memory sitting right next to this array 
which will lead to random memory corruptions...

Have a look at some of the examples in existing codec drivers.

Other than that patch looks good.

--srini


> +};
>   static int lpass_cpu_init_i2sctl_bitfields(struct device *dev,
>   			struct lpaif_i2sctl *i2sctl, struct regmap *map)
>   {
> @@ -324,6 +332,25 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
>   };
>   EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_dai_ops);
>   
> +int lpass_cpu_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +				struct snd_soc_dai *dai)
> +{
> +	int ret;
> +	struct snd_soc_dai_driver *drv = dai->driver;
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +
> +	if (drvdata->mi2s_playback_sd_mode[dai->id] == LPAIF_I2SCTL_MODE_QUAD01) {
> +		ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
> +				&lpass_quad_chmaps, drv->playback.channels_max, 0,
> +				NULL);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lpass_cpu_pcm_new);
> +
>   int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> @@ -856,6 +883,11 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
>   			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
>   		}
> +		if (drvdata->mi2s_playback_sd_mode[dai_id] ==
> +			LPAIF_I2SCTL_MODE_QUAD01) {
> +			variant->dai_driver[dai_id].playback.channels_min = 4;
> +			variant->dai_driver[dai_id].playback.channels_max = 4;
> +		}
>   	}
>   
>   	/* Allocation for i2sctl regmap fields */
> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> index 8c168d3c589e..77a556b27cf0 100644
> --- a/sound/soc/qcom/lpass-sc7180.c
> +++ b/sound/soc/qcom/lpass-sc7180.c
> @@ -58,6 +58,7 @@ static struct snd_soc_dai_driver sc7180_lpass_cpu_dai_driver[] = {
>   		},
>   		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
>   		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
> +		.pcm_new = lpass_cpu_pcm_new,
>   	}, {
>   		.id = LPASS_DP_RX,
>   		.name = "Hdmi",
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 83b2e08ade06..623ddccdafff 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -259,5 +259,7 @@ void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev);
>   int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev);
>   int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai);
>   extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
> +int lpass_cpu_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +				struct snd_soc_dai *dai);
>   
>   #endif /* __LPASS_H__ */
> 
