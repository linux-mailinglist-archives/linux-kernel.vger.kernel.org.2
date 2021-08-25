Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE43F6F61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhHYGWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhHYGWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:22:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B2C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:21:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d11so49166394eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dVbVehniMjvM5NTf7hHZxByXWjOXE/OB/pEnc9eElz0=;
        b=NINaQSEe9BIAWzEicFglmOCIPlRb36EMQwFxA84GeRAk/vIvBZvadK6Fn+EWH2G3lW
         1wYaViWU1s4jRHw48g8BLMs9KwfYC4PSPqM7yWGSB0cqImleDuIuPYOJSeRizxg5iUrV
         v19RzQ4UEtqOHQx/ggFcPd53CWfRj0q8FtOReGwywnGDp4gHi7Exp9i7c4bKcqW8ricV
         OnBsH61RrriwAr3L5GrABTyjjpTcoeYzvcp4QB+PD5z9ZVhCbTrTlavr6vAHtrFFFVQq
         w3tOmyBbcC2+PxPWH+hKN6apbu7M85KNyttreUqfOr33sktDveRY2ON8RZrP9fzUqM7n
         YMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dVbVehniMjvM5NTf7hHZxByXWjOXE/OB/pEnc9eElz0=;
        b=I3aHHLbc6ViS01pI+C5EpqeyDzqWqAMEvLx36JV7k8kLCtraG52lCtnMYQbfpwqCfS
         iivixSa1g7UKcCCtZ9gejP/KTRlkrY7ZziRXOgMBO41sV7MXXObUSyGyVoZaoljQoMGM
         xMqqr3shYeHmMMerCXPXRa5Qo6H81kYqJ8OxSGRrqaFbYqH1c9VKthc5wFovckfj0XFN
         gP/pVKXYIc9OZL3TAV3211iPqCKjzjf4tLL67JCCY0N2lTAA+iwI4i4KXK0U/uR8yeUa
         PbQQ/Xurw8FXeV3C0WLiu4yiBS7G4Wj+6QJo6hbNCOF9U4pEQ5UYUNXJIkakqcrazwSx
         LvDw==
X-Gm-Message-State: AOAM531sKY3YX3b5S1KLoAvRzB0eaglh7X6bPcKmWwBlei7OQAnqr/gK
        5rnciBqGJXRgrBAnBm7gXLm6417z+61PePcvFkjVijlvxG0inA==
X-Google-Smtp-Source: ABdhPJyWNpsoF0T+CDZ16yFHeOWwIdTehvTSFaPlIS3HVyl2r9xCTU0yNZe0dD/ZVM48XZ5KiWfKP0dblBWEx9LjSGM=
X-Received: by 2002:a17:906:3542:: with SMTP id s2mr44983723eja.379.1629872473599;
 Tue, 24 Aug 2021 23:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <876c53b92f99623bae45d5c0c5ae79ee3e24f745.1628239345.git.michal.simek@xilinx.com>
In-Reply-To: <876c53b92f99623bae45d5c0c5ae79ee3e24f745.1628239345.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Aug 2021 08:21:02 +0200
Message-ID: <CAHTX3dJMN+PVdz8Dx6JnCuSBbQdwF57HXNQT0xaUovz6JivcTg@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Remove not documented is-dual property
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 6. 8. 2021 v 10:42 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Remove is-dual not documented property and also update comment about QSPI
> sizes to reflect dual configuration as 16MB + 16MB.
> Only single configuration is supported now.
>
> Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 3 +--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 3 +--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index becfc23a5610..3d8d14ef1ede 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -937,9 +937,8 @@ &psgtr {
>
>  &qspi {
>         status =3D "okay";
> -       is-dual =3D <1>;
>         flash@0 {
> -               compatible =3D "m25p80", "jedec,spi-nor"; /* 32MB */
> +               compatible =3D "m25p80", "jedec,spi-nor"; /* 16MB + 16MB =
*/
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 reg =3D <0x0>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index d2219373580a..057c04352591 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -931,9 +931,8 @@ &psgtr {
>
>  &qspi {
>         status =3D "okay";
> -       is-dual =3D <1>;
>         flash@0 {
> -               compatible =3D "m25p80", "jedec,spi-nor"; /* 32MB */
> +               compatible =3D "m25p80", "jedec,spi-nor"; /* 16MB + 16MB =
*/
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 reg =3D <0x0>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index dac5ba67a160..e1fff62a4cd5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -773,9 +773,8 @@ &psgtr {
>
>  &qspi {
>         status =3D "okay";
> -       is-dual =3D <1>;
>         flash@0 {
> -               compatible =3D "m25p80", "jedec,spi-nor"; /* 32MB */
> +               compatible =3D "m25p80", "jedec,spi-nor"; /* 16MB + 16MB =
*/
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 reg =3D <0x0>;
> --
> 2.32.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
