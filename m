Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAB31A2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBLQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBLQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:26:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C37C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:25:13 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lg21so169071ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xglaiz3RgqkqB4TANC557gBJSWXWE3yrMwKM30qFOAs=;
        b=QDsRGe8MSE8/YNwDNW+EfTuN8zzLT0ruXkRF324meNmQ7xMwZrYfrjQLLKk4gML1f7
         8EpjFxLipLzo1105Nu/oBwe6cbZtdF1rsrQkEFN5l2gTbNdrlevyFzseMBVOwuIBYLy9
         9rRuA2KXSJ0GUEtW0SzcWQEJZdL0WwYs88bR/etW4d4NrQpOqQCY4tlbvoZuEy8cGblB
         H6mI6LwMs9j6k5qT3DYSfme/ERuqSYmaYRgI3WklAJmU0Yhfe4tFmFCELLisQgloPjO6
         uMYqZnt/5avMJWL0sauaK4+E+9Z1qR1hBms00iiu+kIuwHjJD1YPNhvRsCotCZg86E39
         xL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xglaiz3RgqkqB4TANC557gBJSWXWE3yrMwKM30qFOAs=;
        b=JdAKzwB6mimyIJLXAH7fEDVke5xWBuuAj6EhC46ptI34Zheo2mobh7x4q9jR5oUDgm
         CREmfCS0wOg2dCrqOTg+7EbaYTbl6/C1xNSlFXrpaQ2N+ZLtaue1oSxR/rpoFOzNJVpm
         Vn5Tb2UVU5HEcHCFHiGSVXL7dPj8XrO+wJ7+Hzr59+Q4e1l5KCt0Joaww69+UlGze+CP
         +kI3EcRI20pau30Zc/HvlLC0pQR+z83y5I6OS42PCE4a7bHHHRaU8kfmO88G8cHtiX2w
         RDd4BDoWuwP20OVHo0HuMDTnGKUfQzhubscTldu+fAln9mDGpyHBnjxs+J9M+bppEjFz
         Vccw==
X-Gm-Message-State: AOAM531ABnfpUPBfevZGlt7uLa1jfCeaNAGVGyUAFHsx2tl2QglmEUfP
        hJoExITQ3OGwH7BTrfWczP5V8JX8T6foskuKkck=
X-Google-Smtp-Source: ABdhPJxMMOf//mx+h5hn1SlfuFSTE4AKMZwsBU1tGCqMAQ49CqDlC/B3oQUAUa5kjW1gpkhmeFWBChSAVe/tPMaIWyM=
X-Received: by 2002:a17:906:c34d:: with SMTP id ci13mr3781061ejb.333.1613147111977;
 Fri, 12 Feb 2021 08:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com> <20210212123515.GC6057@sirena.org.uk>
 <20210212132807.GC7718@arm.com>
In-Reply-To: <20210212132807.GC7718@arm.com>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Fri, 12 Feb 2021 16:24:35 +0000
Message-ID: <CA+y5pbTOZF9NgHdf0yG2d6GmPGqyyX400j0c=D8669WfWvk4SQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Steven Price <steven.price@arm.com>, sonicadvance1@gmail.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 1:28 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> The only downside I think is that for some syscalls it's not that
> efficient. Those using struct iovec come to mind, qemu probably
> duplicates the user structures, having to copy them in both directions
> (well, the kernel compat layer does something similar).
>
> Anyway, I'm not in favour of this patch. Those binary translation tools
> need to explore the user-only options first and come up with some perf
> numbers to justify the proposal.

I'd like to elaborate Tango's point of view on this problem.

Quick recap: Tango allows AArch32 programs to run on AArch64 CPUs that
don't support 32-bit mode. The primary use case is supporting 32-bit
Android apps, which means that Tango needs to be able to support the
full set of syscalls used on Android, including interfacing with many
drivers that are not in the mainline kernel. The patch proposed by
Ryan is based on the kernel patch used by Tango which can be found
here: https://github.com/Amanieu/linux/tree/tango-v5.4

Efficiency is not the concern here: copying/rearranging some bytes is
tiny compared to the cost of a syscall. The main concern is
correctness: there are many cases where userspace does not have the
information or the capabilities needed to ensure that the 32-bit
syscall ABI is correctly emulated.

There are two distinct parts to this: compat syscall emulation and
mmap address selection. I will address each separately.

Part 1: Compat syscall emulation

Even with this patch, Tango doesn't just pass 32-bit syscall through
to the kernel directly. We have ~5000 lines of code dealing with
various details such as memory management, signal handling, /proc
emulation, ptrace emulation, etc. However once this is done, Tango
will pass the syscall through to the kernel as a 32-bit compat syscall
instead of as a 64-bit syscall.

Here are several issues, off the top of my head, which are impossible
or impractical to support in user-mode:
- As mentioned before, there are a huge number of ioctls which behave
differently in 32-bit mode. It is impractical and error prone to
manually emulate them all in user mode. Specifically, the kernel
already has a well-tested and reliable compatibility layer and it
makes sense to reuse this. QEMU supports emulating some ioctls in
userspace but this still does not cover devices like GPUs which are
needed for accelerated rendering.
- The 64-bit set_robust_list is not compatible with the 32-bit ABI.
The compat version of set_robust_list must be used. Emulating this in
user mode is not reliable since SIGKILL cannot be caught.
- io_uring uses iovec structures as part of its API, which have
different sizes on 32-bit and 64-bit. This makes io_uring unusable
- ext4 represents positions in directories as a 64-bit hash, which
break if they are truncated to 32 bits. There is special support for
32-bit off_t in the ext4 driver but this is only used when
in_compat_syscall is true. QEMU also suffers from this problem:
https://bugzilla.kernel.org/show_bug.cgi?id=205957

Additionally, for Tango we want 32-bit programs to be able to use
seccomp filters, which is required by the Android CTS. Tango
intercepts seccomp filter installation and inserts a prefix which
whitelists 64-bit syscalls used internally by Tango and passes the
rest through to the user seccomp filter. For this to work, the kernel
must report 32-bit syscalls from 64-bit processes as AUDIT_ARCH_ARM
with the compat syscall number.

These issues are all solved by exposing compat syscalls to 64-bit
processes and ensuring is_compat_task/in_compat_syscall is true for
the duration of that syscall. There is a precedent for this: on x86,
syscalls made with int 0x80 are treated as 32-bit syscalls even if
they come from a 64-bit process.

Aside from seccomp support, this also solves FEX's concerns for
x86-to-AArch64 translation. There are of course some structures with
architecture-specific differences (e.g. epoll, stat, statfs) which
have to be translated manually in userspace, but the vast majority of
the ABI differences are simply due to 32/64-bit differences which
apply to all architectures.

Part 2: mmap address range

A binary translator such as FEX or Tango generally splits the address
space into two parts: the lower 4GB are reserved for the use of the
32-bit process and the rest of the address space is for the
translator's internal use (e.g. JIT cache). It is important that any
VM regions allocated through syscalls by the translated application be
located in the lower 4GB.

QEMU reserves 4G of address space with PROT_NONE and maps chunks out
of it for the application with MAP_FIXED as needed. However this
doesn't work for all cases:
- The io_setup syscall allocates a VM area for the AIO context and
returns it. But there is no way to control where this context is
allocated so it will almost always end up above the 4GB limit.
- Some ioctls will also perform VM allocations, with the same issues
as io_setup. Search for "vm_mmap" in drivers/.
- Some file descriptors have alignment requirements which are not
known to userspace. For example, a hugetlbfs file can only be mmaped
at a huge page alignment but there is no way for userspace to know
this when selecting an address.
- The Mali kbase out-of-tree driver outright forbids MAP_FIXED when
mapping GPU memory and insists on selecting a properly aligned address
itself.
- shmat and shmdt are particularly difficult to emulate since the
length of the mapping is not passed in as a parameter. They also
suffer from race conditions since shmdt leaves a gap in the 4GB
reserved space which could be filled in by a concurrent mmap
operation.

The solution proposed in this patch is to use a separate mmap_base
when a compat syscall is being executed by a 64-bit process. This
mmap_base is separately randomized on process startup so that
translated processes benefit from the additional security. All VM
allocations performed by 32-bit-under-64-bit syscalls will be done in
the low 4GB using this new mmap_base, while 64-bit syscalls used by
the translator continue to use the original mmap_base.

A possible alternative approach would be to use a prctl to restrict
the mmap range of the process and allow the translator to manually
specify its mmap_base. Any allocations that the translator needs to
perform above 4GB would then need to be done with MAP_FIXED, which is
workable albeit slightly inconvenient. The main advantage of this
alternative is that it is not tied to compat syscalls.

An extension to mmap which allows a custom address range to be
specified does *not* solve all of the issues listed above, which
primarily come from VM allocations performed by syscalls other than
mmap.
