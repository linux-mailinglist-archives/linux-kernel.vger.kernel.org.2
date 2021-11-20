Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F66457FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhKTRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhKTRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:24:38 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D17C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 09:21:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 8so12535316qtx.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dklIDAaghO+Tz5i61I0cD9/R2sWzOsTEWpON7OMe1m4=;
        b=br9DkPnIyHAyRmonsI+Km5I5t/s+Ovax9wxzpaIrf6dQbfOlnAGIThFdJhIxk7ZqBp
         RiQ2UxgYCKllPQUy21fOOXRQkzouS3pS/mu31K8JRzGyrYRZPpxT5Ct+xplAJUjeJhE3
         9xIICkyFxI9+7sc6G7Q1iz/I+EtKpVyB5HJkIXWcuEC4ogLgbFWWZwwI6ch3ezkuX51c
         STC1gz3Ld7jEyWEAOx8VrKzrsGzjfMbGH5D9XnRZ8wFqeD4cHaER+lfktpdr5vNSxCIK
         hJid5TEkIG38AQZ1FgiE2RBSTQwUBbdcc2z1YCwTZUGEGCDbmPkV9Y/egjbEFn6rwy7C
         pLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dklIDAaghO+Tz5i61I0cD9/R2sWzOsTEWpON7OMe1m4=;
        b=Bt+rVnOu3c2jKDoSCZAiXJF/VQZjSuclAG4v7lG24y75W4MfyWdDuWfqkGDFrYMUW3
         ZaA4gDaS7TpxBNa1kddRVD07fH792T2K7iOu8ZHFrCihMuxX29qz1naK7m49fZDq/aYC
         ekRwXa+LW/d4Yd3Oyv62dWnH1vM6MA8xWz5Iuz1qsqfD/GphYJjK3Tm2XKd7sQBiVF2n
         eS0crMjuiTU0mYw2qHD9CZjEJAJp/4ucVRIBXjEiYae68iTZqbafjQ42Jm3WjBGaB6GE
         LzuDZIVJrL3r6FnHXk6grjYbmwz3V07Bnfq7uuP/e4Pl6BSMQ+oeC0JC3zL2oiMJ4fVb
         9SBA==
X-Gm-Message-State: AOAM533Yr3E4e3J3Do7XgKNHrSIZVjIVv4kfPdFugFi6CUkSSeOlhOrb
        BjltI3l6QFr87Rfbs7U/1ac=
X-Google-Smtp-Source: ABdhPJxJRFi7S0uXkEiMXynRu9sDoUGTl0cFMMQXlgHb5pIbh0cr/SkW/qq7VClaKTtrfsrokggULQ==
X-Received: by 2002:a05:622a:1450:: with SMTP id v16mr16291638qtx.367.1637428893609;
        Sat, 20 Nov 2021 09:21:33 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id y73sm1639416qkb.113.2021.11.20.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 09:21:33 -0800 (PST)
Date:   Sat, 20 Nov 2021 12:21:31 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: ti: omap-usb2: Fix the kernel-doc style
Message-ID: <YZkum7CrX/51TpMx@shaak>
References: <20211120061531.410771-1-vkoul@kernel.org>
 <20211120061531.410771-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120061531.410771-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Sat, Nov 20, 2021 at 11:45:31AM +0530, Vinod Koul wrote:
> The documentation uses incorrect style, so fix that.
> 
> drivers/phy/ti/phy-omap-usb2.c:102: warning: Function parameter or member 'comparator' not described in 'omap_usb2_set_comparator'
> 
> While at it, use a single line for function description
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> Changes in v2: use () for function names
> 
>  drivers/phy/ti/phy-omap-usb2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index ebceb1520ce8..3a505fe5715a 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -89,9 +89,9 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
>  }
>  
>  /**
> - * omap_usb2_set_comparator - links the comparator present in the system with
> - *	this phy
> - * @comparator - the companion phy(comparator) for this phy
> + * omap_usb2_set_comparator() - links the comparator present in the system with this phy

My apologies for the noise, I just noticed your v2.

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> + *
> + * @comparator:  the companion phy(comparator) for this phy
>   *
>   * The phy companion driver should call this API passing the phy_companion
>   * filled with set_vbus and start_srp to be used by usb phy.
> -- 
> 2.31.1
> 
