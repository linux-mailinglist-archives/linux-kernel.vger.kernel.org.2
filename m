Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6813426A71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhJHMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:11:23 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34880
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240457AbhJHMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:11:18 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AE9D54000F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633694958;
        bh=XIAA2IQLT0N1oUC3FDWSicvndgmt0HcmrgFfR+RcWIM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ol1pksDYJQuR6DTH/CkRDeTabu8B5E77TkyX5VH+WSmLtZUL1aTtZwZrJwH+DwI2M
         7J4blcJ0mGL8/uq5sEdYWpteNjSwlNb4PoP+aXAcCg18fFxOGrDOu/rwo3pedk+ACJ
         oMddJ9O/8y1HZm5+Ke1sqRrN6SxF3MASop804lw2mjXVex0RsqgLzL/g1+OIojtQ6i
         NIgN687io+glbGRy6dbL0QWsJKpWjDqNf4OofqOfGViMomUaOVJCTmQOqPi79ItUNY
         jGuWLGce0TUM4ETowbF94k69ExR9gNDdp7VG1oIcHxKecp8WyVwBlTJSA5RvFETyhx
         r3mSgHMSZffWQ==
Received: by mail-wr1-f71.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso7190827wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIAA2IQLT0N1oUC3FDWSicvndgmt0HcmrgFfR+RcWIM=;
        b=Rm6jvyVW/Ns8OM+/AFi2LZ63AZEkeIxoTrwAZ9T6kk3zw6To61Q+oRH8ZIV3X4iAaB
         TXn3uM4JaH282E8VWixFYm7IjhZYGCH4hCNjV+lDXZqWJNRRk0xIIn4vsX6AUQPGo1V0
         VI23tO46PSKxj0qZ+C7jTcEt2nOyq3YBlMrfhTDt1+H43cQ/gA0MU72ROhj9Z3L8yw1N
         WDyUCyEp0VluR5EaW1dF6X5yWEmDVpCjJU0UiPOmvcEW7aAOS4ZUGzdX1U6MoqCHRy7n
         g26Stqt+R1whyimKwJACI1z31JDupmLfO/ohvteXu/q8bl0aEUiLjJb3tmNEixbGRpWN
         6siw==
X-Gm-Message-State: AOAM531Q0kYdwRIYe8jfpVElxdy8vKXQzUrIOnl6SIQLVBftld+8ZeWC
        03h/X2MPTCa/Z8RjlbldMGQZHu2lk/a3CkK5eyREvkjio4DrlQ/uyGTZhsFjlbASM8mUOKsowmu
        tqG+cXs07dZriF077fn7AhILU/gIDu2BeAQO3z90U0w==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr3056293wme.36.1633694956953;
        Fri, 08 Oct 2021 05:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKO6BSd4+5NrGm89y7Pu0/2WXHHncmaUf3+YEmUR9vLFhhCgY6KDqbn18iu9zuaEBSEBKobQ==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr3056245wme.36.1633694956625;
        Fri, 08 Oct 2021 05:09:16 -0700 (PDT)
Received: from [192.168.1.24] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id c18sm2334770wmb.27.2021.10.08.05.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 05:09:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max77686: convert to
 dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
 <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
 <YVsYrLPx0trUI17D@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a0b2f5ce-6c6b-643b-e7a6-7331437e2217@canonical.com>
Date:   Fri, 8 Oct 2021 14:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVsYrLPx0trUI17D@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 17:07, Rob Herring wrote:
> On Tue, Sep 28, 2021 at 04:13:52PM +0200, Krzysztof Kozlowski wrote:
>> Convert the regulators of Maxim MAX77686 PMIC to DT schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/regulator/max77686.txt           | 71 --------------
>>  .../bindings/regulator/maxim,max77686.yaml    | 92 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  3 files changed, 93 insertions(+), 71 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
>> deleted file mode 100644
>> index e9f7578ca09a..000000000000
>> --- a/Documentation/devicetree/bindings/regulator/max77686.txt
>> +++ /dev/null
>> @@ -1,71 +0,0 @@
>> -Binding for Maxim MAX77686 regulators
>> -
>> -This is a part of the device tree bindings of MAX77686 multi-function device.
>> -More information can be found in ../mfd/max77686.txt file.
>> -
>> -The MAX77686 PMIC has 9 high-efficiency Buck and 26 Low-DropOut (LDO)
>> -regulators that can be controlled over I2C.
>> -
>> -Following properties should be present in main device node of the MFD chip.
>> -
>> -Optional node:
>> -- voltage-regulators : The regulators of max77686 have to be instantiated
>> -  under subnode named "voltage-regulators" using the following format.
>> -
>> -	regulator_name {
>> -		regulator-compatible = LDOn/BUCKn
>> -		standard regulator constraints....
>> -	};
>> -	refer Documentation/devicetree/bindings/regulator/regulator.txt
>> -
>> -  The regulator node's name should be initialized with a string
>> -to get matched with their hardware counterparts as follow:
>> -
>> -	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
>> -			example: LDO1, LDO2, LDO26.
>> -	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
>> -			example: BUCK1, BUCK5, BUCK9.
>> -
>> -  Regulators which can be turned off during system suspend:
>> -	-LDOn	:	2, 6-8, 10-12, 14-16,
>> -	-BUCKn	:	1-4.
>> -  Use standard regulator bindings for it ('regulator-off-in-suspend').
>> -
>> -  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
>> -  control. To turn this feature on this property must be added to the regulator
>> -  sub-node:
>> -	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
>> -				flags are actually ignored and always
>> -				ACTIVE_HIGH is used)
>> -
>> -Example:
>> -
>> -	max77686: pmic@9 {
>> -		compatible = "maxim,max77686";
>> -		interrupt-parent = <&wakeup_eint>;
>> -		interrupts = <26 IRQ_TYPE_NONE>;
>> -		reg = <0x09>;
>> -
>> -		voltage-regulators {
>> -			ldo11_reg: LDO11 {
>> -				regulator-name = "vdd_ldo11";
>> -				regulator-min-microvolt = <1900000>;
>> -				regulator-max-microvolt = <1900000>;
>> -				regulator-always-on;
>> -			};
>> -
>> -			buck1_reg: BUCK1 {
>> -				regulator-name = "vdd_mif";
>> -				regulator-min-microvolt = <950000>;
>> -				regulator-max-microvolt = <1300000>;
>> -				regulator-always-on;
>> -				regulator-boot-on;
>> -			};
>> -
>> -			buck9_reg: BUCK9 {
>> -				regulator-name = "CAM_ISP_CORE_1.2V";
>> -				regulator-min-microvolt = <1000000>;
>> -				regulator-max-microvolt = <1200000>;
>> -				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
>> -			};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
>> new file mode 100644
>> index 000000000000..33a80a8caf26
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/maxim,max77686.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX77686 Power Management IC regulators
>> +
>> +maintainers:
>> +  - Chanwoo Choi <cw00.choi@samsung.com>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description: |
>> +  This is a part of device tree bindings for Maxim MAX77686 Power Management
>> +  Integrated Circuit (PMIC).
>> +
>> +  The Maxim MAX77686 provides high-efficiency Buck and 26 Low-DropOut (LDO)
>> +  regulators.
>> +
>> +  See also Documentation/devicetree/bindings/mfd/maxim,max77686.yaml for
>> +  additional information and example.
>> +
>> +patternProperties:
>> +  # 26 LDOs
>> +  "^LDO([1-9]|1[0-9]|2[0-6])$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    description: |
>> +      Properties for single LDO regulator.
>> +      Regulators which can be turned off during system suspend:
>> +        LDO2, LDO6-8, LDO10-12, LDO14-16
>> +
>> +    properties:
>> +      regulator-name: true
>> +
>> +      maxim,ena-gpios:
>> +        maxItems: 1
>> +        description: |
>> +          GPIO specifier to enable the GPIO control (on/off) for regulator.
>> +
>> +    required:
>> +      - regulator-name
>> +
>> +    unevaluatedProperties: false
>> +
>> +    allOf:
>> +      - if:
>> +          properties:
>> +            $nodename:
> 
> I'm not sure this actually works with $nodename in child nodes.
> 
> I think I would just split out the 2 cases to 2 separate 
> patternProperties entries.
> 

I split the entries, slightly more code but it's actually easier to read.


Best regards,
Krzysztof
