Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F39305563
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhA0IQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhA0IM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:12:59 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 00:12:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id p5so1305405oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25W2kJLNwjwbRDxf2IsFRfKvZZi9bUbt8wUssI4fr4Y=;
        b=jw8d6qMiUfaPqQD4kaocGfMbezmyYGzNz2KHLPzEa8hMe756DtzSwz0wBMnSJx5PvH
         PVp7gS1VNbeCN4/gosx6DoPqS5m+vlgZ9QyMoNlFJHYKfkrfxixzBd7jFPzcHRmsA81w
         5noBZqA3DOKFGX6qOJfFTufgmgGu4i7Xz64tQeJiSPok95WaL32xensQpVg+odu6iW/j
         VynVzpLa1gaLDx3eKMWbfNMZ0BDZpvsQ7SrHQNaA4PlM3gosmovE0wLoigowqA96tYIw
         SL1GpR8bQaN1BDdM1QoLLP1ZrsircFxO+N7pQhA+FLOzfzrII1qxma5yk7mob+BCsdYb
         xqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25W2kJLNwjwbRDxf2IsFRfKvZZi9bUbt8wUssI4fr4Y=;
        b=EuPStsPc7jlVKx6I72GVNsa0wEJdeSE1oNGL5OTi9yjW/e2KG7d4ueDhY21uodZiTg
         +K8pYrZASlkScZCP2nxpVc94LryKZQVRo3aoC4WWQkhHXwbgODGtZJRIDOMbw/5SrrEa
         P67z+PNbvhrCbRtcvLllxGOmWDltSjd1FZpzJk5m8GQnrwQYUwFKfcA91Di5smff4EX/
         JOwSDOgzyBbum45FLR3zqnvev2x67J+/a3c6v9kVxrIYhtmeooHb+vyEsDlmAJo++jYk
         qmbGaPVBvapvH+iYRZTu/978RQ9svF8i3BFm1ATLifBm9PPklt2tmKIJpRn0d3wHhM7C
         zAhQ==
X-Gm-Message-State: AOAM532KRnQcRrlSEiuQDdyN5yG4FcEOhpCNpGmWJbrV+k6dcIu+Sueb
        aQTCh+SLv7a/xCFsxwgPkeWhuhgJxnBgWFD+XYEWKMs3BBM/cg==
X-Google-Smtp-Source: ABdhPJzMwCKXbA0OoGZ3+aicGxeuc19AbDEVx7LEelMZQmSqaYh5TE8wT+QW1C15EvnGb4MJj17SASAdeHzT/Q/8fac=
X-Received: by 2002:aca:31c1:: with SMTP id x184mr2383932oix.74.1611735138053;
 Wed, 27 Jan 2021 00:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20210119220637.494476-1-avagin@gmail.com>
In-Reply-To: <20210119220637.494476-1-avagin@gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 27 Jan 2021 00:10:30 -0800
Message-ID: <CANaxB-zwjDu5PSFJebeJe5zH94HC7mThOwyPYSjE4tkQ0zwvBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64/ptrace: allow to get all registers on syscall traps
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        keno@juliacomputing.com, dave.martin@arm.com
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@google.com>,
        Howard Zhang <howard.zhang@arm.com>,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 2:08 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> Right now, ip/r12 for AArch32 and x7 for AArch64 is used to indicate
> whether or not the stop has been signalled from syscall entry or syscall
> exit. This means that:
>
> - Any writes by the tracer to this register during the stop are
>   ignored/discarded.
>
> - The actual value of the register is not available during the stop,
>   so the tracer cannot save it and restore it later.
>
> This series introduces NT_ARM_PRSTATUS to get all registers and makes it
> possible to change ip/r12 and x7 registers when tracee is stopped in
> syscall traps.
>
> For applications like the user-mode Linux or gVisor, it is critical to
> have access to the full set of registers at any moment. For example,
> they need to change values of all registers to emulate rt_sigreturn and
> they need to have the full set of registers to build a signal frame.

I have found the thread [1] where Keno, Will, and Dave discussed the same
problem. If I understand this right, the problem was not fixed, because there
were no users who needed it.

gVisor is a general-purpose sandbox to run untrusted workloads. It has a
platform interface that is responsible for syscall interception, context
switching, and managing process address spaces. Right now, we have kvm and
ptrace platforms. The ptrace platform runs a guest code in the context of stub
processes and intercepts syscalls with help of PTRACE_SYSEMU. All system calls
are handled by the gVisor kernel including rt_sigreturn and execve. Signal
handling is happing inside the gVisor kernel too. Each stub process can have
more than one thread, but we don't bind guest threads to stub threads and we
can run more than one guest thread in the context of one stub thread. Taking
into account all these facts, we need to have access to all registers at any
moment when a stub thread has been stopped.

We were able to introduce the workaround [3] for this issue. Each time when a
stub process is stopped on a system call, we queue a fake signal and resume a
process to stop it on the signal. It works, but we need to do extra interaction
with a stub process what is expensive. My benchmarks show that this workaround
slows down syscalls in gVisor for more than 50%. BTW: it is one of the major
reasons why PTRACE_SYSEMU was introduced instead of emulating it via
two calls of PTRACE_SYSCALL.


[1] https://lore.kernel.org/lkml/CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com/#r
[2] https://github.com/google/gvisor/issues/5238
[3] https://github.com/google/gvisor/commit/a44efaab6d4b815880749a39647fb3ed9634a489

>
> Andrei Vagin (3):
>   arm64/ptrace: don't clobber task registers on syscall entry/exit traps
>   arm64/ptrace: introduce NT_ARM_PRSTATUS to get a full set of registers
>   selftest/arm64/ptrace: add a test for NT_ARM_PRSTATUS
>
>  arch/arm64/include/asm/ptrace.h               |   5 +
>  arch/arm64/kernel/ptrace.c                    | 130 +++++++++++-----
>  include/uapi/linux/elf.h                      |   1 +
>  tools/testing/selftests/arm64/Makefile        |   2 +-
>  tools/testing/selftests/arm64/ptrace/Makefile |   6 +
>  .../arm64/ptrace/ptrace_syscall_regs_test.c   | 142 ++++++++++++++++++
>  6 files changed, 246 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
>  create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
>
> --
> 2.29.2
>
