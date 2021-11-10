Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3242F44C949
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhKJTr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:47:28 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38665 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhKJTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:47:12 -0500
Received: by mail-ot1-f50.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so5561940otj.5;
        Wed, 10 Nov 2021 11:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LwMY7yGoVHRADsH1iBdmXQvs2eZecM5ZTPN7Dz6EBk8=;
        b=TWMA4dZuGY0e48iapvqIh1nNVUZZah1r3ULOCOKiW9G3ey8PGSWdj0H2Q3V1+P28TE
         D8VIXbegO2pMwVj1Gs23pdRfDYqwQCjAkt/a/jHeXgJBQskYLHOeuHbgiFplitG+fHAA
         1r00RReSsJ2jHHrKjNVlkxjnq94x/50HdYlKqTWWLaERdob9GmKxKBargQl7mdqRebR3
         OCffDmPG33aG1L0naMdAndftqTGrLOq8hFcUpq0DgtekpvjJw68nIunXYrHkrFW3HuuA
         UerH8G+PXfpzAnMcWUC4gHbDddtQ/koNfx8+5Dd/gsm2vs+s3omr747UOyOpPZaJRZWn
         9IpA==
X-Gm-Message-State: AOAM532FS+zi42xOy12S6mgvMC8Ml75ylWadb79EHA/m7u6U/J6gYZEF
        AYPaWtm/w+xgc6vsk+SsUQ==
X-Google-Smtp-Source: ABdhPJwhKGD3zE5gwHgBoQy1rxHWG/g8Q1BHdfqtTlTJi1rNu2B51GVLx0DXi7o9Y8ZiTLEAs3H9uQ==
X-Received: by 2002:a9d:8e9:: with SMTP id 96mr1491465otf.192.1636573464270;
        Wed, 10 Nov 2021 11:44:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm169197oth.21.2021.11.10.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:44:23 -0800 (PST)
Received: (nullmailer pid 1783741 invoked by uid 1000);
        Wed, 10 Nov 2021 19:44:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Jitao shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>
In-Reply-To: <20211110130623.20553-3-granquet@baylibre.com>
References: <20211110130623.20553-1-granquet@baylibre.com> <20211110130623.20553-3-granquet@baylibre.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Wed, 10 Nov 2021 13:44:20 -0600
Message-Id: <1636573460.915903.1783740.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 14:06:18 +0100, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dts:20:18: fatal error: dt-bindings/power/mt8195-power.h: No such file or directory
   20 |         #include <dt-bindings/power/mt8195-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1553428

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

