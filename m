Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FA343F83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCVLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCVLUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:20:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C21C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:20:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k25so1350063iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLLgEIAtDhMTSlLjCARkd+VJiQyrR8iYWRkfviadf/g=;
        b=AbqpB8QwU4/7RB4f8fZepWBAaxQqLiKJjhB3ycqCCzkyq9EnbPksnDKUcrS6HfOF2C
         IrhRp1J48jiVA6DGtRTHD3UNITrkQ32d92aguVjWKzmHBVD8fffe9ndzSKT45hC3Vt+F
         DAupby+KLDTRgaOw8EnYRNkH6sWQALyACQANw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLLgEIAtDhMTSlLjCARkd+VJiQyrR8iYWRkfviadf/g=;
        b=bSCx/dln1i14swa8MSZIrfCP42xsBSHILStDczfArJH0/i7Lo1i8DZxS6BOz/OekH7
         qhgdkF/MiHjSUVLXqGbaZmxnFLnL48uiLTdBiZzv/z8erGRwC8D1EduFU6HWcuFxMmMB
         mQv7+bwpTHnWxUqfHMqmZtZP9COfjaSPCu6k4XKs8BSDuAImigMulkMgNy41D898wvhV
         V28YTeBk64ZN8in8pIAU58zcA8hg781DRtli1Vj6SF0HZgjKLRPGy5MeBG4v8jjC00WW
         soKGBzGe96rnBCchFY1pKb5mpYAKyvK5Xe5SAM7qqq0If3AQh4a5y29s5dPZvRKSQbx5
         d/Ig==
X-Gm-Message-State: AOAM531ObmDd2XQ5egthKhC3bYjtjVvGF46QCtxTbErnfzZp79BcWzDe
        23ZUnlHXyudiNPffvnXyQPgE4O/tkDC3qCgVbxrt1A==
X-Google-Smtp-Source: ABdhPJzUJ+JxnlyP/XApOqLy+Gt3yTqy+AekHvnYCXijerfjWVc0LzSdZZqcyLxOpFBc8xCRTu8kBAhdLf1Mjb4Hi0c=
X-Received: by 2002:a02:ccd9:: with SMTP id k25mr10591705jaq.43.1616412031652;
 Mon, 22 Mar 2021 04:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210316070144.28440-1-michael.kao@mediatek.com> <20210316070144.28440-2-michael.kao@mediatek.com>
In-Reply-To: <20210316070144.28440-2-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 22 Mar 2021 19:20:05 +0800
Message-ID: <CAJMQK-gQxMmq-4+Hb2vuTmz9T7XOZPV3=uwTp-8doHRVD4y_Jg@mail.gmail.com>
Subject: Re: [v7,1/3] arm64: dts: mt8183: add thermal zone node
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 3:02 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> From: "michael.kao" <michael.kao@mediatek.com>
>
> Add thermal zone node to Mediatek MT8183 dts file.
>
> Evaluate the thermal zone every 500ms while not cooling
> and every 100ms when passive cooling is performed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested this patch on mt8183 devices.

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..d3550af06408 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -657,6 +657,87 @@
>                         status = "disabled";
>                 };
>
> +               thermal: thermal@1100b000 {
> +                       #thermal-sensor-cells = <1>;
> +                       compatible = "mediatek,mt8183-thermal";
> +                       reg = <0 0x1100b000 0 0x1000>;
> +                       clocks = <&infracfg CLK_INFRA_THERM>,
> +                                <&infracfg CLK_INFRA_AUXADC>;
> +                       clock-names = "therm", "auxadc";
> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +                       mediatek,auxadc = <&auxadc>;
> +                       mediatek,apmixedsys = <&apmixedsys>;
> +                       nvmem-cells = <&thermal_calibration>;
> +                       nvmem-cell-names = "calibration-data";
> +               };
> +
> +               thermal-zones {
> +                       cpu_thermal: cpu_thermal {
> +                               polling-delay-passive = <100>;
> +                               polling-delay = <500>;
> +                               thermal-sensors = <&thermal 0>;
> +                               sustainable-power = <5000>;
> +                       };
> +
> +                       /* The tzts1 ~ tzts6 don't need to polling */
> +                       /* The tzts1 ~ tzts6 don't need to thermal throttle */
> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 1>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts2: tzts2 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 2>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts3: tzts3 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 3>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts4: tzts4 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 4>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts5: tzts5 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 5>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tztsABB: tztsABB {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 6>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +               };
> +
>                 pwm0: pwm@1100e000 {
>                         compatible = "mediatek,mt8183-disp-pwm";
>                         reg = <0 0x1100e000 0 0x1000>;
> @@ -926,6 +1007,10 @@
>                         reg = <0 0x11f10000 0 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> +                       thermal_calibration: calib@180 {
> +                               reg = <0x180 0xc>;
> +                       };
> +
>                         mipi_tx_calibration: calib@190 {
>                                 reg = <0x190 0xc>;
>                         };
> --
> 2.18.0
>
