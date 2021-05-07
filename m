Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A00376B1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhEGUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:16:18 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39777 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhEGUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:16:15 -0400
Received: by mail-ot1-f45.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso8956509otv.6;
        Fri, 07 May 2021 13:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7l4JEUMp2ZnRM1Fn/oKHA3iE5U9Bk3RHSfWh0z09m4g=;
        b=nycgsEExreD97RA+dUFvHeTXYNNIy29InDa9FypgqnkkZFktd3wcs/B1qcZoyDeEpP
         mdIAgHJtx2s4D1exSdwnSX29CiIwo4GEJZxwvJ5SLtEIoXXKVgdi92/W+MyYFXmAvUS4
         MjxwEgQzIMicBhUBmWnJMriBBzw/j8PCoN8Jjtqzm9gUioPzmQpy1padAFunhDs7pZzz
         sYYo+tmVQ1DM/+ANqyTcwVecGMybcrTEGXaKxtB9yhZvmChNj3paNd3bdLzH0hqYO1nf
         MEGqdn2+qoLWIUNTAc0ArLz1gErcbwJk9rbpCWU5yz3WxN0l1wQsvjaeVJU4EXI/0F5U
         N4Rg==
X-Gm-Message-State: AOAM532QKbjoM8cvko5yQPrQ1MRkRr2G2qTj8OCCIzUg1IoC9NqCwfdm
        y1HjFd6FgroUCiGQJ15uVw==
X-Google-Smtp-Source: ABdhPJwZzmjv8nbBXzcXjgH90d5sMNPJTOhPzToTWSST5h3nq6f1xTuf4EGckNuXIFBESPM0VULEFw==
X-Received: by 2002:a9d:58c5:: with SMTP id s5mr9978209oth.243.1620418513731;
        Fri, 07 May 2021 13:15:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a23sm1413738otf.47.2021.05.07.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:15:13 -0700 (PDT)
Received: (nullmailer pid 2805625 invoked by uid 1000);
        Fri, 07 May 2021 20:15:12 -0000
Date:   Fri, 7 May 2021 15:15:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     devicetree@vger.kernel.org, joro@8bytes.org, robh+dt@kernel.org,
        iommu@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        xxm@rock-chips.com, will@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/6] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
Message-ID: <20210507201512.GA2805596@robh.at.kernel.org>
References: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
 <20210507090232.233049-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507090232.233049-2-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021 11:02:27 +0200, Benjamin Gaignard wrote:
> Convert Rockchip IOMMU to DT schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 4:
>  - Add descriptions for reg items
>  - Add description for interrupts items
>  - Remove useless interrupt-names proporties
> 
> version 2:
>  - Change maintainer
>  - Change reg maxItems
>  - Change interrupt maxItems
>  .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
>  .../bindings/iommu/rockchip,iommu.yaml        | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
