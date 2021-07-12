Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D853C5A29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhGLJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhGLJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:35:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A79AC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:33:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q18so42122725lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVxMITSvLRsKuJMECSfRXRB3DrxDGaXLul0nuRN/gbw=;
        b=jml+89C5HGq4uw5LCN1By7H+vIMgyUf/KZwmyjgDa+eALJRKUNTVtkklHxoXVCfzIB
         3bPGdTeYea3UY9DD28MvZVWs/5Rz4mTMVS4Vprc+k81FAQ0QjQHXgB5ZVLQa1LVwqxTt
         MVB2yg+K+fLDqh9axs/tlXOMl2E/2ipMRBrOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVxMITSvLRsKuJMECSfRXRB3DrxDGaXLul0nuRN/gbw=;
        b=NopP1LRX6CYeRsZkGOwG0NZ9TFANazOwSdV64lQKq8CmP3hoTQxNEtDPAh51q5t517
         N9Q3qQpTaUGXE6WH0GjL+Tk3h7pEqqs4vCwPp5VxrvnXxmFVzLjIyTP0uwCzjDPZ8pQR
         zNPc5g7B3e2cqokWmuF6xpnKPG749/b9fbAKlnqJTk9vg1JHXGcxH4MxtLEKiUIjbRVx
         2zpYDcRKxnQe9RYejQ9ByEPq1yfXTnp0fJ5CtFKeLLdKu1KP3StpnrQA8gagMCEaGiUE
         Oo5reaJItJNNTjPueCFlMnOctydFl+vbfNUJrRdZGZOgHASABjwq44vdt4l1t0uJb9MA
         5vfQ==
X-Gm-Message-State: AOAM531gpGmb+qiS5UcymRwmfc7oU0aGfQP9l2gyA3FocGheznfKzOVd
        jaDpQc84F+PfavB4jx/ZR1GFZ1dFyPGIP/iixqWwqQ==
X-Google-Smtp-Source: ABdhPJzYFZrThcPxdsQL+YpdbFKfbIMq9dOo1waGTbTAzPkm7KJM+K540+SN9hjxqe0HHKO4JboxCtB9hgdS6dRLfII=
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr1234700lfh.479.1626082380371;
 Mon, 12 Jul 2021 02:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-2-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-2-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 17:32:49 +0800
Message-ID: <CAGXv+5GLgwuo7EBJmqE7iksAnKTcXETvwOgUzrKMZJXo8CUDgA@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8195 clock
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 6:49 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8195.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 287 ++++++++++++++++++
>  .../mediatek/mediatek,mt8195-sys-clock.yaml   |  66 ++++
>  2 files changed, 353 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> new file mode 100644
> index 000000000000..21554b3515cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> @@ -0,0 +1,287 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Functional Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek functional clock controller provides various clocks on MT8195.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-nnasys
> +              - mediatek,mt8195-scp_adsp
> +              - mediatek,mt8195-audsys
> +              - mediatek,mt8195-audsys_src
> +              - mediatek,mt8195-imp_iic_wrap_s
> +              - mediatek,mt8195-imp_iic_wrap_w
> +              - mediatek,mt8195-mfgcfg
> +              - mediatek,mt8195-vppsys0
> +              - mediatek,mt8195-wpesys
> +              - mediatek,mt8195-wpesys_vpp0
> +              - mediatek,mt8195-wpesys_vpp1
> +              - mediatek,mt8195-vppsys1
> +              - mediatek,mt8195-imgsys
> +              - mediatek,mt8195-imgsys1_dip_top
> +              - mediatek,mt8195-imgsys1_dip_nr
> +              - mediatek,mt8195-imgsys1_wpe
> +              - mediatek,mt8195-ipesys
> +              - mediatek,mt8195-camsys
> +              - mediatek,mt8195-camsys_rawa
> +              - mediatek,mt8195-camsys_yuva
> +              - mediatek,mt8195-camsys_rawb
> +              - mediatek,mt8195-camsys_yuvb
> +              - mediatek,mt8195-camsys_mraw
> +              - mediatek,mt8195-ccusys
> +              - mediatek,mt8195-vdecsys_soc
> +              - mediatek,mt8195-vdecsys
> +              - mediatek,mt8195-vdecsys_core1
> +              - mediatek,mt8195-apusys_pll
> +              - mediatek,mt8195-vencsys
> +              - mediatek,mt8195-vencsys_core1
> +              - mediatek,mt8195-vdosys0
> +              - mediatek,mt8195-vdosys1
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

I think this really needs to describe some of the clock relations
between the various clock controllers. For example, both
"mediatek,mt8195-imp_iic_wrap_s" and "mediatek,mt8195-imp_iic_wrap_w"
take the CLK_TOP_I2C_SEL clock from "mediatek,mt8195-topckgen",
but it is not described.

> +
> +examples:
> +  - |
> +    nnasys: clock-controller@10211000 {
> +        compatible = "mediatek,mt8195-nnasys";
> +        reg = <0x10211000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    scp_adsp: clock-controller@10720000 {
> +        compatible = "mediatek,mt8195-scp_adsp";
> +        reg = <0x10720000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    audsys: clock-controller@10890000 {
> +        compatible = "mediatek,mt8195-audsys";
> +        reg = <0x10890000 0x10000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    audsys_src: clock-controller@108a0000 {
> +        compatible = "mediatek,mt8195-audsys_src";
> +        reg = <0x108a0000 0x2000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_s: clock-controller@11d03000 {
> +        compatible = "mediatek,mt8195-imp_iic_wrap_s";
> +        reg = <0x11d03000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_w: clock-controller@11e05000 {
> +        compatible = "mediatek,mt8195-imp_iic_wrap_w";
> +        reg = <0x11e05000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    mfgcfg: clock-controller@13fbf000 {
> +        compatible = "mediatek,mt8195-mfgcfg";
> +        reg = <0x13fbf000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vppsys0: clock-controller@14000000 {
> +        compatible = "mediatek,mt8195-vppsys0";
> +        reg = <0x14000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys: clock-controller@14e00000 {
> +        compatible = "mediatek,mt8195-wpesys";
> +        reg = <0x14e00000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys_vpp0: clock-controller@14e02000 {
> +        compatible = "mediatek,mt8195-wpesys_vpp0";
> +        reg = <0x14e02000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys_vpp1: clock-controller@14e03000 {
> +        compatible = "mediatek,mt8195-wpesys_vpp1";
> +        reg = <0x14e03000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vppsys1: clock-controller@14f00000 {
> +        compatible = "mediatek,mt8195-vppsys1";
> +        reg = <0x14f00000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys: clock-controller@15000000 {
> +        compatible = "mediatek,mt8195-imgsys";
> +        reg = <0x15000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_dip_top: clock-controller@15110000 {
> +        compatible = "mediatek,mt8195-imgsys1_dip_top";
> +        reg = <0x15110000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_dip_nr: clock-controller@15130000 {
> +        compatible = "mediatek,mt8195-imgsys1_dip_nr";
> +        reg = <0x15130000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_wpe: clock-controller@15220000 {
> +        compatible = "mediatek,mt8195-imgsys1_wpe";
> +        reg = <0x15220000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ipesys: clock-controller@15330000 {
> +        compatible = "mediatek,mt8195-ipesys";
> +        reg = <0x15330000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys: clock-controller@16000000 {
> +        compatible = "mediatek,mt8195-camsys";
> +        reg = <0x16000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawa: clock-controller@1604f000 {
> +        compatible = "mediatek,mt8195-camsys_rawa";
> +        reg = <0x1604f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_yuva: clock-controller@1606f000 {
> +        compatible = "mediatek,mt8195-camsys_yuva";
> +        reg = <0x1606f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawb: clock-controller@1608f000 {
> +        compatible = "mediatek,mt8195-camsys_rawb";
> +        reg = <0x1608f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_yuvb: clock-controller@160af000 {
> +        compatible = "mediatek,mt8195-camsys_yuvb";
> +        reg = <0x160af000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_mraw: clock-controller@16140000 {
> +        compatible = "mediatek,mt8195-camsys_mraw";
> +        reg = <0x16140000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ccusys: clock-controller@17200000 {
> +        compatible = "mediatek,mt8195-ccusys";
> +        reg = <0x17200000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys_soc: clock-controller@1800f000 {
> +        compatible = "mediatek,mt8195-vdecsys_soc";
> +        reg = <0x1800f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys: clock-controller@1802f000 {
> +        compatible = "mediatek,mt8195-vdecsys";
> +        reg = <0x1802f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys_core1: clock-controller@1803f000 {
> +        compatible = "mediatek,mt8195-vdecsys_core1";
> +        reg = <0x1803f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apusys_pll: clock-controller@190f3000 {
> +        compatible = "mediatek,mt8195-apusys_pll";
> +        reg = <0x190f3000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vencsys: clock-controller@1a000000 {
> +        compatible = "mediatek,mt8195-vencsys";
> +        reg = <0x1a000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vencsys_core1: clock-controller@1b000000 {
> +        compatible = "mediatek,mt8195-vencsys_core1";
> +        reg = <0x1b000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdosys0: clock-controller@1c01a000 {
> +        compatible = "mediatek,mt8195-vdosys0";
> +        reg = <0x1c01a000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdosys1: clock-controller@1c100000 {
> +        compatible = "mediatek,mt8195-vdosys1";
> +        reg = <0x1c100000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> new file mode 100644
> index 000000000000..ea379452ba91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek System Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek system clock controller provides various clocks and system configuration
> +  like reset and bus protection on MT8195.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-topckgen
> +              - mediatek,mt8195-infracfg_ao
> +              - mediatek,mt8195-apmixedsys
> +              - mediatek,mt8195-pericfg_ao
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Same thing for "mediatek,mt8195-topckgen". This clock controller takes
a bunch of the PLLs from "mediatek,mt8195-apmixedsys" as well as an
external oscillator, and muxes and divides them to produce various
clock ouptuts. These clock parents are not described.

In the external oscillator's case, the oscillator is described in the
device tree, but the clock parent relationship is described in the
clock driver in this series with a hard-coded clock name.

This really applies to all clock controllers. Unless it includes some
internal oscillator, it will always have some clock input used to produce
other clock outputs.


Regards
ChenYu

> +
> +examples:
> +  - |
> +    topckgen: syscon@10000000 {
> +        compatible = "mediatek,mt8195-topckgen", "syscon";
> +        reg = <0x10000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    infracfg_ao: syscon@10001000 {
> +        compatible = "mediatek,mt8195-infracfg_ao", "syscon";
> +        reg = <0x10001000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apmixedsys: syscon@1000c000 {
> +        compatible = "mediatek,mt8195-apmixedsys", "syscon";
> +        reg = <0x1000c000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    pericfg_ao: syscon@11003000 {
> +        compatible = "mediatek,mt8195-pericfg_ao", "syscon";
> +        reg = <0x11003000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
