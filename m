Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6013B9BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhGBExz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhGBExz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:53:55 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79CC061762;
        Thu,  1 Jul 2021 21:51:22 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id u14-20020a4ae68e0000b029024bf1563f62so2176683oot.3;
        Thu, 01 Jul 2021 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fl3RRQ8JlBE7JT/rEaWxXtVTS4iBTwFO46Y8JLyFuGE=;
        b=o17h6n8GeFl1kWMxqCC6Qs80DUFWL5jf3xXvqDcuAIrNZQt5EdviBR4QW9SRn78Zor
         9Z7uCI7AulUnJoIconJC6AN3Fxvj8UtXZkBKShaVrH1trlewcP6VP2/gXoeE+QZUHCbe
         bChpLATOaclcyGmf5P+btaRFu+c0q1s2HhAokCLYuSgJSfljcoJwv4319wyadtqYjCm3
         QTcOzqvAQzJ0mfeib8OgOlRxjEeK/dRKW+1ALdhyx4mPRQwfpg9jzNfigFRX2WQubT3s
         WpCXpivrKyQotwsufVHE7lVoA3TaX+Hk9yStUlkb2cUxHNGxuum266oL65tI54LBVG/2
         VkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=fl3RRQ8JlBE7JT/rEaWxXtVTS4iBTwFO46Y8JLyFuGE=;
        b=A4lQp3719jQJXVc1YkSTUmsGjG9wMoLSjbOLoRGmtLR651j0OYRs5UUOSKTSOb50sy
         p/ET+urDNijSqMHiwUxEurn36oKvOiyp2iB9CaFzrLWvqDTvDMwJVBqdEgAwfv1retgi
         Y20XUsUNkEYH6oP+qVDmkumgZI2PjP3dLDS47WXSXj4cVJ6E6zOwKnUTY+VkchUa1kGw
         KnfUsng1oiGSChB1GmugmSyNkLG6PIU0BCA1RtQXt2445SIadOpK2sk5f7RSg9Ovr34k
         AupahYRo0CEmkBGQOF9ia7IJsuGXnMGyT1ONc1xvA2NboHLeF6l0MwLvh0KCXkg6BSTp
         ruUw==
X-Gm-Message-State: AOAM5314+qpD0U9FYW2mZb2CINg7V6rgTY9UDT3C/NDXaYmN2CC3yO9w
        nuvPfjyMje6q0Sqg2ncqE+A=
X-Google-Smtp-Source: ABdhPJxe/LIIOstbfZiJct8I1S9BLCR/TEOiW+ou5onQbkoOhUQvbS0yB4JOzR+ygMRc5hWXPnHXOg==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr2797799oou.23.1625201482101;
        Thu, 01 Jul 2021 21:51:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a44sm399880ooj.12.2021.07.01.21.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 21:51:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Jul 2021 21:51:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] Revert "clk: divider: Switch from .round_rate to
 .determine_rate by default"
Message-ID: <20210702045120.GA3079423@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 06:10:58PM -0700, Stephen Boyd wrote:
> This reverts commit db400ac1444b756030249ed4a35e53a68e557b59. We have
> drivers that are still using the .round_rate ops from here. We could
> implement both determine_rate and round_rate for these divider ops, but
> for now let's just kick out the commit that tried to change it and
> convert various drivers properly.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: db400ac1444b ("clk: divider: Switch from .round_rate to .determine_rate by default")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/clk/clk-divider.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 9e05e81116af..87ba4966b0e8 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -425,8 +425,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
>  }
>  EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
>  
> -static int clk_divider_determine_rate(struct clk_hw *hw,
> -				      struct clk_rate_request *req)
> +static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *prate)
>  {
>  	struct clk_divider *divider = to_clk_divider(hw);
>  
> @@ -437,13 +437,13 @@ static int clk_divider_determine_rate(struct clk_hw *hw,
>  		val = clk_div_readl(divider) >> divider->shift;
>  		val &= clk_div_mask(divider->width);
>  
> -		return divider_ro_determine_rate(hw, req, divider->table,
> -						 divider->width,
> -						 divider->flags, val);
> +		return divider_ro_round_rate(hw, rate, prate, divider->table,
> +					     divider->width, divider->flags,
> +					     val);
>  	}
>  
> -	return divider_determine_rate(hw, req, divider->table, divider->width,
> -				      divider->flags);
> +	return divider_round_rate(hw, rate, prate, divider->table,
> +				  divider->width, divider->flags);
>  }
>  
>  int divider_get_val(unsigned long rate, unsigned long parent_rate,
> @@ -500,14 +500,14 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  const struct clk_ops clk_divider_ops = {
>  	.recalc_rate = clk_divider_recalc_rate,
> -	.determine_rate = clk_divider_determine_rate,
> +	.round_rate = clk_divider_round_rate,
>  	.set_rate = clk_divider_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ops);
>  
>  const struct clk_ops clk_divider_ro_ops = {
>  	.recalc_rate = clk_divider_recalc_rate,
> -	.determine_rate = clk_divider_determine_rate,
> +	.round_rate = clk_divider_round_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
>  
> 
> base-commit: 498cc50b3fa99b545532dc433d53d3c0b889cc98
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 
