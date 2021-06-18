Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C913AD424
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhFRVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:09:09 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:39906 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFRVJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:09:08 -0400
Received: by mail-oo1-f48.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so2781597oor.6;
        Fri, 18 Jun 2021 14:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtiOyReou+pF/1rfufORAr+idx/wS1LrrDO07j6J4ZY=;
        b=sbUkJ3qqijpDU7/6mMzeJMLT1a6SkQipP9bwSBAXNsauF9yKNayM3z5wr95YpRvg8w
         TQZKpXqJvyuuB2JCdTC8xH8vLVBZ++Fh+OfupdR4fuyKhfQxObAosOTM+SOuLauU71i0
         8ddO+c8DOIyNauhGkxXgVKW93IJyNS8GdCgc2L62jjU7FUDU3rDjhsXnSdk91dfmaJvs
         OlYrepuftjC6+8wZwXgtMXk5usg+ZDMcNb+GcIe2Io+O3lHimDIosoU2edslX/RTxN+G
         5kP82S49mcVU1XXsWjtJApdzkbEX+WGU0pcVTNoOT4wkX/PoBQgri3jzF7RRvsVwAP/1
         MWLA==
X-Gm-Message-State: AOAM533vsu2XTBuo8xT2WuYmG+Moe6ywLflmqzD6y+N4JiYhnNHxzvqG
        sLfAYa87/DSkwMuiEatERA==
X-Google-Smtp-Source: ABdhPJxMCbp/u0TP+JyeZh7NKeN4BrawJlBzXSydp60BTZbERp/w/KlhgnJ1kT4nGA+auxBWoWyDRw==
X-Received: by 2002:a4a:cb06:: with SMTP id r6mr10657436ooq.15.1624050418226;
        Fri, 18 Jun 2021 14:06:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t39sm2014170ooi.42.2021.06.18.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:06:57 -0700 (PDT)
Received: (nullmailer pid 2874848 invoked by uid 1000);
        Fri, 18 Jun 2021 21:06:54 -0000
Date:   Fri, 18 Jun 2021 15:06:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, soc@kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 3/4] dt-bindings: arm: fsl: add SKOV imx6q and imx6dl
 based boards
Message-ID: <20210618210654.GA2874818@robh.at.kernel.org>
References: <20210609121050.18715-1-o.rempel@pengutronix.de>
 <20210609121050.18715-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609121050.18715-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 14:10:49 +0200, Oleksij Rempel wrote:
> Add SKOV imx6q/dl LT2, LT6 and mi1010ait-1cp1 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
