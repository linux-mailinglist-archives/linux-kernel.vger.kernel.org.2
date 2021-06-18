Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482723AC890
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhFRKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhFRKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:15:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E05C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:12:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k10-20020a056830168ab029044d922f6a45so805376otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziEgOzcP1HByIwM5tzkw38PrntEO3ToJbYWi+oRdGcs=;
        b=PdJl0ncgrhfekyPHp+KqwLByDJx2Zx1fUgbF2xiq4jALmjPa09pYQTcwt9o5SZ3FDq
         +mmWaE4r4lH84yr6Q/F09ayO2bq98b2RuKnwAaqZzUXy1D5F6sNGkfD1cdXOPGC+eBXT
         3QnVHBsPfKkchYlmwi850FIBz+aseO7hgkfjWNoCil1YxCXyhg1OzuIstRmIUAoLA1gE
         T41vAbLC7LANLbus+TouLLqdAVDBCRPb5Yoihh14+97GnWw+k8u/txz2z7884qrYQeue
         NiQEl77YaIM5a9ZxsLj3JTYo+Y8GqNm4LfOvYqwVnXVzPbUQCSeROhWaZo8FGGC8D4Vt
         9v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziEgOzcP1HByIwM5tzkw38PrntEO3ToJbYWi+oRdGcs=;
        b=ao8TyCmnOx8JYXzjBqvCpSo0/Ptiq2J94nXZcraAcy2+ZscWt0hsNOpaiMNCVpH5aN
         YCZ0zh6W79pklG+Vq9EamNV2iHIQSh6OxEbIANWAu1Q+fWdScGEK5q0c21rpqpJRijcZ
         Aldef/X965XP9nW01FcpBBgnov/RPr40ysM1hQH4ov8usWTIpeUDhum+/9cs5/+p244L
         sq9WKg7MQwAIkDGrNDmn/0X5wQTAgK4VsP5wO/1AVijDmj9Op3N8+6U6DmFr7CXpGH7l
         QDb4NHR14gr4uXT38EQ553meagl+3/J7MDMgXB5QKhOyaHvqftFuJYNrdxRiXyCLu8zD
         YVrQ==
X-Gm-Message-State: AOAM533v3jZGEDaw7D0cc+3FrGDZByl28ijqGtFOJmHBdCp18Dy/8Xlb
        lt7EYqme2Nl8oTk+v+M8vXUCgLWv8LyUrHahPw58eg==
X-Google-Smtp-Source: ABdhPJzA9Ime81OAPZIz8ZFv0L/PCg9uztC6yCsFB33iXVicxGaKxCR3bjdzuMVRn5C3JruCfUO7TrEKZB+nh/CFwRo=
X-Received: by 2002:a9d:74d4:: with SMTP id a20mr8644554otl.28.1624011170558;
 Fri, 18 Jun 2021 03:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210617054548.353293-1-bhupesh.sharma@linaro.org>
 <20210617054548.353293-5-bhupesh.sharma@linaro.org> <6011130d-8ce8-420b-6e55-5d168fef0347@somainline.org>
In-Reply-To: <6011130d-8ce8-420b-6e55-5d168fef0347@somainline.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 18 Jun 2021 15:42:39 +0530
Message-ID: <CAH=2Ntw5uZOLmc8b3oB5CizYQQ_Oxie3Hk_Z68WwHb=u2Xx05w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: pmm8155au_2: Add base dts file
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review.

On Fri, 18 Jun 2021 at 04:02, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> > Add base DTS file for pmm8155au_2 along with GPIOs, power-on, rtc and vadc
> > nodes.
> >
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi | 107 ++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> > new file mode 100644
> > index 000000000000..0c7d7a66c0b5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> > +
> > +/ {
> > +     thermal-zones {
> > +             pmm8155au-2-thermal {
> > +                     polling-delay-passive = <100>;
> > +                     polling-delay = <0>;
> > +
> > +                     thermal-sensors = <&pmm8155au_2_temp>;
> > +
> > +                     trips {
> > +                             trip0 {
> > +                                     temperature = <95000>;
> > +                                     hysteresis = <0>;
> > +                                     type = "passive";
> > +                             };
> > +
> > +                             trip1 {
> > +                                     temperature = <115000>;
> > +                                     hysteresis = <0>;
> > +                                     type = "hot";
> > +                             };
> > +
> > +                             trip2 {
> > +                                     temperature = <145000>;
> > +                                     hysteresis = <0>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&spmi_bus {
> > +     pmic@4 {
> > +             compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
> > +             reg = <0x4 SPMI_USID>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             power-on@800 {
> > +                     compatible = "qcom,pm8916-pon";
> > +                     reg = <0x0800>;
>
> No common debounce, interrupts, bias- property or pwrkey key code?
>
> Besides, (as a question to Bjorn and others) do we pad reg to 4 digits in PMIC DTs now?

Maybe Bjorn can pitch in with his thoughts here.

> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             pmm8155au_2_temp: temp-alarm@2400 {
> > +                     compatible = "qcom,spmi-temp-alarm";
> > +                     reg = <0x2400>;
> > +                     interrupts = <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> > +                     io-channels = <&pmm8155au_2_adc ADC5_DIE_TEMP>;
> > +                     io-channel-names = "thermal";
> > +                     #thermal-sensor-cells = <0>;
> > +             };
> > +
> > +             pmm8155au_2_adc: adc@3100 {
> > +                     compatible = "qcom,spmi-adc5";
> > +                     reg = <0x3100>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     #io-channel-cells = <1>;
> > +                     interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> > +
> > +                     ref-gnd@0 {
> > +                             reg = <ADC5_REF_GND>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                             label = "ref_gnd";
> > +                     };
> > +
> > +                     vref-1p25@1 {
> > +                             reg = <ADC5_1P25VREF>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                             label = "vref_1p25";
> > +                     };
> > +
> > +                     die-temp@6 {
> > +                             reg = <ADC5_DIE_TEMP>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                             label = "die_temp";
> > +                     };
> > +             };
> > +
> > +             pmm8155au_2_gpios: gpio@c000 {
> > +                     compatible = "qcom,pmm8155au-gpio";
> > +                     reg = <0xc000>;
> > +                     gpio-controller;
> > +                     #gpio-cells = <2>;
> > +                     interrupt-controller;
> > +                     #interrupt-cells = <2>;
> > +             };
>
> Don't we do gpio-ranges anymore?

Maybe Bjorn can pitch in with his thoughts here as he may have more
historical context, but I personally think that since the mapping
between the  pin controller local number space and the pins in the
GPIO controller local number space is 1:1 (same) here, adding
gpio-ranges property here is optional (as it provides little
additional information).

But I might have missed something here, so I will wait for more
thoughts from Bjorn.

Thanks,
Bhupesh

>
>
> > +     };
> > +
> > +     pmic@5 {
> > +             compatible = "qcom,pmm8155au", "qcom,spmi-pmic";
> > +             reg = <0x5 SPMI_USID>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +     };
> > +};
>
>
> Konrad
>
