Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1015E32F55C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCEVgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:36:55 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44629 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:36:47 -0500
Received: by mail-ot1-f48.google.com with SMTP id f33so3186555otf.11;
        Fri, 05 Mar 2021 13:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/znipdyOwAzgeuPaqqylgiCI8fL3ADaRxj51tLfbj8=;
        b=NxoK6uMJQDCn0M/kAchEbptukeR6FJRkGQhXg5ZasFgNwu2/KGLLsg6l3g3gjxgXai
         j3YNuc/gjfgUC8DpE2dV1gXB1YQ9Zq7deqpbARF9XeHqJXaxeI5F3uz14vkxR30XKkAS
         eth/rDBC0f84/h1nXlRV6MCLXdO6g9++CEe0Y12WQ/0CE7xMZxd+zcY+pulpvVz0UnnG
         un69UYY9rFytuieM0ineTzm0OQ7yq/+UE9AVjxZOrzosIIja8tAWdqf0W20/1zLSI+EP
         AzdKahtj4PrdjujoglTey9WOMBQodD204e5FTy380MAIsrSO8itvzXD3SGaOE0/m8DA/
         deMA==
X-Gm-Message-State: AOAM532vnWsUswDPNSOxljth76rTpp1vds7kGMViurMZapaXkgNAj57x
        HAY2DgkL/8OTZ2x9sjGqVfFhcJ0HxA==
X-Google-Smtp-Source: ABdhPJzYXim21O+qXZpvHXpE/16+KL1gkOLIQx/2yYxHvK52IFy6UDRNy4I2+TRpgV+8VzYWa0fJKw==
X-Received: by 2002:a9d:7196:: with SMTP id o22mr9553570otj.107.1614980207112;
        Fri, 05 Mar 2021 13:36:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d1sm783766oop.0.2021.03.05.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:36:46 -0800 (PST)
Received: (nullmailer pid 687938 invoked by uid 1000);
        Fri, 05 Mar 2021 21:36:45 -0000
Date:   Fri, 5 Mar 2021 15:36:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Vasut <marex@denx.de>,
        linux-amarula@amarulasolutions.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 SN65DSI83/84/85
Message-ID: <20210305213645.GA687887@robh.at.kernel.org>
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214174453.104616-1-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Feb 2021 23:14:52 +0530, Jagan Teki wrote:
> SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
> controller IC's from Texas Instruments.
> 
> SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
> SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
> SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
> 
> Right now the bridge driver is supporting Channel A with single
> link, so dt-bindings documented according to it.
> 
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - fixed Rob comments
> - updated commit message and file name to support all chip variants
> Changes for v2:
> - none
> 
>  .../bindings/display/bridge/ti,sn65dsi8x.yaml | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
