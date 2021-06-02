Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56088399389
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFBTbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:31:52 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43707 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhFBTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:31:50 -0400
Received: by mail-ot1-f49.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3462700otu.10;
        Wed, 02 Jun 2021 12:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3plZeCz7fgIf1ejmmfS5ZX5SU0qjotsTUM0Caj+WGY8=;
        b=FUGGGcMi2fICO3otOyGjTgGwfkmysTueUG5YrMpntI6RfquoMVuC7Cg+E+BR87drGb
         ZrPw3ap9ASkar1ZG1Ne6ySOhVCnkvUVaXkkpdBqL1G997GKa7m0RVl5XN8qOYKpythgL
         W3+RIxR0q8R7HLEZb1ejMxNEaYEqmPpXGyPOexPHyd5h8MHXkOT59fEa3pQJ0IFyt8wp
         Qd/ZIzvchD2JmOyR/OWFAaD4y5pXF2uUcIjK25gZg3uR7ZTJAp9rFYf/XTwuC2jfWb9Z
         7xSBUe4ye9tVjWlPcu+JrZnIvuNyt4D14CBvdSKQ7NQKVzQpjORKe2iGUhFpId2zpuKH
         lxIQ==
X-Gm-Message-State: AOAM5310Kzw7ClfC4mJtX8ptx1LZWqy+r3kKuqjPK4zvEmEoYoj1i9qa
        hp1WV8gK8JgmJ2WqQXNNow==
X-Google-Smtp-Source: ABdhPJxUTbNZu6gnxSBJHTtYZfLz+pJpkTmBpXapgtA0YZOo3BEVhehVwU+ikqYteSZdmcQlOWzqsw==
X-Received: by 2002:a9d:2904:: with SMTP id d4mr3715611otb.238.1622662192100;
        Wed, 02 Jun 2021 12:29:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q22sm176297otl.11.2021.06.02.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:29:51 -0700 (PDT)
Received: (nullmailer pid 3834982 invoked by uid 1000);
        Wed, 02 Jun 2021 19:29:50 -0000
Date:   Wed, 2 Jun 2021 14:29:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-mtd@lists.infradead.org, Fabio Estevam <festevam@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: devices: add devicetree documentation for
 microchip 48l640
Message-ID: <20210602192950.GA3827845@robh.at.kernel.org>
References: <20210601043546.1345704-1-hs@denx.de>
 <20210601043546.1345704-2-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601043546.1345704-2-hs@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:35:45AM +0200, Heiko Schocher wrote:
> The Microchip 48l640 is a 8KByte EERAM connected via SPI.
> Add devicetree bindings documentation.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
> Changes in v3:
> Add Fabio to cc
> 
> Changes in v2:
> as Rob helped, fix warnings from running command
> 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> 
>  .../bindings/mtd/microchip,mchp48l640.yaml    | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> new file mode 100644
> index 0000000000000..08089f2db0761
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MTD SPI driver for Microchip 48l640 (and similar) serial EERAM

This is not the driver.

> +
> +maintainers:
> +  - Heiko Schocher <hs@denx.de>
> +
> +description: |
> +  The Microchip 48l640 is a 8KByte EERAM connected via SPI.
> +
> +  datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20006055B.pdf
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,48l640
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      spi-eeram@0 {

eeram@0

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>


> +        compatible = "microchip,48l640";
> +        reg = <0>;
> +        spi-max-frequency = <20000000>;
> +      };
> +    };
> +...
> -- 
> 2.31.1
