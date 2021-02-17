Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18431E035
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhBQUZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:25:51 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42372 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhBQUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:25:39 -0500
Received: by mail-oi1-f175.google.com with SMTP id 6so6432946ois.9;
        Wed, 17 Feb 2021 12:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fFAIBJRtS8lz4sWBKvSYwdMKZETWELFgP9KEyHLr6qo=;
        b=W0gHTdtIG2HRo7QcSxoReBKKp88/Y/n6T8hsw0/+z7U96Y2uoSJyCjKH8Bgd5c8RS2
         xh3vf5/tsVyEZxH4mcJs72NLqvw3DQ92aFAj/Bfyy9oaXZZguMGT4sTX2/j4rKGZG2d+
         hq/XVR6mnS9o80F6ZqxrkZcFOnkYzYuNBVMeKkUFLlBRaUmDodO1tnGV5PTg5VzH7OdA
         KOz9Zd3nEecwhwxvH3JYaPtakDukOGnuutvG6c/kOZ9BzAL56MVOQ4BLj+DkfbPNiF5G
         IqJJ0tSXsYxglCVofY9ONpA5UL9jso5F7grNPS+GtFaLjzEQ0KOE3nR58hdMh1dI+Igk
         LenA==
X-Gm-Message-State: AOAM530mxLBUFffVCP4y71fkaNeXosqmO03nHJzg0pE+U5m4+vd+2p1H
        4Qs+aPkYNB1nNTTInN8G1XmkiIRUaQ==
X-Google-Smtp-Source: ABdhPJzYhqCcG+yX3Uzd3OscwPiULaH/YhQfG5nIUHIFUlKV3wM7OO7MID/izmLtsM8b3f8nwgSy/g==
X-Received: by 2002:aca:d0b:: with SMTP id 11mr401379oin.35.1613593498317;
        Wed, 17 Feb 2021 12:24:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w124sm659788oiw.40.2021.02.17.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:24:57 -0800 (PST)
Received: (nullmailer pid 2681061 invoked by uid 1000);
        Wed, 17 Feb 2021 20:24:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, narmstrong@baylibre.com,
        jernej.skrabec@siol.net, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie
In-Reply-To: <20210214232904.1142706-2-adrien.grassein@gmail.com>
References: <20210214232904.1142706-1-adrien.grassein@gmail.com> <20210214232904.1142706-2-adrien.grassein@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add documentation for LT8912
Date:   Wed, 17 Feb 2021 14:24:51 -0600
Message-Id: <1613593491.462326.2681060.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 00:29:03 +0100, Adrien Grassein wrote:
> Lontium LT8912 is a DSI to HDMI bridge.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../display/bridge/lontium,lt8912.yaml        | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/bridge/lontium,lt8912.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/media/video-interfaces.yaml'
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/display/bridge/lontium,lt8912.example.dt.yaml] Error 255
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1440379

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

