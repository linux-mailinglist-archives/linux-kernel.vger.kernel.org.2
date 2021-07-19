Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A319A3CD1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhGSJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:35:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55226 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236217AbhGSJf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:35:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626689766; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hPHHoneMDulXJqs+lPrFDQONVnYTG8TuwzUDsbTUqNw=;
 b=k8Vly8XU9BcGdtHuFsjytf2oR4MXDBBBdfQPJmd0Jo+DAe1Gkd2+y/chfQdhZn+9Ho1AsE6J
 SjeT3DJ7zpvB5hSHrKnPYVe4kBtRZwSnHqPqgPL3Hu+iyAHUljAvpOIhogkSgrjLi4RSx9YO
 6kDkD1FA0VynSmVIFne+mTKbN7A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f550ccc923fb7e0943bcf9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Jul 2021 10:15:40
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A60FBC43460; Mon, 19 Jul 2021 10:15:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6C30C433F1;
        Mon, 19 Jul 2021 10:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Jul 2021 15:45:38 +0530
From:   skakit@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, kgunda@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 1/2] dt-bindings: pinctrl: qcom-pmic-gpio: Convert qcom
 pmic gpio bindings to YAML
In-Reply-To: <YO5QErHuGaPhU41k@yoga>
References: <1625032241-3458-1-git-send-email-skakit@codeaurora.org>
 <1625032241-3458-2-git-send-email-skakit@codeaurora.org>
 <YO5QErHuGaPhU41k@yoga>
Message-ID: <1007ff398382189c10474ca7178a3b0a@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-14 08:16, Bjorn Andersson wrote:
> On Wed 30 Jun 00:50 CDT 2021, satya priya wrote:
> 
>> Convert Qualcomm PMIC GPIO bindings from .txt to .yaml format.
>> 
> 
> Thanks for updating this Satya, this is looking quite good now. Just 
> got
> one issue with the definition of the state child node.
> 
[..]
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 44
>> +    description: |
>> +        Must contain an array of encoded interrupt specifiers for
>> +        each available GPIO
>> +
>> +  '#interrupt-cells':
>> +    const: 2
>> +
>> +  interrupt-controller: true
>> +
>> +  gpio-controller: true
>> +
>> +  gpio-ranges:
>> +    maxItems: 1
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +    description: |
> 
> Not need for the '|', as the formatting isn't significant.
> 

Okay.

>> +        The first cell will be used to define gpio number and the
>> +        second denotes the flags for this gpio
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - gpio-controller
>> +  - '#gpio-cells'
>> +  - gpio-ranges
>> +
>> +patternProperties:
>> +  '.*':
> 
> I would prefer this match to follow tlmm and go '-state$'
> 

okay.

>> +    anyOf:
> 
> Either we want the immediate child node to match gpio-pinctrl-state
> or we want one of more children matching gpio-pinctrl-state, but not
> both. So "oneOf".
> 

Okay.

>> +      - $ref: "pinmux-node.yaml"
>> +      - $ref: "pincfg-node.yaml"
> 
> The generic definition is not sufficient, you want this to be
> 
> 	- $ref: "#/$defs/gpio-pinctrl-state"
> 

Okay, I will add this ref and remove generic ones as we are already 
referring them in 'qcom-pmic-gpio-state' definition.

>> +      - patternProperties:
>> +          ".*":
> 
> The subnodes of the state can be named whatever, so this (the .*) is
> good.
> 
>> +            $ref: "#/$defs/gpio-pinctrl-state"
>> +
>> +$defs:
>> +  gpio-pinctrl-state:
> 
> This is too generic, how about qcom-pmic-gpio-state?
> 

ok.

>> +    type: object
>> +    anyOf:
> 
> I have this as "allOf" in the TLMM binding, not entirely sure what the
> implications of anyOf here would be though...
> 

Sure, will change it to allOf.

>> +      - $ref: "pinmux-node.yaml"
>> +      - $ref: "pincfg-node.yaml"
>> +    properties:
>> +      pins:
>> +        description: |
>> +            List of gpio pins affected by the properties specified in
>> +            this subnode.  Valid pins are
>> +                 - gpio1-gpio10 for pm6150
>> +                 - gpio1-gpio12 for pm6150l
>> +                 - gpio1-gpio10 for pm7325
>> +                 - gpio1-gpio4 for pm8005
>> +                 - gpio1-gpio2 for pm8008
>> +                 - gpio1-gpio6 for pm8018
>> +                 - gpio1-gpio12 for pm8038
>> +                 - gpio1-gpio40 for pm8058
>> +                 - gpio1-gpio10 for pm8150 (holes on gpio2, gpio5,
>> +                                            gpio7 and gpio8)
>> +                 - gpio1-gpio12 for pm8150b (holes on gpio3, gpio4
>> +                                             and gpio7)
>> +                 - gpio1-gpio12 for pm8150l (hole on gpio7)
>> +                 - gpio1-gpio4 for pm8916
>> +                 - gpio1-gpio10 for pm8350
>> +                 - gpio1-gpio8 for pm8350b
>> +                 - gpio1-gpio9 for pm8350c
>> +                 - gpio1-gpio38 for pm8917
>> +                 - gpio1-gpio44 for pm8921
>> +                 - gpio1-gpio36 for pm8941
>> +                 - gpio1-gpio8 for pm8950 (hole on gpio3)
>> +                 - gpio1-gpio22 for pm8994
>> +                 - gpio1-gpio26 for pm8998
>> +                 - gpio1-gpio22 for pma8084
>> +                 - gpio1-gpio2 for pmi8950
>> +                 - gpio1-gpio10 for pmi8994
>> +                 - gpio1-gpio4 for pmk8350
>> +                 - gpio1-gpio4 for pmr735a
>> +                 - gpio1-gpio4 for pmr735b
>> +                 - gpio1-gpio12 for pms405 (holes on gpio1, gpio9
>> +                                            and gpio10)
>> +                 - gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, 
>> gpio10
>> +                                            and gpio11)
>> +
>> +        items:
>> +          pattern: "^gpio([0-9]+)$"
>> +
>> +      function:
>> +        items:
>> +          - enum:
>> +              - normal
>> +              - paired
>> +              - func1
>> +              - func2
>> +              - dtest1
>> +              - dtest2
>> +              - dtest3
>> +              - dtest4
>> +              - func3  # supported by LV/MV GPIO subtypes
>> +              - func4  # supported by LV/MV GPIO subtypes
>> +
>> +      bias-disable: true
>> +      bias-pull-down: true
>> +      bias-pull-up: true
>> +
>> +      qcom,pull-up-strength:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +            Specifies the strength to use for pull up, if selected.
>> +            Valid values are defined in
>> +            <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +            If this property is omitted 30uA strength will be used
>> +            if pull up is selected
> 
> 
> enum: [0, 1, 2, 3]
> 
okay.
>> +
>> +      bias-high-impedance: true

>> +
>> +      gpio-controller;
>> +      gpio-ranges = <&pm8921_gpio 0 0 44>;
>> +      #gpio-cells = <2>;
>> +
>> +      pm8921_gpio_keys: gpio-keys {
> 
> Per my above request of changing the pattern, this would have to be
> "gpio-keys-state" instead.
> 

okay.

Thanks,
Satya Priya

> Regards,
> bjorn
> 
>> +        volume-keys {
>> +          pins = "gpio20", "gpio21";
>> +          function = "normal";
>> +
>> +          input-enable;
>> +          bias-pull-up;
>> +          drive-push-pull;
>> +          qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
>> +          power-source = <PM8921_GPIO_S4>;
>> +        };
>> +      };
>> +    };
>> +...
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 
