Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BE3AA798
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhFPXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:42:29 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:33539 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhFPXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:42:22 -0400
Received: by mail-il1-f181.google.com with SMTP id z1so3873389ils.0;
        Wed, 16 Jun 2021 16:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDYnmGlkYP2XTjPyujeKcLs7zkGku54gbQ2xEMwMzGQ=;
        b=qmgjgw0zjwg1V8cyRGVmQj4yMw9dEausOXPT9map8w8YvYSDLVBbXMWl+4bFzCdxur
         qFowg6KVIfal0UNUmXWCiZJPru9tRAQPv+I4icqMIwRq/chjLDkpMTM83GwJpP6EGS8m
         S4yfWKsLV1VfqFNfuHmKrCzfLv2jzRREOwUrwjVD7tbAKZk7j5c3rpv2+hf252iOZ/Qm
         n27X6lBDTinivNc1GYyI3NmM7VfoIxHNFDL9SwSu1znLrh3XY3/FmmfgHd2qAuwfB8G+
         VR9raEbgrrCtMsj6HJRWAJDBDJrjsc75UG0cerihu+x80CGxUd92lvVOWAoP86Ok1qlo
         JCcg==
X-Gm-Message-State: AOAM533gcCUNDoRmy7IOCfCjnik85jONIjaSB0qdtsiotKbGTGvyr4Lb
        41Gho4XVBqfn+LqQlwC+VQ==
X-Google-Smtp-Source: ABdhPJxOVFOvxO+PfGwlEWm+SVTL4u/1b9+xCOaQxsYMANRsvdRArIUQpQn2YsRYLvV0yG3lnEellA==
X-Received: by 2002:a92:bf10:: with SMTP id z16mr1547434ilh.304.1623886814437;
        Wed, 16 Jun 2021 16:40:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h7sm1866831ilr.44.2021.06.16.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:40:13 -0700 (PDT)
Received: (nullmailer pid 300348 invoked by uid 1000);
        Wed, 16 Jun 2021 23:40:11 -0000
Date:   Wed, 16 Jun 2021 17:40:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Add SONY Synaptics JDI panel
Message-ID: <20210616234011.GA295646@robh.at.kernel.org>
References: <20210605104942.39487-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605104942.39487-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 12:49:40PM +0200, Konrad Dybcio wrote:
> Add bindings for the SONY Synaptics JDI panel used in
> Xperia X, X Performance, X Compact, XZ and XZs smartphones.
> 
> Due to the nature of phone manufacturing and lack of any docs
> whatsoever, replacement names have been used to indicate the
> devices that this panel is used on.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - gpio -> gpios
> - description: |+ -> description: |
> - remove redundant reset-gpio
> - fix up indentation in the example
> 
>  .../display/panel/sony,synaptics-jdi.yaml     | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sony,synaptics-jdi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,synaptics-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,synaptics-jdi.yaml
> new file mode 100644
> index 000000000000..81d841c049e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sony,synaptics-jdi.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,synaptics-jdi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SONY Synaptics JDI panel
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
> +
> +description: |+
> +  This panel seems to only be found in SONY Xperia
> +  X, X Performance, X Compact, XZ and XZs
> +  smartphones and we have no straightforward way of
> +  actually getting the correct model number,
> +  as no schematics are released publicly.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sony,synaptics-jdi-dora
> +          - sony,synaptics-jdi-kagura
> +          - sony,synaptics-jdi-keyaki
> +          - sony,synaptics-jdi-kugo
> +          - sony,synaptics-jdi-suzu
> +
> +  reg: true
> +
> +  reset-gpios: true
> +
> +  avdd-supply:
> +    description: avdd supply
> +
> +  vddio-supply:
> +    description: vddio supply
> +
> +  vsn-supply:
> +    description: voltage negative supply
> +
> +  vsp-supply:
> +    description: voltage positive supply
> +
> +  tvdd-supply:
> +    description: tvdd supply
> +
> +  preset-gpio:

'-gpios' is the preferred form.

And needs 'maxItems: 1'

> +    description: panel reset pin
> +
> +  pvddio-gpio:
> +    description: panel vddio pin
> +
> +  treset-gpio:
> +    description: touch reset pin

Same for these.

> +
> +required:
> +  - compatible
> +  - reg
> +  - preset-gpio
> +  - pvddio-gpio
> +  - treset-gpio
> +  - avdd-supply
> +  - vddio-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - tvdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            panel: panel@0 {
> +                    reg = <0>;
> +

Missing a compatible which means the above schema is never applied...

> +                    pvddio-gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
> +                    preset-gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
> +                    treset-gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
> +
> +                    vddio-supply = <&pm8994_s4>;
> +                    avdd-supply = <&pm8994_l2>;
> +                    tvdd-supply = <&panel_tvdd>;
> +
> +                    backlight = <&pmi8994_wled>;
> +
> +                    port {

and that would point out this is not documented. 

> +                      panel_in: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                      };
> +                    };
> +            };
> +    };
> -- 
> 2.31.1
