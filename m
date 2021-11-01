Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E997A442257
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhKAVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKAVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:09:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AFC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:07:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so68366384edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SAIU+IuE23Lw7sXqYvikkteMzMCec9k3mkNvwAaD1c=;
        b=JTLt05AlEHI961xxW/tusGjITZ2yRmJvdTokKIPc2QLIuzEbC74+SjvP+80LlX1JY7
         DZqGeDI1LYtuhuyZNhBmkcCjmnQKanNCh4eFfrVd9FWCAh0dNMO/0qTd+3QxoIJWQx2P
         lbiGtp7Xzj6ewwzVrhIfYJeMn2RanJ+33SGst8cCfX3xACL2fB8kr0LRWpmbqDZ4Y6DH
         +O3YUP6/9N5DeDqgx/+yIkiTsdQE0X41fXsk0YUt4Fo6f5tzzGfoimm7UY/GVJUSK4al
         JzbhCaUTmbqQtVC1DH5QOe/zUBBBzsv51PBlAWuAGTEijo61cvMl4P3U5632pPJv3zGz
         uh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SAIU+IuE23Lw7sXqYvikkteMzMCec9k3mkNvwAaD1c=;
        b=NEzx774KaOD8tH68izs7hcykNdJSHzYyrHqa+ccE1I8xqsiZaTB0UmRvbrPwCWwPtu
         Q5yS0ewZ2MfKTAxyFXlQEq/MdvrjVvFPj1v/AciqWUXIVpLB4xgCoiNqaPzv9rGZag90
         eNaU8xwFCUdeA8H4VLf1Xq6tZLvrzOWK/RY0iXsr56MqwFqFlaW0QfgZy0PDKHzqqWZK
         IbWYy9mEtej2nqpetnccXhiO3oxwbi+eIW3mzDENC5PGja98stSvrhUn611FABX4HAg+
         MaGaYS7D1BfxYb338ymL716bI4pUfacenzZwgDfP0x8SkQXsZ2XKgVxm0R/JQ2VVFAuD
         KDMw==
X-Gm-Message-State: AOAM532GAbEr4AqF7MLoN00yNcDRDgmclx6dOgDXN5RpzytZe2tNuBXy
        W2caSm/v8xiupp3E7A4n9hY9PDTUP4cE2g9oBJs=
X-Google-Smtp-Source: ABdhPJxN3QSIRkPsc+8zd3aRq/WjgQUAMwDW9tVIqvOw68oAb61UD21Pse+Izcm3WITNC1J3KVzBSDZIPJTtvL7C26w=
X-Received: by 2002:a17:906:d20c:: with SMTP id w12mr18780674ejz.521.1635800821471;
 Mon, 01 Nov 2021 14:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211101194336.305546-1-shy828301@gmail.com> <YYBRePv3w9cfCpHC@casper.infradead.org>
In-Reply-To: <YYBRePv3w9cfCpHC@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Nov 2021 14:06:49 -0700
Message-ID: <CAHbLzkr7+-urztS70fnCvGwkvBEPHvv3+OSzQk8ZzpPX1MAivw@mail.gmail.com>
Subject: Re: [PATCH] mm: page-flags: fix build failure due to missing
 parameter for HasHWPoisoned flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 1:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Should probbaly cc Linus, and also note that Stephen noticed & fixed
> this problem already.
> https://lore.kernel.org/lkml/20211101174846.2b1097d7@canb.auug.org.au/

Oh, yes, I forgot that fix. Anyway picking either one is fine to me.

>
> I didn't know about it at the time I sent the pull request because it
> hadn't been merged at that point.

It is fine. I really don't mean blame to you.

>
> On Mon, Nov 01, 2021 at 12:43:36PM -0700, Yang Shi wrote:
> > The below build failure when !CONFIG_MEMORY_FAILURE was reported for
> > v5.16 merge window:
> > In file included from include/linux/mmzone.h:22,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/slab.h:15,
> >                  from include/linux/crypto.h:20,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > include/linux/page-flags.h:806:29: error: macro "PAGEFLAG_FALSE"
> > requires 2 arguments, but only 1 given
> >   806 | PAGEFLAG_FALSE(HasHWPoisoned)
> >       |                             ^
> > include/linux/page-flags.h:411: note: macro "PAGEFLAG_FALSE" defined here
> >   411 | #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)   \
> >       |
> > include/linux/page-flags.h:807:39: error: macro "TESTSCFLAG_FALSE"
> > requires 2 arguments, but only 1 given
> >   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
> >       |                                       ^
> > include/linux/page-flags.h:414: note: macro "TESTSCFLAG_FALSE" defined here
> >   414 | #define TESTSCFLAG_FALSE(uname, lname)
> >          \
> >       |
> > include/linux/page-flags.h:806:1: error: unknown type name 'PAGEFLAG_FALSE'
> >   806 | PAGEFLAG_FALSE(HasHWPoisoned)
> >       | ^~~~~~~~~~~~~~
> > include/linux/page-flags.h:807:25: error: expected ';' before 'static'
> >   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
> >       |                         ^
> >       |                         ;
> > ......
> >   815 | static inline bool is_page_hwpoison(struct page *page)
> >       | ~~~~~~
> > make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
> >
> > The commit d389a4a81155 ("mm: Add folio flag manipulation functions")
> > changed the definition of PAGEFLAG macros, this caused the build failure
> > for HasHWPoisoned flag.  The new flag was introduced by commit
> > eac96c3efdb5 ("mm: filemap: check if THP has hwpoisoned subpage for PMD
> > page fault") in v5.15-rc7.  But the folio series pull request was
> > prepared before v5.15, so this new flag was missed.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/page-flags.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index d8623d6e1141..981341a3c3c4 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -803,8 +803,8 @@ PAGEFLAG_FALSE(DoubleMap, double_map)
> >  PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
> >       TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
> >  #else
> > -PAGEFLAG_FALSE(HasHWPoisoned)
> > -     TESTSCFLAG_FALSE(HasHWPoisoned)
> > +PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
> > +     TESTSCFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
> >  #endif
> >
> >  /*
> > --
> > 2.26.2
> >
> >
