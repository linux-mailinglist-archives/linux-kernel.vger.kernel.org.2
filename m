Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4A38C33E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhEUJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhEUJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:36:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:34:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so91531wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QS9C9TZP/LIhXh/A86+cA4E2zCqL/pkxZ+dcKq3mb/8=;
        b=fztd89Omuf4opCAx6o67aZ0oeo6vyXKFZdPl6G2tingNdDYrhoEFs3wlaqcHS8uxaO
         pq2mVArFa4w0Q1oJ1RF/YYasVVX/BCOwi1PVIyxxJgClzxKvLc4WPCNxjrvbHHpNTZk1
         kg77USyJYEbHd7Pel+V6NFSnjrZKNrqwcYunKzQl4+fkmfKaVROmmJ2LeZ3qel9BVhIN
         WOQ70lxA1LanxVCRdfj//1bckFAAQelE1Ucj1V2phNeSxFMPGdp0zurtSpaXv/w+lu00
         BEHhygMVoitmv3BXEvS0E7MbEj706n7zcLl7rnSOBAumCdWEjU/oCh0kGjbRyOlAaqCt
         KloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QS9C9TZP/LIhXh/A86+cA4E2zCqL/pkxZ+dcKq3mb/8=;
        b=go+Cx14TNdB46CZ2aDlXvigcapdS1pkxYcgzG6fkTkhtT+ID7IMTJDWalpoHM2NQnQ
         QMs7Y+BKK/lI/l9CAd2PIJRL0p4cXRQYiFtR9pgeBmulNB6g3P+OhmDGnhz/usHtsYek
         YT8mzwIwGGcMyyZvSL9unH5rNxlGKVxRzqKyHNUDJvJt2JbauXApyhIEXf+8GL0BdL2o
         l0E8nC+GNaewH9dKjddqTDVuSOQtURW1pAINWF7YibLJMUp+kjU9yZtrAQVdSyqltFCj
         rkodLtHSSopRsqzpftrCM47BKVN+SQpRXKuXJZr58zNiYTnghObAwv/8yTNbK8jLTwrT
         v29w==
X-Gm-Message-State: AOAM5326HmFftvlxfhaY/D6GfgsbKo6RouqNrSfs6w40clwL2PEkqehN
        30Ga7+b1ifNipnKVjq78P4iwuA==
X-Google-Smtp-Source: ABdhPJxKLuDkDkJcUdWHYHwuORgC+mlRBwAFwJvqko9NwAyymbpZBtCpoLhIIaAHqoxMYzHgADSoXw==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr7771186wmb.53.1621589693793;
        Fri, 21 May 2021 02:34:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z131sm4993484wmb.30.2021.05.21.02.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 May 2021 02:34:53 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: Use optional clk APIs
To:     Stephen Boyd <swboyd@chromium.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>
References: <20210520014807.3749797-1-swboyd@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <96301eb2-ef2d-be7f-2a24-8723c1e39905@linaro.org>
Date:   Fri, 21 May 2021 10:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210520014807.3749797-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for patch.

On 20/05/2021 02:48, Stephen Boyd wrote:
> This driver spits out a warning for me at boot:
> 
>   sc7180-lpass-cpu 62f00000.lpass: asoc_qcom_lpass_cpu_platform_probe() error getting optional null: -2
> 
> but it looks like it is all an optional clk. Use the optional clk APIs
> here so that we don't see this message and everything else is the same.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Fixes: 3e53ac8230c1 ("ASoC: qcom: make osr clock optional")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Lgtm,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini

> ---
>   sound/soc/qcom/lpass-cpu.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index c62d2612e8f5..28c7497344e3 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -835,18 +835,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   		if (dai_id == LPASS_DP_RX)
>   			continue;
>   
> -		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(dev,
> +		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get_optional(dev,
>   					     variant->dai_osr_clk_names[i]);
> -		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
> -			dev_warn(dev,
> -				"%s() error getting optional %s: %ld\n",
> -				__func__,
> -				variant->dai_osr_clk_names[i],
> -				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
> -
> -			drvdata->mi2s_osr_clk[dai_id] = NULL;
> -		}
> -
>   		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(dev,
>   						variant->dai_bit_clk_names[i]);
>   		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
> 
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> 
