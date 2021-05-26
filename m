Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499839208E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhEZTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhEZTI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA8A610A8;
        Wed, 26 May 2021 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622056018;
        bh=ArzjRoIQImcLyGoAFNv7HeB9ZnbpJBh6UdALpi14PnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UlIeMsrtCkRRoFYoaTtfuyX12NysJpx7L5iKXkP4Bb6IvhF7skLg91u77ZAebW05t
         B2waKvnSuRUS8jNXa9GVY9hQtQsvKNn/APfrUnLS34BU+88QCL71u7clW/AyVWaseo
         KFnn2P86zWG8wULvsJ+2vY1nuk7cMMzpJvggdViF+LgZ5lM3UJzEpAKZe7mpWzZcTK
         eLacnOlpQ2a2TaEuN7prl+OPFeihBrjjgrY+PKl6ggUaZGz1BHHsa46bXsi1PXHbZX
         3I7IBv5s/hxMnMofvxMLimBvsY1jvIHEFmxj1VzSQDG2OMClDx0RKOzAysaez98QHM
         vhKnDm758oh8Q==
Received: by mail-ej1-f50.google.com with SMTP id k14so4172675eji.2;
        Wed, 26 May 2021 12:06:57 -0700 (PDT)
X-Gm-Message-State: AOAM532YYGhzqCXfLO6T0VcvY9YJmbHtTUjMfeBL99tkzLIQ4uJ0n0lb
        p4lBa37tPeysuUM+6CqdWrj2xeGHM7H1SZxreQ==
X-Google-Smtp-Source: ABdhPJxgVqvowzsp7TRxZPskdhCkXc6U/QwXmtf8n6OT0fr1FMW8d8o6pwJSfTkwGMCUkgkVWU1/wtp4/1Bdxtw1hnE=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr34749764ejc.108.1622056016641;
 Wed, 26 May 2021 12:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210524190919.2616-1-rdunlap@infradead.org>
In-Reply-To: <20210524190919.2616-1-rdunlap@infradead.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 May 2021 14:06:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCzFN81vbN=Y5hpvW_u=h9oWPSyK6zrO9kXr9pPArt1Q@mail.gmail.com>
Message-ID: <CAL_JsqLCzFN81vbN=Y5hpvW_u=h9oWPSyK6zrO9kXr9pPArt1Q@mail.gmail.com>
Subject: Re: [PATCH v2] OF: of_address: clean up OF stub & extern functions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 2:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Adjust <linux/of_address.h> so that stubs are present when
> CONFIG_OF is not set *or* OF is set but OF_ADDRESS is not set.
>
> This eliminates 2 build errors on arch/s390/ when HAS_IOMEM
> is not set (so OF_ADDRESS is not set).
> I.e., it provides a stub for of_iomap() when one was previously
> not provided as well as removing some duplicate externs.

Personally, I think we should get rid of HAS_IOMEM or at least most of
its usage in kconfig. It has little purpose beyond hiding drivers in
kconfig and mainly for UML though I think UML no longer needs that
IIRC. (I'm not wild about 'depends on OF' either).

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
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v2: handle SPARC as a special case since it provides its own versions of
>     of_address_to_resource() and of_iomap();
>     fix build errors reported by lkp/ktr and address comments from Laurent;
>     do more randconfig build testing;
>
>  include/linux/of_address.h |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --- linux-next-20210524.orig/include/linux/of_address.h
> +++ linux-next-20210524/include/linux/of_address.h
> @@ -106,11 +106,12 @@ static inline bool of_dma_is_coherent(st
>  }
>  #endif /* CONFIG_OF_ADDRESS */
>
> -#ifdef CONFIG_OF
> +#ifdef CONFIG_SPARC /* SPARC has its own versions of these */

The whole point of CONFIG_OF_ADDRESS is really just for SPARC. So I
don't really like the mixture of the ifdefs here and in kconfig. It
looks only more fragile.

Can we drop the HAS_IOMEM dependency from CONFIG_OF_ADDRESS and then
fix the fallout from that? That would also remove all the other build
time dependencies on HAS_IOMEM.

>  extern int of_address_to_resource(struct device_node *dev, int index,
>                                   struct resource *r);
> -void __iomem *of_iomap(struct device_node *node, int index);
> -#else
> +extern void __iomem *of_iomap(struct device_node *device, int index);
> +#else /* !CONFIG_SPARC */
> +#if (defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS)) || !defined(CONFIG_OF)
>  static inline int of_address_to_resource(struct device_node *dev, int index,
>                                          struct resource *r)
>  {
> @@ -121,7 +122,9 @@ static inline void __iomem *of_iomap(str
>  {
>         return NULL;
>  }
> -#endif
> +#endif /* (defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS)) || !defined(CONFIG_OF) */
> +#endif /* CONFIG_SPARC */
> +
>  #define of_range_parser_init of_pci_range_parser_init
>
>  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
