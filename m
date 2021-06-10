Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB03A316F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFJQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:55:02 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37555 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFJQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:54:57 -0400
Received: by mail-ot1-f50.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso351264otj.4;
        Thu, 10 Jun 2021 09:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmSSSTzI1G/+6aJZJ8BoKiXXr7B+qXzntJBgHmeug3Y=;
        b=HTjOVHhMPBiGVUGLHzq7WvoWPX9Vf8nL2lpX9mX3lx/VxaqrC17Nc7ZjbNBzsYH/yD
         xrFG+0ZiUBhzemFNvhNqCJ++cuXS0JCV9jZTH7ZoqN2s0hlrCoec1oYZs1tAVjX93d65
         8WNPZ2GiDSPnGLlFIeqfdg1Yvo9i7gdUW19mIe9Jw8RYFq4/u9/uzFSpmqWcq5DksnhN
         yPAMVDDJOlrY1F/56xzgwtV3qfXvLC4JDGHiyzZFtCiUwNJ/NzG/RLTqVr+OUudt6tJC
         9K8qjakB9ZptiESo2J2Mmn314qqI6LD+WsbeNooGKJpTp0xpbwf46mBMf5CzTOlgV3Zy
         rszA==
X-Gm-Message-State: AOAM533SqgMCEIjRRGmSr6N3LCylU/W9JlmW359JnH2NHkiyY20zK0nM
        OEOs8PEkzq0iFI7680WE8w==
X-Google-Smtp-Source: ABdhPJyxJx2yyoRpM5CWFF+cVvOk3Yz7iEbL+70+P4FScA/iA6sbd53xkBffuUIqKvda7xsVEg0IYQ==
X-Received: by 2002:a9d:6d0e:: with SMTP id o14mr3267889otp.90.1623343968019;
        Thu, 10 Jun 2021 09:52:48 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id t15sm643045oie.14.2021.06.10.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:52:47 -0700 (PDT)
Received: (nullmailer pid 1955270 invoked by uid 1000);
        Thu, 10 Jun 2021 16:52:44 -0000
Date:   Thu, 10 Jun 2021 11:52:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Message-ID: <20210610165244.GA1948260@robh.at.kernel.org>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603085003.50465-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 10:50:02AM +0200, Sven Peter wrote:
> DART (Device Address Resolution Table) is the iommu found on Apple
> ARM SoCs such as the M1.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> new file mode 100644
> index 000000000000..db21ca07d121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/apple,dart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple DART IOMMU
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description: |+
> +  Apple SoCs may contain an implementation of their Device Address
> +  Resolution Table which provides a mandatory layer of address
> +  translations for various masters.
> +
> +  Each DART instance is capable of handling up to 16 different streams
> +  with individual pagetables and page-level read/write protection flags.
> +
> +  This DART IOMMU also raises interrupts in response to various
> +  fault conditions.
> +
> +properties:
> +  compatible:
> +    const: apple,t8103-dart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Reference to the gate clock phandle if required for this IOMMU.
> +      Optional since not all IOMMUs are attached to a clock gate.
> +
> +  '#iommu-cells':
> +    const: 1
> +    description:
> +      Has to be one. The single cell describes the stream id emitted by
> +      a master to the IOMMU.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    dart1: iommu@82f80000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f80000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +
> +    master1 {
> +      iommus = <&{/dart1} 0>;

/dart1 is a path, but 'dart1' is a label. You need '&dart1' (or 
'&{/iommu@82f80000}' but that doesn't really work here because the 
examples get prefixed with /example-n/...)

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>


> +    };
> +
> +  - |+
> +    dart2a: iommu@82f00000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f00000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +    dart2b: iommu@82f80000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f80000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +
> +    master2 {
> +      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 673cadd5107a..4373d63f9ccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1240,6 +1240,12 @@ L:	linux-input@vger.kernel.org
>  S:	Odd fixes
>  F:	drivers/input/mouse/bcm5974.c
>  
> +APPLE DART IOMMU DRIVER
> +M:	Sven Peter <sven@svenpeter.dev>
> +L:	iommu@lists.linux-foundation.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +
>  APPLE SMC DRIVER
>  M:	Henrik Rydberg <rydberg@bitmath.org>
>  L:	linux-hwmon@vger.kernel.org
> -- 
> 2.25.1
