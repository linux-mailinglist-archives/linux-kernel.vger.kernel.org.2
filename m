Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93903DABA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhG2TIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:08:34 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:44678 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhG2TId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:08:33 -0400
Received: by mail-il1-f177.google.com with SMTP id o7so6946967ilh.11;
        Thu, 29 Jul 2021 12:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmDYTMDrb5z+wR/I3Bgep+1Plzvx/T7uZyiKlMv4WDc=;
        b=GveE0qFDfkN/8lTwzt+EAqWRHKaMNrQdalWmAWdRxy3UfT79g8NlOq36Xj8q9gdwfy
         VTAFic/7sNO4K/8qLWf3R4RMRwBi6K6gXOIXUoaMUpQ5HJDTMEgEgHk3nYqTWNgQpPGl
         DB3RdPOxGTzKWntVz01dHM6lrT+Bf/WWuUkT+7Ka2G0adfUUvxzOaaeUj6p7/g+zlwIa
         jIaYEcI9vonsyZuaLewzweEWMo3k4MkazqNmeAwPBSJlseA28aDSsX9fiC+L4Pd78Kpo
         VmS37yqSJRclDFlgee94+Bc04EwGg2nYLp4UxRvvizOvYVTsIMeyUODaJ1NzC0cjnkua
         SXJw==
X-Gm-Message-State: AOAM531xtPDigktzoZFMDEsumv9QIAEGHxalEenuY7Qc5TD70+Z/jUPN
        nRwDqJhAGA5Vemp/Kr+YDQ==
X-Google-Smtp-Source: ABdhPJzo5t2afAZSo7+QVOK17vpxXGg6rQM1gUcfwrGEIFPcxdTBNVn/G0Kjax4Mwehv6E92N252OQ==
X-Received: by 2002:a92:dad0:: with SMTP id o16mr4695293ilq.65.1627585708145;
        Thu, 29 Jul 2021 12:08:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q10sm2975639ion.3.2021.07.29.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:08:27 -0700 (PDT)
Received: (nullmailer pid 704017 invoked by uid 1000);
        Thu, 29 Jul 2021 19:08:24 -0000
Date:   Thu, 29 Jul 2021 13:08:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Bernie Liang <bliang@analogixsemi.com>,
        Sheng Pan <span@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] dt-bindings:drm/bridge:anx7625:add vendor define
 flags
Message-ID: <YQL8qLpN41ocV9N0@robh.at.kernel.org>
References: <cover.1626685856.git.xji@analogixsemi.com>
 <85126d087cb045ea5e00a5100fc7d81840744a68.1626685856.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85126d087cb045ea5e00a5100fc7d81840744a68.1626685856.git.xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 06:10:09PM +0800, Xin Ji wrote:
> Add 'bus-type' and 'data-lanes' define for port0. Define DP tx lane0,
> lane1 swing register array define, and audio enable flag.
> 
> The device which cannot pass DP tx PHY CTS caused by long PCB trace or
> embedded MUX, adjusting ANX7625 PHY parameters can pass the CTS test. The
> adjusting type include Pre-emphasis, Vp-p, Rterm(Resistor Termination)
> and Rsel(Driven Strength). Each lane has maximum 20 registers for
> these settings.
> 
> For the DP tx swing setting, each lane has 10 different combination for
> swing, as Pre0: swing3|swing2|swing1|swing0, Pre1: swing2|swing1|swing0,
> Pre2: swing1|swing0, Pre3: swing0.
> 
> Register definition as:
> [Boost_ctrl]
> These registers control post cursor manual, increase the Boost_Ctrl
> setting can increase Pre-emphasis value separately.
> Lane	Condition	Register address
> Lane0	Swing0_Pre0	0x7a:0x00 bit[3:0]
> Lane0	Swing1_Pre0	0x7a:0x01 bit[3:0]
> Lane0	Swing2_Pre0	0x7a:0x02 bit[3:0]
> Lane0	Swing3_Pre0	0x7a:0x03 bit[3:0]
> Lane0	Swing0_Pre1	0x7a:0x04 bit[3:0]
> Lane0	Swing1_Pre1	0x7a:0x05 bit[3:0]
> Lane0	Swing2_Pre1	0x7a:0x06 bit[3:0]
> Lane0	Swing0_Pre2	0x7a:0x07 bit[3:0]
> Lane0	Swing1_Pre2	0x7a:0x08 bit[3:0]
> Lane0	Swing0_Pre3	0x7a:0x09 bit[3:0]
> Lane1	Swing0_Pre0	0x7a:0x14 bit[3:0]
> Lane1	Swing1_Pre0	0x7a:0x15 bit[3:0]
> Lane1	Swing2_Pre0	0x7a:0x16 bit[3:0]
> Lane1	Swing3_Pre0	0x7a:0x17 bit[3:0]
> Lane1	Swing0_Pre1	0x7a:0x18 bit[3:0]
> Lane1	Swing1_Pre1	0x7a:0x19 bit[3:0]
> Lane1	Swing2_Pre1	0x7a:0x1a bit[3:0]
> Lane1	Swing0_Pre2	0x7a:0x1b bit[3:0]
> Lane1	Swing1_Pre2	0x7a:0x1c bit[3:0]
> Lane1	Swing0_Pre3	0x7a:0x1d bit[3:0]
> 
> [Swing_ctrl]
> These registers control swing manual, increase Swing_Ctrl setting can
> increase Vp-p value separately.
> Lane	Condition	Register address
> Lane0	Swing0_Pre0	0x7a:0x00 bit[6:4]
> Lane0	Swing1_Pre0	0x7a:0x01 bit[6:4]
> Lane0	Swing2_Pre0	0x7a:0x02 bit[6:4]
> Lane0	Swing3_Pre0	0x7a:0x03 bit[6:4]
> Lane0	Swing0_Pre1	0x7a:0x04 bit[6:4]
> Lane0	Swing1_Pre1	0x7a:0x05 bit[6:4]
> Lane0	Swing2_Pre1	0x7a:0x06 bit[6:4]
> Lane0	Swing0_Pre2	0x7a:0x07 bit[6:4]
> Lane0	Swing1_Pre2	0x7a:0x08 bit[6:4]
> Lane0	Swing0_Pre3	0x7a:0x09 bit[6:4]
> Lane1	Swing0_Pre0	0x7a:0x14 bit[6:4]
> Lane1	Swing1_Pre0	0x7a:0x15 bit[6:4]
> Lane1	Swing2_Pre0	0x7a:0x16 bit[6:4]
> Lane1	Swing3_Pre0	0x7a:0x17 bit[6:4]
> Lane1	Swing0_Pre1	0x7a:0x18 bit[6:4]
> Lane1	Swing1_Pre1	0x7a:0x19 bit[6:4]
> Lane1	Swing2_Pre1	0x7a:0x1a bit[6:4]
> Lane1	Swing0_Pre2	0x7a:0x1b bit[6:4]
> Lane1	Swing1_Pre2	0x7a:0x1c bit[6:4]
> Lane1	Swing0_Pre3	0x7a:0x1d bit[6:4]
> 
> [Rsel_ctrl]
> These registers control resistor compensation manual, increase Rsel_ctrl
> can increase the IO driven strength, increase Vp-p simultaneously.
> Lane	Condition	Register address
> Lane0	Swing0_Pre0	0x7a:0x0a bit[4:0]
> Lane0	Swing1_Pre0	0x7a:0x0b bit[4:0]
> Lane0	Swing2_Pre0	0x7a:0x0c bit[4:0]
> Lane0	Swing3_Pre0	0x7a:0x0d bit[4:0]
> Lane0	Swing0_Pre1	0x7a:0x0e bit[4:0]
> Lane0	Swing1_Pre1	0x7a:0x0f bit[4:0]
> Lane0	Swing2_Pre1	0x7a:0x10 bit[4:0]
> Lane0	Swing0_Pre2	0x7a:0x11 bit[4:0]
> Lane0	Swing1_Pre2	0x7a:0x12 bit[4:0]
> Lane0	Swing0_Pre3	0x7a:0x13 bit[4:0]
> Lane1	Swing0_Pre0	0x7a:0x1e bit[4:0]
> Lane1	Swing1_Pre0	0x7a:0x1f bit[4:0]
> Lane1	Swing2_Pre0	0x7a:0x20 bit[4:0]
> Lane1	Swing3_Pre0	0x7a:0x21 bit[4:0]
> Lane1	Swing0_Pre1	0x7a:0x22 bit[4:0]
> Lane1	Swing1_Pre1	0x7a:0x23 bit[4:0]
> Lane1	Swing2_Pre1	0x7a:0x24 bit[4:0]
> Lane1	Swing0_Pre2	0x7a:0x25 bit[4:0]
> Lane1	Swing1_Pre2	0x7a:0x26 bit[4:0]
> Lane1	Swing0_Pre3	0x7a:0x27 bit[4:0]
> 
> [Rterm_ctrl]
> These registers adjust 50ohm impedance of DP tx
> 00:55 ohm
> 01:50 ohm(default)
> 10:45 ohm
> 11:40 ohm
> Lane	Condition	Register address
> Lane0	Swing0_Pre0	0x7a:0x0a bit[6:5]
> Lane0	Swing1_Pre0	0x7a:0x0b bit[6:5]
> Lane0	Swing2_Pre0	0x7a:0x0c bit[6:5]
> Lane0	Swing3_Pre0	0x7a:0x0d bit[6:5]
> Lane0	Swing0_Pre1	0x7a:0x0e bit[6:5]
> Lane0	Swing1_Pre1	0x7a:0x0f bit[6:5]
> Lane0	Swing2_Pre1	0x7a:0x10 bit[6:5]
> Lane0	Swing0_Pre2	0x7a:0x11 bit[6:5]
> Lane0	Swing1_Pre2	0x7a:0x12 bit[6:5]
> Lane0	Swing0_Pre3	0x7a:0x13 bit[6:5]
> lane1	Swing0_Pre0	0x7a:0x1e bit[6:5]
> Lane1	Swing1_Pre0	0x7a:0x1f bit[6:5]
> Lane1	Swing2_Pre0	0x7a:0x20 bit[6:5]
> Lane1	Swing3_Pre0	0x7a:0x21 bit[6:5]
> Lane1	Swing0_Pre1	0x7a:0x22 bit[6:5]
> Lane1	Swing1_Pre1	0x7a:0x23 bit[6:5]
> Lane1	Swing2_Pre1	0x7a:0x24 bit[6:5]
> Lane1	Swing0_Pre2	0x7a:0x25 bit[6:5]
> Lane1	Swing1_Pre2	0x7a:0x26 bit[6:5]
> Lane1	Swing0_Pre3	0x7a:0x27 bit[6:5]

All this information should be in the properties description. But the 
above form is not all that clear in defining how to fill in the 
properties. You need to describe what is in each word of the properties 
and assume the reader has the datasheet. 
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 55 ++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index ab48ab2f4240..77b160d7c269 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -43,6 +43,24 @@ properties:
>    vdd33-supply:
>      description: Regulator that provides the supply 3.3V power.
>  
> +  analogix,lane0-swing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 20
> +    description:
> +      an array of swing register setting for DP tx lane0 PHY.
> +
> +  analogix,lane1-swing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 20
> +    description:
> +      an array of swing register setting for DP tx lane1 PHY.
> +
> +  analogix,audio-enable:
> +    type: boolean
> +    description: let the driver enable audio HDMI codec function or not.
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -50,13 +68,43 @@ properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port

This needs to be #/$defs/port-base instead since you are adding child 
properties.

Also needs 'unevaluatedProperties: false'.

>          description:
> -          Video port for MIPI DSI input.
> +          MIPI DSI/DPI input.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              remote-endpoint: true
> +              bus-type: true

All the possible bus-type values are supported by this h/w?

> +              data-lanes: true
> +
> +            required:
> +              - remote-endpoint

Drop this.

> +
> +        required:
> +          - endpoint

Drop this.

> +
>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
>            Video port for panel or connector.
>  
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#

No additional properties, you don't need this reference or the rest of 
this addition.

> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              remote-endpoint: true
> +
> +            required:
> +              - remote-endpoint
> +
>      required:
>        - port@0
>        - port@1
> @@ -87,6 +135,9 @@ examples:
>              vdd10-supply = <&pp1000_mipibrdg>;
>              vdd18-supply = <&pp1800_mipibrdg>;
>              vdd33-supply = <&pp3300_mipibrdg>;
> +            analogix,audio-enable;
> +            analogix,lane0-swing = <0x14 0x54 0x64 0x74 0x29 0x7b 0x77 0x5b>;
> +            analogix,lane1-swing = <0x14 0x54 0x64 0x74 0x29 0x7b 0x77 0x5b>;

If the values are only 8-bit, then make the type uint8-array.

>  
>              ports {
>                  #address-cells = <1>;
> @@ -96,6 +147,8 @@ examples:
>                      reg = <0>;
>                      anx7625_in: endpoint {
>                          remote-endpoint = <&mipi_dsi>;
> +                        bus-type = <5>;
> +                        data-lanes = <0 1 2 3>;
>                      };
>                  };
>  
> -- 
> 2.25.1
> 
> 
