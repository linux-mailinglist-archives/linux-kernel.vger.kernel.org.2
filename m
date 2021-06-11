Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA83A3AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFKEPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:15:12 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:55101 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKEPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:15:08 -0400
Received: by mail-pj1-f51.google.com with SMTP id g24so4936053pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZpAKBzRtum++A6I+sQPu1wrLWwSoIBCUNQ7Vp72lb8E=;
        b=fryvg3Qh73vZ5EZgeSi5omN3PED391AT8z36/quqA7pIW1a2JcrWsJ/wPANZhdilkq
         EL40BLy1XoW2Vnp+Z9R40RmrDZvOHWty98Nzcsmby+1ul3SgyfdGmK3MWqdeSOrHL3MA
         QAVA9uFE4wm1W1k/qGbaty+/cxsQmql3H9QnpR/jbO+SzexHCH11t0oZMnTMtAYNJnCB
         xcWqp+pKMaGsUTjHJN3o0bDKYFpLGILNjAd9hZnNryQamaisL0epRO54rF5oFcFr0RCS
         xcEzP1OKee3spwRv+yEilM9sGTu77La7/LOkEsthOo9Ou0xCl/tFW5MR3bPPRZXURDww
         BDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpAKBzRtum++A6I+sQPu1wrLWwSoIBCUNQ7Vp72lb8E=;
        b=XsyqLesCOGXQ4HVPmof2WwCBCAk6cLFyO/BOUWTVBYaPqXpxa5P+im2hM5uRzHrXxQ
         WHzoRzxqeJ22/KlehQQ6iKshzEmMPvO88fGIbFd9axsOHWAlRAMl+DJJcxq9+LFEVlfJ
         BRV0nsxVuFoBKbL+D+3ABzWf/OEAEjay0XA9ubZMVmWxdvVEAJwU0xqnkCYqsKmsXn/B
         mC0BRUugYBvfE9t1lnC3N8krPi50hmDXOvBel4Jck9MJtTIbo1lGN/l63kdxaa2DTovQ
         eWwA3aZv8I6nDFSlwadPJ6FE4FnKfYvIPDtyIDteQLrbyk5ek6eTiIxH0s2wrPUyBx59
         7e0g==
X-Gm-Message-State: AOAM53059uIw0dzPEisf5unKcO3KIe+CvI8/TrXZ4uT1pIPwLi5HLihH
        U0VitTyZiZoxgqUCShcvdjEC
X-Google-Smtp-Source: ABdhPJyQNtV4HQWkIfjBIcoMAqHXA+VmwTmB0Hmc7bSteNAdGCzWAwJtPQJ5BnZQjxUTyGFWTt0yWg==
X-Received: by 2002:a17:90b:1d0f:: with SMTP id on15mr6985029pjb.194.1623384722346;
        Thu, 10 Jun 2021 21:12:02 -0700 (PDT)
Received: from thinkpad ([2409:4072:6281:d9a2:40f:351d:828b:fc1a])
        by smtp.gmail.com with ESMTPSA id y27sm3851881pff.202.2021.06.10.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 21:12:01 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:41:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on
 Owl S500 SoC
Message-ID: <20210611041154.GA5317@thinkpad>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
 <21c1abd19a7089b65a34852ac6513961be88cbe1.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c1abd19a7089b65a34852ac6513961be88cbe1.1623354574.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:05:24PM +0300, Cristian Ciocaltea wrote:
> There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> clock chain involving AHPPREDIV, H and AHB clocks:
> 
> * AHBPREDIV clock is defined as a muxer only, although it also acts as
>   a divider.
> * H clock is using a wrong divider register offset
> * AHB is defined as a multi-rate factor clock, but it is actually just
>   a fixed pass clock.
> 
> Let's provide the following fixes:
> 
> * Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
> * Use the correct register shift value in the OWL_DIVIDER definition
>   for H clock
> * Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
>   ungated OWL_COMP_FIXED_FACTOR definition.
> 
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v3:
>  - Fixed the swapped flags between "ahbprediv_clk" and "ahb_clk" as noticed
>    by Mani
> 
> Changes in v2:
>  - Reverted the addition of the clock div table for H clock to support the
>    '1' divider (according to the datasheet), even though the vendor
>    implementation marks it as reserved
>  
>  drivers/clk/actions/owl-s500.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 42d6899755e6..cbeb51c804eb 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -153,11 +153,6 @@ static struct clk_factor_table hde_factor_table[] = {
>  	{ 0, 0, 0 },
>  };
>  
> -static struct clk_factor_table ahb_factor_table[] = {
> -	{ 1, 1, 2 }, { 2, 1, 3 },
> -	{ 0, 0, 0 },
> -};
> -
>  static struct clk_div_table rmii_ref_div_table[] = {
>  	{ 0, 4 }, { 1, 10 },
>  	{ 0, 0 },
> @@ -186,7 +181,6 @@ static struct clk_div_table nand_div_table[] = {
>  
>  /* mux clock */
>  static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
> -static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
>  
>  /* gate clocks */
>  static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
> @@ -199,16 +193,25 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
>  static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
> -static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> +static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, NULL, 0, 0);
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
> +			CLK_SET_RATE_PARENT);
> +
> +static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
> +			{ 0 },
> +			1, 1, 0);
> +
>  static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
>  			OWL_MUX_HW(CMU_VCECLK, 4, 2),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
> -- 
> 2.32.0
> 
