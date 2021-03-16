Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916F433CC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhCPDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhCPDvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:51:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:51:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ha17so9160499pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8oLEyrZESR6CUt/SxdJhSlTaKMEYXaCbysmUXKIyTNM=;
        b=E5NTtk7xysRD413RQdLJ0OJeKpRa5NdPspzftI3kyLcfYp6diyqJPmwmx6F2/DzHuR
         C0iuYjUo4mEk2dvzWnv/LysZGx46VPSea7N/RQL8qn9v4XkEgcifdH5vb8MtIAxiYV3u
         DH51xiiTfl707KmIQQ/TTJijece0aUEs6aJDa7nY0YXjcizyuGSzNb59vEO7Vbt4B2+7
         YCzfLhBHlCLpJ/3FnRSvGwoLvpYgTRVm6/grisVu38XgRzZiFW0ELYnWCMp/0QS1i7+9
         D1xqG1fWZn6ebyAEiqadRfwgZ32zyXdOiOiON0ivm6Of3sUR8s81Gj2EtQlexEGGorfY
         YOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8oLEyrZESR6CUt/SxdJhSlTaKMEYXaCbysmUXKIyTNM=;
        b=kWTNQBmXMcrmyilNuD8PSTUu/WcJ72RHdy9WNBPhcrcEKODqCx+5hVqHtws6cZbQ2d
         XCoCMAC6bn/OsoGLNLJJddQo3547bbExnpBO/KcBTS9Kexb/aQcvuz+xFBstP3LO1iqQ
         iszl0QZC7VNPUsL+xLbGugxp0w0anX/903VA62DsOBhHCjfz15vn56okAgdtDyelrFL0
         aeAyzidNpyUjYThpmenQQTjxDX7w9eQe6+ADQ6u6QqeQI4ZoKgnQ6tJTxSl7/xATm+h9
         zfBGWVFsCXF5M9NVpACqV99g7J7N1/Xozws4LitoShEYkJ26ukFQo/kRkBZiEGWV79WM
         w0xg==
X-Gm-Message-State: AOAM531VCVk6WBOOQRWg3BYe1MpT31bRJ1u/rT9Q/6U2Cg4cgAmWGjn9
        uDrW7PXnzj7qY/OmtorJzdCA
X-Google-Smtp-Source: ABdhPJwI75pg7FWR/Yz24jtSICZctpnQaS8RGw0Lkukg9kequDhYBJge4UTHE7HnLibHrqyhpWqzBQ==
X-Received: by 2002:a17:902:e98c:b029:e5:defc:ccf8 with SMTP id f12-20020a170902e98cb02900e5defcccf8mr14904625plb.20.1615866664997;
        Mon, 15 Mar 2021 20:51:04 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id l3sm14717894pfc.81.2021.03.15.20.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:51:04 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:20:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] clk: actions: Fix UART clock dividers on Owl S500 SoC
Message-ID: <20210316035058.GA1798@thinkpad>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <3d3118fc3e0973cc1cbbdbb98b643f0c82dd74fc.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3118fc3e0973cc1cbbdbb98b643f0c82dd74fc.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:18:26PM +0200, Cristian Ciocaltea wrote:
> Use correct divider registers for the Actions Semi Owl S500 SoC's UART
> clocks.
> 
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/clk/actions/owl-s500.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 61bb224f6330..75b7186185b0 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -305,7 +305,7 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
>  static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART0CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(uart1_clk, "uart1_clk", uart_clk_mux_p,
> @@ -317,31 +317,31 @@ static OWL_COMP_DIV(uart1_clk, "uart1_clk", uart_clk_mux_p,
>  static OWL_COMP_DIV(uart2_clk, "uart2_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART2CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 8, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART2CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(uart3_clk, "uart3_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART3CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 19, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART3CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(uart4_clk, "uart4_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART4CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 20, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART4CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(uart5_clk, "uart5_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART5CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 21, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART5CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(uart6_clk, "uart6_clk", uart_clk_mux_p,
>  			OWL_MUX_HW(CMU_UART6CLK, 16, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN1, 18, 0),
> -			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
> +			OWL_DIVIDER_HW(CMU_UART6CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
>  			CLK_IGNORE_UNUSED);
>  
>  static OWL_COMP_DIV(i2srx_clk, "i2srx_clk", i2s_clk_mux_p,
> -- 
> 2.30.1
> 
