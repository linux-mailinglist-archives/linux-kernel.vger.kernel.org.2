Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D31439446
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhJYK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhJYK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635159322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9r/2xnQluktoJQNTVnyYXdf7iQ2Ry5qJeSjDsQ0D0w=;
        b=amNg/iIZeJFsK/PxFAMNilxIh6hj5kxSu0zyYwadW+dQ4J7S4qOBKTcUxfoP0ZYuOhwLq3
        IrgkUS1NMSgOO4Qcnrn61LGh6BF0kKTguL72lSqyuvaqq8fb/wIfOL4dOrnXg2+4TMmsBz
        J9/cg51MuTcLlo/pOwOl41zh3oIUle4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-doLtARHTO_OtM7DavJo9Nw-1; Mon, 25 Oct 2021 06:55:21 -0400
X-MC-Unique: doLtARHTO_OtM7DavJo9Nw-1
Received: by mail-ed1-f71.google.com with SMTP id b17-20020a056402351100b003dd23c083b1so7629840edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9r/2xnQluktoJQNTVnyYXdf7iQ2Ry5qJeSjDsQ0D0w=;
        b=7jgFYRhSuDnJhX1t+YmOmB64KKPaxdryMAFUX3s9HN0j63K1u5+KSrtsa9Iia3HdDt
         EHNWf8Aie0FNcEFRTm9XYy0V1oRgTFeyt8HMj/a5iTXGaGLrHbfri6vJoGqJok25nyFE
         WRAOg4+oPVkINmR58VqYghG6Q7BMgpocwhioaxDwln0Aah5uNU3/VlENm2Xhd0Wieo9i
         VecCRu22BmKjhhQxpMZFcJinKZ/5expuO90AyCw2mqPYT4MRSsi7lacDywkTDvj39A8T
         Ozzqt0lV1k0hmBJ5SFDKkN0Sj7scwwhUBYnaEqK1tsmtPZ9QY7N3fVA9Y7foNN+o4KP/
         ohWA==
X-Gm-Message-State: AOAM532qXJg1kI7N/wARcloaHZNCfjCXImow3LBSE0umsnCvmSPbyXK0
        oVXsLHU2+7ziGyH9yFH/PKaDe3fo7SeEiGTAJuz8PxzjD4+MbiQJjIW0MYs0NmS0o+j5qZ6pbW+
        0PKEKtFD9OmLXD02PmY4swgQ/eRycH9hW7dqtoSjj
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr20707050ejp.374.1635159320509;
        Mon, 25 Oct 2021 03:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHvjGx1o/l6cvWtLlt1bGcsJAK4tj98GXlzcrNu3As9Dt3iN96hZKCL/C9ae8LCUWJQ5rLjfsX6KSXF7IsaAQ=
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr20707017ejp.374.1635159320347;
 Mon, 25 Oct 2021 03:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com>
 <YXZU/3/YmRGFrOXK@infradead.org>
In-Reply-To: <YXZU/3/YmRGFrOXK@infradead.org>
From:   Wei Fu <wefu@redhat.com>
Date:   Mon, 25 Oct 2021 18:55:09 +0800
Message-ID: <CA+YCwKkX64A8p9vfLJHC3+LqOWyDg99eDBR0mjfB=H45BOyJLQ@mail.gmail.com>
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

Great thanks for your review.

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
>
> > +#define _SVPBMT_PMA          ((unsigned long)0x0 << 61)
> > +#define _SVPBMT_NC           ((unsigned long)0x1 << 61)
> > +#define _SVPBMT_IO           ((unsigned long)0x2 << 61)
>
> 0UL << 61
> 1UL << 61

How about this macro:
#define _SVPBMT_PMA         0x0UL
#define _SVPBMT_NC         BIT(61)
#define _SVPBMT_IO         BIT(62)
#define _SVPBMT_MASK         GENMASK(62, 61)

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
> Also why not use the standard names for these _PAGE bits used by
> most other architectures?

Which names are you suggesting? Would you mind providing an example ?
_PAGE_BIT_   for _PAGE_KERNEL_ ??

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

