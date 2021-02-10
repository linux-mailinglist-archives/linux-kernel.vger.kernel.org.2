Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5699316BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhBJQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:55:17 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40032 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhBJQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:52:01 -0500
Received: by mail-ot1-f46.google.com with SMTP id i20so2400208otl.7;
        Wed, 10 Feb 2021 08:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYDCWW0ri9ABwNvakmVNrOr5CXzUYGndo7RaL5QLnsY=;
        b=d16j+9IqLn5pPaSzFyRl29YxYg0AsK3dOdQ/4D4keMg2iQD8pnoeaMl2a3w2AbhC2A
         BMfvpmey5OkuMGYUQkmS7caUFuCZdadpuKJ02HGGFmaIUwpNY+GV+6Tb0V1gBwcqdXQ9
         3ds1e4uNQ4OCuXESVef2IoiZbL4LcJKZgFUmEeWJV0jhE2nF1gkACgWEdk/VN81MAeLw
         3DBVjGliESVjwC6rdLl2Ufbm+TYUhD+5Ngm6dRuZFIZwiPixyPsmk1ep9Uu7aU02M9Ka
         xFjO8LaeuvRbES8zg1VPZR55h4CJY0oQDdZNPIROWRdCTNpDPkbancfSp9Jj0+bsFtTP
         hC4g==
X-Gm-Message-State: AOAM532DW7eOP8DtjLeqXrcnv2W3pbUCM5/v4xfqn6HtExqNELTNSO2l
        v2QPYKC/8k1R4dwMGpKxRg==
X-Google-Smtp-Source: ABdhPJytCx3NdyTubREuzpwniM9aZ3So4jziTwM7WzUcVNObDeXC7uO//8RwWqawI+Itzag/Jn/R0g==
X-Received: by 2002:a05:6830:120c:: with SMTP id r12mr2830409otp.72.1612975881492;
        Wed, 10 Feb 2021 08:51:21 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t3sm476211otb.36.2021.02.10.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:51:19 -0800 (PST)
Received: (nullmailer pid 2315145 invoked by uid 1000);
        Wed, 10 Feb 2021 16:51:18 -0000
Date:   Wed, 10 Feb 2021 10:51:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     vkoul@kernel.org, kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI
 D-PHY bindings
Message-ID: <20210210165118.GA2311581@robh.at.kernel.org>
References: <20210210080736.771803-1-narmstrong@baylibre.com>
 <20210210080736.771803-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210080736.771803-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:07:35AM +0100, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This Analog D-PHY works with a separate Digital MIPI D-PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> new file mode 100644
> index 000000000000..14bb8d78a860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic G12A MIPI analog PHY
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,g12a-mipi-dphy-analog
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@0 {
> +          compatible = "amlogic,g12a-mipi-dphy-analog";
> +          #phy-cells = <0>;
> +          reg = <0>;

If this is a child of something else, then put a $ref to this schema and 
the example in the parent schema.

Rob
