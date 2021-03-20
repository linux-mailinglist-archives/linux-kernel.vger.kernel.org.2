Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B25343041
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 00:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCTXAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCTXAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 19:00:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9FEC061574;
        Sat, 20 Mar 2021 16:00:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u19so6144220pgh.10;
        Sat, 20 Mar 2021 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWWJ/HC2d49of2MHI8ao+BOYP73HCOW+pg19qzolebE=;
        b=eELVBijOu23kAPk5Omob4YfT7N/apgyTCy/rvIDFlssKN+5ZXFyLoyPBCikbmaRDj5
         9b5USUWwz0I/VASLK2g/u/1rN+/BZS6w+ir7y2H2cpZFGkDnjf1BKQkABrf6wJfY8zrq
         TqO/RPp9NYxsrhVDDmWtmSXGWYxBvZXq5CtKsezMmXBz+nMoQMcZQEAfOwp4YfGsc92H
         HcKUrbLvvnNIETN8P9oxOtT9S1JAGtEZpn6OxcT1mIJqU1oYVH7xp948wJHdD30cWy6f
         lZ9gnchXm0JzLd/C4yDa0DSKXQxE/GUVkcHdQf4deRemiWGjUkIeyQ8pA7AXB9R1fvfK
         FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWWJ/HC2d49of2MHI8ao+BOYP73HCOW+pg19qzolebE=;
        b=Rh+kRjE3L0RfE41BbZewFenpBn9CIdsfYS/UkStOGY6q3l4Vgd4rhQaf3D+G0ITTdP
         VCbNcveMD/ljcn7haPrDvToP9bCB2xvGcgK3pNnB0KON6rx7UBKmQwVZanLxGCxsNqka
         TgVX5VEHsRUvt2nn7J8VHLs0gQq17RvVzuiEqVtL+LxBR4OBwXTSOnUKM/QgfPwFQ8Ag
         uU3chakG5beXHxJo9QKEMF4VgcUJzmHJvNnzjDV5TzxEduhlBvi5/Rjau4L/HRBsHNHG
         sDa+dX63oc34hG0H09Xgl3mybLAjgyzRk1EFpyIJZzL5lKnv9XdxeG7ri3uS21WPWEtL
         NuWA==
X-Gm-Message-State: AOAM532EywqwLqPwGhgn5sRdxKSQ9sQZKfxUO/XiRJGPgItkXt6jBOSR
        cVGo8OefZ4NLehBYzpGiehMUN0PB+JQTTNZsAs8=
X-Google-Smtp-Source: ABdhPJxtnKEEI/yn3Ps2FynlqZ475s2gzczKKgAVNbvtzGZRmLRIy8p2CKSuYuS87JYWafPd2pfH7yf5XLyODMumeqU=
X-Received: by 2002:a63:231d:: with SMTP id j29mr16546928pgj.75.1616281236103;
 Sat, 20 Mar 2021 16:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210313122818.445228-1-aford173@gmail.com> <e754a185-4aa2-295a-37a8-dd0c7ebc289f@pengutronix.de>
 <0361ab5b-a26e-7631-9bae-8909715f6354@pengutronix.de>
In-Reply-To: <0361ab5b-a26e-7631-9bae-8909715f6354@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 20 Mar 2021 18:00:25 -0500
Message-ID: <CAHCN7xLSMGOe6E0YQU=n0aKX53_CV2cz9BgqO2OA96S1-eTMgg@mail.gmail.com>
Subject: Re: [PATCH V4] clk: imx: Fix reparenting of UARTs not associated with stdout
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 4:40 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> On 13.03.21 16:16, Ahmad Fatoum wrote:
> >> +/* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
> >> +#ifdef CONFIG_OF
> >>      if (imx_keep_uart_clocks) {
> >>              int i;
> >>
> >> -            imx_uart_clocks = clks;
> >> -            for (i = 0; imx_uart_clocks[i]; i++)
> >> -                    clk_prepare_enable(*imx_uart_clocks[i]);
> >> +            imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> >> +
> >> +            if (!of_stdout)
> >> +                    return;
> >
> > Memory leak. Just do if (imx_keep_uart_clocks && of_stdout)
>
> Please dismiss. I overlooked that you free it in a later initcall.

Abel,

Are you OK with this?  I also have a V5 posted [1] which does what
Ahmad suggested.

Either of these will fix reparenting issues, but I need this for
Bluetooth to operate correctly, because both beacon imx8mn and imx8mn
kits switch the UART parent to an 80MHz clock in order to run at
4Mbps.

thank you,

adam
>
> >>  static int __init imx_clk_disable_uart(void)
> >>  {
> >> -    if (imx_keep_uart_clocks && imx_uart_clocks) {
> >> +    if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
> >>              int i;
> >>
> >> -            for (i = 0; imx_uart_clocks[i]; i++)
> >> -                    clk_disable_unprepare(*imx_uart_clocks[i]);
> >> +            for (i = 0; i < imx_enabled_uart_clocks; i++) {
> >> +                    clk_disable_unprepare(imx_uart_clocks[i]);
> >> +                    clk_put(imx_uart_clocks[i]);
> >> +            };
> >> +            kfree(imx_uart_clocks);
> >>      }
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
