Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95322325375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBYQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhBYQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:27:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC949C061574;
        Thu, 25 Feb 2021 08:26:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l64so6600732oig.9;
        Thu, 25 Feb 2021 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8+E3tKaHv1Iv53/dVuKP3IEuN3f05dgVCivKk8lejs=;
        b=Ld7CmKY4g+LqZwjMLPC7wKVNJONL7SRRph4vaveM7ySisL+OKqrBMdG68Yzto++BJ0
         wHct57jbHrgqf9LAnsS0Vwssu2eC2Vc/9HQRTt9I9HG8JlOlL8KWahMXGXEyRAhJwL9/
         C3MdGp/YYttr/45wiDIuwtASeYuMkRoklERDQQhf+UAVTUC3jLagWccLuuEX8fHISyh4
         5D1GsUBJzt1Oo0HC5JZN2syR+8Q9Ai2NyYjl9Ir1vrLWeyAqzEmt0V5yZO9LOXmlRU4G
         UsjnARgzDfD5i/EhGp9amqmpg6rgikCuhSDATB+7HpSx4XAYwUi1DqpI66kIbkFRa16I
         NoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8+E3tKaHv1Iv53/dVuKP3IEuN3f05dgVCivKk8lejs=;
        b=GLNtfD8I8v0g9wfpqEdP45IDeDE4IGODdVshdob3njhxkkHYSvYP44YvV7kaUT8vRt
         xT8Yx0/3YEHwEdlnHL7rAooUr9xS2KecnWOn+Yu9ukqJsV1MOZTEir3BFmJiEBLcM2Lw
         cl+12OB89GsAEWSzKrSaPD5uEDkghHAZo2eRGu8lSSYUTkHEfP7q2w1INBgbDRo2kSOa
         pwjMtQc2V6lr/e9f/0RS0vbt1Y4OnBuO4I79KkUrb17TPHiXwHIlw3pkS8ugWZezLiL8
         Y6KOIzNbwbo+stSRO37TFOtLz4IBsHnAh9Zd9aVxSUvLuMfwcuDHqyMzCeeVVnrIiOJR
         AxeQ==
X-Gm-Message-State: AOAM533TVaGCz4q/FukbMrnM9GXLWdqtGgYnVQYC0LDoNi4p103BCdbS
        rpwEWV/qFsKAZcgJWLZ1b6+grl/NETgrH3wYqrM=
X-Google-Smtp-Source: ABdhPJyybdAtq8H+CRG2egH1fCHK6WDlPZP8BO+1ULhZK5N6M93VYf5idc5ZE+VeG4G2rB1ittD60d81irmaVwM5Qi8=
X-Received: by 2002:aca:4454:: with SMTP id r81mr2385686oia.129.1614270408226;
 Thu, 25 Feb 2021 08:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20210201110447.383473-1-hsinyi@chromium.org>
In-Reply-To: <20210201110447.383473-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 25 Feb 2021 17:26:36 +0100
Message-ID: <CAFqH_50_SKgwgtV+8UX+4v=S9mY9tf0HCQaCKgGCQzWuBfQ7ug@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: Add gce client reg for display subcomponents
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 1 de febr.
2021 a les 12:05:
>
> Add mediatek,gce-client-reg for ccorr, aal, gamma, dither.
>
> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

FWIW this removes some errors from the boot log like this:

 platform 14010000.aal: error -2 can't parse gce-client-reg property (0)

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index b3b8afec5ab9a..0ed37dd9d80b4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1058,6 +1058,7 @@ ccorr0: ccorr@1400f000 {
>                         interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>                         clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
>                 };
>
>                 aal0: aal@14010000 {
> @@ -1067,6 +1068,7 @@ aal0: aal@14010000 {
>                         interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>                         clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
>                 };
>
>                 gamma0: gamma@14011000 {
> @@ -1075,6 +1077,7 @@ gamma0: gamma@14011000 {
>                         interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>                         clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
>                 };
>
>                 dither0: dither@14012000 {
> @@ -1083,6 +1086,7 @@ dither0: dither@14012000 {
>                         interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>                         clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
>                 };
>
>                 dsi0: dsi@14014000 {
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
