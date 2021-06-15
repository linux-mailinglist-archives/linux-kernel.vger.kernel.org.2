Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB73A8AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhFOVKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFOVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:10:42 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D15C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:08:37 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id y18-20020a4ae7120000b02902496b7708cfso123720oou.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5H/WIGAt2bcGus6syHjeDpEBJBSWGYGK2ZP5DaJq8HI=;
        b=Wh0xf1ppQyc5kPm+/1GaRANZM62IHN3p08884tek1zX2shuDsH5dVu1BGEv00Se1Qp
         vxhbERR6ISRbJFFhkNWgfPND/o3svNBm6LCfX7ik+V6iwSgMmUslOsNPMg1pLiuKM7+v
         VcHManoDf9yvNpprfKQL8MFyRJP+Nuis1popY+w8HvSh22IgpWcXttSzGuc9u8TZI14E
         kCOusr5iijIFqnCakDFKTuS0fZVRJWu5zSeL0k+RAMgBpRJ971XMXUbAyTJZuLehxudb
         KYQYmqUohJOzOeFAZdISMjb6w4vvnQdlwogq4L/tUo4qpJ4I7sK2HHDb6nVjVCwVWUeI
         R5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5H/WIGAt2bcGus6syHjeDpEBJBSWGYGK2ZP5DaJq8HI=;
        b=K7gf8f/0dxCOXJiuNaapqGlsSgefueqY1dfnKBDlpvfOrz3nu9WR3O+icrHuGJUwM5
         okfYHEWY+u2+Rn1MVVJk8HTL5BagOoRU2vUffAYToMswmrZLI6B60PnOtCtE1go7pcxf
         IWM33eU2fZrXueMVNfMdGzobkkz7SdvRrdWKXzGnsqY3QKlABAS3xTc8xPBOaOVFARUN
         6Gm8MrcknE2HWn1kGo/H4Q7KzMk0rtCxCmmQVm0CQM7TSbLyQu1CtbT3oJKUzFO3bMCM
         PwSsaL6a88teTRH3+FT+eZpI3k0tUawHvfRSLNlEAjXBZOSK1CjGcRVFCzqhedbFWtJN
         vl/A==
X-Gm-Message-State: AOAM530n9bFjh1bppoXYo1tiHpzM7nAJ5rF7EnQW5zxbWA1HQECzS99P
        tNE9uGb0avV5DhTsC/Q7I2btag==
X-Google-Smtp-Source: ABdhPJyQEfWiQUz1pY9YR1vEOYIO+jkKuQFJseI31f2XPj0vFUAtGN5ui54x6xW9VEQYrzp8AEk2Sw==
X-Received: by 2002:a4a:49d0:: with SMTP id z199mr909507ooa.67.1623791316982;
        Tue, 15 Jun 2021 14:08:36 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u1sm14300ooo.18.2021.06.15.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:08:36 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:08:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: pmm8155au_1: Add base dts file
Message-ID: <YMkW0mMUk/zTt7jQ@builder.lan>
References: <20210615074543.26700-1-bhupesh.sharma@linaro.org>
 <20210615074543.26700-9-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615074543.26700-9-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Jun 02:45 CDT 2021, Bhupesh Sharma wrote:

> Add base DTS file for pmm8155au_1 along with GPIOs, power-on, rtc and vadc
> nodes.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi | 134 ++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> new file mode 100644
> index 000000000000..b04c28e54470
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +/ {
> +	thermal-zones {
> +		pmm8155au-1-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pmm8155au_1_temp>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +
> +				trip2 {
> +					temperature = <145000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pon: power-on@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x0800>;
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +
> +				status = "disabled";
> +			};
> +		};
> +
> +		pmm8155au_1_temp: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			io-channels = <&pmm8155au_1_adc ADC5_DIE_TEMP>;
> +			io-channel-names = "thermal";
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmm8155au_1_adc: adc@3100 {
> +			compatible = "qcom,spmi-adc5";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +
> +			ref-gnd@0 {
> +				reg = <ADC5_REF_GND>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
> +			};
> +
> +			vref-1p25@1 {
> +				reg = <ADC5_1P25VREF>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
> +			};
> +
> +			die-temp@6 {
> +				reg = <ADC5_DIE_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
> +			};
> +		};
> +
> +		pmm8155au_1_adc_tm: adc-tm@3500 {
> +			compatible = "qcom,spmi-adc-tm5";
> +			reg = <0x3500>;
> +			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pmm8155au_1_rtc: rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> +
> +			status = "disabled";
> +		};
> +
> +		pmm8155au_1_gpios: gpio@c000 {
> +			compatible = "qcom,pmm8155au-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> -- 
> 2.31.1
> 
