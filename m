Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72757423782
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJFFh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 01:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 01:37:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F923C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 22:36:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j5so5359845lfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybRV+hwt+XX9ge3tQ7wYeHTSSre975ppkrBynQaih68=;
        b=OGLR+fdzuu83r+LVkVgU/R82Qj2xU1RxfIhAkTq5M9KO9tp5Yki8qP3nCeOA/qdKtY
         tRxRkDy86vKOfWi8PcvOT8GgF6nU1PAwUoJ4MxwfgY2xWB7G/WDwRzg3GdsEZ5Z9JcGq
         jbREXv0tEsGS/Byq/QbpRlly2G9PXkrFj1RyhZuP/YlqqGGpQ8qh2zaKXb0UNDfEH6e4
         hzasqeQ73tKDjuNmWzX718Plg8QfOfo6blOJ7q3K9Q5oep6F131LdDFAgutcPLF1xbwq
         MVfiKIMP72/Wkgox241eYRIJ5kcF7dSrXNheWEZM7l+R1W6CkqthTlP2/yiX4PAfmwAg
         bTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybRV+hwt+XX9ge3tQ7wYeHTSSre975ppkrBynQaih68=;
        b=FjSMbl10u+cPPtmGe4xQfb/WNiojOVMvSB8Sjy9arCMaRZTEnL06WSXKYBhB70kWXv
         mSYLjblDPtAig+v1SRR6ed6QN6Qi52M0tMNr0+FxTs0WeTA3CnfvCtH4D6PmPR70cxzr
         xLii3wRR9ZCc2B+gGgabcl0wj50vIkwmSgtzww7FNIzrV6fFZFwmJGFsWp532CowgFYn
         PhueRksTXT6Z5puVSZn5ETlKvijBvzkS1lg71jWMC9BJ4oZWoJEuq5mF9miv5niJrH9n
         TnXNh1AL5UAWNIqNPjXDeoOnGNQ9qRc/Kugp9c20cfAHDNTob5PqyhX8np0EA1HHPFIh
         2z5A==
X-Gm-Message-State: AOAM532EhbNgaIEoYfiPGXzJ+5hPWH1Af71MW+E3Oj9GjS+QEV8uD/AL
        visJoxHrPczIBWYVXot5nmyJQRouvnkvGD9cTs9lOg==
X-Google-Smtp-Source: ABdhPJzqEDYTHvAgPayyBNgll4yjivTHrBO+vJYqEiOV4VbsArYf1dvYHymL3sKS5UG7PlqCkl77D1pUn08KGosvLnY=
X-Received: by 2002:a05:6512:747:: with SMTP id c7mr7562628lfs.80.1633498565212;
 Tue, 05 Oct 2021 22:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211005123645.2766258-1-sumit.garg@linaro.org>
 <CABCJKuesYcGdKLi1YqHP3PU5n6vf-3Q-A+UNyCLzsoJ+0oiKmw@mail.gmail.com> <20211005153523.GD6678@C02TD0UTHF1T.local>
In-Reply-To: <20211005153523.GD6678@C02TD0UTHF1T.local>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 6 Oct 2021 11:05:52 +0530
Message-ID: <CAFA6WYMvVuwAsU09iW7LonZGK92hX2rH3f8Xtktqs6t1wVtLUw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: ftrace: use function_nocfi for _mcount as well
To:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ben.dai@unisoc.com,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Sami,

On Tue, 5 Oct 2021 at 21:05, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 05, 2021 at 08:20:02AM -0700, Sami Tolvanen wrote:
> > Hi Sumit,
> >
> > On Tue, Oct 5, 2021 at 5:37 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
> > > only fixed address of ftrace_call but address of _mcount needs to be
> > > fixed as well. Use function_nocfi() to get the actual address of _mcount
> > > function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
> > > with jump table addresses which breaks dynamic ftrace as the address of
> > > _mcount is replaced with the address of _mcount.cfi_jt.
> > >
> > > This problem won't apply where the toolchain implements
> > > -fpatchable-function-entry as we'll use that in preference to regular -pg,
> > > i.e. this won't show up with recent versions of clang.
> > >
> > > Fixes: 9186ad8e66bab6a1 ("arm64: allow CONFIG_CFI_CLANG to be selected")
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Added fixes tag.
> > > - Extended commit description.
> > > - Picked up Mark's ack.
> > >
> > >  arch/arm64/include/asm/ftrace.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > index 91fa4baa1a93..347b0cc68f07 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -15,7 +15,7 @@
> > >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> > >  #else
> > > -#define MCOUNT_ADDR            ((unsigned long)_mcount)
> > > +#define MCOUNT_ADDR            ((unsigned long)function_nocfi(_mcount))
> > >  #endif
> > >
> > >  /* The BL at the callsite's adjusted rec->ip */
> > > --
> > > 2.17.1
> > >
> >
> > Clang >= 10 supports -fpatchable-function-entry and CFI requires Clang
> > 12, so I assume this is only an issue if
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS is explicitly disabled?
>
> I don't believe it's possible to disable explicitly, since
> DYNAMIC_FTRACE_WITH_REGS isn't user selectable, and is def bool y,
> depending on HAVE_DYNAMIC_FTRACE_WITH_REGS.
>

Ah, I see.

> Sumit, have you actually seen a problem, or was this found by
> inspection?
>

Actually I have seen this ftrace problem with the android11-5.4-lts
kernel and AOSP master user-space on db845c. The reason being kernel
v5.4 LTS doesn't support ftrace with -fpatchable-function-entry on
arm64.

With the mainline, I haven't tried to reproduce this issue but it was
rather by inspection that this needs to be fixed as well.

> If this isn't an issue in practice, we could add the funciton_nocfi()
> for consistency, but we should make that clear in the commit message,
> and drop the fixes tag.

Sure, let me drop the fixes tag and update the commit description in
v3 as mainline only enabled CFI_CLANG for arm64 when
"-fpatchable-function-entry" is supported.

-Sumit

>
> Thanks,
> Mark.
