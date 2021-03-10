Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7E33336B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCJC7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:59:08 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:33926 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCJC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:58:36 -0500
Received: by mail-io1-f50.google.com with SMTP id o11so16372884iob.1;
        Tue, 09 Mar 2021 18:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NvJfFHHjSXrZPelJXpOGfvsgnRgrEictZAVxjsaxjas=;
        b=tkZLrHMUoEIzNZUUBf3Xh680ueg/ZpFC/Jk3wwVmWUzc2yt2MVs//jk9IjPDJumQX1
         UhVx7ltwnp26diuJLz+t29V8Qu9uY/LCuJro1OOVkn6ht2b+0tZy90bjuWVQgIaRpWoR
         lb4ZAhnLu9LReyK/2DHwcxzzsD1jap+KyBvl1qiUImuNbL0lzkuYcdtH2r/SQhf7WLSe
         cjYOTECWQNaQnYnQfwOProXAsSHu0ymWkGmmL7sd4sWPQjCJaKD2gG29D1H0WsRhViht
         OXDugtHZtwXFfpsPMaDfqcGFjJ5VmJYlbZM2n1lscOB9qv3WvP72+INmMywvcXFMXdqM
         A1LQ==
X-Gm-Message-State: AOAM532K3X/3nUsc0rcXdGshW4Z9MK0f+I+QSddEHpHMioiliBNOF6E+
        3eiMyZCadw+XhCK+uZjbI6iS4XuXOA==
X-Google-Smtp-Source: ABdhPJw0dsp1wd3hNPwCczjvlSXXqWBrXy3V0hN2TVom21FlXwsJ7NadVMljd7bSQbl+chvYmUU7Ow==
X-Received: by 2002:a05:6602:1641:: with SMTP id y1mr1016044iow.34.1615345116172;
        Tue, 09 Mar 2021 18:58:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y3sm8341675iot.15.2021.03.09.18.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:58:35 -0800 (PST)
Received: (nullmailer pid 1660968 invoked by uid 1000);
        Wed, 10 Mar 2021 02:58:33 -0000
Date:   Tue, 9 Mar 2021 19:58:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <20210310025833.GA1658557@robh.at.kernel.org>
References: <20210308011853.19360-1-ansuelsmth@gmail.com>
 <20210308011853.19360-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308011853.19360-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 02:18:45AM +0100, Ansuel Smith wrote:
> Document nvmem-cells compatible used to treat mtd partitions as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/nvmem-cells.yaml  | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> new file mode 100644
> index 000000000000..4ed246b27985
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvmem cells
> +
> +description: |
> +  This binding can be used to treat the specific partition as a nvmem provider.
> +  Each direct subnodes represents the nvmem cells and won't be parsed as fixed-partitions.
> +  Fixed-partitions bindings described in fixed-partitions.yaml apply to the nvmem provider node.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +

I think this should reference nvmem.yaml. We can drop the $nodename 
restrictions in it.

> +properties:
> +  compatible:
> +    const: nvmem-cells
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  reg:
> +    description: partition offset and size within the flash
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    partitions {
> +      compatible = "fixed-partitions";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      /* ... */
> +
> +      };
> +      art: art@1200000 {
> +        compatible = "nvmem-cells";
> +        reg = <0x1200000 0x0140000>;
> +        label = "art";
> +        read-only;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        macaddr_gmac1: macaddr_gmac1@0 {
> +          reg = <0x0 0x6>;
> +        };
> +
> +        macaddr_gmac2: macaddr_gmac2@6 {
> +          reg = <0x6 0x6>;
> +        };
> +
> +        pre_cal_24g: pre_cal_24g@1000 {
> +          reg = <0x1000 0x2f20>;
> +        };
> +
> +        pre_cal_5g: pre_cal_5g@5000{
> +          reg = <0x5000 0x2f20>;
> +        };
> +      };
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            label = "bootloader";
> +            reg = <0x000000 0x100000>;
> +            read-only;
> +        };
> +
> +        firmware@100000 {
> +            compatible = "brcm,trx";
> +            label = "firmware";
> +            reg = <0x100000 0xe00000>;
> +        };
> +
> +        calibration@f00000 {
> +            compatible = "nvmem-cells";
> +            label = "calibration";
> +            reg = <0xf00000 0x100000>;
> +            ranges = <0 0xf00000 0x100000>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            wifi0@0 {
> +                reg = <0x000000 0x080000>;
> +            };
> +
> +            wifi1@80000 {
> +                reg = <0x080000 0x080000>;
> +            };
> +        };
> +    };
> -- 
> 2.30.0
> 
