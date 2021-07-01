Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBAA3B8E02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhGAHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhGAHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:02:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:59:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id u7so4138974ion.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WT0ggnc6y+zkQZpmAfY5vcqw6YGgCRdcKPkikOc0Nw=;
        b=JJDyWO50TjD2JKx8VvF5pj14yk3j1SIQkpONmRgMEcD0EJGWVUrmG2gmr8IKqEaK77
         HctyKwx9tJK6K+lShpZfc0rFQfwWxrbKyEa0Ljd1itQdHqZFoTvp7/kg4mWRCs2Xy3+7
         h7sYv7+E2AOnPRJPoEuk7AdQcp6OVlDVnTpf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WT0ggnc6y+zkQZpmAfY5vcqw6YGgCRdcKPkikOc0Nw=;
        b=mTr772RbiK4P9Br+zHfByAuYNmGKNBKQH/PgSVeQ+xvQxUPlIebVql6hRAul1RxN0u
         6GsWY/uyJHWbuhggn1aUXXW0Zxsqqz7EyJh50+jjpBmNROO9dvWscVqe45+CSeWkvnKf
         GGTiZqjkGy1DEG3iY1CE5YfYUVzodv7Zn7iK6lIfV0+d0A9aOKEB9uhsmjxYrNB8mGch
         gad3+sM9zTbBl1PoclJjisiFqK2YV87dlktpZmGXoo2C7+ZmNKuQG4+18CcEurbkR4Ap
         uodZ6db6xHH5dMOMESukNv9dmPTY3inCSlE19wvBBvaoPj1aZKqHelTQfRO4Y/VgpHmV
         IXYA==
X-Gm-Message-State: AOAM531ydPk/hjiatuE/mLaOdkz+QRYGZvsc+w34dZm5QsDj9otaBlHk
        aTYEAUzJoFUnzacXm0vt+/d+pOf1MyJ+GijsJlw5aw==
X-Google-Smtp-Source: ABdhPJzHGyqZefwsLiquuhbKyd8kroyqF4uiqAGrTewcKDSPvfkci20FHon3xrv4G+J8c6C5Ms+h7k4fzdXVCt8vD/8=
X-Received: by 2002:a05:6602:1c4:: with SMTP id w4mr10899930iot.44.1625122793122;
 Wed, 30 Jun 2021 23:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210630073311.2177374-1-hsinyi@chromium.org>
In-Reply-To: <20210630073311.2177374-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 1 Jul 2021 14:59:27 +0800
Message-ID: <CAJMQK-gPeepDhNVc0S1Z_FxyDgiSuZZ4We6k8oWbQ_BbLJZxsw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8183: kukui: use generic pin configs for
 i2c pins
To:     Matthias Brugger <matthias.bgg@gmail.com>, zhiyong.tao@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 3:33 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> mt8183 i2c pins don't support PUPD register, so change to use generic
> pin configs instead of let it fail and fallback.

Though PUPD can be skipped, if we set bias-pull-up, we may miss the r0
r1 set in mtk_pinconf_adv_pull_set().
Sent another fix to replace this patch here:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210701065439.2527790-1-hsinyi@chromium.org/

>
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ae549d55a94fc..69dc04c3f7fff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -426,7 +426,7 @@ i2c0_pins: i2c0 {
>                 pins_bus {
>                         pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
>                                  <PINMUX_GPIO83__FUNC_SCL0>;
> -                       mediatek,pull-up-adv = <3>;
> +                       bias-pull-up;
>                         mediatek,drive-strength-adv = <00>;
>                 };
>         };
> @@ -435,7 +435,7 @@ i2c1_pins: i2c1 {
>                 pins_bus {
>                         pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
>                                  <PINMUX_GPIO84__FUNC_SCL1>;
> -                       mediatek,pull-up-adv = <3>;
> +                       bias-pull-up;
>                         mediatek,drive-strength-adv = <00>;
>                 };
>         };
> @@ -453,7 +453,7 @@ i2c3_pins: i2c3 {
>                 pins_bus {
>                         pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
>                                  <PINMUX_GPIO51__FUNC_SDA3>;
> -                       mediatek,pull-up-adv = <3>;
> +                       bias-pull-up;
>                         mediatek,drive-strength-adv = <00>;
>                 };
>         };
> @@ -471,7 +471,7 @@ i2c5_pins: i2c5 {
>                 pins_bus {
>                         pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
>                                  <PINMUX_GPIO49__FUNC_SDA5>;
> -                       mediatek,pull-up-adv = <3>;
> +                       bias-pull-up;
>                         mediatek,drive-strength-adv = <00>;
>                 };
>         };
> --
> 2.32.0.93.g670b81a890-goog
>
