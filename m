Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85790402D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbhIGQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:49:03 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:38523 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbhIGQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:49:02 -0400
Received: by mail-oo1-f44.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso3114495ooe.5;
        Tue, 07 Sep 2021 09:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHz/eO25vUr8S8mSE9bsSa7gCQmBbjrMFcMGbCUHb6o=;
        b=b+pyhJaDOtgHQqzozInLMw1ONDcpoNUFal8EseLWv/Fqrth3FlXDCY/0BEaU2+3hIw
         yk8lpZ+/QbUw45gP6EZ6JQqSOOKJ0t+uNC8gvIX/t92nhzC10HcHrC+q8DpOJDpXl8iu
         AF6AC4vn36R5bq+9yKDKqVmkW9xvTp/P7SdXOfGO4+BYkQUgp8W+DBb3LzOfFTI5dTRe
         azfWnk0M/d1synE0e8eF5r2bXgg3OjMze/3mc2u2cGpeoPTV+WgBKp+WaaPPklvcPCYr
         nL+p1+SD1EbZHD7KaAYllUEivAd5DKyLahZLuE5Oq0azbi43nRFpQGgkINM7VAFhTnb7
         hb4A==
X-Gm-Message-State: AOAM531TfJ99ZtCjypIqILFpxhGTRuPJmbSwbCzaby58j+/q1Lt2dllR
        h8PtSKPCzCn9NTjyYQthAw==
X-Google-Smtp-Source: ABdhPJzZ4nyNi1E0Szx6UheqtQBDEqBMRmGhaKeXZHBzgMHg0LqsypWDXSEu8Z0dH05M0/talFPCXA==
X-Received: by 2002:a4a:e923:: with SMTP id a3mr641201ooe.45.1631033275700;
        Tue, 07 Sep 2021 09:47:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z18sm2234069oib.27.2021.09.07.09.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:47:54 -0700 (PDT)
Received: (nullmailer pid 4137367 invoked by uid 1000);
        Tue, 07 Sep 2021 16:47:53 -0000
Date:   Tue, 7 Sep 2021 11:47:53 -0500
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
        linux-phy@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 4/4] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Message-ID: <YTeXuVdyh+VMGdl7@robh.at.kernel.org>
References: <20210907083723.7725-1-granquet@baylibre.com>
 <20210907083723.7725-5-granquet@baylibre.com>
 <1631026304.913177.3958449.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631026304.913177.3958449.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 09:51:44AM -0500, Rob Herring wrote:
> On Tue, 07 Sep 2021 10:37:21 +0200, Guillaume Ranquet wrote:
> > Add Mediatek HDMI and HDMI-DDC bindings for MT8195 SoC.
> > 
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> >  .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 46 +++++++++
> >  .../mediatek/mediatek,mt8195-hdmi.yaml        | 99 +++++++++++++++++++
> >  2 files changed, 145 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dts:19:18: fatal error: dt-bindings/clock/mt8195-clk.h: No such file or directory
>    19 |         #include <dt-bindings/clock/mt8195-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:379: Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1438: dt_binding_check] Error 2

Last I checked this is still not upstream. I'd suggest you adjust the 
example to not need this header.

Rob
