Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E098340784
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCROM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCROMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:12:09 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA6C06175F;
        Thu, 18 Mar 2021 07:12:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso5285109oti.11;
        Thu, 18 Mar 2021 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a50uAhSDderMggKK8RFXjAkHNeNGYqS63dv1RpSuGyc=;
        b=pgxmK244IvKUUg6U3uQJetoS+P0+C8mca9STqv7sC4W8TZCh5gs2zqBkg6m0/1MHrd
         zDFi6ctfeSfr8D88QSqD9ENo8Fl4YJw7lv2//Gpd8mYKT9ly3G7ZVDAOmodrP16TY9HS
         uoGzDxmAp4r4JyuepHDPwpObn9sADhthag0/LMq3gq29wU0ZBi8RFp2hacxC3Edr+5Er
         lUR9QIiOoDQgqsyjHZi0xHL3qwzfIclZOB+C2mjjAW80ukWtpIOziYTHHGQZvu28DGRu
         5WKgq+LPHhqNfM7jkltObWELadokmy3rzlZP1I8knEpn0jzma24CppiQeUYNtKyl+5Gh
         buiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a50uAhSDderMggKK8RFXjAkHNeNGYqS63dv1RpSuGyc=;
        b=Cqg8mpFZu1scP6vxN+fE6Cdetj0NjPzSktwRAZKBW2RkGe7rMcBoP4WOOfSrfGPpzJ
         NlDVE9h0HGRiFc5cJADG2kGLfzOxFFd7+vVrjRBVnEVM0kVv2E3iYZzJuL/ri3rutdWv
         eobxraFBJG7Dphx1jQ5Ri/FU99Y9Dlge6YZYrRaDDx6/T1RUWBHjILffUzh3VjzgSskp
         Edy/Qbfyx9I2W0s+cngoh27CpDMBKJ8zk8pWnsftmEhuZ0r3Z3wU9LPBOJEYXW6W6pRn
         DwhPZFbGR04/P07whUon2YXdtjUutHFXuPLHUwAr9QLa38miskAYhMp3GmZ5Vkt2c+pU
         yP7Q==
X-Gm-Message-State: AOAM530JQdoO6LdgvFvqTNuJbDQT3mo44RA+rjDIPazGqhSXJSXfjEM7
        JKy3jpij+hHQat9IfcEDlqBPpxIEkMPlgogZlMc=
X-Google-Smtp-Source: ABdhPJw4DThuBC9XHi/q9lTAvpKLtWEp1SFB4rMT1KtPPWqAyCi1s2Scsgg6cdjyBkmyan/VAEidSQQvMEkhEBLQHUs=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr7771017oto.281.1616076728381;
 Thu, 18 Mar 2021 07:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210312145545.26050-1-matthias.bgg@kernel.org> <20210312145545.26050-2-matthias.bgg@kernel.org>
In-Reply-To: <20210312145545.26050-2-matthias.bgg@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 18 Mar 2021 15:11:56 +0100
Message-ID: <CAFqH_500_xUU9=y1t=FFErD5LwUb8p9KT7qngW_t99_OPQWeVg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindigns: regulator: mtk: Drop unneeded compatible
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

Thank you for your patch. There is a typo in the subject line
s/dt-bindigns/dt-bindings/ Rob might miss this patch as he filters the
patches by subject I guess.

Missatge de l'adre=C3=A7a <matthias.bgg@kernel.org> del dia dv., 12 de mar=
=C3=A7
2021 a les 15:57:
>
> From: Matthias Brugger <mbrugger@suse.com>
>
> The regulator does not need to have a device tree compatible, if it's
> part of an MFD. We leave the node name to the SoC specific name (e.g.
> mt6323regulator) to allow older kernels to work with the new binding.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../bindings/regulator/mt6323-regulator.txt        |  2 +-
>  .../bindings/regulator/mt6358-regulator.txt        |  4 +---
>  .../bindings/regulator/mt6397-regulator.txt        | 14 +++++---------
>  3 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator=
.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> index a48749db4df36..69f32e1a6702e 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> @@ -19,7 +19,7 @@ LDO:
>  Example:
>
>         pmic: mt6323 {
> -               mt6323regulator: regulators {
> +               mt6323regulator {

If you convert this binding to YAML, you'll probably get a review that
the node name must be just 'regulators' here. And then, looking at the
other patches something will break I guess ...

>                         mt6323_vproc_reg: buck_vproc{
>                                 regulator-name =3D "vproc";
>                                 regulator-min-microvolt =3D < 700000>;
> diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator=
.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> index 9a90a92f2d7e1..ba1214da5bf7c 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> @@ -23,9 +23,7 @@ Example:
>         pmic {
>                 compatible =3D "mediatek,mt6358";
>
> -               mt6358regulator: mt6358regulator {
> -                       compatible =3D "mediatek,mt6358-regulator";
> -
> +               mt6358regulator {
>                         mt6358_vdram1_reg: buck_vdram1 {
>                                 regulator-compatible =3D "buck_vdram1";
>                                 regulator-name =3D "vdram1";
> diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator=
.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> index c080086d3e629..2b14362ac56e1 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> @@ -1,11 +1,9 @@
>  Mediatek MT6397 Regulator
>
> -Required properties:
> -- compatible: "mediatek,mt6397-regulator"
> -- mt6397regulator: List of regulators provided by this controller. It is=
 named
> -  according to its regulator type, buck_<name> and ldo_<name>.
> -  The definition for each of these nodes is defined using the standard b=
inding
> -  for regulators at Documentation/devicetree/bindings/regulator/regulato=
r.txt.
> +List of regulators provided by this controller. It is named
> +according to its regulator type, buck_<name> and ldo_<name>.
> +The definition for each of these nodes is defined using the standard bin=
ding
> +for regulators at Documentation/devicetree/bindings/regulator/regulator.=
txt.
>
>  The valid names for regulators are::
>  BUCK:
> @@ -23,9 +21,7 @@ Example:
>         pmic {
>                 compatible =3D "mediatek,mt6397";
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
