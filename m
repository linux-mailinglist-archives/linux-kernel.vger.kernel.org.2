Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1181F399132
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFBRN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:13:59 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45007 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFBRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:13:58 -0400
Received: by mail-oi1-f173.google.com with SMTP id d21so3323720oic.11;
        Wed, 02 Jun 2021 10:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COKp8u2ZXVU0CymIjovVJV/hDUHC7QysfTLqbeCPlLA=;
        b=Adjldz+oq4KFHDqvU1eRqQef907OlddrGe9cdNa753BgVW1rQbgNDNGV3UGpCua9Iz
         c8jRZMwkLA3MN2Oh4vwk6KOjOR409WBHR3ti/a09dMyuppfoCLQcXhYJb2cE8z/rQk4C
         zI2gq2qHxwmRuM9WMszXWt75l9sgoNjpCnplsQdYoJ0rnG6MPvZgYuXsD4durC6Hct3k
         kSnLBILuhFOwhY2N5Tl2zXFw2ZmgU+QQXuVzoyzhuv2l1Kiph1YAvF66j9MRjujNRVRX
         uiHmsiEVG+FBBUFAhV9vFQwJ6n2qQn6t30wjjXXXhSsFjl7Razwu6t1O6ncZu6GxajxF
         wkJQ==
X-Gm-Message-State: AOAM530rmo2rRuraARcP17U8Dtearb6FI9zQ/8DBEuYW2HSEG9Y3yjLl
        NHidTwZ+EjaeoMqyF6DWPg==
X-Google-Smtp-Source: ABdhPJyP/3UlWlRYRDmsD0pTWPUKVDZroExh5v+MUz02ZfHdTYEFo7ZHdLt3LYHa0h3JIS3nfHzYVA==
X-Received: by 2002:a54:4609:: with SMTP id p9mr21746605oip.107.1622653923200;
        Wed, 02 Jun 2021 10:12:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a6sm89629oon.20.2021.06.02.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:12:02 -0700 (PDT)
Received: (nullmailer pid 3589893 invoked by uid 1000);
        Wed, 02 Jun 2021 17:12:01 -0000
Date:   Wed, 2 Jun 2021 12:12:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
Message-ID: <20210602171201.GA3566462@robh.at.kernel.org>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524122053.17155-2-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:20:32PM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation of imp i2c wrapper controller
> for Mediatek MT8192.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,imp_iic_wrap.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> new file mode 100644
> index 000000000000..fb6cb9e60ee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,imp_iic_wrap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek IMP I2C Wrapper Controller
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek imp i2c wrapper controller provides functional configurations and clocks to the system.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-imp_iic_wrap_c
> +          - mediatek,mt8192-imp_iic_wrap_e
> +          - mediatek,mt8192-imp_iic_wrap_s
> +          - mediatek,mt8192-imp_iic_wrap_ws
> +          - mediatek,mt8192-imp_iic_wrap_w
> +          - mediatek,mt8192-imp_iic_wrap_n

Looks to me like these are all the same h/w, but just have differing 
sets of clocks. That's not really a reason to have different 
compatibles. 

If you need to know what clocks are present, you can walk the DT for 
all 'clocks' properties matching this clock controller instance. Or use 
'clock-indices' to define which ones are present.

Rob
