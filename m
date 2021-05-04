Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1924373189
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhEDUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:40:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:39:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v191so200896pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEqfxQ8AAlsu+BA0zZiz8XTuNkSjbiVEIHbGrgKCVi8=;
        b=GGuJilI16Gv4WOlQW6tn1pgVQ58LtiENpN908u49RMGv5e2GYCIUjcF79VbZQSmdsD
         5uACNWMbx+uFZMLspHU6HP/WXBQqDRVO7bHNinjFEPDsBAJMFHsqzNNTLTaRaOJFV0ak
         kJ/CIIJnj91/sGIYPLFCdAADLtrxSI1R0lEz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEqfxQ8AAlsu+BA0zZiz8XTuNkSjbiVEIHbGrgKCVi8=;
        b=n/EoRUSgXtUvoymMYqQBtLdmF/hB+0BSLdlDfmJz920XhvoNSYKl3yYfEr2r/jk7zr
         UDKztCxhgFrZRXSBnQ+hMniR+0fq08smv9juIiVm0J3najRODPd6z9CsYcsw6uyAB/Dy
         oX14LHgodY9Vzfvi//x6uHEUc9VCCiqtUMsXRzRNeddB4+lUMSgGqlDNUWdgOeHYrIUp
         JPcT+KK/Lg1d6fkKgZ/M8rOa++YVPgXNV9xEWLsz5V4WwYTQQynQssxnb79KU8YFpA6r
         BuToH9gDGU48u9iogeBKPhUbb8uhL3FUTd23seH6uTKrtxIw2ltDkLEyfYVKUGsG6c5j
         LFoA==
X-Gm-Message-State: AOAM532qMJ8qVM4nR2oRz8GE+o2CzYwPnHV3vfuBe4IdLb6NT54Y1slE
        ytBqMSMlGmZmliIpLDPxvSVVGg==
X-Google-Smtp-Source: ABdhPJw70Bzwz7Ixp5BNK3ZDju26UjgK5+nxgewmkhgxHZs+LG9de3cybj+Zkurxz1k6rfsJhAtUIA==
X-Received: by 2002:a17:90b:3593:: with SMTP id mm19mr30682409pjb.146.1620160757518;
        Tue, 04 May 2021 13:39:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4c2f:1f84:af45:6245])
        by smtp.gmail.com with UTF8SMTPSA id h21sm7617673pjv.47.2021.05.04.13.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:39:16 -0700 (PDT)
Date:   Tue, 4 May 2021 13:39:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sc7280: Add USB related nodes
Message-ID: <YJGw86qt6iGsYJJ2@google.com>
References: <1620112135-1388-1-git-send-email-sanm@codeaurora.org>
 <1620112135-1388-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1620112135-1388-2-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 12:38:54PM +0530, Sandeep Maheswaram wrote:
> Add nodes for DWC3 USB controller, QMP and HS USB PHYs in sc7280 SOC.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
> changes in v3:
>  removed space between clock and clock-names.
> 
> changes in v2:
>  Moved #clock-cells property to child node in  usb_1_qmpphy.
>  changed phy@88e9000 to phy-wrapper@88e9000 to avoid  binding check error.
>  changed lanes@88e9200 to usb3-phy@88e9200 to avoid  binding check error.
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 149 +++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2cc4785..c95e143 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -805,6 +805,110 @@
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sc7280-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0 0x088e3000 0 0x400>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		};
> +
> +		usb_2_hsphy: phy@88e4000 {
> +			compatible = "qcom,sc7280-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0 0x088e4000 0 0x400>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
> +		};
> +
> +		usb_1_qmpphy: phy-wrapper@88e9000 {
> +			compatible = "qcom,sm8250-qmp-usb3-phy";
> +			reg = <0 0x088e9000 0 0x200>,
> +			      <0 0x088e8000 0 0x20>;
> +			reg-names = "reg-base", "dp_com";
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_1_ssphy: usb3-phy@88e9200 {
> +				reg = <0 0x088e9200 0 0x200>,
> +				      <0 0x088e9400 0 0x200>,
> +				      <0 0x088e9c00 0 0x400>,
> +				      <0 0x088e9600 0 0x200>,
> +				      <0 0x088e9800 0 0x200>,
> +				      <0 0x088e9a00 0 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb_2: usb@8cf8800 {
> +			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> +			reg = <0 0x08cf8800 0 0x400>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			dma-ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface","mock_utmi",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +				     <&pdc 13 IRQ_TYPE_EDGE_RISING>,
> +				     <&pdc 12 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "hs_phy_irq",
> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_SEC_BCR>;
> +
> +			usb_2_dwc3: dwc3@8c00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x08c00000 0 0xe000>;
> +				interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0xa0 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_2_hsphy>;
> +				phy-names = "usb2-phy";
> +				maximum-speed = "high-speed";
> +			};
> +		};
> +
>  		system-cache-controller@9200000 {
>  			compatible = "qcom,sc7280-llcc";
>  			reg = <0 0x09200000 0 0xd0000>, <0 0x09600000 0 0x50000>;
> @@ -812,6 +916,51 @@
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> +			reg = <0 0x0a6f8800 0 0x400>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			dma-ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq", "ss_phy_irq";
> +
> +			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +			usb_1_dwc3: dwc3@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a600000 0 0xe000>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0xe0 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				maximum-speed = "super-speed";
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sc7280-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
