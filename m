Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE042E1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhJNS5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhJNS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:57:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:55:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so30783907lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5M5m8DjfK5hJyEYeMm28Sfb9jW0/rdhueUlUtHmJrg=;
        b=j+1VXgCvhgorpI6KygCPuVxYKzSXv8uLSMAiTmzTd9JTv8TLlQ7tWo7pErnwDldF8t
         e+js0mIOfOg4XAgnH66/KORf31cTSmPVyMXuXbuylMCgxVzTqtmUOeY0J3Foyt5x1xey
         VnaSgCTUJiQMpWDYaRmvwqVQmnHjCmXa2K7AMhTZHQSHdPF/GFwf+cKyS2usHvOu1a5W
         fwAX1HeqRUuMKMqHmnSV16ExQXUJC0Yuan9UuMbmgx5TvlMrHpCkar86vw9WIQM4IvmS
         bUQLafkGZ5gkKZjMEtoh8bKm9VXFW/fvET21/49RgkbxuxQ/QpI347Rb86oX1ykvPFPv
         t6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5M5m8DjfK5hJyEYeMm28Sfb9jW0/rdhueUlUtHmJrg=;
        b=wewiqb7GfFoC7dNVVY4eiGVJGujJRLuzYisYaZopNnKLaD8E+zd+UNEqMoCd2Bws8t
         AtYzzArJfaRtRA/qDt+RQTuBoFOeSryNsepHnw2Zr8wjRZ0VMfP2nyrxUWSatAPAHkOB
         rSSgNICC4utwtYSyAEfgho+fYgNrHiNiy7vlkRM53K7bKBiVvgw+EbEm29X495eQrKnQ
         xVFLApGa/lsNdl7EJLtttCST2DPA0Wi7qexUXsSD5Z/UA0ogOJZBLVqislnp7/Pdtr99
         4sRG1FUrtIqX+W9HMws9oQPe178s3fOicZm1ILr65A+LAsbqF3aYbrJMBl9exWfOMTQV
         DcpQ==
X-Gm-Message-State: AOAM530hfH2GeyZBs8/UXCqPn5CPlben+pvMe51l4mctCXtHqgr8EXpe
        GBQzzTvBUCWrLeUmJOpivsZkdtYgVKDRZ68PSjFmBg==
X-Google-Smtp-Source: ABdhPJx/0eqf52atHFL/Lb8UyrmBf6cXySUxK9azDJC9DfECKlRql3JvqMF31A3Iw1p6MltvD/smqGa2T4oiFaTdgq8=
X-Received: by 2002:a05:6512:4c7:: with SMTP id w7mr6926764lfq.444.1634237742018;
 Thu, 14 Oct 2021 11:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org> <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
 <CANiq72nt+8bCGAm8yhvTZfS64ovOi9_U=Gym7biUhdEsc3Neaw@mail.gmail.com> <CANiq72=UVCmjr1tpSwcoOkid5tWZirKCnV17_Peqy-LBmEQHEg@mail.gmail.com>
In-Reply-To: <CANiq72=UVCmjr1tpSwcoOkid5tWZirKCnV17_Peqy-LBmEQHEg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 11:55:30 -0700
Message-ID: <CAKwvOdkSFhzSwo2hfFjXXHypC8eU+VBCnRVjvNima7qx85z65Q@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Thu, Oct 14, 2021 at 11:41 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 14, 2021 at 8:33 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > That would be a nice to do, but I am not sure about introducing one
> > more macro about this... I think it would be simpler to submit patches
> > for moves into `static_assert` even if we have to "flip" the meaning.

$ grep -r BUILD_BUG_ON | wc -l
3405

> Actually, what would be ideal is a compiler-backed lint that checks
> whether it could be an `static_assert`, perhaps in clang-tidy?

Oh, that is a good idea.  There is one already for recommending the
use of static_assert instead of assert.  That's actually very nice.

I was playing with trying to adapt clang-tidy's C++11 `auto` fixit to
work on GNU C code to automate the replacement of:

__typeof(x) y = (x);

with:

__auto_type y = (x);

in macros.  That's perhaps interesting, too.  Given the volume of code
in the kernel, I wouldn't waste time with one off patches; rather I'd
work on automation (since clang-tidy can be taught "fixits" to fix the
code in place, not just warn) so that we can better enable treewide
changes AND keep new instances from sneaking back in easier.

Let's see if I get an intern in 2022, maybe I can have them focus on
clang-tidy+kernel.

>
> It would also ensure things are kept clean.
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
