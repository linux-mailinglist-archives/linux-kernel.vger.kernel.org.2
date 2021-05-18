Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878ED387A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349695AbhERNjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:39:54 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:40852 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbhERNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:39:51 -0400
Received: by mail-oo1-f41.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so451202oou.7;
        Tue, 18 May 2021 06:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXOzbw6kj/huhT91E46/d3VHyM30D8TcdD0+bpXFius=;
        b=l9p7tCSnVJo8cftRFBFrG7WJw6yx4UJjf/bjO2mNFGiEjVi7iEWAQFdMNZDayfgDnY
         KqrLh/TI4NVS8aM0XyVGLIFJvWSq4Ba6MK4rRckRqEZ1cc33/jdL4YepgZWvNR2mrrHG
         xydP+G3z5VkXvBLT2gnVDEV2HrnRECgv2T4UI9UL3/QG9VN2ixRaNHzEzH8fs3YaNEtj
         wW2vuAg5A8Mmw1/l3M6u1lME6fiz5+ur+Hcc8XLnnXqPdjmgpCJkZr8JE6oig5Oa0dv+
         CSZFp1ZGOFrBwTgXTQfQUYI4ci96WOLwZD1oCh79NuEqiPbXxZ0RZyDGS4n/rw2cfRCA
         z04w==
X-Gm-Message-State: AOAM532nlaaJ3CLguEyiCVlS6vY+eYuUb5ae1AFb3jvMQ3eDDD5IrAff
        eL3rIgDwSDBkaZzACj3e1kLtz1LiGA==
X-Google-Smtp-Source: ABdhPJyqJW8jb/jAVhJ7YM46fiQroC3rAm4U5DdM5U9zrld9tG2eyhqubnJzRTpvOnpIwaO29vW/2w==
X-Received: by 2002:a4a:9c8c:: with SMTP id z12mr4485317ooj.3.1621345113591;
        Tue, 18 May 2021 06:38:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k7sm3713033ood.36.2021.05.18.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 06:38:32 -0700 (PDT)
Received: (nullmailer pid 553081 invoked by uid 1000);
        Tue, 18 May 2021 13:38:31 -0000
Date:   Tue, 18 May 2021 08:38:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: rt6160: Add DT binding document for
 Richtek RT6160
Message-ID: <20210518133831.GA543149@robh.at.kernel.org>
References: <1621183560-6668-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621183560-6668-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:45:59AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add DT binding document for Richtek RT6160 voltage regulator.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v2
> - Move buckboost node from patternProperties to Properties.
> ---
>  .../regulator/richtek,rt6160-regulator.yaml        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> new file mode 100644
> index 00000000..4ce1f7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt6160-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT6160 BuckBoost converter
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT6160 is a high-efficiency buck-boost converter that can provide
> +  up to 3A output current from 2025mV to 5200mV. And it support the wide
> +  input voltage range from 2200mV to 5500mV.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT6160A/DS6160A-00.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt6160
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: A connection of the 'enable' gpio line.
> +    maxItems: 1
> +
> +  richtek,vsel_active_low:

richtek,vsel-active-low

> +    description: |
> +      Used to indicate the 'vsel' pin active level. if not specified, use
> +      high active level as the default.
> +    type: boolean
> +
> +  buckboost:

If this is the only regulator, you don't really need a child node here. 
Just move everything up.

> +    description: BuckBoost converter regulator description.
> +    type: object
> +    $ref: regulator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt6160@75 {
> +        compatible = "richtek,rt6160";
> +        reg = <0x75>;
> +        enable-gpios = <&gpio26 2 0>;
> +
> +        buckboost {
> +          regulator-name = "rt6160-buckboost";
> +          regulator-min-microvolt = <2025000>;
> +          regulator-max-microvolt = <5200000>;
> +          regulator-allowed-modes = <0 1>;
> +        };
> +      };
> +    };
> -- 
> 2.7.4
> 
