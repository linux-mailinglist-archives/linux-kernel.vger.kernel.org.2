Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5845F38DB49
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEWNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:44:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49090 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:44:39 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94D4D2A8;
        Sun, 23 May 2021 15:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621777391;
        bh=e9WKWb2u3+bpo7AIMrf2X78HJQYY6mY097rfyST6qt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtkwcOFMp67WVI6LFBd3yW+lKPIAfwhrC4MSKjlEWMLHuUx8hawBg3tsvh3JqcEzw
         C0xtWWaNK9ZcPH5e68CEvhKn+rbY9uNF+cJO2m0URx2RClftIwICJ+aUPQPLTdhvxF
         EZLU3wd3MJ1oGFfyt9iZJ6i3e1C/11c000aVkZzA=
Date:   Sun, 23 May 2021 16:43:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] OF: of_address: clean up OF stub functions
Message-ID: <YKpb7CBAGqpmFS7P@pendragon.ideasonboard.com>
References: <20210523022807.5193-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210523022807.5193-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Sat, May 22, 2021 at 07:28:07PM -0700, Randy Dunlap wrote:
> Adjust <linux/of_address.h> so that stubs are present when
> CONFIG_OF is not set *or* OF is set but OF_ADDRESS is not set.
> 
> This eliminates 2 build errors on arch/s390/ when HAS_IOMEM
> is not set (so OF_ADDRESS is not set).
> I.e., it provides a stub for of_iomap() when one was previously
> not provided as well as removing some duplicate stubs.
> 
> s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
> irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
> s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
> timer-of.c:(.init.text+0xa4): undefined reference to `of_iomap'
> 
> Tested with many randconfig builds, but there could still be some
> hidden problem here.
> 
> Fixes: 4acf4b9cd453 ("of: move of_address_to_resource and of_iomap declarations from sparc")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  include/linux/of_address.h |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> --- linux-next-20210521.orig/include/linux/of_address.h
> +++ linux-next-20210521/include/linux/of_address.h
> @@ -106,11 +106,7 @@ static inline bool of_dma_is_coherent(st
>  }
>  #endif /* CONFIG_OF_ADDRESS */
>  
> -#ifdef CONFIG_OF
> -extern int of_address_to_resource(struct device_node *dev, int index,
> -				  struct resource *r);
> -void __iomem *of_iomap(struct device_node *node, int index);
> -#else
> +#if defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS) || !defined(CONFIG_OF)

Parentheses would help making the precedence order clear.

On sparc, CONFIG_OF is set, CONFIG_OF_ADDRESS isn't, and
of_address_to_resource() is provided by arch code. You'll stub it out
here, which doesn't seem correct to me.

>  static inline int of_address_to_resource(struct device_node *dev, int index,
>  					 struct resource *r)
>  {

-- 
Regards,

Laurent Pinchart
