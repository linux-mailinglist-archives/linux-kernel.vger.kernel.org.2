Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E742E20F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhJNTfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJNTff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:35:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:33:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d125so5108246iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y3CUDnBdTwrB31OmbGNsn7XVJp+6GgfdsLjPUZSzRw=;
        b=jADDAblRGxyXiLiV7CxIpwecQCD9qtT4yoY2Xh45iAsai0Ba3cIwOwcCtpwuPaccXk
         7n1/qude1VF3weiueYkQQtxs8v4r8g0tZfUbIOd/vosMMipYCotyffMJOlE+BAvjXhny
         NQl4UbSsCCV0wK3Th+fGAr7Bq2YVx4EtvFoWjsPstB5Fh889MYCp047ncx3ZrEWF+qY5
         6A1slEOTm//B+IS+w0c1kkg2kuzEpFerJtFxHTuyHzCgPkyUo9GaFDoqJcrZuZMgMryI
         REGOKKO22dHzb454XsjmdAxItSzmmTa0RUmusEahaBvCZpxfVhBWqwSea0EREou36i7m
         9D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y3CUDnBdTwrB31OmbGNsn7XVJp+6GgfdsLjPUZSzRw=;
        b=dhroqud50H3Rnpek0nuzIbS0XK8pLvTvVZfIN0q8nDwuuNQOh8GY1XmfKARA473fll
         DG+i84lRXj+QJp6JygiZiBeqHC+rOXG9/34PyqRgDyYi6aizWO30gUoZCTG00NSNzbK5
         FuHPunwhMBC0E/JKwmr8LZYj8yH1qIkG/DRG++gpzCKIRpIS8uOT/5Ns6i4bgGKRRZKw
         RoPjYcd1zUMVbjXZw/KLmqmN7BYS0d2J8l2ivZYLkvhufsTMtWuq6Tv4+58LZMmBeIrz
         7wZd1dG/DQanlsVcobEIFHXNUfJ0b3gwFi4Za8XjjeeZSWLJet7CNp+RnpQua0fCsPLd
         yaNg==
X-Gm-Message-State: AOAM532z05+3ViI/4hAQ5k4uh/zw20ZCGuyma597jFrNxxPJP77EVBY7
        JgpdBizZn3zlIeLs+LhUIUyaYme4RA8QNzijKvU=
X-Google-Smtp-Source: ABdhPJwFRtnszd9LYlqNvIgsElFFrpNYGnstm/pQiqEgtxIO9ow2deXivNbAElzfpFpNoNFcwvJ0fM24pn6fAwxIGtA=
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr654825iok.177.1634240010184;
 Thu, 14 Oct 2021 12:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org> <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
 <CANiq72nt+8bCGAm8yhvTZfS64ovOi9_U=Gym7biUhdEsc3Neaw@mail.gmail.com>
 <CANiq72=UVCmjr1tpSwcoOkid5tWZirKCnV17_Peqy-LBmEQHEg@mail.gmail.com> <CAKwvOdkSFhzSwo2hfFjXXHypC8eU+VBCnRVjvNima7qx85z65Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkSFhzSwo2hfFjXXHypC8eU+VBCnRVjvNima7qx85z65Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Oct 2021 21:33:19 +0200
Message-ID: <CANiq72=vZ0gvJRuVcNaBi3CQfgB4edEUyLpL8DvZeLkDSvttOg@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:55 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> $ grep -r BUILD_BUG_ON | wc -l
> 3405

Definitely -- I am assuming a significant part of the macro
invocations cannot be static asserts so that we would ended up with
churn anyway...

> Oh, that is a good idea.  There is one already for recommending the
> use of static_assert instead of assert.  That's actually very nice.

Happy to help!

> in the kernel, I wouldn't waste time with one off patches; rather I'd
> work on automation (since clang-tidy can be taught "fixits" to fix the
> code in place, not just warn) so that we can better enable treewide
> changes AND keep new instances from sneaking back in easier.

For automatic fixing we would need to be a bit smart due to the
negation w.r.t. "style", i.e. in most cases it should be easy to apply
it to the expression, e.g. from `!(x == 42)` to `x != 42`, but in
others it may require some "human touch".

There is also the possible mismatch of the usual style rules even if
we apply e.g. `clang-format` after it (one more reason to avoid human
formatting...).

But yeah, I think we should be able to cover the vast majority of them
easily. We can always send them as RFC patches and let folks adapt the
patch, then enable the warning/error by default after one release or
two.

> Let's see if I get an intern in 2022, maybe I can have them focus on
> clang-tidy+kernel.

It would be great to have someone adding more `linuxkernel-` checks!

Cheers,
Miguel
