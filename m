Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C194337A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJSNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhJSNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:49:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F7C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:47:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e3so47566263wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOpjjqWh4RKFubSe9AsWzWR8dfmnNsfnQYnDdU7OniM=;
        b=VYJ9XI/xaWN9Yy6GOYJPd+BPtK62ZpNoVNKMH84MqJcJouT4goFsTy6DF278DFJ4+Q
         6pTqNTzVrzQZ3/12/mW3uwTIKNBjpbPCsc5qaQz1r8rt/6SwWTUQz5jeeXXPStgmLZUn
         yFwCja5WjwC7asT5yhnUroAsqG9hG/M21KmTbbkH5QsBVV5cMX1OMbkrfWqW477Y35Df
         D6Gc01MBQ9I5ldgZfUkMxCtZ3ns6kXY+o3QFxX3lCuVk2+nU9xHaDUpgY210qnojBJtK
         lWarIct7wDN/7FjphaBgFmC+qS6UfFjTiSMGn7gqQJFRe/3rVjZZ8sB3kneeD46pfbIr
         6i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOpjjqWh4RKFubSe9AsWzWR8dfmnNsfnQYnDdU7OniM=;
        b=KQh9G9VdLMN2A+SJ3eVwcKKCtYWB0rn/Wt325/67MUjpTHtRnNbNzmy5BbH4gf50Xu
         aH1OlpuiQGN8pTfId2SzSuDbr0xcgc39T+YMfC5XYJQj5Pjf+KRr4y0gA9Ts/2cRquQx
         poRQfHWNMz6oYqleHN7oN4c/s+IH5UXO6fB9yc913rjwT6RxEZbOcFqWB/nPkE8fO68U
         uYGZWpoiJ0yseHiiGDaxvv5nPARRoC/TFlud+f/FaJ8M/5IzzyoD2i9XL2vKhhl5hDEa
         BxnE0ohxCDhRE7i9iI1bkd3CnSdFeBWVdOMSXKJpE5hd4i4mbo6OLtx2z7ZXTIdb3Aiv
         8wZw==
X-Gm-Message-State: AOAM530jsn1JioUSdOXpifLvxReCXkv1zVWgOh35ZN3JaMEbHGcBGFLz
        Qo26Uo9toNNC/2N3Vs2sQI/yow==
X-Google-Smtp-Source: ABdhPJyKgSgSNsH0UdkObuwMPYZqgDLXJM5BiXzacKvhMe97dMMcbs9Ekgb0Mv2xOMRvvcUVzCnChQ==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr42935319wry.273.1634651235814;
        Tue, 19 Oct 2021 06:47:15 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i188sm2360130wmi.5.2021.10.19.06.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:47:15 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codecs: Fix WCD_MBHC_HPH_PA_EN usage
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, yang.lee@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3ff34912-19e6-4d52-e9da-0e78ceb1d2ff@linaro.org>
Date:   Tue, 19 Oct 2021 14:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/2021 08:31, Christophe JAILLET wrote:
> 'hphpa_on' is known to be false, so the if block at the end of the function
> is dead code.

Yes, this is a dead code we should remove it.

This code was part of moisture detection logic which is not enabled in 
upstream code yet.

During Moisture detection if the PA is on then we switch it off and do 
moisture measurements and at the end of the function we restore the 
state of PA.

> 
> Turn it into a meaningful code by having 'hphpa_on' be static. Use is as a
> flip-flop variable.

No, It does not.

Have you even tested this patch in anyway?

> 
> Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset detection support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The purpose of this patch is not to be correct (!) but to draw attention
> on several points:
>     - in 'wcd_mbhc_adc_hs_rem_irq()', the "if (hphpa_on)" path is dead code
>       because 'hphpa_on' is known to be false
>     - What is this magic number '3'?
>       All 'wcd_mbhc_read_field()' look for 0 or non-0
>     - a 'mutex_[un]lock()' in an IRQ handler looks spurious to me
> 
> Instead of this (likely broken) patch, it is likely that something is
> missing elsewhere. Maybe in 'wcd_mbhc_adc_hs_ins_irq()'.
> I also guess that 'hphpa_on' should be read for somewhere else.
> ---
>   sound/soc/codecs/wcd-mbhc-v2.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 405128ccb4b0..783d8c35bc1b 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -1176,7 +1176,7 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
>   	struct wcd_mbhc *mbhc = data;
>   	unsigned long timeout;
>   	int adc_threshold, output_mv, retry = 0;
> -	bool hphpa_on = false;
> +	static bool hphpa_on = false;
>   
>   	mutex_lock(&mbhc->lock);
>   	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
> @@ -1212,6 +1212,9 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
>   
>   	if (hphpa_on) {
>   		hphpa_on = false;
> +		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 0);
> +	} else {
> +		hphpa_on = true;
>   		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);

Just remove this dead code.

--srini
>   	}
>   exit:
> 
