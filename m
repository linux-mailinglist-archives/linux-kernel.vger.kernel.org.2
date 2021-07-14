Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F63C8B56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhGNTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:02:19 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33398 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhGNTCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:02:17 -0400
Received: by mail-io1-f50.google.com with SMTP id z11so3486493iow.0;
        Wed, 14 Jul 2021 11:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqn/UuKDKBVB65aNlLqXAidjfeKUMUwTatpSpLAxY4U=;
        b=Tg0iPwpS5QNTRtOlO9GO+X+CmTx09K7dyV73lGBbCsGpzmvYkjX7kRDCGAANr1Wbbh
         +Y3A4sxeFnp9kC8AbzYn2ZvX23YqilRInTk+PhUJlMMa1xlUwkWOWF313t2QSYrflQd+
         szpjYMPHOCuKOvB4V0QB0XxGz/i7pvsy6vTu4yg6L0lxrz9M8IqTIMnpiUASCd1VAgFg
         A/MdvbuS55EBSuEX3nY/LtlpgzFG9PXGo0og54Y2aDvTleoGFOxTenCPEjpfs8FALGNd
         +Oiwk6EnqjFaue0oWsAvYFJ2DCidxbvKQb7FeEUoEn6/DBxTVa+k5QyjxgcoxlxhNdLf
         upRw==
X-Gm-Message-State: AOAM531aVisfg16DCK8gSVj090iYIQHEBgSbDWmjmz4cGlOFuHfgYVMe
        zwic8xPtE6//2aQVJBcZ6Q==
X-Google-Smtp-Source: ABdhPJxYKPIleDLKeTmh50SEBn76TTQwAq6xmaa4599i+vpnmfWqT0gXTEERcjvubH19PDmCTkbwVg==
X-Received: by 2002:a02:9109:: with SMTP id a9mr10232121jag.93.1626289165340;
        Wed, 14 Jul 2021 11:59:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16sm1696281iln.30.2021.07.14.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:59:24 -0700 (PDT)
Received: (nullmailer pid 2937232 invoked by uid 1000);
        Wed, 14 Jul 2021 18:59:22 -0000
Date:   Wed, 14 Jul 2021 12:59:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: Re: [PATCH] dt-bindings: nvmem: Convert UniPhier eFuse bindings to
 json-schema
Message-ID: <20210714185922.GA2857803@robh.at.kernel.org>
References: <1624413058-17338-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624413058-17338-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:50:58AM +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier eFuse binding to DT schema format.
> 
> Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 109 +++++++++++++++++++++
>  .../devicetree/bindings/nvmem/uniphier-efuse.txt   |  49 ---------
>  2 files changed, 109 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
> new file mode 100644
> index 0000000..e03c1ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/socionext,uniphier-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier eFuse bindings
> +
> +maintainers:
> +  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    const: socionext,uniphier-efuse
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+,[0-9]+$":

nvmem.yaml has a different definition. Though it doesn't handle 
overlapping addresses. You should extend nvmem.yaml like you have here. 
The last part should be optional though.

> +    type: object
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      bits:
> +        maxItems: 1
> +
> +    required:
> +      - reg

All this is already defined in nvmem.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Use 'unevaluatedProperties: false' and then you don't need to redefine 
anything common here.

> +
> +examples:
> +  - |
> +    // The UniPhier eFuse should be a subnode of a "soc-glue" node.
> +
> +    soc-glue@5f900000 {
> +        compatible = "simple-mfd";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x5f900000 0x2000>;
> +
> +        efuse@100 {
> +            compatible = "socionext,uniphier-efuse";
> +            reg = <0x100 0x28>;
> +        };
> +
> +        efuse@200 {
> +            compatible = "socionext,uniphier-efuse";
> +            reg = <0x200 0x68>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            /* Data cells */
> +            usb_rterm0: trim@54,4 {
> +                reg = <0x54 1>;
> +                bits = <4 2>;
> +            };
> +            usb_rterm1: trim@55,4 {
> +                reg = <0x55 1>;
> +                bits = <4 2>;
> +            };
> +            usb_rterm2: trim@58,4 {
> +                reg = <0x58 1>;
> +                bits = <4 2>;
> +            };
> +            usb_rterm3: trim@59,4 {
> +                reg = <0x59 1>;
> +                bits = <4 2>;
> +            };
> +            usb_sel_t0: trim@54,0 {
> +                reg = <0x54 1>;
> +                bits = <0 4>;
> +            };
> +            usb_sel_t1: trim@55,0 {
> +                reg = <0x55 1>;
> +                bits = <0 4>;
> +            };
> +            usb_sel_t2: trim@58,0 {
> +                reg = <0x58 1>;
> +                bits = <0 4>;
> +            };
> +            usb_sel_t3: trim@59,0 {
> +                reg = <0x59 1>;
> +                bits = <0 4>;
> +            };
> +            usb_hs_i0: trim@56,0 {
> +                reg = <0x56 1>;
> +                bits = <0 4>;
> +            };
> +            usb_hs_i2: trim@5a,0 {
> +                reg = <0x5a 1>;
> +                bits = <0 4>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> deleted file mode 100644
> index eccf490..0000000
> --- a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -= UniPhier eFuse device tree bindings =
> -
> -This UniPhier eFuse must be under soc-glue.
> -
> -Required properties:
> -- compatible: should be "socionext,uniphier-efuse"
> -- reg: should contain the register location and length
> -
> -= Data cells =
> -Are child nodes of efuse, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> -Example:
> -
> -	soc-glue@5f900000 {
> -		compatible = "socionext,uniphier-ld20-soc-glue-debug",
> -			     "simple-mfd";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x0 0x5f900000 0x2000>;
> -
> -		efuse@100 {
> -			compatible = "socionext,uniphier-efuse";
> -			reg = <0x100 0x28>;
> -		};
> -
> -		efuse@200 {
> -			compatible = "socionext,uniphier-efuse";
> -			reg = <0x200 0x68>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			/* Data cells */
> -			usb_mon: usb-mon@54 {
> -				reg = <0x54 0xc>;
> -			};
> -		};
> -	};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -Example:
> -
> -	usb {
> -		...
> -		nvmem-cells = <&usb_mon>;
> -		nvmem-cell-names = "usb_mon";
> -	}
> -- 
> 2.7.4
> 
> 
