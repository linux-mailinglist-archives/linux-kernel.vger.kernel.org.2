Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9784A331537
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCHRu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:50:29 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46682 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:50:03 -0500
Received: by mail-io1-f54.google.com with SMTP id u8so10820216ior.13;
        Mon, 08 Mar 2021 09:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqG62A6ECHx1ErMIyW9dOku1I1WJGyJu3tFPOBlLGpU=;
        b=ErIMYsJlxtO6/Q+EQlJMycfXACdZ3mKiDXVXjuCMzJpdYIHfw45mDfjome8+vKWhHm
         brqS0yDH1ppfdpNCiU8kjqm8D0LTTMk3hGQP3Prm9bnTS/TdVaeBuXZREqa84q3dzXZ4
         ktUxjaiMkScrbaz6FMk8FcNOkllKfQHI+KoWjHMXRyK7tGdyVq0ker7/2Cyz/7VCfVRr
         bA2Wp2URD51lU31Q6IZGLdOnGHtPOZwLhwJDoIuEInN3ET+PNUK6XNl63M+vy9DYeuYi
         x2wCRKs2bzYho2G/Or7N9sPvF9YicXBLvbyn1T0jEBhVLzx0SprZi68M1Z+7U5O+DEKb
         j43g==
X-Gm-Message-State: AOAM533GUT/soun83SxVTv5ivtpoCUvyVJ3+rknQT/13h9pbjUtdv2YE
        RYtSF42aKCPfNqyhS2IAGQ==
X-Google-Smtp-Source: ABdhPJyQIlPVRS8gcc3++0/v5MEklYTA8j+4auW1vDU3cm7oYcIBlZs7P0coPzx2Ij5DU1gi2Cy+5Q==
X-Received: by 2002:a05:6638:329e:: with SMTP id f30mr7582086jav.121.1615225803214;
        Mon, 08 Mar 2021 09:50:03 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c18sm6681876ild.37.2021.03.08.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:50:02 -0800 (PST)
Received: (nullmailer pid 2696494 invoked by uid 1000);
        Mon, 08 Mar 2021 17:50:00 -0000
Date:   Mon, 8 Mar 2021 10:50:00 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 1/9] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings
 for AM64 SERDES Wrapper
Message-ID: <20210308175000.GA2693969@robh.at.kernel.org>
References: <20210222112314.10772-1-kishon@ti.com>
 <20210222112314.10772-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222112314.10772-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:53:06PM +0530, Kishon Vijay Abraham I wrote:
> Add bindings for AM64 SERDES Wrapper.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 10 ++++++---
>  include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/phy/phy-ti.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index c33e9bc79521..bf431f98e6ea 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -12,9 +12,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,j721e-wiz-16g
> -      - ti,j721e-wiz-10g
> +    oneOf:
> +      - const: ti,j721e-wiz-16g
> +      - const: ti,j721e-wiz-10g
> +      - const: ti,am64-wiz-10g

Why do you need to change this from an enum?

>  
>    power-domains:
>      maxItems: 1
> @@ -42,6 +43,9 @@ properties:
>    "#reset-cells":
>      const: 1
>  
> +  "#clock-cells":
> +    const: 1
> +
>    ranges: true
>  
>    assigned-clocks:
> diff --git a/include/dt-bindings/phy/phy-ti.h b/include/dt-bindings/phy/phy-ti.h
> new file mode 100644
> index 000000000000..ad955d3a56b4
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-ti.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for TI SERDES.
> + */
> +
> +#ifndef _DT_BINDINGS_TI_SERDES
> +#define _DT_BINDINGS_TI_SERDES
> +
> +/* Clock index for output clocks from WIZ */
> +
> +/* MUX Clocks */
> +#define TI_WIZ_PLL0_REFCLK	0
> +#define TI_WIZ_PLL1_REFCLK	1
> +#define TI_WIZ_REFCLK_DIG	2
> +
> +/* Reserve index here for future additions */
> +
> +/* MISC Clocks */
> +#define TI_WIZ_PHY_EN_REFCLK	16
> +
> +#endif /* _DT_BINDINGS_TI_SERDES */
> -- 
> 2.17.1
> 
