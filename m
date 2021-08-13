Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA43EBC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhHMSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:53:15 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41790 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHMSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:53:14 -0400
Received: by mail-oi1-f175.google.com with SMTP id be20so17240936oib.8;
        Fri, 13 Aug 2021 11:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mdzy0KX+fl8Q5N04J1STf/fVrOxfUwyLIOn26vpnuiI=;
        b=YUWXlDymuvCcwKHMxhaiLGGFk5deq3MkhFKraasdq59R1oT/7eoSGgZPYc5MyoKSwW
         m8yAQzmOe0i3SibRixWid9PObkjgPvVY0MppmGGOuO46r6fXRQ2oAmn2K6ENE4/ynoQS
         Cw7XW9lYNhhhqznRpwuKrYxg/NuWZp9/gNEOIjMdNo6XhsGaJitwnkAjubkEYeyGtrVV
         LLueRy2d6fwl8YkVipEjKK4MadvYHFUeFQvTGbd9vqwkLqMSX0KcCMIEaqLR+Mbn9KHP
         yEDap0xM7kJFxYuTrkPukc1HDEmJ1ofh09m8xXKdreBq7sh7O1j/xO/jmHNxIPft3AOY
         pq3A==
X-Gm-Message-State: AOAM533588C751MTy5rzqAZ3bvbH69voyDdkDVS5uIRfbCVXGduNJr12
        ddK3HwKehnCBpOvn73gIDA==
X-Google-Smtp-Source: ABdhPJyLUXUJRcE/jMjACT75yHjEPAVxS+dLaQGxKczevuNEaqic1Wiop2DZjTPspxeR0wQaHMxqHw==
X-Received: by 2002:aca:230f:: with SMTP id e15mr657649oie.154.1628880767430;
        Fri, 13 Aug 2021 11:52:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u14sm412251oot.36.2021.08.13.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:52:46 -0700 (PDT)
Received: (nullmailer pid 3854710 invoked by uid 1000);
        Fri, 13 Aug 2021 18:52:45 -0000
Date:   Fri, 13 Aug 2021 13:52:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: add schema for USB hub on Kirin
 devices
Message-ID: <YRa/fURTp8QncIEZ@robh.at.kernel.org>
References: <d428b90bb655c7992e9e13fc50130ed223812d2d.1628159456.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d428b90bb655c7992e9e13fc50130ed223812d2d.1628159456.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 12:31:00PM +0200, Mauro Carvalho Chehab wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds binding documentation to support USB HUB and
> USB data role switch of HiSilicon HiKey960 and HiKey970 boards.

Like PCIe, there's a standard way to describe USB devices in DT. Though 
PCI is easy compared to USB. :(

Also like PCIe on Hikey, I'm less than thrilled to define how this 
should look for a board that's generally not widely available or well 
supported.

> 
> [mchehab: updated OF names and added support for HiKey970]
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/misc/hisilicon,hikey-usb.yaml    | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> new file mode 100644
> index 000000000000..857f9bd802fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiKey960/970 onboard USB GPIO Hub
> +
> +maintainers:
> +  - John Stultz <john.stultz@linaro.org>
> +
> +description: |
> +  Supports the onboard USB GPIO hub found on HiKey960/970.
> +  The HUB, which acts as a role-switch intermediary to detect the state of
> +  the USB-C port, to switch the hub into dual-role USB-C or host mode,
> +  which enables the onboard USB-A host ports.
> +
> +  Schematics about the hub can be found here:
> +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> +    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,gpio_hubv1
> +      - hisilicon,kirin970_hikey_usbhub

s/_/-/

Why is one compatible pretty generic and the other very specific?

> +
> +  typec-vbus:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the typec-vbus gpio

If a GPIO, why is it not using a GPIO DT property?

> +
> +  otg-switch:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the otg-switch gpio

Ditto?

> +
> +  hub-vdd33-en:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the hub 3.3v power enablement gpio

GPIOs controlling a power rail should use a gpio-regulator.

> +
> +  hub_reset_en_gpio:

s/_/-/

And still, not a GPIO DT property...

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the hub reset gpio
> +
> +  usb-role-switch:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Support role switch.
> +
> +  hub-vdd-supply:
> +    description: regulator for hub power
> +
> +  port:
> +    description: |
> +      any connector to the data bus of this controller should be modelled
> +      using the OF graph bindings specified, if the "usb-role-switch"
> +      property is used. Note for this driver, two ports are supported,
> +      the first being the endpoint that will be notified by this driver,
> +      and the second being the endpoint that notifies this driver of a
> +      role switch.

You're describing this in terms of driver connections rather than h/w 
connections.

But we've already got ways to describe the data connections. For 
starters, it should be a child of the USB host.

And how does all this tie in with the USB connector binding?

> +
> +
> +required:
> +  - compatible
> +  - typec-vbus
> +  - otg-switch
> +  - usb-role-switch
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    hisi_hikey_usb: hisi_hikey_usb {
> +        compatible = "hisilicon,gpio_hubv1";
> +        typec-vbus = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> +        otg-switch = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +        hub-vdd33-en = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> +        usb-role-switch;
> +
> +        port {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            hikey_usb_ep0: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&dwc3_role_switch>;
> +            };
> +            hikey_usb_ep1: endpoint@1 {
> +                reg = <1>;
> +                remote-endpoint = <&rt1711h_ep>;
> +            };
> +        };
> +    };
> -- 
> 2.31.1
> 
> 
