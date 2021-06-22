Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B73B0E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFVUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhFVUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:20:12 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42FC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:17:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x196so720398oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cpA2xD2FjsLrzZmU0oN2BW/VHUt5Zn6smoNUos5bsDI=;
        b=bnjFPTNRqg6zdQLI/eYX+f1Y6x45HgGfYF17XiAkOccY1E9PIaTYP29EJcPKJb3Cxm
         EUs7JZCgrUPIiz9gsF4o0/slLya1YIiXkYE/ZshviO8gcvHST8wyNWlk3Cif7+SdQH2j
         G6rAHR0a4jN3Ig4mOaz/qzdonUnpEl/WUGqXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cpA2xD2FjsLrzZmU0oN2BW/VHUt5Zn6smoNUos5bsDI=;
        b=Kw3N9FwJe0lz6JM1PLc+7x4BLhQtCx6LhSIik3EtAg/I2aAwadFbtqwgnMrfgG7jku
         sgfaSXW1DmHDX1IIFriL4GN7zE9bOf8MnMtE9WYdDIkzp6cCbeITQmI6E1KfMJEjJBjE
         ThvjL/QNSM/vOcydFGR8pq/E8c5R7+lZVS+WaDSw5FRTFnJYjUceNISe2M1UCzcLond1
         PIlk94TL9ZOjyJwrlWjB4l/qaFDKlsS7ScTzSbxhW2muDQPxjfYLE7MjYdfSIlYmIAcr
         SzIwo5FsX68suF9mbzpCjuog5W+roUWa2mtKcTJwGm+njUF64ZUI0wOPZmM4WziXEHvj
         E5Jw==
X-Gm-Message-State: AOAM5324XOU0miTxKjXIIMJmNyh73U6AZCecP3+BxdiGOFOFuDEdUbPB
        JxkK62EfhCrGnnDQkSUYIcy8TpjVChxSJGesCIBm7w==
X-Google-Smtp-Source: ABdhPJwde6azm9PoH3w6YvHb1B6Z71He6eFgrE5OOKljQKBwKbyM2R1pxvBRnnhFinnpFgCCltBuKyuuzlmbj1i21zE=
X-Received: by 2002:a54:4802:: with SMTP id j2mr418352oij.125.1624393074182;
 Tue, 22 Jun 2021 13:17:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jun 2021 13:17:53 -0700
MIME-Version: 1.0
In-Reply-To: <1623835381-29696-1-git-send-email-sbhanu@codeaurora.org>
References: <1623835381-29696-1-git-send-email-sbhanu@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 22 Jun 2021 13:17:53 -0700
Message-ID: <CAE-0n52KyStCcQ1QPFJBUvrTVB-NuBcQ9qnPhnzQj6PFiXPLGg@mail.gmail.com>
Subject: Re: [PATCH V4] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        sayalil@codeaurora.org, sartgarg@codeaurora.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        sibis@codeaurora.org, okukatla@codeaurora.org, djakov@kernel.org,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shaik Sajida Bhanu (2021-06-16 02:23:01)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 3900cfc..0f63cac 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmr735b.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/gpio/gpio.h>

The letter g comes before i, please move this higher in the list.

>  #include "sc7280.dtsi"
>  #include "pm7325.dtsi"
>  #include "pmr735a.dtsi"
> @@ -272,6 +273,34 @@
>         status = "okay";
>  };
>
> +&sdhc_1 {
> +       status = "okay";
> +
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&sdc1_on>;
> +       pinctrl-1 = <&sdc1_off>;
> +
> +       non-removable;
> +       no-sd;
> +       no-sdio;
> +
> +       vmmc-supply = <&vreg_l7b_2p9>;
> +       vqmmc-supply = <&vreg_l19b_1p8>;
> +};
> +
> +&sdhc_2 {
> +       status = "okay";
> +
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&sdc2_on>;
> +       pinctrl-1 = <&sdc2_off>;
> +
> +       vmmc-supply = <&vreg_l9c_2p9>;
> +       vqmmc-supply = <&vreg_l6c_2p9>;
> +
> +       cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
> +};
> +
>  &uart5 {
>         status = "okay";
>  };
> @@ -291,3 +320,55 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&tlmm {
> +       sdc1_on: sdc1-on {
> +               clk {
> +                       pins = "sdc1_clk";

Can the pins property at least be moved into sc7280.dtsi? Then this can
add bias and drive strength overrides in the board file?

> +                       bias-disable;
> +                       drive-strength = <16>;
> +               };
> +
> +               cmd {
> +                       pins = "sdc1_cmd";
> +                       bias-pull-up;
> +                       drive-strength = <10>;
> +               };
> +
> +               data {
> +                       pins = "sdc1_data";
> +                       bias-pull-up;
> +                       drive-strength = <10>;
> +               };
> +
> +               rclk {
> +                       pins = "sdc1_rclk";
> +                       bias-pull-down;
> +               };
> +       };
> +
> +       sdc2_on: sdc2-on {
> +               clk {
> +                       pins = "sdc2_clk";
> +                       bias-disable;
> +                       drive-strength = <16>;
> +               };
> +
> +               cmd {
> +                       pins = "sdc2_cmd";
> +                       bias-pull-up;
> +                       drive-strength = <10>;
> +               };
> +
> +               data {
> +                       pins = "sdc2_data";
> +                       bias-pull-up;
> +                       drive-strength = <10>;
> +               };
> +
> +               sd-cd {
> +                       pins = "gpio91";
> +                       bias-pull-up;
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d600bca..16d8e17 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -974,6 +1033,51 @@
>                         };
>                 };
>
> +               sdhc_2: sdhci@8804000 {
> +                       compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> +                       status = "disabled";
> +
> +                       reg = <0 0x08804000 0 0x1000>;
> +
> +                       iommus = <&apps_smmu 0x100 0x0>;
> +                       interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hc_irq", "pwr_irq";
> +
> +                       clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> +                                <&gcc GCC_SDCC2_AHB_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "core", "iface", "xo";
> +                       interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +                                       <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_2 0>;
> +                       interconnect-names = "sdhc-ddr","cpu-sdhc";
> +                       power-domains = <&rpmhpd SC7280_CX>;
> +                       operating-points-v2 = <&sdhc2_opp_table>;
> +
> +                       bus-width = <4>;
> +
> +                       qcom,dll-config = <0x0007642c>;
> +
> +                       sdhc2_opp_table: sdhc2-opp-table {

Any reason the node shouldn't be called opp-table?
