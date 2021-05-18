Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A94387389
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347291AbhERHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbhERHv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:51:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F92C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:50:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so910130wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mA1mK0+fQE9/tWWJ52jiHZ2px5uCbZhPu9foxVoORVE=;
        b=BMRVYMGPoqUoIM1+3P/qV2PqvGuHGfAWEFkAdkHQadEkf0+TYNk16srPsG6IlYh7lK
         BSKcVVTiGPpzP3frfC/ujxdSsTc4065WO8mxdZqkhVM2NF7U55g/CZeVj+wgn42mWr/1
         aZY3oMqLUvhBQlqST3R2cjF/FfSk6Hr8sXjmBZt/75K3eB49XCLb2OhaPueya+h6rCvL
         laoCmhisKRAQngbhCFq+l8kV7zoP8FAR0mxtDQGW0P61kH1waPNAZdJav4RqOKI61NG/
         QxlG3ADKmavBlvYzwgznXTu/PAh1NY+yM/wQllfkdlD8OZV0eHNF+38Y1MLsbHwoNIpn
         KCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mA1mK0+fQE9/tWWJ52jiHZ2px5uCbZhPu9foxVoORVE=;
        b=heD7YYjprMaEBX8a1fj9r2g37l9TAjEZReOHTJmfVaXwuyqbgCR7hCj62v/D6zeeXC
         cWmA2hMn1xBSjwmF3zb6zS626i0Od8AyVYF/Rq8RumR/+JRbDOgSDIUKg5Fc0vyrhIBd
         yW4NeZSu1x9yo1r97IS6GVDvybkoq3K0ykZts7twv3ZtZO93UoFZKxwogPPv8DPMoCwJ
         0hZVqUxwRohW6V1421Axw2iv4lzyrZW5zl4XtIJOUjcqj1BVOW5404L3F7Zy79v6eqP8
         dkz19519yMzwF7ln7RPjBf1v88ERyfA890iUe1lhdMThxGOEzSMq8HgS9iGbBgB8CDHq
         9Fdw==
X-Gm-Message-State: AOAM5317YXpAV/bUWwdjYlpSrgPwn5jd63eVkk0u/Mdp4bqx+UmIchCP
        FdhP9z8GDjv7G5TK1no6Lc3rOQ==
X-Google-Smtp-Source: ABdhPJzVVjWOzZjstMGH6oqwvQ9v8NQT386nZ8AwtHPb0QX7ljoBUK7xowqnIVc15vkLz9dBpk+gkw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr3477659wmo.180.1621324237237;
        Tue, 18 May 2021 00:50:37 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id h9sm16657780wmb.35.2021.05.18.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:50:36 -0700 (PDT)
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
 <20210517203724.1006254-4-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v1 3/3] clk: meson: pll: switch to determine_rate
 for the PLL ops
In-reply-to: <20210517203724.1006254-4-martin.blumenstingl@googlemail.com>
Message-ID: <1jo8d81nw3.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 18 May 2021 09:50:36 +0200
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

Looks good. I see no reason to keep this one as RFC.
I can take it directly if this is OK with you ?

> ---
>  drivers/clk/meson/clk-pll.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 49f27fe53213..9e55617bc3b4 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -242,8 +242,8 @@ static int meson_clk_get_pll_settings(unsigned long rate,
>  	return best ? 0 : -EINVAL;
>  }
>  
> -static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -				     unsigned long *parent_rate)
> +static int meson_clk_pll_determine_rate(struct clk_hw *hw,
> +					struct clk_rate_request *req)
>  {
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> @@ -251,22 +251,26 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long round;
>  	int ret;
>  
> -	ret = meson_clk_get_pll_settings(rate, *parent_rate, &m, &n, pll);
> +	ret = meson_clk_get_pll_settings(req->rate, req->best_parent_rate,
> +					 &m, &n, pll);
>  	if (ret)
> -		return meson_clk_pll_recalc_rate(hw, *parent_rate);
> +		return ret;
>  
> -	round = __pll_params_to_rate(*parent_rate, m, n, 0, pll);
> +	round = __pll_params_to_rate(req->best_parent_rate, m, n, 0, pll);
>  
> -	if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
> -		return round;
> +	if (!MESON_PARM_APPLICABLE(&pll->frac) || req->rate == round) {
> +		req->rate = round;
> +		return 0;
> +	}
>  
>  	/*
>  	 * The rate provided by the setting is not an exact match, let's
>  	 * try to improve the result using the fractional parameter
>  	 */
> -	frac = __pll_params_with_frac(rate, *parent_rate, m, n, pll);
> +	frac = __pll_params_with_frac(req->rate, req->best_parent_rate, m, n, pll);
> +	req->rate = __pll_params_to_rate(req->best_parent_rate, m, n, frac, pll);
>  
> -	return __pll_params_to_rate(*parent_rate, m, n, frac, pll);
> +	return 0;
>  }
>  
>  static int meson_clk_pll_wait_lock(struct clk_hw *hw)
> @@ -419,7 +423,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>   */
>  const struct clk_ops meson_clk_pcie_pll_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
> -	.round_rate	= meson_clk_pll_round_rate,
> +	.determine_rate	= meson_clk_pll_determine_rate,
>  	.is_enabled	= meson_clk_pll_is_enabled,
>  	.enable		= meson_clk_pcie_pll_enable,
>  	.disable	= meson_clk_pll_disable
> @@ -429,7 +433,7 @@ EXPORT_SYMBOL_GPL(meson_clk_pcie_pll_ops);
>  const struct clk_ops meson_clk_pll_ops = {
>  	.init		= meson_clk_pll_init,
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
> -	.round_rate	= meson_clk_pll_round_rate,
> +	.determine_rate	= meson_clk_pll_determine_rate,
>  	.set_rate	= meson_clk_pll_set_rate,
>  	.is_enabled	= meson_clk_pll_is_enabled,
>  	.enable		= meson_clk_pll_enable,

