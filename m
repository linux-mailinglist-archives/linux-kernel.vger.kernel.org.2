Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC73BA445
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhGBTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhGBTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:14:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D0C061765
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:11:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m9so17953007ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNe0CZD49Y6HeTR2zvAdV2swVmjxw8HGAOl4RmeBDHE=;
        b=OOVuX5kUkOlD/17Ow3pMt/Tn89olUzx+mZzFNrRE4ecm1Jj02CZuYiUFeZr0lWOjWz
         xvpR/25J+giT5ahz7BrHpktRPhIefWfoJLpypEkWWgiZudgt5ffrOhODpUYXBmNgX1uK
         nME76vrEPtrO4pBugfe6fpIZRc9NP2F0trgYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNe0CZD49Y6HeTR2zvAdV2swVmjxw8HGAOl4RmeBDHE=;
        b=HvetY2NrgTBoDthIsWg3QexWmAy8IMZ4k1FcST2oG5KUlLycWyMJ9wlSv189NZo35D
         6/GPbKjiyGTMBIbOwsl+HGg9bWNpbMfvu9p12RTdIJtljMwV/loGGmzZ0oiu0PT8ouXY
         eUL3ZrQ4kNbVq4ec6t4PDCSvoh4uiTxg+4NpH3EKi4JUtHl8PFxL20srO2kADd48CWor
         ubuWwN+sAF7BOxWo9o+GmjC6hupPqm2T9l9WbTa5dtPj53hZsYAc+H6s/czLfK/I4qVd
         Hky6jeN9rJ5AD38bbg0WSqnDIvrdvRYOQF9JOGZymKgo5bhYCQ7NwbE3nFMZLMvgitbR
         3v9w==
X-Gm-Message-State: AOAM533CaQtgxNT+VXx9E39310C8ZFJr73v10XHe38S/Qn829NfeTfuK
        HILtJYKb1D6WaozIU08hT/E/FpEivnQHlq1Xb7ek
X-Google-Smtp-Source: ABdhPJzqkbkxM1MEMKQQBXENZX/GSVyjLhXai8633EMbMtXXh8Efubsw76BaSmLC7bBeenfpRwhH1lqLwnbb+jznUVk=
X-Received: by 2002:a25:b3c3:: with SMTP id x3mr1106992ybf.147.1625253088549;
 Fri, 02 Jul 2021 12:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134018.62859-1-xypron.glpk@gmx.de> <CAOnJCUKuHGUZi-13PpnZGHKkXxhj3asVJgaNMTv3=830eVwi=g@mail.gmail.com>
 <CAMj1kXG-O5PLnEWGWXzYf2r471ng7j-jZ2ziTwLdSgdVFdJNaA@mail.gmail.com>
In-Reply-To: <CAMj1kXG-O5PLnEWGWXzYf2r471ng7j-jZ2ziTwLdSgdVFdJNaA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 2 Jul 2021 12:11:17 -0700
Message-ID: <CAOnJCUK3fiNBfRaWpFBzqe3oy3Sb7-_fVC5CP0ynz_4Qscv8VA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 12:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 30 Jun 2021 at 00:56, Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Tue, Jun 29, 2021 at 6:40 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> > > to boot SUSE Linux with GRUB on QEMU, cf.
> > > https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
> > >
> > > Remove the constraint.
> > >
> > > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > ---
> > >  arch/riscv/include/asm/efi.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> > > index 7542282f1141..649ab513dc99 100644
> > > --- a/arch/riscv/include/asm/efi.h
> > > +++ b/arch/riscv/include/asm/efi.h
> > > @@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
> > >
> > >  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
> > >
> > > -/* Load initrd at enough distance from DRAM start */
> > > +/* Load initrd anywhere in system RAM */

Alex/Anup/Palmer:

As per my understanding initrd can be loaded in system RAM as long as
it doesn't overwrite the existing data (fdt/kernel image)
and respect reserved memory regions.

Let us know if we have any inherent memory location limitation for
initrd loading.


> > >  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
> > >  {
> > > -       return image_addr + SZ_256M;
> > > +       return ULONG_MAX;
> > >  }
> > >
> > >  #define alloc_screen_info(x...)                (&screen_info)
> > > --
> > > 2.30.2
> > >
> >
> > LGTM
> >
> > Reviewed-by: Atish Patra <atish.patra@wdc.com>
> >
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Please take this via the RISC-V tree.



--
Regards,
Atish
