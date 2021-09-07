Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D66402E92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhIGSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:55:53 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:46636 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:55:52 -0400
Received: by mail-oo1-f52.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso72885oov.13;
        Tue, 07 Sep 2021 11:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TjmhbtbAQZbdA5sDdIp8k5w1YXYBF7DW1ypJqA8M4sc=;
        b=fkmRck5NkILmUOIKSXmPjnLO58LkuZYHHaoKWwkd6Lap/mrJC8K4Bm+5y6XykkhfsV
         kwmrnmU4YWPtxerbaXIX/2tXhenPNaVqKekJ6jHMyN/ITgq2q9muf2sagXjGbBHVR1LW
         3C7N51eoIoWBQUyQj78SOGFzWvdkMqySRkJoaMZMgqgmb77x9CewJVDyKvB1a9VBFp3k
         XiuCTaBsU6uZN2QTdmktZ7B+c3CjnlZoe4YtmyNYXQ3qQrRihw1cbZx29W9F8ZL4zEpj
         ondUIe6zYJ5WezHWgRAJa1t8majUeiJJmcpADkM9Sjar69GbLtk5AOm0G4OpaPsMneAp
         HOKA==
X-Gm-Message-State: AOAM530FuSm31fXhlzBBfWoagCAX0VNF+sGCx/ESkA1kspYQdzxqyYkP
        NgImpdRhi8ioatrnETKlww==
X-Google-Smtp-Source: ABdhPJwvYTYVwXR6dJBS4wHju5OX2gY6JN2C0XJL6fY8147yLZ5rYVaL0bvfsxX9SjcpL0w1Bmm/Dg==
X-Received: by 2002:a4a:d48c:: with SMTP id o12mr1125675oos.55.1631040885198;
        Tue, 07 Sep 2021 11:54:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z15sm956437oth.73.2021.09.07.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:54:44 -0700 (PDT)
Received: (nullmailer pid 149997 invoked by uid 1000);
        Tue, 07 Sep 2021 18:54:43 -0000
Date:   Tue, 7 Sep 2021 13:54:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mparab@cadence.com, vigneshr@ti.com, kishon@ti.com
Subject: Re: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for
 Cadence UFS host controller
Message-ID: <YTe1c7sxlL9HGxv7@robh.at.kernel.org>
References: <20210826185135.26599-2-dkangude@cadence.com>
 <20210902063754.9509-1-dkangude@cadence.com>
 <20210902063754.9509-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902063754.9509-2-dkangude@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:37:54AM +0200, Dhananjay Kangude wrote:
> 1.Converted bindings into yaml format for Cadence UFS host controller
> 2.Modified reference to cdns,ufshc.txt tp cdns,ufshc.yaml
> 3.Removed power,domain property from ti,j721e-ufs.yaml as it is not required

Maybe not required, but should be allowed which is still not the case.

> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |    3 +-
>  3 files changed, 81 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> deleted file mode 100644
> index 02347b0..0000000
> --- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* Cadence Universal Flash Storage (UFS) Controller
> -
> -UFS nodes are defined to describe on-chip UFS host controllers.
> -Each UFS controller instance should have its own node.
> -Please see the ufshcd-pltfrm.txt for a list of all available properties.
> -
> -Required properties:
> -- compatible	: Compatible list, contains one of the following controllers:
> -			"cdns,ufshc" - Generic CDNS HCI,
> -			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm PHY
> -		  complemented with the JEDEC version:
> -			"jedec,ufs-2.0"
> -
> -- reg		: Address and length of the UFS register set.
> -- interrupts	: One interrupt mapping.
> -- freq-table-hz	: Clock frequency table.
> -		  See the ufshcd-pltfrm.txt for details.
> -- clocks	: List of phandle and clock specifier pairs.
> -- clock-names	: List of clock input name strings sorted in the same
> -		  order as the clocks property. "core_clk" is mandatory.
> -		  Depending on a type of a PHY,
> -		  the "phy_clk" clock can also be added, if needed.
> -
> -Example:
> -	ufs@fd030000 {
> -		compatible = "cdns,ufshc", "jedec,ufs-2.0";
> -		reg = <0xfd030000 0x10000>;
> -		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
> -		freq-table-hz = <0 0>, <0 0>;
> -		clocks = <&ufs_core_clk>, <&ufs_phy_clk>;
> -		clock-names = "core_clk", "phy_clk";
> -	};
> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> new file mode 100644
> index 0000000..4509ae0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ufs/cdns,ufshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence Universal Flash Storage (UFS) Controller
> +
> +maintainers:
> +  - Dhananjay Kangude <dkangude@cadence.com>
> +
> +description:
> +  UFS nodes are defined to describe on-chip Cadence UFS host controllers.
> +  Each UFS controller instance should have its own node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cdns,ufshc
> +              - cdns,ufshc-m31-16nm
> +          - const: jedec,ufs-2.0
> +      - items:
> +          - const: jedec,ufs-2.0
> +
> +  reg:
> +    items:
> +      - description: UFS controller register set

Not a useful description. Just 'maxItems: 1'.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: Description of core_clk
> +      - description: Description of phy_clk
> +      - description: Description of ref_clk

'Description of core_clk'?

ref_clk was not documented. Okay to add, but mention why in the commit 
msg.

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core_clk
> +      - const: phy_clk
> +      - const: ref_clk
> +
> +  freq-table-hz:
> +    $ref: /schemas/types.yaml#/definitions/uint64-matrix

Not the right type.

> +    description:
> +      Clock frequency table.
> +      See the ufshcd-pltfrm.txt for details.
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - freq-table-hz
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +unevaluatedProperties: false

Don't need both. Just additionalProperties.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ufs: ufs@fd030000 {
> +         compatible = "cdns,ufshc", "jedec,ufs-2.0";
> +         reg = <0xfd030000 0x10000>;
> +         interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
> +         freq-table-hz = <0 0>;
> +         clocks = <&ufs_core_clk>;
> +         clock-names = "core_clk";
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> index 4d13e6b..b8f73dd 100644
> --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> @@ -50,7 +50,7 @@ patternProperties:
>      type: object
>      description: |
>        Cadence UFS controller node must be the child node. Refer
> -      Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for binding
> +      Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml for binding
>        documentation of child node
>  
>  additionalProperties: false
> @@ -81,7 +81,6 @@ examples:
>                  reg = <0x0 0x4000 0x0 0x10000>;
>                  interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>                  freq-table-hz = <19200000 19200000>;
> -                power-domains = <&k3_pds 277>;
>                  clocks = <&k3_clks 277 1>;
>                  assigned-clocks = <&k3_clks 277 1>;
>                  assigned-clock-parents = <&k3_clks 277 4>;
> -- 
> 1.7.1
> 
> 
