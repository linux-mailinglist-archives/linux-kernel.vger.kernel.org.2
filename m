Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9297F3F8F88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhHZUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhHZUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 16:11:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BAC061757;
        Thu, 26 Aug 2021 13:11:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq28so9375732lfb.7;
        Thu, 26 Aug 2021 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljj8+PavRlDjCYeTM0Y3t8UOeuSlVU1mCZqXOWU6lU4=;
        b=HZXNjsumIeyG/Vw1OkTWrHVqSz854PwQ8Uzncg58on9e+pvcqxfj6hXQL7ZBNi4nQL
         5VfWKv/IiEYXqgSqsFwevzsA4/nT1dU4onrngt55MkH6GNAL5UTbGSsJVogBMZ6rkZH2
         LJeO6A/nY+89KrRDfDipt56aaYEx/yK4gpLQmxl8EXuSPGAQu8Q3ZTc6S0Ij3Dunk8Ts
         PiDb1cC/p5AYnvpMdtb5ac1Ecb38f0epPZd6Ycs2CEveEZbIiOgYlhcSLKKf9SeS9srd
         qYQzVx75gn1COsLKKGxOBWIolHYAWGnQCDEJ/F9v4FWdXNOscC1q6wn/rgp7RCwpNdpW
         45TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljj8+PavRlDjCYeTM0Y3t8UOeuSlVU1mCZqXOWU6lU4=;
        b=hP0C9DVLLipkJprQpOwGFw3lbPVdFmAhvjxL0tXovNHtn/7LXiJgwgX89HNACSvarU
         Dpw+1Vv5U+dFRomrlJYU+uLTiAb4RhOL8aju2yFCY4GA5ytdvxhfhVFlLBxTAmnjZYz1
         Gs5zc90EHFWLuKvW/R9h6Xe1IyFNaSfKhBKfTJ0BoHeHQGxA6oTMMz2DGNlj9gVXGnsJ
         e2zsW2uZ/0VJKt1ilt3tG9CkJXMYukQ/wspt0gOUqdUr2MyISPcus2lsyszHttSw9kid
         wqp5O5c4Ta+kumN/RoZe7zuV7qrKJM0/YgBevhvYfWWXZWd+pR/AvQo6HtyW0B3HbogS
         ERhw==
X-Gm-Message-State: AOAM5318gpQomT5lbMFKJg/fj/HkER4lXTeucSJDQrbqinr4NnVUiHaL
        0UoIr6uQ7WZCEpuI3NWAFe4JlRNJJW1Jasjr1lU=
X-Google-Smtp-Source: ABdhPJzxIdSWys8Hw92KNWOfn1riI9bczm/DEuK3YN4HyXHP5OwUUrv0OrO/ap9lIuw2Q9E9wOKiBpxoZiiKIj5QqHE=
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr4267641lfr.295.1630008670134;
 Thu, 26 Aug 2021 13:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210826152049.4175381-1-s.riedmueller@phytec.de> <20210826152049.4175381-2-s.riedmueller@phytec.de>
In-Reply-To: <20210826152049.4175381-2-s.riedmueller@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Aug 2021 17:10:58 -0300
Message-ID: <CAOMZO5DR7awy7mxr3=qXiEmSG10MX15hc2MJCSajN+gW8=ryuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: imx: imx6ul: Fix csi clk gate register
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Aug 26, 2021 at 12:20 PM Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:
>
> According to the imx6ul Reference Manual the csi clk gate register is
> CCM_CCGR3 (offset 0x74) bit 0/1. For the imx6ull on the other hand the
> Reference Manual lists register CCM_CCGR2 (offset 0x70) bit 2/3 as the
> csi clk gate which is the current setting.
>
> Tests have shown though that the correct csi clk gate register for the
> imx6ull is actually CCM_CCGR3 bit 0/1 as well. Thus set the correct
> register for both platforms.
>
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

I tested the series on an imx6ull-evk with an OV5640 sensor:

Tested-by: Fabio Estevam <festevam@gmail.com>

but in my case, I did not see the problem even without your patch.

Most likely because the bootloader turned on the CSI clock.

> ---
>  drivers/clk/imx/clk-imx6ul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index 206e4c43f68f..5dd222fab01b 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -380,7 +380,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>                 hws[IMX6ULL_CLK_ESAI_IPG]       = imx_clk_hw_gate2_shared("esai_ipg",   "ahb",          base + 0x70,    0, &share_count_esai);
>                 hws[IMX6ULL_CLK_ESAI_MEM]       = imx_clk_hw_gate2_shared("esai_mem",   "ahb",          base + 0x70,    0, &share_count_esai);
>         }
> -       hws[IMX6UL_CLK_CSI]             = imx_clk_hw_gate2("csi",               "csi_podf",             base + 0x70,    2);
>         hws[IMX6UL_CLK_I2C1]            = imx_clk_hw_gate2("i2c1",              "perclk",       base + 0x70,    6);
>         hws[IMX6UL_CLK_I2C2]            = imx_clk_hw_gate2("i2c2",              "perclk",       base + 0x70,    8);
>         hws[IMX6UL_CLK_I2C3]            = imx_clk_hw_gate2("i2c3",              "perclk",       base + 0x70,    10);
> @@ -391,6 +390,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>         hws[IMX6UL_CLK_PXP]             = imx_clk_hw_gate2("pxp",               "axi",          base + 0x70,    30);
>
>         /* CCGR3 */

It would be nice to put a comment here explaining the imx6ull
Reference Manual mismatch.

Maybe Abel could help to check internally at NXP?

> +       hws[IMX6UL_CLK_CSI]             = imx_clk_hw_gate2("csi",       "csi_podf",     base + 0x74,    0);

Thanks
