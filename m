Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9140442E1F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhJNTXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhJNTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:23:00 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73867C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:20:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s64so17090369yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghIdK0FoHMlyldN0eJzj8LVeRYAc3FvVHoGe9rMJ4DU=;
        b=Rdbokmn+vqYcp9RP1CdzAdGBb0+6iL3BSsHZPlPYuGsJjZOpAdYiqOON6DAEczpYsE
         LenCbwzFyuSGvvtrFRk4JEHsdmWPV44CLu7FWG+E+xsOQ+OD35/fF8/cVSqs2KTQNKGA
         y/qUMH997gw3ziV3d20AdeugL7H8yY4Lysdo4WMMCiObxN+TH8YUJJYTILo7xbIN3mUz
         Hltlu9/grCyju0Q+MOYpjzxPwMq9/zAeDqcDdxuSDwQEwXny6khtrJZ4m0Z2R2UrUqic
         OXnwY3oM3Nm4gfoakoMIqVdFz5InaF8YWHCSHD9SgNv1ztzN9MqyjJbT9/8XFvVX3J5C
         hHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghIdK0FoHMlyldN0eJzj8LVeRYAc3FvVHoGe9rMJ4DU=;
        b=0V4GiMrRkvU5rQCkYgjwNx7SkpgPerS+kgu0Ky7kxP4ygOmUuJ2cm2m0U5+9EaIPR+
         ENCeCmMH2vr902HwJlqBI1CRsmuPlFnjx+0/4ekgzSFF3NDkrVCMMYiad5nB+bNq1K7/
         eQGYaoaDou9GCvBWi5dFXcg3MwcWShDFT1SbBP6ZC2lTziSqCfekzwGQMcxXcnjogNd2
         x928jDpP1m/6E/iT95Chq1pfSsaR5m+T3gyFI29t1v17Vtb/StMGnZuGO3mhJkIniHja
         pz/ZHHhLxQ4t7Ct5mMAIW4Tya86sYyvVOfH2upZ0bGILZh5BooALMmLnnNdtBaoGj/hF
         kRWw==
X-Gm-Message-State: AOAM530pd+VOC1JRsHD/HKL9DkNG5IqbVKwzulHtJYiREWFD2fznDqdV
        DtXxtCfjO40IucCVXEjj6l/PKcSJUKSWfhqtlG77XA==
X-Google-Smtp-Source: ABdhPJyryvz9R2IZXRTVQhGXXspp67GbOs3I+aFZqoKFLwt3dpeEIXsSEe9qSwJn/Dagp97NYpK+qENgSS9hP+//AOc=
X-Received: by 2002:a25:6908:: with SMTP id e8mr8035718ybc.289.1634239254220;
 Thu, 14 Oct 2021 12:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-2-samitolvanen@google.com> <YWgE4iTPGr/ruu8e@hirez.programming.kicks-ass.net>
In-Reply-To: <YWgE4iTPGr/ruu8e@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Oct 2021 12:20:43 -0700
Message-ID: <CABCJKufkH+2A-CySxHAvfZYzpvoytmRZe2_J2=Wv-kh80d=oyA@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 13, 2021 at 11:16:44AM -0700, Sami Tolvanen wrote:
> > diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> > index 1f2ae708b223..5fe31523e51f 100644
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -63,6 +63,23 @@ bool arch_callee_saved_reg(unsigned char reg)
> >       }
> >  }
> >
> > +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
> > +{
> > +     if (!reloc->addend)
> > +             return 0;
> > +
> > +     if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> > +             return reloc->addend + 4;
> > +
> > +     return reloc->addend;
> > +}
> > +
> > +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
> > +{
> > +     /* offset to the relocation in a jmp instruction */
> > +     return offset + 1;
> > +}
> > +
> >  unsigned long arch_dest_reloc_offset(int addend)
> >  {
> >       return addend + 4;
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index b18f0055b50b..cd09c93c34fb 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
>
> > @@ -575,6 +580,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
> >       return 0;
> >  }
> >
> > +/*
> > + * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
> > + * jump table. Undo the conversion so objtool can make sense of things.
> > + */
> > +static int fix_cfi_relocs(const struct elf *elf)
> > +{
> > +     struct section *sec;
> > +     struct reloc *reloc;
> > +
> > +     list_for_each_entry(sec, &elf->sections, list) {
> > +             list_for_each_entry(reloc, &sec->reloc_list, list) {
> > +                     struct reloc *cfi_reloc;
> > +                     unsigned long offset;
> > +
> > +                     if (!reloc->sym->sec->cfi_jt)
> > +                             continue;
> > +
> > +                     if (reloc->sym->type == STT_SECTION)
> > +                             offset = arch_cfi_section_reloc_offset(reloc);
> > +                     else
> > +                             offset = reloc->sym->offset;
> > +
> > +                     /*
> > +                      * The jump table immediately jumps to the actual function,
> > +                      * so look up the relocation there.
> > +                      */
> > +                     offset = arch_cfi_jump_reloc_offset(offset);
> > +                     cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
> > +
> > +                     if (!cfi_reloc || !cfi_reloc->sym) {
> > +                             WARN("can't find a CFI jump table relocation at %s+0x%lx",
> > +                                     reloc->sym->sec->name, offset);
> > +                             return -1;
> > +                     }
> > +
> > +                     reloc->sym = cfi_reloc->sym;
> > +                     reloc->addend = 0;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> If that section ever gets modified and we end up running
> elf_rebuild_reloc_section() on it, we're in trouble, right?
>
> Do we want a fatal error in elf_rebuild_reloc_section() when ->cfi_jt is
> set?

That's a valid point. Since ->cfi_jt is only set for jump table
sections, I think we'll need a different flag for this though.

Sami
