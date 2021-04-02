Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C81352F62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhDBSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhDBSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:45:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6371C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:45:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gv19-20020a17090b11d3b029014c516f4eb5so1154730pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lBknpnUfvW7Mp8L8MjbRdTTbJ2YiP+RrDtDZ87i1HWc=;
        b=a1l1lme4++l+zuVvbvuPg11j5VRcaKdhH+EdpHF4zqEVznOydK8W+SNJwIXmze+azb
         HQzCWQ38y+RONCzZiM5t2cA9IZD6bGbCwLv6Snpgm1DkOINWhdsYHZUkDkIdzqjMrXk7
         hCQgYTWI++hjt7Xc2CkMjSYTR1DI7wt8SLw6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lBknpnUfvW7Mp8L8MjbRdTTbJ2YiP+RrDtDZ87i1HWc=;
        b=b5/cxvZwUlSmjQZ/maykDj8qo7zNs912U8sLQBWNWxHt3PWBQBdBo/31e3MBXBisp6
         R1/YMR94ufoRb8tqhMiQIsIMu7ow3PAAnoV1HFhQClXgO832x2vdB3/zFY5efdJSgpe8
         yoDK6lZoq0Jyg5uz6no8oRXF2CfOvMPlThIlMEwlKKXXfu55WGajkiodwqmPDq8bmjdr
         tUXL42zbQf/CmTuINBZf0AbyW0GUyQQr9bKWh6/DOX59PLUkukheRojBf5hipaL0LVSg
         U0POnfUCUhTfYqLL402zByAtwbJRPCLxsSFQb+DfSPE14vBP+ks2RXRMBFP9pI+La8v+
         1B5Q==
X-Gm-Message-State: AOAM532VkDCgHSawsTX8WnBm9PlPzumfjSzUgOSskKXcTWb6A0O+hI7z
        +oE+lCNtyDp5DyR72Cqu44oKXQ==
X-Google-Smtp-Source: ABdhPJyqvR/GeA0hGMMS3fUELGKBLUJ3jxozyY1rdnFq7+JShRmPb9RGh1zy5AHLN03Qvq9gS6OOXQ==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr3055188pjb.171.1617389133265;
        Fri, 02 Apr 2021 11:45:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:581c:e04f:7c08:c602])
        by smtp.gmail.com with UTF8SMTPSA id l10sm8194972pfc.125.2021.04.02.11.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:45:32 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:45:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V2 3/5] arm64: dts: qcom: pmk8350: Add PMIC peripherals
 for pmk8350
Message-ID: <YGdmS8Ih5TGGMbdE@google.com>
References: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
 <1617268396-1837-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617268396-1837-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:43:14PM +0530, satya priya wrote:
> subject: arm64: dts: qcom: pmk8350: Add PMIC peripherals for pmk8350

same nit as for 1/5: maybe just 'arm64: dts: qcom: Add pml7350 support/.dtsi'
or similar since this adds the initial .dtsi for the pmk8350?

> Add PON, GPIO, RTC and other PMIC infra modules support for pmk8350.

nit: also mention that it adds the pmk8350 .dtsi in the first place.

> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi | 100 ++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> new file mode 100644
> index 0000000..13631f2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2021, The Linux Foundation. All rights reserved.
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmr735b.h>
> +
> +&spmi_bus {
> +	pmk8350: pmic@0 {
> +		compatible = "qcom,pmk8350", "qcom,spmi-pmic";

Please provide a link to the binding if it has been sent.

> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmk8350_pon: pon@1300 {
> +			compatible = "qcom,pm8998-pon";
> +			reg = <0x1300>;
> +
> +			pwrkey {
> +				compatible = "qcom,pmk8350-pwrkey";
> +				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +			resin {
> +				compatible = "qcom,pmk8350-resin";
> +				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_VOLUMEDOWN>;
> +			};

Is the usage of this keys really universal across different boards?

At least for the volume down key for most PMICs the config is in the
board file, which seems to make more sense.

> +		};
> +
> +		pmk8350_vadc: adc@3100 {
> +			compatible = "qcom,spmi-adc7";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "eoc-int-en-set";
> +			#io-channel-cells = <1>;
> +			io-channel-ranges;
> +
> +			pmk8350_die_temp {
> +				reg = <PMK8350_ADC7_DIE_TEMP>;
> +				label = "pmk8350_die_temp";
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pm8350_die_temp {
> +				reg = <PM8350_ADC7_DIE_TEMP>;
> +				label = "pm8350_die_temp";
> +				qcom,pre-scaling = <1 1>;
> +			};

nit: I think this should be 'alphabetical' order, so 'pm8350_die_temp' should
be before 'pmk8350_die_temp'.

> +
> +			pmr735a_die_temp {
> +				reg = <PMR735A_ADC7_DIE_TEMP>;
> +				label = "pmr735a_die_temp";
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pmr735b_die_temp {
> +				reg = <PMR735B_ADC7_DIE_TEMP>;
> +				label = "pmr735b_die_temp";
> +				qcom,pre-scaling = <1 1>;
> +			};

Is it guaranteed that a board with the pmk8350 will always have the
other 3 PMICs?

> +		};
> +
> +		pmk8350_adc_tm: adc-tm@3400 {
> +			compatible = "qcom,adc-tm7";
> +			reg = <0x3400>;
> +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "threshold";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#thermal-sensor-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		pmk8350_gpios: gpios@b000 {
> +			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
> +			reg = <0xb000>;
> +			gpio-controller;
> +			gpio-ranges = <&pmk8350_gpios 0 0 4>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pmk8350_rtc: rtc@6100 {

nit: nodes should be ordered by address, hence 'rtc@6100' should be before
'gpios@b000'.

> +			compatible = "qcom,pmk8350-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +	};
> +};
