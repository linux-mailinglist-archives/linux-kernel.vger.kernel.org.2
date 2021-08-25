Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6663F6F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhHYGX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbhHYGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:23:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B5C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:22:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so10741159edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eF2sy8oNTsdMLU6pLrdZdA0MNtuollQXR7O5tJyRoik=;
        b=RhhiFl7xn7hJR1KbDCWdVPWdy1WHeR3Y77IJoHIxNfkPePvhTkDmnzJcafSXkRYC2K
         z/s4QHYISMoZd96G/Hx0Z7Yxt3Ibxh1DBIEmU36fTAL1pF5/Dsbf2JJs0+YA9Hj96QY7
         KeZxnxZxYXPLam1wXJs1lOisHxYxuQOiTFYm2RmWTq2C7YAbYIg4DO8Oc4bEbJl+kWWo
         xg1i/wSgWvfQawWGyQq+O7XmybqVd9CWiJ/G56ICt2/VGZBeYV6PwvCq/dDfS9cODYT/
         eQ5dojtOyL4biJPT59+TlwhgEglXu31hevF3kCEG6446L6QTRHitZMK8LPvzR/smhsWM
         7GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eF2sy8oNTsdMLU6pLrdZdA0MNtuollQXR7O5tJyRoik=;
        b=YtBvXeTRoJy8xf773fLSJ44syGPjCMwzMN7NtbW1myG3ZhhdgGIIcWR6wvDPN/ofyN
         aGo48nxbmOU2Oc2uOPecns8zjcDe27YN21WRNv96EuMsm1+wqfSs03CP9drcIaO/AsHH
         JaLJ79LLKbFiuUzeKh7s297M0iq4slzx5cS4sc1d+9jZZ3RVRRj7bDnSXGcWamTQDj5l
         pmY7OGYPmft+d6vC4MxjRU0ePDSXz2VASYaLY/Ph4syCGy06+3Eto/LRGPJhQjXYxyGJ
         FSnnoXJp3ZrhekZJHrhCAaBTaVDWQ9447UaEO0iy2mLt46z7zQfdY7717lmlrDPlGLXw
         o8Nw==
X-Gm-Message-State: AOAM531ygZwMF7uSNH0Gpoi3SF+xFh98YjT89McZXjTVspkiTEBuFRlQ
        w8sXZVval6Id/IwYVFc+Ny3uWiecxnY+WpoAfjLOiBDCiZsamw==
X-Google-Smtp-Source: ABdhPJzqvn3pevoyyWnIEzgF9K/gYAD3tejldgkNie2UVrI48oKDfgaaumvaIDAkYL/oE5ZVGxEROrLd/7U/XrZXiLE=
X-Received: by 2002:aa7:cc02:: with SMTP id q2mr46439428edt.154.1629872558097;
 Tue, 24 Aug 2021 23:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <8c78625f08c16385a4798e0a62d20df7491ac00e.1628244860.git.michal.simek@xilinx.com>
In-Reply-To: <8c78625f08c16385a4798e0a62d20df7491ac00e.1628244860.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Aug 2021 08:22:27 +0200
Message-ID: <CAHTX3dJUH_DEKsLYNO0Z2StOBcnD5qynraJz_JLY_q_W6-nTTw@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Wire psgtr for zc1751-xm013
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

p=C3=A1 6. 8. 2021 v 12:14 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Add psgtr description for SATA and USB.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Based on https://lore.kernel.org/r/cover.1628244703.git.michal.simek@xili=
nx.com
> ---
>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> index 4394ec3b6a23..381cc682cef9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> @@ -11,6 +11,7 @@
>
>  #include "zynqmp.dtsi"
>  #include "zynqmp-clk-ccf.dtsi"
> +#include <dt-bindings/phy/phy.h>
>
>  / {
>         model =3D "ZynqMP zc1751-xm017-dc3 RevA";
> @@ -37,6 +38,18 @@ memory@0 {
>                 device_type =3D "memory";
>                 reg =3D <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x8=
0000000>;
>         };
> +
> +       clock_si5338_2: clk26 {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <26000000>;
> +       };
> +
> +       clock_si5338_3: clk125 {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <125000000>;
> +       };
>  };
>
>  &fpd_dma_chan1 {
> @@ -116,6 +129,13 @@ &nand0 {
>         num-cs =3D <2>;
>  };
>
> +&psgtr {
> +       status =3D "okay";
> +       /* usb3, sata */
> +       clocks =3D <&clock_si5338_2>, <&clock_si5338_3>;
> +       clock-names =3D "ref2", "ref3";
> +};
> +
>  &rtc {
>         status =3D "okay";
>  };
> @@ -131,6 +151,8 @@ &sata {
>         ceva,p1-comwake-params =3D /bits/ 8 <0x06 0x19 0x08 0x0E>;
>         ceva,p1-burst-params =3D /bits/ 8 <0x13 0x08 0x4A 0x06>;
>         ceva,p1-retry-params =3D /bits/ 16 <0x96A4 0x3FFC>;
> +       phy-names =3D "sata-phy";
> +       phys =3D <&psgtr 2 PHY_TYPE_SATA 0 3>;
>  };
>
>  &sdhci1 { /* emmc with some settings */
> @@ -149,6 +171,8 @@ &uart1 {
>
>  &usb0 {
>         status =3D "okay";
> +       phy-names =3D "usb3-phy";
> +       phys =3D <&psgtr 0 PHY_TYPE_USB3 0 2>;
>  };
>
>  &dwc3_0 {
> @@ -161,6 +185,8 @@ &dwc3_0 {
>  /* ULPI SMSC USB3320 */
>  &usb1 {
>         status =3D "okay";
> +       phy-names =3D "usb3-phy";
> +       phys =3D <&psgtr 3 PHY_TYPE_USB3 1 2>;
>  };
>
>  &dwc3_1 {
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
