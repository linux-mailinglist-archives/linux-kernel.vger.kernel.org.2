Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5B3B3837
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhFXU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:58:50 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38900 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhFXU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:58:48 -0400
Received: by mail-io1-f50.google.com with SMTP id k11so9981583ioa.5;
        Thu, 24 Jun 2021 13:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AwKzwVZyZHTmtCuefIf9ZctjwvA1YdIvDb/Jjt0151Y=;
        b=a+kfwXf7Iv2Jg4WPU0w/9EUscV4zGtCRAX4a8/ws8cfE5a6JG3MqkqSI3umdvpaRUS
         w2jas7HgtIf+JwsjcZ7vE5BhHk/bjDs/n8hYGdAh0fKUAXOt6N/o96PQO1OT2YOGsF39
         mvspfSJxJLZz2dWFKENauFFbm/KAB1CjrOEh20K7Dw1YhStAqbk4w2dapRZKs9sH++L7
         qdFM4/WdrGW0cQ8orgwOmus+O8c3Sw98vTTfUPcti8dNInJ5/NpuGQVVwBIwrL9fvNe0
         YzQXgIRLv52rHuHqXuwhjm/BQVt0bLvxger94zLxO+T2PlnWhDCbTbXoS6RYRFaNZfat
         v34Q==
X-Gm-Message-State: AOAM5310XWZphGH2XCfts3spcli4xXguudovpi/Ap+iNztpZ4tvwZXZD
        1Q1E6n2sADCHpDfZfv75aQ==
X-Google-Smtp-Source: ABdhPJzSnzjuSPNk+15BYzQuFXuFQ77PQGJHmcrRrpWubR8bkwxHWRKW397mBo0RCO37kVQl/3+4aA==
X-Received: by 2002:a6b:760e:: with SMTP id g14mr5622985iom.119.1624568187189;
        Thu, 24 Jun 2021 13:56:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b23sm1978903ior.4.2021.06.24.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:56:26 -0700 (PDT)
Received: (nullmailer pid 1973492 invoked by uid 1000);
        Thu, 24 Jun 2021 20:56:22 -0000
Date:   Thu, 24 Jun 2021 14:56:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v6 1/5] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <20210624205622.GA1968619@robh.at.kernel.org>
References: <20210615103400.946-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615103400.946-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:33:56PM +1000, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/mfd/silergy,sy7636a.yaml         | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> new file mode 100644
> index 000000000000..9e50f57d5e8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/silergy,sy7636a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: silergy sy7636a PMIC
> +
> +maintainers:
> +  - Alistair Francis <alistair@alistair23.me>
> +
> +properties:
> +  compatible:
> +    const: silergy,sy7636a
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +  epd-pwr-good-gpios:
> +    description:
> +      Specifying the power good GPIOs. As defined in bindings/gpio.txt.

Drop the 2nd sentence.

> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: silergy,sy7636a-regulator
> +
> +      "vcom":

Don't need quotes.

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +
> +      regulator-name:
> +        const: "vcom"

Don't need quotes.

Doesn't this belong in the 'vcom' node? You need another 'properties' 
and this under it.


> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@62 {
> +        compatible = "silergy,sy7636a";
> +        reg = <0x62>;
> +        status = "okay";

Don't show status in examples.

> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_epdpmic>;
> +        #thermal-sensor-cells = <0>;
> +
> +        regulators {
> +          compatible = "silergy,sy7636a-regulator";
> +          reg_epdpmic: vcom {
> +            regulator-name = "vcom";
> +            regulator-boot-on;
> +          };
> +        };
> +      };
> +    };
> +...
> -- 
> 2.31.1
> 
> 
