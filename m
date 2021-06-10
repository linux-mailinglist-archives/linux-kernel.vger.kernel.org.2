Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1F3A2E63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFJOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:38:59 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46013 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:38:57 -0400
Received: by mail-pl1-f169.google.com with SMTP id 11so1115131plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRLgU3JHZtARnfgYuE4byvQXFLPCwkroVQ8QT5X4RN8=;
        b=vy8Y4PV6KZ9gql/eh6Q30QBlYMw4iGgoQ2HhzKTwvc/znZIqswgQ9SFUZcPmL0JgJc
         Gw2mq9kziFGocQTC7JmtLFlc75ehMC320tpQ1upzwwadSg/uqNoz3S2/lA6PAwKw14ZA
         2PWs3gkEwQLRmyB9+/b24JG2DQq9IXxMOlHpC823vCsXAvnuXBoyt/aS70kdU5PoBbyP
         8BNaahDAy/stNlvDbMtWlK73quGWX8JVeKnytTqCV3dwPuXfRh+m5rIjwpnfyZN1vHET
         FigdRX1N7cDSCFb5e6p+2o3zlYDhgT22LzV4L/tWrTRH3/lbwfd3gSLrh2R2ekVGepCc
         51wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRLgU3JHZtARnfgYuE4byvQXFLPCwkroVQ8QT5X4RN8=;
        b=IlpYcd/KY6RXkic0AkbTFQIzUXHZ7riAUGA1aE3NNsOgRvzfpG1TApWKpidFnySn6M
         I8tmfzM5xC1Zj7pECc5VWQCzRrbqNqAR30lmVmGNmeoR5vE6Sw7hYo7ckwEoa09TAz+S
         G5gBWo8bXCBE/12yNX5gzYj9sN/l5nq2BY7X5vLEalT5ND87B0Rgub3RNVNUaGZmdC6j
         k1D3Qov3w+X9zcJ28UHzCZfHIOHrAlvwhGC24AjEd1jp0eEcMpv6L2XJnSviwJCUtU0k
         fTITLBmj8GuYvz7FphPXKVZDvku7yxinIglqqA2whmL1j0DmruF28Nim7KvggQ4NRVCZ
         1X8g==
X-Gm-Message-State: AOAM530mkzn7U7K2OolkpkmMRwqC0vvUfaJXX/ceDHBeRCT0lS0IURuL
        itZron8vux9AiZbuLLUQ6BXU
X-Google-Smtp-Source: ABdhPJycpqfQoe2FhO8MC6DImrNeaI5jbviOEK9wjsBL/7tG+V9tuf1NUIahQh0lCvqcT39QGoEGfA==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr3675370pjq.179.1623335761454;
        Thu, 10 Jun 2021 07:36:01 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9e:80ad:d341:9a16:2c5c:2249])
        by smtp.gmail.com with ESMTPSA id v15sm2616023pfm.216.2021.06.10.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:36:00 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:05:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] clk: actions: Add NIC and ETHERNET clock support
 for Actions S500 SoC
Message-ID: <20210610143554.GE315240@thinkpad>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
 <fb8085722305af11311ca2661cba2bf73a71abea.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8085722305af11311ca2661cba2bf73a71abea.1622119892.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:16:44PM +0300, Cristian Ciocaltea wrote:
> Add support for the missing NIC and ETHERNET clocks in the Actions Semi
> Owl S500 SoC clock driver.
> 
> Additionally, change APB clock parent from AHB to the newly added NIC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v2:
>  - Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
>    field ordering
> 
>  drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 257923bd5386..a9c7e06ebcd6 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -113,6 +113,7 @@ static const char * const sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
>  static const char * const sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
>  static const char * const pwm_clk_mux_p[] = { "losc", "hosc" };
>  static const char * const ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
> +static const char * const nic_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
>  static const char * const uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
>  static const char * const de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
>  static const char * const i2s_clk_mux_p[] = { "audio_pll_clk" };
> @@ -194,7 +195,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
>  
>  /* divider clocks */
>  static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, NULL, 0, 0);
> -static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
> +static OWL_DIVIDER(apb_clk, "apb_clk", "nic_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
>  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
>  
>  /* factor clocks */
> @@ -202,6 +203,12 @@ static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table
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
> @@ -317,6 +324,10 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
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
> @@ -451,6 +462,8 @@ static struct owl_clk_common *s500_clks[] = {
>  	&apb_clk.common,
>  	&dmac_clk.common,
>  	&gpio_clk.common,
> +	&nic_clk.common,
> +	&ethernet_clk.common,
>  };
>  
>  static struct clk_hw_onecell_data s500_hw_clks = {
> @@ -510,6 +523,8 @@ static struct clk_hw_onecell_data s500_hw_clks = {
>  		[CLK_APB]		= &apb_clk.common.hw,
>  		[CLK_DMAC]		= &dmac_clk.common.hw,
>  		[CLK_GPIO]		= &gpio_clk.common.hw,
> +		[CLK_NIC]		= &nic_clk.common.hw,
> +		[CLK_ETHERNET]		= &ethernet_clk.common.hw,
>  	},
>  	.num = CLK_NR_CLKS,
>  };
> -- 
> 2.31.1
> 
