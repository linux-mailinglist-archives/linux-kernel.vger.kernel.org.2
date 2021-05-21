Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D593138CE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhEUTUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhEUTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:20:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:19:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s6so24442797edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0bOSvQvIFoNvuO08SOXCaee1LAs7SSvjM47STchOkk=;
        b=WAEzSBCnxT/1BObN8G+M1p7trniZRWUzovbAuER9lI+APkD3WYl8njHOV/oXKOxw3v
         0lB64Ddw4sJEzRgVDXDMlb7dD2kb6SYtLv3aE6gWzYJKDQD8vlzOHQ3oR+kq8M20bMYe
         1DFpsArMo4hjTgYaR2rqa0Z2WZ5z/uOhNsqa+XtZGW7n9hEHOKZhC3uizie/oWSSE+fX
         9RjZAXPcYoRDHHd7shIiGCqGsicxzGh0pHIcxPLfBGxRCX+PDTJyn3oOWnKdia77gdyC
         oIocvnVDfp0VxvUZo0sQJ+EMkvXt5A1cYaZzKYpDoNXrncDGlTznW9IQ1uLB4yiUjnGF
         hKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0bOSvQvIFoNvuO08SOXCaee1LAs7SSvjM47STchOkk=;
        b=EHxET+5ihuX+wgkp8dsvVSurWV5zQTzce4eUbwJe3AKICL8U23eP9Y0gmqJ+0L88f3
         Pt1bPYfZa5t82VvjT8SFZ9zW+s4Rzfl8HvcB1Yui3T/Y3G0+tqrRh1nTfEaVFSkoUMjL
         c9huZlFe5rkj2rYAQXdBiS33g1XJBSL5jPeC7K9VOxIUa+DwaCVe+LY7AItX7YAm6Fsr
         o02fvZdMydBl45sBZyX9FMzR/rG7I31ohIXiOtvf9P9Pwm1Dj+YtPsZkKGv232V2HwYl
         RMgDvHavnpySHb0bMRxPnRSWaUyoLxupPMqX2YQro7i37QoeRWVZKUrdNT2ClCeUpZC3
         TCWw==
X-Gm-Message-State: AOAM532jgHBfxw6jHBQP1rC9njnQTrAJpJOhCzieGc1Yz5CznNNhkbdU
        zRrWvYIL6SHocdG0E3Qw9kHnh7gmVywEYpBL/JBl2MTgQegHTCrK
X-Google-Smtp-Source: ABdhPJxy/tsOlhxVkaev+BLzhjxfSBrGKeHQy2re7EosrmSkiZQ/auNR0gOHbYIynQVu4ilnreNrudnMgRqMkD8Z2S8=
X-Received: by 2002:aa7:d893:: with SMTP id u19mr13027947edq.258.1621624742282;
 Fri, 21 May 2021 12:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
 <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com>
 <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com> <CA+y5pbRwgpctUOBzzscT9XMN9LM2qraPNg6K6onFcpQaaFDYkQ@mail.gmail.com>
 <1c2bd27a-1c96-f154-ed18-f33630b109b1@arm.com>
In-Reply-To: <1c2bd27a-1c96-f154-ed18-f33630b109b1@arm.com>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Fri, 21 May 2021 20:18:25 +0100
Message-ID: <CA+y5pbSbky2kS+O5j9bn57nROdYaYeHcd2R-46X1cc388PKOvg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     Steven Price <steven.price@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:51 AM Steven Price <steven.price@arm.com> wrote:
> >> In those cases to correctly emulate seccomp, isn't Tango is going to
> >> have to implement the seccomp filter in user space?
> >
> > I have not implemented user-mode seccomp emulation because it can
> > trivially be bypassed by spawning a 64-bit child process which runs
> > outside Tango. Even when spawning another translated process, the
> > user-mode filter will not be preserved across an execve.
>
> Clearly if you have user-mode seccomp emulation then you'd hook execve
> and either install the real BPF filter (if spawning a 64 bit child
> outside Tango) or ensure that the user-mode emulation is passed on to
> the child (if running within Tango).

Spawning another process is just an example. Fundamentally, Tango is
not intended or designed to be a sandbox around the 32-bit code. For
example, many of the newer ioctls use u64 instead of a pointer type to
avoid the need for a compat_ioctl handler. This means that such ioctls
could be abused to read/write any address in the process address
space, including the code that is performing the usermode seccomp
emulation.

> You already have a potential 'issue' here of a 64 bit process setting up
> a seccomp filter and then execve()ing a 32 bit (Tango'd) process. The
> set of syscalls needed for the system which supports AArch32 natively is
> going to be different from the syscalls needed for Tango. (Fundamentally
> this is a major limitation with the whole seccomp syscall filtering
> approach).

The specific example I had in mind here is Android which installs a
global seccomp filter on the zygote process from which app processes
are forked from. This filter is designed for mixed arm32/arm64 systems
and therefore has syscall whitelists for both AArch32 and AArch64.
This filter allows 32-bit processes to spawn 64-bit processes and
vice-versa: for example, many 32-bit apps will invoke another 32-bit
executable via system() which uses a 64-bit /system/bin/sh.

> >> I guess the question comes down to how big a hole is
> >> syscall_in_tango_whitelist() - if Tango only requires a small set of
> >> syscalls then there is still some security benefit, but otherwise this
> >> doesn't seem like a particularly big benefit considering you're already
> >> going to need the BPF infrastructure in user space.
> >
> > Currently Tango only whitelists ~50 syscalls, which is small enough to
> > provide security benefits and definitely better than not supporting
> > seccomp at all.
>
> Agreed, and I don't want to imply that this approach is necessarily
> wrong. But given that the approach of getting the kernel to do the
> compat syscall filtering is not perfect, I'm not sure in itself it's a
> great justification for needing the kernel to support all the compat
> syscalls.

I feel that exposing all compat syscalls to 64-bit processes is better
than the alternative of only exposing a subset of them. Of the top of
my head I can think of quite a few compat syscalls that cannot be
fully emulated in userspace and would need to be exposed in the
kernel:
- mmap/mremap/shmat/io_setup: anything that allocates VM space needs
to return a pointer in the low 4GB.
- ioctl: too many variants to reasonably maintain a separate compat
layer in userspace.
- getdents/lseek: ext4 uses 32-bit directory offsets for 32-bit processes.
- get_robust_list/set_robust_list: different in-memory ABI for
32/64-bit processes.
- open: don't force O_LARGEFILE for 32-bit processes.
- io_uring_create: different in-memory ABI for 32/64-bit processes.
- (and possibly many others)

Also consider the churn involved when adding a new syscall which
behaves differently in compat processes: rather than just using
in_compat_syscall() or wiring up a COMPAT_SYSCALL_DEFINE, a compat
variant of this syscall would also need to be added to the 64-bit
syscall table to support translation layers like Tango and FEX.

> One other thought: I suspect in practise there aren't actually many
> variations in the BPF programs used with seccomp. It may well be quite
> possible to convert the 32-bit syscall filtering programs to filter the
> equivalent 64-bit syscalls that Tango would use. Sadly this would be
> fragile if a program used a BPF program which didn't follow the "normal"
> pattern.

This might work for simple filters that only look at the syscall
number, but becomes much harder when the filter also inspects the
syscall arguments.
