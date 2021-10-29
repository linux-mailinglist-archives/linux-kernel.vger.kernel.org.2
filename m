Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146B43F3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJ2ALQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhJ2ALO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635466127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ke1RR/yh2Lw9wS2LgxkSgK8p4zl57sqmHmt240T7mE8=;
        b=U4Ap5AYi7GusgbktA31XyOtBNCOK35ZdMtRWH+G+1NM4UrOcT5d9dizCl6QdNaiiTsShem
        718emubJrfrkuJRwPRFGm/m8WY1TcsbJyErQu8ZqhEgMLTe7JRdu7cIuU7JI9BCUy59N3D
        2N7l8JbpZKEdKdEh4yA1Hm4pMLRF7DI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-n010S_1qMTaAWX8z4ZhYSw-1; Thu, 28 Oct 2021 20:08:45 -0400
X-MC-Unique: n010S_1qMTaAWX8z4ZhYSw-1
Received: by mail-qt1-f198.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so5595476qtm.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke1RR/yh2Lw9wS2LgxkSgK8p4zl57sqmHmt240T7mE8=;
        b=H5OZ4gg1oqh9Amp6mvhF3nfU9A8zddiynZOm2iWBFB7ecBBZuXtBpGRyxog2QplySh
         Nc6GSea/9QqmJBv+ios9K8xmmW1XTukLWFZSbA/x/mUg07iN9m4o9zGPMvDLqOuPSA82
         fii1gzQh7+fbh3IMsdA1dxlH2IwA2MpzmBnMOVBgjf7Ernhcr3+wGeemMzBe9s52VBL5
         2YyZgzLVB4djWeRI0w7rkat1Do7vMmS9b4wmj+OubOWtBhb/k3oIiNlRuWiBoq9CJaCW
         Knnp4psN5WPwQ/bBNLB1zyoFlrjg4sO5fK5OhpuTp4CKJNNOXNjnbC/1dDudqr4bMg3P
         fUtA==
X-Gm-Message-State: AOAM531BqjBvIAYud1xxUy/7x2v4uZ4480Fgy6l74283lOkJXTjbiZK1
        2x9T3XfaIHX8RfQz5HDcjs2UBL9ZuHAcm5FlB6VIgysZoRALl5pa4zEkkF2rUJlJ+GpVcQEwVwI
        9aeif/qNm45LLn90vMUaryFxitWE9fW2A5P9FCRps
X-Received: by 2002:a05:6214:2608:: with SMTP id gu8mr3538039qvb.18.1635466124339;
        Thu, 28 Oct 2021 17:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylNxarNV97CLBKGSh04boGFTKqTFzoyBWJzfMvavg7iSpapV71rVFB8MJzAYfXc/7HhcAXXFMvY7OmwJ17Vrg=
X-Received: by 2002:a05:6214:2608:: with SMTP id gu8mr3538003qvb.18.1635466123884;
 Thu, 28 Oct 2021 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211020095926.735938-1-flokli@flokli.de>
In-Reply-To: <20211020095926.735938-1-flokli@flokli.de>
From:   Dennis Gilmore <dgilmore@redhat.com>
Date:   Thu, 28 Oct 2021 19:08:32 -0500
Message-ID: <CAJesf3Opx3KBPgBdQbKYTdBkoWhuuvphKm6BoVoaqrs_JBz13g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Enable HDD power on helios64
To:     Florian Klink <flokli@flokli.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Dennis Gilmore <dgilmore@redhat.com>

On Thu, Oct 28, 2021 at 11:37 AM Florian Klink <flokli@flokli.de> wrote:
>
> This adds the hdd_{a,b}_power blocks present in the armbian helios64
> dts. [1]
>
> Without those powered up, no HDDs will appear (except one connected via
> the m.2 slot).
>
> From https://wiki.kobol.io/helios64/sata/#hdd-power:
>
> > The power delivery of the HDDs is divided into two group:
> >
> >     HDD Rail A (Max. 3x Drives)
> >     HDD Rail B (Max. 2x Drives)
> >
> > Helios64 implements a power staggering approach where HDD Rail A will be
> > powered up first, then few seconds later HDD Rail B will be powered up.
> > This power control scenario is performed to reduce the inrush current
> > during disk spin-up.
>
> In practice, this power staggering approach will be included in the
> bootloader (not in the kernel), as we might want to boot from a SATA
> drive.
>
> From my experiments, if the bootloader doesn't implement the power
> staggering, only one HDD will get recognized (probably cause the others
> didn't boot due to few power).
>
> Still, it makes sense to expose this block in the device-tree, so the
> kernel can ensure both rails are on (and this can be shared with
> u-boot).
>
> [1] https://github.com/armbian/build/blob/744ea89a589d62cb6f409baab60fc6664520bc39/patch/kernel/archive/rockchip64-5.14/add-board-helios64.patch
>
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---
>  .../dts/rockchip/rk3399-kobol-helios64.dts    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> index 738cfd21df3e..93745dcc2af6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> @@ -82,6 +82,30 @@ led-1 {
>                 };
>         };
>
> +       hdd_a_power: hdd-a-power {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-0 = <&hdd_a_power_en>;
> +               pinctrl-names = "default";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-name = "hdd_a_power";
> +               startup-delay-us = <2000000>;
> +       };
> +
> +       hdd_b_power: hdd-b-power {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> +               pinctrl-0 = <&hdd_b_power_en>;
> +               pinctrl-names = "default";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-name = "hdd_b_power";
> +               startup-delay-us = <2000000>;
> +       };
> +
>         pcie_power: pcie-power {
>                 compatible = "regulator-fixed";
>                 enable-active-high;
> @@ -422,6 +446,14 @@ pmic_int_l: pmic-int-l {
>         };
>
>         power {
> +               hdd_a_power_en: hdd-a-power-en {
> +                       rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               hdd_b_power_en: hdd-b-power-en {
> +                       rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
>                 vcc5v0_usb_en: vcc5v0-usb-en {
>                         rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
> --
> 2.33.0
>


-- 
Dennis Gilmore
Multiple Architecture Portfolio Enablement
T: +1-312-660-3523

