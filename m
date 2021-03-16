Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8703533CDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhCPFxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhCPFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:52:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8804C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:52:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 30so11870852ple.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pe69Q5DUzNzxEuJPgJPZ95TpFdLl5kEHOCKbCnUbXHI=;
        b=zvMkaebn3tc8Ocjfkjmznf/o4FqM5cTQ4GfsFvjx8E8Ba0CrOnfgm5XxJuKGr7b+7v
         GBM6CSLLFXve5S4VXD8Kw5tTs1QNISGUY71rkHwFXYsBskx7DPXril75dtZd7HmQD9p4
         S/cfY65iIThKnwtdUbDdPxFkvojmXe9DHkeEX57DocjgQJg1lGYacorxXW/lZeVhC9Jq
         RqVzDuPzki83xtwYJAQJDp8dgPgOlBwwfoF/t7qXwG/6sUuWbm5fOeUcrlMjwScqPXiH
         o2Z0RAbIp7TH6WJuvZVX1Y2wZ1XvOJ3U1n9yR0d8tqhuFZLCdfLHrI6ysuaQXgJr8qIJ
         qdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pe69Q5DUzNzxEuJPgJPZ95TpFdLl5kEHOCKbCnUbXHI=;
        b=NE/wmQzCjvvomOr+AqduTbiecoP2d4r366lfRjazKfzZevftwQh1YmQabUPPb/36tc
         UD7sghiWbKhfblOUNN5aTN11JcgVHj+7GXjO3Jqs71KJX/nTYzUSMDRKDVNy1RQ3gPPQ
         sQ2sYWbDEhjjzJvG/HIKkjb6FpL36X68wHmtTN0GtxZDsH74Mug96VgwSPuTddoXfdnd
         LPuk3Fvcc8feHNSryn5kBcxuJYDRcg9XRWGzINtWoMdb2/RV4NFQ0W+k7hVeMRhIBSK5
         D9GZQX8URpM9osI2Vww8rBASOOw5CQUD6Zi9EQG5sfEUob7xunoj24zFziIivRG3cPly
         H9gw==
X-Gm-Message-State: AOAM53142ht07JL//gUnOXMRRLNZ8D8kmL6LcKQwk2BCA6oTwjALRaAG
        a7YIS1+8oI9NQxzy0v2tnhwd
X-Google-Smtp-Source: ABdhPJzsaa7YWAVypSTahZiALp/IK2FzXMbiaxkoMp0PKFHI+/VZn5CZGl6hS4V0desqd1wrN2nHVg==
X-Received: by 2002:a17:90b:1a89:: with SMTP id ng9mr3111070pjb.36.1615873966899;
        Mon, 15 Mar 2021 22:52:46 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id z18sm4298905pfa.39.2021.03.15.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:52:46 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:22:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] clk: actions: Add NIC and ETHERNET clock support for
 Actions S500 SoC
Message-ID: <20210316055240.GE1798@thinkpad>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <ddafbffafe48fc55bed050728e2ce2610c934e7b.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddafbffafe48fc55bed050728e2ce2610c934e7b.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:18:31PM +0200, Cristian Ciocaltea wrote:
> Add support for the missing NIC and ETHERNET clocks in the Actions Semi
> Owl S500 SoC clock driver.
> 
> Additionally, change APB clock parent from AHB to the newly added NIC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index b9e434173b4f..0ccc9619b302 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -112,6 +112,7 @@ static const char * const bisp_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
>  static const char * const sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
>  static const char * const sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
>  static const char * const pwm_clk_mux_p[] = { "losc", "hosc" };
> +static const char * const nic_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };

As per the reg field order, this should come after "ahbprediv_clk_mux_p"

Rest looks good.

Thanks,
Mani

>  static const char * const ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
>  static const char * const uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
>  static const char * const de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
> @@ -197,7 +198,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
>  static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, h_div_table, 0, 0);
> -static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
> +static OWL_DIVIDER(apb_clk, "apb_clk", "nic_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
>  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
>  
>  /* factor clocks */
> @@ -205,6 +206,12 @@ static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table
>  static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
>  
>  /* composite clocks */
> +static OWL_COMP_DIV(nic_clk, "nic_clk", nic_clk_mux_p,
> +			OWL_MUX_HW(CMU_BUSCLK1, 4, 3),
> +			{ 0 },
> +			OWL_DIVIDER_HW(CMU_BUSCLK1, 16, 2, 0, NULL),
> +			0);
> +
>  static OWL_COMP_DIV(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p,
>  			OWL_MUX_HW(CMU_BUSCLK1, 8, 3),
>  			{ 0 },
> @@ -320,6 +327,10 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 31, 0),
>  			1, 5, 0);
>  
> +static OWL_COMP_FIXED_FACTOR(ethernet_clk, "ethernet_clk", "ethernet_pll_clk",
> +			OWL_GATE_HW(CMU_DEVCLKEN1, 22, 0),
> +			1, 20, 0);
> +
>  static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
> @@ -454,6 +465,8 @@ static struct owl_clk_common *s500_clks[] = {
>  	&apb_clk.common,
>  	&dmac_clk.common,
>  	&gpio_clk.common,
> +	&nic_clk.common,
> +	&ethernet_clk.common,
>  };
>  
>  static struct clk_hw_onecell_data s500_hw_clks = {
> @@ -513,6 +526,8 @@ static struct clk_hw_onecell_data s500_hw_clks = {
>  		[CLK_APB]		= &apb_clk.common.hw,
>  		[CLK_DMAC]		= &dmac_clk.common.hw,
>  		[CLK_GPIO]		= &gpio_clk.common.hw,
> +		[CLK_NIC]		= &nic_clk.common.hw,
> +		[CLK_ETHERNET]		= &ethernet_clk.common.hw,
>  	},
>  	.num = CLK_NR_CLKS,
>  };
> -- 
> 2.30.1
> 
