Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D3416944
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhIXBNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:13:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DCC061574;
        Thu, 23 Sep 2021 18:11:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so4162362otv.4;
        Thu, 23 Sep 2021 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MxDtpUjEKo8kqRtDSEa0VC2kT6csU3vX3PxoHUzEVys=;
        b=lZTsLyBURwTrxfoxlaW7/mmme2DMEm99v2X6w3AAheJUt4IunbUdpap+0UIDLa1JpM
         0+EPTA+zjtAHOqudXy9pFULZGl09euwo7KIb+7UOSL+nlCmkWoBq1niqhEfwJrC40BfB
         tE8iwHj8deuk0WxTKLv8swzmuij9yVGbMWLdMzUVm4on9hU8/KVX3r3wv6yfQMvje0TI
         1pwLHuj9clwSytLoHt6tivu422KXtD+Urh2JsxE2I+LKEJJg7PGAPLy5/Y3YbND5T98x
         HZOCK+ShctvovNX63qhXsVx4rrVEWsXPBoR0o3oFfQQslmFWKaA2q9LrbmupV7ZeiPbF
         Q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MxDtpUjEKo8kqRtDSEa0VC2kT6csU3vX3PxoHUzEVys=;
        b=RQktmV/TYCnFTIu2DkMOARYQjb4X9whkN2qBQrR0ZyLIYUtrvc0JPWvFgzxL+vp+MY
         x6mpsIflrYPzc6Z2ipJuOcWHT5N5kBHu+HkJ+ivltglM2FJP+jWcKO5jwuBZZ68Pqq+p
         JE3ROTLvtL8Ij2lZJcSF/jVksw1j/OrPBXwql8Y5aw/ohejt6qVVYH/s825/Q87KqOok
         0Jklu2jtuL6+3BfN9pf7KZkqUh1p6Q6j5lKcHs0BZSky37M08R6eypNF+dgZolePDQIY
         3nE1VAHPl2CCYOpgH+0uiKC/FB/AHqsV8a+Yg/XgfdedeccYMQov8JyBJK0Df1gxcy1J
         VJcg==
X-Gm-Message-State: AOAM532dhCig/bXEcxq0kSMuHXbEsGili9JsxC9g09ndqXlJ/zQba65a
        nazsT5TerTR/aeWbewGddlC9UKrVXa0=
X-Google-Smtp-Source: ABdhPJxvotrPgXwqvtRlLvXAmLpc9dwM10hhD7EcF5PrtnaXw6b7a8CYuf5T0ywOYZdL0JMB8PHYbw==
X-Received: by 2002:a9d:289:: with SMTP id 9mr1416129otl.213.1632445907180;
        Thu, 23 Sep 2021 18:11:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h17sm1768476ooc.18.2021.09.23.18.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:11:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:11:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: lm90: convert to dtschema
Message-ID: <20210924011145.GA3029785@roeck-us.net>
References: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:19:12PM +0200, Krzysztof Kozlowski wrote:
> Convert the National LM90 hwmon sensor bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. Drop adi,adt7461 from trivial-devices.
> ---
>  .../devicetree/bindings/hwmon/lm90.txt        | 51 ------------
>  .../bindings/hwmon/national,lm90.yaml         | 79 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 -
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 80 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
> deleted file mode 100644
> index 398dcb965751..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/lm90.txt
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -* LM90 series thermometer.
> -
> -Required node properties:
> -- compatible: manufacturer and chip name, one of
> -		"adi,adm1032"
> -		"adi,adt7461"
> -		"adi,adt7461a"
> -		"gmt,g781"
> -		"national,lm90"
> -		"national,lm86"
> -		"national,lm89"
> -		"national,lm99"
> -		"dallas,max6646"
> -		"dallas,max6647"
> -		"dallas,max6649"
> -		"dallas,max6657"
> -		"dallas,max6658"
> -		"dallas,max6659"
> -		"dallas,max6680"
> -		"dallas,max6681"
> -		"dallas,max6695"
> -		"dallas,max6696"
> -		"onnn,nct1008"
> -		"winbond,w83l771"
> -		"nxp,sa56004"
> -		"ti,tmp451"
> -
> -- reg: I2C bus address of the device
> -
> -- vcc-supply: vcc regulator for the supply voltage.
> -
> -Optional properties:
> -- interrupts: Contains a single interrupt specifier which describes the
> -              LM90 "-ALERT" pin output.
> -              See interrupt-controller/interrupts.txt for the format.
> -
> -- #thermal-sensor-cells: should be set to 1. See thermal/thermal-sensor.yaml
> -	      for details. See <include/dt-bindings/thermal/lm90.h> for the
> -	      definition of the local, remote and 2nd remote sensor index
> -	      constants.
> -
> -Example LM90 node:
> -
> -temp-sensor {
> -	compatible = "onnn,nct1008";
> -	reg = <0x4c>;
> -	vcc-supply = <&palmas_ldo6_reg>;
> -	interrupt-parent = <&gpio>;
> -	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> -	#thermal-sensor-cells = <1>;
> -}
> diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> new file mode 100644
> index 000000000000..e712117da3df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/national,lm90.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LM90 series thermometer
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1032
> +      - adi,adt7461
> +      - adi,adt7461a
> +      - dallas,max6646
> +      - dallas,max6647
> +      - dallas,max6649
> +      - dallas,max6657
> +      - dallas,max6658
> +      - dallas,max6659
> +      - dallas,max6680
> +      - dallas,max6681
> +      - dallas,max6695
> +      - dallas,max6696
> +      - gmt,g781
> +      - national,lm86
> +      - national,lm89
> +      - national,lm90
> +      - national,lm99
> +      - nxp,sa56004
> +      - onnn,nct1008
> +      - ti,tmp451
> +      - winbond,w83l771
> +
> +
> +  interrupts:
> +    items:
> +      - description: |
> +          Single interrupt specifier which describes the LM90 "-ALERT" pin
> +          output.
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  vcc-supply:
> +    description: phandle to the regulator that provides the +VCC supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/tegra-gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@4c {
> +            compatible = "onnn,nct1008";
> +            reg = <0x4c>;
> +            vcc-supply = <&palmas_ldo6_reg>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +            #thermal-sensor-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 1e4b3464d734..1eb4ce7dcdfd 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -41,10 +41,6 @@ properties:
>            - adi,adp5585-02
>              # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
>            - adi,adp5589
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7461
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adt7461
>              # AMS iAQ-Core VOC Sensor
>            - ams,iaq-core
>              # i2c serial eeprom  (24cxx)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b990794ec35..b07679009af2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10928,7 +10928,7 @@ LM90 HARDWARE MONITOR DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/hwmon/lm90.txt
> +F:	Documentation/devicetree/bindings/hwmon/national,lm90.yaml
>  F:	Documentation/hwmon/lm90.rst
>  F:	drivers/hwmon/lm90.c
>  F:	include/dt-bindings/thermal/lm90.h
