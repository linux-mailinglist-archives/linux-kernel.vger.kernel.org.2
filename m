Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B73BBA74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhGEJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhGEJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:46:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F7C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:44:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o18so17155818pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHcKffN8wMut7bLauxeR1fCOpc0cDu1qBJhBAyl5X2s=;
        b=HaoK+Bgz2kFJLQt++pprx7lZP69jLmytiu7N2/DeZwFMtAFfuV/iad69oAwJrz3uqa
         13kmghX9aH87DaKkp+dWV9GF9Z8nnimxFX32e9pED2C1qUStM/qlS37JFInmVbu6ixg3
         lnwn+EhEQRD3Y+eKyAdJqT1/eSO6uEZ1IVFqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHcKffN8wMut7bLauxeR1fCOpc0cDu1qBJhBAyl5X2s=;
        b=qPQQytVDsUNZ4FCDpvx8O+i0OkWBGTRdQ8wMQ0jRUfQyiEIOZzxX94hHt5GpoEZRhI
         NpNe5qwNsZvw+3qUaRjNb81t3dtCfvgMlm47NZRjWQWHHYa4s3MBUNqH46zlSFNUYdWt
         kBVVqcoD68Q62xxAqGjNQXAc/sFlXTJ/oMRZN8eVneSKDjTCt6EFxtH0Etrq1cjOhCF5
         GGavgdGtBAoEfn3eBlXRJSnIcMwL55kLJ6o5gRlght5PtCSAlo1Yx57WU0FlrD5FSkm4
         92Ryo6MX/mY+5LdmP/BZ27JLCua6mv0xlFj/7wY9PRl3f1j9cQ6WhSUy/Jf8OBUFNbk+
         IFEQ==
X-Gm-Message-State: AOAM530+WJBGWbUtoj3M478X0JfPH2lnuhDbuo16h4td+bm154Vo6asw
        ZfSVmIKoC87Ce25YfQVIeNqqzLMpF1nKj9ulJMj6VQ==
X-Google-Smtp-Source: ABdhPJxyA25k+MQzNVOvp2bJiN+RAATvnYmKd0XwTjay1Mne4xFaaVhZO2GUZHqNHQCIxOMkmMwvdl7go2T8Wrxe2Hs=
X-Received: by 2002:a63:1107:: with SMTP id g7mr15102241pgl.59.1625478255483;
 Mon, 05 Jul 2021 02:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210630090710.1873559-1-kansho@chromium.org> <20210630180652.2.I6e9ce0f2a489f9a52299656cd966b38ae75e7552@changeid>
 <7fed89b3-5c44-05a0-98f6-17d0080634a5@gmail.com>
In-Reply-To: <7fed89b3-5c44-05a0-98f6-17d0080634a5@gmail.com>
From:   Kansho Nishida <kansho@chromium.org>
Date:   Mon, 5 Jul 2021 18:44:04 +0900
Message-ID: <CAP3OrSL1GQMCkumuxuqw4B1ejXx2+mmUShpUiH2GWvvN_eiHwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: add kukui platform audio node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shunli Wang <shunli.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 3:23 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 30/06/2021 11:07, Kansho Nishida wrote:
> > Set pin control for the SoC sound node.
> > The compatibles are set by each model dts.
> >
> > The codecs that each models use are:
> > burnet       ts3a227_max98357
> > damu         da7219_max98357
> > fennel       da7219_rt1015p
> > fennel14     da7219_rt1015p
> > juniper      ts3a227_max98357
> > kakadu       da7219_rt1015p
> > kappa        ts3a227_max98357
> > kenzo        ts3a227_max98357
> > kodama       ts3a227_max98357
> > krane        ts3a227_max98357
> > willow-sku0  da7219_max98357
> > willow-sku1  ts3a227_max98357
> >
> > Signed-off-by: Kansho Nishida <kansho@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt6358.dtsi      |  1 +
> >  .../mt8183-kukui-audio-da7219-max98357a.dtsi  | 13 ++++
> >  .../mt8183-kukui-audio-da7219-rt1015p.dtsi    | 13 ++++
> >  .../mediatek/mt8183-kukui-audio-da7219.dtsi   | 54 +++++++++++++++
> >  .../mt8183-kukui-audio-max98357a.dtsi         | 13 ++++
> >  .../mediatek/mt8183-kukui-audio-rt1015p.dtsi  | 13 ++++
> >  ...mt8183-kukui-audio-ts3a227e-max98357a.dtsi | 13 ++++
> >  .../mt8183-kukui-audio-ts3a227e-rt1015p.dtsi  | 13 ++++
> >  .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi | 32 +++++++++
> >  .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  |  1 +
> >  .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |  1 +
> >  .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  1 +
> >  .../mt8183-kukui-jacuzzi-juniper-sku16.dts    |  1 +
> >  .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   |  1 +
> >  .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   |  1 +
> >  .../mt8183-kukui-jacuzzi-willow-sku0.dts      |  1 +
> >  .../mt8183-kukui-jacuzzi-willow-sku1.dts      |  1 +
> >  .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  1 +
> >  .../dts/mediatek/mt8183-kukui-kodama.dtsi     |  1 +
> >  .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |  5 ++
> >  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 67 +++++++++++++++++--
> >  21 files changed, 243 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> > index fa159b20379e..95145076b7e6 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> > @@ -13,6 +13,7 @@ pmic: mt6358 {
> >
> >               mt6358codec: mt6358codec {
> >                       compatible = "mediatek,mt6358-sound";
> > +                     mediatek,dmic-mode = <0>; /* two-wires */
> >               };
> >
> >               mt6358regulator: mt6358regulator {
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
> > new file mode 100644
> > index 000000000000..37177952cb4f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Dual license GPL + MIT if possible.
> That holds for all files in this series.
>
> Regards,
> Matthias
>


Hi Matthias,

Thanks for the comment!
It's OK to change to dual license.
Let me upload the v2 patch!

Regards,
Kansho


> > +/*
> > + * Google Kukui (and derivatives) da7219-max98357a sound card.
> > + *
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +#include "mt8183-kukui-audio-da7219.dtsi"
> > +#include "mt8183-kukui-audio-max98357a.dtsi"
> > +
> > +&sound {
> > +     compatible = "mediatek,mt8183_da7219_max98357";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
> > new file mode 100644
> > index 000000000000..24316d2460d5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) da7219-rt1015p sound card.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include "mt8183-kukui-audio-da7219.dtsi"
> > +#include "mt8183-kukui-audio-rt1015p.dtsi"
> > +
> > +&sound {
> > +     compatible = "mediatek,mt8183_da7219_rt1015p";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> > new file mode 100644
> > index 000000000000..4c5598f71ac6
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) audio fragment for da7219.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +&i2c5 {
> > +     da7219: da7219@1a {
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&da7219_pins>;
> > +             compatible = "dlg,da7219";
> > +             reg = <0x1a>;
> > +             interrupt-parent = <&pio>;
> > +             interrupts = <165 IRQ_TYPE_LEVEL_LOW 165 0>;
> > +
> > +             dlg,micbias-lvl = <2600>;
> > +             dlg,mic-amp-in-sel = "diff";
> > +             VDD-supply = <&pp1800_alw>;
> > +             VDDMIC-supply = <&pp3300_alw>;
> > +             VDDIO-supply = <&pp1800_alw>;
> > +
> > +             status = "okay";
> > +
> > +             da7219_aad {
> > +                     dlg,adc-1bit-rpt = <1>;
> > +                     dlg,btn-avg = <4>;
> > +                     dlg,btn-cfg = <50>;
> > +                     dlg,mic-det-thr = <500>;
> > +                     dlg,jack-ins-deb = <20>;
> > +                     dlg,jack-det-rate = "32ms_64ms";
> > +                     dlg,jack-rem-deb = <1>;
> > +
> > +                     dlg,a-d-btn-thr = <0xa>;
> > +                     dlg,d-b-btn-thr = <0x16>;
> > +                     dlg,b-c-btn-thr = <0x21>;
> > +                     dlg,c-mic-btn-thr = <0x3E>;
> > +             };
> > +     };
> > +};
> > +
> > +&pio {
> > +     da7219_pins: da7219_pins {
> > +             pins1 {
> > +                     pinmux = <PINMUX_GPIO165__FUNC_GPIO165>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +     };
> > +};
> > +
> > +&sound {
> > +     mediatek,headset-codec = <&da7219>;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
> > new file mode 100644
> > index 000000000000..05da27cd88a7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) audio fragment for max98357a.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +/ {
> > +     max98357a: max98357a {
> > +             compatible = "maxim,max98357a";
> > +             sdmode-gpios = <&pio 175 0>;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
> > new file mode 100644
> > index 000000000000..dc836c9686fa
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) audio fragment for rt1015p.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +/ {
> > +     rt1015p: rt1015p {
> > +             compatible = "realtek,rt1015p";
> > +             sdb-gpios = <&pio 175 0>;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
> > new file mode 100644
> > index 000000000000..129da9ac3219
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) ts3a227e-max98357a sound card.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include "mt8183-kukui-audio-max98357a.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e.dtsi"
> > +
> > +&sound {
> > +     compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
> > new file mode 100644
> > index 000000000000..2a95c42d38bc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) mt6358-ts3a227-rt1015p sound card.
> > + *
> > + * Copyright 2021 Google LLC.
> > + */
> > +
> > +#include "mt8183-kukui-audio-ts3a227e.dtsi"
> > +#include "mt8183-kukui-audio-rt1015p.dtsi"
> > +
> > +&sound {
> > +     compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
> > new file mode 100644
> > index 000000000000..af07648dd335
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Google Kukui (and derivatives) audio fragment for ts3a227e.
> > + *
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +&i2c5 {
> > +     ts3a227e: ts3a227e@3b {
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&ts3a227e_pins>;
> > +             compatible = "ti,ts3a227e";
> > +             reg = <0x3b>;
> > +             interrupt-parent = <&pio>;
> > +             interrupts = <157 IRQ_TYPE_LEVEL_LOW>;
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&pio {
> > +     ts3a227e_pins: ts3a227e_pins {
> > +             pins1 {
> > +                     pinmux = <PINMUX_GPIO157__FUNC_GPIO157>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +     };
> > +};
> > +
> > +&sound {
> > +     mediatek,headset-codec = <&ts3a227e>;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
> > index a8d6f32ade8d..1a2ec0787d3c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       model = "Google burnet board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> > index 42ba9c00866c..0eca3ff8672a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi.dtsi"
> > +#include "mt8183-kukui-audio-da7219-max98357a.dtsi"
> >
> >  / {
> >       model = "Google damu board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> > index bbe6c338f465..577519a775c0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi.dtsi"
> > +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> >
> >  &mt6358codec {
> >       mediatek,dmic-mode = <1>; /* one-wire */
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
> > index 36d2c3b3cadf..bc2c57f0a827 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi-juniper.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       model = "Google juniper sku16 board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
> > index b3f46c16e5d7..e5bd9191e426 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       model = "Google kappa board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
> > index 6f1aa692753a..8fa89db03e63 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi-juniper.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       model = "Google kenzo sku17 board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
> > index 281265f082db..89208b843b27 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi-willow.dtsi"
> > +#include "mt8183-kukui-audio-da7219-max98357a.dtsi"
> >
> >  / {
> >       model = "Google willow board sku0";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
> > index 22e56bdc1ee3..c7b20441d053 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-jacuzzi-willow.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       model = "Google willow board sku1";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
> > index 20eb0dc68f09..89a139a0ee44 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui-kakadu.dtsi"
> > +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> >
> >  / {
> >       model = "MediaTek kakadu board";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> > index 3aa79403c0c2..06f8c80bf553 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183-kukui.dtsi"
> > +#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
> >
> >  / {
> >       ppvarn_lcd: ppvarn-lcd {
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> > index 30c183c96a54..a7b0cb3ff7b0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include "mt8183-kukui.dtsi"
> > +#include "mt8183-kukui-audio-max98357a.dtsi"
> >
> >  / {
> >       ppvarn_lcd: ppvarn-lcd {
> > @@ -345,3 +346,7 @@ rst_pin {
> >  &qca_wifi {
> >       qcom,ath10k-calibration-variant = "LE_Krane";
> >  };
> > +
> > +&sound {
> > +     compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index ae549d55a94f..b709859b0a03 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -113,12 +113,18 @@ scp_mem_reserved: scp_mem_region {
> >               };
> >       };
> >
> > -     max98357a: codec0 {
> > -             compatible = "maxim,max98357a";
> > -             sdmode-gpios = <&pio 175 0>;
> > +     sound: mt8183-sound {
> > +             mediatek,platform = <&afe>;
> > +             pinctrl-names = "default",
> > +                             "aud_tdm_out_on",
> > +                             "aud_tdm_out_off";
> > +             pinctrl-0 = <&aud_pins_default>;
> > +             pinctrl-1 = <&aud_pins_tdm_out_on>;
> > +             pinctrl-2 = <&aud_pins_tdm_out_off>;
> > +             status = "okay";
> >       };
> >
> > -     btsco: codec1 {
> > +     btsco: bt-sco {
> >               compatible = "linux,bt-sco";
> >       };
> >
> > @@ -213,6 +219,11 @@ tboard_thermistor2: thermal-sensor2 {
> >       };
> >  };
> >
> > +&afe {
> > +     i2s3-share = "I2S2";
> > +     i2s0-share = "I2S5";
> > +};
> > +
> >  &auxadc {
> >       status = "okay";
> >  };
> > @@ -400,6 +411,54 @@ &mt6358_vsim2_reg {
> >  };
> >
> >  &pio {
> > +     aud_pins_default: audiopins {
> > +             pins_bus {
> > +                     pinmux = <PINMUX_GPIO97__FUNC_I2S2_MCK>,
> > +                             <PINMUX_GPIO98__FUNC_I2S2_BCK>,
> > +                             <PINMUX_GPIO101__FUNC_I2S2_LRCK>,
> > +                             <PINMUX_GPIO102__FUNC_I2S2_DI>,
> > +                             <PINMUX_GPIO3__FUNC_I2S3_DO>, /*i2s to da7219/max98357*/
> > +                             <PINMUX_GPIO89__FUNC_I2S5_BCK>,
> > +                             <PINMUX_GPIO90__FUNC_I2S5_LRCK>,
> > +                             <PINMUX_GPIO91__FUNC_I2S5_DO>,
> > +                             <PINMUX_GPIO174__FUNC_I2S0_DI>, /*i2s to wifi/bt*/
> > +                             <PINMUX_GPIO136__FUNC_AUD_CLK_MOSI>,
> > +                             <PINMUX_GPIO137__FUNC_AUD_SYNC_MOSI>,
> > +                             <PINMUX_GPIO138__FUNC_AUD_DAT_MOSI0>,
> > +                             <PINMUX_GPIO139__FUNC_AUD_DAT_MOSI1>,
> > +                             <PINMUX_GPIO140__FUNC_AUD_CLK_MISO>,
> > +                             <PINMUX_GPIO141__FUNC_AUD_SYNC_MISO>,
> > +                             <PINMUX_GPIO142__FUNC_AUD_DAT_MISO0>,
> > +                             <PINMUX_GPIO143__FUNC_AUD_DAT_MISO1>; /*mtkaif3.0*/
> > +             };
> > +     };
> > +
> > +     aud_pins_tdm_out_on: audiotdmouton {
> > +             pins_bus {
> > +                     pinmux = <PINMUX_GPIO169__FUNC_TDM_BCK_2ND>,
> > +                             <PINMUX_GPIO170__FUNC_TDM_LRCK_2ND>,
> > +                             <PINMUX_GPIO171__FUNC_TDM_DATA0_2ND>,
> > +                             <PINMUX_GPIO172__FUNC_TDM_DATA1_2ND>,
> > +                             <PINMUX_GPIO173__FUNC_TDM_DATA2_2ND>,
> > +                             <PINMUX_GPIO10__FUNC_TDM_DATA3>; /*8ch-i2s to it6505*/
> > +                     drive-strength = <MTK_DRIVE_6mA>;
> > +             };
> > +     };
> > +
> > +     aud_pins_tdm_out_off: audiotdmoutoff {
> > +             pins_bus {
> > +                     pinmux = <PINMUX_GPIO169__FUNC_GPIO169>,
> > +                             <PINMUX_GPIO170__FUNC_GPIO170>,
> > +                             <PINMUX_GPIO171__FUNC_GPIO171>,
> > +                             <PINMUX_GPIO172__FUNC_GPIO172>,
> > +                             <PINMUX_GPIO173__FUNC_GPIO173>,
> > +                             <PINMUX_GPIO10__FUNC_GPIO10>;
> > +                     input-enable;
> > +                     bias-pull-down;
> > +                     drive-strength = <MTK_DRIVE_2mA>;
> > +             };
> > +     };
> > +
> >       bt_pins: bt-pins {
> >               pins_bt_en {
> >                       pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
> >
