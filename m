Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35031CFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBPSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBPSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:14:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B11C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:13:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b16so12989808lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZhgJDXN3qUlzI3D7+EIdLJ24tS4lcpyI6gPNIaOo8w=;
        b=ZBm5V3zJZ3UveJ7pDKj01FoqrULNre395se6yeQqMjkAJmfXyL8lWMkO4V0Q/J/1ay
         XIDmZTo2tRCP4/gs32dGZdrtLOscShzQS4Nr43MU0a4fALOLMfhDN2LKxzRVAHXmzx1G
         Y95yJwAb6MGA2WXBzA+Fgnic/iFp6+bWbJM691VxFkXKW5YDv0gzKQ3cb6qTonKTrU7k
         +gbdTusN4T/0bOI12CH+SpPKyOWxVYrAnyOpb3O2Ne3Y2TtnH60Y8fAPRnMureurY3eh
         Amapkw5QrxbJIBdwbimqe1+I/SWsotJGthHC+UXC1E4sR9nHDR0t3pxaKB3yN3H2kOW6
         VQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZhgJDXN3qUlzI3D7+EIdLJ24tS4lcpyI6gPNIaOo8w=;
        b=dhnhrhxMGb/XTCWqnhjK7PnorYF7XhCJlZQly3PRyfbFkpaWZy15dBuGonFQmGCKfI
         p/sDuGi6vOMbUzHtfejCmuX93ma17oCKJBV3jFaFXAywyfwqAuIzyfdj45mRJNybjBhY
         YjPQJXuTcjFut2SAoEWVtbe+DHrC6nlx+tP0MLNZqR0Z0cibZr9V5T8F2KsafK87su+e
         XhIiYPI/65prUBvVC2prNIpgfdc85uEVQ/uTsBqSKVsoG9UinfMAfckHfKRUU01Erh6Q
         iXOSli8OTg9Qct5V4ElgbcXxdOSSncqoD/agBGB21K/XZXHrahKkdMvw9uDk0ZMe9M77
         6jQw==
X-Gm-Message-State: AOAM532yG+grEO45MmXyKX2mW8jg0kFVsb40NVuAczIqk/9Z1q///fId
        EMbaXfsxc81ubhKZ2yHM1HD9EfJ+38eynp6Yy2Xv0w==
X-Google-Smtp-Source: ABdhPJxRzyUYDlbmLIRZ0vS/9VmDpwE+h93pZz4mct9lqg4Ah6CdB9Wu5RDqz9n3AnxyKGdJVH8b+ds+V7/M4U7wu7Y=
X-Received: by 2002:a05:651c:2112:: with SMTP id a18mr13153514ljq.341.1613499220885;
 Tue, 16 Feb 2021 10:13:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613243844.git.luto@kernel.org>
In-Reply-To: <cover.1613243844.git.luto@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Feb 2021 10:13:29 -0800
Message-ID: <CAKwvOdknXerBUV6aMhNC9y50kH3EQY+0s-aZ7Vvh8-tG8uR_wA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Clean up x86_32 stackprotector
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 11:19 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
> disables stackprotector on x86_32 on GCC 8.1 and on all clang
> versions.  Some clang people are cc'd.

When in doubt, check the MAINTAINERS entry for LLVM for our mailing
list and listed maintainers.

>
> Changes from v1:
>  - Changelog fixes.
>  - Comment fixes (mostly from Sean).
>  - Fix the !SMP case.
>
> Andy Lutomirski (2):
>   x86/stackprotector/32: Make the canary into a regular percpu variable
>   x86/entry/32: Remove leftover macros after stackprotector cleanups
>
>  arch/x86/Kconfig                          |  7 +-
>  arch/x86/Makefile                         |  8 ++
>  arch/x86/entry/entry_32.S                 | 95 +----------------------
>  arch/x86/include/asm/processor.h          | 15 +---
>  arch/x86/include/asm/ptrace.h             |  5 +-
>  arch/x86/include/asm/segment.h            | 30 ++-----
>  arch/x86/include/asm/stackprotector.h     | 79 ++++---------------
>  arch/x86/include/asm/suspend_32.h         |  6 +-
>  arch/x86/kernel/asm-offsets_32.c          |  5 --
>  arch/x86/kernel/cpu/common.c              |  5 +-
>  arch/x86/kernel/doublefault_32.c          |  4 +-
>  arch/x86/kernel/head_32.S                 | 18 +----
>  arch/x86/kernel/setup_percpu.c            |  1 -
>  arch/x86/kernel/tls.c                     |  8 +-
>  arch/x86/kvm/svm/svm.c                    | 10 +--
>  arch/x86/lib/insn-eval.c                  |  4 -
>  arch/x86/platform/pvh/head.S              | 14 ----
>  arch/x86/power/cpu.c                      |  6 +-
>  arch/x86/xen/enlighten_pv.c               |  1 -
>  scripts/gcc-x86_32-has-stack-protector.sh |  6 +-
>  20 files changed, 62 insertions(+), 265 deletions(-)
>
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
