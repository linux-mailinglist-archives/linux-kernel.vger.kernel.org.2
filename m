Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE62397A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFATSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:18:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCA2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:16:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u22so823606ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/jOJxrVdwVgkU5pbHsyaxFrpR7j0sbYKE51g0U8/jE=;
        b=JNQVKx8YGqWIPolHIu7v69C0waidVaomhIcbK/bziEbTl7DykCEDGeYYUeLjtFfsff
         oXQYZFYTAMZA0mrbtVQ8+hvf40tKDtC+0YeeNuM3fnUHbx4RXPwjjxXoUI6EGll9fdoT
         xx87coe9CxpHI62e4tK/n1R0QIJcxiwM78wsY1bjJD5S85HVGCgiXEwWYsfYDIaa1FoM
         5rXMOfyYCo1BYHGjht1LqOHqzSgzhN3nyICK9NNQs0jFCDAm8HX5wDGPhrKPVEENhAOp
         Me/o1k/AvMlS+BtdWIkLq9s7TFT+W0lVn+rDsDRL47WJzhfZPHWCenbiim+pSKg+W2lf
         BkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/jOJxrVdwVgkU5pbHsyaxFrpR7j0sbYKE51g0U8/jE=;
        b=osPZPRUBpaDYV9hHhYY5sDrEkyMI2JyGMEVB8L0Jv8jXA/s/UVoomPruhlKNPvvi+5
         Y6SDR6VAl6CcKNPC2vGlp1GZKRuyfj0be1jXlQznNmKtRcp3nDppJ1CiNoyIJWpfldMW
         uyWY2e3O1G6C+JiUi6ev7+ZkqBabHKV2683Mc/a1o6z5rJWKRlEHyR8ktMoa5qnmnxw3
         u82SMfBpPOCZ+w+3CKVoP86aRqLwM/yyMMZMgLmnEGhYN7ugYA8Sbh/8iDoUhkpx/urA
         hUFHlzhCZoeYberNCZQeG9wWw/FE3Lko0HCwRflFD65NDUa7XLRWMfux3rH92nFFJ+QK
         0T3A==
X-Gm-Message-State: AOAM530wPo4SW5w6bo0iU1+WLOhbCofxJDmT/bhYLbbhdqEVKEssG4QF
        ZjNlnSIg0yzUQG/f/RiHTiETubA8SUy941ymCI8CjgstmsU=
X-Google-Smtp-Source: ABdhPJyJN7rznpmh/MvqNMCED4g9cm477yEbcpS0IHXgl5c7ioyiAWHkHQJUXQItnu0aciOXvmkPmEU2nN5EuXKf1hY=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr22336288ljc.116.1622574985372;
 Tue, 01 Jun 2021 12:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-2-nathan@kernel.org>
In-Reply-To: <20210521011239.1332345-2-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 12:16:14 -0700
Message-ID: <CAKwvOdnUdQHMungT97KcECo-HzMSLeDM7s=JCGh5XwOkR84+Rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Patch "mm/slub: use stackdepot to save stack trace in objects" in -mm
> selects CONFIG_STACKDEPOT when CONFIG_STACKTRACE_SUPPORT is selected and
> CONFIG_STACKDEPOT requires IRQENTRY_TEXT and SOFTIRQENTRY_TEXT to be
> handled after commit 505a0ef15f96 ("kasan: stackdepot: move
> filter_irq_stacks() to stackdepot.c") due to the use of the
> __{,soft}irqentry_text_{start,end} section symbols. If those sections
> are not handled, the build is broken.
>
> $ make ARCH=hexagon CROSS_COMPILE=hexagon-linux- LLVM=1 LLVM_IAS=1 defconfig all
> ...
> ld.lld: error: undefined symbol: __irqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>
> ld.lld: error: undefined symbol: __irqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>
> ld.lld: error: undefined symbol: __softirqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
>
> ld.lld: error: undefined symbol: __softirqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive lib/built-in.a
> ...
>
> Add these sections to the Hexagon linker script so the build continues
> to work. ld.lld's orphan section warning would have caught this prior to
> the -mm commit mentioned above:
>
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is being placed in '.softirqentry.text'
>
> Fixes: 505a0ef15f96 ("kasan: stackdepot: move filter_irq_stacks() to stackdepot.c")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1381
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the series, and sorry I didn't get around to reviewing
before I took time off last week.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
> index 35b18e55eae8..20f19539c5fc 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -38,6 +38,8 @@ SECTIONS
>         .text : AT(ADDR(.text)) {
>                 _text = .;
>                 TEXT_TEXT
> +               IRQENTRY_TEXT
> +               SOFTIRQENTRY_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
>                 LOCK_TEXT
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
