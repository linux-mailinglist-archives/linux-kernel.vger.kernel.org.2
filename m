Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DD388355
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhERXw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhERXw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:52:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E7C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:51:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k14so13746989eji.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IjcznopF00s42V62Q4DwQxE1WnpZq8FmdwRVPdjvEo=;
        b=WsZ+Fm5yv2oDq/u/6I23ZY7ycwVDxzauC8u6hdwmDloiTD9btCT7WdP5Um49pACXzz
         def+9JyxT9WDprDCjenPCmRVujwLW4W4cc2ekw+MUm9VTY0QcmzDe1Bn7aOXqp7XqKQ8
         l9or71ngl29KIuq0S8Po6jTdtv9I+lcdvmcjrnR3Wb19953aqyhnuN+dVjfAIomlNtXH
         GKNnSO50O+l55QkeQErBsO8Bj7P+5SQM8vBd1rVB2dIyD2u9WTCNolJ+YOSw5zEg4hCv
         i/iUNBpRQ9Oprw+5Xd3q+4x9ifoF4T7bJKzFtaODZxmTNotm8xFs4afcxbC6m5jLcQOi
         8KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IjcznopF00s42V62Q4DwQxE1WnpZq8FmdwRVPdjvEo=;
        b=Nz3yeEZvUSbLCG6oCoba0ywteoqqnP0WnbCns76aXoo4dKR/dvQoEA4jPdvdm6YAvF
         Ajlp08vDSVZX3c7RMEiuPQq5boYQ8yTfVitJwPLydvClDkHk5KFJmFI0XqP/tinRnLAz
         IskDyEoblIcClUcBVlBdFM2dhG9gCktxahY2OJQ5g2KTwkWOfI0pTZbpx1xY2RKz1m2+
         5ujs6wr1jzg01aku6QpsKk519RTERNzHr5KjxvAn4x3fXlVlu72Pra9ycl6rdP+Y/obr
         Cxhp9fdQkqv0U5Y0urWxutsvrA0yFbm3qDjs56GITs5xfXzz2Vs2se36zp99TnAlwMwf
         LE8g==
X-Gm-Message-State: AOAM530P/aZPGH3WQ+JFYx4ea5Mz9nAlfN3rJ6IT6d0Ei9CHZ7h9sGJP
        Wnd83f6yRZlfqOgGLAmo8myDQ/FPZl2O+2Ec/qc=
X-Google-Smtp-Source: ABdhPJw9zyvsAtZH0Fu9ekeObuTogb3dy2yR6SuMVoj7iWZLNLuwyLlvErUT73Mn6WUb+u1TMlMyiZfDohsWqJD07jA=
X-Received: by 2002:a17:906:17ca:: with SMTP id u10mr8517332eje.124.1621381896332;
 Tue, 18 May 2021 16:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
In-Reply-To: <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Wed, 19 May 2021 00:51:00 +0100
Message-ID: <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     Arnd Bergmann <arnd@kernel.org>
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

On Tue, May 18, 2021 at 2:03 PM Arnd Bergmann <arnd@kernel.org> wrote:
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

Tango needs the entire compat ABI to be exposed to support seccomp for
translated AArch32 processes. Here's how this works:

1. When a translated process installs a seccomp filter, Tango injects
a prefix into the seccomp program which effectively does:
    if (arch == AUDIT_ARCH_AARCH64) {
        // 64-bit syscalls used by Tango for internal operations
        if (syscall_in_tango_whitelist(nr))
            return SECCOMP_RET_ALLOW;
    }
    // continue to user-supplied seccomp program

2. When Tango performs a 32-bit syscall on behalf of the translated
process, the seccomp filter will see a syscall with AUDIT_ARCH_ARM and
the compat syscall number. This allows the user-supplied seccomp
filter to behave exactly as if it was running in a native AArch32
process.
