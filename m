Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518334078E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCROPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCROO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:14:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E341C06174A;
        Thu, 18 Mar 2021 07:14:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so5298089ota.9;
        Thu, 18 Mar 2021 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=whMoHbtKnfcby2pmtzf2mISpuDe1wTbNYLjDL6S2nWU=;
        b=qnl2CydrzMzC1UDRQdu6kUSjpCCCERB4VXU1TsW3mEZaC8xka3ipUQL6J1VTG4Pwqc
         RRujaoAFQU03tQFMkmvqldCSHZXv/qbKdUIr2OIVBAwK5GXkvNAX56DXdXaG4qWxbCZx
         etQd4aIdrdgBXruRaS6HSONWle+4MMBa5nTxYAOLgvAB8JyS6BIkT8agoFkL+EnV8nJA
         TyIWpFJZEfFqSDEj0q1KXWfQtBF/F1YebpfrYzjBovVWr2eMRu+EF8WoGBI1S41XL+up
         +6QhY62tVov/4oYqTf8g6b6C6WB8rRmXpi8NJ+mdJHINT0lGPpHfD5Po6xI82jzCDdY0
         t0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=whMoHbtKnfcby2pmtzf2mISpuDe1wTbNYLjDL6S2nWU=;
        b=idQiiJBRnjmCNzuoDegk14zuvuqtHqDCfbfO2s6QNbby/Qkfni7v1+cagq/cbNZ6Rf
         hIavbqGrJnF92D4f+kUtASAjlUAYEEK9waprDdbTttHU7w7JtH5/GyDm1UcPdVz2T2mX
         WVMpJ1l2oJAc2fY2sb3QZamXTl2m3v4g46ELLoXwhJUCNLna0mhK5cnlbavFLuaAKRFL
         nOsP1iI4VIvU9Bb5zfCV3u6eTmKomXAnzs5mPEt1YL3fZFNFgmHiXPIgugPPMgkOHJb2
         1TVAHjYV8jMMx/z9by5XAheOoIKAjiVTlrtP1vfX3JI5wUIuY6cpwlapUw9wVNOe+6p5
         hoQg==
X-Gm-Message-State: AOAM533ewxTBiJ+Mq4FjbmrfJh7EIhSLo/7QIczeC8xGHeE/fRdg3soy
        DOhp4fRMJGCJ3pc2PsI5HKsoMq3WFjAldkhSrF4=
X-Google-Smtp-Source: ABdhPJxTMcnggbeYkpD5TX+BjZlctL0gnQTf4UVoA3HsEiYZzWmnyeHJbxL7vl20IqOugt08qXLgSl5C2fQYL7yUt/E=
X-Received: by 2002:a9d:226a:: with SMTP id o97mr7736917ota.362.1616076896631;
 Thu, 18 Mar 2021 07:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210312145545.26050-1-matthias.bgg@kernel.org> <20210312145545.26050-7-matthias.bgg@kernel.org>
In-Reply-To: <20210312145545.26050-7-matthias.bgg@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 18 Mar 2021 15:14:44 +0100
Message-ID: <CAFqH_52aDxqdK8=1iiUcGM-+CcyMmQoAKCUmozD7otoBHOvCcA@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: mt8173: Drop compatible for mt6397
To:     matthias.bgg@kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your patch.

Missatge de l'adre=C3=A7a <matthias.bgg@kernel.org> del dia dv., 12 de mar=
=C3=A7
2021 a les 15:57:
>
> From: Matthias Brugger <mbrugger@suse.com>
>
> The regulator framework does not need compatible, it's actually
> superfluous. Drop it from the DT.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>
> Series-to: lee.jones@linaro.org
> Series-to: robh+dt@kernel.org
> Series-to: matthias.bgg@gmail.com
> Series-to: lgirdwood@gmail.com
> Series-to: broonie@kernel.org
> Series-cc: devicetree@vger.kernel.org
> Series-cc: linux-arm-kernel@lists.infradead.org
> Series-cc: linux-mediatek@lists.infradead.org
> Series-cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt8173-elm.dtsi
> index 21452c51a20a8..db06a986f763e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -916,9 +916,7 @@ pio6397: pinctrl {
>                         #gpio-cells =3D <2>;
>                 };
>
> -               regulator: mt6397regulator {
> -                       compatible =3D "mediatek,mt6397-regulator";
> -
> +               mt6397regulator {

The same happens here, it is not checked because the mt6397 is not in
YAML format yet, but once we do this it'll trigger an error as the
node name should be 'regulators'


>                         mt6397_vpca15_reg: buck_vpca15 {
>                                 regulator-compatible =3D "buck_vpca15";
>                                 regulator-name =3D "vpca15";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boo=
t/dts/mediatek/mt8173-evb.dts
> index 6dffada2e66b4..c3f2a85d55fe7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -303,9 +303,7 @@ pmic: mt6397 {
>                 interrupt-controller;
>                 #interrupt-cells =3D <2>;
>
> -               mt6397regulator: mt6397regulator {
> -                       compatible =3D "mediatek,mt6397-regulator";
> -
> +               mt6397regulator {
>                         mt6397_vpca15_reg: buck_vpca15 {
>                                 regulator-compatible =3D "buck_vpca15";
>                                 regulator-name =3D "vpca15";
> --
> 2.30.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
