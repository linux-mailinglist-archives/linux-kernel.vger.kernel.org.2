Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863CD39AC35
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFCVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFCVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:02:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68245C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 14:00:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r198so7501799lff.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHl84Rjlmz5z7CisG4GhOYojkJVrwSv3e0lfWz8f8SI=;
        b=dm5CMlsGo8hziSNnNQiuBPA8WN2sf3sh6NKWGkfGJg8P7dYP2LvUcXJptmh0X044vB
         IZ77A/4GpmNOjLFUSz7lp5e/kEX0S/NYVzYpugopviHMud76tXvU0Fox/W5eHfjlcIbf
         prPbUGdcQ99h7XHv4L9Ctl9YrAzb5yG8I1mmVL6P160I9bz6w/38ss67Xp38qGjsIsi/
         v3KFvWoan0ZXK5iFCp8caU684bks6Nj8fH3VVlGAcHfeoT32kATmVYVZU2tzxu3WOKl3
         O6qaYOeD+BlP2MXaaHCwcK4CNOwVrAA1bUU9/ZLJzPzSSVu3ks1QXKRj92eOTid6J6yc
         lJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHl84Rjlmz5z7CisG4GhOYojkJVrwSv3e0lfWz8f8SI=;
        b=iQKbX0zuflG79MIxlm0HDyUORIAcyiUWXi4v1yes1NCrBPK2jtu29c34FVoUf/jsE6
         tGYaBh0hdeRtO20Qn1xKy7Yznmj2ShxdOyTcKuQZIOh/umLeoI3mOvIUVQFwU66HZKR+
         KRc7Pr+GojvQmmAAwGUKwn2IOtNybSlH5BEGR4d0jIncO3y0XAgcebBqbIelabHBt56S
         LoTCtg5X9CM1KFMY56cP78TjpgVyhfd3qR5fvmPK+d1aQKVZH1/d7NYBF8OsY4Y6r5lC
         MsY/t8vTS+xSkojps9GAq4098WiAZqVyUqZScE23G8Ux0J+95kyQUZRGB7ZPaJ0PCjYz
         JyyQ==
X-Gm-Message-State: AOAM533fnldWFHi2L6oSHYHXYCaMw5Rgr+hZVXPvp0oLBxKQPCXbP8+d
        QP9z5q3ngMdSG3ykDqCLOJ3sepZC0MlFjrX6DkLl/wMTJkk=
X-Google-Smtp-Source: ABdhPJzk2iE0ZTQBVxCB36R+U6Ozu53NUmBKgXTbVx8AB73mmkZTsBN2tGzZyCE/E9RvbRG+uCQulP+wSO70sRchkFg=
X-Received: by 2002:ac2:430f:: with SMTP id l15mr519767lfh.297.1622754049413;
 Thu, 03 Jun 2021 14:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com> <CAKwvOd=ygrySyMkJuGwyG7OPCOrTagcFn02RfEKANvhhuZJdOA@mail.gmail.com>
 <f06200fd-4ce5-e976-20ec-d2ea9d734b3c@kernel.org>
In-Reply-To: <f06200fd-4ce5-e976-20ec-d2ea9d734b3c@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Jun 2021 14:00:38 -0700
Message-ID: <CAKwvOdna4oLBQXsN_PfSik+zUkEuR3_ZLAHgZixr7qFtuPW4Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 1:52 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 6/3/2021 1:50 PM, Nick Desaulniers wrote:
> > On Thu, Jun 3, 2021 at 6:41 AM Jarmo Tiitto <jarmo.tiitto@gmail.com> wrote:
> >>
> >> Based on Kees and others feedback here is v2 patch
> >> that clarifies why the current checks in allocate_node()
> >> are flawed. I did fair amount of KGDB time on it.
> >
> > Kees can probably cut it when merging, but the above paragraph might
> > be better "below the fold" below next time (doesn't necessitate a v3).
> >
> >>
> >> When clang instrumentation eventually calls allocate_node()
> >> the struct llvm_prf_data *p argument tells us from what section
> >> we should reserve the vnode: It either points into vmlinux's
> >> core __llvm_prf_data section or some loaded module's
> >> __llvm_prf_data section.
> >>
> >> But since we don't have access to corresponding
> >> __llvm_prf_vnds section(s) for any module, the function
> >> should return just NULL and ignore any profiling attempts
> >> from modules for now.
> >>
> >> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> >> ---
> >
> > ^ ie. here. If you put text between the `---` and the diffstat, git
> > just discards it when applying. It's a good way to hide commentary
> > just meant for reviewers when sending a patch.
> >
> >
> >>   kernel/pgo/instrument.c | 21 ++++++++++++---------
> >>   1 file changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> >> index 0e07ee1b17d9..afe9982b07a3 100644
> >> --- a/kernel/pgo/instrument.c
> >> +++ b/kernel/pgo/instrument.c
> >> @@ -23,6 +23,7 @@
> >>   #include <linux/export.h>
> >>   #include <linux/spinlock.h>
> >>   #include <linux/types.h>
> >> +#include <asm-generic/sections.h>
> >>   #include "pgo.h"
> >>
> >>   /*
> >> @@ -55,17 +56,19 @@ void prf_unlock(unsigned long flags)
> >>   static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
> >>                                                   u32 index, u64 value)
> >>   {
> >> -       if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
> >> -               return NULL; /* Out of nodes */
> >> -
> >> -       current_node++;
> >> -
> >> -       /* Make sure the node is entirely within the section */
> >> -       if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
> >> -           &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
> >> +       const int max_vnds = prf_vnds_count();
> >
> > Sorry, where was prf_vnds_count() defined? I don't see it in
> > linux-next, but I'm also not sure which tree has
> > 5d0cda65918279ada060417c5fecb7e86ccb3def.
>
> It is generated via the __DEFINE_PRF_SIZE macro in kernel/pgo/pgo.h.

Thanks, it kills me when I can't find something with grep. I wonder if
language servers more modern than ctags have figured this out yet.

Patch looks fine to me then.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> >> +       /* Check that p is within vmlinux __llvm_prf_data section.
> >> +        * If not, don't allocate since we can't handle modules yet.
> >> +        */
> >> +       if (!memory_contains(__llvm_prf_data_start,
> >> +               __llvm_prf_data_end, p, sizeof(*p)))
> >>                  return NULL;
> >>
> >> -       return &__llvm_prf_vnds_start[current_node];
> >> +       if (WARN_ON_ONCE(current_node >= max_vnds))
> >> +               return NULL; /* Out of nodes */
> >> +
> >> +       /* reserve vnode for vmlinux */
> >> +       return &__llvm_prf_vnds_start[current_node++];
> >>   }
> >>
> >>   /*
> >>
> >> base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
> >> --
> >> 2.31.1
> >>
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/f06200fd-4ce5-e976-20ec-d2ea9d734b3c%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
