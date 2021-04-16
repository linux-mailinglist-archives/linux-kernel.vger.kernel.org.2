Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1348736223F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhDPO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbhDPO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:29:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:29:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h7so20902801qtx.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8l9FyBuH/BTGEYuzxVaf9TucQyLLNilcn+KXBfwnWIU=;
        b=M1hHNRamb82YIk/lbOBEDTCvbPD0rXi+/QC3Xk47O8ev5I5uqGpsn0K/Xsb2fYPEOK
         YJqEo4l7GF90H8PqLByqgrCHdqH4xeW3B+V3RZ1R1ugX98E30j6tn+JygtMUHOcxcR1f
         lD2yjfW/6QenhiFH0bwh7nZX2rqb7idpqDnAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8l9FyBuH/BTGEYuzxVaf9TucQyLLNilcn+KXBfwnWIU=;
        b=DmNjcPPCGU/H9qHPDGLCOMyE4YJDzJGQYNQPxHGzX4fpaXm8AyMxPgIyIbydrVMC/x
         L7yCRtUY7neIr7eVZXyOXAtE1N5n421fo0aExxMLrexpUxTN8QLziOFpAfkw9Zd+M6v/
         rM/SFmkgVLBvhsncSWUd9+OQ3WqDMWSmJ+dT0n9FfMPQCvkmLImm9MVysRhyBZy12qDf
         pm4kBsTgBD5DvTseJjeQvnGXW3vK930yq05As/WWWuvr405ZbaxFow5gDY+tDv55l55b
         8PJAheVlNMw1WcQRySDO0TO7vFHZysheNmBsRsZz/le/xP/lXvQKzDjciqxdV6HvFbaK
         GR0A==
X-Gm-Message-State: AOAM531qxrQrGIG/NkK6vxIMpvvmilKOsns4v78oEkc4qwMPL/6voVwG
        u0vXI2UotEheQz4i9lzqqw5ToDXAuGjYrQ==
X-Google-Smtp-Source: ABdhPJx/kXfizRc/q5kwtdIPpVP2+FI6Cg1eerE+bNvxpuBJPIpofgtQAGmIo8P5hbfesUWYFZngMw==
X-Received: by 2002:a05:622a:14c6:: with SMTP id u6mr7942269qtx.125.1618583368419;
        Fri, 16 Apr 2021 07:29:28 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u184sm2960919qkd.82.2021.04.16.07.29.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:29:27 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 65so30328135ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:29:27 -0700 (PDT)
X-Received: by 2002:a25:d34b:: with SMTP id e72mr12054749ybf.343.1618583366837;
 Fri, 16 Apr 2021 07:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210414111007.v1.1.I1a438604a79025307f177347d45815987b105cb5@changeid>
In-Reply-To: <20210414111007.v1.1.I1a438604a79025307f177347d45815987b105cb5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Apr 2021 07:29:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XURtypK1G-Q+4FKtii=JnTVTRKQ=Ehr1rggVqxbXDH0w@mail.gmail.com>
Message-ID: <CAD=FV=XURtypK1G-Q+4FKtii=JnTVTRKQ=Ehr1rggVqxbXDH0w@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7180: coachz: Add thermal config
 for skin temperature
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 11:10 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add ADC and thermal monitor configuration for skin temperature,
> plus a thermal zone that monitors the skin temperature and uses
> the big cores as cooling devices.
>
> CoachZ rev1 is stuffed with an incompatible thermistor for the
> skin temperature, disable the thermal zone for rev1 to avoid
> the use of bogus temperature values.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  9 +++
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  | 63 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> index 86619f6c1134..80bdc4d5b523 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> @@ -14,6 +14,15 @@ / {
>         compatible = "google,coachz-rev1", "qcom,sc7180";
>  };
>
> +/*
> + * CoachZ rev1 is stuffed with a 47k NTC as thermistor for skin temperature,
> + * which currently is not supported by the PM6150 ADC driver. Disable the
> + * skin temperature thermal zone to avoid using bogus temperature values.
> + */
> +&skin_temp_thermal {
> +       status = "disabled";
> +};
> +
>  &tlmm {
>         gpio-line-names = "HUB_RST_L",
>                           "AP_RAM_ID0",
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index e2ffe71c2d52..cabe5d6b981b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -25,6 +25,50 @@ adau7002: audio-codec-1 {
>                 IOVDD-supply = <&pp1800_l15a>;
>                 #sound-dai-cells = <0>;
>         };
> +
> +       thermal-zones {
> +               skin_temp_thermal: skin-temp-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <0>;
> +
> +                       thermal-sensors = <&pm6150_adc_tm 1>;
> +                       sustainable-power = <814>;
> +
> +                       trips {
> +                               skin_temp_alert0: trip-point0 {
> +                                       temperature = <42000>;
> +                                       hysteresis = <1000>;
> +                                       type = "passive";
> +                               };
> +
> +                               skin_temp_alert1: trip-point1 {
> +                                       temperature = <45000>;
> +                                       hysteresis = <1000>;
> +                                       type = "passive";
> +                               };
> +
> +                               skin-temp-crit {

If it were me I would have added a label to the "crit" too to match
the alert0 and alert1. It's not needed right now, though, so it's not
worth spinning the patch for.

> +                                       temperature = <60000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&skin_temp_alert0>;
> +                                       cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +
> +                               map1 {
> +                                       trip = <&skin_temp_alert1>;
> +                                       cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +       };
>  };
>
>  &ap_spi_fp {
> @@ -77,6 +121,25 @@ &panel {
>         compatible = "boe,nv110wtm-n61";
>  };
>
> +&pm6150_adc {
> +       skin-temp-thermistor@4e {

A part of me wonders if we should just be using the generic name
"thermistor@4e" which seems more common in dts.  ...but what you have
matches what we've already done in pompom so I think it's fine.

FWIW: I'm not an expert on any of the thermistor stuff but it looks
sane and matches how pompom is working with this thermistor...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
