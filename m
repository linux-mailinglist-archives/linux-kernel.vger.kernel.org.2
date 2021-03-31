Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6995034DF65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhC3Dcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhC3DcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:32:17 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642CC061765
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:32:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so14282445otn.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i2x/X9BG63R//CVLfSoE0M4KR4xNiPeiHIWesuqNXQg=;
        b=hMekMY8xTYLPRNDqnA+0imQMhad461ftjU5eP/+mf/CZ/k++ps0jhGHZZ/3GZT38gJ
         OYWq8SQQv52tqliPkoRTSe48ZsO/BQ4O1uZTqGehyB4eNFAWUQooPRWDN1yRS1zM8eQ0
         xxOJXW5qCILG1qelliq4BhJ0BrvXhIw8SKFZ+Trk6pExuJgeBnzsb6NKm6dQmfOlEYDE
         0a2aeJMUacJlA9kyNy0vBygD2lZ3BeF23giehHJjsuBL4gD0xRbl1r725KJv5878EBOH
         meQcPDGcvEZ76LWfiIoIhFK7rUTHV6HMFBuyGF9yRkzg4XT3EyQDnJai1TxIeyste2r6
         LAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2x/X9BG63R//CVLfSoE0M4KR4xNiPeiHIWesuqNXQg=;
        b=WC/GdbVZZ2/vvW3AtDYLqmwGm3cCERlp60HZLbrQdJbxI1Oo2ejTE0rfEj37FPtODR
         WFtAlpJ1PYE9SBOopRs1QqHNd9IJXZ8wa0FdFg5fysFsfeg4fZ70aXWYtNA33fkFnrRb
         3gX4Zz8Wkz9aOTzIkxRXDktpUz8F7YxIBeypJEtZbKZlBMS/SVUHwxgxj+o/KJaTjFwM
         V6lf8UJDjVaelTLGcgLsuAPYtoyUqFoCIijjTy8P3BUWAWnMa+GeanM5PPRR7G+AAenm
         4nyBF24Ty8p/zhxreuTbBJdIvppn2YN/BZRpGHf/vVrHw8s69nZ2nEyvznwXpiQ2/M8V
         NKsQ==
X-Gm-Message-State: AOAM532qJ1vjlAxCW/ub/iQcQH1shdT5ABVeCL10ZSUg2nfbjxVIKLVs
        eQsEq7WcUbeI9OAqHhZTKtddbA==
X-Google-Smtp-Source: ABdhPJxsln1U2m1k+HQ5cLe+ywzbiHn8tOkGFBZBq7QPXmwIiDtU3emRaud6vI5YtnvpQZWzaM9UMQ==
X-Received: by 2002:a9d:624f:: with SMTP id i15mr25198184otk.6.1617075135673;
        Mon, 29 Mar 2021 20:32:15 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c7sm4133937oot.42.2021.03.29.20.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 20:32:15 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:32:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/7] arm64: dts: qcom: sm8250: switch usb1 qmp phy to
 USB3+DP mode
Message-ID: <YGKbvc//txcWJtA+@builder.lan>
References: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
 <20210328205257.3348866-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328205257.3348866-7-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28 Mar 15:52 CDT 2021, Dmitry Baryshkov wrote:

> USB1 QMP PHY is not just a USB3 PHY, but USB3+DP PHY. Change device tree
> nodes accordingly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Vinod, will you let me know when you've picked the driver changes so I
can pick the two DT patches?

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 947e1accae3a..0f79e6885004 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2097,12 +2097,11 @@ usb_2_hsphy: phy@88e4000 {
>  		};
>  
>  		usb_1_qmpphy: phy@88e9000 {
> -			compatible = "qcom,sm8250-qmp-usb3-phy";
> +			compatible = "qcom,sm8250-qmp-usb3-dp-phy";
>  			reg = <0 0x088e9000 0 0x200>,
> -			      <0 0x088e8000 0 0x20>;
> -			reg-names = "reg-base", "dp_com";
> +			      <0 0x088e8000 0 0x40>,
> +			      <0 0x088ea000 0 0x200>;
>  			status = "disabled";
> -			#clock-cells = <1>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> @@ -2116,7 +2115,7 @@ usb_1_qmpphy: phy@88e9000 {
>  				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
> -			usb_1_ssphy: lanes@88e9200 {
> +			usb_1_ssphy: usb3-phy@88e9200 {
>  				reg = <0 0x088e9200 0 0x200>,
>  				      <0 0x088e9400 0 0x200>,
>  				      <0 0x088e9c00 0 0x400>,
> @@ -2128,6 +2127,20 @@ usb_1_ssphy: lanes@88e9200 {
>  				clock-names = "pipe0";
>  				clock-output-names = "usb3_phy_pipe_clk_src";
>  			};
> +
> +			dp_phy: dp-phy@88ea200 {
> +				reg = <0 0x088ea200 0 0x200>,
> +				      <0 0x088ea400 0 0x200>,
> +				      <0 0x088eac00 0 0x400>,
> +				      <0 0x088ea600 0 0x200>,
> +				      <0 0x088ea800 0 0x200>,
> +				      <0 0x088eaa00 0 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
>  		};
>  
>  		usb_2_qmpphy: phy@88eb000 {
> -- 
> 2.30.2
> 
