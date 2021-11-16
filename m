Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A942C4537F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhKPQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbhKPQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:46:05 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:43:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b17so14176356qvl.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBIcYw/n23OIMpLRX1RLZiL+IY8T96dnmnSnvlhsflc=;
        b=TtFCINNE69WzBO0cqgKxZHBKmIiAxvzSwJk5NoyKhCQXH705c/RZ6+6xrJtJifBLBr
         YsoWmaeKiQ4qHX6EBJLe7Rg+kwmYPUFn51JY8J7HM4fL35k1qR7lCrYJHJAzyvGDMMs2
         5qTD+23czcmaL0jyyrpQbj57BrJcozvOnBUTRx1P6kNT0c62xiFCJRaVMpudnR2dnl2o
         FVyPCt8kFVM8MlZdZgTCYNslXa6QV2kDbNAP/0G85oBtOtfEeVzmqmJzRTG3BIHO74r7
         hgKYzsCCqkkkViIRAQP8iEWyhT3u1ryREdsRvrucdXnkjwL+DXVNPgUtIPwD1+zymT+j
         /R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBIcYw/n23OIMpLRX1RLZiL+IY8T96dnmnSnvlhsflc=;
        b=RljBNXLTB9TNjyBxctChKJtUP6+/dYiJ0tN7Oc8YFjLgGXaRPADnX77dffz9fbh55l
         iA9pRh+yE3bK36i8iRGDfqMKaJYfIYAz9OgHYfS507AtFYRZ++M3nzUJ31cAnZhCvnSq
         GtMjm7OVm5VW59lwUSIfuXqK+HacbYjNp7hohP4Bc8KDHyjYm6nR8Q1IfcuMveF4IPhI
         AQTnpSQBZ54IICcSIOuIKQfz2xDrmv5q3+BLcJZkIVdaNivGQchAOnHkx6HEuCjrR4yV
         RhS9cYHCFdmlqmzispXt7gf2jmBLyZMYvYcECLpOvQguYBX4cM7YV4YwA+1F1KN/q7Zq
         d1kQ==
X-Gm-Message-State: AOAM533S4DKYZYTHlRhcWW0Yvj/4rdX+tyyPOGKb4SZx11OAEc2HhBup
        92QN8yiBa0jXcRWKaIi+m6w=
X-Google-Smtp-Source: ABdhPJxFwaTkqqf3jm0Z7Z04/7P7173dQIuvHfqSj4tlnmr1yAikdUMYKd9CGj5pxL+lutqFIgMBFg==
X-Received: by 2002:ad4:446f:: with SMTP id s15mr46781867qvt.1.1637080987588;
        Tue, 16 Nov 2021 08:43:07 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id 16sm7146497qty.2.2021.11.16.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:43:07 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:43:05 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] phy: ti: omap-usb2: Fix the kernel-doc style
Message-ID: <YZPfmXPAnsK8TH0m@shaak>
References: <20211116103951.34482-1-vkoul@kernel.org>
 <20211116103951.34482-5-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116103951.34482-5-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, Nov 16, 2021 at 04:09:50PM +0530, Vinod Koul wrote:
> The documentation uses incorrect style, so fix that.
> 
> drivers/phy/ti/phy-omap-usb2.c:102: warning: Function parameter or member 'comparator' not described in 'omap_usb2_set_comparator'
> 
> While at it, use a single line for function description
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Minor nit below.

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/phy/ti/phy-omap-usb2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index ebceb1520ce8..2102b7f73ffa 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -89,9 +89,9 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
>  }
>  
>  /**
> - * omap_usb2_set_comparator - links the comparator present in the system with
> - *	this phy
> - * @comparator - the companion phy(comparator) for this phy
> + * omap_usb2_set_comparator - links the comparator present in the system with this phy
> + *
> + * @comparator:  the companion phy(comparator) for this phy

There's an extra space after the colon here.

Cheers,
Liam

>   *
>   * The phy companion driver should call this API passing the phy_companion
>   * filled with set_vbus and start_srp to be used by usb phy.
> -- 
> 2.31.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
