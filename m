Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8C4075EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhIKJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235485AbhIKJij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:38:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE3D61212;
        Sat, 11 Sep 2021 09:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631353047;
        bh=G18OV5FIIRNWI99pCWXNGoDPuX3uPGlDsnKN/RG9rWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/Y4Je1lPw0LK98KHXnCgi6HQWCPtAFmli2I+O860gkeqcXootKimbzSw8OZxH6T1
         O8N+iJWhCkea0vAVw6GHXJnlK5qL+L2H1Epa1qEozl9q4Hv787/cAtk8guWQrfO02F
         v3W8+Hy6zm5rd+5MNHJ7YvZF2F1CmlO0Jeqtb0G/aUyT0Zp0sMeCg86m4jVn4Z/Rvb
         1x9DlXQLAIroW+I3vYIg76GmYuyWRQt3aDXBYt+3sxIZ6pR/kVqJvM5BndgUqRHOz1
         UtPoNpnQA5eLlK7HGagpoCeaJZKeB81g8Qek2iRHK/29NMWRj0KU54XHZLiNMYtLSQ
         rudBsYBHMt5wA==
Received: by mail-lj1-f175.google.com with SMTP id i28so7426713ljm.7;
        Sat, 11 Sep 2021 02:37:27 -0700 (PDT)
X-Gm-Message-State: AOAM53292usjcfc4986jTz4sdolr25eytMB16OgZ2ZFQKdP8DHF8ze9T
        r48WGnvDvn8IOWZYGsyixR1KNegZ0aPY4j3ta2g=
X-Google-Smtp-Source: ABdhPJz1oYKcutN4CfeiCO1gDO6d41MM4ga2i6X7G8mzRYyCg4UTUoPG7GsV4adhKwlbqQLgd9hxTargj+BFZ5i1K80=
X-Received: by 2002:a2e:3307:: with SMTP id d7mr1615329ljc.292.1631353046032;
 Sat, 11 Sep 2021 02:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-2-atish.patra@wdc.com>
 <20210726065657.GA9035@lst.de> <CAOnJCUJFOZsqC2F9sqJqYw5bLJK0fQS+w=Rp6PeM2ih=75Cxag@mail.gmail.com>
In-Reply-To: <CAOnJCUJFOZsqC2F9sqJqYw5bLJK0fQS+w=Rp6PeM2ih=75Cxag@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 11 Sep 2021 17:37:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT+LgLyYHpJ1dv595mF8M3OHshy8EHg3tk63Kov8+GU9g@mail.gmail.com>
Message-ID: <CAJF2gTT+LgLyYHpJ1dv595mF8M3OHshy8EHg3tk63Kov8+GU9g@mail.gmail.com>
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 5:53 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sun, Jul 25, 2021 at 11:57 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > > +struct riscv_dma_cache_sync {
> > > +     void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> > > +     void (*cache_clean)(phys_addr_t paddr, size_t size);
> > > +     void (*cache_flush)(phys_addr_t paddr, size_t size);
> > > +};
> > > +
> > > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> > > +#endif
> >
> > As told a bunch of times before: doing indirect calls here is a
> > performance nightmare.  Use something that actually does perform
> > horribly like alternatives.  Or even delay implementing that until
> > we need it and do a plain direct call for now.
> >
>
> I was initially planning to replace this with alternatives in the
> future versions. But there is no point in doing it
> until we have CMO spec finalized. We also don't have any other
> platform using these apart from sifive l2
> cache controllers for now.
>
> I will change these to direct for now.
I think alternatives' would be helpful, I've rebased on your patchset, thx.
https://lore.kernel.org/linux-riscv/20210911092139.79607-6-guoren@kernel.org/

>
> > static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > > +{
> > > +     if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > > +             dma_cache_sync->cache_invalidate(paddr, size);
> > > +     else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > > +             dma_cache_sync->cache_clean(paddr, size);
> > > +     else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > > +             dma_cache_sync->cache_flush(paddr, size);
> > > +}
> >
> > The seletion of flush types is completely broken.  Take a look at the
> > comment in arch/arc/mm/dma.c above arch_sync_dma_for_device for a good
> > explanation.
> >
>
> Thanks. I will fix it.
>
> > > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > > +{
> > > +     void *flush_addr = page_address(page);
> > > +
> > > +     memset(flush_addr, 0, size);
> >
> > arch_dma_prep_coherent is not supposed to modify the content of
> > the data.
>
> Sorry. This was a leftover from some experimental code. It shouldn't
> have been included.
>
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>
> --
> Regards,
> Atish
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
