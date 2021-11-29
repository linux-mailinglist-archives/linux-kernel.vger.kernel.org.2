Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF3460C15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhK2BRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:17:39 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:38402 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhK2BPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:15:38 -0500
Received: by mail-oo1-f54.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5205792ooj.5;
        Sun, 28 Nov 2021 17:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03605aa61GPqAkMuEDxiULscPlb4IrQgvCCxdTvrYo0=;
        b=HBQbc4uQGlpZO4dqIXLy2rK2wzmMkE1rTj3HQt7VmI5MYVgmqMZ539ISNxvwtNxd1g
         nJ7myIf7lG0GfUP2IOa8Q7zlgWarl7rDssHjHHWLXIQobB6KPcaKgmftr1Ajmhb+uEae
         eKmfWdQk3qke5ILBikDxRvUvtYWSyolhFi4NhSx6iYYo8egXKKoxehqwzorV16jjcVfs
         Bhh3TWLfFrOBTjSQvRThwTvClxOhd04gIg+XZ6D2p5mQ05vQhFgY1d0KoL8cgTF4npxZ
         Je9I/jeY9nKFVjwFyNDESodLwgkwDFTzOCxpsQHLnjUu+9ZGB9lN0T/T+V0iUmFUgdls
         VSJw==
X-Gm-Message-State: AOAM533eAfCevxqBuvakOqVLLWlmA7GIcCD0dHdW4bT87nBrbMMLmdom
        91uYpm81eBB3iq3tmEnjZQ==
X-Google-Smtp-Source: ABdhPJxzhvSxTOGoyPf+w1ZfNACC6PBC3QI/jrnXNUoX8D33yr4OrKGRKxpW1BPnSOUOB2tdNfo6Ww==
X-Received: by 2002:a4a:9406:: with SMTP id h6mr29823072ooi.80.1638148341725;
        Sun, 28 Nov 2021 17:12:21 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id 111sm2390830otu.55.2021.11.28.17.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:12:21 -0800 (PST)
Received: (nullmailer pid 2952305 invoked by uid 1000);
        Mon, 29 Nov 2021 01:12:19 -0000
Date:   Sun, 28 Nov 2021 19:12:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 2/3] dt-bindings: staging: Add the binding
 documentation for ZHOUYI AI accelerator
Message-ID: <YaQo81xyEkZpqXnc@robh.at.kernel.org>
References: <20211126021904.32325-1-caihuoqing@baidu.com>
 <20211126021904.32325-3-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126021904.32325-3-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:19:00AM +0800, Cai Huoqing wrote:
> ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> such as Allwinner R329 SOC.
> Add the binding documentation for ZHOUYI AI accelerator.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v2->v3:
>         *Fix unit_address_format, avoid leading 0s.
> 
>  .../bindings/staging/arm,zynpu.yaml           | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/arm,zynpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/staging/arm,zynpu.yaml b/Documentation/devicetree/bindings/staging/arm,zynpu.yaml
> new file mode 100644
> index 000000000000..d452c08ab4a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/arm,zynpu.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/staging/arm,zynpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM ZHOUYI AI accelerator bindings
> +
> +maintainers:
> +  - Cai Huoqing <caihuoqing@baidu.com>
> +
> +description:
> +  Supports ZHOUYI AI accelerator in ARM SOC.
> +
> +properties:
> +  compatible:
> +    const: armchina,zhouyi-v1
> +
> +  reg:
> +    maxItems: 1
> +
> +  device_type:

device_type is deprecated except for a couple of uses.

> +    const: zynpu
> +
> +  cma-reserved-bytes:
> +    default: 0

Use 'memory-region' and your own carve out if you need this, but do you 
really need this in DT? Is this fixed for a given board/platform rather 
than something a user would want to tune?


> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3

You must define what each clock is and the order.

> +
> +required:
> +  - compatible
> +  - reg
> +  - device_type
> +  - cma-reserved-bytes
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        zynpu@3050000 {
> +            compatible = "armchina,zhouyi-v1";
> +            reg = <0x0 0x3050000 0x0 0x1000>;
> +            device_type = "zynpu";
> +            cma-reserved-bytes = <0x2600000>;
> +            interrupts = <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&clk_zynpu>,
> +                     <&clk_pll_zynpu>,
> +                     <&clk_zynpu_slv>;
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
