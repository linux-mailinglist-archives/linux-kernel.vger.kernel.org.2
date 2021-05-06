Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67544375720
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhEFPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:30:03 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34638 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhEFP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:28:32 -0400
Received: by mail-ot1-f52.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso5224494ote.1;
        Thu, 06 May 2021 08:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KfFwaizpNkSOSpLy+JW7Fy7Dspgzcz2CioU6Zd7EVAk=;
        b=e0EXL82HEl1qbBIIvzlgDEhEU3xjt2ODbNxw+ybCnY6fGZZP9Yrc31Q7zlq00Op6Ox
         plSnWqpnPrJh1ERgGG/rfVWO3m5O30fsLRjduCbU5cdpBQL3JOYyeG1qQAU2XrMtsvHy
         YJP8bwYgGI7MZzVWjiWtl2S5h5E7XBKepkQyF5yltDLbkAMvTkcD6DpbXVGm3pKTx8fe
         MGxvdQoR2hDp1o6lC4QSJLJiddTUsl1vY8dG1ex47T+9cez2aRhcFTGchwTMuRQVEOPt
         CzTENtidsteiOHWHFb5XZd3pfSJTNL/VcsUOviPB4lpYhLHyQ9E2s4qJTD9pthXJwX2z
         qdKQ==
X-Gm-Message-State: AOAM532vux2HvvxJjNmRk78pGZfzssydTYnZzJKBuWLPUJFiAl6VTywp
        x8x+0oij9CKaPsphRJ4X/Q==
X-Google-Smtp-Source: ABdhPJyCLkQhPP5rdxxEieDcOSIiGM6kzGFCroiumy3wPbDHuAA8EbZClvAdIFe0pFhQONw0viGWYw==
X-Received: by 2002:a05:6830:248d:: with SMTP id u13mr4105799ots.121.1620314853204;
        Thu, 06 May 2021 08:27:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e67sm480839oia.5.2021.05.06.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:27:32 -0700 (PDT)
Received: (nullmailer pid 357250 invoked by uid 1000);
        Thu, 06 May 2021 15:27:31 -0000
Date:   Thu, 6 May 2021 10:27:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] regulator: rt6160: Add DT binding documet for
 Richtek RT6160
Message-ID: <20210506152731.GA352070@robh.at.kernel.org>
References: <1620036917-19040-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620036917-19040-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 06:15:16PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>

Typo in the subject.

> 
> Add the DT binding document for Richtek RT6160 voltage regulator.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt6160-regulator.yaml        | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> new file mode 100644
> index 00000000..fe7b168
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> @@ -0,0 +1,68 @@
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
> +    description: |
> +      Used to indicate the 'vsel' pin active level. if not specified, use
> +      high active level as the default.
> +    type: boolean
> +
> +patternProperties:
> +  buckboost:

foo-buckboost-bar is valid name?

It's not a pattern, so move to 'properties'.

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
