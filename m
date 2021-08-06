Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380D13E313A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbhHFVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:39:23 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37678 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:39:21 -0400
Received: by mail-io1-f48.google.com with SMTP id l20so11996194iom.4;
        Fri, 06 Aug 2021 14:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7de5tolBWZq18Zw+L/U81d1pEQY7EMCoZVERp/FRCDI=;
        b=eUwCudNBPB0ICtwTO5YWosz2wWMlp+IT0jUPMut3h00O8XqM01WZCBV55qjCQjNO6E
         7sjHCjsOs8YgMajE/4pE1kN3UVRAsrfKtQ8/Opqnf+g9Ty9IBKTvPfajpn8ILEk0qMyR
         6/4/Sf3moVGc54paIFMfMlz3Xy2Ovt0Rn/Wp8goTvHvBZJtgQGb8OrUz/iIBOB/IoRu/
         u9C/UbGWXT7OebEvi0MYuAXqTuvLLRDG5mx2ZxoKbeU4uOTymC/mHDD+1hHqKEC995Fm
         yhxM1pJRDKJcvKliDKlBObeV+gNe2X+Gpn4SlrvJWOvBcrPq1tDUHqVJVUBiS5H6ZcAv
         NtvA==
X-Gm-Message-State: AOAM532dMLk7LcYzEMk/7a5/vH8EqtLqj2SbyK9qjOGSBMpDnLPiv5ot
        dFkD9Dwqw+XhRlhmAy6anA==
X-Google-Smtp-Source: ABdhPJxTLbGslSUzO7Jkq47TbQYUHxhicw/Ad6Gy5IXySA7I7XS1Ra9f5bmquX4igCtvfeuiJxghCw==
X-Received: by 2002:a02:9082:: with SMTP id x2mr8076067jaf.44.1628285944257;
        Fri, 06 Aug 2021 14:39:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k13sm4911260ilv.18.2021.08.06.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:39:03 -0700 (PDT)
Received: (nullmailer pid 1848297 invoked by uid 1000);
        Fri, 06 Aug 2021 21:39:01 -0000
Date:   Fri, 6 Aug 2021 15:39:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ck.hu@mediatek.com,
        stonea168@163.com, huijuan.xie@mediatek.com,
        rex-bc.chen@mediatek.com, shuijing.li@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: drm/bridge: anx7625: add
 force_dsi_end_without_null
Message-ID: <YQ2r9ZJHLdiN5/BZ@robh.at.kernel.org>
References: <20210802010711.169080-1-jitao.shi@mediatek.com>
 <20210802010711.169080-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802010711.169080-2-jitao.shi@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 09:07:10AM +0800, Jitao Shi wrote:
> The force_dsi_end_without_null requires the dsi host ent at
> the same time in line.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index ab48ab2f4240..8b868a6a3d60 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -43,6 +43,11 @@ properties:
>    vdd33-supply:
>      description: Regulator that provides the supply 3.3V power.
>  
> +  force_dsi_end_without_null:
> +    description: |
> +      Requires the dsi host send the dsi packets on all lanes aligned
> +      at the end.

Can't this be implied from the compatible string if it is a property of 
this chip? 

