Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FE3DDF09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhHBSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:23:04 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:22:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j77so27946298ybj.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpAP0boYKgMSl+EEAfMqGAcS1DBVrnYXR6p3McRuuF8=;
        b=KlMxq4MfUxuE4wxvHzy/b64JIYB/khWpUguGIPzgKEmNeHHmr5FP9tLSQwLDHvPx0w
         +x0/5c2lijkljpgCsjjcQDt4QDKuZuv5UY3N4tLODMVHOqjtqHyJqJqMoKjhwD+8gYsw
         f5f6DaG0rlmzwPVYqNg3BSwoYkx90Nnb5bHKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpAP0boYKgMSl+EEAfMqGAcS1DBVrnYXR6p3McRuuF8=;
        b=p0gMARPZSxQ1+8TS2JGuXHZuEfRdtaB5KIufCM7Wf+nYXH5+VzsslNtuzWPK1P7H9M
         yU+NPK2BxylKD8L/gLZqYHX67w24f637Lwuzve+ZCLPkwiZWJAB+RF3Akmquk8H2q54L
         URbOkfXBK2ttIodL0GTqEd/NTtkJWY+1ZyXbpPJAoezzqcVuCBtjjzJU3m1sO+kttVMQ
         QjTVwEGrGDzq03uMuvLn+Xecy3KD3C+fs6qoHjPsNUA14CEE1Jm574SLHGer5qTq1qMU
         dkpDONBAbA100eUVeMjH49VBmZyU8L9cxuIbI1EQwurqiXZFsuWgCFlYpSi0Xl7LLxuK
         u57A==
X-Gm-Message-State: AOAM530XFYk2t0kNMGzzfy1bCeR/Pns/aG8Kh8zMoTmPe2DTRUMQN5Xf
        dULnp9eIAh5abVP2T1ZqSBE3z1TwL4+OD+56seuN
X-Google-Smtp-Source: ABdhPJynNZIyUvDVGGyRh+IbdUlssdg8o1eWgR0yeR8vNlVh2L5U96YBAQGX7dRj9k0KPeGehWEsCQ07LvSHzf9+hAY=
X-Received: by 2002:a25:84c7:: with SMTP id x7mr21646394ybm.447.1627928573559;
 Mon, 02 Aug 2021 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-4-atish.patra@wdc.com>
 <20210726070030.GB9035@lst.de> <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
 <20210727085244.GA20609@lst.de>
In-Reply-To: <20210727085244.GA20609@lst.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 2 Aug 2021 11:22:42 -0700
Message-ID: <CAOnJCUJgCHOR5nifNVjkQawKniGf81Zvsh226brdAPuLNkXAdQ@mail.gmail.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
To:     Christoph Hellwig <hch@lst.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 1:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 26, 2021 at 03:47:54PM -0700, Atish Patra wrote:
> > arch_dma_set_uncached works as well in this case. However, mips,
> > niops2 & xtensa uses a
> > fixed (via config) value for the offset. Similar approach can't be
> > used here because the platform specific
> > offset value has to be determined at runtime so that a single kernel
> > image can boot on all platforms.
>
> Nothing in the interface requires a fixed offset.  And using the offset
> has one enormous advantage in that there is no need to declare a
> statically sized pool - allocations are fully dynamic.  And any kind of
> fixed pool tends to cause huge problems.
>
> > 1. a new DT property so that arch specific code is aware of the
> > non-cacheable window offset.
>
> Yes.
>
> > individual device if a per-device non-cacheable
> >    window support is required in future. As of now, the beagleV memory
>
> If you require a per-device noncachable area you can use the per-device
> coherent pools.  But why would you want that?
>
> > region lies in 0x10_0000_00000 - x17_FFFF_FFFF
> >    which is mapped to start of DRAM 0x80000000. All of the
> > non-coherent devices can do 32bit DMA only.
>
> Adjust ZONE_DMA32 so that it takes the uncached offset into account.
>
> > > > -     mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> > > > +     if (phys_addr == device_addr)
> > > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> > > > +     else
> > > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
> > >
> > > Nak.  The phys_addr != device_addr support is goign away.  This needs
> >
> > ok.
> >
> > > to be filled in using dma-ranges property hanging of the struct device.
> >
> > struct device is only accessible in rmem_dma_device_init. I couldn't
> > find a proper way to access it during
> > dma_reserved_default_memory setup under global pool.
> >
> > Does that mean we should use a per-device memory pool instead of a
> > global non-coherent pool ?
>
> Indeed, that would be a problem in this case.  But if we can just
> use the uncached offset directly I think everything will be much
> simpler.

Yes. I was planning to change this to use an uncached offset.
However, the planned mass production for beaglev starlight sbc is
cancelled now [1].
As there is no other board that requires an uncached offset, I don't
think there is no usecase
for adding uncached offset support for RISC-V right now. I will
revisit(hopefully we don't have to)
this in case any platform implements uncached window support in future.

[1] https://www.cnx-software.com/2021/07/31/beaglev-starlight-sbc-wont-be-mass-manufactured-redesigned-beaglev-risc-v-sbc-expected-in-q1-2022/
-- 
Regards,
Atish
