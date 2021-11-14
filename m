Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E344F9F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhKNSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 13:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhKNSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 13:32:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFFC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 10:29:58 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s14so14295888ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk1kS/XrodSTgHr2aFvqwnuh3hvmct9PH9DLNGKfjfA=;
        b=DL9rvNCgh+4g7/jwfzxas1EGyGpWBk51o68+Z7WTqxfxlH+XMMUt9Ex5Hew6Vvx6fl
         QKWgC5GZfVFImv2tND26vUhxHZ/QAL24su7euKvqi5WdD4fJlxGdYjWeOKOM9WTE8bp/
         KrtxTo66GbkFZ3wWCv0oobA3DeWLY0AlmPtyG9YeS8SklnQn/XbsIa75RhiGTKPdtbGr
         8Zk/8ayV+m3uIycDcu2iiU8ZHOY/pjZQgZJQdgiWuBLsnGnUQkv5tvhWsQkm5HXp/nd+
         2GlqqMT771q5wXr1TLBPKCxlQv1EOQNVatJN8aLT3MWz1hYBtF0QSeip1lIPDam0yGYc
         2ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk1kS/XrodSTgHr2aFvqwnuh3hvmct9PH9DLNGKfjfA=;
        b=5kwXkNTXpf2izqI+J8N9wdMzCCwiGa8h4r5tvX6bFcgvrDChkQCLEAbtzMXqhHoCzN
         pdjPKXpEkuNJ5OjJtjNe8gw4Ybitm7AhjZuhdlvlN9cfKbC4JqQwyF8cMikCAqMEYTRU
         oWGhhT5NC8OoMEtqeyUblN3oshOqzO9bf9qiNGqjflevYPJtkzS9XhhGd2mxlXhUFAmX
         rb5Id0tZ2r2WZdM25ZXPat2zqbQGR4gqskrSIh3T++cu2ZENh5lYWcUuj9EjT/qdUgzc
         a7Nw3z81zdglq+mDVSYhJuXq8q+45BMsmbZpG2ZKFQ7igqLe5xM+5DNJnx+cGZn15aFN
         vQ/Q==
X-Gm-Message-State: AOAM532/GlAUquctq20ISZvlUUPag10Ew2JOntxqjxSHb4idxJp/UsdL
        BGzj1H5037+DJpt/I8Ac2xkPB8JEgnNgKmkH6Q==
X-Google-Smtp-Source: ABdhPJzd5CAJwWb9QRkWPS2TK2wfg1GyhVdOu2nZaM2F3P5YYz8FX+7UjTtB9TuDtmOjlJ6Mp8OvWM7OpagKmA53s8o=
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr18895429ilu.211.1636914597654;
 Sun, 14 Nov 2021 10:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20211113124035.9180-1-brgerst@gmail.com> <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com> <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
 <20211114110305.GN174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211114110305.GN174703@worktop.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 14 Nov 2021 13:29:46 -0500
Message-ID: <CAMzpN2jWs8heND7PydKw9CCZ0cjvJgxLMwXXQj45rwR6twpJLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 6:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Nov 13, 2021 at 11:54:19PM -0500, Brian Gerst wrote:
> > On Sat, Nov 13, 2021 at 8:18 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > >
> > >
> > > On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
> > > > The per-cpu section is currently linked at virtual address 0, because
> > > > older compilers hardcoded the stack protector canary value at a fixed
> > > > offset from the start of the GS segment.  Use a standard relative offset
> > > > as the GS base when the stack protector is disabled, or a newer compiler
> > > > is used that supports a configurable location for the stack canary.
> > >
> > > Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.
> >
> > This patch probably makes more sense if we drop the fixed model, as
> > that gets rid of alot of code that works around having to link the
> > percpu section differently.
>
> Can someone spell out these benefits please? To me having per-cpu start
> at 0 makes perfect sense, how does not having that make things better?

The best reason is that the percpu section is currently not subject to
KASLR.  It actually needs extra support to counter the effects of
relocation.  There have also been a number of linker bugs over the
years that have had to be worked around.

If we were to decide to drop the fixed stack protector the diffstat
would look something like:

 arch/x86/Makefile                         |  19 ++--
 arch/x86/boot/compressed/misc.c           |  12 ---
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/percpu.h             |  22 -----
 arch/x86/include/asm/processor.h          |  24 ++---
 arch/x86/include/asm/stackprotector.h     |  13 +--
 arch/x86/kernel/asm-offsets_64.c          |   6 --
 arch/x86/kernel/cpu/common.c              |   8 +-
 arch/x86/kernel/head_64.S                 |  11 ++-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/vmlinux.lds.S             |  33 -------
 arch/x86/tools/relocs.c                   | 143 +-----------------------------
 arch/x86/xen/xen-head.S                   |  10 +--
 scripts/gcc-x86_64-has-stack-protector.sh |   2 +-
 14 files changed, 35 insertions(+), 271 deletions(-)

--
Brian Gerst
