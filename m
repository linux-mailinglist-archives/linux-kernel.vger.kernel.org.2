Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E310362163
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbhDPNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244237AbhDPNrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80CD46121E;
        Fri, 16 Apr 2021 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618580816;
        bh=B/gO4o0ET1Vf4JJJaWbgLKZOakfSU5zu8k7n8XwNkcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q6ySTFEuLcZ4Q3HiIU3ZLS6PIYWbzBKE+E85JHkS7+68Ve4YOKQoGeVEy38cC3atV
         0ZKtTNLMnWqqEl0ibUc1zA/ScBeccX8iQbsdsPNk5hwxVLlEdYwUqdRoweGrS7bLd8
         no13WO4vVR5+7Z9IAz5cQZtw8cumow1zrXe7xtUSCLUxi1QwRufdCWoVFN0Zfos0H5
         zSUaPFlcsYBlG8GGyqTq0E+o+jEn8q3mXvhSrdIrUoGr4pEoRuSLwfLpLIcrBQqQ29
         P7M+rHJJ7SaDWVBU4sOUUz5+/WpDoltGkqoKlRC3Js8EudEN56RmY8+DaGfiNsJfmb
         HHF7MzdTvYOtA==
Received: by mail-ej1-f54.google.com with SMTP id mh2so20688036ejb.8;
        Fri, 16 Apr 2021 06:46:56 -0700 (PDT)
X-Gm-Message-State: AOAM532p5Nh0RRjAt9yCVV4T4aDLa6lQTsU/jYLA4CASNjhUYv6OH80c
        kN6Djkc8TWaAv4YdX/dac6goK3tcj86tEY18bQ==
X-Google-Smtp-Source: ABdhPJxTDzaPKU8wyeBHLRuKnIcggDRpfumYSFxCw0m75Xt2Xdbw7cBsRkNPQ/1iDsEibfDBKiARfrTWqdXzoIBomOk=
X-Received: by 2002:a17:907:70d3:: with SMTP id yk19mr8343248ejb.108.1618580815150;
 Fri, 16 Apr 2021 06:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <YHmOvvyxAyOY/fRL@Red>
In-Reply-To: <YHmOvvyxAyOY/fRL@Red>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Apr 2021 08:46:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ47D2m-7sF_FKfmf3X0JVw4gs-bxGt2b76oUtUqhdEYw@mail.gmail.com>
Message-ID: <CAL_JsqJ47D2m-7sF_FKfmf3X0JVw4gs-bxGt2b76oUtUqhdEYw@mail.gmail.com>
Subject: Re: Need help converting usb/faraday,fotg210.yaml to yaml
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 8:18 AM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Hello
>
> I am converting Documentation/devicetree/bindings/usb/faraday,fotg210.txt to yaml with the patch attached below.
> But validating it give me:
> Documentation/devicetree/bindings/usb/faraday,fotg210.example.dt.yaml: usb@68000000: 'syscon', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'

These have to be defined at the top level, not just the if/then
schema. More below...

>
> I dont know from where came this pinctrl regex.

The tooling adds it.

> I think this is perhaps due to the if not matched, but still didnt find any solution.
>
> Thanks
>
> --- a/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Faraday FOTG Host controller
> -
> -This OTG-capable USB host controller is found in Cortina Systems
> -Gemini and other SoC products.
> -
> -Required properties:
> -- compatible: should be one of:
> -  "faraday,fotg210"
> -  "cortina,gemini-usb", "faraday,fotg210"
> -- reg: should contain one register range i.e. start and length
> -- interrupts: description of the interrupt line
> -
> -Optional properties:
> -- clocks: should contain the IP block clock
> -- clock-names: should be "PCLK" for the IP block clock
> -
> -Required properties for "cortina,gemini-usb" compatible:
> -- syscon: a phandle to the system controller to access PHY registers
> -
> -Optional properties for "cortina,gemini-usb" compatible:
> -- cortina,gemini-mini-b: boolean property that indicates that a Mini-B
> -  OTG connector is in use
> -- wakeup-source: see power/wakeup-source.txt
> -
> -Example for Gemini:
> -
> -usb@68000000 {
> -       compatible = "cortina,gemini-usb", "faraday,fotg210";
> -       reg = <0x68000000 0x1000>;
> -       interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> -       clocks = <&cc 12>;
> -       clock-names = "PCLK";
> -       syscon = <&syscon>;
> -       wakeup-source;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
> new file mode 100644
> index 000000000000..b5418f29745e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/faraday,fotg210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday FOTG Host controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +    This OTG-capable USB host controller is found in Cortina Systems
> +    Gemini and other SoC products.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,fotg210
> +      - items:
> +        - const: cortina,gemini-usb
> +        - const: faraday,fotg210
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: PCLK
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: cortina,gemini-usb
> +then:
> +  properties:
> +    syscon:
> +      maxItems: 1
> +      $ref: /schemas/types.yaml#/definitions/phandle
> +      description: Phandle to the system controller to access PHY registers
> +    cortina,gemini-mini-b:
> +      type: boolean
> +      description: boolean property that indicates that a Mini-B OTG connector is in use
> +    wakeup-source:
> +      type: boolean
> +      description: see power/wakeup-source.txt

Move these definitions to the top level 'properties'. Then add an else clause:

else:
  properties:
    syscon: false
    cortina,gemini-mini-b: false
    wakeup-source: false

> +  required:
> +    - syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    usb@68000000 {
> +      compatible = "cortina,gemini-usb", "faraday,fotg210";
> +      reg = <0x68000000 0x1000>;
> +      interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cc 12>;
> +      clock-names = "PCLK";
> +      syscon = <&syscon>;
> +      wakeup-source;
> +    };
> +...
>
