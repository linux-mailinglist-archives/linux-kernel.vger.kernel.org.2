Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606CE34362E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCVBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCVBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:17:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99939C061763
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:17:22 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c4so9068373qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfs7xVzInGDXwslEYQjd+qhYAguRi3oFAn1yP3BW/2k=;
        b=epkhX8fuq5xMIzNlsG9pKusuN9WWzHkBij7FO7Ihg7Rl40Ylexo0nq3Pb2fQpokwDS
         rAQxeBZ8Pkn+F6ocbic5mNgbOc5vp+yJUCrXQfl7gAvbiOpWrqSoUSs9R/jr8+qbdrkf
         JYS6qNQ4p+gsg7x3VNU92iXdHUOclSxS6hA3L1yl574BaGYpRL0b3NUoiZ12lu9b0fMm
         jDBflZWHzV5AB2tRcIl0HBrL1UV+xrJXXgAp8cj2c6tkDR4S9ZrwwaGQ/PAmxHi8Adsw
         N26w4xrc/jaRY8RWdHV5CPclm7jM/byeGC0zpeLR/i87NPXiDygQrKZF9qXmf9PzPGwh
         4mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfs7xVzInGDXwslEYQjd+qhYAguRi3oFAn1yP3BW/2k=;
        b=aw4Kt6IpBBZR+5mXSHYqoI2NivoFYlOWzFvtvioWQV+PzyTQZ9i9+VfrTm2uG4JJ4z
         8IWeijeGAbDevFmRCSNq0BDyZYhljQTg2cd/zbt67bHvY/oAyi9lZrd2OI5x397OHGXN
         HDx30W9X2EU2MPDqYYP0l1b+gun/Lxabqx7/BT99IFhPXiAkUrpVBrYyiaBXW0f1ITgP
         AYDZ+q4YGvSC3xHeSIhf1MKRk/CRdo1aEQIqu40JRSa5FEhFbNl+v0itjQ67XgMaziAu
         Xy+5k4UHc/zYrkSmKs5HjT8aEusGiTY5+FlTyJ4gbRMcQQF5TDfarh0jJOlv78Ha0VbQ
         cLbA==
X-Gm-Message-State: AOAM530y5t46yGRnt3YCndLmij3cWoOf73V+Z7A8obF79RCCWf/t8gJ+
        OeT8nWiTU6wAF3m9T2XX4fUb8MJGtxHgjw==
X-Google-Smtp-Source: ABdhPJw5CxyXrmQKPVQRl5Tk/lz8EbKa3VTJDWRuNObEIvT2jGno1muWGknIJV11WzbgmSz34KpONw==
X-Received: by 2002:a37:a913:: with SMTP id s19mr9048401qke.158.1616375841339;
        Sun, 21 Mar 2021 18:17:21 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id r133sm9993160qke.20.2021.03.21.18.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 18:17:20 -0700 (PDT)
Subject: Re: [PATCH v12 5/9] drivers: thermal: tsens: Fix bug in sensor enable
 for msm8960
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
 <20210319181512.7757-6-ansuelsmth@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <07ad8ee4-352f-57b6-c990-1410615e5798@linaro.org>
Date:   Sun, 21 Mar 2021 21:17:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319181512.7757-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 2:15 PM, Ansuel Smith wrote:
> Device based on tsens VER_0 contains a hardware bug that results in some
> problem with sensor enablement. Sensor id 6-11 can't be enabled
> selectively and all of them must be enabled in one step.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara
> ---
>   drivers/thermal/qcom/tsens-8960.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 86585f439985..bf8dfaf06428 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -27,9 +27,9 @@
>   #define EN			BIT(0)
>   #define SW_RST			BIT(1)
>   #define SENSOR0_EN		BIT(3)
> +#define MEASURE_PERIOD		BIT(18)
>   #define SLP_CLK_ENA		BIT(26)
>   #define SLP_CLK_ENA_8660	BIT(24)
> -#define MEASURE_PERIOD		1
>   #define SENSOR0_SHIFT		3
>   
>   /* INT_STATUS_ADDR bitmasks */
> @@ -126,17 +126,34 @@ static int resume_8960(struct tsens_priv *priv)
>   static int enable_8960(struct tsens_priv *priv, int id)
>   {
>   	int ret;
> -	u32 reg, mask;
> +	u32 reg, mask = BIT(id);
>   
>   	ret = regmap_read(priv->tm_map, CNTL_ADDR, &reg);
>   	if (ret)
>   		return ret;
>   
> -	mask = BIT(id + SENSOR0_SHIFT);
> +	/* HARDWARE BUG:
> +	 * On platform with more than 6 sensors, all the remaining
> +	 * sensors needs to be enabled all togheder or underfined
> +	 * results are expected. (Sensor 6-7 disabled, Sensor 3
> +	 * disabled...) In the original driver, all the sensors
> +	 * are enabled in one step hence this bug is not triggered.
> +	 */
> +	if (id > 5)
> +		mask = GENMASK(10, 6);
> +
> +	mask <<= SENSOR0_SHIFT;
> +
> +	/* Sensors already enabled. Skip. */
> +	if ((reg & mask) == mask)
> +		return 0;
> +
>   	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);
>   	if (ret)
>   		return ret;
>   
> +	reg |= MEASURE_PERIOD;
> +
>   	if (priv->num_sensors > 1)
>   		reg |= mask | SLP_CLK_ENA | EN;
>   	else
> 

