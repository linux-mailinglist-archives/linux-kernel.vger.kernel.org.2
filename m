Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE7387977
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349267AbhERNEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343843AbhERNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:04:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8CB46135F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621342999;
        bh=6aWbQ/cmw1NOJPbNf/djIc+7tBX7AnxmIUM2xlj60LQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ufU38bmU4ZPCTltFmLRTkmLUzDMs8CnZy1fB+6hoFm1ClmQ5BaNqT/kwq+zrxBdLS
         71Z96ovywdmQWZkNqMlh8/FrID2RWnYPvdxXRK9EF89Y5loqvrxvpjG3COxZLFgb3E
         YSZcg40ehttjazNjpBLOdT3+gHznbwIN/rSAX6J8stXF/3QuqxQlsKqjRuPmoa08Vl
         r7/IUGX36Ju0GbCio9mwObpLleNsl/e4OsB7++JjnoACbcMdqqoH5mdU4cvLbNn0o4
         1PgmvhjL/59pOjft/tvSV6CPm22mbPUvGsmjcvMauNvHJAwGCvJCKbcQOdjcBItoZd
         nu0xsXwBAj71w==
Received: by mail-wm1-f54.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1426168wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:03:19 -0700 (PDT)
X-Gm-Message-State: AOAM533BFxAO5GzzT1z2npkOZQF0dwr0OpwY5xD6y9msumZLJIcqS1Rf
        3qAZgTkcns2kYbLmOzz63lKIIx6QN6myjCrEZO8=
X-Google-Smtp-Source: ABdhPJwmP1BgISGTLbJ6gC20qTKXocj7E7RZ/f5ImNxLHvbohx7NzsEK7svNgmDtuV6Ft8TFTa73HK539GFv2KZkBLU=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4880112wmb.142.1621342998355;
 Tue, 18 May 2021 06:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
In-Reply-To: <20210518090658.9519-9-amanieu@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 15:02:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
Message-ID: <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     "Amanieu d'Antras" <amanieu@gmail.com>
Cc:     Ryan Houdek <Houdek.Ryan@fex-emu.org>,
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

On Tue, May 18, 2021 at 11:06 AM Amanieu d'Antras <amanieu@gmail.com> wrote:
>
> Setting bit 31 in x8 when performing a syscall will do the following:
> - The remainder of x8 is treated as a compat syscall number and is used
>   to index the compat syscall table.
> - in_compat_syscall will return true for the duration of the syscall.
> - VM allocations performed by the syscall will be located in the lower
>   4G of the address space.
> - Interrupted syscalls are properly restarted as compat syscalls.
> - Seccomp will treats the syscall as having AUDIT_ARCH_ARM instead of
>   AUDIT_ARCH_AARCH64. This affects the arch value seen by seccomp
>   filters and reported by SIGSYS.
> - PTRACE_GET_SYSCALL_INFO also treats the syscall as having
>   AUDIT_ARCH_ARM. Recent versions of strace will correctly report the
>   system call name and parameters when an AArch64 task mixes 32-bit and
>   64-bit syscalls.
>
> Previously, setting bit 31 of the syscall number would always cause the
> sygscall to return ENOSYS. This allows user programs to reliably detect
> kernel support for compat syscall by trying a simple syscall such as
> getpid.
>
> The AArch32-private compat syscalls (__ARM_NR_compat_*) are not exposed
> through this interface. These syscalls do not make sense in the context
> of an AArch64 task.
>
> Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
> Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>

I'm still undecided about this approach. It is an easy way to expose the 32-bit
ABIs, it mostly copies what x86-64 already does with 32-bit syscalls and
it doesn't expose a lot of attack surface that isn't already exposed to normal
32-bit tasks running compat mode.

On the other hand, exposing the entire aarch32 syscall set seems both
too broad and not broad enough: Half of the system calls behave the
exact same way in native and compat mode, so they wouldn't need to
be exposed like this, a lot of others are trivially emulated in user space
by calling the native versions. The syscalls that are actually hard to do
such as ioctl() or the signal handling will work for aarch32 emulation, but
they are still insufficient to correctly emulate other 32-bit architectures
that have a slightly different ABI. This means the interface is a fairly good
fit for Tango, but much less so for FEX.

It's also worth pointing out that this approach has a few things in common
with Yury's ilp32 tree at https://github.com/norov/linux/tree/ilp32-5.2
Unlike the x86 x32 mode, that port however does not allow calling compat
syscalls from normal 64-bit tasks but rather keys the syscall entry point
off the executable format., which wouldn't work here. It also uses the
asm-generic system call numbers instead of the arm32 syscall numbers.

I assume you have already considered or tried the alternative approach of
only adding a minimal set of syscalls that are needed for the emulation.
Having a way to limit the address space for mmap() and similar
system calls sounds like a generally useful addition, and having an
extended variant of ioctl() that lets you pick the target ABI (arm32, x86-32,
...) on supported drivers would probably be better for FEX. Can you
explain the tradeoffs that led you towards duplicating the syscall
entry points instead?

         Arnd
