Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E84015BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhIFEim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 00:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhIFEik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 00:38:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C2C061575;
        Sun,  5 Sep 2021 21:37:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b10so7822752wru.0;
        Sun, 05 Sep 2021 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZODmmsHnkb7YAmT21C2rjrCFhtMoQ3D7EpFSk4oK4BU=;
        b=YMZLeMVQt0/nJOj7hCXA2VynWaRyQ/SuOVzh/dEIcXv1PZEFLs1/HbyZ2PsXtnPu58
         B3ze0z8wa5bBpikrYTBLZBabO5XpoOga9eD9ycEsflkbUGZRNd+mWkpgHCB8rhdsdf/f
         E662UqpUTABtprYvK5phN/xta17OzLiwxtCVSWrAavyZg7OS9iysnh6xYIkJKyuxmQ74
         mXtAkYAuasWl0R9/9zlIt5m2RbKFdCIdQLksG8qzB/MlpVVHDcEOynccd93tUkuRTJhJ
         YS6JAmxF2bcaXE28a7T6ZfKJbDs0kef0DtRYUI4NvIipvXKqsIFeqSQBxgCst5v28BFx
         b0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZODmmsHnkb7YAmT21C2rjrCFhtMoQ3D7EpFSk4oK4BU=;
        b=YXDlqfZ13Pq09RUUqJXVq47m095766Zu9hysPGzI+LSkoraxP09xJtqxPHSk1I0J3f
         /zHKE8mAiHUzQzwrY2wyxG13GCJtbDln5wYqvhwyZCYFxFC1F62754gl3coEAbOAtNb+
         GuEopAEHYJ7vYW5IkTIPylloaVVWqNVEnYI3kvFEAC3bPCrP9hsW0crk2+ayLIUAwGoM
         slwAX/XjmNLe/QGlQDRQHCxJ/vgzWKR/+PxIYTxMqrMJBb8TLGKXG2h6xopPL5kSWQoe
         L2bFdipxP240otZO+1IUbTU+f8Ieim5slCLEt84UjUYpI31wtmm/ul34iFPg58/C/ES1
         GZew==
X-Gm-Message-State: AOAM531rnDgwBNoqxzuwCMcnd9ctGGkok1NtaEZ3KL7XeJmJv76nNIC3
        hqoQ4Y86WVs1SstUgYsjFARxImxQMWQLNpIYB7I=
X-Google-Smtp-Source: ABdhPJzr11GM4ZqwmgiRq7QVSTYG2ETqOQB7tS+fE5b68p3/VrXiQfLMZfEqvbTwQ0YQ/lAaXumg5DtarCFmCU4lj4U=
X-Received: by 2002:adf:fc43:: with SMTP id e3mr10737483wrs.436.1630903054251;
 Sun, 05 Sep 2021 21:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210902092704.2678277-1-zhang.lyra@gmail.com> <CAL_JsqJrXPEEJrPnhZKhrddBw3LHwoKEJ3-eoMOsRtGt6k8i7w@mail.gmail.com>
In-Reply-To: <CAL_JsqJrXPEEJrPnhZKhrddBw3LHwoKEJ3-eoMOsRtGt6k8i7w@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 6 Sep 2021 12:36:57 +0800
Message-ID: <CAAfSe-vpmqSH9mzecn8w4qsD_zg7SFKkJy=bwVZxdwyVqd73kw@mail.gmail.com>
Subject: Re: [PATCH] of: fix of_address_to_resource and of_iomap undefined
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000364ed005cb4c35a8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000364ed005cb4c35a8
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Sept 2021 at 04:23, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 2, 2021 at 4:27 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > If CONFIG_OF is selected, but CONFIG_OF_ADDRESS is not, when compiling
> > files (sunch as timer_of.c) in which the function of_iomap() is invoked,
> > compiler would report 'undefined reference to of_iomap', the same case
> > is for of_address_to_resource().
>
> What arch and config are you building?

sparc, and the config is attached.

>
> > This patch also makes sure that of_iomap() and of_address_to_resource()
> > are declared for sparc so that sparc can have its specific
> > implementations in arch/sparc/kernel/of_device_common.c, even if
> > including include/linux/of_address.h in it.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  include/linux/of_address.h | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 45598dbec269..02a719d58466 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -80,6 +80,23 @@ static inline u64 of_translate_address(struct device_node *np,
> >         return OF_BAD_ADDR;
> >  }
> >
> > +#ifdef CONFIG_SPARC
> > +extern int of_address_to_resource(struct device_node *dev, int index,
> > +                                 struct resource *r);
> > +void __iomem *of_iomap(struct device_node *device, int index);
>
> This is now in the !CONFIG_OF_ADDRESS section. So for
> CONFIG_OF_ADDRESS, we'd never have a function declaration.

Not sure I got your point.
There are these two function declarations both in
arch/sparc/kernel/of_device_common.c (CONFIG_SPARC &&
!CONFIG_OF_ADDRESS) and drivers/of/address.c (!CONFIG_SPARC &&
CONFIG_OF_ADDRESS).

> This change does not look right at all to me.
>
> > +#else
> > +static inline int of_address_to_resource(struct device_node *dev, int index,
> > +                                        struct resource *r)
> > +{
> > +       return -EINVAL;
> > +}
> > +
> > +static inline void __iomem *of_iomap(struct device_node *device, int index)
> > +{
> > +       return NULL;
> > +}
> > +#endif

Now, I'm also not sure if this change is right, I learned in another
patch recently that Linus prefers to avoid the extra code like this.

https://lkml.org/lkml/2021/7/2/511



> > +
> >  static inline const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
> >                                              u64 *size, unsigned int *flags)
> >  {
> > @@ -124,22 +141,6 @@ static inline bool of_dma_is_coherent(struct device_node *np)
> >  }
> >  #endif /* CONFIG_OF_ADDRESS */
> >
> > -#ifdef CONFIG_OF
> > -extern int of_address_to_resource(struct device_node *dev, int index,
> > -                                 struct resource *r);
> > -void __iomem *of_iomap(struct device_node *node, int index);
> > -#else
> > -static inline int of_address_to_resource(struct device_node *dev, int index,
> > -                                        struct resource *r)
> > -{
> > -       return -EINVAL;
> > -}
> > -
> > -static inline void __iomem *of_iomap(struct device_node *device, int index)
> > -{
> > -       return NULL;
> > -}
> > -#endif
> >  #define of_range_parser_init of_pci_range_parser_init
> >
> >  static inline const __be32 *of_get_address(struct device_node *dev, int index,
> > --
> > 2.25.1
> >

--000000000000364ed005cb4c35a8
Content-Type: application/gzip; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_kt81yiw00>
X-Attachment-Id: f_kt81yiw00

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
--000000000000364ed005cb4c35a8--
