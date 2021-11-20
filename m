Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00932457FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhKTRN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKTRNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:13:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA543C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 09:10:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so12443769qtj.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnCwGlmPlhsgWQpMrlEyz6X5l8iowoAG+7+85zNSQa0=;
        b=bjVIfRv16oqa3RY0VQFnugJ2LPvWU6g4JkQbJrUzhVioYnrZpS/hVp+RKtc2+QnycH
         yTC2IxdOr//4m5gf+n0jUO2/JvMg1BqFAIFqIncELNiGobvbawjc76E6pEM8GIm3d1zL
         +vpmG19/3fWJAYN9nyMKSHxnc2Xhsg8DisCZWyOaNLTcrCbcK6wJe9rq/WmJybF2AqyZ
         nqwVlrI+fWGfMPFMYc9SPFSB5Ad0N9nQNxZR1lc4Hu6y4PHtSBIN/2cy8ISXWPg7hebL
         nVH4eG3/+QvAO4Lb7eEPS5H8p92kltlKh58piBwzIXnBacDAmm2xIgwW86xlU9OJNw2/
         f62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnCwGlmPlhsgWQpMrlEyz6X5l8iowoAG+7+85zNSQa0=;
        b=E1L1wF723Epz1PS/vk9Xj7Z0buxX7A4Qedh2wPZ03lr+4aGfQMBdfHD9KJw18luq9b
         iORLamSU8T+hECn5GGfdYOUXM/GjmBW02yBX5OqonPgfklUAzXSMGDn99ldZxSRLlUvM
         fX2l0nnwJWjiMx2nkYNk6f+Pgvf3U5Tp3N1wFpuOX8lmGgvRD5KXbDKoj5XFWkYDdEGO
         9vU5M9wF8IZ98ZMH7QFi/S/2fyam/WvFzHKrQl1yYSfPdYW4h6uZuVP/zKtptRQNX9Lx
         vazDSSOruuQq0GnkRqxst3v0wgVyGAl7ADQ3+I39Mdi9b/Z1+1u519KAZydEbf8qNMd6
         1DBw==
X-Gm-Message-State: AOAM533J3DK2ny2lP+JzrhfZBiUqq3sKg9cTZY5gBsQJ8i6nSm0nhIXi
        Dvn65ITz4x33PoMnw1PkPEc=
X-Google-Smtp-Source: ABdhPJxmLJ9cPxPyROhuAhoZzpXUEVfmcf7jI4hdEn3zqmi+b3YNIv9iAAXNtNUxeuA4jVeCZmdaKA==
X-Received: by 2002:a05:622a:1014:: with SMTP id d20mr16892890qte.399.1637428221068;
        Sat, 20 Nov 2021 09:10:21 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h68sm1650389qkf.126.2021.11.20.09.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 09:10:20 -0800 (PST)
Date:   Sat, 20 Nov 2021 12:10:18 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] phy: ti: omap-usb2: Fix the kernel-doc style
Message-ID: <YZkr+vwyiIfKx2Nc@shaak>
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

I missed it before but as Bjorn pointed out in this thread, it appears
the function name should end with parentheses.

Cheers,
Liam

> + *
> + * @comparator:  the companion phy(comparator) for this phy
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
