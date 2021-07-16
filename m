Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D73CBB72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhGPR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:58:40 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:39860 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:58:39 -0400
Received: by mail-io1-f48.google.com with SMTP id w22so3424476ioc.6;
        Fri, 16 Jul 2021 10:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFOHzg/8OboexPm/0pSsjz82hnih9yZe/xW9+Qml0Fo=;
        b=JI6v9+B1A/1O5SIicqwRhvXlTsI/TCb0DE/XTY+3zATN4YN9DlrGTIUT4nKfwseKYb
         8ZfoePOc+v+QhxQVmU92pYbV3FACu1Ex+AsSQNdaKrqkJnFcItFSxVuIrgXHAsPInmjr
         7QyQJZY3Xm9HYXHpwCQ1stGmaDo3xDPRw91YmXz0GjAU0SzI6JxbSe3AuAFqSdAV86eQ
         1eNE/55gLn+3pdZ/jZ2cYwqd+W+p96qmSriT2vwlPF62XvOAKOAmYqfgVZdxYG7cxZdJ
         lR+Yqqypy3uigk0p5sn0dGfQoAnH5Rd2DbuqKqCVcyZk2FqupjIYkJ74JMOZCO1PpT6k
         PK+w==
X-Gm-Message-State: AOAM532SjaKYzRV6KCSEluFtObpH2Dbib0/mXS3mJp0LJiLxb9boJ9HJ
        wMaVyQ2cd3j8Q2HsKR+Ldg==
X-Google-Smtp-Source: ABdhPJyB1gQr5+xRZl+gIVic1+l9kv06PAA28WzTGwCgfyv07tnL8aVGaFiMGmLDAVDhxYYSy9tskA==
X-Received: by 2002:a02:bb12:: with SMTP id y18mr9776068jan.66.1626458142771;
        Fri, 16 Jul 2021 10:55:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m26sm5481404ioo.23.2021.07.16.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:55:41 -0700 (PDT)
Received: (nullmailer pid 3675453 invoked by uid 1000);
        Fri, 16 Jul 2021 17:55:38 -0000
Date:   Fri, 16 Jul 2021 11:55:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        drinkcat@chromium.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        eizan@chromium.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] dt-bindings: display: mediatek: add dsi reset
 optional property
Message-ID: <20210716175538.GA3675419@robh.at.kernel.org>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.3.Ifec72a83f224b62f24cfc967edfe78c5d276b2e3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714121116.v2.3.Ifec72a83f224b62f24cfc967edfe78c5d276b2e3@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 12:11:37 +0200, Enric Balletbo i Serra wrote:
> Update device tree binding documentation for the dsi to add the optional
> property to reset the dsi controller.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Added a new patch to describe the dsi reset optional property.
> 
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
