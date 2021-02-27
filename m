Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E795326C15
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 08:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhB0HSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 02:18:00 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:32489 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0HR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 02:17:57 -0500
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 11R7Gqoj011859
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 16:16:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11R7Gqoj011859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614410212;
        bh=2VwYGs0XfMWZJ7w9TMuYXEHeMGMKE1RQ9jv/xrKLVIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cc3JBua62lW/4rDjlc47ZcxoDgCz4ezUZCczaRBLf0rCR1gj5+6JP1zESDQY5wEnP
         cuMHkZqhFAvqaqjUJCvZJ2Hg9tilpM1kfpCDm/xGgs6eEqNIBYq+qazV+bmTzZd0KP
         dp8I0NFYdKneKzSDzGp0yFozDnHcqLklHrqHPiTqYxRMoIVy81ricDp1Fu2O8aDXr9
         2VyfIh+d8+IkYIRhdq13094haYEgz6dqQFvBAdMgmrTCFw/RY0f6A69dW/yTLE5ZqV
         lSWRoy6c1yuKEI0fQmf473w7j3uBp3R7xxaox7YlLDQnRMLIn+cp9Ju57reQ3YfAqu
         u/Rtqa/Py7Xjw==
X-Nifty-SrcIP: [209.85.215.178]
Received: by mail-pg1-f178.google.com with SMTP id p21so7637134pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 23:16:52 -0800 (PST)
X-Gm-Message-State: AOAM530Z04ZFhsuj2Xej1jMHijGVR/XPaO/ijglTn5mm9ZWZ2i667n1P
        a2LkEz9vz3y7dGlKfeWjA5PALoVjoZq+dFL5M7k=
X-Google-Smtp-Source: ABdhPJz98h6iGMQHbgKOw3bRR6geUfhVePaZv55pXOTit5rayJGje+Wtt8ATAhU3QOdZNGqAGKqfIQxzEzpvoKYmhyM=
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id
 h22-20020a62b4160000b02901e4fb5a55bbmr6598789pfn.80.1614410211865; Fri, 26
 Feb 2021 23:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
 <20210113214436.GL1551@shell.armlinux.org.uk> <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
 <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com> <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
In-Reply-To: <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Feb 2021 16:16:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOjqvp12jaXYJm=s7mO3TQy1skb10+sHRkjY63-4fk-w@mail.gmail.com>
Message-ID: <CAK7LNASOjqvp12jaXYJm=s7mO3TQy1skb10+sHRkjY63-4fk-w@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


On Fri, Jan 15, 2021 at 3:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 14, 2021 at 12:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > So if the arguments are piling up, what is holding us back, other than
> > inertia?
>
> I think we can most certainly just try increasing the minimum version
> to 5.1 in the next merge window and see.


Just a friendly reminder.

It will be nice to increase the minimum GCC version
to GCC 5.x globally.

Now, the version check has been moved to
scripts/cc-version.sh, which is invoked from
Kconfig.

If you decide to do this, please update
'gcc_min_version' in that file.


I'd like to suggest GCC 5.2 instead of 5.1
so that we can drop the following line
from arch/powerpc/Kconfig.

if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC





> > Note that banning 4.9 for arm64 and banning it in general should be
> > two different changes in any case, as the former will need to be
> > backported to -stable kernels as well.
>
> Yes. The arm64 issue is a clear and known bug, plus I suspect gcc-4.9
> is ridiculously old in the arm64 ecosystem anyway.
>
> So the arm64 issue is a bug-fix, the follow-up of just upgrading gcc
> requirements in general would be a "keep up with the times, and allow
> those variable declarations in loops".
>
>             Linus



-- 
Best Regards
Masahiro Yamada
