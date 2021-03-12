Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63D339259
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhCLPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:52:37 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:44711 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCLPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:52:13 -0500
Received: by mail-ua1-f43.google.com with SMTP id q18so1460585uas.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ufGY0BpS1FFe+dVBdNB94a4xu++ZlC5MzGN3kgXpLE=;
        b=UY0+OOFuVkRynifu5L9Oq9abKTcqNpgmRyes4M1izKNyN41yUD5Wdz3glQEzcylTT4
         FbBVOFbb9J8dM5jJl0QOq57Fr1xqgk8uUE737aYK8XfyO7S7ifk3CyE/EEtUtsylWRTe
         5rJLXcITDhXEzlTYRWfqeM+W+CTsGdLwBW16Fg+8HxPhrdBCsvs+wIyF3U9vUI2F1NvC
         aET/v17RkrZkaVJs6fzwou4Lz/0NNKYyaoVi9GPpu+ClWb3Yl/SySloBBM2jRareUd/A
         AkOjQrLbo1o89qp2EDptSOJDYqAMa1nQFMgoufueBueCv6AkhTBcAydBNG56eJhEllgf
         oc+w==
X-Gm-Message-State: AOAM531tlwRk4SVydjs90F3At2fDd19nSkuPZanEB70eEr07wz72qNBC
        E6vfYcTOaBcKHAyRkiOPe370tnPNckudWDzVUXI=
X-Google-Smtp-Source: ABdhPJxCumYpIHmJF/Vw3mPrBZtFKjQV9FO4fc15rHi2hf+aiIEVAVv0yR+b7rK0YHXckIBF+0u3E8dWXbrbbjQxLo8=
X-Received: by 2002:ab0:30b3:: with SMTP id b19mr8849816uam.58.1615564332725;
 Fri, 12 Mar 2021 07:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-4-atish.patra@wdc.com> <mhng-1400a3dd-651b-4a78-bb2d-1f10580add75@palmerdabbelt-glaptop>
 <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
In-Reply-To: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Mar 2021 16:52:01 +0100
Message-ID: <CAMuHMdVOzdy9zA8uk0j4OxFWHQqu_jb7uMXRXqmioY+H-TdtkA@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 7:34 PM Atish Patra <atishp@atishpatra.org> wrote:
> On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> > > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> > > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> > > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/riscv/include/asm/cache.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > > index 9b58b104559e..c9c669ea2fe6 100644
> > > --- a/arch/riscv/include/asm/cache.h
> > > +++ b/arch/riscv/include/asm/cache.h
> > > @@ -7,7 +7,11 @@
> > >  #ifndef _ASM_RISCV_CACHE_H
> > >  #define _ASM_RISCV_CACHE_H
> > >
> > > +#ifdef CONFIG_64BIT
> > >  #define L1_CACHE_SHIFT               6
> > > +#else
> > > +#define L1_CACHE_SHIFT               5
> > > +#endif
> > >
> > >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
> >
> > Should we not instead just
> >
> > #define SMP_CACHE_BYTES L1_CACHE_BYTES
> >
> > like a handful of architectures do?
> >
>
> The generic code already defines it that way in include/linux/cache.h
>
> > The cache size is sort of fake here, as we don't have any non-coherent
> > mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> > cache lines in RISC-V implementations as software may assume that for
> > performance reasons.  Not really a strong reason, but I'd prefer to just make
> > these match.
> >
>
> If it is documented somewhere in the kernel, we should update that. I
> think SMP_CACHE_BYTES being 64
> actually degrades the performance as there will be a fragmented memory
> blocks with 32 bit bytes gap wherever
> SMP_CACHE_BYTES is used as an alignment requirement.
>
> In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> without this patch.
> I didn't see anything in Qemu though.

FTR, I no longer need this patch on vexriscv.
It seems it just masked an issue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
