Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295A1386E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbhERA3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:29:22 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42728 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhERA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:29:21 -0400
Received: by mail-ot1-f41.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso7148089otg.9;
        Mon, 17 May 2021 17:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3L7pxt4zbk8yKl/avJfRLABaqdm3QQDGowpbldv5VQ=;
        b=WhSjBEQ8TasR4f/nsQm1Q3ky6WuQL2gONqPDj7Us6PuXKGMKmKRWCAD9PSO2O9ZUTV
         L5v9mA3faXRlDvAN5RaGysWePe085CjxGLnu/b3Yd2Fj9hepZDqThCuu6MqSmGzT2ivf
         KsjpKeMZvvWc/oQOxKLOqwmco+HHoNAbPt2g2A6thZY+Eiamy7R3L92J0qWTKLvqoibT
         HfaS+2Ew3APwfpF6kyegwiLMtFtImFeZDkCcEDbNukre7ydyX4Ezqz9oSIX4LduyMh/w
         MWvQXRhNstUxsfiMiSDdRz8bTdiPoS+Jk6Ww7mnjiCGdIIpUtRO7OFKGnOv/q4wI3e5P
         aDgQ==
X-Gm-Message-State: AOAM532APBRTJGgffktCpXIqo8cYaPDhPi22P2Yj2nE/DvylxlLy/JRO
        vD4hVYmzFS6P5zgePOFsmYn/n94Nuw==
X-Google-Smtp-Source: ABdhPJwo+JpfM6jwHe1xxWMB9CadaPmye2HzBZL+6b/BqkSpJkZUqJ2uC/RTySA+qewzrquRUK9mQw==
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr1918550otp.34.1621297684104;
        Mon, 17 May 2021 17:28:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y44sm3421102ooi.0.2021.05.17.17.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 17:26:43 -0700 (PDT)
Received: (nullmailer pid 3503561 invoked by uid 1000);
        Tue, 18 May 2021 00:26:24 -0000
Date:   Mon, 17 May 2021 19:26:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: convert faraday,tve200 to YAML
Message-ID: <20210518002624.GA3346846@robh.at.kernel.org>
References: <20210511165448.422987-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511165448.422987-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:54:48PM +0000, Corentin Labbe wrote:
> Converts display/faraday,tve200.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/display/faraday,tve200.txt       | 54 -----------
>  .../bindings/display/faraday,tve200.yaml      | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt
>  create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.txt b/Documentation/devicetree/bindings/display/faraday,tve200.txt
> deleted file mode 100644
> index 82e3bc0b7485..000000000000
> --- a/Documentation/devicetree/bindings/display/faraday,tve200.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* Faraday TV Encoder TVE200
> -
> -Required properties:
> -
> -- compatible: must be one of:
> -	"faraday,tve200"
> -	"cortina,gemini-tvc", "faraday,tve200"
> -
> -- reg: base address and size of the control registers block
> -
> -- interrupts: contains an interrupt specifier for the interrupt
> -	line from the TVE200
> -
> -- clock-names: should contain "PCLK" for the clock line clocking the
> -	silicon and "TVE" for the 27MHz clock to the video driver
> -
> -- clocks: contains phandle and clock specifier pairs for the entries
> -	in the clock-names property. See
> -	Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Optional properties:
> -
> -- resets: contains the reset line phandle for the block
> -
> -Required sub-nodes:
> -
> -- port: describes LCD panel signals, following the common binding
> -	for video transmitter interfaces; see
> -	Documentation/devicetree/bindings/media/video-interfaces.txt
> -	This port should have the properties:
> -	reg = <0>;
> -	It should have one endpoint connected to a remote endpoint where
> -	the display is connected.
> -
> -Example:
> -
> -display-controller@6a000000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "faraday,tve200";
> -	reg = <0x6a000000 0x1000>;
> -	interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> -	resets = <&syscon GEMINI_RESET_TVC>;
> -	clocks = <&syscon GEMINI_CLK_GATE_TVC>,
> -		 <&syscon GEMINI_CLK_TVC>;
> -	clock-names = "PCLK", "TVE";
> -
> -	port@0 {
> -		reg = <0>;
> -		display_out: endpoint {
> -			remote-endpoint = <&panel_in>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.yaml b/Documentation/devicetree/bindings/display/faraday,tve200.yaml
> new file mode 100644
> index 000000000000..3ab51e7e72af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/faraday,tve200.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/faraday,tve200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday TV Encoder TVE200
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,tve200
> +      - items:
> +          - const: cortina,gemini-tvc
> +          - const: faraday,tve200
> +
> +  reg:
> +    minItems: 1

maxItems: 1

They evaluate the same, but maxItems seems a bit more logical. 

> +
> +  interrupts:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: PCLK
> +      - const: TVE
> +
> +  clocks:
> +    minItems: 2
> +
> +  resets:
> +    minItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^port@[0-9]+$":

Should be just 'port' or 'port@0', but really the former is preferred 
when only 1. 

Use the graph binding:

$ref: /schemas/graph.yaml#/properties/port

> +    type: object
> +    description: describes LCD panel signals, following the common binding

But this is not an LCD panel...

> +      for video transmitter interfaces; see
> +      Documentation/devicetree/bindings/media/video-interfaces.txt

Drop this reference. It's now a schema, but this isn't using anything 
from it.

> +      It should have one endpoint connected to a remote endpoint where
> +      the display is connected.
> +
> +    properties:
> +      reg:
> +        const: 0
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    display-controller@6a000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "faraday,tve200";
> +      reg = <0x6a000000 0x1000>;
> +      interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> +      resets = <&syscon GEMINI_RESET_TVC>;
> +      clocks = <&syscon GEMINI_CLK_GATE_TVC>,
> +               <&syscon GEMINI_CLK_TVC>;
> +      clock-names = "PCLK", "TVE";
> +
> +      port@0 {
> +        reg = <0>;
> +        display_out: endpoint {
> +          remote-endpoint = <&panel_in>;
> +        };
> +      };
> +    };
> -- 
> 2.26.3
> 
