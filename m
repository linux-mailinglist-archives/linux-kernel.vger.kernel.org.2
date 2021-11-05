Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58C44612B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhKEJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKEJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:13:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B3C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 02:11:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d5so12674126wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VNkeQU62dCY789Bl5jyei5Z7Cvsl7VpmBZtGziLEC0s=;
        b=Q3qRdL+n62BjXpnmDLkiDZ6ExmGaaoAu9AdFx7tycXYPMng6WgsX5DM/61K/wPYQ+f
         I1UmfOonFAFtlVtRvAA9NSspGMTJVCmJ4dcVgdYvwU3KOGLMlzi7u0CRVFzYpD70TvW7
         R5MrBpYCnrzxRhNY35icnH2wXWmnrLzG/kajOA1m+NNypJPejlFS6EGiyK2Pf9wR9HUi
         n5QWSDWThuDTlDDyGctQcsuwYuNAkASjrjKFdIKCxKeF6cgFMlSzmiRXNRBZkhe0ZPZ2
         ZRmwIVlhj4kcsMuwmZ4NIs29aHvxGOyefvmy5UwrBb7BqjVQx98oWI5sJ0tQqnevbtRH
         3SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VNkeQU62dCY789Bl5jyei5Z7Cvsl7VpmBZtGziLEC0s=;
        b=ms8/HS5dNvEovlSQcvuGVF4aGPAnA5e8JwBPhowRMIr8FNkRSKdnSUm1Ra9r2EVcci
         GSl152IuenNKiVhlsniF900gdlNiurNE6MDNQfXmAkNOhIwYSEx3Uryg6kGv7yQYkKrV
         7RM56F/BhG7Yww8R+l9HTPy/bVsGZVeA9OwPP9KbeHBuYVgVBOwYo6pgtmwysKqn6LT6
         gmiB4bCXgudXF0zhNK1IRR8ZIXs5V9c26oef+6xrRMcrcykCv+e0iKzU+usvNA4XmGfD
         aA3LQEGw5xntpfSqFOpti5cSffA3WR4LcgW6PcEsbjAZXwPzxOdS6OMwoChdOyQ2mekJ
         e2Gg==
X-Gm-Message-State: AOAM532wlvTwTtTaukJ0Y3xmqPm+l4bfyBV1cj22mykQB/51VBGUYZZs
        YDnFQpd3bf8Jb1Om1YOBTlaauQ==
X-Google-Smtp-Source: ABdhPJwovJHtZyhpRSHPfG/+AmGNjDXxw16eSDl9PENlmHdNrJgryJIAMC2FF7g6ta2P2X/quWi9IQ==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr38164801wry.110.1636103462587;
        Fri, 05 Nov 2021 02:11:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id f3sm10566819wmb.12.2021.11.05.02.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:11:02 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codecs: Axe some dead code in
 'wcd_mbhc_adc_hs_rem_irq()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, yang.lee@linux.alibaba.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <837b3278-ca6d-b013-03f2-e6a681886578@linaro.org>
Date:   Fri, 5 Nov 2021 09:11:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2021 19:19, Christophe JAILLET wrote:
> 'hphpa_on' is know to be false, so this is just dead code that should be
> removed.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini


> ---
> This patch is a follow-up of:
> https://lore.kernel.org/kernel-janitors/988948f7f266aa00698704687537335b7e6a67b2.1634455711.git.christophe.jaillet@wanadoo.fr/
> ---
>   sound/soc/codecs/wcd-mbhc-v2.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 405128ccb4b0..b905eb8f3c67 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -1176,7 +1176,6 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
>   	struct wcd_mbhc *mbhc = data;
>   	unsigned long timeout;
>   	int adc_threshold, output_mv, retry = 0;
> -	bool hphpa_on = false;
>   
>   	mutex_lock(&mbhc->lock);
>   	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
> @@ -1210,10 +1209,6 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
>   	wcd_mbhc_elec_hs_report_unplug(mbhc);
>   	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_ISRC_CTL, 0);
>   
> -	if (hphpa_on) {
> -		hphpa_on = false;
> -		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
> -	}
>   exit:
>   	mutex_unlock(&mbhc->lock);
>   	return IRQ_HANDLED;
> 
