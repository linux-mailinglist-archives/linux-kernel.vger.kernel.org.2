Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9943064B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhA0UCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhA0UBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:01:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:00:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id c132so2322027pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBdA7Nf3DvwxZdzX00Eonq9lYvdJAq2LlEJMLWdaFgQ=;
        b=V8QOj+Q+1fHQ1H36xr+mUp/WLDS2EcuSMZmc3AhtOrMAlBC08U5jBNgEgdLpDfKk22
         jDomIQbrzVEPkpuY4r0FDcuKPa71M2VwQ5mVu56lFvAabiAabf3SFJ30yV20/zie+UtP
         ThS07AmNNrFpW9WPjRKVsZ+zXRV+dnQZ876CLYA8CzLOTrj/Sh12NQLdOoKN6Da1Moj1
         tJlY2axMIQUOOG25y0uKnFzIp9Gz5jBdPvLN4+EzuTihFe220dYgPBKobx+VI0C3eduj
         FiwkkFxMpNbjAEYGZZFmWoUUbk8p2pE1uzpa5N0nBIzAfjxu8mJJlQwZhk5G196DdQ+g
         f/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBdA7Nf3DvwxZdzX00Eonq9lYvdJAq2LlEJMLWdaFgQ=;
        b=sciZ1VcyWGPnwHPWw785nueDQ49cRU20TXXdnJnxt3qaUzZZIjCfBFH3c+3WkBTo7M
         jPZbHR3+IAsjKCh0H0j6W3RrwkYEb6bpSIr3RfCWaGvzkfmyEeSsqVNftfysIr4RyZE+
         gNkn2HBm9DmMgL1pIUhKwI5tSDkmvVQQz85G+cvEl9oxqCEyD9OIGxC3n++qf+v6Czdg
         fLoeVZRraw7V6eH/aKm5dPMw43yWzE0dbiplmeh6EqXu6kLrKroPMSEcQBO/+cqH5MLt
         c4hwMYM6k7c47rIXwRZIQA62hZH8boNZHgQdhm9vt9ShNKJsxFq26GHqpN7L0hXG8xjF
         QEEg==
X-Gm-Message-State: AOAM533yWAz4BiguVWs2oDw/RIfTb5PrYetVV+WjWV6jfalaGMDoRwu0
        emV7mmEEWOk2/zmGxEaBNS7PsczLaPFd/rIVyHeAiw==
X-Google-Smtp-Source: ABdhPJwWsCylpOTXaqGgHO65KypzzRkHx0ONCfMqo85qSNqnMB6z0xpBZYv3zD7Rba2abGuLqVWa1DFPdbHH4ELjGsY=
X-Received: by 2002:a05:6a00:1:b029:1c1:2d5f:dc16 with SMTP id
 h1-20020a056a000001b02901c12d5fdc16mr12176024pfk.55.1611777628828; Wed, 27
 Jan 2021 12:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210126134603.49759-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 21:00:17 +0100
Message-ID: <CAAeHK+xTWrdJ2as6kBLX+z64iu3e6JEGppOkN-i_jsH74c6xoA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:46 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
>
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
>
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
>
> The series is based on linux-next/akpm.
>
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
>
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Evgenii Stepanov <eugenis@google.com>
> Cc: Branislav Rankov <Branislav.Rankov@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Tested-by: Andrey Konovalov <andreyknvl@google.com>

> Vincenzo Frascino (4):
>   arm64: mte: Add asynchronous mode support
>   kasan: Add KASAN mode kernel parameter
>   kasan: Add report for async mode
>   arm64: mte: Enable async tag check fault

Andrew, could you pick this up into mm? The whole series will need to
go through mm due to dependencies on the patches that are already
there.
