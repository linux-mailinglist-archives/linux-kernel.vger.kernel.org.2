Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FC36FEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhD3Qhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3Qhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:37:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0734DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:36:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d4so2826242wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ukke2EarrCZ6LZGmPgLhnaE6LpNng0t5cCCCGZbWno=;
        b=akR6FJa9nUWRslrIQI8F8HEmUFR/xRFaENe0ub5k2+RSDZs09JwEAr7X9IQQj2W7Er
         KbS5j4k69UG19d2R/es3nGN2LK3kSl5iaLhNIVnQUhcf3ppIz6v5VVRQhjqZU3NwjKr2
         6Pz096l/+ePpuTTQ0eLYORC+tkx9vKy0Kr9kyaEVQIhtvgYjeXBVf+spDntvfSd0D1ZV
         6oMgS/3y8tM88XezCt3XqFkdd4JJQN9kxUu/iRLGF6uicngLh6DuBEAyD4d+ZXLDVPAr
         qd8YZtKsVjT/JtCBzlS0TU64Jo4bYKUmH841Q8kuss4HXxOKdHM4KYv9eeI0y0LjLaPe
         ojKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ukke2EarrCZ6LZGmPgLhnaE6LpNng0t5cCCCGZbWno=;
        b=NStis0Qnj8C8z+CBwEIoUopuMPwnus2yMA4kxcRySD9jy31VEB+7Gd//6mRmTyo25H
         k8qKVTgvVpREGRjM2dYjyd/tgS6ORi01oZwL6gKW8HmUV4BieIcAKpFsYrlLQ/rJiSIT
         D05GSplWRHV8yHlbHlWpOIHLV5fNeyy2u5I+XAg+kpa8gxVpQnuQLJw4qPfZc+oVhzXT
         pZz5BYNKmkLMz8T3Otv8nxK+Msbb5K106LN1ru2qeaj0FmsZcSs0t4cMBdWUjI1m5qeL
         VqIJIfcZryKf9f+eAxL1xOO5Cjwu/BxfTL4tlkW4hN8FcgQ2T0F989T6efZpEwPFi6a2
         QFLg==
X-Gm-Message-State: AOAM532sbdVDrYHOgwtGSA2uJt64868AJZUe6oUqUD8QMVvCSdJKq1gA
        PzAgUJTeL3GrSidEftiZuJzc23p9C/e1GMLt
X-Google-Smtp-Source: ABdhPJyJU+B1+ATEMQ+DZYinDU4nZ4BEMacdGMARtzR6/CSdMCzk3r7QR+wKBz5nlJ49wvt59sQpGQ==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr8196116wrq.137.1619800611233;
        Fri, 30 Apr 2021 09:36:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n3sm3464730wmi.7.2021.04.30.09.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Apr 2021 09:36:49 -0700 (PDT)
Subject: Re: [PATCH v2] ASoC: codecs: lpass-wsa-macro: handle unexpected input
To:     trix@redhat.com, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210430142117.3272772-1-trix@redhat.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <647db8c8-2ee0-0dee-51e5-41120566bb5e@linaro.org>
Date:   Fri, 30 Apr 2021 17:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210430142117.3272772-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Tom for fixing this.

On 30/04/2021 15:21, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> 
> lpass-wsa-macro.c:1732:6: warning: Array subscript is undefined
>          if (wsa->ec_hq[ec_tx]) {
>              ^~~~~~~~~~~~~~~~~
> 
> The happens because 'ec_tx' is never initialized and there is
> no default in switch statement that sets ec_tx.  Add a default
> case that returns an error before the array is accessed.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2:
>    - handle the input error, keep switch
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 1a7fa5492f28..d3ac318fd6b6 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1727,6 +1727,10 @@ static int wsa_macro_enable_echo(struct snd_soc_dapm_widget *w,
>   		val = val & CDC_WSA_RX_MIX_TX1_SEL_MASK;
>   		ec_tx = (val >> CDC_WSA_RX_MIX_TX1_SEL_SHFT) - 1;
>   		break;
> +	default:
> +		dev_err(component->dev,	"%s: Invalid shift %u\n",
> +			__func__, w->shift);
> +		return -EINVAL;

With the existing code we should never even touch this default path,

However the changes look safe to me,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini


>   	}
>   
>   	if (wsa->ec_hq[ec_tx]) {
> 
