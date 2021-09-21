Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807644139E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhIUSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhIUSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:19:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F75C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:17:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x124so385347oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4ndnE3A6HWrWUQFEpLBibvZpS/DSj/u5RwWUUcBBIbY=;
        b=M9q4eBksz0cSuyze2PDRWMN+/8AyzW1UW+oCWE+lKF8Z2CVt982CWqNfw6L8TSon+G
         reiUZmoZkSto0CNjXNKzVt4n/s+cY04W/A2IknIZap7ojgmwmYkvM8JMbshrSzkLYeu7
         VwQxIezIgtVR5pA6JAMYA2DsWYCdVUSfdFM/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4ndnE3A6HWrWUQFEpLBibvZpS/DSj/u5RwWUUcBBIbY=;
        b=ezxrtx9TmssjeJX5WwJWuJpc913UR16pIDyLXG0gyzczgo+sqDBdwYqNq7qfZag6gM
         d8kReLgIjTqxxhwICjrZX0iEigtK9/msc8GV1xZ9GJJUAku4cQIqTDzCCIQJVTa9t2d7
         ODP5bv1GD78mIQrC/1+iNoeD8PiMfjmDYwBnLph2Jp5Fndf71ilg1rm2hblXEgFixu5c
         U1cWHOLcXJxDCpMfN2R2fueiStsaAbqu6FrsPQ6fLlFFsccqDCtczLr72M5vLvrrNEn0
         cy6pLcM60EfgdueCrsFROszljpQAykV86/pMceVqD7GtUyPof7PfdI6f5uf+d5AEBQ1J
         RHBA==
X-Gm-Message-State: AOAM533m5bFZCq7T91eRU7QJgt7WtErqDfRXiFfQ+Of7tQxbh2aXWZPQ
        ztjVKrKiHPDWxc7CdipOEYC8O3DY4GwPzkagJWE+iA==
X-Google-Smtp-Source: ABdhPJyKrRMRshM7mtWtkfA0FX6HRcL56w59GugrJ4C/D9fm74PkXOWGt8OszBdOXp7+Mf9Fje/hrhpk5ziklYlRqus=
X-Received: by 2002:aca:3110:: with SMTP id x16mr4818312oix.64.1632248271650;
 Tue, 21 Sep 2021 11:17:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Sep 2021 11:17:51 -0700
MIME-Version: 1.0
In-Reply-To: <1632220746-25943-5-git-send-email-rajpat@codeaurora.org>
References: <1632220746-25943-1-git-send-email-rajpat@codeaurora.org> <1632220746-25943-5-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 21 Sep 2021 11:17:51 -0700
Message-ID: <CAE-0n53gvxkFEvGmX2TSPnrQsv-wnG4gZA6Z5cO8L7ChzAS0TA@mail.gmail.com>
Subject: Re: [PATCH V9 4/8] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-21 03:39:02)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2fbcb0a..b65c5da 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -536,24 +555,425 @@
>                 qupv3_id_0: geniqup@9c0000 {
>                         compatible = "qcom,geni-se-qup";
>                         reg = <0 0x009c0000 0 0x2000>;
> -                       clock-names = "m-ahb", "s-ahb";
>                         clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>                                  <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +                       clock-names = "m-ahb", "s-ahb";
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> +                       iommus = <&apps_smmu 0x123 0x0>;
>                         status = "disabled";
>
> +                       i2c0: i2c@980000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00980000 0 0x4000>;
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +                               clock-names = "se";
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c0_data_clk>;
> +                               interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +                                               <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +                                               <&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
> +                               status = "disabled";
> +                       };
> +
> +                       spi0: spi@980000 {
> +                               compatible = "qcom,geni-spi";
> +                               reg = <0 0x00980000 0 0x4000>;
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +                               clock-names = "se";
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>, <&qup_spi0_cs_gpio>;

This should only have qup_spi0_data_clk and qup_spi0_cs, not
qup_spi0_cs_gpio. Both qup controlled and gpio controlled options are
provided in case a board wants to use the qup version of chipselect, but
having them both used by default leads to conflicts and confusion. This
same comment applies to all spi pinctrl properties in this file. Please
keep the cs_gpio variants though so that boards can use them if they
want. They will be unused, but that's OK.

> +                               interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               power-domains = <&rpmhpd SC7280_CX>;
> +                               operating-points-v2 = <&qup_opp_table>;
> +                               interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +                                               <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +                               interconnect-names = "qup-core", "qup-config";
> +                               status = "disabled";
> +                       };
> +
