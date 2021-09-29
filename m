Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE22D41C7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbhI2PB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344912AbhI2PBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:01:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBECF613A6;
        Wed, 29 Sep 2021 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632927575;
        bh=VUb8Hz0/BpNdgps2xTkakpwXoPg5XQy5xf84s5JEXVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OFBBzHkgQI9pM3LmRLhMl3lZk092dBuPGTLGeDbB7UXUbCAegu9SvLAB8mbtqxvBs
         0WABJBws6oAJNxae2pQMr2F613WDHf8KuZBPs5Yqp9ZrRG0W9x7Rz6KIzmH1qV54vg
         GrHUMVzw23yRVOr2QRE549jZ3XdM6vWw43F9B90Hm8aIv+sYURQ5IWB/2ZAyZ5RfiM
         Q7u89y1ysxUuSz1bVvVBkpSNEBbn5qviU7HdodZgGVvWAz2OFbzJAp9u5RMj79/DZz
         pvUQDdcnoXKq+lI9zgeCcIJFmOYnbwywVysIRKGvH/mBZ82RRRbVl7lnFqXM0d2Abb
         qKUWIy5haa/0A==
Received: by mail-ed1-f47.google.com with SMTP id v10so9866079edj.10;
        Wed, 29 Sep 2021 07:59:35 -0700 (PDT)
X-Gm-Message-State: AOAM533U7HQ/QkJ3NRvMdtdDHql46bx66x6Jq7eBgWTeLGTZLAhjxHQh
        jnfxVrN5NgbhWHA043F7V7WmBluGW+RmkgeokQ==
X-Google-Smtp-Source: ABdhPJxsD+TnDFNUqanlGBCypQs3xKOluvNlkE0i13YzaQBkJ7d4Ds18d5fx4ZdpNBIF8fQe7huJSOVXh7Nq7sEZVgI=
X-Received: by 2002:a17:906:c10e:: with SMTP id do14mr231513ejc.84.1632927503293;
 Wed, 29 Sep 2021 07:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210928201214.294737-1-trix@redhat.com> <CAL_JsqKMLu1Vm1x0rVGXf-RD2Mw65f3YPY3QL1mEB8=CQ9GMGw@mail.gmail.com>
In-Reply-To: <CAL_JsqKMLu1Vm1x0rVGXf-RD2Mw65f3YPY3QL1mEB8=CQ9GMGw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Sep 2021 09:58:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmcTPqopCcETeFUsgG=nDSUMVvVBAMMuCF_j-SzfoAEw@mail.gmail.com>
Message-ID: <CAL_JsqJmcTPqopCcETeFUsgG=nDSUMVvVBAMMuCF_j-SzfoAEw@mail.gmail.com>
Subject: Re: [PATCH] of: remove duplicate declaration of of_iomap()
To:     trix@redhat.com
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 9:26 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Sep 28, 2021 at 3:12 PM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > A ranconfig produces this linker error
> > irq-al-fic.c:252: undefined reference to `of_iomap'
> >
> > The declaration of of_iomap() is dependent on OF
> > The definition of of_iomap() is dependent on OF_ADDRESS
> > These should match.  There are duplicate declarations
> > of of_iomap(), remove of_iomap() and the
> > of_address_to_resource() duplicate.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  include/linux/of_address.h | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 45598dbec269..a190996b4b0b 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -122,13 +122,7 @@ static inline bool of_dma_is_coherent(struct device_node *np)
> >  {
> >         return false;
> >  }
> > -#endif /* CONFIG_OF_ADDRESS */
> >
> > -#ifdef CONFIG_OF
> > -extern int of_address_to_resource(struct device_node *dev, int index,
> > -                                 struct resource *r);
> > -void __iomem *of_iomap(struct device_node *node, int index);
>
> This is going to break sparc which has !OF_ADDRESS and its own
> of_iomap and of_address_to_resource implementations. I don't want to
> add CONFIG_SPARC in here, so I think we should solve this in kconfig.
> OF and !OF_ADDRESS is supposed to mean the arch provides these
> functions.
>
> I'd really like to do away with HAS_IOMEM. It doesn't serve much
> purpose other than disabling a bunch of drivers.

Following UML (the only other arch with configurable HAS_IOMEM), I
think dummy ioremap() implementations is the way to go here. UML added
its own dummy functions, but it would be better if we can just do
this:

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e93375c710b9..a9d02403b2fe 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -946,7 +946,7 @@ static inline void *phys_to_virt(unsigned long address)
  * can provide stricter non-posted write semantics if the architecture
  * implements them.
  */
-#ifndef CONFIG_MMU
+#if !defined(CONFIG_GENERIC_IOREMAP)
 #ifndef ioremap
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
@@ -961,7 +961,7 @@ static inline void iounmap(void __iomem *addr)
 {
 }
 #endif
-#elif defined(CONFIG_GENERIC_IOREMAP)
+#else /* CONFIG_GENERIC_IOREMAP */
 #include <linux/pgtable.h>

 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
@@ -972,7 +972,7 @@ static inline void __iomem *ioremap(phys_addr_t
addr, size_t size)
        /* _PAGE_IOREMAP needs to be supplied by the architecture */
        return ioremap_prot(addr, size, _PAGE_IOREMAP);
 }
-#endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
+#endif /* CONFIG_GENERIC_IOREMAP */

 #ifndef ioremap_wc
 #define ioremap_wc ioremap


Then we can apply the following patch:

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3dfeae8912df..4a2453e4d4f3 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -64,7 +64,7 @@ config OF_DYNAMIC

 config OF_ADDRESS
        def_bool y
-       depends on !SPARC && (HAS_IOMEM || UML)
+       depends on !SPARC

 config OF_IRQ
        def_bool y
