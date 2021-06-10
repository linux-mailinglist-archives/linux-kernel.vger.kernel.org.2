Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7C3A2E53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFJOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:36:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E25C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:34:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u18so497728plc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NoG4kcVr4onmC8GwKi74Fb0Au47jb6GQBPdI6ViJks=;
        b=hb+gFlMZ5lsfye5orD2HfDm69xWdh0ImWNrad0GfmspEQe/MBdHf3Bdn/pBUdOTIMz
         vJgQTkk6IKqPDE90d3GqXyh2lMetjiVYCHaV3koKdOWnzzgID5ZwFFkHT+ZPX+IB4CRY
         pr3dfjU5mxgGZ6w4+rjHvKSGJTz66UdEwz0sLR7CbGHIgFF9Ym2QTPX2/GfUF6D8DPss
         P5BIPLEtBNrVMVFTSElQ8fkBu7PASbQnkln+1NhijjL2ZqG9AHFg0BgVQZkSQhqzgSiZ
         VTYSdElUzNXQ+Edo5gyAV9Pb5duRU0lNkY4AGZLZZQYR/ytYXMkQjCTeZICrqj64Nehu
         zhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NoG4kcVr4onmC8GwKi74Fb0Au47jb6GQBPdI6ViJks=;
        b=YNDHpdKFJjOwgi2hng8IV72MajAlGt40BeYatpowXouCMwSCEzIbM4dlnsrrSSh7S9
         5L0l4ondPf6/yQes3HEJShx+qCbg1XGEVKLg8LCYVy1MUwj7PSIyXnABknP4Y66arS1o
         L/zNooQ9aiHlXO90OmVgU0LStv6GC/IkV8Lx9Pd4qas1MvI2aZe2v2Q6hi9ELhOkiLnK
         JuYJj7QvjGwEVryCnjnAqFtjjyjyokkZFrvm/xR91UvngNBCNq/+U46WkJ9vqdudSOvt
         uo0eaKruIba+MJY9fpbDVjZf1x7sdrt/ojkkyWZqtC71vkUxi4ZxZ8cjD6evvbBVGdvY
         DPvg==
X-Gm-Message-State: AOAM5310iAHP+WZe3goWTXvxnCUyUx/GISsI6i6iv63fTaDnUN40ehPL
        f1vha5F1YKrncaNVKQvR8rir
X-Google-Smtp-Source: ABdhPJzbF7Z0yYFRdKQ/8/O7a/ocykejjMhtwCjk3txcAfux7Dj9U26puqA3/fd1ViStsxX6YI8mJw==
X-Received: by 2002:a17:902:d917:b029:107:eca4:d5b4 with SMTP id c23-20020a170902d917b0290107eca4d5b4mr5063870plz.79.1623335661194;
        Thu, 10 Jun 2021 07:34:21 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9e:80ad:d341:9a16:2c5c:2249])
        by smtp.gmail.com with ESMTPSA id o133sm2804262pfd.49.2021.06.10.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:34:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:04:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on
 Owl S500 SoC
Message-ID: <20210610143413.GC315240@thinkpad>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
 <107776b4a4e752ef83b143114d2baf52bf8c4107.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107776b4a4e752ef83b143114d2baf52bf8c4107.1622119892.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:16:42PM +0300, Cristian Ciocaltea wrote:
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
> ---
> Changes in v2:
>  - Reverted the addition of the clock div table for H clock to support the
>    '1' divider (according to the datasheet), even though the vendor
>    implementation marks it as reserved
>  
>  drivers/clk/actions/owl-s500.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 42d6899755e6..257923bd5386 100644
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
> +			0);
> +
> +static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
> +			{ 0 },
> +			1, 1, CLK_SET_RATE_PARENT);

I think you swapped the flags between "ahbprediv_clk" and "ahb_clk"...

> +
>  static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
>  			OWL_MUX_HW(CMU_VCECLK, 4, 2),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
> -- 
> 2.31.1
> 
