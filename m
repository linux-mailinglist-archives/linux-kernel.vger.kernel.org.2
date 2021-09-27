Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06A8419266
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhI0Kom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhI0Kok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:44:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:43:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so78060wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXNuvpJlyjSNrgzOqRqsp7gQ1I5PBxPfkM0hf91W8lY=;
        b=Ke3i1ykoPbGEAAEA4nUyXqJpkf2ynn+0FDzRDaoFigBy5Mw8qFbOauhlbROJ3lnzWG
         pM3p3zbREIOSs0XG5wnTUNhQPcOQrBUSDRK1GeGm6y/QTpUulN7mzMfaYqf4t3jHWWk5
         c2CDdOxTAdHeeEmjEIuUPvRG1tqM6zPV764wt63J6rOCX+OkI4iJJjrbEJw3yS/348IA
         lwBYA1np4+430aNrhcJS46DdVoqSX8gkZkkuiPIHTz9f8eBv83SQsEEbdQdI5ttuIY8G
         g8VZB/97UL4EscYW4M2bO82HZAC4Q0GRYzh0M46h1xs8FJoMxAu8aq2bu5khZtc3/6+X
         VuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXNuvpJlyjSNrgzOqRqsp7gQ1I5PBxPfkM0hf91W8lY=;
        b=4wSUw9O7NTuM0fNKmIHuW5v4mKzEH53onb0EulmtkY/N6yUqeu+lg76TGeDxRvmnPr
         MxVrgNGqwTi1TMrkXhHN/OvtyvBAByaCkhu5PNBwLZ01oRJBZ9Pf6xolGwjSBp/+a7P7
         ET9NLfX/eyzzG0hriYh+HefN1IqUuOw1TK0lGCqfqKZv36n9xqb7Yylbsa7Cmhx09rGO
         WojhzMWZpeO2jpAiBo1sNPnDsAyWuLOK3ST3jvFg+BBfZcqCbvwAlkbygGESf+kPXV8B
         xqNaBOKNLankXPiPAvauZQ6Nc4rDiSyjaHeGjEpCgqsADJgGIj0tSvxqtqg3XIYcPbnn
         4Nhg==
X-Gm-Message-State: AOAM530fyg8qaWjNRcpcLko21ufb8uoLjafXFa5Jvf2wJUhucvGQuKxE
        ASc9F7u95E/xdqqiC3+LY4gHAg==
X-Google-Smtp-Source: ABdhPJwNBcpoxdG0Xf6e3LsdVnmfnOjtFC7vYinvbFoeRcsD16ENxLXAafyb9zhpHqxxcSVSQGSa6g==
X-Received: by 2002:a05:600c:28e:: with SMTP id 14mr2938720wmk.88.1632739381393;
        Mon, 27 Sep 2021 03:43:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g17sm6278181wru.62.2021.09.27.03.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:43:00 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ASoC: codecs: Change bulk clock voting to optional
 voting in digital codecs
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
 <1632313878-12089-6-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2b401e05-ae34-846e-8e1d-b5db3e0df40e@linaro.org>
Date:   Mon, 27 Sep 2021 11:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632313878-12089-6-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 13:31, Srinivasa Rao Mandadapu wrote:
> Change bulk clock frequency voting to optional bulk voting in va, rx and tx macros
> to accommodate both ADSP and ADSP bypass based lpass architectures.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Reviwed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



>   sound/soc/codecs/lpass-rx-macro.c | 2 +-
>   sound/soc/codecs/lpass-tx-macro.c | 2 +-
>   sound/soc/codecs/lpass-va-macro.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index c2b9333..2bed5cf 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -3531,7 +3531,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>   	rx->clks[3].id = "npl";
>   	rx->clks[4].id = "fsgen";
>   
> -	ret = devm_clk_bulk_get(dev, RX_NUM_CLKS_MAX, rx->clks);
> +	ret = devm_clk_bulk_get_optional(dev, RX_NUM_CLKS_MAX, rx->clks);
>   	if (ret) {
>   		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
>   		return ret;
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 66c39fb..c288471 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -1794,7 +1794,7 @@ static int tx_macro_probe(struct platform_device *pdev)
>   	tx->clks[3].id = "npl";
>   	tx->clks[4].id = "fsgen";
>   
> -	ret = devm_clk_bulk_get(dev, TX_NUM_CLKS_MAX, tx->clks);
> +	ret = devm_clk_bulk_get_optional(dev, TX_NUM_CLKS_MAX, tx->clks);
>   	if (ret) {
>   		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
>   		return ret;
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 70f09b4..11147e3 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1408,7 +1408,7 @@ static int va_macro_probe(struct platform_device *pdev)
>   	va->clks[1].id = "dcodec";
>   	va->clks[2].id = "mclk";
>   
> -	ret = devm_clk_bulk_get(dev, VA_NUM_CLKS_MAX, va->clks);
> +	ret = devm_clk_bulk_get_optional(dev, VA_NUM_CLKS_MAX, va->clks);
>   	if (ret) {
>   		dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
>   		return ret;
> 
