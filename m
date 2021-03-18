Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EB340FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhCRVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhCRVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:15:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB698C061761
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:15:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l13so5218459qtu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a3v6OowpnYirgnqzOWwi689L4QBKiJLs2zj4ksqvvcc=;
        b=WdTTgE5YHaVbVRNk63OuJPOCmk5FB6PzUHgA/naO9mkbZV2sBOWrlgFPmEbfxX15+G
         EbJkTMW6WMQ0PiGZViC5NmtMOkX9+hiI+58ENUzvyk5fiQ1+sUJdqIc4A9Co2nmCQxqZ
         ao90IjIajJwXv4u+nK+7mcQHsj4r7bXJs8/N4lzWSzRMgJ5cVJCwPNkn9lCIIZ3vs4lr
         dEoFEZd/2asBsODdE1ibyV27J6zYnazdXJQ9stUkJ6n4OthrybLuqWDdkTsZmoJd2cFS
         TJwVMYyVo0CD5J7VC5et4gcLY1B7IDsA4wqkdyYrit+sqY+1GRtWxHZxIiCgaRtZgHhp
         NrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3v6OowpnYirgnqzOWwi689L4QBKiJLs2zj4ksqvvcc=;
        b=NGSmjsoh7gyuEnKFqDTg2PPZZ7s2CeCD2UKYtwJwpQoPFr/HpqhlA/UKrXhJRIv+KL
         bL1/Quktb20C4wVU4XA+Z+mcd6onzyb6LrNPkKQqU8PQlBgriMmLzfTSyxjGgaWwkpwu
         wfBAQMiUrrW82ib0ln7HMG0iDONCACh/3Tle7LEvkekdhEnu32ivAxtYv9h/VhPb5p7q
         OmeUHTdG1+7tZ55oi+ZUxcYU299gnfBBkDBh46hjNQHLSdjUceRlfp5axXZ/Z5QOnLDl
         oAXS/GorFDo3Jtb9zW+o+8IGD+xKYcwVpzQ7KzyWXrAFhByitY9TYyB+lKD50JA+ddpB
         ApXA==
X-Gm-Message-State: AOAM531D3Kt7tyRuKQUan4IRyXzND529LqSausjmS53JAqZxdnBJ3Up2
        vcitZ+i7vQ6D9oPbutnxFkCt5MA0xM0ckA==
X-Google-Smtp-Source: ABdhPJw5ihkCBvjYf4qAnjBB+/mMqTqNwaxWqNM9Kkgfh83pHEl6CfFFh/sclY25TaWHQ06OUWcFMA==
X-Received: by 2002:ac8:744e:: with SMTP id h14mr5639102qtr.383.1616102145586;
        Thu, 18 Mar 2021 14:15:45 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id k126sm2857757qkb.4.2021.03.18.14.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:15:45 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v10 5/8] drivers: thermal: tsens: Fix bug in sensor enable
 for msm8960
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
 <20210217194011.22649-6-ansuelsmth@gmail.com>
Message-ID: <f19dddf4-2865-745c-5f48-4c547a88ac95@linaro.org>
Date:   Thu, 18 Mar 2021 17:15:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/21 2:40 PM, Ansuel Smith wrote:
> It's present a hardware bug in tsens VER_0 where if sensors upper to id
> 6 are enabled selectively, underfined results are expected. Fix this by
> enabling all the remaining sensor in one step.


It took me a while to understand this. It is most likely me! But please 
consider rewording.

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens-8960.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 86585f439985..248aaa65b5b0 100644
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
> @@ -132,11 +132,26 @@ static int enable_8960(struct tsens_priv *priv, int id)
>   	if (ret)
>   		return ret;
>   
> -	mask = BIT(id + SENSOR0_SHIFT);
> +	/* HARDWARE BUG:
> +	 * On platform with more than 5 sensors, all the remaining

Isn't it 6 ? At least according to code below it is.. You are checking 
for id > 5.

> +	 * sensors needs to be enabled all togheder or underfined
> +	 * results are expected. (Sensor 6-7 disabled, Sensor 3
> +	 * disabled...) In the original driver, all the sensors
> +	 * are enabled in one step hence this bug is not triggered.

Also with this change, you should add a check in this function to see if 
the sensors are already enabled and if yes return back. The enabling 
call from tsens.c happens for every single sensor. But at sensor number 
6 you are enabling rest of the sensors. There is absolutely no reason to 
keep doing this for rest of the sensors.

> +	 */
> +	if (id > 5)
> +		mask = GENMASK(10, 6);
> +	else
> +		mask = BIT(id);
> +
> +	mask <<= SENSOR0_SHIFT;
> +
>   	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);

I know this is not part of this patch. But you mention above that 
earlier you were enabling all sensors one shot. Now that this is being 
done one at a time, is it needed to do a SW_RST every time ?

>   	if (ret)
>   		return ret;
>   
> +	reg |= MEASURE_PERIOD;
> +
>   	if (priv->num_sensors > 1)
>   		reg |= mask | SLP_CLK_ENA | EN;
>   	else
> 

-- 
Warm Regards
Thara
