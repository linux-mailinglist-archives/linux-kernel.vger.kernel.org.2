Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB034401B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCVLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhCVLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:45:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:45:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o10so20748669lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRuJKDLONwqvRSEZw7q4XL+dQi5no/glykgD4QfcHoc=;
        b=P9wPcvkHTDs1x5aCD8ZWEAWDiHPlrSVjFG0tZV2TfulePyEkQ6FYDKFVNHR6Ba67JP
         +H1qdwoME5OWNcW8CR860GNbI4yTWPM4F38y+Qspah6LrVzJbg2URQH7AQkh/n8Nrd+u
         75kTundK0bGBQWyzxgfo4/sPM5u8o9bnRP3Mg8pVx7w/PkkwGy9B7uwE75ypeSpiqDc4
         vZNiuAxUb38EJR50GOUr5lEySgXSaMMvVRltUk4fJzdmzrMb/RG9VRDkCx7PlzPRBlHf
         w7Tg0Jv89mm5EnWdjrnl2kNdb2GCGWSV3pR3ULzG+Tk3zRwXI63yTjFI7bOfs5DUTIrR
         azeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRuJKDLONwqvRSEZw7q4XL+dQi5no/glykgD4QfcHoc=;
        b=NhCTBdj2NqfpMU5Gr9AjYw//fiHtIt3ke0N4Srkdi7laQDR+0OEHmUo+xIPVxVIPdC
         dCVBV7qSXROR9TP+cw4T34x1fmdb40milT9lvsYsrMuxyyrbKvJ4rp9hLTuF2JDy2HD2
         QOG64UA716seuBQ/KlF2zAmRLhjP1UcrHpFjDEO8yDzGoFSltG+/D1OTI1Owrs3lkzdU
         XRaZT8XIGNqhlgcGVEEeu+OkMKcOc6qJQY67NfrO8B7N5iaXpVqewFbbw7DW4jBPaUQp
         +ON9Ut391iUvMfwtFEsfIKkQdm2/akRJpfzMVjRyAWCZ7UeGvc8c2imVbl8F0CTCfH63
         cd1w==
X-Gm-Message-State: AOAM530x98K7b3ROhSOsIwBYRrNByzmiRewupsnn3xiAWqxWNwmH25gx
        UqvQXaGUE0PX1b61uvGjtl5fhpzn41kjK46AQYDL6w==
X-Google-Smtp-Source: ABdhPJys1oU0GEM6faShhioXUDfwSD5LX0IoMQgOqke2KKHhM6OxUhkzXyD0wPqFp09wOreA6rq0SxHKh/GVYbssc/g=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr8543421lfa.291.1616413557065;
 Mon, 22 Mar 2021 04:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
 <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
 <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com> <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com>
In-Reply-To: <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 12:45:45 +0100
Message-ID: <CACRpkdbF43_CjSFNu_4FUCEqOB8CebrpXJpkzeW8TnPpRELBtg@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 5:43 AM Jian Cai <jiancai@google.com> wrote:
> On Sat, Mar 6, 2021 at 4:25 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Mar 5, 2021 at 12:23 AM Jian Cai <jiancai@google.com> wrote:
> > > On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > > I think gcc also has these options.
> > > https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html
> >
> > And how does that work with this part of your patch:
> >
> > +#define SLS_TEXT                                       \
> > +       ALIGN_FUNCTION();                              \
> > +       *(.text.__llvm_slsblr_thunk_*)
> >
> > This does not look compiler agnostic?
>
> You are right, GCC does generate different oraphan section names. I
> will address it in the next version of the patch. Also it seems only
> arm64 gcc supports -mharden-sls=* at this moment, arm32 gcc does not
> support it yet. I don't know if there is any plan to implement it for
> 32-bit gcc, but should we patch arm32 linker script preemptively,
> assuming the sections will be named with the same pattern like how
> clang does so the kernel would not fail to boot when the flag is
> implemented?

I think the best thing is to have something like this:
Implement a macro such as this in
include/linux/compiler-clang.h

#define SLS_TEXT_SECTION *(.text.__llvm_slsblr_thunk_*)

then the corresponding in include/linux/compiler-gcc.h
but here also add a

#define SLS_TEXT_SECTION #error "no compiler support"

if the compiler version does not have this.

I don't know the exact best approach sadly, as the patch
looks now it seems a bit fragile, I wonder if you get linker
warnings when this section is unused?

Yours,
Linus Walleij
