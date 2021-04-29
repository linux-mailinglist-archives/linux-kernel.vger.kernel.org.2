Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6943D36E7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhD2JVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhD2JVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:21:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CBC06138E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:20:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so6247311wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=emtycNn+wWCzpWR3wOPRX/lfC7/b7fgfW6hulP1Fj7Y=;
        b=e+xfgr7nxfd1QlWEWsqxjy1GUZPA7ol9k+mWo0/8JLNUhvS0J4jmiBTTLfDxEradFq
         CIsxtz0S7SxSbc0qvNJyclrHPRSJoKUWSX82ziobYfkzic6lu1CJwOvrwXFy1JEn8DG6
         riIHtBrWT3/TJecwwZsUF56rWIPkKRAY06iNxlRjDM/cu5dyjOWlOXfHXVAyDbGyQDDU
         itrhfxwLXaAoAWzkdiS3cbP8Y6BhMOdJEwkBTLUBAtmwHaqrL0RQJugTwhjrSpkof4O9
         xsK5HjjySgkp+4Ki7kNyWs2+LPU8iM0GG1ZtoYg5PByLRn/upr8gWhOPaG5M+zOwEh6p
         //nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=emtycNn+wWCzpWR3wOPRX/lfC7/b7fgfW6hulP1Fj7Y=;
        b=TPWrOPeUQkmSu6ivB33UXsqZ+jSeeVc6WwTEN2m/LvUJOaXqQAKj+0LxIi7tnz5q/R
         G94Ynj8a/eDjFqCyoXJJVoUJ5+ZOUdJq4b27XMv8cRGXHgCXFJaGPWw/wxJft9K721XM
         h5geNyOxDYNXQE60rnQvYZBHSue3lx9mA67Ik52uwl05aaz7rRlJnm3SbWdGTT7Xe0f8
         C+D6T1MnLkVPSfjqYFJjso98b7kPb0ZE/0kxcQEJZ6AOk+aQh83RKxb14vBaYtcJPV1u
         PcA0jkGhxrXQveOueD/Utx+lLfRQaAlx4sgHVBztvgg5wNO17dsJWHtVLQLz3tsuSXYZ
         1TtA==
X-Gm-Message-State: AOAM530mZyBpAYr65NA2rVsmLEXga+UPfiYthdvG2ls3uw4SRnKYKuR7
        Bp4BuKsQZCWhpKflV2xy4EKRtStvo4jXyz7I
X-Google-Smtp-Source: ABdhPJz5ekuOvwFtm5X+ti48U3iGu1NlkQkbznQFO3DSiirw/PRy6N7TyqP6K1tEDIiQl8WB7C7+sQ==
X-Received: by 2002:a1c:1bca:: with SMTP id b193mr2500141wmb.28.1619688008970;
        Thu, 29 Apr 2021 02:20:08 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:c304:4b2b:4a79:1da9? ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id f6sm3835949wrt.19.2021.04.29.02.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 02:20:08 -0700 (PDT)
Subject: Re: [PATCH] clk: meson: axg-audio: do not print error on defer
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210429090516.61085-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ea42fa60-77cb-179b-ae2b-18b230383578@baylibre.com>
Date:   Thu, 29 Apr 2021 11:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429090516.61085-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 11:05, Jerome Brunet wrote:
> Do not print an error if we are just waiting for the reset controller to
> come up.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 7c8d02164443..5e501eff0840 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -1811,7 +1811,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  
>  	ret = device_reset(dev);
>  	if (ret) {
> -		dev_err(dev, "failed to reset device\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to reset device\n");
>  		return ret;
>  	}
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
