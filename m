Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CC41CDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhI2VCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbhI2VBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:01:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:00:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so16256394lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BFsGoidX5xySatTjL6O1Rs262c5AIgIlOFlxvgUuvk=;
        b=SneNZlIax4nr4ZEGc5l2fDkaEHCvlPaNVr54DBErWz531ImoNTTv4yv4LSWd/cEuWN
         +LjfoMkqSL31WQy8KPDor/xko/H+HICy229+RzM67ajM2FF+qE7ioqGeuLTts3APho1s
         h+Xmo4pmNdp1QU1Ddjq1WQKjiiobT0/AJ3wU8BprS98FnY7k9OO0qcyJC7nY+hgOvamj
         ZmMjW0FyLoCcBWwrHidIp7iOSvM9yO7EiHkAtpFA39UYst7nJcToVWg2o6L7W4snPmS/
         CqD77cdpNSxGl6kFtfQeyELHgIvdgpRaE1Zrh6zjG7Rdb3SszlQFopMmn3J0YCgsw+sb
         n47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BFsGoidX5xySatTjL6O1Rs262c5AIgIlOFlxvgUuvk=;
        b=uw3tJ6tBjT5TyLyRSh6/dLW+7kh+WKey/bAlgZdqglmjp5zD6//RmlE53Ju0rExkpO
         LGKwEFFVbHW/XEvLOCZ3j3PaEJuWOfcVqvkpDfjVwZPT6pwjIn4MV3WelXU35TQ2sZML
         oTfGeEKZO2EPogM/75/1NO6IMY1Sii7fJDUeej3VcBw15Ac3l33G0C5/SL8ws1K1IS1H
         hXi0nzeE3pd5BtaMhtgjPG0wVIVVFJ0LMMUihWJgX9L9kmko+lNfh8fml6ijwJkJo8aU
         WZVzpDqCdFrnoNa+MqUqt3fHcT4fznnze9yuF2OTAYckTtOqOLaGE6SsiNIOVJmB9Ni0
         jEhg==
X-Gm-Message-State: AOAM533XLRvLfA5iYHuaw0qBOfYconf2784QZj6v7BHbwz1xLNTMopjD
        pRaCiqmFjtHgG0Q1hAWQjMbATUMPP9KEI+4BL+5WGQ==
X-Google-Smtp-Source: ABdhPJwKYMOSk2zIDZ/Li6VchcYDCLj1AiZt5Mx4teV3ccBrag7zsEBeHnhIKWBJ5VzOa2KBBUDR16FGSsdIXYBtoLw=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr1910694lfu.240.1632949208202;
 Wed, 29 Sep 2021 14:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmjZ+QmjTJnQ-w5hLPJjow1gYnWTe6f8RBhQUJ2b3cYnw@mail.gmail.com>
 <20210929192026.1604095-1-ndesaulniers@google.com> <CAMj1kXHkcTZOR1eb-GVVe3m77Lfg8qdp+wLgHMOr7yNTecBGOw@mail.gmail.com>
In-Reply-To: <CAMj1kXHkcTZOR1eb-GVVe3m77Lfg8qdp+wLgHMOr7yNTecBGOw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 13:59:56 -0700
Message-ID: <CAKwvOdmOEhbc_LdsBTuFojPXa77DQNkjS7b8EyZzQ6SjRREy9g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Dave Martin <dave.martin@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 1:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 29 Sept 2021 at 21:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > QEMU 6.1.0 is more correct about trapping on misaligned accesses.
>
> Btw, this is not entirely relevant. QEMU now behaves like every single
> hardware implementation does, and reports an alignment fault when
> using a load-multiple instruction on an address that is not 32-bit
> aligned, as the architecture requires.

Sure, I can drop that line from the commit message when submitting to
RMK's queue.

>
>
> > A
> > kernel built with CONFIG_THUMB2_KERNEL=y and using clang as the
> > assembler could generate non-naturally-aligned v7wbi_tlb_fns which
> > results in a boot failure. The original commit adding the macro missed
> > the .align directive on this data.
> >
> > Fixes: 66a625a88174 ("ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1447
> > Link: https://lore.kernel.org/all/0699da7b-354f-aecc-a62f-e25693209af4@linaro.org/
> > Debugged-by: Ard Biesheuvel <ardb@kernel.org>
> > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > Debugged-by: Richard Henderson <richard.henderson@linaro.org>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * Drop accidentally committed Kconfig change.
> > * Pick up Ard's AB tag.
> >
> >  arch/arm/mm/proc-macros.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index e2c743aa2eb2..d9f7dfe2a7ed 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -340,6 +340,7 @@ ENTRY(\name\()_cache_fns)
> >
> >  .macro define_tlb_functions name:req, flags_up:req, flags_smp
> >         .type   \name\()_tlb_fns, #object
> > +       .align 2
> >  ENTRY(\name\()_tlb_fns)
> >         .long   \name\()_flush_user_tlb_range
> >         .long   \name\()_flush_kern_tlb_range
> >
> > base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> > prerequisite-patch-id: 3edbe4a8485c7a75a61dbbe299e8ce1985d87ee0
> > --
> > 2.33.0.685.g46640cef36-goog
> >



-- 
Thanks,
~Nick Desaulniers
