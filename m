Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D984D3C7932
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhGMVtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:49:53 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34375 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:49:52 -0400
Received: by mail-io1-f43.google.com with SMTP id g22so29168212iom.1;
        Tue, 13 Jul 2021 14:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzr1EzVc2M1m4gRYRp5G50037Vri23Gnx2SLxj/9HEU=;
        b=eq/eE2GAntstVT9rZPUos31QhlJ9eH6bZe5gmgaFjIK9jzfrZP/YKlWEd+387H6iHN
         6WbRzrdxNFnnQp2sLy7/hL5flnten1dg+1n9Xt3Q3N6e0nFfG0es07EnZuxjolmziFQd
         416G2JHK+2KWMxgjxuQLwEz5S9h1cwJxXnpkFCQmoXr2axXpYqDR7eU8853YL1q4AwT5
         pdhSKYspmPd6wUF83fRSMJ82Li4ghCx3DI7XF6Pf+gdL7rb4Th4G1bj4F+Dl0mbc/HBu
         UKhCXs6cd/Z2bMVXDpzT55Rt84e2fvn9rB3NQI6iIlcLVWamvqqWQMvsm42ilVLQ5uJQ
         Sxow==
X-Gm-Message-State: AOAM533MFvq5GXdnqXhE+1ycQm71r9ufMEH0H1+LtxIMYpZxVwHG+d1q
        50WPVqBy5barVHl/gdCxxA==
X-Google-Smtp-Source: ABdhPJz+8SdCViluK/4UrT4lxgcuvtsyPOZKhMusB8P4wcWnnHFQTR7VaLImLT2hOv2f8PMHbQOxJg==
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr4758762iol.53.1626212821532;
        Tue, 13 Jul 2021 14:47:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y13sm14314ioa.51.2021.07.13.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 14:47:00 -0700 (PDT)
Received: (nullmailer pid 895283 invoked by uid 1000);
        Tue, 13 Jul 2021 21:46:59 -0000
Date:   Tue, 13 Jul 2021 15:46:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: rtq6752: Add binding document for Richtek
 RTQ6752
Message-ID: <20210713214659.GA892012@robh.at.kernel.org>
References: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 11:40:35PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add binding document for Richtek RTQ6752.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rtq6752-regulator.yaml       | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
> new file mode 100644
> index 00000000..641840e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rtq6752-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RTQ6752 TFT LCD Voltage Regulator
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RTQ6752 is an I2C interface pgorammable power management IC. It includes
> +  two synchronous boost converter for PAVDD, and one synchronous NAVDD
> +  buck-boost. The device is suitable for automotive TFT-LCD panel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rtq6752
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: |
> +      A connection of the chip 'enable' gpio line. If not provided, treat it as
> +      external pull up.
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    $ref: regulator.yaml#

This node is not a regulator, just a container. Drop.

> +
> +    patternProperties:
> +      "^(p|n)avdd$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          regulator description for pavdd and navdd.
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rtq6752@6b {
> +        compatible = "richtek,rtq6752";
> +        status = "okay";

Don't show status in examples.

> +        reg = <0x6b>;
> +        enable-gpios = <&gpio26 2 0>;
> +
> +        regulators {
> +          pavdd {
> +            regulator-name = "rtq6752-pavdd";
> +            regulator-min-microvolt = <5000000>;
> +            regulator-max-microvolt = <7300000>;
> +            regulator-boot-on;
> +          };
> +          navdd {
> +            regulator-name = "rtq6752-navdd";
> +            regulator-min-microvolt = <5000000>;
> +            regulator-max-microvolt = <7300000>;
> +            regulator-boot-on;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.7.4
> 
> 
