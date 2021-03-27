Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68934B7E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC0PSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 11:18:09 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39588 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0PRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:17:50 -0400
Received: by mail-oi1-f180.google.com with SMTP id i81so8819744oif.6;
        Sat, 27 Mar 2021 08:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HR93ICa3yWJ7V2cU1aVAOQYhP6ybWqoIXcHtKx1QIgQ=;
        b=h9VKXn/mGFvqhdgza2zTIl5+culRmIrm1B87cHRrrXzn8iEAwktaqdGCx9BfAl1ZEA
         3rfH4QOE6XqdApSKVPJLaw+R152DQMnM2VlQlv79lPGWZCPPmFLZokH8ds32kYynpAVY
         KMIR2+A4Ix93bnFyK/J3kAF4qMDUFjtIe7WFu1Pp/Dmscsvgc1kvbUBxM/RFIa+rJRWQ
         Hmd7mwE7nzTZTBCpcr2cY43DYfFPPbtk8ShmuQF0gky1gy7o2RmBPxCVOAp56SvIkdfH
         se7XbrysWpa43Pr+9RwQwWTNpPW3t7JKt3FtdswKitSJPm4LJUcxBet77/rjLqYVeS0z
         gHZw==
X-Gm-Message-State: AOAM531PQnQcLc/nBdqCnSXbHO1TUkek9fFyuNX+/xP0ITxoNGBNWcuK
        zIdw/k24OmVWlykLQN3BLQ==
X-Google-Smtp-Source: ABdhPJyhJgJk5T983JkfRGYT5rufgWLi8CcYeyyNcLoqA30snh0E1m4zh9EiHg9k4fMBoQ6nAHQluw==
X-Received: by 2002:aca:3788:: with SMTP id e130mr13252828oia.45.1616858270409;
        Sat, 27 Mar 2021 08:17:50 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.102.185])
        by smtp.gmail.com with ESMTPSA id l191sm2410902oih.16.2021.03.27.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:17:49 -0700 (PDT)
Received: (nullmailer pid 131094 invoked by uid 1000);
        Sat, 27 Mar 2021 15:14:33 -0000
Date:   Sat, 27 Mar 2021 09:14:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <20210327151433.GA121810@robh.at.kernel.org>
References: <20210326015511.218-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326015511.218-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:55:07PM -0400, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
> v3:
>  - No change
> v2:
>  - N/A
> 
>  .../bindings/mfd/silergy,sy7636a.yaml         | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> new file mode 100644
> index 000000000000..f260a8eae226
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> @@ -0,0 +1,63 @@
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
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#

This isn't right as the actual regulators are child nodes of 
'regulators'. So you need another level defined here.

This node should also have 'additionalProperties: false' which will 
highlight the errors here.

> +
> +    properties:
> +      compatible:
> +        const: silergy,sy7636a-regulator
> +
> +      regulator-name:
> +        pattern: "vcom"

Not a pattern. Use 'const'.

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
> +      sy7636a@62 {

pmic@62

> +        compatible = "silergy,sy7636a";
> +        reg = <0x62>;
> +        status = "okay";
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
> 2.31.0
> 
