Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476F1361989
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhDPFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhDPFxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:53:44 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4344C061574;
        Thu, 15 Apr 2021 22:53:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso2297056otl.0;
        Thu, 15 Apr 2021 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MCLUGMKOGCUhcX5PBKwgjDIDGwxEw0xOP/rCTk9Ji7w=;
        b=dWqwHYu2UDFUk2dsRv+6Opo6tnDsyuOf/z6SFDD6Yu/pYZeMyd5ptvs+teCRwYrFcV
         r0QJo7BFf/SgXng34dmLR210AModhgA2SwTdXfsnsN3e7r3aG1waK6OgJbaoYakNsyhR
         2qWHWnkC+u3an0MrnM4T41G5/nrQUbbseJzCgrtr9Fdt1MMWfvxKqSeXGqY0hqTr8y7S
         KFvRvCUT+vPfg7rS/MIKLvQktakh+cBjSmPkgJ2metykBox4dimG2a1gEpp72kj5xh8b
         nbFCddQeeQoEH+b8JSUojOPj5EqKGqa8m/ZVsFgIhcHmqL9zvKH4Vflh1KdqCHpppzfM
         1cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MCLUGMKOGCUhcX5PBKwgjDIDGwxEw0xOP/rCTk9Ji7w=;
        b=kHuzJNzu+FwaPn7O/oO+Q/dPVa6sQyxiI7nMI1q0nlbIFdAgcYMUJmcxK26KCo7C/3
         dlAZJRCbNwrzvDU5Prp4fNnTCRoE7UVViSPHEn0pIHIfneZ6W8n/zJrOAoeS+NB2f/f9
         6uZv45B3+Qocu80Hlwz48oYGB2FxazGmfkhBIhA1C++AKrU+dTxGIVGENHduSZM1CWiO
         O0M4uLDZw5XAlkrroA3Fw3NC3DsFEe2gu9sGiokASeq4fhS3vgQC7zrudtO/hEnJn9sK
         l1eJaDzWftzqT53qZoIHvbP4h5YSnPd27/J0PAatfBbsbJETATGU5PenkMuwuK958QSS
         fUrg==
X-Gm-Message-State: AOAM533rNTXbyX3Ntj9ATOYBR3H/n237NV/TaMSP3rbQYaAKJXR1y3Zb
        l9AR1OpAXaKGj0ke2AU3uCCbWHvUQ1xYvFSpkf4=
X-Google-Smtp-Source: ABdhPJzFLjrAS4QeLk1KFR6twQbAcjPSrmnYSU8cMmm1EBYPMvKlpmQ3aMpsI2Zm4QhdZI2+66eoLsV3YPk0O9aLiKs=
X-Received: by 2002:a05:6830:15d0:: with SMTP id j16mr2489968otr.184.1618552400329;
 Thu, 15 Apr 2021 22:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210414144643.17435-1-matthias.bgg@kernel.org> <20210414144643.17435-2-matthias.bgg@kernel.org>
In-Reply-To: <20210414144643.17435-2-matthias.bgg@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:53:11 +0200
Message-ID: <CAFqH_51iP+V1hQ=J+YtLv0K9qoEK9WJgoCiNyqp6Yd1T9RKfXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: mt8183: fix dtbs_check warning
To:     matthias.bgg@kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your patch.

Missatge de l'adre=C3=A7a <matthias.bgg@kernel.org> del dia dc., 14 d=E2=80=
=99abr.
2021 a les 16:48:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Fix unit names to make dtbs_check happy.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 0ff7b67a6806..c5e822b6b77a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -681,13 +681,13 @@ cpu_thermal: cpu_thermal {
>                                 sustainable-power =3D <5000>;
>
>                                 trips {
> -                                       threshold: trip-point@0 {
> +                                       threshold: trip-point0 {
>                                                 temperature =3D <68000>;
>                                                 hysteresis =3D <2000>;
>                                                 type =3D "passive";
>                                         };
>
> -                                       target: trip-point@1 {
> +                                       target: trip-point1 {
>                                                 temperature =3D <80000>;
>                                                 hysteresis =3D <2000>;
>                                                 type =3D "passive";
> @@ -1103,7 +1103,7 @@ u2port0: usb-phy@0 {
>                                 status =3D "okay";
>                         };
>
> -                       u3port0: usb-phy@0700 {
> +                       u3port0: usb-phy@700 {
>                                 reg =3D <0x0700 0x900>;
>                                 clocks =3D <&clk26m>;
>                                 clock-names =3D "ref";
> --
> 2.30.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
