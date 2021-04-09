Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A698D35962E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhDIHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhDIHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:17:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A2C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 00:17:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c18so3932236iln.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQnIRoHA4x1UAhY7RX5AeqrqGDyDCqLIFSUEhL1QK7s=;
        b=NDXgKlLvAaZbc2qgy4Q0R5uga266mP1/WWd6hXjrCDfa3vyAxGVho3/+i3MuR45Kl+
         eyLLJYmVei5meNFxRsbt4wB4mFC512Lw1pJQg7zCqwzePeXrP+07O0tpYz/M8jNVQ6SU
         BWJwbInvZcE0MZENZOpg1Xtt5H2jCmzhDALzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQnIRoHA4x1UAhY7RX5AeqrqGDyDCqLIFSUEhL1QK7s=;
        b=uf6LlDFPugrZUunMbEQEjrCAexBsbDBem/p5G17nA3z6sxD6N4XlZvKGkX/ygLq0Vg
         RhM8X5HsME+K079ooANpMIoRxUYF8VBRMeXSZikGjZqrg28WiNAmBAq1VT1Gogdu5yRx
         mcRMkxsfVgVeSwoKgj2W0FpcNOtV4PledlV4rin5yNIhafs9VHKgZu1JHNGUgEBIIF6s
         5vQuOKsxOiBD3NvP2z8Mz8ZdR27Z65GjELFPjP90ZxhjLAeQb0l5brKbuiS9HmgzOIrK
         NLFfIm8m+LsSy0TmigY3fkZ2vke/cUd9hzYXoIl7dWQVDN/trJTGaHfeT+zhDCLxhnOC
         R+mA==
X-Gm-Message-State: AOAM531qmli4MJW3DVLRMsIOClvHKbaSekmq/ja/W+mzM9jhtlVv6+TW
        kpGDtks0tYyo0hNGbYfZ2J7267miFdQcftpocm68kA==
X-Google-Smtp-Source: ABdhPJy9q6Hme9f6iqNO9ugJeOby6qDIOrflfECR7vElVqX4gwbpzavhILzhkX02xc2aDf1+38x6gz2hk27uUelkelQ=
X-Received: by 2002:a05:6e02:2197:: with SMTP id j23mr10336676ila.308.1617952630774;
 Fri, 09 Apr 2021 00:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210409071158.2346-1-michael.kao@mediatek.com>
In-Reply-To: <20210409071158.2346-1-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 9 Apr 2021 15:16:44 +0800
Message-ID: <CAJMQK-gXfR2Ca-Ay5fwcRgQ4F6h4xXVt1bbAL+3LFwgotwYREA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: mt8183-kukui: Enable thermal Tboard
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

On Fri, Apr 9, 2021 at 3:12 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> Add Tboard thermal sensor settings.
>
> pull-up voltage: 1800 mv
> pull-up resistor: 75K
>
> Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )
> AuxIn = Vsense * 4096 / 1500
>
> TEST=boot kukui
>      check /sys/class/thermal/thermal_zone*/type
>      check /sys/class/thermal/thermal_zone*/temp
the TEST lines can be removed.

>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

This removes following error:
[   10.882325] generic-adc-thermal thermal-sensor1: Thermal zone
sensor register failed: -19
[   10.911912] generic-adc-thermal thermal-sensor2: Thermal zone
sensor register failed: -19

>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index bf2ad1294dd3..202acb542b12 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -801,6 +801,20 @@
>         status = "okay";
>  };
>
> +&thermal_zones {
> +       Tboard1 {
> +               polling-delay = <1000>; /* milliseconds */
> +               polling-delay-passive = <0>; /* milliseconds */
> +               thermal-sensors = <&tboard_thermistor1>;
> +       };
> +
> +       Tboard2 {
> +               polling-delay = <1000>; /* milliseconds */
> +               polling-delay-passive = <0>; /* milliseconds */
> +               thermal-sensors = <&tboard_thermistor2>;
> +       };
> +};
> +
>  &u3phy {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 1ad0a1d55d53..f0719dbef249 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -673,7 +673,7 @@
>                         nvmem-cell-names = "calibration-data";
>                 };
>
> -               thermal-zones {
> +               thermal_zones: thermal-zones {
>                         cpu_thermal: cpu_thermal {
>                                 polling-delay-passive = <100>;
>                                 polling-delay = <500>;
> --
> 2.18.0
>
