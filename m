Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2062B3670C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhDURAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:00:30 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45779 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbhDURA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:00:27 -0400
Received: by mail-ot1-f54.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so34438923otf.12;
        Wed, 21 Apr 2021 09:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+2uWSkW19YMSUIgrRyX+Zrerp6y6BIi//8JY71zHg0=;
        b=Xd1X497ITXsACaOZInK/gmCLpdgEOGJaKoQvMGpiaq0PZRAYBb8kYIfXPzSwaAIn7d
         2IqY3OweFp5cXFVIPLHUTnko6COXAix+YsFIrBIsg70ZuGj6yQW+upI9ADZJ8iD/ZnzW
         ksozCgk7cG4Kxb0v+yuIk11k0Xdvl9xge13AN1cw9yCihtdZpWfQn2sS3eRdjhtT/aae
         xv9i2BoWzW8dfeE3jpywrStE3hcOU3KcYVHGcV4+V953J0aDh5vPBWp6uT+PMo8Idhm3
         Byz3MaqzEPVWMUL3UkicVJjbSzSjFb4LrTnIL4fIZ6lS6LZia75oxV12y8V8LZtR7hKA
         KfrA==
X-Gm-Message-State: AOAM532O/xi75qhnKjzf2qUkTqonpMvH1qwvwMgY3QqbFiL4BuAyPffJ
        6CGFL+wR+w/7LRwY3bfKig==
X-Google-Smtp-Source: ABdhPJwWoz3BS4dg+l9N7pX1PZhZ/4wlq0ogtsxElhcG8h2QSloGBtatkURwBVfcHg/r68nPpaIvzw==
X-Received: by 2002:a9d:615b:: with SMTP id c27mr22752308otk.119.1619024393434;
        Wed, 21 Apr 2021 09:59:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w23sm643762otl.60.2021.04.21.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:59:52 -0700 (PDT)
Received: (nullmailer pid 1292145 invoked by uid 1000);
        Wed, 21 Apr 2021 16:59:51 -0000
Date:   Wed, 21 Apr 2021 11:59:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        boris.brezillon@collabora.com,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        hsinyi@chromium.org, hoegsberg@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>, fshao@chromium.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v13 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
Message-ID: <20210421165951.GA1292095@robh.at.kernel.org>
References: <20210421052855.1279713-1-drinkcat@chromium.org>
 <20210421132841.v13.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421132841.v13.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 13:28:52 +0800, Nicolas Boichat wrote:
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> (no changes since v12)
> 
> Changes in v12:
>  - binding: Fix min/maxItems logic (Rob Herring)
> 
> Changes in v11:
>  - binding: power-domain-names not power-domainS-names
> 
> Changes in v10:
>  - Fix the binding to make sure sram-supply property can be provided.
> 
> Changes in v6:
>  - Rebased, actually tested with recent mesa driver.
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2"
> 
> Changes in v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
