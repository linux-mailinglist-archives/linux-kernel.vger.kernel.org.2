Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0454421A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKAU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhKAU0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:26:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D00E61058;
        Mon,  1 Nov 2021 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635798237;
        bh=feSTcRc2actU+HHo2pcgOZswEK9+Krw1YkXnHhxgUtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k6/BV6czCRnhMubWyz+TvKRLAdfLuZ6hVCq4/8MWd4wluVUqTYwxezxQIkHpVGLCi
         9qekMnUAVBMJ9vDxkS2TRXfI/zIhh1o1L2vKlETOW8wbwXlwNKhND0P3W8rIokSQir
         MndHf7pqpC8YM377htnlXMhggAH9KgPFAfJouRRXl3nM3w7wOWhKtxX8wb8Vwlfp7w
         0A2HCfyDkFV/nNR4STfwHOOTFQ3ZKZxvqAiK4PsNvkqWJ1mg2Gzaoq7BQ8MH+9CSgC
         rl8dYgsQwa3OKzx9P2ojjTcr/aV9svuFi509I/vCr5XiU0Zx1EZkwouGCOcCUlQ0Ad
         xkLHGtHEuIUgg==
Received: by mail-ed1-f43.google.com with SMTP id w1so14389714edd.10;
        Mon, 01 Nov 2021 13:23:56 -0700 (PDT)
X-Gm-Message-State: AOAM531U4l0NOB7TqC2TawJCuTIDv9zsA0DJmsBwdCNcIf4wH2wthEFV
        Y7Bm/4KSjrGGAQ+dlQzN33Znu82Hr1hzTYHsqQ==
X-Google-Smtp-Source: ABdhPJxerSbOAL+RQjUEcSRK11YYr4XJkk1k3y92Df/MixrQUqwOf/jtSj37gCjipDXUeK8l900VtO/oHXaq6BA8PhM=
X-Received: by 2002:aa7:dc13:: with SMTP id b19mr28817292edu.145.1635798235443;
 Mon, 01 Nov 2021 13:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211024180628.2992108-1-piyush.mehta@xilinx.com> <20211024180628.2992108-2-piyush.mehta@xilinx.com>
In-Reply-To: <20211024180628.2992108-2-piyush.mehta@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Nov 2021 15:23:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKu6vr3iCz1G7MtK6gyqAvn4s4mpuLOwPzJDEmyZeROig@mail.gmail.com>
Message-ID: <CAL_JsqKu6vr3iCz1G7MtK6gyqAvn4s4mpuLOwPzJDEmyZeROig@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb2244 Controller
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        --to=robh+dt@kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 1:06 PM Piyush Mehta <piyush.mehta@xilinx.com> wrot=
e:
>

Your email is somewhat corrupted. Lore has a warning:

[-- Warning: decoded text below may be mangled, UTF-8 assumed --]
[-- Attachment #1: Type: text/plain; charset=3D"y", Size: 2065 bytes --]

Maybe it's the '--to=3Drobh+dt@kernel.org' email...

> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controlle=
rs
> provides an ultra-fast interface between a USB host controller and flash
> media cards.
>
> Add dt-bindings documentation for Microchip's usb2244 Controller.
> USB224x is a USB 2.0 compliant ultra fast USB 2.0 multi-format,
> SD/MMC, and MS Flash Media Controllers.
>
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  .../devicetree/bindings/usb/microchip,usb2244.yaml | 43 ++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb22=
44.yaml
>
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml=
 b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
> new file mode 100644
> index 0000000..ecab0cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/microchip,usb2244.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Bindings for the Microchip USB2244 Ultra Fast USB-SD Controller
> +
> +description:
> +  Microchip=E2=80=99s USB224x is a USB 2.0 compliant, Hi-Speed bulk only=
 mass
> +  storage class peripheral controller intended for reading and writing
> +  to popular flash media from the xDPicture Card=E2=84=A2, Memory Stick=
=C2=AE (MS),
> +  Secure Digital (SD), and MultiMediaCard=E2=84=A2 (MMC) families.
> +
> +  USB224x is a flash media card reader solution fully compliant with the
> +  USB 2.0 specification
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: microchip,usb2244
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      The phandle and specifier for the GPIO that controls the RESET lin=
e of
> +      flash media controller.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    usb {
> +       compatible =3D "microchip,usb2244";

This needs to be a USB device under a USB controller node. See usb-device.y=
aml.

> +       reset-gpios =3D <&gpio 2 GPIO_ACTIVE_HIGH>;
> +    };
> --
> 2.7.4
>
