Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE339CCA3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFFECL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:02:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4DC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 20:59:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso286595oto.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 20:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yLxayT1GLLyu9ED1r5TJCfhThypNGEnhnrNs7AhNr1U=;
        b=YTPV8chRmjHPmt45awZrN+94Pea7iSJ3gVMg9xlsitK2q6HVSNhjhLDvEr2IAJ050O
         4eTho0fPITkWyHQHKlYaXRc217cHv0ymVOBsUG4BVq4EXZS5vQNJalbSBPtsFugRvFlp
         EO5I2O0tVF71j6kfNSMUAg4r2KSAszmwCkIux++TtsWZXvvOEvsA7/Q59k2muqckpFv3
         /6LMvUg8NR9TO183d7F2iZRaG7qSCKzlzfzKne+kwtwMtdhW3IozCUF07/DAFe0T1pXt
         6wf5TFGAiDPqV/wldQnXOwu5q4uzMZQyCki6yidMWB10hm6QII8TzExSF9dWDNnfW9/a
         Nwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLxayT1GLLyu9ED1r5TJCfhThypNGEnhnrNs7AhNr1U=;
        b=EDcCSGKbSXXCUqhgs3T8RtWeLEPBTBdZIDBd0uQaE9REYfzBhZSfPOd2muayZ4fxOk
         qCtA9paiEAS15EKfJFHSom80AJzBCtxi6slxYX3ZTXGmt9owrl1uvFwurrvbTieVQj+b
         y4v3I8O6nfNuB0d5iBLasJaHnOue/Ci+s4NvGgfC8hNv2tTE8MAruBCsXMWvBxDwZyxF
         gXUsrNi8tyN9Mf1ZnjnauDH413HMkU4LsCornVdarMB1PHPAg/MmUGOAAwO9Rv3nuLqX
         321Z6L1f3+mvy2CXb+OHB17kWPCgFfqikQ9Lwt2q9hY2NoFtq/I7gfCZp6SE3y+IlCpP
         vFwA==
X-Gm-Message-State: AOAM5312DxBJo+eilDIjF+7bdTqLyrd+Cv+Gf9MpeU4sc0iaWQe+F3Ek
        I3cfODhFIjDAOrXfHVUOIKIVtg==
X-Google-Smtp-Source: ABdhPJzOdcgIfV4AIGzCd7W1R7yczfXr3RIvERCKcJqHIpZLLmtnPmnpmW+CRwsawWf+mhYSg5LfQg==
X-Received: by 2002:a9d:7a94:: with SMTP id l20mr8961073otn.46.1622951992044;
        Sat, 05 Jun 2021 20:59:52 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d12sm1077984otf.65.2021.06.05.20.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 20:59:51 -0700 (PDT)
Date:   Sat, 5 Jun 2021 22:59:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7280: Add USB related nodes
Message-ID: <YLxINYgey58jRWnq@builder.lan>
References: <1622804618-18480-1-git-send-email-sanm@codeaurora.org>
 <1622804618-18480-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622804618-18480-2-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Jun 06:03 CDT 2021, Sandeep Maheswaram wrote:

> Add nodes for DWC3 USB controller, QMP and HS USB PHYs in sc7280 SOC.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> changed usb3-phy to lanes in qmp phy node as it was causing probe failure.
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 149 +++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0b6f119..d70d5fb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -973,6 +973,110 @@
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

No, your sc7280 doesn't have a sm8250 UBS PHY.

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
> +			usb_1_ssphy: lanes@88e9200 {
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

This should be usb@.

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
> @@ -980,6 +1084,51 @@
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

Ditto.

Regards,
Bjorn
