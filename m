Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5D4169AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbhIXBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbhIXBzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:55:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8F8C061574;
        Thu, 23 Sep 2021 18:54:19 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso11132836otc.9;
        Thu, 23 Sep 2021 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZ7iH6Q8l67sPv3mVUusPpqoviodZTEfInAFFD0to5g=;
        b=bmJOJ8D4fN5cUpbZE+wUjqNj6kd0TMsZG5DjBjwGT/U831siTueRpCF8CsqTFR6NXP
         QsJiw7JcNm5+xH+ZCnJhC4CO2Mop1bIz0/RPTDqEzYtlhfTXDtwRPlvfpZsH/nPr81Tq
         MYcSdOFY9cRV9zb5ufjPjeZoVC+UiNZW+WGLDTumczpylNokKHAnoFQFlTBhXXnYJ+rf
         s1AQCYTOm2r43XVjcKZ8qLLvlOyGsitgtsnGX2BI8+3SxCAxXPkTm8sMyBsqU4q7X+p2
         eLKeDnvtbox0NKdBqcGBi7F+cuqffJ7ciHBsp6B08uBlluNFGPRpW8rtQWtCAHhdgbZ6
         bkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eZ7iH6Q8l67sPv3mVUusPpqoviodZTEfInAFFD0to5g=;
        b=iAq7fSU8QbKT+CQDIYA6UEiSNp1Q0Y2G0mYQlo+K4uAF6okZoslt6nESMp1nmCxosX
         2Ci/RR12e0z5INUIejf8nxgjSWN8RfzcMcd5VJ6MMFKpcKdHQTGqO6t1GnMRP7EKeUxN
         FKBJiHozN5qitwZTcyXjCr/Ak/L5WSGpKWbYae+khWHupifHu5FDalugPiVHMM5Bl1Sl
         /TE0yrZAuXxrajijmgNog6nqWIwbPoBzYoeWoIsGdnfGebf14RtkG60fe6/+/tI338EI
         u3bOxCD8OBhzbrbiD53jXsRL+o5w+IGBSvhd7CGqN62pwQMdSCNneuvhPfwgm/VoAE1V
         6IKw==
X-Gm-Message-State: AOAM5329kM5qbMYVpreMiyy3/Rgf4GvljVIsLDCrL/keKK/bGR+uoqzD
        xJaEWJEkYQpsE/g4pgTNZnc=
X-Google-Smtp-Source: ABdhPJxsZno9TR1s7LghbC1zEKNP9FZnT5qe3iCwsqU5kygZ+JaJaV7hAWJ85B/ytaGZa7apn468lw==
X-Received: by 2002:a9d:719a:: with SMTP id o26mr1713249otj.278.1632448458901;
        Thu, 23 Sep 2021 18:54:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g23sm1697785otl.23.2021.09.23.18.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:54:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:54:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: hwmon: ti,tmp102: add bindings and
 remove from trivial devices
Message-ID: <20210924015417.GA3030874@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:28:28PM +0200, Krzysztof Kozlowski wrote:
> The TI TMP102 temperature sensor does not fit into trivial devices
> bindings due to additional properties.  Add separate bindings for it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ti,tmp102.yaml  | 47 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> new file mode 100644
> index 000000000000..d3eff4fac107
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMP102 temperature sensor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmp102
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@48 {
> +            compatible = "ti,tmp102";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpio7>;
> +            interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +            #thermal-sensor-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index c9333fb81fdf..6ad0628741cf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -317,8 +317,6 @@ properties:
>              # I2C Touch-Screen Controller
>            - ti,tsc2003
>              # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> -          - ti,tmp102
> -            # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>            - ti,tmp103
>              # Thermometer with SPI interface
>            - ti,tmp121
