Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2857D315411
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhBIQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:39:21 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:34952 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhBIQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:39:05 -0500
Received: by mail-oo1-f47.google.com with SMTP id t196so2249316oot.2;
        Tue, 09 Feb 2021 08:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQ88ktMveXLIFjVYi4XLJQTN5XKyqacXyZXIGcsGiCs=;
        b=se2Gzef2zjE2vun3ESZj803I/ck4r+b260eSHSqy46brjWT2zQVBqXuj7HW9388JKd
         M4oY460J2ce5RSME8Y6bc1oDWlYCGHhvdPJp1dvzSrZpUJorNOXTHOghmnWLedDeYl2j
         2cZTjNLunSsahCcGrH2oxEBa6wktK6etbBL+oNhsC/mWCbYwWYQiPUVUYcmlcyg+rc/n
         zyiBssfatE/sPSx4B4vAKGR76xGv+c3em0oCL1mw9a1GMYobGp1BwkgfauF4kJbLCbSD
         gBKvocATGzEnz8SyDX6X/EUA64es3DqhdjEx7V+FJlNVl06DNXBknwMaTDqLCc4w0847
         PBSw==
X-Gm-Message-State: AOAM531TDdTk7aBY947tATIdDLmTuCjiMz04MxAhxhErxcs//jfxmhUV
        0C0sgXVOV0ksXQH5eFIXmQ==
X-Google-Smtp-Source: ABdhPJyVYqJkRSlVwkuaXSCn5iGg2F2ZS9AACtrBVl6W1FRn+PDFWJy5SUmUPRPoMrkPqrR4nEHY2w==
X-Received: by 2002:a4a:424c:: with SMTP id i12mr16605365ooj.85.1612888704019;
        Tue, 09 Feb 2021 08:38:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e30sm48346ooh.32.2021.02.09.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:38:22 -0800 (PST)
Received: (nullmailer pid 3898734 invoked by uid 1000);
        Tue, 09 Feb 2021 16:38:20 -0000
Date:   Tue, 9 Feb 2021 10:38:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add documentation for
 LT8912
Message-ID: <20210209163820.GB3892603@robh.at.kernel.org>
References: <20210124150835.1522899-1-adrien.grassein@gmail.com>
 <20210124150835.1522899-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124150835.1522899-3-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 04:08:34PM +0100, Adrien Grassein wrote:
> Lontium LT8912 is a DSI to HDMI bridge.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../display/bridge/lontium,lt8912.yaml        | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
> new file mode 100644
> index 000000000000..ed1a6ddaab2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/lontium,lt8912.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lontium LT8912 MIPI to HDMI Bridge
> +
> +maintainers:
> +  - Adrien Grassein <adrien.grassein@gmail.com>
> +
> +description: |
> +  The LT8912 is a bridge device which convert DSI to HDMI
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lontium,lt8912
> +
> +  reg:
> +    maxItems: 1
> +
> +  ddc-i2c-bus:

This belongs in an hdmi-connector node.

> +    maxItems: 1
> +    description: i2c bus used to read EDID of the connected display.
> +
> +  dsi-lanes:
> +    maxItems: 1
> +    description: dsi lanes count interconnected with lt8912.

'data-lanes' in the graph is the standard way to do this.

You'll need video-interfaces.yaml which is pending in the media tree.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active high RESET pin.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Primary MIPI port-1 for MIPI input

You're going to need a port for the connector.

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - ddc-i2c-bus
> +  - dsi-lanes
> +  - reg
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c4 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdmi-bridge@48 {
> +        compatible = "lontium,lt8912";
> +        reg = <0x48>;
> +        reset-gpios = <&max7323 0 GPIO_ACTIVE_LOW>;
> +        dsi-lanes = <4>;
> +        ddc-i2c-bus = <&ddc_i2c_bus>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +
> +            hdmi_out_in: endpoint {
> +              remote-endpoint = <&mipi_dsi_out>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +    ddc_i2c_bus: i2c5 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5aa18cbfb883..01e7e356bfac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10472,6 +10472,11 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>  F:	drivers/hid/hid-lg-g15.c
>  
> +LONTIUM LT8912 MIPI TO HDMI BRIDGE
> +M:	Adrien Grassein <adrien.grassein@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> -- 
> 2.25.1
> 
