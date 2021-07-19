Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86F3CDF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbhGSPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:09:58 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:41840 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhGSOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:43:37 -0400
Received: by mail-il1-f175.google.com with SMTP id p3so16305139ilg.8;
        Mon, 19 Jul 2021 08:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzERivZqSSJFIGeAmgTC/Nw6CzI7ObBqzkfLEHhPO/w=;
        b=R2idV5CPpdq41/jv8XCr25KVn6FDSxXoiutD3JoYNgI78dBqAPrsDURWDImKDTBZBs
         YbB75ZIs4bLDthDqyCWZiuDzr3YgBhlrAjaOTHRERv0K1pBcmwoNbsHkvTAcc05H1gS1
         e6hwU/Khd9/8ol9sbKQt7GGLi39cQEV6V0cSUKAYvKKCJ3QLV7T6J0k1Q9rN7iwNPyaM
         rBLWYAZ2JC+vjC9HuzVIxmyv3QlWv9f4fFFrAK+useu+PSW9AheGG3yKfbrg35VaR9vi
         5zmxhQ/nsSI70tQlFL/GxuSIVaMam4MBTclHAvpTEz9DC7CQ81oU3t77nUBm98qUJPtU
         22Bw==
X-Gm-Message-State: AOAM532SDF+WKSWg1QLC8Uqt9p2c6DHcWTedT0k5V8QAgz4VGmauGJ3v
        W45exn2wwKaBY6TKeEzAaw==
X-Google-Smtp-Source: ABdhPJyri+TXCyr4MCEpKVVzSSJx361AXYHcpD9imtD5zPDRk+xQaRGiGAFQK3C6ytmqRK551Sb+Kg==
X-Received: by 2002:a92:d251:: with SMTP id v17mr16834647ilg.283.1626708256258;
        Mon, 19 Jul 2021 08:24:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u10sm5867563iop.15.2021.07.19.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:24:15 -0700 (PDT)
Received: (nullmailer pid 1961107 invoked by uid 1000);
        Mon, 19 Jul 2021 15:24:13 -0000
Date:   Mon, 19 Jul 2021 09:24:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
Message-ID: <20210719152413.GA1953551@robh.at.kernel.org>
References: <20210718004125.733-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718004125.733-1-a-nandan@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:41:25AM +0000, Apurva Nandan wrote:
> Convert spi-nand.txt binding to YAML format with an added example.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>  .../devicetree/bindings/mtd/spi-nand.yaml     | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> deleted file mode 100644
> index 8b51f3b6d55c..000000000000
> --- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -SPI NAND flash
> -
> -Required properties:
> -- compatible: should be "spi-nand"
> -- reg: should encode the chip-select line used to access the NAND chip
> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> new file mode 100644
> index 000000000000..366b86e1b19c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI NAND flash
> +
> +maintainers:
> +  - Apurva Nandan <a-nandan@ti.com>
> +
> +allOf:
> +  - $ref: "mtd.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: spi-nand

Drop 'oneOf' as there is only one.

> +
> +  reg:
> +    items:
> +      description:
> +        should encode the chip-select line used to access the NAND chip

Just:

reg:
  maxItems: 1

> +
> +  spi-max-frequency: true
> +  spi-rx-bus-width: true
> +  spi-tx-bus-width: true
> +
> +  partitions:
> +    type: object
> +
> +  '#address-cells': true
> +  '#size-cells': true
> +
> +patternProperties:
> +  # Note: use 'partitions' node for new users
> +  '^partition@':
> +    type: object
> +
> +  "^otp(-[0-9]+)?$":
> +    type: object
> +
> +additionalProperties: false

Just do:

additionalProperties:
  type: object

and then drop partitions, partition@, and ^otp(-[0-9]+)?$.

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@6 {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            compatible = "spi-nand";
> +            reg = <0x6>;
> +            spi-max-frequency = <42000000>;
> +
> +            partitions {
> +                compatible = "fixed-partitions";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                partition@0 {
> +                    label = "boot";
> +                    reg = <0 0x200000>;
> +                };
> +
> +                partition@200000 {
> +                    label = "rootfs";
> +                    reg = <0x200000 0xce0000>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
