Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB531ADBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBMTUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBMTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 14:20:04 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E40C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 11:19:24 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o15so2289993ilt.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UHr0V2pEeNmhieOwBwecUglE7wnegkRieoaAKsSRabU=;
        b=M5KHPRkMMJckXl3Q0wiXCj8V+EQdrZ/zInGaqvqS2e2mSawE1PYFm4lCLkLNTqLDfr
         uRIV2n+uEpFZXGwg4bmdHIK4hwpifPR6BdRe96D+aTiBJT8yozcCPpl+RC/QIuQs4Gku
         Ipx0BGXK/n7T17g57B2Q4QSkaeJtVgImmSOnlriBl1jG8VA7vXMWpPXG1ufH8wYvZ9wT
         dhcFEOda9p8Gr2LRExPtbhr227N/9UaEm/UQjbcwYC7Q0I923cvIVrJgNKCwtsAFF7+l
         f5DKyADIJ+KyDLDak4Lrcs1kTv7mPgtbxvkGKTkulhIO3ePqrPmwAiP8T1Sw6xVjd6On
         pmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UHr0V2pEeNmhieOwBwecUglE7wnegkRieoaAKsSRabU=;
        b=tIHi2YzMb65zgiDHnDm8VnQob9x8sWH/qLYC+zqF70QeWag6l5e0saGRj8DXBA1C6X
         5ihOauYE4T/b6Dm91ySkC+62sIy2Owf5Y4QlU9NFUK4qHgnm9vWNjFhycWngN1NCejDG
         AtJix00aFGX7riPB1bKNxIH47ErZnpGL/teulGN/BAWn8BLHtc0Da0OXRPrYwWHZOfns
         AxuZX2dyxuZSfWFyaMGpm5bpf5K/HrNf/hP4qO8QWtRW/8wJMj20HRnLFuusBdbDgeok
         X1bRJceOolVRknaSnmbQb6Fm5jK7QxKOUhY8KzWmJ3agCDZjojJriZGScgyTSSRcUvOJ
         I4QQ==
X-Gm-Message-State: AOAM531VmHYbnxX2sqlVIqVRZa3zzf2dvCpxcfDlNtn30F27lNyoq5zp
        bTYjvHPO38IkIVB48s6sRMCQNkswXLZHa/9TJp2tEp1+Q5TzLQ==
X-Google-Smtp-Source: ABdhPJy+oIeUjK60BpRIaON9DX/zul5GY52TB7KXxIgi3fDPFEbcgbiCw+8j7oSuikUV+Vu+wfZxaJLttk+wR34HCL0=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr7441756ilr.10.1613243964394;
 Sat, 13 Feb 2021 11:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20210208214327.65287-1-sedat.dilek@gmail.com> <CAP045Ar1MvSGSrL9gL3YzSbGJvs4Xt0MMuAahLZz2_B6y0UbzQ@mail.gmail.com>
In-Reply-To: <CAP045Ar1MvSGSrL9gL3YzSbGJvs4Xt0MMuAahLZz2_B6y0UbzQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Feb 2021 20:19:13 +0100
Message-ID: <CA+icZUXj2ew2zPpBBk989i-o49Rz4sb0JpdBH_CtmbSqcwsEJg@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: Remove _TIF_SINGLESTEP define leftover
To:     Kyle Huey <me@kylehuey.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 11:01 PM Kyle Huey <me@kylehuey.com> wrote:
>
> Looks good to me.
>

Any other comments on this patch v2?

Thanks.

- Sedat -

> - Kyle
>
> On Mon, Feb 8, 2021 at 1:43 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > After commit 6342adcaa683 ("entry: Ensure trap after single-step on
> > system call return") a _TIF_SINGLESTEP define is obsolete for arch/x86.
> >
> > So, remove the leftover in arch/x86/include/asm/thread_info.h file.
> >
> > Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return"
> > CC: Kyle Huey <me@kylehuey.com>
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  arch/x86/include/asm/thread_info.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> > index 0d751d5da702..8861967e0305 100644
> > --- a/arch/x86/include/asm/thread_info.h
> > +++ b/arch/x86/include/asm/thread_info.h
> > @@ -101,7 +101,6 @@ struct thread_info {
> >  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
> >  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
> >  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
> > -#define _TIF_SINGLESTEP                (1 << TIF_SINGLESTEP)
> >  #define _TIF_SSBD              (1 << TIF_SSBD)
> >  #define _TIF_SPEC_IB           (1 << TIF_SPEC_IB)
> >  #define _TIF_SPEC_FORCE_UPDATE (1 << TIF_SPEC_FORCE_UPDATE)
> > --
> > 2.30.0
> >
