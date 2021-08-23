Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB93F4B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhHWNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhHWNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:13:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8CC061575;
        Mon, 23 Aug 2021 06:12:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i8so33981299ybt.7;
        Mon, 23 Aug 2021 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R97OqEZrNIno3qkz/yEO15JnSxGdGN4h7p8yY0hMHwo=;
        b=R4QpTqGpG1d4yXhFwmfMpVQdsXOHi+n+oBn9IzTtt8NW7mkaaY2XTjRmek3GoDtpr4
         Bf2YE0BRpVMDh1CNKutuBiiG1Wea6UZ++awb2BnekU/3LRJwqccoH8bj+C+Ds24Yl3oG
         7Rb0q7nXkE4GOvJwHabez+wnqBLZUg3u+L5JwFVyEDIwor9Vpb6SVEvAGqMudGOz2PjD
         02Y/tVYZ11ci4yasfp9OYpzmb8g+G5XOrOFme2ymCSAN5kGcZTVF2MU50TMRLyIvW77N
         oNfMgyaMrCeFIdukNmuYbfdjkbSL+IOGgL/m9Fsgmfwi9wntr6QUMa50oylVNy9ZgiiV
         Iv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R97OqEZrNIno3qkz/yEO15JnSxGdGN4h7p8yY0hMHwo=;
        b=kxPmb0RJiUsUlWCNtaf8xQJi0+xzRkKawhKMqxj+v8Mtm83Kp+PirjUvhuU9yWclSt
         Z0LY1IljcmockcaKF0Ph8xUetSsXC/4rpaDs2ujVS2RDsMxgVcpzf88ER3aYMJXIEqY6
         SXPda3G2jQBEmBFVYUAZX5vyX5PjoFkmsxEv8hlSgv1tTe+S02/4+VmUAsFdjkqDvu3e
         2XDW6PqradLKXuky7VQeyv+cHCdcwqM0OUaHehmoNFnK2mxZmTErJYMnl8kJZVoCaTNp
         dxW1PxT1FbkkKtd3OOrtemQHk259/KSZfYdTley3je4q835wWIWFWHNtnQXxC4a3vFcd
         VG2g==
X-Gm-Message-State: AOAM533Hwnol83o6l66LsBR8nizMrGYKrv4HpuBuh1BnhioexlgBTZT0
        Bdt4LobHvQtAksg0yf3HzhoaC1OOz2FN5vE2a1o=
X-Google-Smtp-Source: ABdhPJw+vICRTODnbzvLttDb0NknD91cihfl7QBAuVDbaw46UeMABTy/M8I/01k3C7LjLMGIStqQ0IyMMsq13Xt8PpM=
X-Received: by 2002:a25:3108:: with SMTP id x8mr42681800ybx.386.1629724341797;
 Mon, 23 Aug 2021 06:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123911.12095-1-michael.riesch@wolfvision.net> <20210823123911.12095-2-michael.riesch@wolfvision.net>
In-Reply-To: <20210823123911.12095-2-michael.riesch@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 23 Aug 2021 09:12:10 -0400
Message-ID: <CAMdYzYr4ZTXvfJaeMejuRHBkBAVKcEUseskhEVqLMSYR+Dv4uw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: add missing rockchip,grf
 property to rk356x
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 8:39 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> This commit fixes the error messages
>
>   rockchip_clk_register_muxgrf: regmap not available
>   rockchip_clk_register_branches: failed to register clock clk_ddr1x: -524
>
> during boot by providing the missing rockchip,grf property.

Good Morning,

This was fixed by commit: 6fffe52fb336 clk: rockchip: drop GRF
dependency for rk3328/rk3036 pll types
which was merged in -next. I don't believe it's going to be backported
to 5.14 due to 5.14 not being able to fully boot.

Very Respectfully,
Peter Geis

>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 23949e79d8ce..0a1d07c96b2e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -233,6 +233,7 @@
>                 #reset-cells = <1>;
>                 assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
>                 assigned-clock-rates = <1200000000>, <200000000>;
> +               rockchip,grf = <&grf>;
>         };
>
>         i2c0: i2c@fdd40000 {
> --
> 2.17.1
>
