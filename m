Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C039C21C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFDVNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:13:09 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45644 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhFDVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:13:08 -0400
Received: by mail-oi1-f179.google.com with SMTP id w127so11039167oig.12;
        Fri, 04 Jun 2021 14:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=12fDzFlHcR7MgS/6SJcEZmnZQ01o5QA2CzWvQ7tWGj0=;
        b=gWVdEFZPTx0aixwskpn61TNsnEt1r0O/+xkMcejcWfreF6M+348mJUqADY6Q/k7AUR
         3qijmwGAHltDZrsUpfvlGyRU2PVvSEr+ktFyyRgBwbzoCHnM4UWihl01KgRyFCYjYBUF
         a1gcCbcT5EeTJPLV0vRkDBUfTyArzlwR1vcYwyfKTn/oh1lPKvN+2uXV6Z/XFTr8ox/B
         KsX1lpP6u5dLbWwHJCZKPHFEunfrfBfv6KPVVh9DE00mhhgoiEYPvuaclX41nqCHePT/
         kFR9yqQn15jrJ4yTAVSTztLn1x8JgTZsH2pjea++s4uxHYGIedKZrbFqI2fl5SvzlfuM
         DhXg==
X-Gm-Message-State: AOAM531XFR248udGwX2uZReNI3rkwbWtJQPYhiwLwei3bMIICSLmsPZB
        +0ivu8HfuYdMfxS87GBixg==
X-Google-Smtp-Source: ABdhPJy5T24Ii55AMNbKFTrKwW9HSnMSHcwbCExf322LMZLqHTXAROZfbB15SujQjbREZ4k4ZwkpJw==
X-Received: by 2002:a54:4794:: with SMTP id o20mr4218812oic.99.1622841080893;
        Fri, 04 Jun 2021 14:11:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z25sm715060oic.30.2021.06.04.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:11:20 -0700 (PDT)
Received: (nullmailer pid 3924767 invoked by uid 1000);
        Fri, 04 Jun 2021 21:11:19 -0000
Date:   Fri, 4 Jun 2021 16:11:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Message-ID: <20210604211119.GA3916166@robh.at.kernel.org>
References: <20210528185329.1969688-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528185329.1969688-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 06:53:29PM +0000, Corentin Labbe wrote:
> Converts timer/faraday,fttmr010.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/timer/faraday,fttmr010.txt       | 38 --------
>  .../bindings/timer/faraday,fttmr010.yaml      | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> deleted file mode 100644
> index 3cb2f4c98d64..000000000000
> --- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Faraday Technology timer
> -
> -This timer is a generic IP block from Faraday Technology, embedded in the
> -Cortina Systems Gemini SoCs and other designs.
> -
> -Required properties:
> -
> -- compatible : Must be one of
> -  "faraday,fttmr010"
> -  "cortina,gemini-timer", "faraday,fttmr010"
> -  "moxa,moxart-timer", "faraday,fttmr010"
> -  "aspeed,ast2400-timer"
> -  "aspeed,ast2500-timer"
> -  "aspeed,ast2600-timer"
> -
> -- reg : Should contain registers location and length
> -- interrupts : Should contain the three timer interrupts usually with
> -  flags for falling edge
> -
> -Optionally required properties:
> -
> -- clocks : a clock to provide the tick rate for "faraday,fttmr010"
> -- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
> -  and peripheral clock respectively, for "faraday,fttmr010"
> -- syscon : a phandle to the global Gemini system controller if the compatible
> -  type is "cortina,gemini-timer"
> -
> -Example:
> -
> -timer@43000000 {
> -	compatible = "faraday,fttmr010";
> -	reg = <0x43000000 0x1000>;
> -	interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
> -		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
> -		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
> -	clocks = <&extclk>, <&pclk>;
> -	clock-names = "EXTCLK", "PCLK";
> -};
> diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> new file mode 100644
> index 000000000000..a495ea80c0fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0+)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology timer
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  This timer is a generic IP block from Faraday Technology, embedded in the
> +  Cortina Systems Gemini SoCs and other designs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,fttmr010
> +      - items:
> +          - const: cortina,gemini-timer
> +          - const: faraday,fttmr010
> +      - items:
> +          - const: moxa,moxart-timer
> +          - const: faraday,fttmr010
> +      - const: aspeed,ast2400-timer
> +      - const: aspeed,ast2500-timer
> +      - const: aspeed,ast2600-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3
> +    description: Should contain the three timer interrupts usually with flags for falling edge
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: "PCLK"
> +      - const: "EXTCLK"
> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        items:

This is wrong because 'contains' should be a schema applying to a single 
item whereas 'items' applies to the whole array.

> +          - const: cortina,gemini-timer

Just this is enough.

> +          - const: faraday,fttmr010
> +then:
> +  required:
> +    - syscon
> +else:
> +  properties:
> +    syscon: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    timer@43000000 {
> +      compatible = "faraday,fttmr010";
> +      reg = <0x43000000 0x1000>;
> +      interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
> +                   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
> +                   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
> +      clocks = <&extclk>, <&pclk>;
> +      clock-names = "PCLK", "EXTCLK";
> +      syscon = <&syscon>;

This should fail based on my read of the .txt binding.

> +    };
> +...
> -- 
> 2.31.1
