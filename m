Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6731E100
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhBQVFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:05:42 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33881 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhBQVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:05:25 -0500
Received: by mail-oi1-f173.google.com with SMTP id j5so4276788oie.1;
        Wed, 17 Feb 2021 13:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKAFux8XcEkNyoW3lOTVnQo4Rj14jUDRtsW9J/H/LJg=;
        b=KJjk4+ST/0u1awn7YEo3bjd+H0pIXykUUaQbfzRUI9UROPMmylwX+fFuzdROBLSpaW
         O3LI8vExRvOmYdaMbd/Md76YlUImRp+ehyWDu2I7kbfkcbXKI8T5BJQbeG7XVyjXZfXj
         u1KkOQQu9RkH5ubKgjGgavQNWbbZXaOi598En+fsid8ksbCP7SKQHHpjqFJISOL6JGBZ
         W2uEdpMOizS4w4KIhtcRAJOBMlLrHUC6v7pcgaTr1H6BfECKWnxbPL0cZ5TLXnkLa3Zi
         yKlh+3Du94lXbTD/JTYySxRGY6pIMaaCvwDvj2nYggtR5EBXj1zlAQUKYza2IueI4rk2
         7pKw==
X-Gm-Message-State: AOAM5316oagBCBLkQ43fY/EhMutv4R+WKTb/v2Y2E4QBb6cuhGFKWHrP
        Z7uEtjxnTuGA5L/BQO6fsg==
X-Google-Smtp-Source: ABdhPJxh3dS23qtLfh7ls7pqVObEW5PGwbQ5egZFAPvIdN9ALx8kFVv2h6t+P8NvUL6Sf6mmMyx8oA==
X-Received: by 2002:a05:6808:115:: with SMTP id b21mr476463oie.110.1613595883842;
        Wed, 17 Feb 2021 13:04:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm622099oth.38.2021.02.17.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:04:43 -0800 (PST)
Received: (nullmailer pid 2752193 invoked by uid 1000);
        Wed, 17 Feb 2021 21:04:41 -0000
Date:   Wed, 17 Feb 2021 15:04:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20210217210441.GA2709172@robh.at.kernel.org>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:10:36AM -0800, Matthias Kaehlcke wrote:
> Discrete onboard USB hubs (an example for such a hub is the Realtek
> RTS5411) need to be powered and may require initialization of other
> resources (like GPIOs or clocks) to work properly. This adds a device
> tree binding for these hubs.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v5:
> - updated 'title'
> - only use standard USB compatible strings
> - deleted 'usb_hub' node
> - renamed 'usb_controller' node to 'usb-controller'
> - removed labels from USB nodes
> - added 'vdd-supply' to USB nodes
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - updated commit message
> - removed recursive reference to $self
> - adjusted 'compatible' definition to support multiple entries
> - changed USB controller phandle to be a node
> 
> Changes in v2:
> - removed 'wakeup-source' and 'power-off-in-suspend' properties
> - consistently use spaces for indentation in example
> 
>  .../bindings/usb/onboard_usb_hub.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> new file mode 100644
> index 000000000000..bf4ec52e6c7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for discrete onboard USB hubs

This isn't really generic. Maybe there's a set of hubs with only a 
single supply much like 'simple-panel', but I kind of doubt that here. 
There aren't hundreds of hub chips like panels. Though, we should put 
this into bindings/usb/hub/ so we start collecting hub bindings in one 
place.

A generic driver doesn't have to have a generic binding. You can have a 
specific device binding which is handled by a generic driver. Or not. 
Who knows. Maybe a simple user like u-boot has a generic driver while 
something more feature rich has a device specific binding.

> +
> +maintainers:
> +  - Matthias Kaehlcke <mka@chromium.org>

Now we have usb-device.yaml, you need:

allOf:
  - $ref: usb-device.yaml#

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - usbbda,5411
> +        - usbbda,411
> +
> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +required:
> +  - compatible
> +  - vdd-supply
> +
> +examples:
> +  - |
> +    usb-controller {
> +        dr_mode = "host";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +            compatible = "usbbda,5411";
> +            reg = <1>;
> +            vdd-supply = <&pp3300_hub>;
> +        };
> +
> +        /* 3.0 hub on port 2 */
> +        hub_3_0: hub@2 {
> +            compatible = "usbbda,411";
> +            reg = <2>;
> +            vdd-supply = <&pp3300_hub>;
> +        };
> +    };
> +
> +...
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
