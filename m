Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40333EB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCQIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhCQITu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B25864F96;
        Wed, 17 Mar 2021 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615969190;
        bh=4yKu9VDlHkcv0zuSCsLQWbJ6QFg9jp9i/0uWyfylwF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KKz2N9EceRi5DoHpwycCjdEkagsWwXbpblOET9ldxgBI1kJv/egj0J2PbQ/GO4goF
         OsQICnd303ZNSbTgG6mOqmzSiKSgNuKZsqjeAFir4Gy9gg4m6iE5EfzB02ZRn8xBo7
         YKCljROt8l6RprEvFsNwaY0TI+ogEX1Suh31++Vddm/GJ6nR4/27uRZn/v3/jQ2uaZ
         WJNnQFetDYfIodE0o1SW8ikvv/hLruak/Fv0t32YKnHaELQLfBNA/pUTMevlHSy6QA
         hLGdel3myRrFQTu9GrdgN2LUJ78tPGPzs7HaihHTbUByantLUveZxOxbVpWKjetxeM
         hbfCzDSatt6vA==
Subject: Re: [PATCH] drm/tilcdc: fix LCD pixel clock setting
To:     Dario Binacchi <dariobin@libero.it>, linux-kernel@vger.kernel.org,
        Jyri Sarha <jyri.sarha@iki.fi>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20210314151342.23404-1-dariobin@libero.it>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <7df3a270-1cc4-7a71-5e55-49a0dfb2c21f@kernel.org>
Date:   Wed, 17 Mar 2021 10:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210314151342.23404-1-dariobin@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 17:13, Dario Binacchi wrote:
> As reported by TI spruh73x RM, the LCD pixel clock (LCD_PCLK) frequency
> is obtained by dividing LCD_CLK, the LCD controller reference clock,
> for CLKDIV:
> 
> LCD_PCLK = LCD_CLK / CLKDIV
> 
> where CLKDIV must be greater than 1.
> 
> Therefore LCD_CLK must be set to 'req_rate * CLKDIV' instead of req_rate

The above doesn't make sense, the code already sets LCD_CLK to 'req_rate 
* clkdiv', not req_rate.

> and the real LCD_CLK rate must be compared with 'req_rate * CLKDIV' and
> not with req_rate.

This is true, the code looks at the wrong value.

> Passing req_rate instead of 'req_rate * CLKDIV' to the tilcdc_pclk_diff
> routine caused it to fail even if LCD_CLK was properly set.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> 
> ---
> 
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 30213708fc99..02f56c9a5da5 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -203,7 +203,7 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
>   	struct drm_device *dev = crtc->dev;
>   	struct tilcdc_drm_private *priv = dev->dev_private;
>   	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> -	unsigned long clk_rate, real_rate, req_rate;
> +	unsigned long clk_rate, real_rate, req_rate, clk_div_rate;
>   	unsigned int clkdiv;
>   	int ret;
>   
> @@ -211,10 +211,11 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
>   
>   	/* mode.clock is in KHz, set_rate wants parameter in Hz */
>   	req_rate = crtc->mode.clock * 1000;
> -
> -	ret = clk_set_rate(priv->clk, req_rate * clkdiv);
> +	/* LCD clock divisor input rate */
> +	clk_div_rate = req_rate * clkdiv;

"clk_div_rate" sounds a bit odd to me. Why not lcd_fck_rate, as that's 
the name used later? Or lcd_clk_rate. Or maybe lcd_clk_req_rate...

> +	ret = clk_set_rate(priv->clk, clk_div_rate);
>   	clk_rate = clk_get_rate(priv->clk);
> -	if (ret < 0 || tilcdc_pclk_diff(req_rate, clk_rate) > 5) {
> +	if (ret < 0 || tilcdc_pclk_diff(clk_div_rate, clk_rate) > 5) {
>   		/*
>   		 * If we fail to set the clock rate (some architectures don't
>   		 * use the common clock framework yet and may not implement
> 

I think this fix is fine, but looking at the current code, it's calling 
tilcdc_pclk_diff(), but doesn't actually provide pixel clocks to the 
function, but fclk.

  Tomi

