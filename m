Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D33662D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhDUAEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhDUADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:55 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067BC061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:03:22 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x9so5007897uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pWfqImez5c/AvjBdvwv0ThwA7fdMurH1H09DMK3D8E=;
        b=bCUOhHnYf8zZ2HGjarEZAx9Am08hh+poRRWb8icqE6E8KFe8FSyUfCWuWbjpz5x6Ic
         q1aN4mlV4RU0w/JWst/cMhetxCq55Xa1XZBb6mx6RprQMPP7BH4Sod/8nCp5/LnJuMxs
         MGYQR+tPzt2uRy0VxNa3RVooraO36yw0IR2ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pWfqImez5c/AvjBdvwv0ThwA7fdMurH1H09DMK3D8E=;
        b=B4jNZK5UO8JvqAk8MLoY4qeuzofotvHG+8uJg4zn8Cgha9/q+DW5XRiSVAee8AJ/zO
         IsjSJGnWTasm+twHoh8QKnme+7HL3Ij7Xq/vzvJ8CD/zb6f1prasPa79Gd4Dh/xbWuHA
         8IJpO2kpq8MshGVf8oykvBxaDxFC9MBtfNf/y/ni2gKTB7PmrirycW4KzhaaDEdLqMVM
         u24s/wl0jusq3GH7bwVQDPOzkYdHZ+/e01aUfMpgiv6OZ2ewi9/FFI44/Z2Vlesdkf7S
         /CTCaYczOh2E+EHIM+fZ0WNZ9Q4SO8+Bdi2v6MnpGg/HGukUHyQoKisQGe6pVGtozpLB
         dEYA==
X-Gm-Message-State: AOAM531ADlY0S/w576Ju2+rdLFEjpikFzlZPP2jBQ7WTbhTjAZGp3+W5
        1VxPINNQaDudtIYnrsMHtfLFAs6PuguSJ2BcMiCtiQ==
X-Google-Smtp-Source: ABdhPJzo1HIB/m7CJLvMIj2ZoR2HWULK0YObQ5wtKPidV7QWFoxV0pht9shOXTz97PvrW74Ix1b3dUqPnwPRnQtavz4=
X-Received: by 2002:ab0:638e:: with SMTP id y14mr14599883uao.82.1618963401853;
 Tue, 20 Apr 2021 17:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210126011759.1605641-1-drinkcat@chromium.org>
 <20210126091747.v11.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid> <1a37f9be-8ec8-893a-e2fc-f0739948f71f@baylibre.com>
In-Reply-To: <1a37f9be-8ec8-893a-e2fc-f0739948f71f@baylibre.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 21 Apr 2021 08:03:10 +0800
Message-ID: <CANMq1KBMXyYsjmaoVa+qb1TiSTm5ZqViqno36hJk0hNAUr4pmA@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] arm64: dts: mt8183: Add node for the Mali GPU
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Fei Shao <fshao@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 26/01/2021 02:17, Nicolas Boichat wrote:
> > Add a basic GPU node for mt8183.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > The binding we use with out-of-tree Mali drivers includes more
> > clocks, this is used for devfreq: the out-of-tree driver switches
> > clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> > switches clk_mux back to clk_main_parent:
> > (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> > clocks =
> >         <&topckgen CLK_TOP_MFGPLL_CK>,
> >         <&topckgen CLK_TOP_MUX_MFG>,
> >         <&clk26m>,
> >         <&mfgcfg CLK_MFG_BG3D>;
> > clock-names =
> >         "clk_main_parent",
> >         "clk_mux",
> >         "clk_sub_parent",
> >         "subsys_mfg_cg";
> > (based on discussions, this probably belongs in the clock core)
> >
> > This only matters for devfreq, that is disabled anyway as we don't
> > have platform-specific code to handle >1 supplies.
> >
> > Changes in v11:
> >  - mt8183*.dts: remove incorrect supply-names
> >
> > Changes in v10: None
> > Changes in v9: None
> > Changes in v8: None
> > Changes in v7: None
> > Changes in v6:
> >  - Add gpu regulators to kukui dtsi as well.
> >  - Power domains are now attached to spm, not scpsys
> >  - Drop R-B.
> >
> > Changes in v5:
> >  - Rename "2d" power domain to "core2" (keep R-B again).
> >
> > Changes in v4:
> >  - Add power-domain-names to describe the 3 domains.
> >    (kept Alyssa's reviewed-by as the change is minor)
> >
> > Changes in v3: None
> > Changes in v2:
> >  - Use sram instead of mali_sram as SRAM supply name.
> >  - Rename mali@ to gpu@.
> >
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
> >  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >
>
> If you re-spin, you can also add the same changes to mt8183-pumpkin.dts :

Will do in v12.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index eb6e595c2975..cc23e5df391e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -68,6 +68,11 @@ &auxadc {
>         status = "okay";
>  };
>
> +&gpu {
> +       mali-supply = <&mt6358_vgpu_reg>;
> +       sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c_pins_0>;
>
> I did a boot-test of the platform with panfrost and drm-misc-next and it worked fine.

Great news thanks!

>
> Thanks,
> Neil
>
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index cba2d8933e79..1cfbea5a0101 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -42,6 +42,11 @@ &auxadc {
> >       status = "okay";
> >  };
> >
> > +&gpu {
> > +     mali-supply = <&mt6358_vgpu_reg>;
> > +     sram-supply = <&mt6358_vsram_gpu_reg>;
> > +};
> > +
> >  &i2c0 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&i2c_pins_0>;
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index bf2ad1294dd3..a38315b604df 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -249,6 +249,11 @@ &cpu7 {
> >       proc-supply = <&mt6358_vproc11_reg>;
> >  };
> >
> > +&gpu {
> > +     mali-supply = <&mt6358_vgpu_reg>;
> > +     sram-supply = <&mt6358_vsram_gpu_reg>;
> > +};
> > +
> >  &i2c0 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&i2c0_pins>;
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 5b782a4769e7..5430e05e18a0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -964,6 +964,111 @@ mfgcfg: syscon@13000000 {
> >                       #clock-cells = <1>;
> >               };
> >
> > +             gpu: gpu@13040000 {
> > +                     compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
> > +                     reg = <0 0x13040000 0 0x4000>;
> > +                     interrupts =
> > +                             <GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
> > +                             <GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
> > +                             <GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
> > +                     interrupt-names = "job", "mmu", "gpu";
> > +
> > +                     clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> > +
> > +                     power-domains =
> > +                             <&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
> > +                             <&spm MT8183_POWER_DOMAIN_MFG_CORE1>,
> > +                             <&spm MT8183_POWER_DOMAIN_MFG_2D>;
> > +                     power-domain-names = "core0", "core1", "core2";
> > +
> > +                     operating-points-v2 = <&gpu_opp_table>;
> > +             };
> > +
> > +             gpu_opp_table: opp_table0 {
> > +                     compatible = "operating-points-v2";
> > +                     opp-shared;
> > +
> > +                     opp-300000000 {
> > +                             opp-hz = /bits/ 64 <300000000>;
> > +                             opp-microvolt = <625000>, <850000>;
> > +                     };
> > +
> > +                     opp-320000000 {
> > +                             opp-hz = /bits/ 64 <320000000>;
> > +                             opp-microvolt = <631250>, <850000>;
> > +                     };
> > +
> > +                     opp-340000000 {
> > +                             opp-hz = /bits/ 64 <340000000>;
> > +                             opp-microvolt = <637500>, <850000>;
> > +                     };
> > +
> > +                     opp-360000000 {
> > +                             opp-hz = /bits/ 64 <360000000>;
> > +                             opp-microvolt = <643750>, <850000>;
> > +                     };
> > +
> > +                     opp-380000000 {
> > +                             opp-hz = /bits/ 64 <380000000>;
> > +                             opp-microvolt = <650000>, <850000>;
> > +                     };
> > +
> > +                     opp-400000000 {
> > +                             opp-hz = /bits/ 64 <400000000>;
> > +                             opp-microvolt = <656250>, <850000>;
> > +                     };
> > +
> > +                     opp-420000000 {
> > +                             opp-hz = /bits/ 64 <420000000>;
> > +                             opp-microvolt = <662500>, <850000>;
> > +                     };
> > +
> > +                     opp-460000000 {
> > +                             opp-hz = /bits/ 64 <460000000>;
> > +                             opp-microvolt = <675000>, <850000>;
> > +                     };
> > +
> > +                     opp-500000000 {
> > +                             opp-hz = /bits/ 64 <500000000>;
> > +                             opp-microvolt = <687500>, <850000>;
> > +                     };
> > +
> > +                     opp-540000000 {
> > +                             opp-hz = /bits/ 64 <540000000>;
> > +                             opp-microvolt = <700000>, <850000>;
> > +                     };
> > +
> > +                     opp-580000000 {
> > +                             opp-hz = /bits/ 64 <580000000>;
> > +                             opp-microvolt = <712500>, <850000>;
> > +                     };
> > +
> > +                     opp-620000000 {
> > +                             opp-hz = /bits/ 64 <620000000>;
> > +                             opp-microvolt = <725000>, <850000>;
> > +                     };
> > +
> > +                     opp-653000000 {
> > +                             opp-hz = /bits/ 64 <653000000>;
> > +                             opp-microvolt = <743750>, <850000>;
> > +                     };
> > +
> > +                     opp-698000000 {
> > +                             opp-hz = /bits/ 64 <698000000>;
> > +                             opp-microvolt = <768750>, <868750>;
> > +                     };
> > +
> > +                     opp-743000000 {
> > +                             opp-hz = /bits/ 64 <743000000>;
> > +                             opp-microvolt = <793750>, <893750>;
> > +                     };
> > +
> > +                     opp-800000000 {
> > +                             opp-hz = /bits/ 64 <800000000>;
> > +                             opp-microvolt = <825000>, <925000>;
> > +                     };
> > +             };
> > +
> >               mmsys: syscon@14000000 {
> >                       compatible = "mediatek,mt8183-mmsys", "syscon";
> >                       reg = <0 0x14000000 0 0x1000>;
> >
>
