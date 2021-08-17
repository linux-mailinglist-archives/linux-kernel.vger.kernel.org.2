Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B13EF2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHQTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:47:08 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34692 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhHQTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:47:05 -0400
Received: by mail-ot1-f47.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so26326001otl.1;
        Tue, 17 Aug 2021 12:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zclo9C2Olul3g2wXY2iqqkT/f1ALULPox5qxFfU7XXc=;
        b=WnBfNvYyosNW+VwAiKyByDpmyF0grOYzZxSiK8hsAI00iiPora++c5E/hIM0HjJbcA
         6OKBZVUYbKaFuxsEfnh8OZoaCG72WspcEbjwXQvl9VJwd4akc5M5PUfv4zbJS5uMxeGQ
         YjKUt6a7+mhbnkOkcHe9FIAqHIeosdyE+XqDklf26P09/7X4UTUlwrXehvI5V9cOoXz2
         PibgPWq1rbQy6WjX7NmMLnbLa6YAeXiw3mJtOXBiZW5HDkwHPDgohcQyb6BpUUY/tiXH
         3M6X16Eh/JFwfRHm3uWEpoF15ZZDJPoRNaz0LF1dNZzli0CiX5qYeH99tLw5o8yhC+Jo
         vGzQ==
X-Gm-Message-State: AOAM533+qW5GUiVHRT+PGZYYPRgYJJR3sR6a3UjjWxKwUlLLMEBKyBee
        ReQ9pqCMD0fjM3OelFVJdw==
X-Google-Smtp-Source: ABdhPJy3iP1WxayZau7U1PboFtVN55VMumE+Vzc0q695S6mcf30r7B2ZXqsDACWZOA85+aK7vXjXyA==
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr3907185otq.351.1629229591422;
        Tue, 17 Aug 2021 12:46:31 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j14sm605117oor.33.2021.08.17.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:46:30 -0700 (PDT)
Received: (nullmailer pid 728341 invoked by uid 1000);
        Tue, 17 Aug 2021 19:46:29 -0000
Date:   Tue, 17 Aug 2021 14:46:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: eeprom-93xx46: Convert to json schema\
Message-ID: <YRwSFdhUb9RT0wOZ@robh.at.kernel.org>
References: <20210810064904.10846-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810064904.10846-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:18:59PM +0530, Aswath Govindraju wrote:
> Convert eeprom-93xx46 binding documentation from txt to yaml format

Drop the trailing '\' in the subject.

> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Device tree fixes required are posted in the following patch,
> https://lore.kernel.org/patchwork/project/lkml/list/?series=511477
> 
> 
>  .../bindings/misc/eeprom-93xx46.txt           | 29 --------
>  .../bindings/misc/eeprom-93xx46.yaml          | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> deleted file mode 100644
> index 72ea0af368d4..000000000000
> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -EEPROMs (SPI) compatible with Microchip Technology 93xx46 family.
> -
> -Required properties:
> -- compatible : shall be one of:
> -    "atmel,at93c46"
> -    "atmel,at93c46d"
> -    "atmel,at93c56"
> -    "atmel,at93c66"
> -    "eeprom-93xx46"
> -    "microchip,93lc46b"
> -- data-size : number of data bits per word (either 8 or 16)
> -
> -Optional properties:
> -- read-only : parameter-less property which disables writes to the EEPROM
> -- select-gpios : if present, specifies the GPIO that will be asserted prior to
> -  each access to the EEPROM (e.g. for SPI bus multiplexing)
> -
> -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
> -apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
> -
> -Example:
> -	eeprom@0 {
> -		compatible = "eeprom-93xx46";
> -		reg = <0>;
> -		spi-max-frequency = <1000000>;
> -		spi-cs-high;
> -		data-size = <8>;
> -		select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
> -	};
> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
> new file mode 100644
> index 000000000000..4254a7be5a70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/eeprom-93xx46.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip 93xx46 SPI compatible EEPROM family dt bindings
> +
> +maintainers:
> +  - Cory Tusar <cory.tusar@pid1solutions.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "@[0-9]+$"

Unless you want to define 'eeprom' as the correct node name, there's no 
point in this. The unit address is checked by the spi bus schema and 
it's also wrong here being decimal.

> +
> +  compatible:
> +    enum:
> +      - atmel,at93c46
> +      - atmel,at93c46d
> +      - atmel,at93c56
> +      - atmel,at93c66
> +      - eeprom-93xx46
> +      - microchip,93lc46b
> +
> +  data-size:
> +    description: number of data bits per word
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16]
> +
> +  reg:
> +    description: chip select of EEPROM
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +  spi-cs-high: true
> +
> +  read-only:
> +    description:
> +      parameter-less property which disables writes to the EEPROM

type: boolean.


> +
> +  select-gpios:
> +    description:
> +      specifies the GPIO that needs to be asserted prior to each access
> +      of EEPROM (e.g. for SPI bus multiplexing)
> +    maxItems: 1
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - data-size
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi0 {

spi {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      eeprom@0 {
> +        compatible = "eeprom-93xx46";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        spi-cs-high;
> +        data-size = <8>;
> +        select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> -- 
> 2.17.1
> 
> 
