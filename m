Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817D36CFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhD1AMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhD1AMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:12:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66CF6613FC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619568684;
        bh=792QeymoWauXvm02dswME8EM0IgqUrIwt4lsDh5wUrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hh1aY/nRVJDxTXaHdxDLlvdGwWxonXq64a17k0SXUUjulkJuPRhSbofS8k/8pU2Hq
         GmxucxgF64op4WwkTsRGVwVdPry4mfePPk2510OqxAwBMCxIGdndfdEFa0sxHRvEgu
         ChQeVnsYOTlPHxCIbrDfbDNj+5WVG1cjJq84lgnUZAkahiww3Ju/qgHKCJmXbSexih
         xJIXalxzCQS6XyUW2kcspX1DI4rGlzr9w6mUhLyJYu9KmrQ1+AaQ7iqVmsLt3Wk/0n
         WPmYAzTeB0669ByqgDxFNgic/oAvRHu45uYCtFp57C8lKvnVXhhQelbvOTkvuHVv6e
         yEozGZ/NE/Wfg==
Received: by mail-ej1-f48.google.com with SMTP id r20so42216421ejo.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:11:24 -0700 (PDT)
X-Gm-Message-State: AOAM531dGermP/ssXvVjP1JKTT8B1YljjuEnqDTxQsfIDRwp0gEia13y
        QnfMe3VyVAOwiLdwyWEChSe9V/cZ99OH/kVCYhRJHg==
X-Google-Smtp-Source: ABdhPJzFJ9RDRFJkSZtUvvXS0A1zmHuwfOM0Id3HacC43zVXPXjiF6rCdQLA98OO8yPKhWP6sM3Z89x3sgfd9juQ0Cw=
X-Received: by 2002:a17:906:270a:: with SMTP id z10mr17591091ejc.204.1619568683001;
 Tue, 27 Apr 2021 17:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net> <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
 <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com> <3626eea3-524e-4dbd-78dd-9ade5a346a08@zytor.com>
In-Reply-To: <3626eea3-524e-4dbd-78dd-9ade5a346a08@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Apr 2021 17:11:11 -0700
X-Gmail-Original-Message-ID: <CALCETrWzL=jgnWd+6YuBo02GG8vTvsG22sXGaUQCc37vwQ6HdA@mail.gmail.com>
Message-ID: <CALCETrWzL=jgnWd+6YuBo02GG8vTvsG22sXGaUQCc37vwQ6HdA@mail.gmail.com>
Subject: Re: pt_regs->ax == -ENOSYS
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 5:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 4/27/21 4:23 PM, Andy Lutomirski wrote:
> >
> > I much prefer the model of saying that the bits that make sense for
> > the syscall type (all 64 for 64-bit SYSCALL and the low 32 for
> > everything else) are all valid.  This way there are no weird reserved
> > bits, no weird ptrace() interactions, etc.  I'm a tiny bit concerned
> > that this would result in a backwards compatibility issue, but not
> > very.  This would involve changing syscall_get_nr(), but that doesn't
> > seem so bad.  The biggest problem is that seccomp hardcoded syscall
> > nrs to 32 bit.
> >
> > An alternative would be to declare that we always truncate to 32 bits,
> > except that 64-bit SYSCALL with high bits set is an error and results
> > in ENOSYS. The ptrace interaction there is potentially nasty.
> >
> > Basically, all choices here kind of suck, and I haven't done a real
> > analysis of all the issues...
> >
>
> OK, I really don't understand this. The *current* way of doing it causes
> a bunch of ugly corner conditions, including in ptrace, which this would
> get rid of. It isn't any different than passing any other argument which
> is an int -- in fact we have this whole machinery to deal with that subcase.
>

Let's suppose we decide to truncate the syscall nr.  What would the
actual semantics be?  Would ptrace see the truncated value in orig_ax?
 How about syscall user dispatch?  What happens if ptrace writes a
value with high bits set to orig_ax?  Do we truncate it again?  Or do
we say that ptrace *can't* write too large a value?

For better for worse, RAX is 64 bits, orig_ax is a 64-bit field, and
it currently has nonsensical semantics.  Redefining orig_ax as a
32-bit field is surely possible, but doing so cleanly is not
necessarily any easier than any other approach.  If it weren't for
seccomp, I would say that the obviously correct answer is to just
treat it everywhere as a 64-bit number.

--Andy
