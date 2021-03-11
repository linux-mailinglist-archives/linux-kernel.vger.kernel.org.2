Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C326337ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhCKRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:32:49 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:45435 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:32:25 -0500
Received: by mail-il1-f180.google.com with SMTP id s1so19628091ilh.12;
        Thu, 11 Mar 2021 09:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mciBxnYC8ZTMruTsj3A3327ldspmTar14yGRG/X9ADw=;
        b=twXjg20hOh+9vs/EusiW0My71WLMbM+5Kq8khjjZipT3urUU4YNw6NEXt4iLWbS6O4
         qwG2CAG8V/CQU/iV5r3LaO3983r7p/Zi98V6/lkr/GjL0QxfM38V7LB1EwNiFrs+BexE
         y5apCjEvOMOu7fUKzRY5KjS3q8vfP14mxeeWAMn0bkTd2q6vUZbN11OEtzH7YGdOq0ZO
         pz5w3s9nKQTTb6s36KuC04s/rMygB3Eb9PMEohbhHp9jc8n1zp+lomiDzcQBrvsa4Hab
         qNXYZfmHjEUQPX1nmSoEdpriqnrvCr0m9kbAxONTCXn8cRHMCZhN/h8muslY7XXdK8jO
         e77A==
X-Gm-Message-State: AOAM532nWX3pm6zvK3XCYMfyl7XH34jU7zh1bTJCVQiXcNijgPFbmw2x
        TkASTw0dbUasFDH8uDg//eDRUxePJA==
X-Google-Smtp-Source: ABdhPJw33c7UkDeD10+NXNJn3sij95d8ma7Y6H5nWgbBsMNXhiJJlw09dJacyGQlFWCO5FIIUqgIYA==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr8130601ilu.277.1615483944718;
        Thu, 11 Mar 2021 09:32:24 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m9sm95215ilf.53.2021.03.11.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:32:23 -0800 (PST)
Received: (nullmailer pid 920025 invoked by uid 1000);
        Thu, 11 Mar 2021 17:32:21 -0000
Date:   Thu, 11 Mar 2021 10:32:21 -0700
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <20210311173221.GB866234@robh.at.kernel.org>
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
 <20210311051309.16789-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311051309.16789-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 06:12:48AM +0100, Ansuel Smith wrote:
> Document nvmem-cells compatible used to treat mtd partitions as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> new file mode 100644
> index 000000000000..b53faf87d4e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvmem cells
> +
> +description: |
> +  Any partition containing the compatible "nvmem-cells" will register as a
> +  nvmem provider.
> +  Each direct subnodes represents a nvmem cell following the nvmem binding.
> +  Nvmem binding to declare nvmem-cells can be found in:
> +  Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +allOf:
> +  - $ref: "../../nvmem/nvmem.yaml#"

I'd rather have the 'absolute' path:

/schemas/nvmem/nvmem.yaml

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +properties:
> +  compatible:
> +    const: nvmem-cells
> +
> +required:
> +  - compatible
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
