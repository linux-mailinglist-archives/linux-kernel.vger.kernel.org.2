Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84B32DAC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhCDUDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236804AbhCDUD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:03:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66CCC64F45;
        Thu,  4 Mar 2021 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888166;
        bh=bruc6SY11nBgSItW59izSH7Jt5Lb6PEf73rKiiR9gvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YC7vXYrbKSlpqOHrmatgu1RESLRfZElZ3V56ybqaWC5SfA1KiPowSDQxgypsgc5P1
         z2sbEMYvJ5Pd+br9iNppsr8ly6dwSMlUD4HWYfB44oWHCIJnIyRaUUxGeeRb3OwkwX
         gjv98iBw5dwRAULA6y5q0hm1fdDBpKHYyeE3lvLFrIflYTcL+hp005jV1QBVLd2BzM
         LHkpMP5ryg0pAw7e4XM0UVjhD5TNJSHi0A7cAwemVz68YbMNGLGzklyEBSomKWxgbe
         jJVQ8CyAdUOpcEkAOZZa04YdR3FaC2L3c8RDpi+TB7VBfnxPpJ1CUb5mJ/fB1JjKHq
         Dek2GogjvrvqA==
Received: by mail-ej1-f45.google.com with SMTP id p8so25533102ejb.10;
        Thu, 04 Mar 2021 12:02:46 -0800 (PST)
X-Gm-Message-State: AOAM530xa6QkWIyv9KCVggQSl2slaXawQlsuoOs1ugM7VEV7itn0oJWz
        iAMo7NQP8iA0qSkf+vjnTN2GJrQWDaJExnAk0Q==
X-Google-Smtp-Source: ABdhPJzwjPqB5mqgjUm8IO6F5PFehRlUl9DieoKYxQUK9v3daKrCxnAREqPHnHBfcmjiHKHpDPpZeGLj6ie+eG05LAg=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr6218826ejb.359.1614888165006;
 Thu, 04 Mar 2021 12:02:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612867682.git.michal.simek@xilinx.com> <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
 <20210210222241.GA2901449@robh.at.kernel.org> <584bfee2-17a6-5935-b61c-b49824bcf857@xilinx.com>
 <CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com> <2f0f4e86-cf9d-03d7-a3a6-8f2284facaaa@xilinx.com>
In-Reply-To: <2f0f4e86-cf9d-03d7-a3a6-8f2284facaaa@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Mar 2021 14:02:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com>
Message-ID: <CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb5744 hub
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 7:38 AM Michal Simek <michal.simek@xilinx.com> wrot=
e:
>
> Hi Rob,
>
> On 2/11/21 3:42 PM, Rob Herring wrote:
> > On Thu, Feb 11, 2021 at 3:35 AM Michal Simek <michal.simek@xilinx.com> =
wrote:
> >>
> >> Hi Rob,
> >>
> >> On 2/10/21 11:22 PM, Rob Herring wrote:
> >>> On Tue, Feb 09, 2021 at 11:48:09AM +0100, Michal Simek wrote:
> >>>> From: Piyush Mehta <piyush.mehta@xilinx.com>
> >>>>
> >>>> Added dt binding for usb5744 driver.
> >>>>
> >>>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> >>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>>> ---
> >>>>
> >>>> Changes in v2: None
> >>>>
> >>>>  .../bindings/usb/microchip,usb5744.yaml       | 56 ++++++++++++++++=
+++
> >>>>  MAINTAINERS                                   |  1 +
> >>>>  2 files changed, 57 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,=
usb5744.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744=
.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..fe222f6db81d
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> >>>> @@ -0,0 +1,56 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
> >>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >>>> +
> >>>> +title: Bindings for the Microchip USB5744 4-port Hub Controller
> >>>> +
> >>>> +description:
> >>>> +  Microchip=E2=80=99s USB5744 SmartHub=E2=84=A2 IC is a 4 port, Sup=
erSpeed (SS)/Hi-Speed (HS),
> >>>> +  low power, low pin count configurable and fully compliant with th=
e USB 3.1
> >>>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) an=
d Low Speed
> >>>> +  (LS) USB signaling, offering complete coverage of all defined USB=
 operating
> >>>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB =
2.0
> >>>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected =
by slower
> >>>> +  USB 2.0 traffic.
> >>>> +
> >>>> +maintainers:
> >>>> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> >>>> +  - Michal Simek <michal.simek@xilinx.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: microchip,usb5744
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +    description: |
> >>>> +      Specifies the i2c slave address, it is required and should be=
 0x2d
> >>>> +      if I2C is used.
> >>>
> >>> If I2C is not used, then this should be underneath the USB host as a =
USB
> >>> device. That also implies a different compatible string. I'd suggest =
you
> >>> just say I2C is required if that's your use.
> >>
> >> We can't say that i2c is required because we have both cases. One is
> >> really usb hub connected over i2c which at least requires to send one
> >> smbus command to start operate. But it can be extended to add more
> >> features - limit speeds, disable ports, etc.
> >>
> >> And the second is really the same usb hub without i2c connected which
> >> runs in default mode. But reset is required to ensure proper reset
> >> sequence.
> >> Hub also have external clock chip which is not handled now because it =
is
> >> just crystal on the board but if you want I can also model it via fixe=
d
> >> clock and call clock enable for it.
> >>
> >> It is the same use case as is with
> >> Documentation/devicetree/bindings/usb/usb3503.txt
> >
> > Yes, there are examples of how we don't want to do it.
>
> ok.
>
> >
> >> Can you please elaborate why different compatible string should be use=
d?
> >> It is still the same device and not quite sure why different compatibl=
e
> >> string should be used.
> >>
> >> Do you also want to example where this node is the part of usb node?
> >
> > See usb/usb-device.txt. And there is this[1] under review.
> >
> > For these cases with I2C, I'd really rather see the hub always under
> > the USB bus with a link to the I2C bus when connected.
>
> I read that thread and also looked at his device and it is very similar
> to this one. Binding should also have information about i2c or spi. It
> is the same case here that you can use this hub without any bus
> connected which works in default mode. Or when i2c/smbus is connected
> and the hub is waiting for initialization sequence. And I expect spi
> behaves very similarly but don't have this setup here.
>
> Do we have any binding doc which is using suggested bus link?

'i2c-bus' or 'ddc-i2c-bus' properties for I2C. Don't think we have
anything for SPI, but I'd expect it would be similar though we'd need
a cell for the chip-select.

Rob
