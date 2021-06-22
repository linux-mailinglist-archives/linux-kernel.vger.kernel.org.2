Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94463B026E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFVLLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhFVLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:11:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA61C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:08:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f15so7704982wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lq66Xjw5phBkXkJlrRj1+NbFKwtWmVfKpej/PiTxwz8=;
        b=lu/XpFbeQPRb3Kmlu2wIqg2ziWjqCteY1wketnLaG+eeKF2gnNuY6/TXszGZKzwLZX
         G0x4PUBL6KuhSN6ZhsePGOG+FKmWhlYahIl0sVH9WQ0N++7uGontZRdwlAvHFHYnL0ct
         YdgcVmIxpxXt48KHwuTpV90rphOmzxZQP3K+hpP5jaappI3/vQG6dH5Z9J/p3SwhLvhj
         qb0TkShFTp4A9RHYZ734dRU/KjTmwDJkhq/u/fO6+CCDEBZOIBF+iEx9aX3bELtzG/D+
         dtk85tcmBV4Y8gH4zabe61pGw1Epk2eLSzXD2PxSrvny1h9HggAmi7Rl9QRaI0NFUK68
         lGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Lq66Xjw5phBkXkJlrRj1+NbFKwtWmVfKpej/PiTxwz8=;
        b=rtVI8r3vYRph1PnKTrXiMN4umaJbDFg+XD2OSMtyLLRFUevA01g0B+b5Kul+rptTTg
         nbnt9aD0zGeU9cTmY5tzKqmHLmADGJz9H2DMwNDCzAiL7dbjAPp45y3OnZPmjaz9uvxM
         CZMCgHb5fyPQxQ5rhtryj5pt2daQarO3/1fADKUO+fMx1m8TZ8xq9iXhydXnTnVlx6P6
         7bG27iEa9SKdsvr83gJ4/eUSW4bxC7eIHaFh+UmpJ6TKQf49yBYxdzOtQ0ZOPfmy+5B4
         rpzNc92xFX5hg50KGJoOwQ5mxd7GIkh3rgWy3ggnmvDWprrgdX40V5KsUd+B3B/IsC2F
         x4OQ==
X-Gm-Message-State: AOAM530syYhtz7zGypHa26ZsWXuxDE4o+0p6Ob5np/pnYzm3webZQaz4
        /VuTEA8dA1gzFe2odnf6uvry/Q==
X-Google-Smtp-Source: ABdhPJwjDHkvFKgWlzcHBiFhM7t70Wscz+aLHos8OuzpYf1kseMkyODFDMtCSJ5qqjmtXYvMLmoTXg==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr3965814wru.318.1624360133978;
        Tue, 22 Jun 2021 04:08:53 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:de9f:b167:e2fd:3d94? ([2001:861:44c0:66c0:de9f:b167:e2fd:3d94])
        by smtp.gmail.com with ESMTPSA id b7sm7101142wrw.20.2021.06.22.04.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 04:08:53 -0700 (PDT)
Subject: Re: [PATCH] watchdog: meson_gxbb_wdt: improve
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, khilman@baylibre.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
References: <20210622095639.1280774-1-art@khadas.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <bfa12322-bc49-2337-2988-199e87e34b87@baylibre.com>
Date:   Tue, 22 Jun 2021 13:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622095639.1280774-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Art,

On 22/06/2021 11:56, Artem Lapkin wrote:
> Improve meson_gxbb_wdt watchdog driver
> 1) added module param timeout and nowayout same as other modules
> 2) print watchdog driver start status
> 3) add watchdog_stop_on_unregister
> 4) remove watchdog_stop_on_reboot ( still can be activated by
> watchdog.stop_on_reboot=1 ) i think this driver configuration more useful
> becouse we can get reboot waranty for abnormal situations on shutdown stage

Can you split the patch in 4 distinct changes ?

Neil

> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/watchdog/meson_gxbb_wdt.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 5a9ca10fbcfa..15c889932c13 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -35,6 +35,17 @@ struct meson_gxbb_wdt {
>  	struct clk *clk;
>  };
>  
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +static unsigned int timeout = DEFAULT_TIMEOUT;
> +
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds="
> +			__MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +
>  static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
>  {
>  	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> @@ -174,7 +185,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	data->wdt_dev.ops = &meson_gxbb_wdt_ops;
>  	data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
>  	data->wdt_dev.min_timeout = 1;
> -	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
> +	data->wdt_dev.timeout = timeout;
>  	watchdog_set_drvdata(&data->wdt_dev, data);
>  
>  	/* Setup with 1ms timebase */
> @@ -186,7 +197,12 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  
>  	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>  
> -	watchdog_stop_on_reboot(&data->wdt_dev);
> +	watchdog_set_nowayout(&data->wdt_dev, nowayout);
> +	watchdog_stop_on_unregister(&data->wdt_dev);
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
> +		data->wdt_dev.timeout, nowayout);
> +
>  	return devm_watchdog_register_device(dev, &data->wdt_dev);
>  }
>  
> 

