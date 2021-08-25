Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77D33F6F64
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhHYGW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhHYGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:22:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CAFC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:21:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b7so35330119edu.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=syOxfM62LkM7upKReOBvkmgZS+avI6nD5bcxAo63aOo=;
        b=fPCFQTzaDRGBpHqDfWAIoWTU8T1ed2Dhe8bu5ZXK7zHk6DcPZTyP8peWEWmWBfzIqE
         IXJ+KQzkqeWYp8GmmwrV77Lk232sA500eERC+00FpNdwK+5Ggqrmvs53i3degaHjdkWF
         lRY16jyqQnbYYrhpMTNQtLt8gWcdK75+AXzhBpGGgNyyV1IQW2pYse+YhxL66ATg6FDE
         7iy9Tk8++7H1bjcKhQhKqHw6r8vmAWqbq0gaeeZzHJftsbD9t3n/lN9mrTYbCjd4mU4R
         7nHbS8euIkct9yg8erjMZfCJJ4cwvBegwJVH6uZ/yXfRm203RFv0zymUL8crp/B73flJ
         NPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=syOxfM62LkM7upKReOBvkmgZS+avI6nD5bcxAo63aOo=;
        b=s8lHH3bMaFI8rNqQu/B0/W4v4QMu2PxRvaS7sZCkP4dSooPBWCFFzkBVkiri5clKFA
         Ig191PDp6SZQNoH+GxQ4unJLV5MPNXhyLFjCzNmNkhU8a+vOQN2VfXYEfe3vkN/6s5Uj
         F+WY1UluZYO1e7Ldr1DpMl2NmymJRUfZIWvwNnGxyyvS101L3zsCc6eb23JhIZyYssdq
         /9H1npD14zNQOWRbjCAYuVtezCfpxN0HJ95jGikMxYQiEIqWBBXtKOLbWpiFfTfJO0PU
         Z+L63VX5kvo151VMCLQ4CNdy0rxMY9wHOcn6PrttHP+c2nL9MtRmDpGv31CM4rKGl9mc
         BnoQ==
X-Gm-Message-State: AOAM5333a5+gKkcJjkuoBLBBDjmoVp/YGgDZ8cjtnEQMuUi6YyLo4rAt
        h2xT3PBx6Z5yedppRagBFGnV5f07HfJz9T3xXuqEbklJUnDd+g==
X-Google-Smtp-Source: ABdhPJxZrPfQGGgCD1HyK3wyYHlm12n8eeADNUIhQ0FsY/2kafLC6el2dPwhmw0M0N3G1irGYr1Bgx6lIt322q0qua8=
X-Received: by 2002:a05:6402:430a:: with SMTP id m10mr12044536edc.235.1629872498354;
 Tue, 24 Aug 2021 23:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <89b36e0a6187cc6b05b27a035efdf79173bd4486.1628240307.git.michal.simek@xilinx.com>
In-Reply-To: <89b36e0a6187cc6b05b27a035efdf79173bd4486.1628240307.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Aug 2021 08:21:27 +0200
Message-ID: <CAHTX3d+WoUWPNHpzP41zLgVfagSiM7GxE-EQ22e+H4eeKNUcHQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Fix serial compatible string
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 6. 8. 2021 v 10:58 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Based on commit 65a2c14d4f00 ("dt-bindings: serial: convert Cadence UART
> bindings to YAML") compatible string should look like differently that's
> why fix it to be aligned with dt binding.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 6f0fcec28ae2..b5fde9dddca5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -786,7 +786,7 @@ ttc3: timer@ff140000 {
>                 };
>
>                 uart0: serial@ff000000 {
> -                       compatible =3D "cdns,uart-r1p12", "xlnx,xuartps";
> +                       compatible =3D "xlnx,zynqmp-uart", "cdns,uart-r1p=
12";
>                         status =3D "disabled";
>                         interrupt-parent =3D <&gic>;
>                         interrupts =3D <0 21 4>;
> @@ -796,7 +796,7 @@ uart0: serial@ff000000 {
>                 };
>
>                 uart1: serial@ff010000 {
> -                       compatible =3D "cdns,uart-r1p12", "xlnx,xuartps";
> +                       compatible =3D "xlnx,zynqmp-uart", "cdns,uart-r1p=
12";
>                         status =3D "disabled";
>                         interrupt-parent =3D <&gic>;
>                         interrupts =3D <0 22 4>;
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
