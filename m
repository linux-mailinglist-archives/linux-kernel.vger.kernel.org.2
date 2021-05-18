Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5B387382
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhERHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347263AbhERHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:49:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA31FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:47:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so904550wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=qbYhZ0j3U7IXcdLANW6Ri1lM6U26+3AlkXH54c6o33U=;
        b=UNsPc7NxgufwBvAxSN+WYxjkS2wP7YKuiSTAO7fTBlrx/MXk+8EAEXbijP/ncLJppV
         YKZwrNuPv7BHS+5JF9a2f2mrChqUm8Wm30714fyBi5RGDFFT/3u28/M6Dq/ytavc4/Cm
         YFGoYw75AF05UHj8+dO72HXzxU4ztfGlP4CRpZLvb2z+qX7eTsPdDUQD4X3T2Td/8P5M
         OTX6yFpjac7arJZg1O5HVRCtB9e4Yf+Pk2wDTqBTiywkFhLH/kdYr7ycSm0EYpgGFJGm
         6dQ7lY47+udLjko7x7r0B3k6MLh04dYisbni7GEtbw4B+04zstbs5XCaAwH5k9Sowuzh
         Tf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=qbYhZ0j3U7IXcdLANW6Ri1lM6U26+3AlkXH54c6o33U=;
        b=o1GYCnO7ER0qnh/+QFVNT1nrDN6gyc8TMg+WLH6MqxcLxr1Kpb270CiHFWhw/iM7FW
         gbTXu/qBVD5yllnJqz2QcThmhHnaatbFEUHFBYasVuRlPR7b8VvtOtp2+M4U+kPX3hZZ
         8wCaVdZQcBcxkoQBbZi7TMsYY3hqlOJp4T5a7QLLEATiqdvqXeOxmdxAU7ojD5CLFNh7
         RO1DYySVwXpv1fjh9Mcwn7NDGWcGxLHPJGLvG1QjG/lie8eu6sryIvHkfOyYY3FFanCr
         IIUEQOCxpUMNB9bjqnYVdzXuww7C66XEVvlRbTUKdmteWMA94+mvPf1Y4tE70xFkmD/u
         tR7w==
X-Gm-Message-State: AOAM530vyzKG0cVeLAE6jrKFYjR6G+6l1Bl1KIIkNric5WNstQb3bSuJ
        mAgsU+tyw2mA8ZSzjEwidePgQQ==
X-Google-Smtp-Source: ABdhPJynC+inihhIFx014wY+OTem05Sqe/Rnseyfe0Fwn2uGEqzQBo+xrnoV58p3lDVwgvyj1pRh0w==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr3404815wmb.15.1621324071556;
        Tue, 18 May 2021 00:47:51 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id x11sm20088700wrl.13.2021.05.18.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:47:51 -0700 (PDT)
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
 <20210517203724.1006254-3-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v1 2/3] clk: meson: regmap: switch to determine_rate
 for the dividers
In-reply-to: <20210517203724.1006254-3-martin.blumenstingl@googlemail.com>
Message-ID: <1jr1i41o0p.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 18 May 2021 09:47:50 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 17 May 2021 at 22:37, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This increases the maxmium supported frequency on 32-bit systems from
> 2^31 (signed long as used by clk_ops.round_rate, maximum value:
> approx. 2.14GHz) to 2^32 (unsigned long as used by
> clk_ops.determine_rate, maximum value: approx. 4.29GHz).
> On Meson8/8b/8m2 the HDMI PLL and it's OD (post-dividers) are
> capable of running at up to 2.97GHz. So switch the divider
> implementation in clk-regmap to clk_ops.determine_rate to support these
> higher frequencies on 32-bit systems.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/clk/meson/clk-regmap.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index dcd1757cc5df..8ad8977cf1c2 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -75,8 +75,8 @@ static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
>  				   div->width);
>  }
>  
> -static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
> -				      unsigned long *prate)
> +static int clk_regmap_div_determine_rate(struct clk_hw *hw,
> +					 struct clk_rate_request *req)
>  {
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> @@ -87,18 +87,17 @@ static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
>  	if (div->flags & CLK_DIVIDER_READ_ONLY) {
>  		ret = regmap_read(clk->map, div->offset, &val);
>  		if (ret)
> -			/* Gives a hint that something is wrong */
> -			return 0;
> +			return ret;
>  
>  		val >>= div->shift;
>  		val &= clk_div_mask(div->width);
>  
> -		return divider_ro_round_rate(hw, rate, prate, div->table,
> -					     div->width, div->flags, val);
> +		return divider_ro_determine_rate(hw, req, div->table,
> +						 div->width, div->flags, val);
>  	}
>  
> -	return divider_round_rate(hw, rate, prate, div->table, div->width,
> -				  div->flags);
> +	return divider_determine_rate(hw, req, div->table, div->width,
> +				      div->flags);
>  }
>  
>  static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -123,14 +122,14 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  const struct clk_ops clk_regmap_divider_ops = {
>  	.recalc_rate = clk_regmap_div_recalc_rate,
> -	.round_rate = clk_regmap_div_round_rate,
> +	.determine_rate = clk_regmap_div_determine_rate,
>  	.set_rate = clk_regmap_div_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
>  
>  const struct clk_ops clk_regmap_divider_ro_ops = {
>  	.recalc_rate = clk_regmap_div_recalc_rate,
> -	.round_rate = clk_regmap_div_round_rate,
> +	.determine_rate = clk_regmap_div_determine_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_regmap_divider_ro_ops);
