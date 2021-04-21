Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D536753D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbhDUWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:41:18 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33725 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDUWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:41:18 -0400
Received: by mail-ot1-f45.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso17907577otl.0;
        Wed, 21 Apr 2021 15:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQELPAcx4r8r1G2/6bk2QQXKHGwcPfLjNXv4IU1C2JI=;
        b=tX2Eb85jE2pN1AYwht6cLS+rUAjp6wB5NmU+eCUNibhZO5Zzw8lGRs3gv34wfd9Gno
         Zc3pkCWkEHJRvOctKB0C71D/aQDfRQkUkIQKaXxbM8CinvcEMwIMjPi0fhedrkJcYBec
         iwZbJgvS42nNpC1i83ReSOsa8axFV2MMDavWDDKnseG6vsrKyhxZqDEwaLxRBDDtm2JK
         aYaAgOPFYGUldgP79A5IPhjRrH8LwNDKYX12jZnpb8TGnqXaR42R2kLij6OHlNhnG6Ll
         pQW3RBVYLpysDlBVNE020YOZpx4lEyyhwoWpl3DdNdxP2adE9LQCzthkc9H0rIfPdeMc
         zEEw==
X-Gm-Message-State: AOAM531cmKi3XjwvQ1hmLrUs6mV7LIAUE2rf2yU+jV1aLRP5SjI+z+r8
        vNOg/hgJp6ri0dIf2O1xE25rm2tCFQ==
X-Google-Smtp-Source: ABdhPJwqIxWHS9pI2qaVwYS391Uf7+mqnQF5mRHq/DXmLnfo0ncTFGZ77MWZSTBi7cM0JkzXR0bVJA==
X-Received: by 2002:a9d:394:: with SMTP id f20mr357464otf.220.1619044844111;
        Wed, 21 Apr 2021 15:40:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p22sm207821otf.25.2021.04.21.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:40:42 -0700 (PDT)
Received: (nullmailer pid 1745763 invoked by uid 1000);
        Wed, 21 Apr 2021 22:40:41 -0000
Date:   Wed, 21 Apr 2021 17:40:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: arm: keystone: Convert ti,sci to json
 schema
Message-ID: <20210421224041.GA1740292@robh.at.kernel.org>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-5-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416063721.20538-5-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:37:21AM -0500, Nishanth Menon wrote:
> Convert the ti,sci to json schema for better checks and documentation.
> 
> NOTE: This change does introduce a stricter naming convention for
> TI-SCI controller nodes.
> 
> NOTE: we do have false positive checkpatch warning with this patch:
> "DT binding docs and includes should be a separate patch"
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
>  .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> deleted file mode 100644
> index 6f0cd31c1520..000000000000
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -Texas Instruments System Control Interface (TI-SCI) Message Protocol
> ---------------------------------------------------------------------
> -
> -Texas Instrument's processors including those belonging to Keystone generation
> -of processors have separate hardware entity which is now responsible for the
> -management of the System on Chip (SoC) system. These include various system
> -level functions as well.
> -
> -An example of such an SoC is K2G, which contains the system control hardware
> -block called Power Management Micro Controller (PMMC). This hardware block is
> -initialized early into boot process and provides services to Operating Systems
> -on multiple processors including ones running Linux.
> -
> -See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
> -
> -TI-SCI controller Device Node:
> -=============================
> -
> -The TI-SCI node describes the Texas Instrument's System Controller entity node.
> -This parent node may optionally have additional children nodes which describe
> -specific functionality such as clocks, power domain, reset or additional
> -functionality as may be required for the SoC. This hierarchy also describes the
> -relationship between the TI-SCI parent node to the child node.
> -
> -Required properties:
> --------------------
> -- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
> -		should be "ti,am654-sci" for for TI AM654 SoC
> -- mbox-names:
> -	"rx" - Mailbox corresponding to receive path
> -	"tx" - Mailbox corresponding to transmit path
> -
> -- mboxes: Mailboxes corresponding to the mbox-names. Each value of the mboxes
> -	  property should contain a phandle to the mailbox controller device
> -	  node and an args specifier that will be the phandle to the intended
> -	  sub-mailbox child node to be used for communication.
> -
> -See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
> -about the generic mailbox controller and client driver bindings. Also see
> -Documentation/devicetree/bindings/mailbox/ti,message-manager.txt for typical
> -controller that is used to communicate with this System controllers.
> -
> -Optional Properties:
> --------------------
> -- reg-names:
> -	debug_messages - Map the Debug message region
> -- reg:  register space corresponding to the debug_messages
> -- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
> -- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
> -	for identification of host processing entities such as virtual
> -	machines
> -
> -Example (K2G):
> --------------
> -	pmmc: pmmc {
> -		compatible = "ti,k2g-sci";
> -		ti,host-id = <2>;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
> -			<&msgmgr &msgmgr_proxy_pmmc_tx>;
> -		reg-names = "debug_messages";
> -		reg = <0x02921800 0x800>;
> -	};
> -
> -
> -TI-SCI Client Device Node:
> -=========================
> -
> -Client nodes are maintained as children of the relevant TI-SCI device node.
> -
> -Example (K2G):
> --------------
> -	pmmc: pmmc {
> -		compatible = "ti,k2g-sci";
> -		...
> -
> -		my_clk_node: clk_node {
> -			...
> -			...
> -		};
> -
> -		my_pd_node: pd_node {
> -			...
> -			...
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> new file mode 100644
> index 000000000000..3e835ad84dc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/keystone/ti,sci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI-SCI controller device node bindings
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +allOf:
> +  - $ref: /schemas/mbox/mbox-consumer.yaml#

Drop.

> +
> +description: |
> +  Texas Instrument's processors including those belonging to Keystone generation
> +  of processors have separate hardware entity which is now responsible for the
> +  management of the System on Chip (SoC) system. These include various system
> +  level functions as well.
> +
> +  An example of such an SoC is K2G, which contains the system control hardware
> +  block called Power Management Micro Controller (PMMC). This hardware block is
> +  initialized early into boot process and provides services to Operating Systems
> +  on multiple processors including ones running Linux.
> +
> +  See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
> +
> +  The TI-SCI node describes the Texas Instrument's System Controller entity node.
> +  This parent node may optionally have additional children nodes which describe
> +  specific functionality such as clocks, power domain, reset or additional
> +  functionality as may be required for the SoC. This hierarchy also describes the
> +  relationship between the TI-SCI parent node to the child node.
> +
> +properties:
> +  $nodename:
> +    pattern: "^system-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    oneOf:
> +      - description: System controller on TI 66AK2G SoC and other K3 SoCs
> +        items:
> +          - const: ti,k2g-sci
> +      - description: System controller on TI AM654 SoC
> +        items:
> +          - const: ti,am654-sci
> +
> +  reg-names:
> +    description: |
> +      Specifies the debug messages memory mapped region that is optionally
> +      made available from TI-SCI controller.
> +      - const: debug_messages

Drop the '-' and fix the indent so it's an actual schema.

> +
> +  reg:
> +    minItems: 1
> +
> +  mbox-names:
> +    description: |
> +      Specifies the mailboxes used to communicate with TI-SCI Controller
> +      made available from TI-SCI controller.
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  mboxes:
> +    minItems: 2
> +
> +  ti,system-reboot-controller:
> +    description: Determines If system reboot can be triggered by SoC reboot
> +    type: boolean
> +
> +  ti,host-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value corresponding to the host ID assigned by Firmware
> +      for identification of host processing entities such as virtual machines.
> +
> +required:
> +  - compatible
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  # All other properties should be a power, clock or reset controller
> +  "^(power-controller|clock-controller|reset-controller)$":
> +    type: object
> +    oneOf:
> +      - $ref: /schemas/soc/ti/sci-pm-domain.yaml#
> +      - $ref: /schemas/clock/ti,sci-clk.yaml#
> +      - $ref: /schemas/reset/ti,sci-reset.yaml#

I'd prefer you separate these with a property for each node.

> +
> +examples:
> +  - |
> +    pmmc: system-controller@2921800 {
> +      compatible = "ti,k2g-sci";
> +      ti,system-reboot-controller;
> +      mbox-names = "rx", "tx";
> +      mboxes= <&msgmgr 5 2>,
> +              <&msgmgr 0 0>;
> +      reg-names = "debug_messages";
> +      reg = <0x02921800 0x800>;
> +    };
> +
> +  - |
> +    dmsc: system-controller@44083000 {
> +      compatible = "ti,k2g-sci";
> +      ti,host-id = <12>;
> +      mbox-names = "rx", "tx";
> +      mboxes= <&secure_proxy_main 11>,
> +              <&secure_proxy_main 13>;
> +      reg-names = "debug_messages";
> +      reg = <0x44083000 0x1000>;
> +
> +      k3_pds: power-controller {
> +        compatible = "ti,sci-pm-domain";
> +        #power-domain-cells = <2>;
> +      };
> +
> +      k3_clks: clock-controller {
> +        compatible = "ti,k2g-sci-clk";
> +        #clock-cells = <2>;
> +      };
> +
> +      k3_reset: reset-controller {
> +        compatible = "ti,sci-reset";
> +        #reset-cells = <2>;
> +      };
> +    };
> -- 
> 2.31.0
> 
