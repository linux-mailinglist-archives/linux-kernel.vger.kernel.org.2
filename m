Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477C535C2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244217AbhDLJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbhDLJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF07C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:38:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r9so19162454ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l44rB0IYMxJ35sDa+nql8M4c9xSWgfebmgWtETnR9Rk=;
        b=g8v5HrPpDcZWCi5z1Vikc+xanmXnwDGaCf7pb+6ERjYz5V/8ty8WRI45YWfGtoUhix
         8YyfFlv7EMZtVtigcSpqkFq332BkhGZLyrw4O+kVCJR+kjRZm8q8cB6C9e0DMpS1JmTH
         jztE0gSlOJZ4TrGt7xRiInCX4a7my9CGB3YNKjE8WcuypZZSQk8bVUWgUhK824gz2AR9
         OKS48TuQYXQw8bsK2MZMkf9R8ffqcCqNLCSPaHTM0DvbFKO13LQUsSFVO3PklHaRP70X
         Ehsvc3zyjyGt6TwhW3KCr5LzkUAT0bzU9eDSsmUCedyD/LdabECYtm6iR5AIHrCMfPYX
         QcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l44rB0IYMxJ35sDa+nql8M4c9xSWgfebmgWtETnR9Rk=;
        b=d0Cv+FI2Diu5dMd8np6+kOMC9qJ939CNggxoCxmRYfV9PtVHiiwZ/+T/hlLesZaI+L
         /fN2f9voX36NEh2y8Xt1iAbAPNu+sq3wHwxDy5zd66B9+NUtBkgzNeH/+0Necj0lyn1F
         x3QOFzxJAG+RumW0Wn0dq+O9fj2m7ERNOiXmsGmplfd5UI6oJCi5G5H9HEOOdelZqKV1
         opxfeX5IEfVG+K32cURzlU/aBlOgdIpuR3f7UoGd1OjVQQh37M34LLbPJR4RR6eT1+zD
         GUtwoXVnmkhpAGN1IqXB/jdi96N2h4QzZxNtWaYeauuMPLuliFmAEvDW1lDf6zByjtDW
         uE2w==
X-Gm-Message-State: AOAM5338iLB0F5i17Uzi3/MJ46d75Bo06tzhujls3/YMQWabhPX7koLP
        4m1Ybj3gket9fTlvm6YpCOY+SPmQQpabKg==
X-Google-Smtp-Source: ABdhPJyoKnOEf9yt/+OdqQdgKTrmiMUNMFKI8xCUhL1iNwpXrKhx02OazrbcOO2o7PPSGwWnyFqeMg==
X-Received: by 2002:a17:907:3e92:: with SMTP id hs18mr25824934ejc.396.1618220325317;
        Mon, 12 Apr 2021 02:38:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h24sm5342077ejl.9.2021.04.12.02.38.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 02:38:44 -0700 (PDT)
Subject: Re: [PATCH 4/5] ASoC: lpass: use the clock provider API
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-5-jbrunet@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0c8c3b5d-891a-9bfa-3bbc-4982542df38a@linaro.org>
Date:   Mon, 12 Apr 2021 10:38:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210410111356.467340-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jerome for the patch,


On 10/04/2021 12:13, Jerome Brunet wrote:
> Clock providers should be registered using the clk_hw API.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   sound/soc/codecs/lpass-va-macro.c  | 2 +-
>   sound/soc/codecs/lpass-wsa-macro.c | 9 +++------
>   2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 5294c57b2cd4..56b887301172 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1343,7 +1343,7 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
>   	if (ret)
>   		return ret;
>   
> -	return of_clk_add_provider(np, of_clk_src_simple_get, va->hw.clk);
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &va->hw);

Now that we convert this to devm, You missed error path and driver 
remove where we delete clk provider. This should be removed as well as 
part of this patch.


This applies to both wsa and va macro.

Thanks,
srini
>   }
>   
>   static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index e79a70386b4b..acb95e83c788 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2337,10 +2337,9 @@ static const struct clk_ops swclk_gate_ops = {
>   	.recalc_rate = swclk_recalc_rate,
>   };
>   
> -static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
> +static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
>   {
>   	struct device *dev = wsa->dev;
> -	struct device_node *np = dev->of_node;
>   	const char *parent_clk_name;
>   	const char *clk_name = "mclk";
>   	struct clk_hw *hw;
> @@ -2358,11 +2357,9 @@ static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
>   	hw = &wsa->hw;
>   	ret = clk_hw_register(wsa->dev, hw);
>   	if (ret)
> -		return ERR_PTR(ret);
> -
> -	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
> +		return ret;
>   
> -	return NULL;
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
>   }
>   
>   static const struct snd_soc_component_driver wsa_macro_component_drv = {
> 
