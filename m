Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0563619A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhDPGBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbhDPGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:01:34 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D3C061756;
        Thu, 15 Apr 2021 23:01:10 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so19683158otf.12;
        Thu, 15 Apr 2021 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=59UpTKt8YsSM4yGeu5c+Ux0/BszmMe/B0VMIiCo5InM=;
        b=AlBYRPkf4BcdE5GsKj8NLy9Ztx84clzZk2jWtyx1bRTRPu0aEnpU750JylT5G/IU00
         ineal0qXWAnllcNxV+OXG5SNvmhqs4QG+AKASREA6S96ilhUpRweNRb3c12RNtMp3nKx
         5jvNPfgLfokqgUmTqdQvVd03l57R6DAeHInc3N4dQ/9FTEPXi/35OWo95jgatEpeaLw3
         dTpBxPCcmJ67QJymQWSOxlMvnIa+58URGDAiZ9BIE7bWw+LGFmLr9L9Oj+6Y5L/aMIzi
         STPV0ldYRipsgehpStEo+jOgg2yTieIdl9+a89yVuDTpZWQAOq1BcdwUxmEzgG5J/svQ
         nIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=59UpTKt8YsSM4yGeu5c+Ux0/BszmMe/B0VMIiCo5InM=;
        b=uGGQgzHfWlmwIhkAB7JBhxdx7pCNVSGiuksDBFeg85ofMCGzdO1YlW0uSXuPqhsvzq
         55NwukSlplAd6Faa/kS7TkE35UEdNwaWGmBSIfIa/oKqu5BZwCOkhAoDMtfiG7nh4hIh
         JVO+2OkYGUDXAn6tbIW7kfILp4eG56vzf+qlElpulKnCLGzcQ9f3lf1+MDccAkmuaQcs
         LGGxeJPaLEiKWTIghB0sVmHfJIz9rx9zCuqYphequjPudsLuwHyjD/UUpXjLqzJphvDf
         dgU+BBUhncVbZ+esxco+Cbl7gNl4QVaLErIMwk7SQ3biga5jFZalyeJ3+m7IdUQ6pTr1
         vuyA==
X-Gm-Message-State: AOAM531FMFKgXFC7/vFVO2gwOOH/OiUypd0+f6hWQemtBDlpX+5FCD5T
        b3nERabADqocHhDDnmnTQ3+voOQoNgVJymy3lhY=
X-Google-Smtp-Source: ABdhPJxBKw4vtrSAg1ORAmYzpKMGQpP+wahz4rortWZlJxR83gLaTM9Dqyb9dP7Xrw17j3oaTXBFoqpEKPE7GgHmHYg=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr2499173otq.281.1618552870163;
 Thu, 15 Apr 2021 23:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-7-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-7-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 08:01:02 +0200
Message-ID: <CAFqH_50LbYBbJKs_yYQRuW7RPnwVTyJo_n7ZyJ-H_4u955b1NA@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 15 d=E2=80=99ab=
r.
2021 a les 11:36:
>
> Burnet is known as HP Chromebook x360 11MK G3 EE
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 33 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-bur=
net.dts
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index 5f43bbc2ea72..b33d0bc58021 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-elm-hana.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-elm-hana-rev7.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-burnet.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-damu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-juniper-sku16.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-kappa.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts=
 b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
> new file mode 100644
> index 000000000000..b97ca331970e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi.dtsi"
> +
> +/ {
> +       model =3D "Google burnet board";
> +       compatible =3D "google,burnet", "mediatek,mt8183";
> +};
> +
> +&mt6358codec {
> +       mediatek,dmic-mode =3D <1>; /* one-wire */
> +};
> +
> +&i2c0 {
> +       touchscreen@2c {
> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x2c>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&touchscreen_pins>;
> +               interrupts-extended =3D <&pio 155 IRQ_TYPE_LEVEL_LOW>;
> +
> +               post-power-on-delay-ms =3D <200>;
> +               hid-descr-addr =3D <0x0020>;
> +       };
> +};
> +
> +&i2c2 {
> +       clock-stretch-ns =3D <4100>;
> +};
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
