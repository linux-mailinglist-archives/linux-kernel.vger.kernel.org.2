Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235143986E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFBKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFBKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:49:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78799C06138C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:47:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f2so1774996wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UfjIM+LI/qydiCGlRftPibFreQGOXtbFtxYa4Sx2Hfg=;
        b=xnevntkI/dNZ2dwhnG2Jzo8x5HDNuXJ00GF90aCoRQp5Q3NmcUNyPvXmsrVXZ0b8q7
         EfpIosGirJyjNr9HLTMcLJR6fvmmCHTTE3xwymcHNRciBWPZru8sAnZEeIW65qmdIvqQ
         fqQ83mtm0koBI29lngVErjZFDcePOeB4LFV1au84a5pVstqYpiKptHtUdSfdTmRP6eMv
         WPOX9vs60nFjV6gz4D1462lLnqLmHTjaG44+aVsngHjOgYi/4Qo8qs2HDxczkDVWeCHX
         0U57h9qBKiZnbGiZlo0ITGsjFPaxY1cGZnHmdz96/s9GrdrkvsNoRLX6CY8t8mocom+/
         XTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UfjIM+LI/qydiCGlRftPibFreQGOXtbFtxYa4Sx2Hfg=;
        b=deqAw/vNYbej1PjNY+lqFnvYKHDa5QlmbBhDIHWI03vHfP+HcpD3BwVHbhGcW7getr
         Hk5FKQFqeIw6+WytgAulqoG67SL1D8cMotM6fsg83QYfEzfP3D+WNrALF0iVmKUeja+f
         zRq/WEloR1q3EbfWcsuUoQ45Tb3XXbCWYvIajjbqAAI4fc1Z9awCe1hQXXGiIBxmA+dT
         kCeaWaHF9a7ICkzBE2YYLTpba/SwBJD/zLLeYVck28LylSYwz0Jk3EbjAAs5EDEcirBp
         dOlHgeK7SgM/LM9nk9mKOWxe/Y8gU9ttwZytF8kdFm57KxHjE7HUzGDCnRdVvrUi9E2z
         PfQA==
X-Gm-Message-State: AOAM532NU1BK06eVB8IE7V2ISfbMxS4EEIVDuaYYdBydmU5vBdVy52wb
        FWZEsSYZzT+KZJRTIgGVOuGa5g==
X-Google-Smtp-Source: ABdhPJyfaHxb7cFtFnnTd/H6CkWsGTGR4AZAdxMIa76jXZC2diKeRoEjb7sA6U3fvRWhMPn9LDDLXA==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr33014640wrr.218.1622630842042;
        Wed, 02 Jun 2021 03:47:22 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id 31sm7015444wrc.96.2021.06.02.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:47:21 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:47:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, luka.perkov@sartura.hr,
        jmp@epiphyte.org, pmenzel@molgen.mpg.de, buczek@molgen.mpg.de
Subject: Re: [PATCH v3 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers
 bindings
Message-ID: <20210602104719.GI2173308@dell>
References: <20210531125143.257622-1-robert.marko@sartura.hr>
 <20210531125143.257622-5-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531125143.257622-5-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021, Robert Marko wrote:

> Add binding documents for the Delta TN48M CPLD drivers.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> * Include bindings for reset driver
> 
> Changes in v2:
> * Implement MFD as a simple I2C MFD
> * Add GPIO bindings as separate
> 
>  .../bindings/gpio/delta,tn48m-gpio.yaml       | 42 +++++++++
>  .../bindings/mfd/delta,tn48m-cpld.yaml        | 90 +++++++++++++++++++
>  .../bindings/reset/delta,tn48m-reset.yaml     | 35 ++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
>  create mode 100644 Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml

> +++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/delta,tn48m-cpld.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Delta Networks TN48M CPLD controller
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  Lattice CPLD onboard the TN48M switches is used for system
> +  management.
> +
> +  It provides information about the hardware model, revision,
> +  PSU status etc.
> +
> +  It is also being used as a GPIO expander for the SFP slots and
> +  reset controller for the switch MAC-s and other peripherals.
> +
> +properties:
> +  compatible:
> +    const: delta,tn48m-cpld
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:
> +  "^gpio(@[0-9a-f]+)?$":
> +    $ref: ../gpio/delta,tn48m-gpio.yaml
> +
> +  "^reset-controller?$":
> +    $ref: ../reset/delta,tn48m-reset.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cpld@41 {
> +            compatible = "delta,tn48m-cpld";
> +            reg = <0x41>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            gpio@31 {
> +                compatible = "delta,tn48m-gpio-sfp-tx-disable";
> +                reg = <0x31>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            gpio@3a {
> +                compatible = "delta,tn48m-gpio-sfp-present";
> +                reg = <0x3a>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            gpio@40 {
> +                compatible = "delta,tn48m-gpio-sfp-los";
> +                reg = <0x40>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            reset-controller {
> +              compatible = "delta,tn48m-reset";
> +              #reset-cells = <1>;
> +            };

How is the Reset component addressed?

> +        };
> +    };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
