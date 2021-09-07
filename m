Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234B4402B16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbhIGOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:52:57 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37391 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbhIGOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:52:55 -0400
Received: by mail-ot1-f49.google.com with SMTP id i3-20020a056830210300b0051af5666070so13083815otc.4;
        Tue, 07 Sep 2021 07:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=K9C/kpdJSeTdk8CqRsAWClMUWdhDIHFpApAyFUpF2cQ=;
        b=XzSDDobm1esz6494YgGjFpv36kXpERkK00d8A+RFTv/rc/M70D9sFSYIZY5qXWsX+g
         twfw5bqbf3hXEkdt5dmtqwCZMQLID/QCSAImGLsFEz4iJQaZ7l6RXPMvelMcEN+sLDrh
         D1s/WdG3/QjxHmhm8nl/rMC57PgwgFOBivM6Ccjtivnl+T6Ocg4d9CJHuQL7QEDSs4Qg
         OQ2me/CnmZ8g6mujmscwIrxYa6IqXR3qTk91QQsBreowcn7j7Rt7B4f5+xonBc6fxjbb
         jYoOwHpsltHwvyYogxNHYd2LFHNWGAD2xEI0P9H01VYATMiqjceb3sXhaGrr5LMUX0Mb
         tuWw==
X-Gm-Message-State: AOAM530aaKD8ZnS2YHeE7DL0sAeijZIx7d274SBuMbw2R2wgme8HZfcc
        pSyp+c3rMPw7R7ejG1cAMQ==
X-Google-Smtp-Source: ABdhPJy/y9KHvC7bV7t4BanxnDIknT6RYDMbRM9hh+0+KhTh72koKcnANQlNWDO/8dqBciBXZJaQGw==
X-Received: by 2002:a05:6830:3144:: with SMTP id c4mr14826951ots.153.1631026308866;
        Tue, 07 Sep 2021 07:51:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm2436686otr.51.2021.09.07.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:51:48 -0700 (PDT)
Received: (nullmailer pid 3958450 invoked by uid 1000);
        Tue, 07 Sep 2021 14:51:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20210907083723.7725-5-granquet@baylibre.com>
References: <20210907083723.7725-1-granquet@baylibre.com> <20210907083723.7725-5-granquet@baylibre.com>
Subject: Re: [PATCH 4/4] dt-bindings: display: mediatek: add MT8195 hdmi bindings
Date:   Tue, 07 Sep 2021 09:51:44 -0500
Message-Id: <1631026304.913177.3958449.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2021 10:37:21 +0200, Guillaume Ranquet wrote:
> Add Mediatek HDMI and HDMI-DDC bindings for MT8195 SoC.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 46 +++++++++
>  .../mediatek/mediatek,mt8195-hdmi.yaml        | 99 +++++++++++++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dts:19:18: fatal error: dt-bindings/clock/mt8195-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8195-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:379: Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1438: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1525170

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

