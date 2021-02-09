Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080AB315AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhBJAJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233899AbhBIUl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:41:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F325B64EAC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612901401;
        bh=xHJDr/1nD89ckeRCIpjTV/NH06t3sFAkrRdc0f9MThY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qV8BV13PVpX+G8rd1T5rWrQymjsvQtZt0FpMgDnqj4rOsZl2FtRtxumMeoojFPRBn
         Zmcx6TqO2ElgeHLZAq8Biet2W4BXGWxA/qQnZLXZaT7D13JRVk8xLI285nIP7q50Mm
         Hfz/ehrUWrFinSipTQkt+JxMzvbzDFzuCTzfmjdgWWYxpcZ7jXGv/B1CWwY7mjcE6w
         TsVe37lLSFd6A3aPzEiEhc28EjGn7amOONfRAnwt7iGd1OXq1fjnwRShWKGGtvtnM2
         nOtytLjIxmrFHlnqdls9u0QHS3ucdo6nq1IufYq9O+DG/7TN7wm0dfq0bQhmP6fQfA
         4Nk+Q145XAmMQ==
Received: by mail-ed1-f53.google.com with SMTP id y8so25565004ede.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:10:00 -0800 (PST)
X-Gm-Message-State: AOAM531S7eq3QtswUR0FX+LaXXkEcDRYeOKSPQDN8O2AtnJJqMClEOWi
        f1RyWor1WJa0NJIL8dJZlTfYRwiCDbavwLSht8ZwMQ==
X-Google-Smtp-Source: ABdhPJwptoAG+zSZ8w6RQ0cdk5e5yV6WHEHso2hROrAGsvahllfnPmpRo98ewwya/3n4xuv8Aa5J4uIw3tTay4pM8dI=
X-Received: by 2002:a05:6402:31a3:: with SMTP id dj3mr24435566edb.172.1612901399469;
 Tue, 09 Feb 2021 12:09:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612113550.git.luto@kernel.org> <c5f715daf95fc7e94e279f0486908b53e1cdba3c.1612113550.git.luto@kernel.org>
 <20210203185517.GH13819@zn.tnic>
In-Reply-To: <20210203185517.GH13819@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Feb 2021 12:09:48 -0800
X-Gmail-Original-Message-ID: <CALCETrXUOJ1RNHCGZjp_Xk0DTvXaGXKy6t1b5vFHa3CqDenoRw@mail.gmail.com>
Message-ID: <CALCETrXUOJ1RNHCGZjp_Xk0DTvXaGXKy6t1b5vFHa3CqDenoRw@mail.gmail.com>
Subject: Re: [PATCH 07/11] x86/fault: Split the OOPS code out from no_context()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Jan 31, 2021 at 09:24:38AM -0800, Andy Lutomirski wrote:
> > Not all callers of no_context() want to run exception fixups.
> > Separate the OOPS code out from the fixup code in no_context().
> >
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/mm/fault.c | 116 +++++++++++++++++++++++---------------------
> >  1 file changed, 62 insertions(+), 54 deletions(-)
> >
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 1939e546beae..6f43d080e1e8 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -618,53 +618,20 @@ static void set_signal_archinfo(unsigned long address,
> >  }
> >
> >  static noinline void
> > -no_context(struct pt_regs *regs, unsigned long error_code,
> > -        unsigned long address, int signal, int si_code)
> > +page_fault_oops(struct pt_regs *regs, unsigned long error_code,
>
> Not sure about this name - it still tries to recover:
> efi_recover_from_page_fault().
>
> Judging by where it is called, maybe no_context_tail() or
> no_context_oops() or no_context_finish_me_already()...
>
> Yah, I haz no better idea. :-\
>
> ...
>
> > @@ -739,6 +692,61 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> >       oops_end(flags, regs, sig);
> >  }
> >
> > +static noinline void
> > +no_context(struct pt_regs *regs, unsigned long error_code,
> > +        unsigned long address, int signal, int si_code)
> > +{
> > +     if (user_mode(regs)) {
> > +             /*
> > +              * This is an implicit supervisor-mode access from user
> > +              * mode.  Bypass all the kernel-mode recovery code and just
> > +              * OOPS.
> > +              */
> > +             goto oops;
>
> Just do
>
>                 return page_fault_oops(...);
>
> here and get rid of the label.

I'm going to skip this one, because that code is deleted later in the
series, and fixing it here just adds more churn.
