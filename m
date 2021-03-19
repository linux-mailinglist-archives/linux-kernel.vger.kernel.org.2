Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9A341B65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCSLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:24:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E2C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:24:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v186so3463062pgv.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4uQV+KvxO31kXHo60N7+Gw7UAt5IF/IxeK6ftcur5jY=;
        b=LOhrFd2hYdoBIm2FIMgrp8Uvjb4MSuVbpyjLKzKSpvg52B+gpSV8KzXVoAEudZLvsS
         k0bvJW7ijuzFmAVqpjXvd0SEjeGH+qrjtiJBEgwreNZF4oHLT06MT7XRZQyMUrmiFgn7
         /5bkMyewrahyJZxYk3xg7Cvm8ZqjXx9KYWTaEj9ozEyoIfqi8tADSAPa0zlD3aMJCh6O
         EY5gYP5oNDZhybV0qZxJ5i/Y1s/7h3tIthVG8Eg7MPi6Lbg1t34C8O1b0zlXhurAisXa
         pxAsCEqfe/AwPCVhvntiFoZQti+uBqf19BZKtU3WZSExW/+oTU3/uibRMVp4PbKYaCN0
         hfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4uQV+KvxO31kXHo60N7+Gw7UAt5IF/IxeK6ftcur5jY=;
        b=caGQ9fVJkd1WHLTaz3UEhf+3/eQkj1+uQgqqYBHyybMNpwgqMRqcrA+kdBOEIVmPic
         PPtiB3LNKaTGW+/GBf5Ej52cOrtDC4qSsLf7flvRhU9jGMzDeWnqrNa6fXZqi6fHFnzV
         gPp9YWdJnJ+4i3Nz/klXLutCnE+1glqR9JIjqstehUFni5qdxg5d9pZITgw7uVRMdKak
         NLcyjQ2OFcw1bbOk+Oq0sNRYsodZNru46N/yWnJJbkyJxGEehiEn3YfkpuqoKQfVImGD
         kvNie5ZIWksx8F6IgRucxqxveCA3q3JD5EJ8jZ6erI+UUUUevTLHivUXjoBpJB9nWTx5
         5OZA==
X-Gm-Message-State: AOAM531ilIRURCM8VogqGBugoXbwQyca/mRv6d+RuGCBGlOSmSdiEhxX
        B/Aw/lhYmtpT3+QKWwf5iB+8DjkcqaLF+54zmZKL0Q==
X-Google-Smtp-Source: ABdhPJwgFbdaY3gBhAdhuG6QEizbLIYS3v0T32ZoYdiyzMzMd//dnEZHpigdjItWgg7oeblQ3x2d9AE2mP+T8nm1Lac=
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr11123732pgk.265.1616153068267;
 Fri, 19 Mar 2021 04:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210319104855.85075-1-robert.foss@linaro.org> <20210319104855.85075-2-robert.foss@linaro.org>
In-Reply-To: <20210319104855.85075-2-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 12:24:16 +0100
Message-ID: <CAG3jFytSoTP1UDWAYR=rAdHLBr9rU49ZF1=F9rfqZptCBuJFTQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sm8350: Add thermal zones and
 throttling support
To:     amitk@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rui.zhang@intel.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 11:49, Robert Foss <robert.foss@linaro.org> wrote:
>
> sm8350 has 29 thermal sensors split across two tsens controllers. Add
> the thermal zones to expose them and wireup the cpus to throttle their
> frequencies on crossing passive temperature thresholds.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 829 +++++++++++++++++++++++++++
>  1 file changed, 829 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 4abdba78cec1..424887652f47 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent = <&intc>;
> @@ -46,6 +47,7 @@ CPU0: cpu@0 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_0>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
> +                       #cooling-cells = <2>;
>                         L2_0: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -62,6 +64,7 @@ CPU1: cpu@100 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_100>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
> +                       #cooling-cells = <2>;
>                         L2_100: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -75,6 +78,7 @@ CPU2: cpu@200 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_200>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
> +                       #cooling-cells = <2>;
>                         L2_200: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -88,6 +92,7 @@ CPU3: cpu@300 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_300>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
> +                       #cooling-cells = <2>;
>                         L2_300: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -101,6 +106,7 @@ CPU4: cpu@400 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_400>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
> +                       #cooling-cells = <2>;
>                         L2_400: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -114,6 +120,7 @@ CPU5: cpu@500 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_500>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
> +                       #cooling-cells = <2>;
>                         L2_500: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -128,6 +135,7 @@ CPU6: cpu@600 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_600>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
> +                       #cooling-cells = <2>;
>                         L2_600: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -141,6 +149,7 @@ CPU7: cpu@700 {
>                         enable-method = "psci";
>                         next-level-cache = <&L2_700>;
>                         qcom,freq-domain = <&cpufreq_hw 2>;
> +                       #cooling-cells = <2>;
>                         L2_700: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -682,6 +691,28 @@ pdc: interrupt-controller@b220000 {
>                         interrupt-controller;
>                 };
>
> +               tsens0: thermal-sensor@c222000 {
> +                       compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
> +                       reg = <0 0x0C263000 0 0x1ff>, /* TM */
> +                             <0 0x0C222000 0 0x8>; /* SROT */
> +                       #qcom,sensors = <15>;
> +                       interrupts = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <&pdc 28 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "uplow", "critical";
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
> +               tsens1: thermal-sensor@c223000 {
> +                       compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
> +                       reg = <0 0x0C265000 0 0x1ff>, /* TM */
> +                             <0 0x0c223000 0 0x8>; /* SROT */
> +                       #qcom,sensors = <14>;
> +                       interrupts = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <&pdc 29 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "uplow", "critical";
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 aoss_qmp: qmp@c300000 {
>                         compatible = "qcom,sm8350-aoss-qmp";
>                         reg = <0 0x0c300000 0 0x100000>;
> @@ -1280,6 +1311,804 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>                 };
>         };
>
> +       thermal-zones {
> +               cpu0-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 1>;
> +
> +                       trips {
> +                               cpu0_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu0_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu0_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu0_alert0>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu0_alert1>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu1-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 2>;
> +
> +                       trips {
> +                               cpu1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu1_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu1_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu1_alert0>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu1_alert1>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu2-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 3>;
> +
> +                       trips {
> +                               cpu2_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu2_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu2_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu2_alert0>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu2_alert1>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu3-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 4>;
> +
> +                       trips {
> +                               cpu3_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu3_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu3_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu3_alert0>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu3_alert1>;
> +                                       cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu4-top-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 7>;
> +
> +                       trips {
> +                               cpu4_top_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu4_top_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu4_top_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu4_top_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu4_top_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu5-top-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 8>;
> +
> +                       trips {
> +                               cpu5_top_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu5_top_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu5_top_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu5_top_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu5_top_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu6-top-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 9>;
> +
> +                       trips {
> +                               cpu6_top_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu6_top_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu6_top_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu6_top_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu6_top_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu7-top-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 10>;
> +
> +                       trips {
> +                               cpu7_top_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu7_top_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu7_top_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu7_top_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu7_top_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu4-bottom-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 11>;
> +
> +                       trips {
> +                               cpu4_bottom_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu4_bottom_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu4_bottom_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu4_bottom_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu4_bottom_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu5-bottom-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 12>;
> +
> +                       trips {
> +                               cpu5_bottom_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu5_bottom_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu5_bottom_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu5_bottom_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu5_bottom_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu6-bottom-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 13>;
> +
> +                       trips {
> +                               cpu6_bottom_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu6_bottom_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu6_bottom_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu6_bottom_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu6_bottom_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu7-bottom-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 14>;
> +
> +                       trips {
> +                               cpu7_bottom_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu7_bottom_alert1: trip-point1 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu7_bottom_crit: cpu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu7_bottom_alert0>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu7_bottom_alert1>;
> +                                       cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               aoss0-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 0>;
> +
> +                       trips {
> +                               aoss0_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               cluster0-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 5>;
> +
> +                       trips {
> +                               cluster0_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                               cluster0_crit: cluster0_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cluster1-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 6>;
> +
> +                       trips {
> +                               cluster1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                               cluster1_crit: cluster1_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               aoss1-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 0>;
> +
> +                       trips {
> +                               aoss1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 1>;
> +
> +                       trips {
> +                               gpu1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <1000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal-bottom {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 2>;
> +
> +                       trips {
> +                               gpu2_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <1000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               // TODO: What is the NSP subsystem?

This comment should not have been included, will remove in v2

> +               nspss1-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 3>;
> +
> +                       trips {
> +                               nspss1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <1000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               // TODO: What is the NSP subsystem?

This comment should not have been included, will remove in v2

> +               nspss2-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 4>;
> +
> +                       trips {
> +                               nspss2_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <1000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               // TODO: What is the NSP subsystem?

This comment should not have been included, will remove in v2

> +               nspss3-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 5>;
> +
> +                       trips {
> +                               nspss3_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <1000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               video-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 6>;
> +
> +                       trips {
> +                               video_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               mem-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 7>;
> +
> +                       trips {
> +                               mem_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               modem1-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 8>;
> +
> +                       trips {
> +                               modem1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               modem2-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 9>;
> +
> +                       trips {
> +                               modem2_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               modem3-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 10>;
> +
> +                       trips {
> +                               modem3_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               modem4-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 11>;
> +
> +                       trips {
> +                               modem4_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               camera-thermal-top {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 12>;
> +
> +                       trips {
> +                               camera1_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +
> +               camera-thermal-bottom {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens1 13>;
> +
> +                       trips {
> +                               camera2_alert0: trip-point0 {
> +                                       temperature = <90000>;
> +                                       hysteresis = <2000>;
> +                                       type = "hot";
> +                               };
> +                       };
> +               };
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> --
> 2.27.0
>
