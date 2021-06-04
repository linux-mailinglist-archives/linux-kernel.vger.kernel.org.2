Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8639B28C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDG2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:28:49 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:45794 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFDG2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:28:49 -0400
Received: by mail-wm1-f50.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so678773wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWiGoQ9cXot7jOVjL8R3Jy7JG2GE+CLSEjZfNbVzYKM=;
        b=rFhr0ddRev6e86NKbMfJoCaI4Iidw4ZhSOXXMJVaC1ktXUrOxb4xBTrFcDAfICXHAT
         xZ7NieCTxYzbhGbTJNuo19T6HiQYYwaKL17f1XDGlMlGRlSsBp2O2QIC6WvUWBCTSo7C
         06UalwS5DmH8sftLZan8pB27R26abP+dCznvG5MkaCoq3drpdGbCrMpcgi8yOGqFVSCZ
         E5Xbx7WYDKcmOoqEq8FzEJ4OqIosuQffXLLUf4ymbW8pJWx404vTtDajxVRKrTRhd7Ka
         4U5w2R1uordGu9KS51hgOUwLQ72Vc8tdSIv/N5LhqC2/ADvyTZiU+m0ULX+ZCS13wVpW
         9f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWiGoQ9cXot7jOVjL8R3Jy7JG2GE+CLSEjZfNbVzYKM=;
        b=YRFtR+bQ8CXkbdDQ5JHXFTaLGPAczUoSzD35xxeoLC6DOnGs7TF52K0omAeOYk1fF0
         pg80upz9QF3Rj8gdK86wg55qC1SBZenbD/oldCdwaFEqS2mDQosw/hJTXO0dKemm9F4r
         68A09PIXJ4iH+mbncicYw4mf0bsMRSUVGOgnhOwop1/zCerSRPAs+X+4asUILY+v1j2N
         /Iz0KUzQTI6MnyaoScy/fIzKfBEfC6nGweoEk33iL763COOHIXMyNGEVieCKS0wLzotI
         pn5sFxwvOGRP/BpcTCPlj1YMLpDcdHUbFSwskhIc7kJCsRIYahML2EkFaWddsuy+Gngx
         ltlg==
X-Gm-Message-State: AOAM532YpEJq/WNcoswIJHyB5FsExuQUlybo924cRO4YRo8G0mqU8s0r
        ccVTEf3HpIfVzrSG4bm4hIuueA==
X-Google-Smtp-Source: ABdhPJyZKXbYg8qPw1WN9jMPm9RRfxl+hLlPTeAoN6oByt7B6P//XuntI5CD0bI4w1rC1rVaOnZHPg==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr1933863wmi.151.1622787962608;
        Thu, 03 Jun 2021 23:26:02 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e0a:90c:e290:71d6:f7f5:b70f:ffea])
        by smtp.gmail.com with ESMTPSA id u18sm4692482wmj.15.2021.06.03.23.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 23:26:02 -0700 (PDT)
Subject: Re: [PATCH] clk: meson: g12a: Add missing NNA source clocks for g12b
To:     xieqinick@gmail.com, jbrunet@baylibre.com, mturquette@baylibre.com,
        sboyd@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
References: <20210604032957.224496-1-xieqinick@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <2288650e-316a-3534-21a7-9962796b7d1a@baylibre.com>
Date:   Fri, 4 Jun 2021 08:26:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210604032957.224496-1-xieqinick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 04/06/2021 à 05:29, xieqinick@gmail.com a écrit :
> From: Nick Xie <nick@khadas.com>
> 
> This adds the Neural Network Accelerator source clocks for g12b.
> 
> Initial support for sm1 already exist in
> commit 2f1efa5340ef
> ("clk: meson: g12a: Add support for NNA CLK source clocks")
> 
> The sm1 and g12b share the same NNA source clocks.
> This patch add missing NNA clocks for A311D (g12b).
> 
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  drivers/clk/meson/g12a.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index b080359b4645..6a1db16b126f 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -4723,6 +4723,12 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
>  		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
>  		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
>  		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
> +		[CLKID_NNA_AXI_CLK_SEL]		= &sm1_nna_axi_clk_sel.hw,
> +		[CLKID_NNA_AXI_CLK_DIV]		= &sm1_nna_axi_clk_div.hw,
> +		[CLKID_NNA_AXI_CLK]		= &sm1_nna_axi_clk.hw,
> +		[CLKID_NNA_CORE_CLK_SEL]	= &sm1_nna_core_clk_sel.hw,
> +		[CLKID_NNA_CORE_CLK_DIV]	= &sm1_nna_core_clk_div.hw,
> +		[CLKID_NNA_CORE_CLK]		= &sm1_nna_core_clk.hw,
>  		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
>  		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
>  		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
