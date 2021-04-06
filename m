Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72935355935
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbhDFQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:30:16 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:47068 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbhDFQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:30:12 -0400
Received: by mail-oi1-f175.google.com with SMTP id m13so15695159oiw.13;
        Tue, 06 Apr 2021 09:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2hEsi6JFE07gneiywvOCYJVqCpw+M6VpQTy6q9ipN0=;
        b=pfF6wwi++bpGU4/DTo8YmFud1p7chLLQD9G4LYZSe1yZDoyShAlKaQCsLjIwtn60OW
         /irH9Lyvf69EZCV62kk3zk0NuyA7e27Yy37qrFB04W4GZT/+6jESKbYoLDW9gI6ZAPew
         +v1B+tt4nr06fkuRVKrf7SaP1ycVJAf1sOYspPtd9qlUa7VUoMbaWURNkHdIAs4n7bKV
         31b/SOF61ZjQkCqnwMY7q9UhI8LhevSZ/Bk+kVNQA+/yDbVED8RzjvkpjJqBnYDa9XNW
         qh3hxDaluKbpe9Vvm2abCSEPnCVyuWl0yKbVujIUbkmR1XuG3QIUQhICykvqxWEKmfJb
         7/2Q==
X-Gm-Message-State: AOAM5325fZpbrvLr/5Y8CFq4SwGLoGEMNYiIJnHyB9omf6ZtXco9IgsY
        +GbCSAFab7B9+5VUBRr5yQ==
X-Google-Smtp-Source: ABdhPJzEkdAGtjLvNovj6nI0aO1oe6vveWO5yByt0P7mzz4mUHa6gSdQLq68mZ6NfcxanOtirCgnoQ==
X-Received: by 2002:aca:b6d7:: with SMTP id g206mr3897766oif.53.1617726603711;
        Tue, 06 Apr 2021 09:30:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d2sm4849681otl.48.2021.04.06.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:30:02 -0700 (PDT)
Received: (nullmailer pid 1916137 invoked by uid 1000);
        Tue, 06 Apr 2021 16:30:01 -0000
Date:   Tue, 6 Apr 2021 11:30:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411
 hub controller
Message-ID: <20210406163001.GA1910748@robh.at.kernel.org>
References: <20210405201817.3977893-1-mka@chromium.org>
 <20210405124900.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405124900.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 01:18:13PM -0700, Matthias Kaehlcke wrote:
> The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> 
> This initial version of the binding only describes USB related
> aspects of the RTS5411, it does not cover the option of
> connecting the controller as an i2c slave.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v7:
> - added type ref for 'companion-hub' property
> 
> Changes in v6:
> - Realtek binding instead of generic onboard_usb_hub
> - added 'companion-hub' property
> - added reference to 'usb-device.yaml'
> - 'fixed' indentation of compatible entries to keep yamllint happy
> - added 'additionalProperties' entry
> - updated commit message
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
>  .../bindings/usb/realtek,rts5411.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> new file mode 100644
> index 000000000000..b59001972749
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for the Realtek RTS5411 USB 3.0 hub controller
> +
> +maintainers:
> +  - Matthias Kaehlcke <mka@chromium.org>
> +
> +allOf:
> +  - $ref: usb-device.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - usbbda,5411
> +          - usbbda,411
> +

reg: true

to fix the error.

> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +  companion-hub:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      phandle to the companion hub on the controller.

This should be required I think. I suppose you could only hook up 2.0 
ports, but why. And 3.0 only wouldn't be USB compliant, would it?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb-controller {

'usb' is the standard name.

> +        dr_mode = "host";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +            compatible = "usbbda,5411";
> +            reg = <1>;
> +            vdd-supply = <&pp3300_hub>;
> +            companion-hub = <&hub_3_0>;
> +        };
> +
> +        /* 3.0 hub on port 2 */
> +        hub_3_0: hub@2 {
> +            compatible = "usbbda,411";
> +            reg = <2>;
> +            vdd-supply = <&pp3300_hub>;
> +            companion-hub = <&hub_2_0>;
> +        };
> +    };
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
