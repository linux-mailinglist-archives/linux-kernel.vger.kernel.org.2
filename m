Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB674340AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhJSVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:40:36 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34390 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:40:33 -0400
Received: by mail-ot1-f51.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so3735316otb.1;
        Tue, 19 Oct 2021 14:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPMjU4iCVb3RsIz3pVs+V885g96iu6in5Ws6/qpbB6k=;
        b=Yb6EOQaVvdPRCPkGljf8Kmb/arL1wqycgBABoKzx1pm8igJc7tj5DFCwau6pnr56fQ
         l+yDZKV1I8TjOJmdBINbHVqT0iWncO1BW7v9y5PsTpPQRwDI+gVTKGPa1fY9zRzV06HY
         uMuIYM9GIEqfswZ99LxaC5jUKasanZ+pD6ksmEw+Sjxt5pUJkhI8WQ2IkLxH+OFByKCl
         87rQ7hLWKzrtHen3YK9LAPj0jCoObBT5nO2Pifs/9iLnJuXrcGeClP6bpVn6HgJrB4Ha
         3jZFrEabhtsFip1kuFCFFSWoIeXTQEu0zTv/Ft9PwfDKYxeBF6V6Bvla2xB6hpndK/ER
         piog==
X-Gm-Message-State: AOAM5333opaNHupBRETddfQl6ETsNheFf8S8QCL2V2HkJqV1XkS8W6KD
        hFRFfEtTuKEkLO5duHwK2ICe54m2Ng==
X-Google-Smtp-Source: ABdhPJxHHmyG0dyZZA6LoacKH1IK+tkhg772TipqhjuS8LLTMy9+/ZieBFI47s6Xk+jMiqLaeIR9lw==
X-Received: by 2002:a05:6830:4027:: with SMTP id i7mr7588963ots.275.1634679500265;
        Tue, 19 Oct 2021 14:38:20 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-67-78-118-34.sw.biz.rr.com. [67.78.118.34])
        by smtp.gmail.com with ESMTPSA id h17sm60212otm.69.2021.10.19.14.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:38:19 -0700 (PDT)
Received: (nullmailer pid 883866 invoked by uid 1000);
        Tue, 19 Oct 2021 21:38:18 -0000
Date:   Tue, 19 Oct 2021 16:38:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Stephen Warren <swarren@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH] WIP: dt-bindings: arm: firmware:
 tlm,trusted-foundations: Convert txt bindings to yaml
Message-ID: <YW86yrhJBTunU121@robh.at.kernel.org>
References: <20211009104518.45596-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009104518.45596-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 12:45:18PM +0200, David Heidelberg wrote:
> Convert Trusted Foundation binding to the YAML syntax.

Looks fine. Why WIP?

If version number ranges are known, you could add constraints on those.

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm/firmware/tlm,trusted-foundations.txt  | 20 --------
>  .../arm/firmware/tlm,trusted-foundations.yaml | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
> deleted file mode 100644
> index 780d0392a66b..000000000000
> --- a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Trusted Foundations
> --------------------
> -
> -Boards that use the Trusted Foundations secure monitor can signal its
> -presence by declaring a node compatible with "tlm,trusted-foundations"
> -under the /firmware/ node
> -
> -Required properties:
> -- compatible: "tlm,trusted-foundations"
> -- tlm,version-major: major version number of Trusted Foundations firmware
> -- tlm,version-minor: minor version number of Trusted Foundations firmware
> -
> -Example:
> -	firmware {
> -		trusted-foundations {
> -			compatible = "tlm,trusted-foundations";
> -			tlm,version-major = <2>;
> -			tlm,version-minor = <8>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
> new file mode 100644
> index 000000000000..9d1857c0aa07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/firmware/tlm,trusted-foundations.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Trusted Foundations
> +
> +description: |
> +  Boards that use the Trusted Foundations secure monitor can signal its
> +  presence by declaring a node compatible under the /firmware/ node
> +
> +maintainers:
> +  - Stephen Warren <swarren@nvidia.com>
> +
> +properties:
> +  $nodename:
> +    const: trusted-foundations
> +
> +  compatible:
> +    const: tlm,trusted-foundations
> +
> +  tlm,version-major:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: major version number of Trusted Foundations firmware
> +
> +  tlm,version-minor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: minor version number of Trusted Foundations firmware
> +
> +required:
> +  - compatible
> +  - tlm,version-major
> +  - tlm,version-minor
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      trusted-foundations {
> +        compatible = "tlm,trusted-foundations";
> +        tlm,version-major = <2>;
> +        tlm,version-minor = <8>;
> +      };
> +    };
> -- 
> 2.33.0
> 
> 
