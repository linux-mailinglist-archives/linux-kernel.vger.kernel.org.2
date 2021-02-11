Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD4318DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBKPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhBKOoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:44:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5428764E7A;
        Thu, 11 Feb 2021 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613054590;
        bh=HIfI4zvgKyR/JmQ+MbMdDh6FwBoPjPjXgns66wz8fAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LxETXxWvAEag4weyJLBLrj286mBIldgdBn8wOQcriful/Ffq5cPQC0Fbpbai3OxJl
         snJonqQY1Ek73Q8xY9cTrg9h6qyWjFkKCtv+hP5Xy8nqZXpT7ljhy0CyFknAcANW9V
         YD4VQS9x/WYrmS7MR70ljf2x2BdzY+nFiafYDy8YP/wffGcAeTorHUoBDYMnbvfz6m
         ZD4cYQam1xBjeBqHYR7qZsVsAn8Soza0vRNOgPVsv3XfNCfv68Etg0WAE1GWnzMPPz
         u9hC9bOPGLYpvpmnYmjZsiMpIjtK9TaLbCSxOUU1C2Vta2vmSwadCwvG3R1YqXspr4
         x8rEWqCfpg07A==
Received: by mail-ej1-f42.google.com with SMTP id bl23so10433559ejb.5;
        Thu, 11 Feb 2021 06:43:10 -0800 (PST)
X-Gm-Message-State: AOAM532aF/7NfRwT5D8ZRzR86m9XDN8RWuUKtAEso3HQb+YQJSPOsgKc
        rEI+J2Q/PhlhPzhtcZtEtavO64eezmv8Y0mwxA==
X-Google-Smtp-Source: ABdhPJwWel9VyFtMO1t8Xd9hmMIghxDUryjOtIt5lyixWmc3hGCNmz+5uparR5CAe9DhrX4DT98QMj6oCm0bnN3D2as=
X-Received: by 2002:a17:906:57cd:: with SMTP id u13mr8863365ejr.341.1613054588880;
 Thu, 11 Feb 2021 06:43:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612867682.git.michal.simek@xilinx.com> <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
 <20210210222241.GA2901449@robh.at.kernel.org> <584bfee2-17a6-5935-b61c-b49824bcf857@xilinx.com>
In-Reply-To: <584bfee2-17a6-5935-b61c-b49824bcf857@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Feb 2021 08:42:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com>
Message-ID: <CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb5744 hub
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 3:35 AM Michal Simek <michal.simek@xilinx.com> wrot=
e:
>
> Hi Rob,
>
> On 2/10/21 11:22 PM, Rob Herring wrote:
> > On Tue, Feb 09, 2021 at 11:48:09AM +0100, Michal Simek wrote:
> >> From: Piyush Mehta <piyush.mehta@xilinx.com>
> >>
> >> Added dt binding for usb5744 driver.
> >>
> >> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> Changes in v2: None
> >>
> >>  .../bindings/usb/microchip,usb5744.yaml       | 56 ++++++++++++++++++=
+
> >>  MAINTAINERS                                   |  1 +
> >>  2 files changed, 57 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,us=
b5744.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.y=
aml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> >> new file mode 100644
> >> index 000000000000..fe222f6db81d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> >> @@ -0,0 +1,56 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: Bindings for the Microchip USB5744 4-port Hub Controller
> >> +
> >> +description:
> >> +  Microchip=E2=80=99s USB5744 SmartHub=E2=84=A2 IC is a 4 port, Super=
Speed (SS)/Hi-Speed (HS),
> >> +  low power, low pin count configurable and fully compliant with the =
USB 3.1
> >> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and =
Low Speed
> >> +  (LS) USB signaling, offering complete coverage of all defined USB o=
perating
> >> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.=
0
> >> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by=
 slower
> >> +  USB 2.0 traffic.
> >> +
> >> +maintainers:
> >> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> >> +  - Michal Simek <michal.simek@xilinx.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: microchip,usb5744
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +    description: |
> >> +      Specifies the i2c slave address, it is required and should be 0=
x2d
> >> +      if I2C is used.
> >
> > If I2C is not used, then this should be underneath the USB host as a US=
B
> > device. That also implies a different compatible string. I'd suggest yo=
u
> > just say I2C is required if that's your use.
>
> We can't say that i2c is required because we have both cases. One is
> really usb hub connected over i2c which at least requires to send one
> smbus command to start operate. But it can be extended to add more
> features - limit speeds, disable ports, etc.
>
> And the second is really the same usb hub without i2c connected which
> runs in default mode. But reset is required to ensure proper reset
> sequence.
> Hub also have external clock chip which is not handled now because it is
> just crystal on the board but if you want I can also model it via fixed
> clock and call clock enable for it.
>
> It is the same use case as is with
> Documentation/devicetree/bindings/usb/usb3503.txt

Yes, there are examples of how we don't want to do it.

> Can you please elaborate why different compatible string should be used?
> It is still the same device and not quite sure why different compatible
> string should be used.
>
> Do you also want to example where this node is the part of usb node?

See usb/usb-device.txt. And there is this[1] under review.

For these cases with I2C, I'd really rather see the hub always under
the USB bus with a link to the I2C bus when connected.

Rob

[1] https://lore.kernel.org/linux-devicetree/20210210091015.v5.1.I248292623=
d3d0f6a4f0c5bc58478ca3c0062b49a@changeid/
