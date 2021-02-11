Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805231940C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBKUMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhBKUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:06:47 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A5DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:06:07 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m144so6516453qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hv4lUwqRmdU+zJjYXcVYmdbm/qNHxm9LCaJxXrDhlE=;
        b=ZseHOs6I0xbZ1oY7DMn2sC2jBdoG7rymZsbeX4UpK+lJ0N/JgAqsiH1kn0G7blPzfG
         stjmcG1itAa3YIJs3TKGTNe5+mEn5mywatsWyHEur5UayWM/K0KueSz3nOSyXOnih6Hg
         tpYGx4p+tftizyCHhzAJqSxhtGL1vUgdQtqyvIgI8X/4PCsCDZaQ48OAhxgw+GWao+On
         Mq6cSGgG+fNclfcFT5svf3ZCfNjZ4a5eKtfSYO3ZXsE/soVvgvwHcSZsl5Szrp1SEBSF
         M3+ZfIvThQVvuFysVWLnqXntVquTPYlGv+M7Tp6akFCHBW+QzBF3pJYrsBlO2bc4wHaw
         VCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hv4lUwqRmdU+zJjYXcVYmdbm/qNHxm9LCaJxXrDhlE=;
        b=bBbvlw613GFg9WOF6WA2aGNjJxEUv6Z49kMsR4smsxUOc6h0RC02rNZTpggr7wTomr
         a0tIkZcBhUo/gDf97pfvMHXDO2vjL+wIoB/MagZktoIRbZIDHX3cS+naAInx/8v4fMA6
         P2R43DBXlvTkGuVzsMkq3rHA5YFLDuJ+6QZ7+KjG1FCzJ+GmSqYR9mbvYuqR919qrSxp
         UhZ6co8gZ7IU14h1dtkHa9f4PWLY6hvhlmh6Q/ubVykN9oUdEbq9DfD2L6RE0Mtx50wh
         3qrR9tInWM9xct0D3uOndZUEQIH6QZtVuVaGka79RWgC0m1aRIVucZgTzR6Tq6hfcMsd
         H95w==
X-Gm-Message-State: AOAM5331jiMZukKYydNgpcEI5HiV1adZ7Ha19WHBSev41H2MO3H84D9l
        OpfsbArlaGB/ng8pV4exYTDZ2BEQaYaBx5PWZ1iYrA==
X-Google-Smtp-Source: ABdhPJwqJXqsJl6ykCAgNYtBOLUyLN20SVwY6rjODAl5bUsVJjWO/7J8MqoUWjbG9+3n5NV62JcBGYiSf9cnPZ9tpCQ=
X-Received: by 2002:a37:5702:: with SMTP id l2mr5561143qkb.486.1613073966499;
 Thu, 11 Feb 2021 12:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20210211181002.22922-1-jonathan@marek.ca> <20210211181002.22922-3-jonathan@marek.ca>
In-Reply-To: <20210211181002.22922-3-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 11 Feb 2021 23:05:54 +0300
Message-ID: <CAA8EJprpkvRG79PXkEYUkK1rcyrXFtS39yyquucooiXaxuP_HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: fix display nodes
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 at 21:11, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Apply these fixes to the newly added sm8250 display ndoes
>  - Use sm8250 compatibles instead of sdm845 compatibles
>  - Remove "notused" interconnect (which apparently was blindly copied from
>    my old patches)
>  - Use dispcc node example from dt-bindings, removing clocks which aren't
>    documented or used by the driver and fixing the region size.
>
> Note: also removed the mmcx-supply for dispcc which wasn't documented when
> it was added. I would have left it there but it is also breaking my
> use-case (setting a lower power level than what the bootloader sets?).

In our use case dispcc does not work w/o mmcx-supply. Compare this
with the downstream kernel, which actively uses MMCX domain.

> Fixes: 7c1dffd471b1 ("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 34 ++++++++--------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 947e1accae3a..20a3ff30e924 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2323,14 +2323,13 @@ usb_2_dwc3: dwc3@a800000 {
>                 };
>
>                 mdss: mdss@ae00000 {
> -                       compatible = "qcom,sdm845-mdss";
> +                       compatible = "qcom,sm8250-mdss";
>                         reg = <0 0x0ae00000 0 0x1000>;
>                         reg-names = "mdss";
>
> -                       interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_DISPLAY_CFG>,
> -                                       <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
> +                       interconnects = <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
>                                         <&mmss_noc MASTER_MDP_PORT1 &mc_virt SLAVE_EBI_CH0>;
> -                       interconnect-names = "notused", "mdp0-mem", "mdp1-mem";
> +                       interconnect-names = "mdp0-mem", "mdp1-mem";
>
>                         power-domains = <&dispcc MDSS_GDSC>;
>
> @@ -2356,7 +2355,7 @@ mdss: mdss@ae00000 {
>                         ranges;
>
>                         mdss_mdp: mdp@ae01000 {
> -                               compatible = "qcom,sdm845-dpu";
> +                               compatible = "qcom,sm8250-dpu";
>                                 reg = <0 0x0ae01000 0 0x8f000>,
>                                       <0 0x0aeb0000 0 0x2008>;
>                                 reg-names = "mdp", "vbif";
> @@ -2580,36 +2579,21 @@ opp-358000000 {
>
>                 dispcc: clock-controller@af00000 {
>                         compatible = "qcom,sm8250-dispcc";
> -                       reg = <0 0x0af00000 0 0x20000>;
> -                       mmcx-supply = <&mmcx_reg>;
> +                       reg = <0 0x0af00000 0 0x10000>;
>                         clocks = <&rpmhcc RPMH_CXO_CLK>,
>                                  <&dsi0_phy 0>,
>                                  <&dsi0_phy 1>,
>                                  <&dsi1_phy 0>,
>                                  <&dsi1_phy 1>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <&sleep_clk>;
> +                                <&dp_phy 0>,
> +                                <&dp_phy 1>;

There is no dp_phy on sm8250 yet.

>                         clock-names = "bi_tcxo",
>                                       "dsi0_phy_pll_out_byteclk",
>                                       "dsi0_phy_pll_out_dsiclk",
>                                       "dsi1_phy_pll_out_byteclk",
>                                       "dsi1_phy_pll_out_dsiclk",
> -                                     "dp_link_clk_divsel_ten",
> -                                     "dp_vco_divided_clk_src_mux",
> -                                     "dptx1_phy_pll_link_clk",
> -                                     "dptx1_phy_pll_vco_div_clk",
> -                                     "dptx2_phy_pll_link_clk",
> -                                     "dptx2_phy_pll_vco_div_clk",
> -                                     "edp_phy_pll_link_clk",
> -                                     "edp_phy_pll_vco_div_clk",
> -                                     "sleep_clk";
> +                                     "dp_phy_pll_link_clk",
> +                                     "dp_phy_pll_vco_div_clk";
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                         #power-domain-cells = <1>;



-- 
With best wishes
Dmitry
