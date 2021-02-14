Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4C31B0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBNOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 09:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBNOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 09:43:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AEBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 06:42:53 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q7so4313006iob.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9wPjYm6KxTX2zA0MH0f3YcudN64OMfQGI54X5pgP9Fo=;
        b=sj/et1DRuCHieziSQrAaf9mTgilPpc8iOKZn+7L0jzpjbkjyuh7MYkzj+eYcdbxXA3
         5oU9dGzGbLBe7oQoKWf99aRJUZ1DoJzr7gfeFXbZPE6rsPsf3jBCjoHaNO1DWvoJREPt
         nvXvK15UccF93OH2xU79IyxDCMoRbc5pJQFswTONuTmdLnw2LAnx484z2cBHnD0eTbmw
         0F012eu5Nr7HTp9pWNOKH95z49JBAnn5U5qwvof56yZNwIQ+zoqIhiIS1AUlgRUoae5a
         I2R6Fmnl9QNRqFpyLQ6EMaDWt4owNad0f/ENiLCqQcyecKi58r1LrxcDHA3FkPIAjMcI
         ZUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9wPjYm6KxTX2zA0MH0f3YcudN64OMfQGI54X5pgP9Fo=;
        b=TeuRINF02pYnzLUs5m0aMc1cSyaV1S+fpplGqzCrs3dQtfJ1TAIK4oTRuDaAZFXEEl
         iGDAkl34O2w/IFiu/CI1ZvWtRFPn4cb6eDkf8FxzKVJ0k0ROAQQKbcKTRMyCnEYXGQTC
         subyu9YSKx+edSDz/Jq3OIgynHPUppp7laYiaYunJ+1PpgR9tUKUiNZkc2ymZTnsVjfb
         +Iw+xcv5+JgAoHFapU8ITT9NgeAib+7sC/PcUFRTrQK+Dgsb0Q93hO1GmyzU/93WRwHD
         CLxvsYhjz57rLpHBNekACY96GsNg9hCtzv85KT5vj0rd0A1naVdz520pJEvmOktURPg/
         5W7A==
X-Gm-Message-State: AOAM530Wvg20i0hitzCzjZCjvPVIlncItGAnb4FIDcJiIqqEOj37Qkm+
        fuGk6HmJ0TdC5bEZ/lp4XbxPUxLZvRCZtJxt6nU=
X-Google-Smtp-Source: ABdhPJyPhvVozKgQAf3Dr1EutSFk3jAhzXePl0UEvwIz6Zc6cHKaPMYi8qMCaxfKPMKWCVc3QYNt7OguHA2GYSlv5kE=
X-Received: by 2002:a05:6638:2694:: with SMTP id o20mr11523155jat.132.1613313773262;
 Sun, 14 Feb 2021 06:42:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613243844.git.luto@kernel.org>
In-Reply-To: <cover.1613243844.git.luto@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 14 Feb 2021 15:42:44 +0100
Message-ID: <CA+icZUUHA2png81GGM=75+i_6JBGfoNyX54uSWiw5RY1txLtag@mail.gmail.com>
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

Happy Valentine's Day,

I have no rose or pralines for you, Andy :-).

First, I tried to apply your patchset on top of <tip.git#autolatest>
which has shown some conflicts.
AFAICS it conflicts with <tip.git#x86/entry> (or more precisely with
the recent "Merge branch 'x86/paravirt' into x86/entry").
Just wanna let you know.

I have tested this on Debian/testing AMD64 (x86 64bit) with LLVM/Clang
v12.0.0-rc1 and my custom patchset.
Means compile-tested and booted into bare metal and checked build-log
and dmesg-log for warnings.
So far nothing scary.

Feel free to give credits like a Tested-by if you like.
( Roses and pralines are welcome, too, hahaha :-). )

Icecold and sunshiny Greetings from North-West Germany,
- Sedat -

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
