Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52F340DAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhIPNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:10:14 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45973 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbhIPNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:10:12 -0400
Received: by mail-io1-f50.google.com with SMTP id a22so7786918iok.12;
        Thu, 16 Sep 2021 06:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ituwSJ110Dj0sXIJC5Efh62E6D6KoCJab81D2Ntqvk0=;
        b=pIdfg+blUge44O6UkAlmlmq3HSwp9QB+Lq2fjSPonzVhzltRwkIirIJ5BKryejXvXo
         zoyPpw1PXPTgQ8DoK0OubpUHPrkaff2TCD8mE9YLrWTRs+3U9t1zHUSxIxear/IsZgbC
         eRQxCSXYeB/d/pKOv/4UqJTcAj4EAkXwokgX7TTMHxdhc0bNw9WqhTUS1DXa1bo3Lyn1
         8mJe0wleP5hUfskTpcSObkytxBRSZPtW2JANEqtDgQZTYZq9UCOKYlinDqHV0x7p0y6l
         Fp3S9hkQG/msUOQhQEZp3TnmvddeB1yZ0krA9FNJYxVMBdh7zEisrzBUbNbV3PPMmCJa
         FcpA==
X-Gm-Message-State: AOAM533HdsAWMV5Zv6xJffMP6/joRW/tR19rUsRGOsdqkxwKzNr9R8pI
        P9QSLtwj+vBglL3rPSwpow==
X-Google-Smtp-Source: ABdhPJyFQUWlE9WY494knK7n3o6KH1B6DrNMuE/xDO8CfBeIaCvmtmsviq9zaRa0/VjO4EZ0rGmYUQ==
X-Received: by 2002:a05:6602:2211:: with SMTP id n17mr4310872ion.142.1631797732078;
        Thu, 16 Sep 2021 06:08:52 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id a14sm1747535iol.24.2021.09.16.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:08:51 -0700 (PDT)
Received: (nullmailer pid 1185083 invoked by uid 1000);
        Thu, 16 Sep 2021 13:08:50 -0000
Date:   Thu, 16 Sep 2021 08:08:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YUNB4jtbh9y2Gn96@robh.at.kernel.org>
References: <20210916084714.311048-1-zhang.lyra@gmail.com>
 <20210916084714.311048-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916084714.311048-2-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:47:11PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> new file mode 100644
> index 000000000000..cf9dad06bb4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc System Global Register Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description:
> +  Unisoc system global registers provide register map
> +  for clocks and some multimedia modules of the SoC.
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    items:
> +      - const: sprd,ums512-glbregs
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  ranges:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":

"clock-controller@[0-9a-f]+$"

> +    # Child node
> +    type: object
> +    $ref: "../clock/sprd,ums512-clk.yaml"
> +    description:
> +      Clock controller for the SoC clocks. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml.

No need to reference this file twice.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ap_apb_regs: syscon@71000000 {
> +      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
> +      reg = <0x71000000 0x3000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0x71000000 0x3000>;
> +
> +      apahb_gate: clock-controller@0 {

Drop unused labels.

> +        compatible = "sprd,ums512-apahb-gate";
> +        reg = <0x0 0x2000>;
> +        #clock-cells = <1>;
> +      };
> +    };
> -- 
> 2.25.1
> 
> 
