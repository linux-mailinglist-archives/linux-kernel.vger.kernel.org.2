Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B8415B14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhIWJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhIWJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:39:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B13C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:37:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so15282988wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JgdO99Nh9eMU52WYnIvz3GvtR2odx+tT24+8KrDRTdc=;
        b=0EvSq6OehNE6x6czWkNvhuABKoVLFfN8ekIQk+ZkjOb1trXo2Lk2tFLfRz2KmVZB31
         t9n6Y0xyyfTcZHJEsEGqjtv39qu02BKdRkqM63LqEghGdU76dROsAsP5NIok+K3PBzAh
         T3WVl6to5FdqsPEBHHUVYX4TLWsmSV0BUxFDStPHHFWRwONhXtXSDwXsSJI5uQi1rPgF
         14+QYtbshDAYWCH7ZScEPB9fQ69qTSheQAq5j9M1WTf9LRgIol6TVmh0+sO9uCvjPMzM
         Xvvu7Q/8N40N1UoqrW/WFMjzlkMl9Tp8vdP3tZJ0Yx3UbO2HLWi8CVqlJy5XkDHvobwc
         tIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JgdO99Nh9eMU52WYnIvz3GvtR2odx+tT24+8KrDRTdc=;
        b=kUzcJTWHhuz1VCntlVzqiEIpRaEXEL7itbFghX8IJZBx7vMmlTg3wmKJp1FAMveDV6
         Dgw8LwPjj/dzY3rwIzFThxtXbK6EGwcLm9duY5n5/DJw+y2P2J3jziTyNVjMAk9QfPd3
         2v/e1C5EzRn7nVmJR2d8dwo8/TvtlUszlWKYPz6EPkpvFHDxZy5tAiFoPrmEpWgtAOTf
         yexACnfQoc6/3SJYn0z+hM7dZ61SmfBwB3CLCGxRVcZAq1HThjJY6b+wX93+X37B9uTu
         crkgrJwbY5dP2xQz5rkhMkb/6w99FSVm5jR6oxrXCt9cQRPS/MOAZborooMs549rU20W
         nRKA==
X-Gm-Message-State: AOAM532T+8ec9ywKfhxJSg2BLFeZI/Pcw8eK+Lfy0QfRJmKuXZaJ8C/O
        sfPJYqIx0bhz3XVIv8F5UXyYTZXxchbQ6C1SZH8mnw==
X-Google-Smtp-Source: ABdhPJxC3dTMAYzm0Ms3oPin268gD/8g64ClSDepf1A3FfmmPaB0BfAlRytVXsQa52z022lwKCQArCvyWLmS49VpLKA=
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr14799601wmj.176.1632389866537;
 Thu, 23 Sep 2021 02:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
In-Reply-To: <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Sep 2021 15:07:34 +0530
Message-ID: <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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

On Thu, Sep 23, 2021 at 2:55 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
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

Actually, "mmu-type" would be a good place because it's page based
memory attribute and paging can't exist without mmu translation mode.

Also, "svpmbt" is indeed a CPU property so has to be feature individual
CPU node. Hypothetically, a heterogeneous system is possible where
some CPUs have "svpmbt" and some CPUs don't have "svpmbt". For
example, a future FUxxx SoC might have a E-core and few S-cores
where S-cores have Svpmbt whereas E-core does not have Svpmbt
because it's an embedded core.

Regards,
Anup

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
>
> Regards,
> Nick
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
