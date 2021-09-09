Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882E1405D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbhIITQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbhIITQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:16:14 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FFC061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:15:04 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so900868oon.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=X+D/zXC15Sztu7hCHCid5gnO02nMT90v2w2N9r6H9H0=;
        b=JCFIqViuDyzXdeRbfp9b4Ps7xZlemQh7cNJH01qQyJpQ+uHiP42NjTE7oJPOKgOv1d
         OZrcpohU2Orz5buQCTXiyrSyDWYPrjQuMB22LcyQ5ACX1jU7dP43JZ68z13z7EoSqVmP
         DPF19ZZ9qfxEOi9nFNFpw4cRfuwDG6NGXoXac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=X+D/zXC15Sztu7hCHCid5gnO02nMT90v2w2N9r6H9H0=;
        b=dKoWJoerp5hSowcfBJ+wsEIUYZdivKspkbcE0kv5Tp4O3z6bip135ZSjlcz8LyT4dM
         YZiL7Q0fVNoB5b4IE2npxhYpmDkXAp+7s904zv9X2I20n65OVYNE/NvAl/pDhuG6jWIX
         W3m0AV8/30pD6OMaHJyXc+cudLmVanVNMDGEcu5EsAxY86GX/1umKXVd3R0yKeZUjPGX
         0gaITDIHwy2nsulHWRzKqGfp/6wg0Lqvdx+c2xChpcFSmC5wK8ADyO7aipvV2l13vfQY
         qxcFrjSB7EKTNRRi/KYjtwKtgaRAWdfz7FYbleRjjzh9xzHQtbirURX7RzY5zvv8UTPp
         r8xw==
X-Gm-Message-State: AOAM532jDpN0TZWCJgUSRjP5LngHDefdOs+aMqq72Iiek9OIV8UImsWo
        mNn0RYm+W2UOeaCFPY3KKa9pAdjz6yu/WV+lLEW9wQ==
X-Google-Smtp-Source: ABdhPJzq/dmil9c0cBFKt5jZ2mOaXCzoZ1B5mJ0oFBERA/8J3W9zfZf65TQivu70Se7KoS6Qf6CvICON8HB91vqxfWk=
X-Received: by 2002:a4a:919e:: with SMTP id d30mr1195316ooh.8.1631214903510;
 Thu, 09 Sep 2021 12:15:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Sep 2021 12:15:02 -0700
MIME-Version: 1.0
In-Reply-To: <1631209245-31256-3-git-send-email-pmaliset@codeaurora.org>
References: <1631209245-31256-1-git-send-email-pmaliset@codeaurora.org> <1631209245-31256-3-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 9 Sep 2021 12:15:02 -0700
Message-ID: <CAE-0n52ywAF_m7R4v_K6P=Z9=wgqXGscG4PXfPsDMOimdyS31w@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-09-09 10:40:43)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..422c112 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -7,6 +7,7 @@
>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interconnect/qcom,sc7280.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> @@ -586,6 +587,119 @@
>                         qcom,bcm-voters = <&apps_bcm_voter>;
>                 };
>
> +               pcie1: pci@1c08000 {
> +                       compatible = "qcom,pcie-sc7280", "qcom,pcie-sm8250";

Can you please drop pcie-sm8250?

> +                       reg = <0 0x01c08000 0 0x3000>,
> +                             <0 0x40000000 0 0xf1d>,
> +                             <0 0x40000f20 0 0xa8>,
> +                             <0 0x40001000 0 0x1000>,
> +                             <0 0x40100000 0 0x100000>;
> +
> +                       reg-names = "parf", "dbi", "elbi", "atu", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <1>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <2>;
> +                       pipe-clk-source-switch;

I thought this property was going away?

> +
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +                                <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +
> +                       interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi";
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +                                <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> +                                <&pcie1_lane 0>,
> +                                <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_PCIE_1_AUX_CLK>,
> +                                <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +                                <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +                                <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +                                <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +                                <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> +                                <&gcc GCC_DDRSS_PCIE_SF_CLK>;
> +
> +                       clock-names = "pipe",
> +                                     "pipe_mux",
> +                                     "phy_pipe",
> +                                     "ref",
> +                                     "aux",
> +                                     "cfg",
> +                                     "bus_master",
> +                                     "bus_slave",
> +                                     "slave_q2a",
> +                                     "tbu",
> +                                     "ddrss_sf_tbu";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +                       assigned-clock-rates = <19200000>;
> +
> +                       resets = <&gcc GCC_PCIE_1_BCR>;
> +                       reset-names = "pci";
> +
> +                       power-domains = <&gcc GCC_PCIE_1_GDSC>;
> +
> +                       phys = <&pcie1_lane>;
> +                       phy-names = "pciephy";
> +
> +                       perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;

This should move to the board file because it's a plain old gpio.

> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pcie1_default_state>;
> +
> +                       iommus = <&apps_smmu 0x1c80 0x1>;
> +
> +                       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> +                                   <0x100 &apps_smmu 0x1c81 0x1>;
> +
> +                       status = "disabled";
> +               };
> +
> +               pcie1_phy: phy@1c0e000 {
> +                       compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy";

sc7280-qmp-gen3x2-pcie-phy?

> +                       reg = <0 0x01c0e000 0 0x1c0>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +                                <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +                                <&gcc GCC_PCIE_CLKREF_EN>,
> +                                <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
> +                       clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +                       resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> +                       reset-names = "phy";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
> +                       assigned-clock-rates = <100000000>;
> +
> +                       status = "disabled";
> +
> +                       pcie1_lane: lanes@1c0e200 {
> +                               reg = <0 0x01c0e200 0 0x170>,
> +                                     <0 0x01c0e400 0 0x200>,
> +                                     <0 0x01c0ea00 0 0x1f0>,
> +                                     <0 0x01c0e600 0 0x170>,
> +                                     <0 0x01c0e800 0 0x200>,
> +                                     <0 0x01c0ee00 0 0xf4>;
> +                               clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                               clock-names = "pipe0";
> +
> +                               #phy-cells = <0>;
> +                               #clock-cells = <1>;
> +                               clock-output-names = "pcie_1_pipe_clk";
> +                       };
> +               };
> +
>                 ipa: ipa@1e40000 {
>                         compatible = "qcom,sc7280-ipa";
>
> @@ -1598,6 +1712,13 @@
>                                         bias-bus-hold;
>                                 };
>                         };
> +
> +                       pcie1_default_state: pcie1-default-state {
> +                               clkreq {

Drop clkreq node and just put the pin and function directly inside
please.

> +                                       pins = "gpio79";
> +                                       function = "pcie1_clkreqn";
> +                               };
> +                       };
>                 };
>
>                 apps_smmu: iommu@15000000 {
