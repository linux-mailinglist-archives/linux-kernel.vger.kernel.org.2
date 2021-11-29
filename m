Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D63460C20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376861AbhK2BVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:21:45 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43893 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhK2BTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:19:44 -0500
Received: by mail-ot1-f45.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so1786891otu.10;
        Sun, 28 Nov 2021 17:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=230w9ape9JpzqZr74e2sVyCORpXl3Wj9yImdFjz57gs=;
        b=RRQbLRoJ8aGuJI3IDuIzH5CbaWBJ7LpTuU8Q7t3f1luXyMLS0s6lxOHBINT1rcn0k2
         Xm6BR53NXgJwEasX+R/o4ANwof/sH7EcOllSyB9L6bzKx9d2ZRt7SEVtFKh+15otzQ2I
         klzEBpLJt21OpLSIdE7Srpr2mPQI2nOhPAeMCODG30Tiw4SCnVeg2RKjWSoP1i5A0ryt
         Lk66eLFOBq1AgGm+2qnAgkAEH3Ct17vH0Q+aKRBYdSxeO7LMVVCvvxa8TerMjAMw8kkl
         pevpwuOaz8Pb2Idx7tNKrBknff1cUa6/jMmSZQy0zBSOMJKA7jkTebY+Mga/7GDosKEf
         2jJA==
X-Gm-Message-State: AOAM533awNRITCagiyadQbnPQ6WoQ3bLX4AevQuYfoRoous8A9yENZpT
        EDjHU0Pwb1CCCYsQfiacwTn0uXk3og==
X-Google-Smtp-Source: ABdhPJxw7RaRn8u7lMfZwgPBfX9c0xo3f1wQiGd25fOtpLSff7OrzkM36mL2nrRKmheta6i+/knLlw==
X-Received: by 2002:a9d:750c:: with SMTP id r12mr41395664otk.273.1638148587262;
        Sun, 28 Nov 2021 17:16:27 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id q22sm2401602ots.62.2021.11.28.17.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:16:26 -0800 (PST)
Received: (nullmailer pid 2958524 invoked by uid 1000);
        Mon, 29 Nov 2021 01:16:19 -0000
Date:   Sun, 28 Nov 2021 19:16:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
Message-ID: <YaQp4wkSBfh5lREV@robh.at.kernel.org>
References: <20211126050228.6257-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126050228.6257-1-j-choudhary@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:32:28AM +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs
> from txt to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells', 'num-serializer' and 'port' which were not there
> in the txt file.
> Adds 'dmas' and 'dma-names' in the example which were not there in
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v3:
> - removes maxItems from 'clock-names'
> 
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'port' and 'num-serializer' as node properties
>  
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 ---------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 178 ++++++++++++++++++
>  2 files changed, 178 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> deleted file mode 100644
> index bd863bd69501..000000000000
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -Texas Instruments McASP controller
> -
> -Required properties:
> -- compatible :
> -	"ti,dm646x-mcasp-audio"	: for DM646x platforms
> -	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
> -	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, AM43xx, TI81xx)
> -	"ti,dra7-mcasp-audio"	: for DRA7xx platforms
> -	"ti,omap4-mcasp-audio"	: for OMAP4
> -
> -- reg : Should contain reg specifiers for the entries in the reg-names property.
> -- reg-names : Should contain:
> -         * "mpu" for the main registers (required). For compatibility with
> -           existing software, it is recommended this is the first entry.
> -         * "dat" for separate data port register access (optional).
> -- op-mode : I2S/DIT ops mode. 0 for I2S mode. 1 for DIT mode used for S/PDIF,
> -  	    IEC60958-1, and AES-3 formats.
> -- tdm-slots : Slots for TDM operation. Indicates number of channels transmitted
> -  	      or received over one serializer.
> -- serial-dir : A list of serializer configuration. Each entry is a number
> -               indication for serializer pin direction.
> -               (0 - INACTIVE, 1 - TX, 2 - RX)
> -- dmas: two element list of DMA controller phandles and DMA request line
> -        ordered pairs.
> -- dma-names: identifier string for each DMA request line in the dmas property.
> -	     These strings correspond 1:1 with the ordered pairs in dmas. The dma
> -	     identifiers must be "rx" and "tx".
> -
> -Optional properties:
> -
> -- ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
> -- tx-num-evt : FIFO levels.
> -- rx-num-evt : FIFO levels.
> -- dismod : Specify the drive on TX pin during inactive slots
> -	0 : 3-state
> -	2 : logic low
> -	3 : logic high
> -	Defaults to 'logic low' when the property is not present
> -- sram-size-playback : size of sram to be allocated during playback
> -- sram-size-capture  : size of sram to be allocated during capture
> -- interrupts : Interrupt numbers for McASP
> -- interrupt-names : Known interrupt names are "tx" and "rx"
> -- pinctrl-0: Should specify pin control group used for this controller.
> -- pinctrl-names: Should contain only one value - "default", for more details
> -  		 please refer to pinctrl-bindings.txt
> -- fck_parent : Should contain a valid clock name which will be used as parent
> -	       for the McASP fck
> -- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
> -		   and FS rate if applicable:
> -		   AUCLK rate = auxclk-fs-ratio * FS rate
> -
> -Optional GPIO support:
> -If any McASP pin need to be used as GPIO then the McASP node must have:
> -...
> -  gpio-controller
> -  #gpio-cells = <2>;
> -...
> -
> -When requesting a GPIO, the first parameter is the PIN index in McASP_P*
> -registers.
> -For example to request the AXR2 pin of mcasp8:
> -function-gpios = <&mcasp8 2 0>;
> -
> -Or to request the ACLKR pin of mcasp8:
> -function-gpios = <&mcasp8 29 0>;
> -
> -For generic gpio information, please refer to bindings/gpio/gpio.txt
> -
> -Example:
> -
> -mcasp0: mcasp0@1d00000 {
> -	compatible = "ti,da830-mcasp-audio";
> -	reg = <0x100000 0x3000>;
> -	reg-names "mpu";
> -	interrupts = <82>, <83>;
> -	interrupt-names = "tx", "rx";
> -	op-mode = <0>;		/* MCASP_IIS_MODE */
> -	tdm-slots = <2>;
> -	serial-dir = <
> -			0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
> -			0 0 0 0
> -			0 0 0 1
> -			2 0 0 0 >;
> -	tx-num-evt = <1>;
> -	rx-num-evt = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> new file mode 100644
> index 000000000000..c4d3f56470bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/davinci-mcasp-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: McASP Controller for TI SoCs
> +
> +maintainers:
> +  - Jayesh Choudhary <j-choudhary@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dm646x-mcasp-audio
> +      - ti,da830-mcasp-audio
> +      - ti,am33xx-mcasp-audio
> +      - ti,dra7-mcasp-audio
> +      - ti,omap4-mcasp-audio
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: main registers
> +      - description: data port register
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: mpu
> +      - const: dat
> +
> +  op-mode:
> +    description: I2S - 0 or DIT - 1 mode
> +    enum:
> +      - 0
> +      - 1

Needs a type.

> +
> +  tdm-slots:
> +    maxItems: 1

An array? Needs a type.

> +
> +  serial-dir:
> +    description:
> +      A list of serializer configuration
> +      Entry is indication for serializer pin direction
> +      0 - Inactive, 1 - TX, 2 - RX
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 16
> +    items:
> +      minimum: 0
> +      maximum: 2
> +      default: 0
> +
> +  dmas:
> +    minItems: 1
> +    items:
> +      - description: transmission DMA channel
> +      - description: reception DMA channel
> +
> +  dma-names:
> +    minItems: 1
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Name of hwmod associated with McASP
> +    maxItems: 1
> +    deprecated: true
> +
> +  tx-num-evt:
> +    maxItems: 1

Array? Needs a type.

> +
> +  rx-num-evt:
> +    maxItems: 1

Array? Needs a type.

> +
> +  dismod:
> +    enum:
> +      - 0
> +      - 2
> +      - 3
> +    default: 2

Needs a type.

And so on...

> +
> +  sram-size-playback:
> +    maxItems: 1
> +
> +  sram-size-capture:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: TX FIFO interrupt
> +      - description: RX FIFO interrupt
> +
> +  interrupt-names:
> +    oneOf:
> +      - minItems: 1
> +        items:
> +          - const: tx
> +          - const: rx
> +      - const: common
> +
> +  fck_parent:
> +    description: parent clock for McASP fck
> +    maxItems: 1
> +
> +  auxclk-fs-ratio:
> +    description: ratio of AUCLK and FS if applicable
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  function-gpios:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: fck
> +      - const: ahclkx
> +      - const: ahclkr
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  num-serializer:
> +    maxItems: 1
> +
> +  port:
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - dmas
> +  - dma-names
> +  - interrupts
> +  - interrupt-names
> +  - serial-dir
> +  - op-mode
> +  - tdm-slots
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mcasp0: mcasp0@1d00000 {
> +      compatible = "ti,da830-mcasp-audio";
> +      reg = <0x100000 0x3000>;
> +      reg-names = "mpu";
> +      interrupts = <82>, <83>;
> +      interrupt-names = "tx", "rx";
> +      op-mode = <0>;		/* MCASP_IIS_MODE */
> +      tdm-slots = <2>;
> +      dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
> +      dma-names = "tx", "rx";
> +      serial-dir = <
> +          0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
> +          0 0 0 0
> +          0 0 0 1
> +          2 0 0 0 >;
> +      tx-num-evt = <1>;
> +      rx-num-evt = <1>;
> +    };
> -- 
> 2.17.1
> 
> 
