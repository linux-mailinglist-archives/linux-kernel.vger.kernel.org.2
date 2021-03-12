Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F98B33992E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhCLVjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhCLVjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:39:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E61C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:39:04 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 184so9105829ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WV6iTMu03uChDms5bBNns9hCvCHH9+fuZrgLAjE0Aog=;
        b=OaWBFeMkfvWj37dbbxmna/HRQ67mBfE0iAhHeu5Jv//n958y/Az3eA6pRlD603C4EN
         FP/qjW1k/HKTKh8dT+jsPmRUtQYuA6Tq2Cns+zusqmJGg4z41SotayBz1FIi4AShT1cP
         V22LMsEOdRLrHT5LsjXKJ0nTOcrX3pOL9aE+iFw/0ZerNDdjEYxZDA7E87PcQ1iO7Omx
         2gRPFQTKwa8CBKJjnFELi6+qlZXGWhSucyQBVGN6Vn4kp4VssSqgYnDzdIbLmUGYc2Mh
         zEt2CsWA7HMYko2Rrsm5finRtMfcVkGG78AcyPtsed9n9PGWbkgXztBFYASL4GV6c1rp
         P1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WV6iTMu03uChDms5bBNns9hCvCHH9+fuZrgLAjE0Aog=;
        b=jFTsh5vyhRdcOdRSBksOv7y94p5fzMn9iXjjiEOPxt3TzIoV8VB1mGZNMxLSWx/dKl
         f5p0/wiqol0t+BtoNtRz4nuZGIOrltKBrwrEiW5QBKYK6aQNk4mDjhShymE8Dc7YJd7S
         ZnBzM88ALmL71pLf93YBX/ktCsrBNsnnXbvwwE7v1R8OtwVPCaw7obbdBbK25qvO4ymU
         pyhMy4wYcswGZppEAPP68wTwV0HdqqroVPR/Z1xz0HShrpn0m5RebusfSrXsLGDrH2/0
         EYaKt7vKRM27Tdzkj647kDF6c2kx5hbUpRwrMJG2xm3dDcJhMG5Cghmoh0H7ZP+nUJiN
         QZeA==
X-Gm-Message-State: AOAM5300VoDEJlgE7IMUfQkRTJZ8/HDM7YswaLEJhvZ9XnzAxS2DKQO7
        JUq8V7UWH7tV91K9F9VFJU5QVU8OXNQfjJYGfc2Ihg==
X-Google-Smtp-Source: ABdhPJx5JJ4dw8VojLBuciUzedeSi3mLUgjg97F+b1rG9zBUK/x3eIXk0j2lYcXtz6plc0vz/GdPy1dzhfEoXQTRo7A=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr3598813ljc.0.1615585142886;
 Fri, 12 Mar 2021 13:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20210312010942.1546679-1-ndesaulniers@google.com> <CAKwvOdnPhpKRs6SePCUCPs_2MUFbWgJiaf9F9J+aQZGESSQ9yA@mail.gmail.com>
In-Reply-To: <CAKwvOdnPhpKRs6SePCUCPs_2MUFbWgJiaf9F9J+aQZGESSQ9yA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Mar 2021 13:38:51 -0800
Message-ID: <CAKwvOdkNoo+7pDiiNdnciRhHB8LpVTOr7ROpDxfEnLS-Qn9dJA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: LTO: have linker check -Wframe-larger-than
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Candle Sun <candlesea@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 9:55 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 11, 2021 at 5:09 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > -Wframe-larger-than= requires stack frame information, which the
> > frontend cannot provide. This diagnostic is emitted late during
> > compilation once stack frame size is available.
> >
> > When building with LTO, the frontend simply lowers C to LLVM IR and does
> > not have stack frame information, so it cannot emit this diagnostic.
> > When the linker drives LTO, it restarts optimizations and lowers LLVM IR
> > to object code. At that point, it has stack frame information but
> > doesn't know to check for a specific max stack frame size.
> >
> > I consider this a bug in LLVM that we need to fix. There are some
> > details we're working out related to LTO such as which value to use when
> > there are multiple different values specified per TU, or how to
> > propagate these to compiler synthesized routines properly, if at all.
> >
> > Until it's fixed, ensure we don't miss these. At that point we can wrap
> > this in a compiler version guard or revert this based on the minimum
> > support version of Clang.
> >
> > The error message is not generated during link:
> >   LTO     vmlinux.o
> > ld.lld: warning: stack size limit exceeded (8224) in foobarbaz
> >
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Reported-by: Candle Sun <candlesea@gmail.com>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > LTO users might want to `make clean` or `rm -rf .thinlto-cache` to test
> > this.
> >
> >  Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index f9b54da2fca0..74566b1417b8 100644
> > --- a/Makefile
> > +++ b/Makefile
>
> Candle sent me a private message that we probably also want coverage
> for kernel modules. Let me revise this and test/send a v2.

False alarm, seems specific to Android's LTO support pre-5.11. I will
fix that in Android trees.  This patch is still relevant going
forward.

>
> > @@ -910,6 +910,11 @@ CC_FLAGS_LTO       += -fvisibility=hidden
> >
> >  # Limit inlining across translation units to reduce binary size
> >  KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
> > +
> > +# Check for frame size exceeding threshold during prolog/epilog insertion.
> > +ifneq ($(CONFIG_FRAME_WARN),0)
> > +KBUILD_LDFLAGS += -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
> > +endif
> >  endif
> >
> >  ifdef CONFIG_LTO
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
