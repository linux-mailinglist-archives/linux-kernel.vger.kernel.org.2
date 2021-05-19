Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F8389222
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbhESPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhESPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:01:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A3C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:00:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so14344497wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dj8HjSEltSQ35S7lmqYwXgvlOZsZ7TUYX+opBuqrwQ0=;
        b=R1n+hnWZMqTitIFXwbfVQ+YhfCV4/jiA4aTdTrIIWZMidDFv/lwN+44qBOrmGWbzIs
         1+6+zj/Gb5hgDcOPLWc8/7yDb2pW+aBmkMgWKa0iTwQ6LuxH1yvpSa4XuF3rdQw8B/cX
         gcd4UXyolgpMBpMnvVO8rSN4z2247vhNL99/Tfqu5NVEmQ49SUOd1y+/GrY9yQpCAVQ5
         G37f8Y5spuR5WdglPbdsBnzYLMOo3lcsNGYodYUgUJxmhBmGgV/4KdklpBrz/mKr+kmL
         dA6eWMU3/D4sX2HqD6zljX7/bOpOF8Qx2N2jc6h3lEIeIczsnyCkb4fNXCzwNXZ5DAIY
         Nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dj8HjSEltSQ35S7lmqYwXgvlOZsZ7TUYX+opBuqrwQ0=;
        b=sZUcBRRs1Cfnq0WRwAXOIjdRCtcqEZ9LGw93I7DWkpw9zUY6Qu5fI9KSpg0bydD+Va
         JzT/SrknjeZpafPYJWxVJIXARhD0QShjj+w58NPgPahN7DeqvjHxorxXPPYM0fN2euAt
         ZJGG5XSXQsaM9JTfgog2lJhQvCoxZw0LZgMUe0s6dUDB3Hetyy3XWE7/4r/RWy8ZndHL
         3phvOm1ZUfi3Y4f8KOMGWn1lMvdTnJb1/6Xx7Ta9E98uuRwM/BpTHy8LIexdxc7NKX6t
         f9ZzeSEmWDOilUxo9vPrhcs9DVGs5dpPvI+LNlrXud/J/S4q5E/TMjUigfoGkNj+zE6F
         clmg==
X-Gm-Message-State: AOAM5309mgpqb1CBer3IJct2mEqrj1h7ReHlsHV1ynKc5KP494Kh9weB
        GYvCn2VH/wdDhTVQA4Q34uzfFQ==
X-Google-Smtp-Source: ABdhPJwVqW1ph9IN2a5+C7Xz683XbVd7eoenA9J/Cjz971MWwgqtmzEOqzq7xSc3x8z11Kn3/z5CWg==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr14795053wru.273.1621436413251;
        Wed, 19 May 2021 08:00:13 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id x2sm11239703wmj.3.2021.05.19.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:00:12 -0700 (PDT)
Date:   Wed, 19 May 2021 16:00:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: ti,j721e-system-controller: Fix
 mux node errors
Message-ID: <20210519150010.GJ2549456@dell>
References: <20210518232858.1535403-1-robh@kernel.org>
 <20210518232858.1535403-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518232858.1535403-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Rob Herring wrote:

> The ti,j721e-system-controller binding does not follow the standard mux
> controller node name 'mux-controller' and the example is incomplete. Fix
> these to avoid schema errors before the mux controller binding is
> converted to schema.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>

Would one of the original authors be kind enough to review please?

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 19fcf59fd2fe..272832e9f8f2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -43,12 +43,10 @@ properties:
>  
>  patternProperties:
>    # Optional children
> -  "^serdes-ln-ctrl@[0-9a-f]+$":
> +  "^mux-controller@[0-9a-f]+$":
>      type: object
> -    description: |
> -      This is the SERDES lane control mux. It should follow the bindings
> -      specified in
> -      Documentation/devicetree/bindings/mux/reg-mux.txt
> +    description:
> +      This is the SERDES lane control mux.
>  
>  required:
>    - compatible
> @@ -68,9 +66,18 @@ examples:
>          #size-cells = <1>;
>          ranges;
>  
> -        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +        serdes_ln_ctrl: mux-controller@4080 {
>              compatible = "mmio-mux";
>              reg = <0x00004080 0x50>;
> +
> +            #mux-control-cells = <1>;
> +            mux-reg-masks =
> +                <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> +                <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> +                <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> +                <0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
> +                <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
> +                /* SERDES4 lane0/1/2/3 select */
>          };
>      };
>  ...

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
