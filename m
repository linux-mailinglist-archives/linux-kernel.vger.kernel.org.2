Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7229437FA13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhEMOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhEMOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:53:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA3C06134A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:52:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c20so4859411ejm.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OfZKh7G4FCWvdITFgddq0jjch2im9fcQcbtcvyCbJ0=;
        b=yGER9sFeqImCRTjxagvrdLG2NXeJuvmnYhHyvT/N3ibkZ0cOji38G2r3ETIQg+Hjkh
         iWkFpwduPfMD3/zTiaVJ5R/D6Ok2eqmCn9maTaJ/XEGisZQmWko1EbbZbCNg/o0Xndbk
         UYvAC19wnmE2b1jbVkkvuAd/MEoAVq+usc6vd24X0pLgwurO+L6JcwXQUFVvnneLHfHE
         N8Wt49yUqefE6Hhrn/kIxCPfhOu7Ka1HDFak1FUkPbIMhdwRWDRVdLBwPcKzg6R38lYQ
         FHk8DwLtiXp6G+VquVP9NSbHCv4qUZ0WD4WJ/LjTrYVZ5SjRrsW51DB/8qINyepIGEV/
         r6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OfZKh7G4FCWvdITFgddq0jjch2im9fcQcbtcvyCbJ0=;
        b=ClqigriOqMXj+X3RXFBMn3UkekTRLja34MDkxoMRUO9PzzJkvcfYlXN8jievGMfX4t
         K3MO0WLW8y/WGUS4JxHdYDIkaAIj5hIQ1m6cSVVOLmcWxsHemWZLsWQsBie9g6LMwSEq
         prZ3JyyIPryWhWH4BApH8p0sfgoqk3YDxHmcxTXn7f8SGE4W9EgGqoSAS+A0mVypZBdD
         zXC7XJimSRVSP4YQ8KupXSVHK/9EYpm6VZj5gFGODbYVBYjjHoF9l+LKOhij06PLvMYN
         sey/IgVgGdM3PcF9duHa3sNSUXQHgDV7hDc+fZCcpT7nQ5twUxjUHbp3UibkzdEoCUy9
         92Zg==
X-Gm-Message-State: AOAM530ub1bfv7B6rhJ1PAhWI4GXD7du1SL/HXtOkooPlsbW0YhytzjQ
        SGVgHMn8V2JEgywoYnFw3JTxlfqx3DgGrtVs8IdIyg==
X-Google-Smtp-Source: ABdhPJxM3ATiNSUpOAOJ9eWZOuQdhYbDZCWVTt9AZfZgddggWQHRJ7iT1otIC6/tIvl+X8AGtpE7CYg8qTpqn1cHFCY=
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr13061663ejl.430.1620917525095;
 Thu, 13 May 2021 07:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210421052855.1279713-1-drinkcat@chromium.org> <20210421132841.v13.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
In-Reply-To: <20210421132841.v13.2.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 13 May 2021 11:51:53 -0300
Message-ID: <CAAEAJfBQzTQmZxTeq3gQcDgNbvMtzgNXegnY0MWUOC1MZ-W1mw@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] arm64: dts: mt8183: Add node for the Mali GPU
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, 21 Apr 2021 at 02:29, Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Add a basic GPU node for mt8183.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> The binding we use with out-of-tree Mali drivers includes more
> clocks, this is used for devfreq: the out-of-tree driver switches
> clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> switches clk_mux back to clk_main_parent:
> (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> clocks =
>         <&topckgen CLK_TOP_MFGPLL_CK>,
>         <&topckgen CLK_TOP_MUX_MFG>,
>         <&clk26m>,
>         <&mfgcfg CLK_MFG_BG3D>;
> clock-names =
>         "clk_main_parent",
>         "clk_mux",
>         "clk_sub_parent",
>         "subsys_mfg_cg";
> (based on discussions, this probably belongs in the clock core)
>
> This only matters for devfreq, that is disabled anyway as we don't
> have platform-specific code to handle >1 supplies.
>

Nit: I think some of this info could be relevant, so I'd make
it part of the commit description.

> (no changes since v12)
>
> Changes in v12:
>  - Add gpu node to mt8183-pumpkin.dts as well (Neil Armstrong).
>
> Changes in v11:
>  - mt8183*.dts: remove incorrect supply-names
>
> Changes in v6:
>  - Add gpu regulators to kukui dtsi as well.
>  - Power domains are now attached to spm, not scpsys
>  - Drop R-B.
>
> Changes in v5:
>  - Rename "2d" power domain to "core2" (keep R-B again).
>
> Changes in v4:
>  - Add power-domain-names to describe the 3 domains.
>    (kept Alyssa's reviewed-by as the change is minor)
>
> Changes in v2:
>  - Use sram instead of mali_sram as SRAM supply name.
>  - Rename mali@ to gpu@.
>
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
>  .../boot/dts/mediatek/mt8183-pumpkin.dts      |   5 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
>  4 files changed, 120 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index edff1e03e6fe..7bc0a6a7fadf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -42,6 +42,11 @@ &auxadc {
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
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcfa3370..e4e54be1c2b2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -279,6 +279,11 @@ dsi_out: endpoint {
>         };
>  };
>
> +&gpu {
> +       mali-supply = <&mt6358_vgpu_reg>;
> +       sram-supply = <&mt6358_vsram_gpu_reg>;
> +};
> +
>  &i2c0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0_pins>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index 0aff5eb52e88..ee912825cfc6 100644
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
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a..c75fdeea8aa4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1118,6 +1118,111 @@ mfgcfg: syscon@13000000 {
>                         #clock-cells = <1>;
>                 };
>
> +               gpu: gpu@13040000 {
> +                       compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
> +                       reg = <0 0x13040000 0 0x4000>;
> +                       interrupts =
> +                               <GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
> +                               <GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
> +                               <GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
> +                       interrupt-names = "job", "mmu", "gpu";
> +
> +                       clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> +
> +                       power-domains =
> +                               <&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
> +                               <&spm MT8183_POWER_DOMAIN_MFG_CORE1>,
> +                               <&spm MT8183_POWER_DOMAIN_MFG_2D>;
> +                       power-domain-names = "core0", "core1", "core2";
> +
> +                       operating-points-v2 = <&gpu_opp_table>;
> +               };
> +
> +               gpu_opp_table: opp_table0 {

If my eyes don't fool me, the OPP table being here means it's a child
of the "soc" node. Given it's not an SoC peripheral,
it'd make more sense to move it to root "/".

Other than that, I think it looks good:

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks!
Ezequiel
