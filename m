Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2BA3F0B51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhHRS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:56:38 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42660 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHRS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:56:34 -0400
Received: by mail-ot1-f44.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5304834otk.9;
        Wed, 18 Aug 2021 11:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWsYvh/LTYe0LzAvjbl9HXu1rWTJ4xzE3ozlxUWmos0=;
        b=mztIjb1sYA+aATtwZuIqT84FJCFyuGa72WSsYDF6L3E1za/8pDJ8ExSEPYv91+CWqy
         nyWXb5PQC0Xshr9F0/xnlgaktuavwRz7rYm/bYutAxVQnAWMJlLIm6fpH4TPn48wmcrf
         voPq3nZoTLxa4eH5Pu1uk6l8sHqladFrW+NDrFNhWXteekR0BkfnehLwwHYX3klCwZrL
         lDjDl7hB8vTXu7/al3WwOfk8aK4MzqDuHhHU42IcBMGVVhU/cYHavCWCVQ/rWyEubzih
         Bn/SYFs8AFu7PEgOojJDO2EOh/x28FVGvhg0pxUUnjSkl9i9IV3o+V8gln5zSmLxo7BU
         kNIA==
X-Gm-Message-State: AOAM530xOcO6yS9giYD0Dx9Mes1fhH2MZY6X5Xt56AMmca1zsW5u+5KI
        w2eFWfHbRD2aiBXuRPH2Jg==
X-Google-Smtp-Source: ABdhPJycZFAQsFLqSs0WqCDFx7NVrqGuvB4UVAsngphoqXwLVv7ukzVwgxjimFWudflox7pHc07jwQ==
X-Received: by 2002:a05:6830:14d5:: with SMTP id t21mr7949953otq.271.1629312958716;
        Wed, 18 Aug 2021 11:55:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x3sm108989ooe.32.2021.08.18.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:55:58 -0700 (PDT)
Received: (nullmailer pid 2912057 invoked by uid 1000);
        Wed, 18 Aug 2021 18:55:57 -0000
Date:   Wed, 18 Aug 2021 13:55:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: convert H8/300 bus controller to
 dtschema
Message-ID: <YR1XvR50rcUBafts@robh.at.kernel.org>
References: <20210818113325.85216-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818113325.85216-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:33:25PM +0200, Krzysztof Kozlowski wrote:
> Convert H8/300 bus controller bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/renesas,h8300-bsc.txt  | 12 -------
>  .../memory-controllers/renesas,h8300-bsc.yaml | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
> deleted file mode 100644
> index cdf406c902e2..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -* H8/300 bus controller
> -
> -Required properties:
> -  - compatible: Must be "renesas,h8300-bsc".
> -  - reg: Base address and length of BSC registers.
> -
> -Example.
> -	bsc: memory-controller@fee01e {
> -		compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
> -		reg = <0xfee01e 8>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
> new file mode 100644
> index 000000000000..70487bb685cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/renesas,h8300-bsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: H8/300 bus controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: renesas,h8300-bsc
> +      - items:
> +          - const: renesas,h8300h-bsc
> +          - const: renesas,h8300-bsc

Seems what's actually in use is:

items:
  - enum: 
      - renesas,h8300h-bsc
      - renesas,h8s-bsc
  - const: renesas,h8300-bsc

Rob
