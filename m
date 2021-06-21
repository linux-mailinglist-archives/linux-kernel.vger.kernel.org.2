Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD03AF229
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFURmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:42:45 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33454 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFURmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:42:43 -0400
Received: by mail-ot1-f53.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so18602856otl.0;
        Mon, 21 Jun 2021 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HN13gmA7y3nz/59kVoPJCGFXMqRoOajwJRx5YAglxNM=;
        b=AlFj5gz1YeuT97+1jaQjfH0Qt+oYPCyLpkrqtSPxbT/TCH13WdMXgzXDFAR6vGm/q1
         /N7Vnm1aG/JX04LZM/6Bcqd+xWfwB/OTd99rEJOPXnBqRNspy3Hoq7LgDR6eled/Jh+U
         ncGf97jr4otog9IecQLbYQFlHqIr17or4Op7GdqWlovf0leSB4eHxtiB9Jmx0CiQ/wF0
         tswr2rSIGZQ183KD9h6xi0FTVD301r7FOjeqlNlvj4k4jNs2JTRCu9pv6cXhGmvrJ2OV
         f99kuEjuau9NaIiSTFlUiDXmstHTkJmMYqa65btORR1ivb1s9yl8stlZ45cdu4kqU+AY
         35Jg==
X-Gm-Message-State: AOAM530W06DyF2HGhdrG3tl2j9JNv6TMYopdt9/7J/z4Qllc1KKR6BRK
        hzk5ScKjrNuh5yRGlnHPpQ==
X-Google-Smtp-Source: ABdhPJxGwFqtkOtwDEBJ3jIvQc8diAPAd9rGu2tJSvFeQ6qyy/qsnWkiPbHoebGF3hQmi+JBnknbfw==
X-Received: by 2002:a9d:7d07:: with SMTP id v7mr21673915otn.204.1624297228726;
        Mon, 21 Jun 2021 10:40:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p25sm3661220ood.4.2021.06.21.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:40:28 -0700 (PDT)
Received: (nullmailer pid 1161635 invoked by uid 1000);
        Mon, 21 Jun 2021 17:40:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Fancy Fang <chen.fang@nxp.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Tomasz Figa <t.figa@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-phy@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <20210621072424.111733-2-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com> <20210621072424.111733-2-jagan@amarulasolutions.com>
Subject: Re: [RFC PATCH 1/9] dt-bindings: display: bridge: Add Samsung SEC MIPI DSIM bindings
Date:   Mon, 21 Jun 2021 11:40:02 -0600
Message-Id: <1624297202.352850.1161634.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 12:54:16 +0530, Jagan Teki wrote:
> Samsung SEC MIPI DSIM Bridge controller is MIPI DSI bridge
> available in NXP's i.MX8M Mini and Nano Processors.
> 
> Add dt-bingings for it.
> 
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/bridge/samsung,sec-dsim.yaml      | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/samsung,sec-dsim.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/bridge/samsung,sec-dsim.example.dts:20:18: fatal error: dt-bindings/power/imx8mm-power.h: No such file or directory
   20 |         #include <dt-bindings/power/imx8mm-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/display/bridge/samsung,sec-dsim.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1494924

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

