Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92E317346
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhBJWXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:23:34 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38775 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBJWXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:23:24 -0500
Received: by mail-ot1-f41.google.com with SMTP id e4so3385325ote.5;
        Wed, 10 Feb 2021 14:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M6n3OYgGLF2v6o6pLcsl5i856+A/z2zBwf3QTH//u/w=;
        b=ngsYsDuSJbzdTp69W+3nXVIua/cOqOJRMIWl2o0+N5yzcz7Bow6TBzeF7Bq2clMWLN
         rtW5fFkuWarfH1qnAOT170Cbnn+3OlYVigOcujlILno9HcVScMtB80l6rP/tizVbiEWx
         pzGlbC0uBjNdeWTVh0g1r2Ij4WBnivQbm7j85PFkAX0nPmfXDmizlcLCeFtVaXVYt73F
         ZZXrD2QZKb9v/2E7E95Tx6wAWoOAfaCPFjGJIwB9raAkVhsl9ZkRJ5Vu46ZupKsWVL+x
         6bJ3UeKRQTbVXD7xqBYUK6/ZNF47B1erMhlK/wq8SC4NTN1jyy++hu3igw7cSEYR2kxW
         Rx2g==
X-Gm-Message-State: AOAM5312Y+gBB7zctBkwznj/LoM0VItRP/hqnpDBIwuJ49aPuuilqOBe
        BwjV8CTp41dP/YArXIDR0w==
X-Google-Smtp-Source: ABdhPJwJYPJGLTsZhzkvK1fZdQzPCEUL88/UW98cs/4NQlfUoYDPVDbNik0oj5mLTaWRzjM8wkG53g==
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr3626235oto.119.1612995763403;
        Wed, 10 Feb 2021 14:22:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m68sm669898otm.46.2021.02.10.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:22:42 -0800 (PST)
Received: (nullmailer pid 2911108 invoked by uid 1000);
        Wed, 10 Feb 2021 22:22:41 -0000
Date:   Wed, 10 Feb 2021 16:22:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb5744 hub
Message-ID: <20210210222241.GA2901449@robh.at.kernel.org>
References: <cover.1612867682.git.michal.simek@xilinx.com>
 <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:48:09AM +0100, Michal Simek wrote:
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> 
> Added dt binding for usb5744 driver.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2: None
> 
>  .../bindings/usb/microchip,usb5744.yaml       | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> new file mode 100644
> index 000000000000..fe222f6db81d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Bindings for the Microchip USB5744 4-port Hub Controller
> +
> +description:
> +  Microchip’s USB5744 SmartHub™ IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
> +  low power, low pin count configurable and fully compliant with the USB 3.1
> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
> +  (LS) USB signaling, offering complete coverage of all defined USB operating
> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
> +  USB 2.0 traffic.
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: microchip,usb5744
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Specifies the i2c slave address, it is required and should be 0x2d
> +      if I2C is used.

If I2C is not used, then this should be underneath the USB host as a USB 
device. That also implies a different compatible string. I'd suggest you 
just say I2C is required if that's your use.

'const: 0x2d' instead of maxItems is the schema to express the address 
if fixed.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      The phandle and specifier for the GPIO that controls the RESET line of
> +      USB hub.
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
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        usb5744@2d {
> +            compatible = "microchip,usb5744";
> +            reg = <0x2d>;
> +            reset-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41e8d3d7faec..7439471b5d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2697,6 +2697,7 @@ W:	http://wiki.xilinx.com
>  T:	git https://github.com/Xilinx/linux-xlnx.git
>  F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
>  F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> +F:	Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>  F:	arch/arm/mach-zynq/
>  F:	drivers/block/xsysace.c
>  F:	drivers/clocksource/timer-cadence-ttc.c
> -- 
> 2.30.0
> 
