Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8D31ADCA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 20:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBMTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 14:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBMTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 14:34:19 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF08C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 11:33:39 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d20so2321015ilo.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3Z2f5M1oWl6Ax7p7CpNaAL+WfzFzmC6OAVotzJGMVDI=;
        b=uGB/Il/48lj049pcFAgL8gma1bnbMpVFN428zMdPFr1U8FP1om7w7PbG4HrLdOYCiC
         DlmsytBbLWNqDs7F5BJopXJL4QSvCr8AMja4yqpdlsmAypPgO7l8OjsEDJRTKyD8vcd3
         DsblPgd1Gl3w11lpLNbY8E0AIlSa/ag2ilLw8U3T5Dk9rsLWT0gNQff3J8Rgt+wWRwLl
         IxkybkajJYhAtlFNsDDQwAHMi35Tlo1HN3x7tekhYNB4f4qpctPlzlU9SPQ30CyyG6Ki
         WMnnJcNnuQlIHZEP3fyOpEbkLnY4pFK9gXWE9XL631ONWpcwtfNaEqVIC8Xl0RSwYuYq
         2+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3Z2f5M1oWl6Ax7p7CpNaAL+WfzFzmC6OAVotzJGMVDI=;
        b=f2PYU6z5K9AZ+QXAE/L05Xk5piU7ukOScGH6rMEnYIuLmtop8/Djba+rCq5nS2bf91
         slPd227bCN/YUuvejfiABSAD2ugWJ2WRW97PlHSU/A5W1ygYp/0G7wr9W1QDb7kUb9OQ
         N3HP6ZPtet2de8YPuNhL890lxvUjPpgcgNfAYRIrQcEaZOW5f2sKqezNVNAY1kxIPAhB
         y7Ukvt937iV0ALtw8q7GSEeVdKRcx9syW4EDZa7tp+IiqbFKJFke2YCr8ANdrV1WsPxv
         cKhO5yRx/S1/mtKdlVDHsG1w8yCMNSprrhB9Dmc6Zc62LzZkClmGXwIjhm+lDRShidyy
         veQw==
X-Gm-Message-State: AOAM531+LfERJf7/t3LLbNDGdWfo6H7bYegTDHoIuUqoG6O1k8qJg05T
        RifYdfarfufc5mNEDykZ8j5fqgN9Xkx/ay9RxP4=
X-Google-Smtp-Source: ABdhPJwt0gME5KRiRK+XCCSp+brLUGrqmiAlbUO9mGM0KR/jLiFPNkbSEjpvwazut+igzIjgyP6d1zzjOFY5QvB9Vj4=
X-Received: by 2002:a92:d8c5:: with SMTP id l5mr7370379ilo.209.1613244818740;
 Sat, 13 Feb 2021 11:33:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613243844.git.luto@kernel.org>
In-Reply-To: <cover.1613243844.git.luto@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Feb 2021 20:33:27 +0100
Message-ID: <CA+icZUUHu6Qm_xNyXdumi0WjGZn1NQt8CSj=pkh4-2qLxg-n7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Clean up x86_32 stackprotector
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 8:19 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
> disables stackprotector on x86_32 on GCC 8.1 and on all clang
> versions.  Some clang people are cc'd.
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

Thanks Andy for bringing this up as v2.

AFAICS, LLVM bug #47479 was involved here (see [1]).
Maybe Nick can say some words.

After patching my LLVM toolchain I decided to drop this and integrated
the (kernel-side) diff from Nick (see [1]) in my custom patch-series.

Is this your x86/unify_stack_canary Git branch (see [2])?

- Sedat -

[1] https://bugs.llvm.org/show_bug.cgi?id=47479
[2] https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/unify_stack_canary

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
