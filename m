Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B949A3AF220
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhFURmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:42:31 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44875 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhFURm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:42:26 -0400
Received: by mail-oi1-f180.google.com with SMTP id s17so11968535oij.11;
        Mon, 21 Jun 2021 10:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=42icZQ+8GFfOaTwG88ozPYml3jznNBXOTDzI2KCtdZY=;
        b=uE+RngS2uHL09PAcX87ofMvgB1O2BP8A0ZAIIvV7xMC2IP0ssu+jcSU+U/ZTX4srVQ
         XwXFSjSmkGRXjuYc/XazttyZ0uQiLOjBsw2uN6hbShRH3KDT6kpqzfJ7Inypsa66ORTk
         3I1yobBlIbpV0qSVGrlcpQv6N3yPteximZlwNLHNjbf3/vfo4PYtnARSAWzu3+4R2i+p
         Kh2O0l2ib6Fa2XgifSEjMzz2J60AapNPF6vESpwCGSzpK20i4id5lxVFz2I7T5Q6hVW1
         6JPQyomdoPWYjED++MhWYnjOERbp+NcTEXArRCAjoyz6QW5HFMvSve5XCsltNW2DZyja
         XsDg==
X-Gm-Message-State: AOAM5337QThmCYtkpUzANPbLFTUeH3LlM4ne3421/03JFph1fbly+QnB
        O++F8ug8B0dD4DaamGUoWQ==
X-Google-Smtp-Source: ABdhPJwlT5h0QKO9Yle57uzgnLiyyYOL2NRu/vSbCoTR9VqstQpf8L5ccpGM5R125N/E7bi9sHGL8w==
X-Received: by 2002:a05:6808:8e6:: with SMTP id d6mr25915392oic.147.1624297212142;
        Mon, 21 Jun 2021 10:40:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u10sm4244248otj.75.2021.06.21.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:40:11 -0700 (PDT)
Received: (nullmailer pid 1161637 invoked by uid 1000);
        Mon, 21 Jun 2021 17:40:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, dri-devel@lists.freedesktop.org,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Fancy Fang <chen.fang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-phy@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <t.figa@samsung.com>,
        linux-amarula@amarulasolutions.com,
        Milco Pratesi <milco.pratesi@engicam.com>
In-Reply-To: <20210621072424.111733-4-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com> <20210621072424.111733-4-jagan@amarulasolutions.com>
Subject: Re: [RFC PATCH 3/9] dt-bindings: phy: Add SEC DSIM DPHY bindings
Date:   Mon, 21 Jun 2021 11:40:02 -0600
Message-Id: <1624297202.363586.1161636.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 12:54:18 +0530, Jagan Teki wrote:
> Samsung SEC MIPI DSIM DPHY controller is part of registers
> available in SEC MIPI DSIM bridge for NXP's i.MX8M Mini and
> Nano Processors.
> 
> Add dt-bingings for it.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/phy/samsung,sec-dsim-dphy.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.example.dts:20:18: fatal error: dt-bindings/power/imx8mm-power.h: No such file or directory
   20 |         #include <dt-bindings/power/imx8mm-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1494925

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

