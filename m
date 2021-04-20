Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5254366117
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDTUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:46:12 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2012C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:45:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k73so38314888ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNWJnV/ujY0AN1/v5JQQqbaoBjz2BczeakSAfc9G65g=;
        b=JmEmQ1D+ODdrwKrwWj0YOP+LdHOd9roC5YmCZ8iKaY3ySqcDx0cyMmAqAhs/BIRer6
         BIQmhHuLIogDg6jE8hRR5+acsut5b7DmJpk+M5Qin+dohrtDco+FYLHIEkwizYIH/VFy
         7D4d5O+++U+8bGRQyY5k43091qfq5t52c8+9ZTvJDCLpnV8ustet3YMp9JlpLMzGbOnS
         6GnulHbJ/xDnCAqs384JsNg8cWUSggU16lLY4ZRORY1CP3y6YJR0W8IBvdIkXyI4yzdh
         zB2aeQokQEWsIdHTTscKaUGSuRDZKZXeNygQU37BPp3OYOjI9bxeSioqZBOa6FN9hyKi
         8/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNWJnV/ujY0AN1/v5JQQqbaoBjz2BczeakSAfc9G65g=;
        b=NenZ9sJ3dEZ0k/5mc0iUGAX1IRAyUUhqU8vt4xvxRwvv+bvNPP4iP141XtEB+/pnbS
         epKrIY+RutDJfHJMJngtmpWx+N778onJIS7Koo7DkjMfn13IqV+0wmy1n7cq/7hjq2JZ
         oD6V5gSOdsZ+LTPwcKAryQ2ST6geFgsxlNwU5y2UtKhbVneA3eor7WJT3m/NXW7h0Lyp
         QEDFgtvSfHivotKWdCqarB5dZ/f01U/XuXeUAxRFIcnkUVbb8XtV1pqCPK8qfeeryCAz
         tqS+MUAyozPjuexH2k5x5AtXlArYKuKNBO23VnGZQed/L/74y8MnegH6UoFv+QIAOB4N
         Kefw==
X-Gm-Message-State: AOAM533e0WAeO59Ngm7JIt0wwU2oeXfyQiWqQQpjfYE0iYC5kYBAUeg/
        +jMDAfkZ6JZuntIJftctK9S23lHZCpoyhp6S2IorRw==
X-Google-Smtp-Source: ABdhPJxvErDAeKN7gNVUK8lP+l8e8YgAeqaZVPcPX0mn5e8XJ3uublln/uslQceWPqApgq7S+ag3pSG/4f3jJ0cavaA=
X-Received: by 2002:a25:7085:: with SMTP id l127mr27992640ybc.293.1618951539670;
 Tue, 20 Apr 2021 13:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-3-samitolvanen@google.com> <20210420194747.3snxvaaa4amfnbah@treble>
In-Reply-To: <20210420194747.3snxvaaa4amfnbah@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Apr 2021 13:45:28 -0700
Message-ID: <CABCJKufE2_z0SGhsbgu-Wu+L5TRhOktQO4wHgJg04RYcvoxAAA@mail.gmail.com>
Subject: Re: [PATCH 02/15] objtool: Add CONFIG_CFI_CLANG support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:48 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:31PM -0700, Sami Tolvanen wrote:
> > +static int fix_cfi_relocs(const struct elf *elf)
> > +{
> > +     struct section *sec, *tmpsec;
> > +     struct reloc *reloc, *tmpreloc;
> > +
> > +     list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
> > +             list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
>
> These loops don't remove structs from the lists, so are the "safe"
> iterators really needed?
>
> > +                     struct symbol *sym;
> > +                     struct reloc *func_reloc;
> > +
> > +                     /*
> > +                      * CONFIG_CFI_CLANG replaces function relocations to refer
> > +                      * to an intermediate jump table. Undo the conversion so
> > +                      * objtool can make sense of things.
> > +                      */
>
> I think this comment could be clearer if it were placed above the
> function.
>
> > +                     if (!reloc->sym->sec->cfi_jt)
> > +                             continue;
> > +
> > +                     if (reloc->sym->type == STT_SECTION)
> > +                             sym = find_func_by_offset(reloc->sym->sec,
> > +                                                       reloc->addend);
> > +                     else
> > +                             sym = reloc->sym;
> > +
> > +                     if (!sym || !sym->sec)
> > +                             continue;
>
> This should be a fatal error, it probably means something's gone wrong
> with the reading of the jump table.
>
> > +
> > +                     /*
> > +                      * The jump table immediately jumps to the actual function,
> > +                      * so look up the relocation there.
> > +                      */
> > +                     func_reloc = find_reloc_by_dest_range(elf, sym->sec, sym->offset, 5);
>
> The jump instruction's reloc is always at offset 1, so this can maybe be
> optimized to:
>
>                         func_reloc = find_reloc_by_dest(elf, sym->sec, sym->offset+1);
>
> though of course that will probably break (future) arm64 objtool.  Maybe
> an arch-specific offset from the start of the insn would be good.
>
> > +                     if (!func_reloc || !func_reloc->sym)
> > +                             continue;
>
> This should also be an error.
>
> > +
> > +                     reloc->sym = func_reloc->sym;
>
> I think we should also do 'reloc->addend = 0', because of the
> STT_SECTION case:
>
>   0000000000000025  0000259e0000000b R_X86_64_32S           0000000000000000 .text..L.cfi.jumptable.8047 + 8
>
> which then translates to
>
>   0000000000000009  0000063200000004 R_X86_64_PLT32         0000000000000000 x2apic_prepare_cpu - 4
>
> so the original addend of '8' is no longer valid.  Copying the '-4'
> wouldn't be right either, because that only applies to a PLT32 text
> reloc.  A '0' should be appropriate for the 32S data reloc.
>
> This addend might not actually be read by any code, so it may not
> currently be an actual bug, but better safe than sorry.

Thank you for taking a look, Josh!  I'll fix these in the next version.

Sami
