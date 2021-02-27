Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9C326B71
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0Dle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhB0Dla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:41:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14DFE64F2A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614397249;
        bh=GaYBKNg2FYle2ONdxwZhRkedGU09PcAZdiKDMRmBPLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XyYvUGJY7Wkxu5qH4nylRf/R5eP6PHeOZFS+5TuNBjYLmZB/zVjMYp7YSuy/NFfqG
         nW+HTGQoIRhUTCfIy7LzMLuINFnacalY9DEZOIESRzNP32m+ItFpwIBBaUfLNxknVv
         cIo/k7esJNeeKJNMMETnsFcASUHwpHugySCaqWetz1raXtqZLDy3/0oEuAKIo45wXY
         xZnDmvRI9g/qYm7BwkBhCWh8kkU7Pmdx736XnX3PFvV6MADsRjO1YgNk7CJwDZ2d+6
         nzjTE7qzpBEzgVEMbUTO7RS4Z5+hxm5baZdpSZor2j0qfmqXkI3RgeukSeEUtANtRU
         kvQ5nXENLPZXQ==
Received: by mail-ej1-f44.google.com with SMTP id b21so7017202eja.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:40:48 -0800 (PST)
X-Gm-Message-State: AOAM530sbu/GQoNpo5QSNvfUgB5AKl/JMZGNNZFntIQyzr94aOX2GLzY
        k9yhV+zvS0d7lfNgh0xFnKhpfqFFea1tryZDiZb5yA==
X-Google-Smtp-Source: ABdhPJygujS8ZtS7FU8BxyTMB+/C3ogJJ/OAQ3TpUmTEIh+cFM/x9j3E1yMzqckCSAyuA83Ngvx8oU/kL9mcMtkQ+UA=
X-Received: by 2002:a17:906:a44:: with SMTP id x4mr6400087ejf.101.1614397247562;
 Fri, 26 Feb 2021 19:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20210223204436.1df73153@alex-virtual-machine> <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
 <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com> <20210225124711.35b31965@alex-virtual-machine>
In-Reply-To: <20210225124711.35b31965@alex-virtual-machine>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Feb 2021 19:40:35 -0800
X-Gmail-Original-Message-ID: <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
Message-ID: <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKCDloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 8:47 PM Aili Yao <yaoaili@kingsoft.com> wrote:
>
> On Tue, 23 Feb 2021 08:42:59 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
>
> > On Tue, Feb 23, 2021 at 07:33:46AM -0800, Andy Lutomirski wrote:
> > >
> > > > On Feb 23, 2021, at 4:44 AM, Aili Yao <yaoaili@kingsoft.com> wrote:
> > > >
> > > > =EF=BB=BFOn Fri, 5 Feb 2021 17:01:35 +0800
> > > > Aili Yao <yaoaili@kingsoft.com> wrote:
> > > >
> > > >> When one page is already hwpoisoned by MCE AO action, processes ma=
y not
> > > >> be killed, processes mapping this page may make a syscall include =
this
> > > >> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in k=
ernel
> > > >> mode it may be fixed by fixup_exception, current code will just re=
turn
> > > >> error code to user code.
> > > >>
> > > >> This is not sufficient, we should send a SIGBUS to the process and=
 log
> > > >> the info to console, as we can't trust the process will handle the=
 error
> > > >> correctly.
> > > >>
> > > >> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> > > >> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > > >> ---
> > > >> arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++------------=
----
> > > >> 1 file changed, 40 insertions(+), 22 deletions(-)
> > > >>
> > > > Hi luto;
> > > >  Is there any feedback?
> > >
> > > At the very least, this needs a clear explanation of why your propose=
d behavior is better than the existing behavior.
> >
> > The explanation is buried in that "can't trust the process" line.
> >
> > E.g. user space isn't good about checking for failed write(2) syscalls.
> > So if the poison was in a user buffer passed to write(fd, buffer, count=
)
> > sending a SIGBUS would be the action if they read the poison directly,
> > so it seems reasonable to send the same signal if the kernel read their
> > poison for them.
> >
> > It would avoid users that didn't check the return value merrily proceed=
ing
> > as if everything was ok.
>
> Hi luto:
>    I will add more infomation:
>    Even if the process will check return value of syscall like write, I d=
on't think
> process will take proper action for this.
>    In test example, the return value will be errno is 14 (Bad Address), t=
he process may not realize
> this is a hw issue, and may take wrong action not as expected.
>    And totally, A hw error will rarely happen, and the hw error hitting t=
his branch will be
> more unlikely, the impaction without this patch is quite minor, but this =
is still not good enough, we should
> make it better, right?

There are a few issues I can imagine:

Some programs may use read(2), write(2), etc as ways to check if
memory is valid without getting a signal.  They might not want
signals, which means that this feature might need to be configurable.

It's worth making sure that this doesn't end up sending duplicate
signals.  If nothing else, this would impact the vsyscall emulation
code.

Programs that get a signal might expect that the RIP that the signal
frame points to is the instruction that caused the signal and that the
instruction faulted without side effects.  For SIGSEGV, I would be
especially nervous about this.  Maybe SIGBUS is safer.  For SIGSEGV,
it's entirely valid to look at CR2 / si_fault_addr, fix it up, and
return.  This would be completely *invalid* with your patch.  I'm not
sure what to do about this.

--Andy
