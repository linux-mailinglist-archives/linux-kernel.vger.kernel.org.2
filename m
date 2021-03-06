Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9D32FCD9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCFToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:44:11 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:54052 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhCFTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:43:53 -0500
Received: by mail-pj1-f50.google.com with SMTP id kx1so1001806pjb.3;
        Sat, 06 Mar 2021 11:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5a0YrJEh1d50dCvaOBmjSqOGqFRau91YasJJ1sqK3+g=;
        b=TnQK8bwfhEbYW9mHCbSPWxsal8y7Gm96VK8AkyRN7CQsH8gFfCIitl37tsf9UxgIu4
         tODpejbVz/IxL0FFz9JS6nosuGU3vIfx55fQRx/J2aeDxazGnCFybPEv5qY3Gg/xZjiU
         VK0Ju2tKoY+4YkpARlUg0LuthBu237ifSfLQQIl2iexJKt91APKARH0NUv5qH8lyHmlT
         Vve+t1URSSFUqFwbzfDgmoguLCqTa+D3wgwM82lfnbJqWr7+19nfIAaYxB0WOP+6VYBC
         Wr0BQeQqbiVQ9VmAUuYu0lLKR/zwgPsfZFTXJ2+zmnQqUrCxkngnkGgN5O8jLm6iIYYq
         3dYQ==
X-Gm-Message-State: AOAM532zUCFyaQ28eiu+/QEZQwEW1PaBuwnpwRpXb6BneP5+Wc1IG0ZK
        oEstIgsEQ4/5ajCP7LYQLXIiSq9TtRwV
X-Google-Smtp-Source: ABdhPJxeupPgywgemhIZt1Ox3xG6NnSum38t5lezwu82m1cZb3YM7OsGntMwVLJhkQa3OJES4kPOzw==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id fr10mr17123192pjb.18.1615059832991;
        Sat, 06 Mar 2021 11:43:52 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id w27sm6095532pfq.105.2021.03.06.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:43:52 -0800 (PST)
Received: (nullmailer pid 1098355 invoked by uid 1000);
        Sat, 06 Mar 2021 19:43:47 -0000
Date:   Sat, 6 Mar 2021 11:43:47 -0800
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411
 hub controller
Message-ID: <20210306194347.GA1095701@robh.at.kernel.org>
References: <20210305193853.2040456-1-mka@chromium.org>
 <20210305113832.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305113832.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 11:38:49AM -0800, Matthias Kaehlcke wrote:
> The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> 
> This initial version of the binding only describes USB related
> aspects of the RTS5411, it does not cover the option of
> connecting the controller as an i2c slave.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
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
>  .../bindings/usb/realtek,rts5411.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> new file mode 100644
> index 000000000000..00e9b3d44583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> @@ -0,0 +1,58 @@
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
> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +  companion-hub:
> +    description:
> +      phandle to the companion hub on the controller.

Needs a type ref.

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
> 2.30.1.766.gb4fecdf3b7-goog
> 
