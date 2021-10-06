Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE44247B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhJFUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhJFUIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:08:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF7C061746;
        Wed,  6 Oct 2021 13:06:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so12228796wra.12;
        Wed, 06 Oct 2021 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRddJYufb1AvtUZ2/MguDS3t2amrBJJpxBlBWWPBNTw=;
        b=myF7algxAMPS4DO76O10XXn0iW/MgEDzmGrrjrBN2HBOvLAaW3WCq+ETkrE7R1f2kj
         rfoHMmKR1dDoerVt3a2hiZwTqdZo2GUC8XZLcdHadQY4b9tArIx16phX9406SRBixGIX
         vbsD8utsGq6CTlMF/NZKsQOmlqadH0Qd3P0dpWuxvM1Yu/EXljuKr6ny4v8oYnoWMUxY
         JV1qgBTjLxu1vZ3myZteme9gx46Om23pJ3zVfCioA6uiUU/3MXfwRrh4m5kHkeFFXugn
         yMkWATG1wAo6Dxm9JVr8xNbyesJvEyWPAhTGcgSq0t7QLFX0iJc111JXDEMETDvCGJXZ
         P2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRddJYufb1AvtUZ2/MguDS3t2amrBJJpxBlBWWPBNTw=;
        b=7BZ+8LjOAZrocF+U4lq3ZCvtIqKPNatZTkvjjnxMAhx/5zJpVLn4MGtJxJLKu3BA4W
         mx1tHvioSAG1/YTVX0gMR9eO5A91Z9eljEg+HrJrWmX/2ys6n42jCEfJMiaUOcOb19gP
         TTP+VZWtCfV7vYAW9THIQp8wnD+FjcptmkS8EuSBi+OZpKIY1TXtDeEbx+zFFCyUKrTH
         haHCgfHeAlNEkPs1+i/5h8SFDCKWen0ktcD8Xw4deRkjF1jlKRcN/M3Ya7jolGCICEMA
         HKkxmTj9esHZN/c6HO9pUxy2nR7mdJyx7hJSqpnQHjEH8SfSjp0XgnrO8t4LZf6wImmq
         SazA==
X-Gm-Message-State: AOAM533u2WG+Ta2Da/F5SbD7Uv5hyKTSAxbvJpxx3wHJctHQIaOQ6+iV
        GnpY557VfCilQLf51ouzkug9IBne/DQnJPG4vDU=
X-Google-Smtp-Source: ABdhPJwV9RBX93Wec42hfUvvLBLsHWnqQT6dPKDtXr74+NF3LvoDBPUT6pQ+Hhi7R7S4JcyWs4wxnA==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr246808wmh.192.1633550800289;
        Wed, 06 Oct 2021 13:06:40 -0700 (PDT)
Received: from [192.168.0.14] (095160158079.dynamic-2-waw-k-4-2-0.vectranet.pl. [95.160.158.79])
        by smtp.gmail.com with ESMTPSA id p18sm10563275wrt.96.2021.10.06.13.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:06:40 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: display/bridge: sil, sii8620: Convert to
 YAML binding
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211006150459.584875-1-angelogioacchino.delregno@collabora.com>
From:   Andrzej Hajda <andrzej.hajda@gmail.com>
Message-ID: <8d058317-b696-d2c8-ae0c-817105b759f3@gmail.com>
Date:   Wed, 6 Oct 2021 22:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006150459.584875-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2021 17:04, AngeloGioacchino Del Regno wrote:
> Convert the Silicon Image SiI8620 HDMI/MHL bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../bindings/display/bridge/sil,sii8620.yaml  | 93 +++++++++++++++++++
>   .../bindings/display/bridge/sil-sii8620.txt   | 33 -------
>   2 files changed, 93 insertions(+), 33 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>   delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> new file mode 100644
> index 000000000000..5a38595b6687
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/sil,sii8620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Image SiI8620 HDMI/MHL bridge
> +
> +maintainers:
> +  - Andrzej Hajda <a.hajda@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: sil,sii8620
> +
> +  reg:
> +    description: I2C address of the bridge
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xtal
> +
> +  cvcc10-supply:
> +    description: Digital Core Supply Voltage, 1.0V
> +
> +  iovcc18-supply:
> +    description: I/O voltage supply, 1.8V
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO connected to the reset pin.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for HDMI input
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - cvcc10-supply
> +  - iovcc18-supply
> +  - interrupts
> +  - ports

What about gpios and other missing props.
With that fixed you can add my r-b.

Regards
Andrzej


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c1 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bridge@39 {
> +        compatible = "sil,sii8620";
> +        reg = <0x39>;
> +        cvcc10-supply = <&ldo36_reg>;
> +        iovcc18-supply = <&ldo34_reg>;
> +        interrupt-parent = <&gpf0>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        reset-gpios = <&gpv7 0 GPIO_ACTIVE_HIGH>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            mhl_to_hdmi: endpoint {
> +              remote-endpoint = <&hdmi_to_mhl>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> deleted file mode 100644
> index b05052f7d62f..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Silicon Image SiI8620 HDMI/MHL bridge bindings
> -
> -Required properties:
> -	- compatible: "sil,sii8620"
> -	- reg: i2c address of the bridge
> -	- cvcc10-supply: Digital Core Supply Voltage (1.0V)
> -	- iovcc18-supply: I/O Supply Voltage (1.8V)
> -	- interrupts: interrupt specifier of INT pin
> -	- reset-gpios: gpio specifier of RESET pin
> -	- clocks, clock-names: specification and name of "xtal" clock
> -	- video interfaces: Device node can contain video interface port
> -			    node for HDMI encoder according to [1].
> -
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	sii8620@39 {
> -		reg = <0x39>;
> -		compatible = "sil,sii8620";
> -		cvcc10-supply = <&ldo36_reg>;
> -		iovcc18-supply = <&ldo34_reg>;
> -		interrupt-parent = <&gpf0>;
> -		interrupts = <2 0>;
> -		reset-gpio = <&gpv7 0 0>;
> -		clocks = <&pmu_system_controller 0>;
> -		clock-names = "xtal";
> -
> -		port {
> -			mhl_to_hdmi: endpoint {
> -				remote-endpoint = <&hdmi_to_mhl>;
> -			};
> -		};
> -	};
> 

