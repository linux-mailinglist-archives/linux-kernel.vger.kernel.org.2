Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C736EF72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhD2S2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233338AbhD2S2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 384E96145A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619720843;
        bh=1dZL19SfAvPWGNrE++ag9v5BV8bXH6/Msa+N94lCj90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nrw6p1vOaYuOyrm4FKbSq1E7BLtBFErpmvElV7bIGxmf2FQzXhQV7o3M5qrwxvaAG
         WEyyq4uGQ5l18v9M2/igBLVEf9DlUlFZ6lsJ7Q4swZIFJEGmK7+9LrnihsJKoXtVgr
         zqEhfE1RyzZ89Lox2f7mdNfGPfzI5qw6qeC2GUOO9t0NJomQczWt/O21z5QjJDZ7MW
         QTbzKVvAKqXhbIV8lQNKsY72cxNN2ocxk8JWtMfHerFsV8EyvYG2bFD9h/ePv2qMCq
         mSxI6PwqRIk1rgyBYTqjQ0rk4uHzIMZf6HT0EnuPMCbM3rGd0hO9dVGHYipUkhys1r
         gSHgFlhdxJTJg==
Received: by mail-wm1-f42.google.com with SMTP id k128so36429765wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:27:23 -0700 (PDT)
X-Gm-Message-State: AOAM532njDKwkYdho1YKWGu+XI+4CcfkWzND/i5Qv1Tm29xZT61OdQxX
        KO4yVYa+oJ8Z1cPVek7gYO33BxWOn7HM33BTV7Y=
X-Google-Smtp-Source: ABdhPJyfPyXCkEz3y4yjciJou1bBLTGnSGTL7kfY+577u6BUkQ4IhgkvzcnM3c6srKX61CtxX+uMYkuauLkoN/LM+gw=
X-Received: by 2002:a1c:a949:: with SMTP id s70mr12305016wme.84.1619720841576;
 Thu, 29 Apr 2021 11:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210429150940.3256656-1-arnd@kernel.org> <20210429181716.2409874-1-ndesaulniers@google.com>
 <CAKwvOd=5sLHssCf0Umfh+E__TjSwpxtO9K2MYVcXEhxvVp8okw@mail.gmail.com>
In-Reply-To: <CAKwvOd=5sLHssCf0Umfh+E__TjSwpxtO9K2MYVcXEhxvVp8okw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Apr 2021 20:26:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1S0ct832wN0aM8ZAKbbQ3=w2_vSprhzQ4rLN=Ue=L0JQ@mail.gmail.com>
Message-ID: <CAK8P3a1S0ct832wN0aM8ZAKbbQ3=w2_vSprhzQ4rLN=Ue=L0JQ@mail.gmail.com>
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>, Jian Cai <jiancai@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 8:24 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Apr 29, 2021 at 11:17 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > (replying manually to
> > https://lore.kernel.org/lkml/20210429150940.3256656-1-arnd@kernel.org/)
> >
> > Thanks for the patch; with this applied I observe the following new warnings
> > though (for x86_64 defconfig; make LLVM=1 LLVM_IAS=1 -j72)
> >
> > kernel/smp.c:515:19: warning: passing 8-byte aligned argument to 32-byte
> > aligned parameter 1 of 'csd_lock_record' may result in an unaligned pointer
> > access [-Walign-mismatch]
> >                 csd_lock_record(csd);
> >                                 ^
> > kernel/smp.c:516:14: warning: passing 8-byte aligned argument to 32-byte
> > aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
> > [-Walign-mismatch]
> >                 csd_unlock(csd);
> >                            ^
> > kernel/smp.c:525:14: warning: passing 8-byte aligned argument to 32-byte
> > aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
> > [-Walign-mismatch]
> >                 csd_unlock(csd);
> >                            ^
>
> Perhaps roll this into a v2?
>

Right, I just did the same thing. I wonder if I failed to hit those because of
differences in configuration or because I tested the wrong way.

Either way, I'll give it some more time on the randconfig build machine
before I send out v2.

       Arnd
