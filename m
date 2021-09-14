Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839B40ADAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhINM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhINM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61CF86113E;
        Tue, 14 Sep 2021 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631622496;
        bh=KT5ep9K5oHPlf5qlK9bQ69cTC75IHh4Vyp7pNBmq2fA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUAizugV18Ufo0GaDfMyTSjKUezZ5c6uLdcg4f5Z8AGsjvED2JRzUEBPZAhLoRL5H
         fFLFkIaX3JeVgbKDcGA+wZLCM9oxmNRc92P+sby4MD5H7zJOMcgnHEFX1dRWVOSWqX
         sNSAP4juJtuHbwkhBHnclmJo4lbWhxXm67lum+yZJdHaNGuaHXisqPsnk8Xuo/9lxC
         IQnb6V+APRqGZVTAExrxMEKTi71ZgWv4KlrxIQ6s9wPM9i1lOzqGB9BPBZiaoJHvzu
         ban1uY4BcWE0r36uGTEBhxbZbfK8WdBa17nFihQLzk9pxGIXB7ZBW3epl88qzrYJND
         QFLs+6IThKzCA==
Received: by mail-ed1-f44.google.com with SMTP id j13so19573726edv.13;
        Tue, 14 Sep 2021 05:28:16 -0700 (PDT)
X-Gm-Message-State: AOAM5325JFcH2m0ibIYSMVZT9AIX+cuFrfrQZzPrw7DyUlYgCbkstZiJ
        gxa52+jtDrNzNI4OQwiUZQr8Jmddb2q8RvwgnA==
X-Google-Smtp-Source: ABdhPJytxCF6xzQ4OivyB+j0dZOQu/8MIbrRVs4+HSha9lJy7gCSxtdeC4zicGrmLhzwRTV8vQD4voa3E22Fj5k0XLw=
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr7862765edt.6.1631622494836;
 Tue, 14 Sep 2021 05:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210913060231.15619-1-chiawei_wang@aspeedtech.com> <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 07:28:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLr-fpgXPLU3XHy9T5hUNbf-mBqeh1Sads=tXWx3LkkhQ@mail.gmail.com>
Message-ID: <CAL_JsqLr-fpgXPLU3XHy9T5hUNbf-mBqeh1Sads=tXWx3LkkhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Oskar Senft <osk@google.com>, yulei.sh@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:02 AM Chia-Wei Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> Convert the bindings of Aspeed LPC from text file into YAML schema.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187 ++++++++++++++++++
>  2 files changed, 187 insertions(+), 157 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> deleted file mode 100644
> index 936aa108eab4..000000000000
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -======================================================================
> -Device tree bindings for the Aspeed Low Pin Count (LPC) Bus Controller
> -======================================================================
> -
> -The LPC bus is a means to bridge a host CPU to a number of low-bandwidth
> -peripheral devices, replacing the use of the ISA bus in the age of PCI[0]. The
> -primary use case of the Aspeed LPC controller is as a slave on the bus
> -(typically in a Baseboard Management Controller SoC), but under certain
> -conditions it can also take the role of bus master.
> -
> -The LPC controller is represented as a multi-function device to account for the
> -mix of functionality, which includes, but is not limited to:
> -
> -* An IPMI Block Transfer[2] Controller
> -
> -* An LPC Host Controller: Manages LPC functions such as host vs slave mode, the
> -  physical properties of some LPC pins, configuration of serial IRQs, and
> -  APB-to-LPC bridging amonst other functions.
> -
> -* An LPC Host Interface Controller: Manages functions exposed to the host such
> -  as LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART
> -  management and bus snoop configuration.
> -
> -* A set of SuperIO[3] scratch registers: Enables implementation of e.g. custom
> -  hardware management protocols for handover between the host and baseboard
> -  management controller.
> -
> -Additionally the state of the LPC controller influences the pinmux
> -configuration, therefore the host portion of the controller is exposed as a
> -syscon as a means to arbitrate access.
> -
> -[0] http://www.intel.com/design/chipsets/industry/25128901.pdf
> -[1] https://www.renesas.com/en-sg/doc/products/mpumcu/001/rej09b0078_h8s2168.pdf?key=7c88837454702128622bee53acbda8f4
> -[2] https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf
> -[3] https://en.wikipedia.org/wiki/Super_I/O
> -
> -Required properties
> -===================
> -
> -- compatible:  One of:
> -               "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon"
> -               "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon"
> -               "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon"
> -
> -- reg:         contains the physical address and length values of the Aspeed
> -                LPC memory region.
> -
> -- #address-cells: <1>
> -- #size-cells: <1>
> -- ranges:      Maps 0 to the physical address and length of the LPC memory
> -                region
> -
> -Example:
> -
> -lpc: lpc@1e789000 {
> -       compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
> -       reg = <0x1e789000 0x1000>;
> -
> -       #address-cells = <1>;
> -       #size-cells = <1>;
> -       ranges = <0x0 0x1e789000 0x1000>;
> -
> -       lpc_snoop: lpc-snoop@0 {
> -               compatible = "aspeed,ast2600-lpc-snoop";
> -               reg = <0x0 0x80>;
> -               interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> -               snoop-ports = <0x80>;
> -       };
> -};
> -
> -
> -LPC Host Interface Controller
> --------------------
> -
> -The LPC Host Interface Controller manages functions exposed to the host such as
> -LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART
> -management and bus snoop configuration.
> -
> -Required properties:
> -
> -- compatible:  One of:
> -               "aspeed,ast2400-lpc-ctrl";
> -               "aspeed,ast2500-lpc-ctrl";
> -               "aspeed,ast2600-lpc-ctrl";
> -
> -- reg:         contains offset/length values of the host interface controller
> -               memory regions
> -
> -- clocks:      contains a phandle to the syscon node describing the clocks.
> -               There should then be one cell representing the clock to use
> -
> -Optional properties:
> -
> -- memory-region: A phandle to a reserved_memory region to be used for the LPC
> -               to AHB mapping
> -
> -- flash:       A phandle to the SPI flash controller containing the flash to
> -               be exposed over the LPC to AHB mapping
> -
> -Example:
> -
> -lpc_ctrl: lpc-ctrl@80 {
> -       compatible = "aspeed,ast2500-lpc-ctrl";
> -       reg = <0x80 0x80>;
> -       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> -       memory-region = <&flash_memory>;
> -       flash = <&spi>;
> -};
> -
> -LPC Host Controller
> --------------------
> -
> -The Aspeed LPC Host Controller configures the Low Pin Count (LPC) bus behaviour
> -between the host and the baseboard management controller. The registers exist
> -in the "host" portion of the Aspeed LPC controller, which must be the parent of
> -the LPC host controller node.
> -
> -Required properties:
> -
> -- compatible:  One of:
> -               "aspeed,ast2400-lhc";
> -               "aspeed,ast2500-lhc";
> -               "aspeed,ast2600-lhc";
> -
> -- reg:         contains offset/length values of the LHC memory regions. In the
> -               AST2400 and AST2500 there are two regions.
> -
> -Example:
> -
> -lhc: lhc@a0 {
> -       compatible = "aspeed,ast2500-lhc";
> -       reg = <0xa0 0x24 0xc8 0x8>;
> -};
> -
> -LPC reset control
> ------------------
> -
> -The UARTs present in the ASPEED SoC can have their resets tied to the reset
> -state of the LPC bus. Some systems may chose to modify this configuration.
> -
> -Required properties:
> -
> - - compatible:         One of:
> -                       "aspeed,ast2600-lpc-reset";
> -                       "aspeed,ast2500-lpc-reset";
> -                       "aspeed,ast2400-lpc-reset";
> -
> - - reg:                        offset and length of the IP in the LHC memory region
> - - #reset-controller   indicates the number of reset cells expected
> -
> -Example:
> -
> -lpc_reset: reset-controller@98 {
> -        compatible = "aspeed,ast2500-lpc-reset";
> -        reg = <0x98 0x4>;
> -        #reset-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> new file mode 100644
> index 000000000000..4e3862cf2a4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -0,0 +1,187 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2021 Aspeed Tehchnology Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Low Pin Count (LPC) Bus Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description:
> +  The LPC bus is a means to bridge a host CPU to a number of low-bandwidth
> +  peripheral devices, replacing the use of the ISA bus in the age of PCI[0]. The
> +  primary use case of the Aspeed LPC controller is as a slave on the bus
> +  (typically in a Baseboard Management Controller SoC), but under certain
> +  conditions it can also take the role of bus master.
> +
> +  The LPC controller is represented as a multi-function device to account for the
> +  mix of functionality, which includes, but is not limited to
> +
> +  * An IPMI Block Transfer[2] Controller
> +
> +  * An LPC Host Interface Controller manages functions exposed to the host such
> +    as LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART
> +    management and bus snoop configuration.
> +
> +  * A set of SuperIO[3] scratch registers enableing implementation of e.g. custom
> +    hardware management protocols for handover between the host and baseboard
> +    management controller.
> +
> +  Additionally the state of the LPC controller influences the pinmux
> +  configuration, therefore the host portion of the controller is exposed as a
> +  syscon as a means to arbitrate access.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2400-lpc-v2
> +          - aspeed,ast2500-lpc-v2
> +          - aspeed,ast2600-lpc-v2
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^lpc-ctrl@[0-9a-f]+$":
> +    type: object
> +
> +    description:
> +      The LPC Host Interface Controller manages functions exposed to the host such as
> +      LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART management
> +      and bus snoop configuration.
> +
> +    properties:
> +      comptabile:

typo here. This is the source of your warnings.

Rob
