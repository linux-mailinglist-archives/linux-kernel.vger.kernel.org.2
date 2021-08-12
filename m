Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE23EA64D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhHLOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbhHLOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:14:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D1C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:14:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so9760866pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vzOAwlW6UGTgJFrX/VxejOCt7Hf3onQCHKFGkK4RKA=;
        b=HQ1DN0OoFwFtZNWHKEVbapU4fxuKtGnWMlPF1IoxiF65FB0YXATxbkagvQ+Ix7a7/T
         uWmxSH+Ig0yWYp2ZOfzXWDOfpauCVW2CnZQM/+LAvbpFfEfv47kD6JBhPK9QFaiS9mRR
         DKRSpPcq1QqXaIUYqUZu/pXF9vfC22lQEhhYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vzOAwlW6UGTgJFrX/VxejOCt7Hf3onQCHKFGkK4RKA=;
        b=L4OA7J3lr1txpZVzQIKWuV09808/eeglDn2VW2Y7s0baEOV8fbS4v6EaUBE1RC9OhN
         k+IeRj2rtW4widzVb8M/Qmq9qtgecVam743onD4v2M8naYVhZi6NKhwObAxStLMLJJ2V
         GEMKCZ8iTfn2XiNIAtWVngbamTQncBo/uh9cQqUMQGJ69RZBPZUV3dm7FCNt2/o+2B02
         4AmluSQUd9WeMaF+L6CxYtyA/PX5C5+YnZDXtVoCOXMoBkKWgad2TmltAqV0Vfs62EyW
         MLBEbD/4uO/51M+L1jCRoULaRcWdPIhdRDeoRjd74lgAZ9XWwFX8qPxk1+e6lAMpH7Az
         DY1g==
X-Gm-Message-State: AOAM532cGQnrUCOLwt45P4557LMt6GcUFOVZhujK+sXVqNN33Gl0T+RD
        hiGURy9jcJKElWc8LhBJGKGQ3A==
X-Google-Smtp-Source: ABdhPJyxgMkKtgQp68WiyN+ECx1YNreWvyEeMVsjruEoAyEllCIwrsFrMLDFCgxUmBcyi165yLzIDA==
X-Received: by 2002:a63:f154:: with SMTP id o20mr4030502pgk.172.1628777649667;
        Thu, 12 Aug 2021 07:14:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9d69:4059:b8a6:e36f])
        by smtp.gmail.com with UTF8SMTPSA id 17sm10655129pjd.3.2021.08.12.07.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 07:14:09 -0700 (PDT)
Date:   Thu, 12 Aug 2021 07:14:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: Re: [PATCH V5 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
Message-ID: <YRUsr6x9vqvaBB9i@google.com>
References: <1628754078-29779-1-git-send-email-rajpat@codeaurora.org>
 <1628754078-29779-4-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1628754078-29779-4-git-send-email-rajpat@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:11:14PM +0530, Rajesh Patil wrote:
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
> 
> Add QUPv3 wrapper_0 DT nodes for SC7280 SoC.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 720 +++++++++++++++++++++++++++++++++++
>  1 file changed, 720 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index f8dd5ff..e461395 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -533,6 +533,25 @@
>  
>  		};
>  
> +		qup_opp_table: qup-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-75000000 {
> +				opp-hz = /bits/ 64 <75000000>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
> +			};
> +
> +			opp-100000000 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				required-opps = <&rpmhpd_opp_svs>;
> +			};
> +
> +			opp-128000000 {
> +				opp-hz = /bits/ 64 <128000000>;
> +				required-opps = <&rpmhpd_opp_nom>;
> +			};
> +		};
> +

Shouldn't the OPP table live outside of /soc, analogous to the discussion
about the QSPI OPP table (https://lkml.org/lkml/2021/7/19/3063)?


>  		qupv3_id_0: geniqup@9c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x009c0000 0 0x2000>;
> @@ -542,8 +561,305 @@
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> +			iommus = <&apps_smmu 0x123 0x0>;
>  			status = "disabled";
>  
> +			i2c0: i2c@980000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00980000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;

nit: the general convention seems to be 'clocks' followed by 'clock-names'.
Applicable to all nodes if you decide to change it.

> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c0_data_clk>;
> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@980000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00980000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>, <&qup_spi0_cs_gpio>;

What is the story behind 'qup_spiN_cs' and 'qup_spiN_cs_gpio'? Both configure
the CS pin with a different function:

  qup_spi0_cs: qup-spi0-cs {
  	pins = "gpio3";
  	function = "qup00";
  };

  qup_spi0_cs_gpio: qup-spi0-cs_gpio {
  	pins = "gpio3";
  	function = "gpio";
  };

> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart0: serial@980000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x00980000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart0_cts>, <&qup_uart0_rts>, <&qup_uart0_tx>, <&qup_uart0_rx>;
> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@984000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00984000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c1_data_clk>;
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi1: spi@984000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00984000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi1_data_clk>, <&qup_spi1_cs>, <&qup_spi1_cs_gpio>;
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart1: serial@984000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x00984000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@988000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00988000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c2_data_clk>;
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@988000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00988000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>, <&qup_spi2_cs_gpio>;
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart2: serial@988000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x00988000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart2_cts>, <&qup_uart2_rts>, <&qup_uart2_tx>, <&qup_uart2_rx>;
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@98c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x0098c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c3_data_clk>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi3: spi@98c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0098c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>, <&qup_spi3_cs_gpio>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart3: serial@98c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x0098c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart3_cts>, <&qup_uart3_rts>, <&qup_uart3_tx>, <&qup_uart3_rx>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@990000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00990000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c4_data_clk>;
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi4: spi@990000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00990000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>, <&qup_spi4_cs_gpio>;
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart4: serial@990000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x00990000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart4_cts>, <&qup_uart4_rts>, <&qup_uart4_tx>, <&qup_uart4_rx>;
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c5: i2c@994000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00994000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c5_data_clk>;
> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@994000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00994000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>, <&qup_spi5_cs_gpio>;
> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
>  			uart5: serial@994000 {
>  				compatible = "qcom,geni-debug-uart";
>  				reg = <0 0x00994000 0 0x4000>;
> @@ -554,6 +870,110 @@
>  				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
> +
> +			i2c6: i2c@998000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00998000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c6_data_clk>;
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi6: spi@998000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00998000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>, <&qup_spi6_cs_gpio>;
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart6: serial@998000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x00998000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart6_cts>, <&qup_uart6_rts>, <&qup_uart6_tx>, <&qup_uart6_rx>;
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			i2c7: i2c@99c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x0099c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c7_data_clk>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config",
> +							"qup-memory";
> +				status = "disabled";
> +			};
> +
> +			spi7: spi@99c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x0099c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi7_data_clk>, <&qup_spi7_cs>, <&qup_spi7_cs_gpio>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
> +
> +			uart7: serial@99c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0 0x0099c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart7_cts>, <&qup_uart7_rts>, <&qup_uart7_tx>, <&qup_uart7_rx>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				status = "disabled";
> +			};
>  		};
>  
>  		cnoc2: interconnect@1500000 {
> @@ -1575,11 +1995,311 @@
>  				function = "qspi_data";
>  			};
>  
> +			qup_i2c0_data_clk:qup-i2c0-data-clk {
> +				pins = "gpio0", "gpio1";
> +				function = "qup00";
> +			};
> +
> +			qup_i2c1_data_clk:qup-i2c1-data-clk {
> +				pins = "gpio4", "gpio5";
> +				function = "qup01";
> +			};
> +
> +			qup_i2c2_data_clk:qup-i2c2-data-clk {
> +				pins = "gpio8", "gpio9";
> +				function = "qup02";
> +			};
> +
  > +			qup_i2c3_data_clk:qup-i2c3-data-clk {
> +				pins = "gpio12", "gpio13";
> +				function = "qup03";
> +			};
> +
> +			qup_i2c4_data_clk:qup-i2c4-data-clk {
> +				pins = "gpio16", "gpio17";
> +				function = "qup04";
> +			};
> +
> +			qup_i2c5_data_clk:qup-i2c5-data-clk {
> +				pins = "gpio20", "gpio21";
> +				function = "qup05";
> +			};
> +
> +			qup_i2c6_data_clk:qup-i2c6-data-clk {
> +				pins = "gpio24", "gpio25";
> +				function = "qup06";
> +			};
> +
> +			qup_i2c7_data_clk:qup-i2c7-data-clk {
> +				pins = "gpio28", "gpio29";
> +				function = "qup07";
> +			};
> +
> +			qup_spi0_data_clk: qup-spi0-data-clk {
> +				pins = "gpio0", "gpio1", "gpio2";
> +				function = "qup00";
> +			};
> +
> +			qup_spi0_cs: qup-spi0-cs {
> +				pins = "gpio3";
> +				function = "qup00";
> +			};
> +
> +			qup_spi0_cs_gpio: qup-spi0-cs_gpio {
> +				pins = "gpio3";
> +				function = "gpio";
> +			};
> +
> +			qup_spi1_data_clk: qup-spi1-data-clk {
> +				pins = "gpio4", "gpio5", "gpio6";
> +				function = "qup01";
> +			};
> +
> +			qup_spi1_cs: qup-spi1-cs {
> +				pins = "gpio7";
> +				function = "qup01";
> +			};
> +
> +			qup_spi1_cs_gpio: qup-spi1-cs_gpio {
> +				pins = "gpio7";
> +				function = "gpio";
> +			};
> +
> +			qup_spi2_data_clk: qup-spi2-data-clk {
> +				pins = "gpio8", "gpio9", "gpio10";
> +				function = "qup02";
> +			};
> +
> +			qup_spi2_cs: qup-spi2-cs {
> +				pins = "gpio11";
> +				function = "qup02";
> +			};
> +
> +			qup_spi2_cs_gpio: qup-spi2-cs_gpio {
> +				pins = "gpio11";
> +				function = "gpio";
> +			};
> +
> +			qup_spi3_data_clk: qup-spi3-data-clk {
> +				pins = "gpio12", "gpio13", "gpio14";
> +				function = "qup03";
> +			};
> +
> +			qup_spi3_cs: qup-spi3-cs {
> +				pins = "gpio15";
> +				function = "qup03";
> +			};
> +
> +			qup_spi3_cs_gpio: qup-spi3-cs_gpio {
> +				pins = "gpio15";
> +				function = "gpio";
> +			};
> +
> +			qup_spi4_data_clk: qup-spi4-data-clk {
> +				pins = "gpio16", "gpio17", "gpio18";
> +				function = "qup04";
> +			};
> +
> +			qup_spi4_cs: qup-spi4-cs {
> +				pins = "gpio19";
> +				function = "qup04";
> +			};
> +
> +			qup_spi4_cs_gpio: qup-spi4-cs_gpio {
> +				pins = "gpio19";
> +				function = "gpio";
> +			};
> +
> +			qup_spi5_data_clk: qup-spi5-data-clk {
> +				pins = "gpio20", "gpio21", "gpio22";
> +				function = "qup05";
> +			};
> +
> +			qup_spi5_cs: qup-spi5-cs {
> +				pins = "gpio23";
> +				function = "qup05";
> +			};
> +
> +			qup_spi5_cs_gpio: qup-spi5-cs_gpio {
> +				pins = "gpio23";
> +				function = "gpio";
> +			};
> +
> +			qup_spi6_data_clk: qup-spi6-data-clk {
> +				pins = "gpio24", "gpio25", "gpio26";
> +				function = "qup06";
> +			};
> +
> +			qup_spi6_cs: qup-spi6-cs {
> +				pins = "gpio27";
> +				function = "qup06";
> +			};
> +
> +			qup_spi6_cs_gpio: qup-spi6-cs_gpio {
> +				pins = "gpio27";
> +				function = "gpio";
> +			};
> +
> +			qup_spi7_data_clk: qup-spi7-data-clk {
> +				pins = "gpio28", "gpio29", "gpio30";
> +				function = "qup07";
> +			};
> +
> +			qup_spi7_cs: qup-spi7-cs {
> +				pins = "gpio31";
> +				function = "qup07";
> +			};
> +
> +			qup_spi7_cs_gpio: qup-spi7-cs_gpio {
> +				pins = "gpio31";
> +				function = "gpio";
> +			};
> +
> +			qup_uart0_cts: qup-uart0-cts {
> +				pins = "gpio0";
> +				function = "qup00";
> +			};
> +
> +			qup_uart0_rts: qup-uart0-rts {
> +				pins = "gpio1";
> +				function = "qup00";
> +			};
> +
> +			qup_uart0_tx: qup-uart0-tx {
> +				pins = "gpio2";
> +				function = "qup00";
> +			};
> +
> +			qup_uart0_rx: qup-uart0-rx {
> +				pins = "gpio3";
> +				function = "qup00";
> +			};
> +
> +			qup_uart1_cts: qup-uart1-cts {
> +				pins = "gpio4";
> +				function = "qup01";
> +			};
> +
> +			qup_uart1_rts: qup-uart1-rts {
> +				pins = "gpio5";
> +				function = "qup01";
> +			};
> +
> +			qup_uart1_tx: qup-uart1-tx {
> +				pins = "gpio6";
> +				function = "qup01";
> +			};
> +
> +			qup_uart1_rx: qup-uart1-rx {
> +				pins = "gpio7";
> +				function = "qup01";
> +			};
> +
> +			qup_uart2_cts: qup-uart2-cts {
> +				pins = "gpio8";
> +				function = "qup02";
> +			};
> +
> +			qup_uart2_rts: qup-uart2-rts {
> +				pins = "gpio9";
> +				function = "qup02";
> +			};
> +
> +			qup_uart2_tx: qup-uart2-tx {
> +				pins = "gpio10";
> +				function = "qup02";
> +			};
> +
> +			qup_uart2_rx: qup-uart2-rx {
> +				pins = "gpio11";
> +				function = "qup02";
> +			};
> +
> +			qup_uart3_cts: qup-uart3-cts {
> +				pins = "gpio12";
> +				function = "qup03";
> +			};
> +
> +			qup_uart3_rts: qup-uart3-rts {
> +				pins = "gpio13";
> +				function = "qup03";
> +			};
> +
> +			qup_uart3_tx: qup-uart3-tx {
> +				pins = "gpio14";
> +				function = "qup03";
> +			};
> +
> +			qup_uart3_rx: qup-uart3-rx {
> +				pins = "gpio15";
> +				function = "qup03";
> +			};
> +
> +			qup_uart4_cts: qup-uart4-cts {
> +				pins = "gpio16";
> +				function = "qup04";
> +			};
> +
> +			qup_uart4_rts: qup-uart4-rts {
> +				pins = "gpio17";
> +				function = "qup04";
> +			};
> +
> +			qup_uart4_tx: qup-uart4-tx {
> +				pins = "gpio18";
> +				function = "qup04";
> +			};
> +
> +			qup_uart4_rx: qup-uart4-rx {
> +				pins = "gpio19";
> +				function = "qup04";
> +			};
> +
>  			qup_uart5_default: qup-uart5-default {
>  				pins = "gpio46", "gpio47";
>  				function = "qup13";
>  			};

Wait, why does uart5 use the pins of qup13? Is see this is
'fixed' by '[4/7] arm64: dts: sc7280: Update QUPv3 UART5 DT
node' but I'm still surprised ...

Doesn't 'fixing' this break devices that are currently using
'uart5'? It seems those devices would need to change from
'uart5' to 'uart11'.
