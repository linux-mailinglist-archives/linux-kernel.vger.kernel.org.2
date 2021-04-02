Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E5E352E82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDBRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhDBRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:35:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E49C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:35:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso2872287pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yphnmbBHawP07rs28D4TVASXy1iDN0SAHVg/RCbgGw=;
        b=fTSE0tGIVBQli5xgECb1c3YtQnQdzIATmTyASBCHwY0w1iUgAP1ZdVVk9VNC/Ipqud
         KHG2toAPV40tAqSylh6q5r4w9BeTpgpUSlPYqMue19B8pIQ9jMAszXCMo4dpAeFRtyEf
         awtOE63SQOs84KurOR87NM/Oi0I2RYYQv6MvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yphnmbBHawP07rs28D4TVASXy1iDN0SAHVg/RCbgGw=;
        b=pjWwKGK7RrBedYdMMCVm9IE00B85TXkBzr6oHlYBpQWAwoYQh2i8s7WZGIhBg7Wxdh
         YfB/0xZ6PGtoLYRW0d4TrIf3C+rAtRwMgOZlbO0gD7SHVwQ7pm8dpek3loGaCFcsmFco
         fwlwTtcxheZtHoasVkJsCS69qmFjw1Pue9L9Tu6oUy6KgVsqRJMQ7MUnEDnHdQoao68W
         DUhwQfGTNQcJgwXQPW7bCZS99zsVGpePHAbLmeHgiJ1XZ7B2Nf11HtAD8UgGV1zOtsAP
         08a92FPWJMM3raXBYl8PyLDsF2LSAeedV77+kvaO5bFgx3D59PB1yCBuDuugh5yJcf3G
         D42w==
X-Gm-Message-State: AOAM532d8Ojl/TZxh1mZT3HeXwb6g4W5AbjvIJy7IDhkSytWJlbeQ//0
        XGwFuU//hGwE7rVz5En2ZCPeuQ==
X-Google-Smtp-Source: ABdhPJwpJcfoesHMdZYbEaX7By1bca37GeS8xAKreb0w71K97U0cTJN+EJblwv84hCl+dUWtukw9tA==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr14756118pjb.154.1617384955602;
        Fri, 02 Apr 2021 10:35:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:581c:e04f:7c08:c602])
        by smtp.gmail.com with UTF8SMTPSA id a18sm9430381pfa.18.2021.04.02.10.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:35:55 -0700 (PDT)
Date:   Fri, 2 Apr 2021 10:35:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V2 1/5] arm64: dts: qcom: pm7325: Add PMIC peripherals
 for pm7325
Message-ID: <YGdV+un4bGcF6jJH@google.com>
References: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
 <1617268396-1837-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617268396-1837-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:43:12PM +0530, satya priya wrote:

> subject: arm64: dts: qcom: pm7325: Add PMIC peripherals for pm7325

nit: maybe just 'arm64: dts: qcom: Add pm7325 support/.dtsi' or similar?

> Add temp-alarm and GPIO support for pm7325.

nit: it's more than that, you are adding the .dtsi for the PMIC itself.

> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pm7325.dtsi | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> new file mode 100644
> index 0000000..1e0848a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2021, The Linux Foundation. All rights reserved.
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pm7325: pmic@1 {
> +		compatible = "qcom,pm7325", "qcom,spmi-pmic";

I saw the patches that add the compatible strings for the GPIOs, but
can't find those that add the strings for the PMICs themselves. Could
you provide a link if they have been sent already?

> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm7325_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm7325_gpios: gpios@8800 {
> +			compatible = "qcom,pm7325-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pm7325_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> +
> +&thermal_zones {
> +	pm7325_thermal: pm7325-thermal {
> +		polling-delay-passive = <100>;
> +		polling-delay = <0>;
> +		thermal-sensors = <&pm7325_temp_alarm>;
> +
> +		trips {
> +			pm7325_trip0: trip0 {
> +				temperature = <95000>;
> +				hysteresis = <0>;
> +				type = "passive";
> +			};
> +
> +			pm7325_trip1: trip1 {

nit: the critical trip point is often named <name>-crit. One reason for
this could be that it allows to add other non-critical trip points (in
the .dtsi itself or the <board>.dts), without messing up the
enumeration scheme.

> +				temperature = <115000>;
> +				hysteresis = <0>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +};
