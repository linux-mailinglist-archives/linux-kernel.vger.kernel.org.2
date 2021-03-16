Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20433CD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhCPFqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhCPFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:45:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37663C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:45:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l2so21888635pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/+IKrV96dIi8qPBX0pnaaLOL6NfRccdvv5EaD8vcl4=;
        b=k7Ri1jMqZ+in2gE0WerwdzenSZYjVE0nzHx9AE/q7YyacJqh/0JKzq1ziojSseqYD3
         v8NqL9OEzYGI/VE8q4FgT/BVXhNquAgngz518GDNZj9gXu/MzKT1vu6m8WUDKHzc4hJ1
         MhLd6i8VMHwCa27+A/fmY1sAtHTH6mdVdCbAV/Bxy0FaT5Ng4qlmDShlsfbqniqFzIb4
         WEQCvEoQ2Nkn0uGfPAJJVvI3XwjiNlS7Pv5JnWOjap5MyKu+zTobTFo+YOH75WxeJGxh
         INzWGIFiOAEMdT5+MqVQZACldk35pCxnzRnwYRNCYCxvg0iwcUG/v5HS5RP6E8Ea5LgC
         80TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/+IKrV96dIi8qPBX0pnaaLOL6NfRccdvv5EaD8vcl4=;
        b=q/R06/imSULlJ1i5vAdpVfRHeEiU4FgJEbgYeMEg648prL2oSYLLM6iXxCWUJqmFqf
         aYNG+RpapTOO14npAFtso3sJRG4rfltqYvosS08gf9MZuIujjrark90eZ/D36oFE6B2X
         Gi7ZjU4iABuiPF+GiNe+8rAAkMAIYNwdjgHk9UdSlfQ5DEV4dnem1qRavefw7UgDDdLD
         J4QaIf9emTmuQrfkJvqaS3aPKFV2CWAiNqZWooEOOiDre80uvLmcsTvQp+dA3m2BU9qi
         zsok2KAg73j3473oMzUOd8Of5gVYckfgneELdI0MYYkGDVAA1RETPmUcmPkFNu7rf0a3
         pPvQ==
X-Gm-Message-State: AOAM533Ed7yy34Vl2q6zqOC7iRc2O47+yBv5RztHnzAneE5vfKxvsFWQ
        ieVD8CGqIaLCQHcjEn90/gsZ
X-Google-Smtp-Source: ABdhPJwj7EYl3XYBTET6bFqagFWDNt1ovBkK0XxtKpD9L5BoCZzHwHlEOyEsr9L1ErbplLSiNLbR+w==
X-Received: by 2002:a63:fa05:: with SMTP id y5mr2406681pgh.154.1615873554253;
        Mon, 15 Mar 2021 22:45:54 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id na8sm1362134pjb.2.2021.03.15.22.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:45:53 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:15:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl
 S500 SoC
Message-ID: <20210316054547.GD1798@thinkpad>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <58225ced4893018792d581c0476a0f1c70e08907.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58225ced4893018792d581c0476a0f1c70e08907.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:18:29PM +0200, Cristian Ciocaltea wrote:
> There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> clock chain involving AHPPREDIV, H and AHB clocks:
> 
> * AHBPREDIV clock is defined as a muxer only, although it also acts as
>   a divider.
> * H clock is defined as a standard divider, although the raw value zero
>   is not supported.

What do you mean by not supported? The datasheet lists "0" as the valid divisor
value for divide by 1.

Rest looks good to me.

Thanks,
Mani

> * AHB is defined as a multi-rate factor clock, but it is actually just
>   a fixed pass clock.
> 
> Let's provide the following fixes:
> 
> * Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
> * Add a clock div table 'h_div_table' for the H clock to drop the
>   unsupported 0 rate and use the correct register shift value in the
>   OWL_DIVIDER definition.
> * Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
>   ungated OWL_COMP_FIXED_FACTOR definition.
> 
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/clk/actions/owl-s500.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index abe8874353de..b9e434173b4f 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -151,9 +151,9 @@ static struct clk_factor_table hde_factor_table[] = {
>  	{ 0, 0, 0 },
>  };
>  
> -static struct clk_factor_table ahb_factor_table[] = {
> -	{ 1, 1, 2 }, { 2, 1, 3 },
> -	{ 0, 0, 0 },
> +static struct clk_div_table h_div_table[] = {
> +	{ 1, 2 }, { 2, 3 }, { 3, 4 },
> +	{ 0, 0 },
>  };
>  
>  static struct clk_div_table rmii_ref_div_table[] = {
> @@ -184,7 +184,6 @@ static struct clk_div_table nand_div_table[] = {
>  
>  /* mux clock */
>  static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
> -static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
>  
>  /* gate clocks */
>  static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
> @@ -197,16 +196,25 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
>  static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
> -static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> +static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, h_div_table, 0, 0);
>  static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
>  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
>  
>  /* factor clocks */
> -static OWL_FACTOR(ahb_clk, "ahb_clk", "h_clk", CMU_BUSCLK1, 2, 2, ahb_factor_table, 0, 0);
>  static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table, 0, 0);
>  static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
>  
>  /* composite clocks */
> +static OWL_COMP_DIV(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p,
> +			OWL_MUX_HW(CMU_BUSCLK1, 8, 3),
> +			{ 0 },
> +			OWL_DIVIDER_HW(CMU_BUSCLK1, 12, 2, 0, NULL),
> +			0);
> +
> +static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
> +			{ 0 },
> +			1, 1, CLK_SET_RATE_PARENT);
> +
>  static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
>  			OWL_MUX_HW(CMU_VCECLK, 4, 2),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
> -- 
> 2.30.1
> 
