Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEA422C96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhJEPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:37:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234282AbhJEPhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:37:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636B71FB;
        Tue,  5 Oct 2021 08:35:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7419A3F70D;
        Tue,  5 Oct 2021 08:35:27 -0700 (PDT)
Date:   Tue, 5 Oct 2021 16:35:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ben.dai@unisoc.com,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        daniel.thompson@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] arm64: ftrace: use function_nocfi for _mcount as well
Message-ID: <20211005153523.GD6678@C02TD0UTHF1T.local>
References: <20211005123645.2766258-1-sumit.garg@linaro.org>
 <CABCJKuesYcGdKLi1YqHP3PU5n6vf-3Q-A+UNyCLzsoJ+0oiKmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuesYcGdKLi1YqHP3PU5n6vf-3Q-A+UNyCLzsoJ+0oiKmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 08:20:02AM -0700, Sami Tolvanen wrote:
> Hi Sumit,
> 
> On Tue, Oct 5, 2021 at 5:37 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
> > only fixed address of ftrace_call but address of _mcount needs to be
> > fixed as well. Use function_nocfi() to get the actual address of _mcount
> > function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
> > with jump table addresses which breaks dynamic ftrace as the address of
> > _mcount is replaced with the address of _mcount.cfi_jt.
> >
> > This problem won't apply where the toolchain implements
> > -fpatchable-function-entry as we'll use that in preference to regular -pg,
> > i.e. this won't show up with recent versions of clang.
> >
> > Fixes: 9186ad8e66bab6a1 ("arm64: allow CONFIG_CFI_CLANG to be selected")
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >
> > Changes in v2:
> > - Added fixes tag.
> > - Extended commit description.
> > - Picked up Mark's ack.
> >
> >  arch/arm64/include/asm/ftrace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 91fa4baa1a93..347b0cc68f07 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -15,7 +15,7 @@
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> >  #else
> > -#define MCOUNT_ADDR            ((unsigned long)_mcount)
> > +#define MCOUNT_ADDR            ((unsigned long)function_nocfi(_mcount))
> >  #endif
> >
> >  /* The BL at the callsite's adjusted rec->ip */
> > --
> > 2.17.1
> >
> 
> Clang >= 10 supports -fpatchable-function-entry and CFI requires Clang
> 12, so I assume this is only an issue if
> CONFIG_DYNAMIC_FTRACE_WITH_REGS is explicitly disabled?

I don't believe it's possible to disable explicitly, since
DYNAMIC_FTRACE_WITH_REGS isn't user selectable, and is def bool y,
depending on HAVE_DYNAMIC_FTRACE_WITH_REGS.

Sumit, have you actually seen a problem, or was this found by
inspection?

If this isn't an issue in practice, we could add the funciton_nocfi()
for consistency, but we should make that clear in the commit message,
and drop the fixes tag.

Thanks,
Mark.
