Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E0365D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhDTQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:25:32 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34701 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhDTQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:25:31 -0400
Received: by mail-oi1-f174.google.com with SMTP id k18so34575730oik.1;
        Tue, 20 Apr 2021 09:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8dVyfjRQex2uU+PHTE48uLGNVgNmujkBe81Of/rrYw=;
        b=P3gaD0+aOS9yHNK+MA8bZdd5d1naMbFEznQRiFmc2nqU1Q29+2Yhz6XvxtUXdeYRVf
         Y5x5CcVwjbIcNBXqxPmHJ1nMYIOdEvjQE9JrDvGgDNGrV3XlB3fPxfWEV4KDaYMzwtTa
         pVZaoh8GTtxJxFcf2NjDyOaLSxSIzbVAl+jjDtrfMClzDw3sRI0hn3K/CfzJL0/rmqjX
         UBlzPbntqSLOy5jmrsMY+Y/B+XmLLIaFaeTcbuTD5ocDQqtIKjj5NiY7OMaYfDHOj5JY
         PPqan/NE27LR8Dj5qJfzAWL95oIBm1Q9eYOQL8PjaHi1nX2J/eEaY3e73JxPAAxT7cSJ
         YTCQ==
X-Gm-Message-State: AOAM530X//IsdJtpOFVTbAMbl3d0l7TkXhxOrJcWQYGJ/WN+erS9QiPb
        PHFnu3H3EmnuiwcxZipwxQ==
X-Google-Smtp-Source: ABdhPJzwYqxFN2+jlPlIrVKF+pkBftc8P1b64ffzN6SRSJxNtkEw2eWPlANKkhIUOyrz343BVhv/gQ==
X-Received: by 2002:aca:b387:: with SMTP id c129mr3598986oif.30.1618935898028;
        Tue, 20 Apr 2021 09:24:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm4370603otf.37.2021.04.20.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:24:57 -0700 (PDT)
Received: (nullmailer pid 3431205 invoked by uid 1000);
        Tue, 20 Apr 2021 16:24:55 -0000
Date:   Tue, 20 Apr 2021 11:24:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        p.zabel@pengutronix.de, chunkuang.hu@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: display: mediatek, hdmi: Convert to
 use graph schema
Message-ID: <20210420162455.GA3431175@robh.at.kernel.org>
References: <20210419073244.2678688-1-narmstrong@baylibre.com>
 <20210419073244.2678688-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419073244.2678688-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 09:32:40 +0200, Neil Armstrong wrote:
> Update the mediatek,dpi binding to use the graph schema.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/mediatek/mediatek,cec.yaml        |  51 +++++++
>  .../display/mediatek/mediatek,hdmi-ddc.yaml   |  57 ++++++++
>  .../display/mediatek/mediatek,hdmi.txt        | 136 ------------------
>  .../display/mediatek/mediatek,hdmi.yaml       | 132 +++++++++++++++++
>  4 files changed, 240 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
