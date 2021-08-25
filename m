Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA873F6F67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhHYGWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhHYGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:22:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B36C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:22:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a25so22557413ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTWhmsKgwbDFsVJhts9Qh7GBwT3/hbH2uX+PR+DVBu8=;
        b=lKOkexaTXaucGOHXzmEynjn5hUr74w+ENkl2G+KxGNXThWrbM2MyiCbrZ3BuJp0Uay
         lcozOkcclK0s1YlIu1e/mo4YxnxH76YSJloh94L0WiflsaFM4RdbGkBmL7oDOyhxML9d
         G2ljW7ZSubJ4lDnvrtFlLz/8TZYrR+X2opHUFGOhTQXHCxFHx+k869yTQcqDDtf4WstP
         Lb4IUt4UU4h8us/k+1EnUXN84ZBe9p2yPyRePeuhBIPCnnmes0G0FTsNyiu/Wh89aTqQ
         MzYzNM9sxFtVnfodtaIlnJ6XGaoJ6zvdrORlsrVWUjdXh4/C81ShNZ5KJV6h2iZm8tuT
         cFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTWhmsKgwbDFsVJhts9Qh7GBwT3/hbH2uX+PR+DVBu8=;
        b=guiLCWm3qpfmohj6AV08VHHihlBdEnqYgwZeelJq4YNIBYXVxd5ZNJyTqj9hNCOVtS
         ++hNi2zEEweqvXEVDvfaJ1I9ocVaK9sZY5H/OoIqZrSUYyrsgEx3bqDW+9fh/NKyeri1
         EwganZADk6h6CipRexZGrF0rXy/MH/1Nl7xCRQLx2V7DzdX1ou3qdiO2N1ePL6hiqQ2l
         emNitTqAr4QCprAS4TyLJGBl7V+5bsQrt7afryoVDOOrI3lVHabl/xOUAzyR6wcahryf
         XSZ7wkxhtRoWlhKA1KKR4lHmpv/aNztAQZHm21PrS3XM/XAg1771ljaTdyPtGt5v/K+5
         B+MA==
X-Gm-Message-State: AOAM5339I+CcotrwNupo1193VqsqDp2MxHgsCetoTU8IInkVDpIDzZCn
        eYCO34LTDnlXnvXvI9FV16jyeniK5e4It47l+GFgb0KOpbcNoQ==
X-Google-Smtp-Source: ABdhPJwFakTRrrBQO6AZDqGsGJCmtdAWT6x8a95rhHSe35Ks+xJsxJzdV1rbOyqb4MvvF6r6gdrmEjwEUdejK7/pxjY=
X-Received: by 2002:a17:906:d04f:: with SMTP id bo15mr43914505ejb.309.1629872524751;
 Tue, 24 Aug 2021 23:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <839d833133318feeb2755c4431204b0ef4788cce.1628244299.git.michal.simek@xilinx.com>
In-Reply-To: <839d833133318feeb2755c4431204b0ef4788cce.1628244299.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Aug 2021 08:21:54 +0200
Message-ID: <CAHTX3d+Tan44uNNzbwfc7gYxhagAioms+qVRFD62weS=cHDB4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Enable gpio and qspi for zc1275-revA
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 6. 8. 2021 v 12:05 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Add missing gpio and qspio for zc1275-revA board.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  .../boot/dts/xilinx/zynqmp-zc1275-revA.dts     | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> index 66a90483b004..e971ba8c1418 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZC1275
>   *
> - * (C) Copyright 2017 - 2019, Xilinx, Inc.
> + * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> @@ -20,6 +20,7 @@ / {
>         aliases {
>                 serial0 =3D &uart0;
>                 serial1 =3D &dcc;
> +               spi0 =3D &qspi;
>         };
>
>         chosen {
> @@ -37,6 +38,21 @@ &dcc {
>         status =3D "okay";
>  };
>
> +&gpio {
> +       status =3D "okay";
> +};
> +
> +&qspi {
> +       status =3D "okay";
> +       flash@0 {
> +               compatible =3D "m25p80", "jedec,spi-nor";
> +               reg =3D <0x0>;
> +               spi-tx-bus-width =3D <1>;
> +               spi-rx-bus-width =3D <4>;
> +               spi-max-frequency =3D <108000000>;
> +       };
> +};
> +
>  &uart0 {
>         status =3D "okay";
>  };
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
