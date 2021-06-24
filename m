Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A33B3830
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhFXUyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:54:55 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:34813 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:54:54 -0400
Received: by mail-il1-f177.google.com with SMTP id s19so7719428ilj.1;
        Thu, 24 Jun 2021 13:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8861/Ltxyv7hm5eHaFAyTFZdG7GDOnf3PVQFvmrdWw=;
        b=L4LwN4LPl6rUedCF/bIjWgbKy3y7yQ23qUalph8+BTfOxS6UKmIjk4EFf3h6H8ZT7u
         joYZA/JWxUCfMOo8AaxBRKq+dc4kVegW90gCD8RihZKU4J779zyDJ/swTvlT+O5Av1P3
         l58FK3D7GMmCJ2Ywx4BaUOz4Lhm9aH7z2xKdmiGMld1gjOdPs5/KSZ1Lbpf4wIkWvPgG
         SvVHx2rHwYRabBcAGSJrJ0AGUIo2BIt6AynVt3++S0NTzCRr+ZYGr0Cu2wGQRs8zyIFs
         vw0Z6vHuMILxAStb1H85tjsC4Ii5rY66Llm2cAKWTNFGbUuhBQWcCUGpYYGsFWBELNWI
         d/hA==
X-Gm-Message-State: AOAM533ROFkZjLaZT9HVxC5Kbftov1iF9X1/tRDhfcQ1azj1/qVlFKHy
        DJaZKjqVVFnVCdJbp/Q8ig==
X-Google-Smtp-Source: ABdhPJzWIIkBrpRIzM+C+vdH4fBPbS6HrJYWxULDLZVaedsNS9B+ORvrty3k9hSL9Csmj/o2XjA1yQ==
X-Received: by 2002:a92:a002:: with SMTP id e2mr4938339ili.98.1624567953687;
        Thu, 24 Jun 2021 13:52:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q8sm2066938iot.30.2021.06.24.13.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:52:33 -0700 (PDT)
Received: (nullmailer pid 1968363 invoked by uid 1000);
        Thu, 24 Jun 2021 20:52:29 -0000
Date:   Thu, 24 Jun 2021 14:52:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, krzk@kernel.org,
        shawnguo@kernel.org, daniel@0x0f.com, linux@rempel-privat.de,
        kuninori.morimoto.gx@renesas.com, max.Merchel@tq-group.com,
        geert+renesas@glider.be, airlied@linux.ie, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alistair23@gmail.com
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for E Ink VB3300-KCA
Message-ID: <20210624205229.GA1966800@robh.at.kernel.org>
References: <20210615103312.872-1-alistair@alistair23.me>
 <20210615103312.872-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615103312.872-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:33:12PM +1000, Alistair Francis wrote:
> Add support for the 10.3" E Ink panel described at:
> https://www.eink.com/product.html?type=productdetail&id=7
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
> v2:
>  - Fix build warning
>  - Document new string
> 
>  .../bindings/display/panel/panel-simple.yaml  |  2 ++
>  drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index b3797ba2698b..799e20222551 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -128,6 +128,8 @@ properties:
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>        - edt,etm0700g0dh6
>        - edt,etm0700g0edh6
> +        # E Ink VB3300-KCA
> +      - eink,vb3300-kca

Combining this with patch 1 would be preferrable. Either way,

Acked-by: Rob Herring <robh@kernel.org>
