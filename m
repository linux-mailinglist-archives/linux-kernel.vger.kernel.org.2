Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1F636F172
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhD2UyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:54:01 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40711 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhD2UyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:54:00 -0400
Received: by mail-ot1-f48.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso29632281otp.7;
        Thu, 29 Apr 2021 13:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2kIvQcj5VKTETi9VR5NeuJxVfXG0eL9B2iMENedQi4=;
        b=VJDUGwtowlu0HnzjjgKbE2FnLoITvWRQtrhgN+VelJJSnSpF3QGtsnIOhN+R2NDDIK
         UsI1kW6qeQbWcLh1aMoLtBxoj7tiGQs+Fl6yMkGXC7XaqCuYLPVe47BHNlVBuNgpKoR8
         l+gDo8bTwky7tT0wtEicHAFXlA4+QoNWyPExzUPop1330GsHIM5/jnuSvkGTGKFxMxqn
         ibWNIRu3ZMo3qq1uC+bm2h5rxultN6lFDDp8/B5BUUCLdfdn79WGzoXVbBiGDzGOttU4
         yPHKDN83Quw/TG+h8cBTJvA9KAcnO1ZJcWCG8tAr+Jq6REwxn31Omg71j0i4mii0DhQz
         wbLA==
X-Gm-Message-State: AOAM532bn16aGeBBPTjmYhg0ZCjJpS2Cafd2Kb4XQyv9Ubp+Kv3hrddy
        pjoHBBYm90IJl0yFYsrUcQ==
X-Google-Smtp-Source: ABdhPJyR1Inhgik7ojUPmW4noVf7zMJAyrLMSyxi4P9HOKhvCG2lqk6R2xzrW2ugDeMh/krkBqQnDA==
X-Received: by 2002:a9d:449:: with SMTP id 67mr754977otc.333.1619729591989;
        Thu, 29 Apr 2021 13:53:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l3sm84635otj.37.2021.04.29.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 13:53:11 -0700 (PDT)
Received: (nullmailer pid 1758066 invoked by uid 1000);
        Thu, 29 Apr 2021 20:53:10 -0000
Date:   Thu, 29 Apr 2021 15:53:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Message-ID: <20210429205310.GA1729011@robh.at.kernel.org>
References: <cover.1619617498.git.nandor.han@vaisala.com>
 <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 04:50:38PM +0300, Nandor Han wrote:
> Documents the device tree bindings for `bootcount-nvmem` driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../bindings/nvmem/bootcount-nvmem.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
> new file mode 100644
> index 000000000000..cc673452fe0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright (c) Vaisala Oyj. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/bootcount-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bootcount NVMEM bindings
> +
> +maintainers:
> +  - Nandor Han <nandor.han@vaisala.com>
> +
> +description: |
> +  This binding is intendent to describe the hardware location for
> +  storing the bootcount value and magic combo.
> +
> +  The NVMEM cell size should be 2 or 4 bytes.
> +
> +allOf:
> +  - $ref: "nvmem-consumer.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - linux,bootcount-nvmem

What makes this Linux specific? IIRC, u-boot has boot counting function 
too.

> +
> +  nvmem-cells:
> +    description: Phandle to reboot mode nvmem data cell.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  nvmem-cell-names:
> +    description: Name of the NVMEM cell.
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    enum:
> +      - bootcount-regs
> +
> +  linux,bootcount-magic:
> +    description: Override default mask value.
> +    $ref: /schemas/types.yaml#/definitions/uint32

I don't understand what this is. Is it magic or a mask?

> +
> +dependencies:
> +  nvmem-cell-names: [ nvmem-cells ]

Core schema takes care of this.

> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # example with 16 bit nvram cell:
> +  - |
> +    bootcount {
> +        compatible = "linux,bootcount-nvmem";
> +        nvmem-cells = <&bootcount_regs>;
> +        nvmem-cell-names = "bootcount-regs";
> +    };
> +
> +    rtc: rtc@68 {
> +        bootcount_regs: bootcount_nvmem_regs@e {
> +            reg = <0x0e 0x2>;

It would be simpler to just add a compatible here and get rid of the 
'bootcount' node here.

> +        };
> +    };
> +
> +...
> -- 
> 2.26.3
> 
