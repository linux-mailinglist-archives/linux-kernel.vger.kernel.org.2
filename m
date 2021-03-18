Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A262340FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhCRVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhCRVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:15:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC1C061761
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:15:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c3so767721qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5w4WSNAlvQXYycvaRdLPv+LtaQ4KyjHhKFtIxnGcrw=;
        b=h957bh8FnXWsrxLfnf0bobs8nTJQyOXwN45d+nctFojCLWbntd1GUSseL7KmK7vCEW
         L+eczyLAYNFabhQ8/cD440URdSMnXLy5LpYlozZRaAIrRch9Qp1ga7a2uRXau742eX0t
         Tw3pSru0QX2mPrdgs9zJBHwY5o2oqb0PI8tFlWlbM97SMn5GjY0fkadK/7PxNHYXgQ7k
         lAHAxuimDOC7VqVrhL5doMcEJLIbueq/KdchZ/WzDHclOh/BdfU9Xj66YKLwhUfAMOC+
         JAsdPVYv2E9+47/IkgnbaPbDKCAB660i8DUNfjn2pZkBu8c3NWd5MaISv5iGrtdi6ePU
         +Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5w4WSNAlvQXYycvaRdLPv+LtaQ4KyjHhKFtIxnGcrw=;
        b=dWX2jleU7o9Q12XMtnH2EnF80DiJY1NaZKllqBfAFDqajm3Ka3i5VixU6CAuyp0+DP
         EJFq2ycHTafLaV39X23rSmhC/9b+67pA/SXs1d+C3F5khWCWgayWQxXHSCPNnz5blqUV
         s//4+oIWXmEajX3MFAEyE/t7AjxYuPk2jjddrgTCH7pe6rOfmpX8af53GrZe8Zmy8Np6
         Bc/tBRF6HiCbnyuPGUYd4UmqlvDsnc+mRvZzYp99Wrw5cm/xu2h50Wnpv5OMag/mJKef
         Ezox1XuYbDrg3V4B089Pfj6XBR5S8RyQyWJY7tXKN4EtkyDq0tgGvT8BRDBnaHN6CyWq
         6Y6w==
X-Gm-Message-State: AOAM5312RT0l6GGmQ0rUMTYR3bWRJf0h7uSM020xSXGqJBiQfaLyr7t8
        P/npdAXvxqDr+SWyWfe7/jrtEHhkcSMhcg==
X-Google-Smtp-Source: ABdhPJwCGnFDuISxiVvC/utQ2rasJrQs7nUMqPkLgQ2XncjdpQGcqld/ce39SJXdN/Vx9pVXXkiuNQ==
X-Received: by 2002:a37:5884:: with SMTP id m126mr6606468qkb.459.1616102154242;
        Thu, 18 Mar 2021 14:15:54 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h75sm2737859qke.80.2021.03.18.14.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:15:53 -0700 (PDT)
Subject: Re: [PATCH v10 6/8] drivers: thermal: tsens: Use get_temp_common for
 msm8960
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <20210217194011.22649-7-ansuelsmth@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <f35182ed-040c-7353-d6d7-932a33193754@linaro.org>
Date:   Thu, 18 Mar 2021 17:15:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/21 2:40 PM, Ansuel Smith wrote:
> Rework calibrate function to use common function. Derive the offset from
> a missing hardcoded slope table and the data from the nvmem calib
> efuses.

You are also changing get_temp to use get_temp_common instead of 
get_temp_8960 in this patch. Please add it to commit description as 
well.I will also consider changing the subject header to something more 
generic like
	"drivers: thermal: tsens: Replace custom 8960 apis with generic apis"
or anything better.

Otherwise,
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens-8960.c | 56 +++++++++----------------------
>   1 file changed, 15 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 248aaa65b5b0..43ebe4d54672 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -67,6 +67,13 @@
>   #define S9_STATUS_OFF		0x3674
>   #define S10_STATUS_OFF		0x3678
>   
> +/* Original slope - 200 to compensate mC to C inaccuracy */
> +u32 tsens_msm8960_slope[] = {
> +			976, 976, 954, 976,
> +			911, 932, 932, 999,
> +			932, 999, 932
> +			};
> +
>   static int suspend_8960(struct tsens_priv *priv)
>   {
>   	int ret;
> @@ -192,9 +199,7 @@ static int calibrate_8960(struct tsens_priv *priv)
>   {
>   	int i;
>   	char *data;
> -
> -	ssize_t num_read = priv->num_sensors;
> -	struct tsens_sensor *s = priv->sensor;
> +	u32 p1[11];
>   
>   	data = qfprom_read(priv->dev, "calib");
>   	if (IS_ERR(data))
> @@ -202,49 +207,18 @@ static int calibrate_8960(struct tsens_priv *priv)
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> -	for (i = 0; i < num_read; i++, s++)
> -		s->offset = data[i];
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		p1[i] = data[i];
> +		priv->sensor[i].slope = tsens_msm8960_slope[i];
> +	}
> +
> +	compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB);
>   
>   	kfree(data);
>   
>   	return 0;
>   }
>   
> -/* Temperature on y axis and ADC-code on x-axis */
> -static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
> -{
> -	int slope, offset;
> -
> -	slope = thermal_zone_get_slope(s->tzd);
> -	offset = CAL_MDEGC - slope * s->offset;
> -
> -	return adc_code * slope + offset;
> -}
> -
> -static int get_temp_8960(const struct tsens_sensor *s, int *temp)
> -{
> -	int ret;
> -	u32 code, trdy;
> -	struct tsens_priv *priv = s->priv;
> -	unsigned long timeout;
> -
> -	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> -	do {
> -		ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
> -		if (ret)
> -			return ret;
> -		if (!(trdy & TRDY_MASK))
> -			continue;
> -		ret = regmap_read(priv->tm_map, s->status, &code);
> -		if (ret)
> -			return ret;
> -		*temp = code_to_mdegC(code, s);
> -		return 0;
> -	} while (time_before(jiffies, timeout));
> -
> -	return -ETIMEDOUT;
> -}
> -
>   static struct tsens_features tsens_8960_feat = {
>   	.ver_major	= VER_0,
>   	.crit_int	= 0,
> @@ -313,7 +287,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
>   static const struct tsens_ops ops_8960 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_8960,
> -	.get_temp	= get_temp_8960,
> +	.get_temp	= get_temp_common,
>   	.enable		= enable_8960,
>   	.disable	= disable_8960,
>   	.suspend	= suspend_8960,
> 
