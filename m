Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68667422650
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhJEMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhJEMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:24:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC10C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 05:23:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i4so86158893lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3F2qtoIxG3zxkrEUzzRxzrLqwcXtB72sgHyP3li3dqk=;
        b=xUJ7mkOoDOxBVKfWHuEyusEWg32a5si67xM0kMKsav1ZKohMiraZhSgr5uI3grGE5k
         kZ5rhw2LHHcnXUUn6SXDdd1Nh2KbhD6RTNZuN9lm9ZUDlfcQhg3x4mkYtyMbF0xFQWRF
         hYuZhjrCcJkEXerAVam5uTKN6XneVg6hWuJZCziXzPeO8nPEDZJIumw0XetBrkZ+42tA
         /grEXPN34W7l8YNoMIoEPxfk1BvJwjMNI7/QgOTMk9nNteb9R4oJilkTx+2yLIZd/EDq
         PxrVu4tHKGbV2i+N/i9u+gT9W2+1OAvDEhLFqnaNQ5QjvXiw+DvDqCePg5vQp+AqDv4e
         U/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F2qtoIxG3zxkrEUzzRxzrLqwcXtB72sgHyP3li3dqk=;
        b=KmEi9SjtJsmhWVSPGCwyahNxzCpULMf0fCbPuoxfIwxdpFU8v21bnK3uq5yJEzwB0m
         HR9SmMXFO0Grd0IhlAXcLRmH2bUh8TCKWopAZOit0d6PID5sV+7NXtQ1P8E6SP5RydEJ
         sXgrWVJMTK7z6GxU5JyEprKMQAFRKnSySO2V7pHCQ5H0oFrhH1V/in6oWkK3D8EG4jfb
         HpIejNhgrzVN4M4ByCTosArxCVb+AlvGMtpMotqLzEVyIXSCaxkO35CCY9TUo9ZKXgrq
         GnIeU1O2DaqFqacYYOTXH9rIo8O4uAl89Bl4p7fNpoL4XfrrgGHc89Xxym2tu+IxlxIO
         mC4A==
X-Gm-Message-State: AOAM531Ixp8cwRQmebCZPMiGIgInoQxzNfrZTFNAl4OyLPR8aFQOagyR
        4fhy+B5fPMqiPyfD8z8dZAZdEChbgpGQ+8BS3G2R7g==
X-Google-Smtp-Source: ABdhPJxvTX4d8/lLaexThVRDLWSA6FrSivw8/LGtGSORiHIxNVOrvc6NPluyz7K+/R5/4mr3xxdiNp2IdzRrGJV88Sc=
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr2934362lfg.40.1633436581665;
 Tue, 05 Oct 2021 05:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211005103208.2763305-1-sumit.garg@linaro.org> <20211005104131.GB1664@C02TD0UTHF1T.local>
In-Reply-To: <20211005104131.GB1664@C02TD0UTHF1T.local>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Oct 2021 17:52:50 +0530
Message-ID: <CAFA6WYNej=GLE5qxSdJfWt3pEfe6s5qHNLZDpaCRrK-GTasgUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: ftrace: use function_nocfi for _mcount as well
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, ben.dai@unisoc.com,
        nathan@kernel.org, Kees Cook <keescook@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 at 16:11, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 05, 2021 at 04:02:08PM +0530, Sumit Garg wrote:
> > Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
> > only fixed address of ftrace_call but address of _mcount needs to be
> > fixed as well. Use function_nocfi() to get the actual address of _mcount
> > function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
> > with jump table addresses which breaks dynamic ftrace as the address of
> > _mcount is replaced with the address of _mcount.cfi_jt.
>
> It might be worth noting that where the toolchain implements
> patchable-function-entry, we'll use that in preference to regular -pg,
> and this problem won't apply. i.e. this won't show with recent versions
> of clang.

Okay, I will add it to the commit description.

>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> This probably wants:
>
> Fixes: 9186ad8e66bab6a1 ("arm64: allow CONFIG_CFI_CLANG to be selected")
>

Okay, I will add it in v2.

> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks,
Sumit

> Mark.
>
> > ---
> >  arch/arm64/include/asm/ftrace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 91fa4baa1a93..347b0cc68f07 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -15,7 +15,7 @@
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> >  #else
> > -#define MCOUNT_ADDR          ((unsigned long)_mcount)
> > +#define MCOUNT_ADDR          ((unsigned long)function_nocfi(_mcount))
> >  #endif
> >
> >  /* The BL at the callsite's adjusted rec->ip */
> > --
> > 2.17.1
> >
