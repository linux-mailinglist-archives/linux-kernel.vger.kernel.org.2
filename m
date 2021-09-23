Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D707415DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhIWMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240619AbhIWMGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 742D561350
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632398682;
        bh=e/+UbbP4lgy47i5DizVGJq66jnIowBxOKInoe0GBfes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E7Z6lURRwPOd+b0eSdVHuXzizolccFX3vYiomS6c6WMNUR7I7y/8Rd9NRQyysAmZ0
         veRaDj+mDQn4RwDn/rHRLAq7Il0kPJpFzzP3IFMOcSvXDnZZadCBQim/QlnhwXfPee
         ik8Rjtii5JIFR0HjAsYbyb70IrfvEnZNfq0IoVzJkbQ+ZvTUc0qOdC22Gm1GpmT85C
         riAsMK9eUWiudCvNH4Z7m634Lr+8YIp5f8ctD/wL3mpPcjrwKtq9hLk4De40twKvEl
         f+6e+vsKyQbn4CDcWeQbqneOL/ALfy71D2Y/gDRK+qITqrgKbi9tQ6Q3tb7LJQzet0
         IxMEQbySrhg7Q==
Received: by mail-vs1-f47.google.com with SMTP id 66so2243577vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:04:42 -0700 (PDT)
X-Gm-Message-State: AOAM533frvXGQIVc5xbeqFSagfbk1D2B5BOPrGV5edy0gQfjoEMBNzLL
        zO4cS7ae+xR3wIFMu9uBhxcSvWS4Ywmr66z9G/4=
X-Google-Smtp-Source: ABdhPJwT4czW0Uy5eZprQ0ZC+RBvDthQG3//W+5N2FJ6Hb1odvqHqDJVW9Lgyf/wpIEi0+cduQdNWiaFQUAVD1bwICQ=
X-Received: by 2002:a67:2f96:: with SMTP id v144mr3355246vsv.33.1632398681340;
 Thu, 23 Sep 2021 05:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
In-Reply-To: <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Sep 2021 20:04:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRJGbxYMYSEwj70SMKZOfvH49mvkQyy3x46HVerbqVpXQ@mail.gmail.com>
Message-ID: <CAJF2gTRJGbxYMYSEwj70SMKZOfvH49mvkQyy3x46HVerbqVpXQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 5:48 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello Guo,
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 10:27, guoren@kernel.org =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index e534f6a7cfa1..1825cd8db0de 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -56,7 +56,9 @@ properties:
>       enum:
>         - riscv,sv32
>         - riscv,sv39
> +      - riscv,sv39,svpbmt
>         - riscv,sv48
> +      - riscv,sv48,svpbmt
>         - riscv,none
>
> Isn't svpbmt orthogonal to the mmu type ? It's a functionality that can
> be present on either sv39/48/57 so why not have another "svpbmt"
> property directly on the cpu node ?
Agree, But that's another patch to redesign mmu-type in dts.

>
> > + * rv64 PTE format:
> > + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 |
> > 3 | 2 | 1 | 0
> > + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U
> > X   W   R   V
> > + * [62:61] Memory Type definitions:
> > + *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
> > + *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> > + *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O
> > memory
> > + *  11 - Rsvd   Reserved for future standard use
> > + */
> > +#define _PAGE_MT_MASK                ((u64)0x3 << 61)
> > +#define _PAGE_MT_PMA         ((u64)0x0 << 61)
> > +#define _PAGE_MT_NC          ((u64)0x1 << 61)
> > +#define _PAGE_MT_IO          ((u64)0x2 << 61)
> > +
>
> It'd be cleaner IMHO if you defined _PAGE_MT_MASK as (_PAGE_MT_PMA |
> _PAGE_MT_NC | _PAGE_MT_IO), like other masks are defined (e.g.
> _PAGE_CHG_MASK on the same file). I also suggest you use unsigned long
> instead of u64 for consistency.
Okay

>
> > +enum {
> > +     MT_PMA,
> > +     MT_NC,
> > +     MT_IO,
> > +     MT_MAX
> > +};
> > +
> > +extern struct __riscv_svpbmt_struct {
> > +     unsigned long mask;
> > +     unsigned long mt[MT_MAX];
> > +} __riscv_svpbmt;
> > +
> > +#define _PAGE_DMA_MASK               __riscv_svpbmt.mask
> > +#define _PAGE_DMA_PMA                __riscv_svpbmt.mt[MT_PMA]
> > +#define _PAGE_DMA_NC         __riscv_svpbmt.mt[MT_NC]
> > +#define _PAGE_DMA_IO         __riscv_svpbmt.mt[MT_IO]
> > +#else
> > +#define _PAGE_DMA_MASK               0
> > +#define _PAGE_DMA_PMA                0
> > +#define _PAGE_DMA_NC         0
> > +#define _PAGE_DMA_IO         0
> > +#endif /* CONFIG_64BIT */
> > +#endif /* __ASSEMBLY__ */
> > +
> >  #define _PAGE_SPECIAL   _PAGE_SOFT
> >  #define _PAGE_TABLE     _PAGE_PRESENT
> >
>
> This struct is not useful as part of enabling the standard Svpbmt
> extension on Linux, we can set _PAGE_DMA_* macros directly on this patch
> and introduce the struct approach later on, when we also define
> alternative values for _PAGE_DMA_* flags. Also to someone reading the
> code the struct doesn't make sense without some documentation on why
> it's needed. Finally why the enum / array ? Why not just have different
> fields on the struct ?
Okay, I'll use different fields on the struct.

>
> > diff --git a/arch/riscv/include/asm/pgtable.h
> > b/arch/riscv/include/asm/pgtable.h
> > index 39b550310ec6..d07ba586c866 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -136,7 +136,8 @@
> >                               | _PAGE_PRESENT \
> >                               | _PAGE_ACCESSED \
> >                               | _PAGE_DIRTY \
> > -                             | _PAGE_GLOBAL)
> > +                             | _PAGE_GLOBAL \
> > +                             | _PAGE_DMA_PMA)
> >
>
> That's a bit misleading, it's like marking the kernel pages as DMAable.
>
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so
> we can't
> - * change the properties of memory regions.
> - */
> -#define _PAGE_IOREMAP _PAGE_KERNEL
> +#define _PAGE_IOREMAP    ((_PAGE_KERNEL & ~_PAGE_DMA_MASK) |
> _PAGE_DMA_IO)
> +
> +#define PAGE_IOREMAP        __pgprot(_PAGE_IOREMAP)
>
> This isn't used anywhere.

See:

arch/riscv/include/asm/fixmap.h
@@ -43,7 +43,7 @@ enum fixed_addresses {
        __end_of_fixed_addresses
 };

-#define FIXMAP_PAGE_IO         PAGE_KERNEL
+#define FIXMAP_PAGE_IO         PAGE_IOREMAP

>
> @@ -490,6 +489,28 @@ static inline int ptep_clear_flush_young(struct
> vm_area_struct *vma,
>       return ptep_test_and_clear_young(vma, address, ptep);
>   }
>
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +    unsigned long prot =3D pgprot_val(_prot);
> +
> +    prot &=3D ~_PAGE_DMA_MASK;
> +    prot |=3D _PAGE_DMA_IO;
> +
> +    return __pgprot(prot);
> +}
> +
> +#define pgprot_writecombine pgprot_writecombine
> +static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
> +{
> +    unsigned long prot =3D pgprot_val(_prot);
> +
> +    prot &=3D ~_PAGE_DMA_MASK;
> +    prot |=3D _PAGE_DMA_NC;
> +
> +    return __pgprot(prot);
> +}
> +
>
> We also have the IO type, we should also define pgprot_device to also
> ensure ordering, or else it'll fallback to pgprot_noncached, which in
> our case won't work well due to RVWMO:
> https://elixir.bootlin.com/linux/latest/source/include/linux/pgtable.h#L9=
30
Current is:
pgprot_noncached =3D pgprot_device =3D IO type
writecombine =3D NC type

I think it's proper.

>
> +void __init riscv_svpbmt(void)
> +{
> +#ifdef CONFIG_64BIT
> +    struct device_node *node;
> +    const char *str;
> +
> +    for_each_of_cpu_node(node) {
> +        if (of_property_read_string(node, "mmu-type", &str)) {
> +            continue;
> +        }
> +
> +        if (!strncmp(str + 11, "svpbmt", 6)) {
> +            __riscv_svpbmt.mask      =3D _PAGE_MT_MASK;
> +            __riscv_svpbmt.mt[MT_PMA] =3D _PAGE_MT_PMA;
> +            __riscv_svpbmt.mt[MT_NC]  =3D _PAGE_MT_NC;
> +            __riscv_svpbmt.mt[MT_IO]  =3D _PAGE_MT_IO;
> +            break;
> +        }
> +    }
> +#endif
> +}
>
> You break; here the first time you find a cpu node with svpbmt enabled,
> shouldn't we make sure that all used cpu nodes support svpbmt before
> using the extension ?
Okay

>
> Regards,
> Nick



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
