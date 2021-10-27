Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334E43BFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhJ0C3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:29:49 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39851 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhJ0C3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:29:48 -0400
Received: by mail-ot1-f49.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so1532771ote.6;
        Tue, 26 Oct 2021 19:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLv2+TvvuzM3ue9hMwxprHaeHfbuqNS3beLTXLzV1o8=;
        b=wzOzE+SMklo1tBDp5z+/BTIg/HhFoLJdyFbX+dUN5xRJv5crJi5PPFMp+ios5RjjLq
         +tAwcRrGQG23XisdowPALL/OwLXDpp1RgO0DDfEgC9KqjGDBRSbfoeCWiubrPGvzkTEM
         UWvm+RDZKF5itenc/1sRJkf8MekyBCbsBCG/vWBS9QKMu/97xd10zebL8t/BY1lBP5Ks
         hXvSkKU9b84hsfMF/iecQI8it7NC22T1eZB3/AQLRqCJ6K726KwDsEw1jEbSeQS6digM
         o52hiddmOAgbc1Pr0GH9KbQkIPzhOdOYOYK39dlCMVoiWs2K8Q+VopoCUEWqUtxtDN1q
         qWvg==
X-Gm-Message-State: AOAM533hTQ7u+HRHCrUJyFmPcn/52Gp1CHFgPALACWS78rBAey2hEw+i
        dbz83mDrHwUjIr2chY9HnAQcw+n/qA==
X-Google-Smtp-Source: ABdhPJw5h9/mlpaa5i4Fdk88j8Sm320N8ZPOivDrPaZ6v47EWJ5nNqvYatSLussR32dS8csm8pIk5g==
X-Received: by 2002:a9d:609b:: with SMTP id m27mr22772092otj.51.1635301643106;
        Tue, 26 Oct 2021 19:27:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm4260857ooh.40.2021.10.26.19.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:27:22 -0700 (PDT)
Received: (nullmailer pid 3829563 invoked by uid 1000);
        Wed, 27 Oct 2021 02:27:21 -0000
Date:   Tue, 26 Oct 2021 21:27:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
Message-ID: <YXi5CUCEi7YmNxXM@robh.at.kernel.org>
References: <20211018234923.1769028-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018234923.1769028-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 07:49:21PM -0400, Sean Anderson wrote:
> This adds a binding for a generic GPIO reset driver. This driver is
> designed to easily add a GPIO-based reset to a driver which expected a
> reset controller. It offers greater flexibility than a reset-gpios
> property, and allows for one code path to be shared for GPIO resets and
> MMIO-based resets.

I would like to do this last part, but not requiring a binding change. 
IOW, be able to register any 'reset-gpios' property as a reset provider 
directly without this added level of indirection.

> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  .../devicetree/bindings/reset/gpio-reset.yaml | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.yaml b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
> new file mode 100644
> index 000000000000..de2ab074cea3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

GPL-2.0-only not GPL-2.0+

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/gpio-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic GPIO reset driver
> +
> +maintainers:
> +  - Sean Anderson <seanga2@gmail.com>
> +
> +description: |
> +  This is a generic GPIO reset driver which can provide a reset-controller
> +  interface for GPIO-based reset lines. This driver always operates with
> +  logical GPIO values; to invert the polarity, specify GPIO_ACTIVE_LOW in the
> +  GPIO's flags.
> +
> +properties:
> +  compatible:
> +    const: gpio-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  reset-gpios:
> +    description: |
> +      GPIOs to assert when asserting a reset. There is a one-to-one mapping
> +      between the reset specifier and the index of the GPIO in this list to
> +      assert.
> +
> +  done-gpios:
> +    description: |
> +      GPIOs which indicate that the device controlled by the GPIO has exited
> +      reset. There must be one done GPIO for each reset GPIO, or no done GPIOs
> +      at all. The driver will wait for up to done-timeout-us for the
> +      corresponding done GPIO to assert before returning.

This is odd. Do you have some examples of h/w needing this done signal? 
It certainly doesn't seem like something we have a generic need for.

> +
> +  pre-assert-us:
> +    default: 0
> +    description: |
> +      Microseconds to delay between when the reset was requested to be
> +      asserted, and asserting the reset GPIO
> +
> +  post-assert-us:
> +    default: 0
> +    description: |
> +      Microseconds to delay after asserting the reset GPIO and before returning
> +      to the caller.
> +
> +  pre-deassert-us:
> +    default: 0
> +    description: |
> +      Microseconds to delay between when the reset was requested to be
> +      deasserted, and asserting the reset GPIO
> +
> +  post-deassert-us:
> +    default: 0
> +    description: |
> +      Microseconds to delay after deasserting the reset GPIO and before
> +      returning to the caller. This delay is always present, even if the done
> +      GPIO goes high earlier.
> +
> +  done-timeout-us:
> +    default: 1000
> +    description:
> +      Microseconds to wait for the done GPIO to assert after deasserting the
> +      reset GPIO. If post-deassert-us is present, this property defaults to 10
> +      times that delay. The timeout starts after waiting for the post deassert
> +      delay.

There's a reason we don't have all these timing values in DT. The timing 
requirements are defined by each device (being reset) and implied by 
their compatible strings. If we wanted a macro language for power 
sequence timings of regulators, clocks, resets, enables, etc., then we 
would have designed such a thing already.

> +
> +required:
> +  - '#reset-cells'
> +  - compatible
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    pcs_reset: reset-pcs {
> +        #reset-cells = <1>;
> +        compatible = "gpio-reset";
> +        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
> +                      <&gpio 1 GPIO_ACTIVE_LOW>,
> +                      <&gpio 2 GPIO_ACTIVE_LOW>,
> +                      <&gpio 3 GPIO_ACTIVE_LOW>;
> +        done-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>,
> +                     <&gpio 5 GPIO_ACTIVE_HIGH>,
> +                     <&gpio 6 GPIO_ACTIVE_HIGH>,
> +                     <&gpio 7 GPIO_ACTIVE_HIGH>;
> +        post-deassert-us = <100>;
> +    };
> -- 
> 2.25.1
> 
> 
