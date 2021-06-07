Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8D39D593
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGHJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FAA561242
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623049657;
        bh=LCovMA/WpeQPLJl1EPHBeVn/zjZbOdOtdU0vdT8DZj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AtT06Y8yIh0AbQlnWPYo7E1SKNDG5mobSDsxs7sJsCjpw7lP0QzfLfJwquZcPcSnn
         kM7mQz4XCFgt2c+CUxGm1TpkXn65UrGK14g54Le21/MGMK4kKHddEsWzjltQv8xzR1
         di7fRXwVT1+PBlSMp4PEZPMDXvKbZlCAXSeJceJHVIzWRGVGoHOQfs46yO1DaSArSL
         VWQRoD3Kgwp9BaqyCUmNaLWj5RKpBqGfbRNsseapJjUtgjaxKEkbIExBf4JtjDruj9
         UYq/KwEPgoIqq4VpbnSRQ8ZPa1j93w5Iv6A8oH8va9T5gqSq9LooQ7vrLvvGIBv4wg
         7Bya1a+zXESNA==
Received: by mail-oo1-f50.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso1121828ooa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:07:37 -0700 (PDT)
X-Gm-Message-State: AOAM531gx107/wGjfaSVuqhein+Lm3f71IBOYQ9RbRVti0MowkjkqQQ8
        rJZA/Q6XFIflj2csXCEHktYsFxNXL/rEkOGb6iM=
X-Google-Smtp-Source: ABdhPJy2kCYQwYjG0i1qYY2Ghb3U7Iy0TlG9MoCIcwelicr5YR1d2V/ah5ArlyZhVDqIf6fNCY6OKIyDR07ilfIwt5w=
X-Received: by 2002:a4a:8706:: with SMTP id z6mr12433560ooh.41.1623049656460;
 Mon, 07 Jun 2021 00:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXE3faN7nSSdoSU=ed+OPruefD_vJuhyRnsMuNiRygZZbg@mail.gmail.com>
 <20210607065948.31632-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210607065948.31632-1-mark-pk.tsai@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Jun 2021 09:07:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPuWLkORrT4YUfoKZ6+SsLRjxdNM91iff4SJj2jgWa8A@mail.gmail.com>
Message-ID: <CAMj1kXFPuWLkORrT4YUfoKZ6+SsLRjxdNM91iff4SJj2jgWa8A@mail.gmail.com>
Subject: Re: [PATCH] recordmcount: avoid using ABS symbol as reference
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matt Helsley <mhelsley@vmware.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 at 08:59, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> > > On Mon, 7 Jun 2021 at 04:42, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> > >
> > > Avoid using ABS symbol, which won't be relocate, as reference.
> > >
> > > On arm64 platform, if there's shndx equals SHN_ABS(0xfff1).
> > >
> > > Section Headers:
> > > [Nr]    Name                         Type      Address          Off      Size   ES  Flg Lk     Inf    Al
> > > [65521] .text.n_tty_receive_buf      PROGBITS  0000000000000000 3cdab520 000054 00  AX  0      0      4
> > > [65522] .rela.text.n_tty_receive_buf RELA      0000000000000000 3cdab578 000030 18  I   152076 65521  8
> > >
> >
> > A RELA section's r_info field points to the section to which it
> > applies. This is why in the example above section #65522 points to
> > section #65521. This has nothing to do with the numerical value of
> > SHN_ABS.
>
> If the r_info of RELA section is 65521(0xfff1),
> find_secsym_ndx() will use it to find the base symbol.
>

But what does that have to do with the sh_info field of the RELA
section's Elf_Shdr struct? IOW, what is the relevance of section
#65521 here?

> And in the symbol search loop in find_secsym_ndx(), get_symindex will
> return 0xfff1 if the symbol is in ABS section.
>
> In this case, find_secsym_ndx() will return a absolute symbol as
> base, which won't be relocate, if an ABS symbol is found before the
> real symbol in section 65521.
>

I see your point here.

> >
> > > find_secsym_ndx, which use r_info in rela section to find the reference
> > > symbol, may take ABS symbol as base.
> > >
> > > Symbol table '.symtab' contains 453285 entries:
> > >    Num:    Value          Size Type    Bind   Vis       Ndx Name
> > >      6: 0000000000000002     0 NOTYPE  LOCAL  DEFAULT   ABS section_count
> > >
> > > Which cause an invalid address in __mcount_loc.
> > >
> >
> > Could you give a better account of the error you are trying to address?
> >
> > Also, arm64 no longer defines a section_count symbol (since v5.11), so
> > please make sure that the diagnostics of the issue you are addressing
> > are accurate for mainline.
> >
>
> My kernel version is 5.4.61.
> But as I explained, I suppose mainline also have this issue.
>

Mainline is what we work on. So please base your changes (and your
commit log) on mainline.


> >
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >  scripts/recordmcount.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > > index f9b19524da11..9b69167fb7ff 100644
> > > --- a/scripts/recordmcount.h
> > > +++ b/scripts/recordmcount.h
> > > @@ -526,6 +526,10 @@ static int find_secsym_ndx(unsigned const txtndx,
> > >         for (symp = sym0, t = nsym; t; --t, ++symp) {
> > >                 unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
> > >
> > > +               /* avoid absolute symbols */
> > > +               if (symp->st_shndx == SHN_ABS)
> > > +                       continue;
> > > +
> > >                 if (txtndx == get_symindex(symp, symtab, symtab_shndx)
> > >                         /* avoid STB_WEAK */
> > >                     && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
