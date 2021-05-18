Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA61738835A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhERXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhERXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:53:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A62C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:52:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 10so8630575pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFd8U2H3+7KgjevEIkxFhdP9sWTsgejveMawFZzQnQI=;
        b=BLkpUlmMtVHZZGVesaTCQAiF5S8WxQOW2l57KGOQL3jfZzyKjmB1pmKd7x3rfGGqZv
         CvX3IOjwn4Fl9z8+I3c92zJ6sn3Mw2c0w6GVjVQlNQYqHQ2qHdiB9atJzYnXwenx8GbU
         FkVJ7fZjP7Z7PC0X/vQtePhd3wZxsrAfOHyRL0NfbK94CM53xf5O/XXu2zobmliqQ6+0
         DGbHlc3Ehtji+gn+ogdz8jhR3xebQuHJNE4hXdfolkNl1MTrrv1CS5xv4c7YAG4CnhZs
         XV1aSEPn2g4YyAmKI390UAr78YBr9S7O7ZU54GZeQpEKzeOXJbT/gfGfYxLaunRGvHmd
         VfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFd8U2H3+7KgjevEIkxFhdP9sWTsgejveMawFZzQnQI=;
        b=ct/nJlbyRpndWfmjcGZ+bOpmrRhxQ7matFte9SupAkrRFZdNEKdMr+UEnZoW7vmj33
         TSmiWR8b++5GoQtchVNCh6N7K/61VnvPm/8D1bYbBotDS0uCF7zmbmXtxHUqFc1EQjEZ
         Et2TU9sJ2GkaFYGZL3K39Hl1IyUglWnzc3gVP/0T0hVANeoEi4IDM19kB5I6FWulXWcG
         fgy8Jxu38y2T1mtOE+rB/hkuKx7z9hzVsXFJ8yZOOwGH2f0SxfIO6FDS5gJsZ29YtdaB
         yJMQtekQ/x/PtU8NyxwC2p9BjwULUCwbOwwWx02Cfg3x8xlqcknxdeJNUuOBuTuXcYin
         zeAw==
X-Gm-Message-State: AOAM532iO+3BbfHvHFqSH8WZfNN+hziLlNgbG2tx5JROtu/OJuC/gLQu
        o2YLwUHQH7uB9uWIBd9hij2Qqdb53b+r/1NTUVgOIg==
X-Google-Smtp-Source: ABdhPJyDSm7VZ3vEBsXak3vmZyZbdtFNebQ5SlUpDFvuZiK10BE3W4rZjOtccBl55SaxHiB7LQSWQitHr+vRO0WTBw0=
X-Received: by 2002:a62:6481:0:b029:249:ecee:a05d with SMTP id
 y123-20020a6264810000b0290249eceea05dmr7620241pfb.9.1621381941392; Tue, 18
 May 2021 16:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
In-Reply-To: <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
From:   Ryan Houdek <houdek.ryan@fex-emu.org>
Date:   Tue, 18 May 2021 16:52:10 -0700
Message-ID: <CAPpY1unuaw_GzbAn=Qugv==2zyG71g+xdxD-6HdsTeAoNSL6og@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Amanieu d'Antras" <amanieu@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 6:03 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 11:06 AM Amanieu d'Antras <amanieu@gmail.com> wrote:
> >
> > Setting bit 31 in x8 when performing a syscall will do the following:
> > - The remainder of x8 is treated as a compat syscall number and is used
> >   to index the compat syscall table.
> > - in_compat_syscall will return true for the duration of the syscall.
> > - VM allocations performed by the syscall will be located in the lower
> >   4G of the address space.
> > - Interrupted syscalls are properly restarted as compat syscalls.
> > - Seccomp will treats the syscall as having AUDIT_ARCH_ARM instead of
> >   AUDIT_ARCH_AARCH64. This affects the arch value seen by seccomp
> >   filters and reported by SIGSYS.
> > - PTRACE_GET_SYSCALL_INFO also treats the syscall as having
> >   AUDIT_ARCH_ARM. Recent versions of strace will correctly report the
> >   system call name and parameters when an AArch64 task mixes 32-bit and
> >   64-bit syscalls.
> >
> > Previously, setting bit 31 of the syscall number would always cause the
> > sygscall to return ENOSYS. This allows user programs to reliably detect
> > kernel support for compat syscall by trying a simple syscall such as
> > getpid.
> >
> > The AArch32-private compat syscalls (__ARM_NR_compat_*) are not exposed
> > through this interface. These syscalls do not make sense in the context
> > of an AArch64 task.
> >
> > Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> > Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
> > Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
>
> I'm still undecided about this approach. It is an easy way to expose the 32-bit
> ABIs, it mostly copies what x86-64 already does with 32-bit syscalls and
> it doesn't expose a lot of attack surface that isn't already exposed to normal
> 32-bit tasks running compat mode.
>
> On the other hand, exposing the entire aarch32 syscall set seems both
> too broad and not broad enough: Half of the system calls behave the
> exact same way in native and compat mode, so they wouldn't need to
> be exposed like this, a lot of others are trivially emulated in user space
> by calling the native versions. The syscalls that are actually hard to do
> such as ioctl() or the signal handling will work for aarch32 emulation, but
> they are still insufficient to correctly emulate other 32-bit architectures
> that have a slightly different ABI. This means the interface is a fairly good
> fit for Tango, but much less so for FEX.

You are correct here. This meshes perfectly for Tango's use case. Where
the syscalls will match perfectly for their aarch32->aarch64->compat syscall
path.

For FEX's use case, we still need to deal with any data structure that
doesn't match between the 32-bit x86 to compat syscall boundary. While
x86->compat will require significantly less fixups than x86->aarch64, it
is still likely to have some structure differences that need fixing.

>
> It's also worth pointing out that this approach has a few things in common
> with Yury's ilp32 tree at https://github.com/norov/linux/tree/ilp32-5.2
> Unlike the x86 x32 mode, that port however does not allow calling compat
> syscalls from normal 64-bit tasks but rather keys the syscall entry point
> off the executable format., which wouldn't work here. It also uses the
> asm-generic system call numbers instead of the arm32 syscall numbers.
>
> I assume you have already considered or tried the alternative approach of
> only adding a minimal set of syscalls that are needed for the emulation.
> Having a way to limit the address space for mmap() and similar
> system calls sounds like a generally useful addition, and having an
> extended variant of ioctl() that lets you pick the target ABI (arm32, x86-32,
> ...) on supported drivers would probably be better for FEX. Can you
> explain the tradeoffs that led you towards duplicating the syscall
> entry points instead?

I'm likely to not be very concise here. There are many paper cuts for
any route taken here.
For me, this one is the best route because of its ability to future proof
for any upcoming additions to syscalls.

If we were wanting to take a path of duplicating a bunch of compat
syscalls to work from the 64-bit side. We would first need to start with
around nine syscalls that are causing immediate problems.
mmap/mmap2, mremap, shmat, ioctl, recvmsg, recvmmsg, getdents,
and getdents64.
So we could carve those out, adding effectively the same memory
handling code that is being added here[1]. Do the ML dance to upstream.
We now have nine-ish syscalls that are added specifically for userspace
compatibility layers.
That's already beginning to have a bad smell.

Next step is a couple months down the line, someone adds a super cool
syscall that say, allocates memory that is secure over infiniband and flushes
to persistence on hibernate. Neato. Oops, this is allocating memory, and
since FEX is tracking very close to upstream kernel syscall support, we now
need to add yet another syscall that handles the compat version in a
64-bit space.
Or maybe it appends to a linked list of secure memory regions. Only visible as
the head of the list (Hello robust futexes).

See what I mean? Exposing the 32-bit compat syscalls removes the burden of
now needing to think about every syscall in a context of 32-bit,
64-bit, 32-bit on 64-bit.
Also removes the burden that I then need to come back and pester the ML
every single time with new patchsets adding syscalls only for compat layers.

And I'm all about removing unnecessary burden

[1]Side grade, personality flags won't be pretty here, FEX lives in a
mixed syscall world and doesn't want only one or the other working.
FEX does a bunch of stuff in the background and a personality flag
would be hard to work around whenever we need to do some
memory allocations, or file system handling, or its own 64-bit ioctl
handling. Just not very versatile.
FEX is already allocating all 48/52-bit VA, breaking ASLR and stack
growing, as a partial workaround here.

>
>          Arnd
