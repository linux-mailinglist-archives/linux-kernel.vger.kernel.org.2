Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59915434044
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJSVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:16:36 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43722 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhJSVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:16:35 -0400
Received: by mail-ot1-f42.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so4683686otb.10;
        Tue, 19 Oct 2021 14:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rxPAMPXkEmgM/eAA416WKz8VLt+xRYrbLcupdEp4vW8=;
        b=eXkSlQQBVK8Ie9jsE3CKR8Y1wSPDkYpLLurv+1r7jkRcaEwbC5dg+KiB9WBjnSwUOK
         2eqALwdCI0Eh94nBhCvNxZnQkmEZEkxR9xSxKRDpp51t7UfRt+luQRfuCtriEirXKo34
         2Mu1Fh5rJ3J4G+BF9wtOLi8MjZebSqpuHeC0Ggmy1Bl62hCQAhC/GpGGGDXapoxeiyY7
         U0ch2iZJluwbO7KD08AFZuxhs51K9BQDFSLOeeTmjloC+koP7VNNJm15NqeK+bJQu0fr
         jNL47lBN/H5gcSAU2Opeyok/J2GN7B1m4ynkmmT231t8CunA21lNuWYagc1kJvMzmgFX
         KVLg==
X-Gm-Message-State: AOAM5308vYp2HA5sOP+cTBcq6Mmp4Zp3w2fe9ya8h3NhsR0qFLAtHiAp
        db2bBd6HS1mCkc8zKVGHlA==
X-Google-Smtp-Source: ABdhPJxTXk3YUcoJAZL3ZeINf+u/Q3Yq2PVlqXzt2+/j9wNmWvCLUfqzzxMnUJzQRgmUZ1kDOP+upA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr7131795ote.239.1634678061020;
        Tue, 19 Oct 2021 14:14:21 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-67-78-118-34.sw.biz.rr.com. [67.78.118.34])
        by smtp.gmail.com with ESMTPSA id bg16sm53542oib.14.2021.10.19.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:14:20 -0700 (PDT)
Received: (nullmailer pid 852663 invoked by uid 1000);
        Tue, 19 Oct 2021 21:14:18 -0000
Date:   Tue, 19 Oct 2021 16:14:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, ajaykumar.rs@samsung.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/bridge: ps8622: Convert to YAML
 binding
Message-ID: <YW81KhW1lL4prPnU@robh.at.kernel.org>
References: <20211007081930.84653-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007081930.84653-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 10:19:30AM +0200, AngeloGioacchino Del Regno wrote:
> Convert the Parade PS8622 eDP/DP to LVDS bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/bridge/parade,ps8622.yaml         | 102 ++++++++++++++++++
>  .../bindings/display/bridge/ps8622.txt        |  31 ------
>  2 files changed, 102 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/ps8622.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
> new file mode 100644
> index 000000000000..dda9ceeac60c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/parade,ps8622.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Parade PS8622 eDP/DP to LVDS bridge
> +
> +maintainers:
> +  - Ajay Kumar <ajaykumar.rs@samsung.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - parade,ps8622
> +      - parade,ps8625
> +
> +  reg:
> +    description: I2C address of the bridge
> +    maxItems: 1
> +
> +  lane-count:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Number of DP lanes to use
> +    maxItems: 1

It's a uint32, so it's already 1 item.

I'd assume only 1, 2, or 4 lanes are valid, so 'enum: [ 1, 2, 4 ]'. Or 
something similar.

> +
> +  use-external-pwm:
> +    type: boolean
> +    description: Backlight controlled by an external PWM
> +
> +  sleep-gpios:
> +    description: GPIO connected to the PD_ signal.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO connected to the RST_ signal.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for LVDS output
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for eDP input
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - sleep-gpios
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c1 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bridge@48 {
> +        compatible = "parade,ps8622";
> +        reg = <0x48>;
> +        lane-count = <1>;
> +        sleep-gpios = <&gpc3 5 GPIO_ACTIVE_HIGH>;
> +        reset-gpios = <&gpy7 7 GPIO_ACTIVE_HIGH>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            bridge_out: endpoint {
> +              remote-endpoint = <&panel_in>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            bridge_in: endpoint {
> +              remote-endpoint = <&dp_out>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/bridge/ps8622.txt b/Documentation/devicetree/bindings/display/bridge/ps8622.txt
> deleted file mode 100644
> index c989c3807f2b..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/ps8622.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -ps8622-bridge bindings
> -
> -Required properties:
> -	- compatible: "parade,ps8622" or "parade,ps8625"
> -	- reg: first i2c address of the bridge
> -	- sleep-gpios: OF device-tree gpio specification for PD_ pin.
> -	- reset-gpios: OF device-tree gpio specification for RST_ pin.
> -
> -Optional properties:
> -	- lane-count: number of DP lanes to use
> -	- use-external-pwm: backlight will be controlled by an external PWM
> -	- video interfaces: Device node can contain video interface port
> -			    nodes for panel according to [1].
> -
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	lvds-bridge@48 {
> -		compatible = "parade,ps8622";
> -		reg = <0x48>;
> -		sleep-gpios = <&gpc3 6 1 0 0>;
> -		reset-gpios = <&gpc3 1 1 0 0>;
> -		lane-count = <1>;
> -		ports {
> -			port@0 {
> -				bridge_out: endpoint {
> -					remote-endpoint = <&panel_in>;
> -				};
> -			};
> -		};
> -	};
> -- 
> 2.33.0
> 
> 
