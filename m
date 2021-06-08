Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE239EFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFHHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:39:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF292C061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 00:37:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e11so10188060wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aqDgIwi6bwB437aBxOTYSUXtzGWCe3kLLCFEAAZHgPE=;
        b=Vpc382BZXgKI+GfBZyUIhbEgmNFLd82NW08+0mEeJ8HfsGRRCVVpAJwqS/hGoecG4s
         nRA7+aThXbCjfNNMeKIpHTsesA+eOVgvSS+2026dPwBhnEadCcbSyP2CEfzjsatMmGD1
         i++SBMgCskIn3ilVuuD8naom7oh2KsO+w/IsWCxezyyODRCPEMBPzHZ4igLxZjbSBaLR
         cNJt4NM0l0SfHRZW4mjIL9eBfZu3UrdbweOnWuYsHod2PQIODnASqoNnUbnlGkgFmhYm
         F8X6Y5+GiN2w4EOtwXzP1baR8EbW9By3dtBX9xOa/8iHqOJSvT7i4vQlcD0oS90fyWuG
         HJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqDgIwi6bwB437aBxOTYSUXtzGWCe3kLLCFEAAZHgPE=;
        b=WRLXsyYx9bhHzHBgunD2RUmkhlLNU/paViHjAItw2lI9OmTIu5cj5aMTdCKFDKCWQ4
         Pz37lEL4G7nJxP7+070ALeiQZMtN6WwubVr5UQaPV68PlPAlzqlRxQKER5iWt9AcI8uh
         eu0hnx4XUooQMiqdkgDp9gbKuhkdmG3ZxJ1k/jeyw9Lt07G/oBHFGLWSNpf/HtzRXv9k
         pI9MmGaBUJVTADSQd99jvzlNGZ2BytjXvWi7iE8zgZ4wtKBcGlEaavFwKprycOAlcBlw
         xTfr4vYvTyL0TgHzRqSLraTF9qW6Oz0v0J3wdmrrYlmyyZKKr3tz4yWm6Yl5lMQztUyk
         u3Nw==
X-Gm-Message-State: AOAM531YYMNUeK3AJHHtphjG+DhemrGMld530Y619UjunXN/QJRkK5vO
        gjJGU7iBeWyCYJVzW91RG3AH0LoTuQIXtA==
X-Google-Smtp-Source: ABdhPJy+68l5PmJs0kj9agOIcHClM5Q1p0eRyup1PdePPYEjZ1YGVRvm0vt7N6cOavVqcnc0O1llwg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr16041869wrm.46.1623137843374;
        Tue, 08 Jun 2021 00:37:23 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id u7sm15406086wrt.18.2021.06.08.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 00:37:22 -0700 (PDT)
Date:   Tue, 8 Jun 2021 09:37:03 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio-mmio to DT schema
Message-ID: <YL8eHxe4dpE4R2Bm@myrica>
References: <20210607193928.3092186-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607193928.3092186-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:39:28PM -0500, Rob Herring wrote:
> Convert the virtio-mmio binding to DT schema format.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Jean-Philippe, hopefully you are okay with being listed as the 
> maintainer here. You're the only active person that's touched this 
> binding.

Sure, no problem. I can work on the conversion of virtio/iommu.txt as
well, so I'll learn a bit more about the yaml syntax.

Acked-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
>  .../devicetree/bindings/virtio/mmio.txt       | 47 ---------------
>  .../devicetree/bindings/virtio/mmio.yaml      | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/virtio/mmio.txt
>  create mode 100644 Documentation/devicetree/bindings/virtio/mmio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
> deleted file mode 100644
> index 0a575f329f6e..000000000000
> --- a/Documentation/devicetree/bindings/virtio/mmio.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* virtio memory mapped device
> -
> -See https://ozlabs.org/~rusty/virtio-spec/ for more details.
> -
> -Required properties:
> -
> -- compatible:	"virtio,mmio" compatibility string
> -- reg:		control registers base address and size including configuration space
> -- interrupts:	interrupt generated by the device
> -
> -Required properties for virtio-iommu:
> -
> -- #iommu-cells:	When the node corresponds to a virtio-iommu device, it is
> -		linked to DMA masters using the "iommus" or "iommu-map"
> -		properties [1][2]. #iommu-cells specifies the size of the
> -		"iommus" property. For virtio-iommu #iommu-cells must be
> -		1, each cell describing a single endpoint ID.
> -
> -Optional properties:
> -
> -- iommus:	If the device accesses memory through an IOMMU, it should
> -		have an "iommus" property [1]. Since virtio-iommu itself
> -		does not access memory through an IOMMU, the "virtio,mmio"
> -		node cannot have both an "#iommu-cells" and an "iommus"
> -		property.
> -
> -Example:
> -
> -	virtio_block@3000 {
> -		compatible = "virtio,mmio";
> -		reg = <0x3000 0x100>;
> -		interrupts = <41>;
> -
> -		/* Device has endpoint ID 23 */
> -		iommus = <&viommu 23>
> -	}
> -
> -	viommu: iommu@3100 {
> -		compatible = "virtio,mmio";
> -		reg = <0x3100 0x100>;
> -		interrupts = <42>;
> -
> -		#iommu-cells = <1>
> -	}
> -
> -[1] Documentation/devicetree/bindings/iommu/iommu.txt
> -[2] Documentation/devicetree/bindings/pci/pci-iommu.txt
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> new file mode 100644
> index 000000000000..444bfa24affc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/mmio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: virtio memory mapped devices
> +
> +maintainers:
> +  - Jean-Philippe Brucker <jean-philippe@linaro.org>
> +
> +description:
> +  See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
> +  more details.
> +
> +properties:
> +  compatible:
> +    const: virtio-mmio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#iommu-cells':
> +    description: Required when the node corresponds to a virtio-iommu device.
> +    const: 1
> +
> +  iommus:
> +    description: Required for devices making accesses thru an IOMMU.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <41>;
> +
> +        /* Device has endpoint ID 23 */
> +        iommus = <&viommu 23>;
> +    };
> +
> +    viommu: iommu@3100 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3100 0x100>;
> +        interrupts = <42>;
> +
> +        #iommu-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.27.0
> 
