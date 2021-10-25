Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2A439937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhJYOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233672AbhJYOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635173365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fQIV8R9EVwqjc2F+5+VNaVeJn8YGGw0zb5KvsfSTOE=;
        b=drtnf594sX9RoydTCL7ZU8Ic2Uq30NB/e3qXSAS9cbxR0vVyRDRKl42MHn9psufV/l2jJD
        A1qQGA5b9Xq4NDYB4QpCSFwdsP/54OVGbg1+vUAws/mcs9lnxhdxZ8Vzh4TGOcCmVJmLYO
        CqMitd+2aR6UTzhNxZp3aTYj8QYsiZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Bui2cJBHPKuA3fkyJyogHQ-1; Mon, 25 Oct 2021 10:49:24 -0400
X-MC-Unique: Bui2cJBHPKuA3fkyJyogHQ-1
Received: by mail-ed1-f70.google.com with SMTP id k28-20020a508adc000000b003dd5e21da4bso2522885edk.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fQIV8R9EVwqjc2F+5+VNaVeJn8YGGw0zb5KvsfSTOE=;
        b=xc9EzD80b10cTezmuC3uqgKaiz59nrnGcnjdhfpf/yJnxKi6JfoiPnvmMPzUXoIHfD
         WqeYd4bTRmQfVpX5PPcABg4/DU5W9ZlpCYxTi9BA+Ulxvx5KUk7ly77ZhRmKrJTbKcvE
         jqx/Yn6Q4G+Qc/eWL3BGUoinybu6SUQ3IRKr4ar21dxOGwl3YIsDDI8/OzTtQ5gf3DjV
         dUjrir+8MBT/yceBj1CvKw+ED46if4cgaSNzh9LrOdTdDhMIOjxIs1Lx4GZkOLLBEwM/
         fjTyHI0CGsVENp0ZDi9ar0NhTtDQY1dk/b6Z2d8T465Vbvxp2LdlLs4WvnvBMOHFRxxm
         PvQw==
X-Gm-Message-State: AOAM531Z/cQTLbuokjdhbmB7V1VV7tcZMtBTDeHxPaMZ90Tnh9GdJQVz
        2gPL74wRvrdXptV54FzlJ1fdDMhUR0Dq+EX5Mj3Ux63dh4kwjeBMv1nx2+eZLdRr6y8bgJ8qTWM
        /b794JRkLBAQzALhSL4aquarnWNDb7Q7FlYSp42Cl
X-Received: by 2002:a05:6402:55:: with SMTP id f21mr27200711edu.8.1635173363355;
        Mon, 25 Oct 2021 07:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/3Iij3j6rCMHEZLZ0laZvPfZAeKNcI+Q2GLVeBfeMLuYto9Is0QQTiujMiPil6Vzeuyp3IRplt1X+mCUlfx4=
X-Received: by 2002:a05:6402:55:: with SMTP id f21mr27200658edu.8.1635173362997;
 Mon, 25 Oct 2021 07:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com>
 <YXZU/3/YmRGFrOXK@infradead.org>
In-Reply-To: <YXZU/3/YmRGFrOXK@infradead.org>
From:   Wei Fu <wefu@redhat.com>
Date:   Mon, 25 Oct 2021 22:49:11 +0800
Message-ID: <CA+YCwKn1VA8=NSa=bdhP99jfpokYGHBvqVSKvZmdndQOz6UUPA@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/2] riscv: add RISC-V Svpbmt extension supports
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, guoren@kernel.org,
        christoph.muellner@vrull.eu,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Liu Shaohua <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I hope I understand this correctly,

On Mon, Oct 25, 2021 at 2:57 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Oct 25, 2021 at 12:06:07PM +0800, wefu@redhat.com wrote:
> >  static inline pmd_t *pud_pgtable(pud_t pud)
> >  {
> > -     return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > +     return (pmd_t *)pfn_to_virt((pud_val(pud) & _PAGE_CHG_MASK)
> > +                                             >> _PAGE_PFN_SHIFT);
> >  }
> >
> >  static inline struct page *pud_page(pud_t pud)
> >  {
> > -     return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > +     return pfn_to_page((pud_val(pud) & _PAGE_CHG_MASK)
> > +                                             >> _PAGE_PFN_SHIFT);
>
> >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> >  {
> > -     return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> > +     return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
> >  }
>
> The "(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT" expression begs
> for readable and well-documented helper.

How about these:
#define _chg_of_pmd(pmd)  (pmd_val(pmd) & _PAGE_CHG_MASK)
#define _chg_of_pud(pud)  (pud_val(pud) & _PAGE_CHG_MASK)

>
> > +#define _SVPBMT_PMA          ((unsigned long)0x0 << 61)
> > +#define _SVPBMT_NC           ((unsigned long)0x1 << 61)
> > +#define _SVPBMT_IO           ((unsigned long)0x2 << 61)
>
> 0UL << 61
> 1UL << 61
> ...
>
> > +#define _SVPBMT_MASK         (_SVPBMT_PMA | _SVPBMT_NC | _SVPBMT_IO)
> > +
> > +extern struct __riscv_svpbmt_struct {
> > +     unsigned long mask;
> > +     unsigned long mt_pma;
> > +     unsigned long mt_nc;
> > +     unsigned long mt_io;
> > +} __riscv_svpbmt;
> > +
> > +#define _PAGE_MT_MASK                __riscv_svpbmt.mask
> > +#define _PAGE_MT_PMA         __riscv_svpbmt.mt_pma
> > +#define _PAGE_MT_NC          __riscv_svpbmt.mt_nc
> > +#define _PAGE_MT_IO          __riscv_svpbmt.mt_io
>
> Using a struct over individual variables seems a little odd here.
>

How about :

extern unsigned long  _svpbmt_mask
extern unsigned long _svpbmt_mt_pma
extern unsigned long _svpbmt_mt_nc
extern unsigned long _svpbmt_mt_io

#define _PAGE_MT_MASK              _svpbmt_mask
#define _PAGE_MT_PMA        _svpbmt_mt_pma
#define _PAGE_MT_NC          _svpbmt_mt_nc
#define _PAGE_MT_IO           _svpbmt_mt_io

> Also why not use the standard names for these _PAGE bits used by
> most other architectures?
>
> > -     return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> > +     return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>
> Overly long line, could use a helper.  Btw, what is the point in having
> this _PAGE_PFN_SHIFT macro to start with?
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>

