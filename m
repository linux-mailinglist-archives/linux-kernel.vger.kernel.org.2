Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F639913E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFBRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:17:26 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42965 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFBRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:17:23 -0400
Received: by mail-ot1-f50.google.com with SMTP id x41-20020a05683040a9b02903b37841177eso3083061ott.9;
        Wed, 02 Jun 2021 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2P63p4K4tBbBNr6gzzyoobg6+9o+75MMsESMYhqw5U=;
        b=To5kVzfcBKgTY/07A9pu0bH+1Ufgjk7QrefLIXKK8NVGroon6Ov4Dz9xBYX0BWxNC1
         tkvbNU5qjVNabDRBYcSaHOv+CbbFhzmOZ+b84PgrZSgxC1Q1ln8Qo95JUP7e8SWJCCFO
         bV6H/4uGKOSe6dxaYY4/KfBYVEVad0V9d5skDt9H46LRotYOUo1nRNSfV9/kMwhDndR0
         XxiAdHJs1ZQnw289M7rDYIS1WP0vOKHKPavv6JJPuTpQGPcO4jrPZbFFjxG4sh3vHiEE
         mB3vXwvpNqUXVLbPr+h+/UkRbGF6gYcCe7VJyLtztkbWwwDrgEm/aWGeZzXv34L+EvRX
         yAzA==
X-Gm-Message-State: AOAM531yvFk0kG9HW2nKVPICaMhOgwPaVlbI5kYeMBMj+rGxWY4iR5dJ
        VapiRr9hw3uyKPZlrtYvkw==
X-Google-Smtp-Source: ABdhPJzubxDrWafAbYqjvQAbpPEO4M+at2huZAVG/AuATI9X3ACKx69dKULHBJ+UhEZfl/ZgFTvhBg==
X-Received: by 2002:a9d:61cb:: with SMTP id h11mr25361198otk.19.1622654140147;
        Wed, 02 Jun 2021 10:15:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm117608otr.16.2021.06.02.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:15:39 -0700 (PDT)
Received: (nullmailer pid 3596346 invoked by uid 1000);
        Wed, 02 Jun 2021 17:15:38 -0000
Date:   Wed, 2 Jun 2021 12:15:38 -0500
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
Subject: Re: [PATCH v9 02/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of mdpsys controller
Message-ID: <20210602171538.GA3590339@robh.at.kernel.org>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524122053.17155-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:20:33PM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation of mdpsys controller
> for Mediatek MT8192.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mdpsys.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
> new file mode 100644
> index 000000000000..22252c322c03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mdpsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MDPSYS Controller
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek mdpsys controller provides functional configurations and clocks to the system.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-mdpsys
> +      - const: syscon

What makes this a syscon? Please add some description about what it 
provides other than clocks.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mdpsys: syscon@1f000000 {

If primarily a clock controller:

clock-controller@...

> +        compatible = "mediatek,mt8192-mdpsys", "syscon";
> +        reg = <0x1f000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.18.0
