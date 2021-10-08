Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5242659C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhJHIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJHIHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B3C56103C;
        Fri,  8 Oct 2021 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633680352;
        bh=COR155gusrZdnvjVpDgWU/uP+eypfCBlb2p3HAxgdNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPYXFxNGcUnrkUiTXqUrGrNF6857sCPIa3VbA9Ln3H9Ytv1H9z/KtySug1lsycvpE
         B1W+zG2S9cC6KyYyPyPdQFnqs3WEjZ5CBvEgMah7XuwOx95AiHikeUTAFETZKYgOne
         dm5Lm3iQHuWpA8rJ03dpPz1T2s94PlVagOdIrdUwPqcaSyaE3SAhowF5JRdtM3iIVw
         A+JVx1cx9dQ4TUmWlnn+UHah+IS/a99U9kO1e/LQyE4u9AXNlGZj2piqKRjWvgKLeG
         FN8hz0uDnBSniDzsgwDWxE1xG2FmrdvDVSIoUF+MeidtlrHNvfXjhmzyjaYg4MLFQo
         YCkRiztPlKAXg==
Date:   Fri, 8 Oct 2021 09:05:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>, ben.dai@unisoc.com,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] arm64: ftrace: use function_nocfi for _mcount as well
Message-ID: <20211008080546.GA495@willie-the-truck>
References: <20211005123645.2766258-1-sumit.garg@linaro.org>
 <CABCJKuesYcGdKLi1YqHP3PU5n6vf-3Q-A+UNyCLzsoJ+0oiKmw@mail.gmail.com>
 <20211005153523.GD6678@C02TD0UTHF1T.local>
 <CAFA6WYMvVuwAsU09iW7LonZGK92hX2rH3f8Xtktqs6t1wVtLUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMvVuwAsU09iW7LonZGK92hX2rH3f8Xtktqs6t1wVtLUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Wed, Oct 06, 2021 at 11:05:52AM +0530, Sumit Garg wrote:
> On Tue, 5 Oct 2021 at 21:05, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Oct 05, 2021 at 08:20:02AM -0700, Sami Tolvanen wrote:
> > > On Tue, Oct 5, 2021 at 5:37 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > > index 91fa4baa1a93..347b0cc68f07 100644
> > > > --- a/arch/arm64/include/asm/ftrace.h
> > > > +++ b/arch/arm64/include/asm/ftrace.h
> > > > @@ -15,7 +15,7 @@
> > > >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> > > >  #else
> > > > -#define MCOUNT_ADDR            ((unsigned long)_mcount)
> > > > +#define MCOUNT_ADDR            ((unsigned long)function_nocfi(_mcount))
> > > >  #endif
> > > >
> > > >  /* The BL at the callsite's adjusted rec->ip */
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > Clang >= 10 supports -fpatchable-function-entry and CFI requires Clang
> > > 12, so I assume this is only an issue if
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS is explicitly disabled?
> >
> > I don't believe it's possible to disable explicitly, since
> > DYNAMIC_FTRACE_WITH_REGS isn't user selectable, and is def bool y,
> > depending on HAVE_DYNAMIC_FTRACE_WITH_REGS.
> >
> 
> Ah, I see.
> 
> > Sumit, have you actually seen a problem, or was this found by
> > inspection?
> >
> 
> Actually I have seen this ftrace problem with the android11-5.4-lts
> kernel and AOSP master user-space on db845c. The reason being kernel
> v5.4 LTS doesn't support ftrace with -fpatchable-function-entry on
> arm64.
> 
> With the mainline, I haven't tried to reproduce this issue but it was
> rather by inspection that this needs to be fixed as well.
> 
> > If this isn't an issue in practice, we could add the funciton_nocfi()
> > for consistency, but we should make that clear in the commit message,
> > and drop the fixes tag.
> 
> Sure, let me drop the fixes tag and update the commit description in
> v3 as mainline only enabled CFI_CLANG for arm64 when
> "-fpatchable-function-entry" is supported.

Did you post a v3? Just want to make sure I didn't miss it.

Will
