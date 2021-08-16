Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFC3EDD25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhHPSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhHPSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:36:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7655C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:36:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k5so8511536lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB23ERGkCrJ9OQnaruluv7ZnEnGMku+yMsIge6kF67c=;
        b=oSXlDIiAeBYFw4h4ctdo4rtYxhpEhLQFl6HTT92igAaqs8WD7gIv3/24NIFsNdTPmQ
         JhfzuXUfm7ZFqhJJp6QsF0IYwzgwCu1L+H/rdeGvzwpMh7oMLlHm9OiX/pKi+lmtqUK/
         SJ+5RADKDVyrvVVsB4sz6ZoUNiiOKEJVRahIp/G9lMcbV2rrgp0PrDXqCfexTHnjQslm
         4MBfaFEF8lEJ8LSA3ZCSoxKOB0+4Jq2AHiCXFQHgOf5lt2XCsqG2yhU787Wjy1+IKSs9
         vUSsIdJMUSOOw/8tvyTju0XSjZJM+2uedI482JknT3/tD6nA6yqZmB3yr+iU5eYbcxL4
         /uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB23ERGkCrJ9OQnaruluv7ZnEnGMku+yMsIge6kF67c=;
        b=SZZOSvPBKaOn3/pAGJNT7iD9DuXDmpHhHrl0BRbqatr+5dk/GCXojCvTaArDq5Uisw
         17jTdabguGVkCNW/lb+KrrfR972UWhh8fNOfden0B3hBXnbePHoU6ZQTSab/V3m/BIwM
         CgPuuU+juoNHvoqVUr1CulU3U4fRB5OXLsXGtOzWWhGxnr7P/r+0PaApLmYxzcgJtgHA
         zqxepTfyHSRJD8I6c3fYUAsEMrd2kG6xUk2/MubTTuIyX87XEAzP2wzESe9tMw8QDU5o
         Ku0iL5ciQR4NTuOXYMjrLFGBF+pYgUEDG44JieHaRR6bDUjdR6f+CYyHzufSGRQxouLk
         aL3Q==
X-Gm-Message-State: AOAM530+u+otYDEKRnbtR3JUDJgBjZM8a88eVgKmRGzo8f0ss8mMb5/a
        VstxI6gtb+xFHsI02Dj7WLpkAFjbwXm3XRBLVs9I+g==
X-Google-Smtp-Source: ABdhPJztzB1EGU5OZD5t9d/8D3eADqHltC95iT7kjGY+zwcaI7n3DFhOCAYwbWhHJX0wJMypPpQJwnPvDKX4bXgx8lY=
X-Received: by 2002:ac2:4e8c:: with SMTP id o12mr13094092lfr.374.1629138960831;
 Mon, 16 Aug 2021 11:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210810204240.4008685-1-ndesaulniers@google.com> <CAK7LNASotywVkNjaBC7wYke70QL+a0tMJEVEvRTPpt8dDgHE9Q@mail.gmail.com>
In-Reply-To: <CAK7LNASotywVkNjaBC7wYke70QL+a0tMJEVEvRTPpt8dDgHE9Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 11:35:49 -0700
Message-ID: <CAKwvOdmpTt1PBnvo3RFkYnd5O2JTW7DTA9sGQJgvsDOFkVt8Ag@mail.gmail.com>
Subject: Re: [PATCH] Makefile: remove stale cc-option checks
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 6:43 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Aug 11, 2021 at 5:42 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > --param=allow-store-data-races=0 was renamed to --allow-store-data-races
> > in the GCC 10 release.
> >
> > diff --git a/Makefile b/Makefile
> > index 027fdf2a14fe..3e3fb4affba1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -844,17 +847,17 @@ KBUILD_RUSTFLAGS += -Copt-level=z
> >  endif
> >
> >  # Tell gcc to never replace conditional load with a non-conditional one
> > -KBUILD_CFLAGS  += $(call cc-option,--param=allow-store-data-races=0)
> > +ifdef CONFIG_CC_IS_GCC
>
>
> Can you insert a comment here?
>
> # GCC 10 renamed --param=allow-store-data-races=0 to --allow-store-data-races
>
>
> It will remind us of dropping this conditional
> in the (long long distant) future.
>
>
>
>
> > +KBUILD_CFLAGS  += $(call cc-option,--allow-store-data-races,--param=allow-store-data-races=0)
> >  KBUILD_CFLAGS  += $(call cc-option,-fno-allow-store-data-races)
> > +endif

This report is confusing:
https://lore.kernel.org/linux-mm/202108160729.Lx0IJzq3-lkp@intel.com/
(csky gcc-11)

>> csky-linux-gcc: error: unrecognized command-line option '--param=allow-store-data-races=0'; did you mean '--allow-store-data-races'?

I wonder if cc-option detection for these is broken?  Perhaps I should
not touch these other than to wrap them in the CONFIG_CC_IS_GCC guard?

(Either way, I need to send a v2 in response to Naresh's report as
well. https://lore.kernel.org/lkml/CA+G9fYtPBp_-Ko_P7NuOX6vN9-66rjJuBt21h3arrLqEaQQn6w@mail.gmail.com/
It seems that -mfentry wasn't implemented for s390-linux-gnu-gcc until
gcc-9; so rather than remove top level support, perhaps a comment
about gcc-9+ s390 having support will make grepping for it easier in
the future).
-- 
Thanks,
~Nick Desaulniers
