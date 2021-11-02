Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D683442573
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhKBCKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhKBCKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F104D60F36
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 02:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635818891;
        bh=o4Y1/O2KjncLfMawRxMHVVrBmttatJPx2bTgoqvhEa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BVcXlIsxpWmtMby5PshVIQ9MhUMSB+iXvnq+jLMiEXOEDKvCyQAnbs+evASu5L1Ja
         qa+Jpyh3lZpzjSTdH0FKLrncEZpmB8vMHPu3jvBPjIMr+SDOzEq0n7VifVLtg3XFT1
         sxMR7QvK3RYL3oBdxeNhvww/7vtn9jeB/j915Jbh8O5TMqhtlLuSqzc8KLzKyY23t6
         2Ek1buUNVEpIfack5JavW1txasMZySdbo5ig+zK3+Obw0Z/Xs2wW7/J0W5wdPVXVtr
         UrMGQKh2ClIcA1BkZpwq4biyWrhLj62VwMnXLd8J1VusWfPzf/IkjG9pSUiW5kFDsc
         wCSMUOmm75vZw==
Received: by mail-ua1-f41.google.com with SMTP id b3so11537066uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 19:08:10 -0700 (PDT)
X-Gm-Message-State: AOAM530zJNnF3Hy/4vTp//6oprV5D7OPcCy3jlmTcKmpeV/293s/vLMy
        BNTt9wKn4PZOsMpUbeUk8FiSsRfJDCo3yF9uCRA=
X-Google-Smtp-Source: ABdhPJw+B6DnDEcgSX/gvPPBK4ZiKWQ5vR/FFezghPiwBbO0YAxFFIFTuIIkY4l0r+6LXZGZUhicdBDxGcxduaxlT6s=
X-Received: by 2002:a05:6102:510d:: with SMTP id bm13mr14823367vsb.28.1635818889988;
 Mon, 01 Nov 2021 19:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
In-Reply-To: <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Nov 2021 10:07:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com>
Message-ID: <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Wei Fu <wefu@redhat.com>, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 8:12 AM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Sun, 24 Oct 2021 21:06:05 PDT (-0700), wefu@redhat.com wrote:
> > From: Fu Wei <wefu@redhat.com>
> >
> > This patch follows the  RISC-V standard Svpbmt extension in
> > privilege spec to solve the non-coherent SOC DMA synchronization
> > issues.
> >
> > The svpbmt PTE format:
> > | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> >   N     MT     RSW    D   A   G   U   X   W   R   V
> >         ^
> >
> > Of the Reserved bits [63:54] in a leaf PTE, the bits [62:61] are used a=
s
> > the MT (aka MemType) field. This field specifies one of three memory ty=
pes
> > as shown in the following table=EF=BC=9A
> > MemType     RISC-V Description
> > ----------  ------------------------------------------------
> > 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> > 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> > 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> > 11 - Rsvd   Reserved for future standard use
>
> Do you have a pointer to the spec that contains these?  I'm specifically
> worried about these page-based attributes being elided when paging is
> off (ie, M-mode), which has caused issues in systems I've worked with in
> the past.
Don't worry about that, I've compiled the Linux with the patch and
below modification in k210_nommu_defconfig. Passed

diff --git a/arch/riscv/include/asm/pgtable-bits.h
b/arch/riscv/include/asm/pgtable-bits.h
index 3b38fe14f169..b4bb41337fdc 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -25,7 +25,7 @@
 #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */

 #ifndef __ASSEMBLY__
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 /*
  * rv64 PTE format:
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 |
3 | 2 | 1 | 0
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d198eabe55d4..58639dfe5917 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -856,7 +856,7 @@ int __meminit vmemmap_populate(unsigned long
start, unsigned long end, int node,
 }
 #endif

-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 struct __riscv_svpbmt_struct __riscv_svpbmt __ro_after_init;
 EXPORT_SYMBOL(__riscv_svpbmt);

So, I don't think the patch would affect M-mode nommu Linux.

To separate MMU & no-MMU clearly, I suggest fuwei add
#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)

> I'm assuming there's something related to this in the specs,
> but I'm worried we'll need some sort of ack from M-mode that it's been
> setup to work that way.  One could imagine an MPRV-like approach
> working, but I don't see enough in the old specs and I'm having trouble
> figuring out where the canonical version of this lives.
>
> > The standard protection_map[] needn't be modified because the "PMA"
> > type keeps the highest bits zero.
> > And the whole modification is limited in the arch/riscv/* and using
> > a global variable(__riscv_svpbmt) as _PAGE_DMA_MASK/IO/NC for
> > pgprot_noncached (&writecombine) in pgtable.h.
> > We also add _PAGE_CHG_MASK to filter PFN than before.
> >
> > Enable it in devicetree - (Add "mmu-supports-svpbmt" in cpu node)
> >  - mmu-supports-svpbmt
>
> Maybe this is enough of an ack, but we'll need to have some pretty
> specific documentation if that's the case.  It's not described that way
> in the docs right now, they just talk about CPU support (IMO we could
> probe that with a trap, but I'm fine with the DT entry as it's a bit
> simpler).
>
> > Wei Fu (2):
> >   dt-bindings: riscv: add mmu-supports-svpbmt for Svpbmt
> >   riscv: add RISC-V Svpbmt extension supports
> >
> >  .../devicetree/bindings/riscv/cpus.yaml       |  5 +++
> >  arch/riscv/include/asm/fixmap.h               |  2 +-
> >  arch/riscv/include/asm/pgtable-64.h           |  8 ++--
> >  arch/riscv/include/asm/pgtable-bits.h         | 41 ++++++++++++++++++-
> >  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++----
> >  arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++
> >  arch/riscv/mm/init.c                          |  5 +++
> >  7 files changed, 117 insertions(+), 15 deletions(-)



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
