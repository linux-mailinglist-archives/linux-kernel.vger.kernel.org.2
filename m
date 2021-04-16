Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B033619A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhDPGBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPGA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:00:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA4C061574;
        Thu, 15 Apr 2021 23:00:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a2-20020a0568300082b029028d8118b91fso6308870oto.2;
        Thu, 15 Apr 2021 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DYqXpISwYSl5B0KoON02xqvRL1A4TfhZkv94/GOZwH0=;
        b=enWvOf0bwwdH/1CN5662vu197Mr6rb+WK2520PuoHkfxuAGqf9v5OsRyvV0vUi2/7F
         yUuMTzY/UIFyN0OaJl+chucUsCbIYoUkaVGo/JX5kVjeOILLwb7i5yogT2b79KRngkQF
         RzQDxkQqTvQT1BlqDbqJxzNv2LvMUSmNGq9DrjZ4BZgDehqo/j3TPY0HvPWsxFxgWghu
         neXhN3nckL1V9H78+NPVjvihpmOpLl/MG3Wur1MJ8OeqPzGsZI/Q/nNOneBaY3zSrX7y
         z8gJV2cicWFTBrPaeQEmPmtf6WBfskF43UYZluHRRcJh+DZJBMJ+YyJ91kXcoba1pJTb
         gReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DYqXpISwYSl5B0KoON02xqvRL1A4TfhZkv94/GOZwH0=;
        b=MnlwjgdGRn1+bA+srCfA/yGUFCQgVGsLAzOeL+x6YszF5P4L4jAfu2AAZArY2ghynL
         +2pDWSAp8d8MJFWrmNycPuCEgUidHh6Gllz/a8tj6A9Cya7Aw0aeuj7Ydfl+jb9tr8xu
         z5Qc/jLJu0HLZp4q3OQOfSeCOwFWyFkVkp2cuk+Ph7/sWMlY+WlWM/NyE8j9ioXJ8dmn
         b/2ll5JoWpTMWutP3hUXoVZwIZGMVUPaSGAXLEH6qbilFiCwEqdEQQEv+Ld22xR3EQQj
         DI4w0IebsoCMGRfS0kpeAWEQNR+ScPwxhHHtpL+vl2LwgGZ/9KzlmwBcPkHUNEpEqaJz
         MmIQ==
X-Gm-Message-State: AOAM531bk4Aq1f/YXowv4gs83izbphiVPXZ5IHE0P+kY6OJQ4VINw4Bf
        R38UqU8DCsM+e6dvDLMlrcxGwrqJhKYFES+qO9IEyr4lu5y/tWMa
X-Google-Smtp-Source: ABdhPJwNNgoDAzRVqe72yu/qRS14DBDbbSwJX0g1V9A7RoYSYK79+dK7zVxtMeHyBG0EYeD3lObR4+40vlaY7PPTVjI=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr2496876otq.281.1618552830388;
 Thu, 15 Apr 2021 23:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-6-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-6-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 08:00:22 +0200
Message-ID: <CAFqH_52+AdGMhKBOpJ_=tYd0tDRrxYu==nUM1Yrw=wA7KUyecw@mail.gmail.com>
Subject: Re: [PATCH 6/8] arm64: dts: mt8183: Add kukui-jacuzzi-willow board
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
2021 a les 11:38:
>
> Willow is known as Acer Chromebook 311 (C722/C722T)
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
>  .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 +++++++++
>  .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 ++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 28 +++++++++++++++++++
>  4 files changed, 55 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-wil=
low-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-wil=
low-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-wil=
low.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index df70674949ce..5f43bbc2ea72 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -16,6 +16,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-damu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-juniper-sku16.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-kappa.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-willow-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-jacuzzi-willow-sku1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kakadu.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sku16.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sku272.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku=
0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
> new file mode 100644
> index 000000000000..281265f082db
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi-willow.dtsi"
> +
> +/ {
> +       model =3D "Google willow board sku0";
> +       compatible =3D "google,willow-sku0", "google,willow", "mediatek,m=
t8183";
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku=
1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
> new file mode 100644
> index 000000000000..22e56bdc1ee3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi-willow.dtsi"
> +
> +/ {
> +       model =3D "Google willow board sku1";
> +       compatible =3D "google,willow-sku1", "google,willow", "mediatek,m=
t8183";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dts=
i b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> new file mode 100644
> index 000000000000..3204c1abc4ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi.dtsi"
> +
> +&i2c2 {
> +       clock-stretch-ns =3D <9500>;
> +
> +       trackpad@2c {
> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x2c>;
> +               hid-descr-addr =3D <0x20>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&trackpad_pins>;
> +
> +               interrupts-extended =3D <&pio 7 IRQ_TYPE_LEVEL_LOW>;
> +
> +               wakeup-source;
> +       };
> +};
> +
> +&qca_wifi {
> +       qcom,ath10k-calibration-variant =3D "GO_JUNIPER";
> +};
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
