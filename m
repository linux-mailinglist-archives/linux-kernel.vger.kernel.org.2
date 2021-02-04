Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB231009F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBDX0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:26:34 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40839 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBDX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:26:32 -0500
Received: by mail-ot1-f53.google.com with SMTP id i20so5167280otl.7;
        Thu, 04 Feb 2021 15:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2nkVg18wGZEoa8kUGTJqurwpIhtPaAbXmqRIWrxCUE=;
        b=V3eEP9JJEfj3ydO7NsU48zQ2MigAmNAVma2aJgjA71DDBFYF7zzvc5AKLFoGqLpIRR
         Xlcfc67SKVyyNZg1dEXfKL1m+7eaGlbZy1sULl5xEgipLM95FUk3KYTvzP3fjHXM4mNf
         hM3+daxg01mw8DkgwDyNMVaKChKseNghCQWW4VgCmLt9O6AFXeDQMq6MmkmhJOvBECmK
         nQwri9/givimkVmTsXoGPikYyL/w4WH6tJCBagOpiznb254Y3QQTlrNuAMe4SeEy91Ii
         7u1mrhWsqgZd6trtfMIhziz5mz1poR6ZvXl8Xn70f+oaFBBQHEzYy1WbRDBcEO2A6yRJ
         OnrQ==
X-Gm-Message-State: AOAM530Br0tibHWCxFAzz9CSddeM/VCWY54ZXL8RLELXWsVvkF/G8Mf2
        qLx7O6zgqNO09wBD+k8DPA==
X-Google-Smtp-Source: ABdhPJwJqr3wnatNUe8DWoShRTE94TDBe87ONFVy1DR98EDCJ7JzDYuizEWR+rUsPGi1b34+LdMtCQ==
X-Received: by 2002:a05:6830:1f4e:: with SMTP id u14mr1333850oth.65.1612481151222;
        Thu, 04 Feb 2021 15:25:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm1445771oih.8.2021.02.04.15.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:25:50 -0800 (PST)
Received: (nullmailer pid 1311195 invoked by uid 1000);
        Thu, 04 Feb 2021 23:25:49 -0000
Date:   Thu, 4 Feb 2021 17:25:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
Message-ID: <20210204232549.GA1305874@robh.at.kernel.org>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203090727.789939-2-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This iommu module can be used by Unisoc's multimedia devices, such as
> display, Image codec(jpeg) and a few signal processors, including
> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> new file mode 100644
> index 000000000000..4fc99e81fa66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc IOMMU and Multi-media MMU
> +
> +maintainers:
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,iommu-v1
> +
> +  "#iommu-cells":
> +    const: 0
> +    description:
> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> +      additional information needs to associate with its master device.
> +      Please refer to the generic bindings document for more details,
> +      Documentation/devicetree/bindings/iommu/iommu.txt
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Not required if 'sprd,iommu-regs' is defined.
> +
> +  clocks:
> +    description:
> +      Reference to a gate clock phandle, since access to some of IOMMUs are
> +      controlled by gate clock, but this is not required.
> +
> +  sprd,iommu-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> +      register range used by the iommu and the media device, the cell
> +      defines the offset for iommu registers. Since iommu module shares
> +      the same register range with the media device which uses it.
> +
> +required:
> +  - compatible
> +  - "#iommu-cells"
> +
> +oneOf:
> +  - required:
> +      - reg
> +  - required:
> +      - sprd,iommu-regs
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu_disp: iommu-disp {
> +      compatible = "sprd,iommu-v1";
> +      sprd,iommu-regs = <&dpu_regs 0x800>;

If the IOMMU is contained within another device, then it should just be 
a child node of that device. Or just make 'dpu_regs' an IOMMU provider 
(i.e. just add #iommu-cells to it).

> +      #iommu-cells = <0>;
> +    };
> +
> +  - |
> +    iommu_jpg: iommu-jpg {
> +      compatible = "sprd,iommu-v1";
> +      sprd,iommu-regs = <&jpg_regs 0x300>;
> +      #iommu-cells = <0>;
> +      clocks = <&mm_gate 1>;
> +    };
> +
> +...
> -- 
> 2.25.1
> 
