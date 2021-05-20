Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B024389A50
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhETAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:07:21 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41683 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:07:18 -0400
Received: by mail-ot1-f43.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so13319747oth.8;
        Wed, 19 May 2021 17:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/HHwpUG4DYqY1wOYcmevFTpDYTTWuP4aLIe9OEyOIE=;
        b=mc7iP3+OX0PRNnXBD+gsju0zPliruJbY2OhGodC8b6dKM7SI5XTjLuMMjLbA2KnB/B
         u0rXcGn3i/SqovEsflMvm8mg90Ko/H77PPpe9m1awI0JgV2JO+JJZAxxKEKpp+VqVM4H
         qTpjklGYs/kdfkSkH4mVg6bOJve/aCDrfEreDPPAxI5wiWKj8YFbR5OH6hbjxyQxwwnK
         42BpomRf2sHHlSo75q3cz5W8GrMKKkoclLdZfTH4P/Y50W59iT4neIto/C8dfinR4vwo
         zsFFZpUOfnMM0hIllqGTiXdEELwSy747fX33P11EnS0WOjlVNnA+PtHZk7S4hx8SD9cZ
         MXHw==
X-Gm-Message-State: AOAM530d3iyg6yjXGgyrWksdgbNv+sF39wxzl+qC1g/P0pmY9rM2hE5+
        oFLczejzYj1BmZVc5VUvtQ==
X-Google-Smtp-Source: ABdhPJw5gex1OFhEgIpWnHy7lFKkRi3NhLOnuaVuAAlbkZZf7bbRmy2hkqeJlyFMuVyUw1rpIxJDmQ==
X-Received: by 2002:a9d:37e2:: with SMTP id x89mr1786329otb.352.1621469157717;
        Wed, 19 May 2021 17:05:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10sm245097oic.4.2021.05.19.17.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 17:05:56 -0700 (PDT)
Received: (nullmailer pid 3927287 invoked by uid 1000);
        Thu, 20 May 2021 00:05:55 -0000
Date:   Wed, 19 May 2021 19:05:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: phy: rename phy nodename in
 phy-rockchip-inno-usb2.yaml
Message-ID: <20210520000555.GA3927257@robh.at.kernel.org>
References: <20210518165658.12764-1-jbx6244@gmail.com>
 <20210518165658.12764-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518165658.12764-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 18:56:56 +0200, Johan Jonker wrote:
> The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
> in phy-provider.yaml has required "#phy-cells" for phy nodes.
> The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
> Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
> notifications. Remove unneeded "#phy-cells" from parent node.
> Also sort example.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
> phy/phy-provider.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
