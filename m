Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF43A13AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhFIMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:03:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbhFIMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:03:07 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqwtU-0007mj-1R
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 12:01:12 +0000
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so2534147wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnDNmk6xWB97FCQncGvxFKPZvRlOM5eWdMh+QD8JdRI=;
        b=XiVMP3TegE6K2ONtmPulg/qKUqfmuNAQxQCAOrw5wwQ0V9HJZFZ1fgj0SW3F+zBtDv
         +RqAzt5wjK5zVN5refMPXIiElc25eFXDiTLlAUpzzqhaLycspyNlhm2jQBQYqvAndMWX
         sxpwzRLhBVNv0nwjp1Bcf/gGasMOI5VplpMOsVtl0kJZbSMyGfSCYHwOMA8JcSh1H4Ga
         CD/7mkZC4xeUbbiz9L1m8iQXoZxZWpgBoav5n6K6FvSNSvvmmYxgbg6iSa8HttkZoGZ5
         +bizUDWjt+Ckiu4nmlux1/DupFSlPs5/IeLDNPMbd4ym2ZyXe9jqA8I9hPfYLmcZaqPa
         2N0g==
X-Gm-Message-State: AOAM533CI5+C0Oi9pSQs2o70bat+s+EQcUxm4H+YKrnvU5vCZvnA8/Y7
        FIDvFh666PHOPpN9iZ3N6DWrUyXKTQ54+cSWosxjyKTtp+eJZ31jLDiqgnETscy9OLtQPSlPf5B
        2gJN3D2zo5Ba0rFlDua+dsW5zc1nzctc8/NbNxcwgIA==
X-Received: by 2002:a05:6000:1365:: with SMTP id q5mr8321930wrz.53.1623240071308;
        Wed, 09 Jun 2021 05:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6QyzCjtadEKIFXtnlzXU2KdyF5rTVINfJlSQDUQHpJX/5LfLWsneFagASOptLJGfnUSn5Pg==
X-Received: by 2002:a05:6000:1365:: with SMTP id q5mr8321906wrz.53.1623240071182;
        Wed, 09 Jun 2021 05:01:11 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id m22sm5703554wmq.21.2021.06.09.05.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:01:10 -0700 (PDT)
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-18-miquel.raynal@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <57ef16cd-33e7-6c16-3a24-9634f47831b3@canonical.com>
Date:   Wed, 9 Jun 2021 14:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609080112.1753221-18-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 10:01, Miquel Raynal wrote:
> Add a yaml description of this NAND controller which is described as a
> subnode of the SMC bus.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> new file mode 100644
> index 000000000000..e72fa14b4385
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PL353 NAND Controller device tree bindings
> +
> +allOf:
> +  - $ref: "nand-controller.yaml"
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:

That's not an enum, but simple const without items.

> +          - arm,pl353-nand-r2p1
> +
> +  reg:
> +    items:
> +      - items:
> +          - description: CS with regard to the parent ranges property
> +          - description: Offset of the memory region requested by the device
> +          - description: Length of the memory region requested by the device

Doesn't it depend on parent's address/size cells?

> +
> +  "#address-cells": true
> +  "#size-cells": true

These should come from nand-controller.yaml

Best regards,
Krzysztof
