Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDA42124E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhJDPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:09:16 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:39906 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhJDPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:09:15 -0400
Received: by mail-oo1-f45.google.com with SMTP id w6-20020a4aa446000000b002b5795cca03so5447714ool.6;
        Mon, 04 Oct 2021 08:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HblbjWkkhGFJMAyrrr0ojHx8MU/wNDgLL3u7EEoP/MI=;
        b=PnqkXwXQp0s/pBkV+M22cNm0QGRAw/2L9E1VHaXBjhfg0bZY6FQgzVYSBX15x6fMob
         pUDFA2W5HVGvClWi9zPn/x+m5XztUP2mpl6ggGAwOxUTwcKuSfA0SCy2s0rHOYFmIfgz
         mPofed4RaOUNyLcysbl+2v60H3YFZpJs9hF2lDFA84Tt+q2NbrHUYgQ+Fyfa5BeiV7xg
         hiRhxGPkk+Ej7wnusIc7KpVzjo8eE3lbM+jUSmCEQgGO4oZlsPjimMWUzcvrfAL8DUo+
         cQqRw+7u7jkVyDtnJuLuaxCJwVKYglL1JH8Cjc8WlEWUavsVI0BPX92yljv0qlXc167Q
         Zncg==
X-Gm-Message-State: AOAM533BseiRKRIgpSKMdO7sgZy/BtuUZAtzRuVqDV/YWWDdVYe3CCMo
        O5RNIa2VQ+/oxR53d6F8JA==
X-Google-Smtp-Source: ABdhPJxMxBVrK2pbP5Ej33r1ptOjnrJPTBlm58+uGDpR8omGu2+HZ4lJz6QQHcQFO3TcafMQu2Kimg==
X-Received: by 2002:a4a:ded2:: with SMTP id w18mr9505550oou.77.1633360046068;
        Mon, 04 Oct 2021 08:07:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f61sm2940102otf.73.2021.10.04.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:07:25 -0700 (PDT)
Received: (nullmailer pid 1302511 invoked by uid 1000);
        Mon, 04 Oct 2021 15:07:24 -0000
Date:   Mon, 4 Oct 2021 10:07:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max77686: convert to
 dtschema
Message-ID: <YVsYrLPx0trUI17D@robh.at.kernel.org>
References: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
 <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 04:13:52PM +0200, Krzysztof Kozlowski wrote:
> Convert the regulators of Maxim MAX77686 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/max77686.txt           | 71 --------------
>  .../bindings/regulator/maxim,max77686.yaml    | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 93 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
> deleted file mode 100644
> index e9f7578ca09a..000000000000
> --- a/Documentation/devicetree/bindings/regulator/max77686.txt
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -Binding for Maxim MAX77686 regulators
> -
> -This is a part of the device tree bindings of MAX77686 multi-function device.
> -More information can be found in ../mfd/max77686.txt file.
> -
> -The MAX77686 PMIC has 9 high-efficiency Buck and 26 Low-DropOut (LDO)
> -regulators that can be controlled over I2C.
> -
> -Following properties should be present in main device node of the MFD chip.
> -
> -Optional node:
> -- voltage-regulators : The regulators of max77686 have to be instantiated
> -  under subnode named "voltage-regulators" using the following format.
> -
> -	regulator_name {
> -		regulator-compatible = LDOn/BUCKn
> -		standard regulator constraints....
> -	};
> -	refer Documentation/devicetree/bindings/regulator/regulator.txt
> -
> -  The regulator node's name should be initialized with a string
> -to get matched with their hardware counterparts as follow:
> -
> -	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
> -			example: LDO1, LDO2, LDO26.
> -	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
> -			example: BUCK1, BUCK5, BUCK9.
> -
> -  Regulators which can be turned off during system suspend:
> -	-LDOn	:	2, 6-8, 10-12, 14-16,
> -	-BUCKn	:	1-4.
> -  Use standard regulator bindings for it ('regulator-off-in-suspend').
> -
> -  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
> -  control. To turn this feature on this property must be added to the regulator
> -  sub-node:
> -	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
> -				flags are actually ignored and always
> -				ACTIVE_HIGH is used)
> -
> -Example:
> -
> -	max77686: pmic@9 {
> -		compatible = "maxim,max77686";
> -		interrupt-parent = <&wakeup_eint>;
> -		interrupts = <26 IRQ_TYPE_NONE>;
> -		reg = <0x09>;
> -
> -		voltage-regulators {
> -			ldo11_reg: LDO11 {
> -				regulator-name = "vdd_ldo11";
> -				regulator-min-microvolt = <1900000>;
> -				regulator-max-microvolt = <1900000>;
> -				regulator-always-on;
> -			};
> -
> -			buck1_reg: BUCK1 {
> -				regulator-name = "vdd_mif";
> -				regulator-min-microvolt = <950000>;
> -				regulator-max-microvolt = <1300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			buck9_reg: BUCK9 {
> -				regulator-name = "CAM_ISP_CORE_1.2V";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1200000>;
> -				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
> -			};
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> new file mode 100644
> index 000000000000..33a80a8caf26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max77686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77686 Power Management IC regulators
> +
> +maintainers:
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77686 Power Management
> +  Integrated Circuit (PMIC).
> +
> +  The Maxim MAX77686 provides high-efficiency Buck and 26 Low-DropOut (LDO)
> +  regulators.
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77686.yaml for
> +  additional information and example.
> +
> +patternProperties:
> +  # 26 LDOs
> +  "^LDO([1-9]|1[0-9]|2[0-6])$":
> +    type: object
> +    $ref: regulator.yaml#
> +    description: |
> +      Properties for single LDO regulator.
> +      Regulators which can be turned off during system suspend:
> +        LDO2, LDO6-8, LDO10-12, LDO14-16
> +
> +    properties:
> +      regulator-name: true
> +
> +      maxim,ena-gpios:
> +        maxItems: 1
> +        description: |
> +          GPIO specifier to enable the GPIO control (on/off) for regulator.
> +
> +    required:
> +      - regulator-name
> +
> +    unevaluatedProperties: false
> +
> +    allOf:
> +      - if:
> +          properties:
> +            $nodename:

I'm not sure this actually works with $nodename in child nodes.

I think I would just split out the 2 cases to 2 separate 
patternProperties entries.


> +              pattern: "^(LDO20|LDO21|LDO22|BUCK8|BUCK9)$"

Drop BUCK* ?

> +        then:
> +          properties:
> +            maxim,ena-gpios: true

This is not necessary. Flip the if condition.

> +        else:
> +          properties:
> +            maxim,ena-gpios: false
> +
> +  # 9 bucks
> +  "^BUCK[1-9]$":
> +    type: object
> +    $ref: regulator.yaml#
> +    description: |
> +      Properties for single BUCK regulator.
> +      Regulators which can be turned off during system suspend:
> +      BUCK[1-4]
> +
> +    properties:
> +      regulator-name: true
> +
> +      maxim,ena-gpios:
> +        maxItems: 1
> +        description: |
> +          GPIO specifier to enable the GPIO control (on/off) for regulator.
> +
> +    required:
> +      - regulator-name
> +
> +    unevaluatedProperties: false
> +
> +    allOf:
> +      - if:
> +          properties:
> +            $nodename:
> +              pattern: "^(LDO20|LDO21|LDO22|BUCK8|BUCK9)$"

Drop LDO* ?

> +        then:
> +          properties:
> +            maxim,ena-gpios: true
> +        else:
> +          properties:
> +            maxim,ena-gpios: false
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39b4ef4b5a95..32b55f9ab76a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11469,6 +11469,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/*/max77686.txt
> +F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
>  F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
>  F:	Documentation/devicetree/bindings/mfd/max14577.txt
>  F:	Documentation/devicetree/bindings/mfd/max77693.txt
> -- 
> 2.30.2
> 
> 
