Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50844E419
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhKLJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhKLJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:48:15 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F27C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:45:24 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id p19so7851318qtw.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTQbLu7DJzgYczzeDokbBx6jczd3POR7HqpLSqJtY74=;
        b=p9Aqslkb2a+UcbKwRGO9FEp4C3WiqewziLqsYJypQBlOjGAxccgxaSumry40GN7WuN
         Z/c7hx6i6HUUKaX8ioEKldnVVdVcQ3Au84D6WPiJCcJeci9bqKQiUgKLr6wl7Sz7XpJR
         tTcarZf9bsfVFeAmb6Jprh9mpL/mg6tz59hRsVIxmMuaduOera0rdggPQI67eS9Ouk02
         oVJHuwSEd0H0P+rZVjRVWt315YH5dA2FHX1i7xlyErtIOzgq2bCC8IhJmuzx/wskXD6u
         28vvhIGdV/esnZPBuHW6d/2d9A01Pm7InNnOhyjYqIaRsqQ95E3empNoWjeSJy1nKGfq
         4A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTQbLu7DJzgYczzeDokbBx6jczd3POR7HqpLSqJtY74=;
        b=JY+At/E2X7auHSctAV0B/pquVeqD/Lq81FfxwAfEXHvQnajF5iqV7qWbKvxih/Oj5h
         qFBCJ+xhnHFoupzOvfQjbeqzk9QE+U8RItyT7HGNPtmwrz3dvS4KMsJgjPMLc8/Ph1V2
         3rG3aIWHdZWsycYS0+NfHlSTb/qQk1TgW/CIR2XtnLcBL2ZS45/yDYvXYQWaLbnenm8A
         Rvlf7vhllePLk2pSQyOhcFEJuOaA17xVOzU89mFGYLG3w/uCSrkUe3UjnClpP2dpNJ+c
         IfXjff+OYRY6dmQLghDDZhfI4fhkVxRbT2KxSFsKsUXqDkLRjCCuQHY9PerhztBJgW6L
         pdhw==
X-Gm-Message-State: AOAM530+khiBdzRnWAmhqDn2Y+w239JC8A6nhD9I8aBdlgm3ft3548VF
        FkMPUE5G3C3KDqNox3bCttg6lsYQi1xY0sOsuIg=
X-Google-Smtp-Source: ABdhPJxDGLbzpvUml615volfmkjIGGCrVkrAChYxV/OvhAnhgiObEE1hRGpZcJqyNBGRh4B9bPLoYW2qQwlIzkInngI=
X-Received: by 2002:ac8:580b:: with SMTP id g11mr14442034qtg.272.1636710323681;
 Fri, 12 Nov 2021 01:45:23 -0800 (PST)
MIME-Version: 1.0
References: <1636708842-25787-1-git-send-email-huangzhaoyang@gmail.com> <CAMj1kXHvo7aXa1X+8dGrmvGimNrX4ONTfG-GWBwZeE1f5r349w@mail.gmail.com>
In-Reply-To: <CAMj1kXHvo7aXa1X+8dGrmvGimNrX4ONTfG-GWBwZeE1f5r349w@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 12 Nov 2021 17:45:02 +0800
Message-ID: <CAGWkznE1oigpcLS5UCbF=rtpt_CV_yJh0xRzh9E4nqf9=GugrA@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: have memblocks out of kernel text use
 section map
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.dai@unisoc.com, lvqiang.huang@unisoc.com,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 5:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 12 Nov 2021 at 10:21, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > By comparing the swapper_pg_dir with k54
>
> I take it this means Linux v5.4 ?
>
> > and previous versions,we find
> > that the linear mappings within which the addr is out of kernel text section
> > will use the smallest pte. It should arise for the sake of rodata_full, which
> > set all memblock use NO_CONT_MAPPINGS.
> >
>
> OK so your intent seems to be to use block mappings for the linear
> alias of the kernel text and rodata, right?
>
> What does that achieve? It should make no difference in TLB pressure,
> as the linear alias is rarely referenced (we only kept it around for
> hibernate). So I guess we save a handful of pages for page tables.
Thanks for the quick response and sorry for causing confusion with my
poor comments. What I want to do is on the contrary, that is using
block mapping on the addr OUT OF the kernel text, which could be
affected by setting rodata_full(can_set_direct_map) so far.


>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  arch/arm64/mm/mmu.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index cfd9deb..14e1bea 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -252,6 +252,8 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
> >         pmd_clear_fixmap();
> >  }
> >
> > +static bool crash_mem_map __initdata;
> > +
> >  static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> >                                 unsigned long end, phys_addr_t phys,
> >                                 pgprot_t prot,
> > @@ -259,7 +261,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> >  {
> >         unsigned long next;
> >         pud_t pud = READ_ONCE(*pudp);
> > +       unsigned long len = end - addr;
> > +       phys_addr_t kernel_start = __pa_symbol(_stext);
> > +       phys_addr_t kernel_end = __pa_symbol(__init_begin);
> >
> > +       if (debug_pagealloc_enabled() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
> > +               ;
> > +       else if (phys > kernel_end || phys + len < kernel_start) {
> > +               flags &= ~(NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > +       }
>
> Please don't use empty statements like this, and I'm not sure we even
> need this check: I wouldn't expect debug_pagealloc or KFENCE to ever
> require page granular mappings of this region either.
>
> Also, please add a comment to explain what the condition is meant to
> check (i..e, that the PMD entry covers a part of the linear alias of
> the kernel image, and so there is no need to map it down to pages or
> to avoid contiguous mappings)
>
> >         /*
> >          * Check for initial section mappings in the pgd/pud.
> >          */
> > @@ -483,7 +493,6 @@ void __init mark_linear_text_alias_ro(void)
> >                             PAGE_KERNEL_RO);
> >  }
> >
> > -static bool crash_mem_map __initdata;
> >
> >  static int __init enable_crash_mem_map(char *arg)
> >  {
> > --
> > 1.9.1
> >
