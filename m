Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E635A5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhDISZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:25:56 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:46978 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:25:54 -0400
Received: by mail-oo1-f48.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so1532946oof.13;
        Fri, 09 Apr 2021 11:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ap1xXHQrgNoanoCkiwbFpBXllDQp2mXH4gtHCARaL4U=;
        b=FvaArclFUnqD7AINfSxyM9bySIlnNlMmzn32B7ao3xMpGWUqNoAgmy0ZPg246F9tXj
         nIavdILCMiFWe20qjp0yhMZuSCTudGZSqQz6nDmNIalb8CGfNpo6pgb4S7yCr8F3J71p
         N4cR1+lFYIxWIrahyq8aVdQDYkJ5ou/7DB0yaNvwUYL01txebWAGXZenHvDbJSLkp8hX
         3xI6j4n0TMo4hQ5EZCDTQnihtCkXmmWe6R9/Y3CjAgXjMQ/7gzfceg0XLeYUaqgb+lzL
         2KD3Cc/puCCpsGeE5so8jZeNHqPfy1b6TFAxjtbMR92juVwRhKXG9FBxpHUXdFtivz+z
         c6hA==
X-Gm-Message-State: AOAM533sXdmbinD1YGDBMEXfbW0klamgBbTGicTiQB9AknRPbXEEbdGx
        zX9jl/JCWwmqLO7XPLtFBg==
X-Google-Smtp-Source: ABdhPJweHT9wHvpbXVWmGxFX9Ck28qRM1eahscjqOn+iYGqcvUYN7gC7q4C72Axnzp84rzKTMQTdEQ==
X-Received: by 2002:a05:6820:60e:: with SMTP id e14mr12869794oow.67.1617992740263;
        Fri, 09 Apr 2021 11:25:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm745559ota.11.2021.04.09.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:25:39 -0700 (PDT)
Received: (nullmailer pid 3916170 invoked by uid 1000);
        Fri, 09 Apr 2021 18:25:38 -0000
Date:   Fri, 9 Apr 2021 13:25:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: arm: mediatek: Add new document
 bindings for APU
Message-ID: <20210409182538.GA3913794@robh.at.kernel.org>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
 <1617766086-5502-5-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617766086-5502-5-git-send-email-flora.fu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:28:02AM +0800, Flora Fu wrote:
> Document the apusys bindings.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,apusys.yaml         | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> new file mode 100644
> index 000000000000..dc04a46f1bad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,apusys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek APUSYS Controller
> +
> +maintainers:
> +  - Flora Fu <flora.fu@mediatek.com>
> +
> +description:
> +  The Mediatek apusys controller provides functional configurations and clocks
> +  to the system.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-apu_mbox
> +          - mediatek,mt8192-apu_conn
> +          - mediatek,mt8192-apu_vcore

s/_/-/

> +      - const: syscon
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
> +    apu_mbox: apu_mbox@19000000 {

mailbox@...? Is this a mailbox provider?

> +        compatible = "mediatek,mt8192-apu_mbox", "syscon";
> +        reg = <0x19000000 0x1000>;
> +    };
> +
> +  - |
> +    apu_conn: apu_conn@19020000 {
> +        compatible = "mediatek,mt8192-apu_conn", "syscon";
> +        reg = <0x19020000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apu_vcore: apu_vcore@19029000 {
> +        compatible = "mediatek,mt8192-apu_vcore", "syscon";
> +        reg = <0x19029000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.18.0
> 
