Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5F352FB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhDBT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhDBT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:26:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181CC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 12:26:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5012437pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4s6Vtv2vZ6Bbjawt/rPkfCViiVZXuVBQF1DqpILNog=;
        b=Qveu1dP3Ik/eATP/5cOdXPxeermVJGHI6+RBORNj4W2OT4aAAxar7/Tljz7dbKTjB6
         tuUbpmAfXocO6pRSE6oA2E1aEA5NShAFvHSNwc7XxXX1434uDmtm+QM8DVC1VZaoFgLv
         xVAi/cBacSuhHPu4OSgpBs9agiBBFCmcq06Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4s6Vtv2vZ6Bbjawt/rPkfCViiVZXuVBQF1DqpILNog=;
        b=tbHzJ7rOpjIwqREXctPeVCfua09HylVU/DqXlefg54cRFWqHbSxZCfyR0bsaOtO+5X
         GSAFofYIn2gSaPBFcpKECjpHbnEGHBCpdngYvG+Ia4Piz2cfXfXbqxEsGtfPidGXbnvd
         2w+vIm4CC18RP2XP4vTYR3vfevOi4DLy6/+bjkGDIPBmiHLEuX3bFte64rLHKw2mIQYY
         ly6yVWRYHRfUcrodfx68wN4chOzDLUsytrJ11ZtSUN4ZwTaDdgaeDgvGhlDzlqwMOMQX
         Sn71ZFZceXX658vpykxTz3eVDcuF+EmQqRz7ITfxZvvbLjbtZraM+1j3qNLie9pzUNmd
         oOcw==
X-Gm-Message-State: AOAM533LPrvEvDVMRIFD+EFNG5iQ6jQpAUIdga0mssDaCz9ga6q5xJFf
        dTmGsI9VA9u/oG/CT69/srMOxg==
X-Google-Smtp-Source: ABdhPJwo8sNbSknxNcF/K4Eabomcg0KEy77eQH9gY3NN8Kwnu6Ez/IY4NTcSNB/TdaiINWMGzLxiTg==
X-Received: by 2002:a17:902:7401:b029:e4:5992:e64a with SMTP id g1-20020a1709027401b02900e45992e64amr14128720pll.75.1617391591301;
        Fri, 02 Apr 2021 12:26:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:581c:e04f:7c08:c602])
        by smtp.gmail.com with UTF8SMTPSA id h6sm9015932pfh.13.2021.04.02.12.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 12:26:30 -0700 (PDT)
Date:   Fri, 2 Apr 2021 12:26:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V2 4/5] arm64: dts: qcom: pmr735a: Add PMIC peripherals
 for pmr735a
Message-ID: <YGdv5pKMr7jD32Le@google.com>
References: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
 <1617268396-1837-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617268396-1837-5-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same comments as '[1/5] arm64: dts: qcom: pm7325: Add PMIC peripherals
for pm7325', plus another nit:

'[3/5] arm64: dts: qcom: pmk8350: Add PMIC peripherals for pmk8350' has
an ADC config for the die temperature of the pmr735a, hence it seems this
patch should be before the 'pmk8350' one in this series.

On Thu, Apr 01, 2021 at 02:43:15PM +0530, satya priya wrote:
> Add temp-alarm and GPIO support for pmr735a.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pmr735a.dtsi | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmr735a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmr735a.dtsi b/arch/arm64/boot/dts/qcom/pmr735a.dtsi
> new file mode 100644
> index 0000000..07077fb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmr735a.dtsi
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2021, The Linux Foundation. All rights reserved.
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmr735a: pmic@4 {
> +		compatible = "qcom,pmr735a", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmr735a_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmr735a_gpios: gpios@8800 {
> +			compatible = "qcom,pmr735a-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmr735a_gpios 0 0 4>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> +
> +&thermal_zones {
> +	pmr735a_thermal: pmr735a-thermal {
> +		polling-delay-passive = <100>;
> +		polling-delay = <0>;
> +		thermal-sensors = <&pmr735a_temp_alarm>;
> +
> +		trips {
> +			pmr735a_trip0: trip0 {
> +				temperature = <95000>;
> +				hysteresis = <0>;
> +				type = "passive";
> +			};
> +
> +			pmr735a_trip1: trip1 {
> +				temperature = <115000>;
> +				hysteresis = <0>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
