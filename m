Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3251439C127
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFDUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:20:31 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:37637 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:20:30 -0400
Received: by mail-oo1-f47.google.com with SMTP id t6-20020a4ae9a60000b0290245a5133898so2529591ood.4;
        Fri, 04 Jun 2021 13:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MCfv6fQHDee2XjvXSHxeG0uhLM30iPs27L6wPGcgAxs=;
        b=o0eAe56daEXySaaYE0QewKHE7uCfnN+z55S5paL3Xj6pZidRu4Zr7+WNKR/DJ3tcjW
         ZnvobxiymSuOyyBmu6EvRZppVUr3Rlc21xfiWX2uwqsz32oNIlCqL9yR3a82BOnyrjV8
         zInadxuEUuTvAKbiutAZ1GSJ2yChGr9yyy87VGJ610evG+cZONsNEUiPr46PlW8Kmluy
         DHN3Jk7lRV0bulkd7ZMwbCKDvWmpHCsg4Oh5r66KZASSNEnmFs8UJ1s2ji1eAOtwsrOy
         O4nOGen1tVzoXEtq6ngOwkdDmxYghwS3JOVypUVdq0Wl5WKX8eQ/8AhQpiUEy5Tc7zKu
         HFpw==
X-Gm-Message-State: AOAM53150WEN1SxYUkRD+/JimTSyfCzR6BZgXRfEYrj4JUEsA6+jefKY
        9Om1I79qJUtN+jj+9UGisrF35vDPLw==
X-Google-Smtp-Source: ABdhPJzRJDPfmgAea9/YY0WQx51jKCVAWE652ExVRIuOi+o8jdXEwJqKDYUFtdgGhgxX1EY+ifs3dQ==
X-Received: by 2002:a4a:5246:: with SMTP id d67mr4967125oob.33.1622837923378;
        Fri, 04 Jun 2021 13:18:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f2sm634713ooj.22.2021.06.04.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:18:42 -0700 (PDT)
Received: (nullmailer pid 3843001 invoked by uid 1000);
        Fri, 04 Jun 2021 20:18:41 -0000
Date:   Fri, 4 Jun 2021 15:18:41 -0500
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
Subject: Re: [PATCH 1/2] dt-bindings: Add SONY Synaptics JDI panel
Message-ID: <20210604201841.GA3834184@robh.at.kernel.org>
References: <20210525113105.52990-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525113105.52990-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:31:02PM +0200, Konrad Dybcio wrote:
> Add bindings for the SONY Synaptics JDI panel used in
> Xperia X, X Performance, X Compact, XZ and XZs smartphones.
> 
> Due to the nature of phone manufacturing and lack of any docs
> whatsoever, replacement names have been used to indicate the
> devices that this panel is used on.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
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

Do you need the formatting? If not, drop '|+'.

> +  This panel seems to only be found in SONY Xperia
> +  X, X Performance, X Compact, XZ and XZs
> +  smartphones and we have no straightforward way of
> +  actually getting the correct model number,
> +  as no schematics are released publicly.

Odd choice of line break length. 80 char please.

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
> +    description: panel reset pin

What's reset-gpios then?

> +
> +  pvddio-gpio:
> +    description: panel vddio pin
> +
> +  treset-gpio:
> +    description: touch reset pin

Use '-gpios'

And need to define how many (maxItems: 1).

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
> +                      panel_in: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                      };

Consistent indentation please. 4 spaces is good.

> +                    };
> +            };
> +    };
> -- 
> 2.31.1
