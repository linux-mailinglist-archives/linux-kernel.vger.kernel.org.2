Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6A44C9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhKJT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhKJT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:57:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:54:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi37so3729505lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=katFFdjF9yTSPvuIotc4HFJ7jS5Mn6dtEx4FmMbQPg4=;
        b=MZggrA4RcGMosy2Ga4WoqLZPKaTXzyjlufmlT6zEByT/wd6dNIGqeBo6m+OmBXpvkW
         75LLdFQAKIW61endN6N1cI/NTleNo3zmNI6/Ek7dm9QlKBdlqqkpqFaT25/nEzdzRI9R
         3j9n2/NeRe6z3HGDU/Bz7jTTVkV9sw03FRnJ1HPXnrlVSRDn4957pXe/P/ShmmxFClfs
         llGhO7Pk5YGvShrE8xNQZLdoBx4nfy/rNYoXHSf/d4raA4PWv0xWz78w8WuNnimtIJ9O
         +ppgIW+LLk7WWRppk1MFW01/0f4dhWeu9eLwtVcBrwv6IU6U01l6kK4yYnFjbA0Gv5WY
         KrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=katFFdjF9yTSPvuIotc4HFJ7jS5Mn6dtEx4FmMbQPg4=;
        b=C+ExV3uDfqtDMTsvtPb4H2EsX3e8NOjFSB4u6fwOF2jooaETkqhaE5Upv7wYMqOKeA
         hxm+TJ8fMneXHAUDz1W4gNGOOb1qdFYfQA6RBJo/6FfZa585Nw9BEkwVi6tDf0kLhiZn
         dcy4s7GWUZLwi52t9xWCJG/9KnQDSi1zcen/3H0rKBD/rDJJoX5mVVbPA/2gjas8fCnP
         SxaBe6ANxyYHJcixuFS7WfdivAnPzYeTQpkJE0GhKevj7dGVPFUNWt7KSrRk7JjJX9Fc
         rJCB7Wii0to1KLzLwo+FoUNlHCX2McdMghyFOw17IrIiPjHxvGsffmVIBaYtea9MKQfO
         FfpQ==
X-Gm-Message-State: AOAM530tAEZ09hjuQ07HVOiGotZA8VckMGBXoNhkcAT21fSEVQWOPHu7
        W+BijE2DTyheq1gaMojI27Z8zs7n9dOlqlHMJGwgeg==
X-Google-Smtp-Source: ABdhPJzFULqa9FMP1hJDixPutwoqlYcQoSFD04OmuzaLunO5v81iEbAfcBW9bBSLNQCvOM2qF9EvJwkAWtQsVLBmPVk=
X-Received: by 2002:a05:6512:150e:: with SMTP id bq14mr1600909lfb.444.1636574070576;
 Wed, 10 Nov 2021 11:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20211107162641.324688-1-masahiroy@kernel.org> <20211107162641.324688-2-masahiroy@kernel.org>
 <CAKwvOdmCaXAMvouD7bsWqmgOUxQ9vpdt3LY7qWpzTVm-2gddEw@mail.gmail.com> <20211109000531.k23mgrfjn5tomevv@google.com>
In-Reply-To: <20211109000531.k23mgrfjn5tomevv@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 11:54:19 -0800
Message-ID: <CAKwvOd=gD+Tn1BCHwtLztUuy6tBPqZxUyneddz3849pDqhP7dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/purgatory: remove -nostdlib compiler flag
To:     Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 4:05 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On 2021-11-08, Nick Desaulniers wrote:
> >On Sun, Nov 7, 2021 at 8:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>
> >> The -nostdlib option requests the compiler to not use the standard
> >> system startup files or libraries when linking. It is effective only
> >> when $(CC) is used as a linker driver.
> >
> >Is that right? ld.lld recognizes --nostdlib and has --help text for it.
>
> GCC/Clang driver -nostdlib != ld.bfd/ld.lld -nostdlib.
>
> ld.lld -nostdlib just ignores SEARCH_DIR in a linker script.
> I think ld.bfd's -nostdlib is more complex than that which also has
> something to do with its internal linker script location.
> Anyway, getting of the obscure ld -nostdlib is a good idea.

Ok, I verified that the size of arch/x86/purgatory/purgatory.ro,
arch/x86/entry/vdso/vdso64.so, and arch/x86/entry/vdso/vdso32.so don't
change with this series. (ldd is not happy with the .so's regardless).

I also suspect that the linker when invoked directly can't assuming
it's linking object files created from C sources (ie. could have been
assembler sources), so there's no reason to assume that the libc, C
runtime, or compiler runtime would need to be linked against.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> >>
> >> $(LD) is directly used for linking purgatory.{ro,chk} here, hence
> >> -nostdlib is unneeded.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> ---
> >>
> >>  arch/x86/purgatory/Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> >> index 95ea17a9d20c..ae53d54d7959 100644
> >> --- a/arch/x86/purgatory/Makefile
> >> +++ b/arch/x86/purgatory/Makefile
> >> @@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> >>
> >>  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> >> -PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
> >> +PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> >>  LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
> >>  LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
> >>  targets += purgatory.ro purgatory.chk
> >> --
> >> 2.30.2
> >
> >--
> >Thanks,
> >~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20211109000531.k23mgrfjn5tomevv%40google.com.



-- 
Thanks,
~Nick Desaulniers
