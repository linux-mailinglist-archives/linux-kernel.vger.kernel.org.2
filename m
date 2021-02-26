Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638B7325C41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 05:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZD7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBZD7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:59:30 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D843C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:58:50 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u3so7655786ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DR7Dnd24+rlaYf99PAlqhwVRNpL9GcKCVK3DbGNBrek=;
        b=U2nwcGm2hY+IwkHqVz0vJLcPbSA0sak7u0hqv5m3rjcmoLnI0Im4QNAssftyTJeoHI
         zOOLElNM47FZ3Q6dWiXKcqbo+r1Bh0HyCmZYNswPVgqW037epoH0kFWYIK7hKSZVrDHx
         9R+JZXW58+N+MkosR1qdlC4eEy9b/icSeZ3IzzZw51G5sGRJCx1IfC4ogrz7H2B1yztm
         NkgtD8c6Be0o7gujR58K5TUYLluYqfChWTRtlL5TrifL4TQGBjW4kJH3QWxIuOUY6x9D
         V6baAWO9MpRCxbgZ8XbuGTc0EEbc/C6LZ84LS5Aint+OD29DuFzGG4yhZDu6Km+vReKg
         hHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DR7Dnd24+rlaYf99PAlqhwVRNpL9GcKCVK3DbGNBrek=;
        b=EZb3kg/Jajp5EVuJwEhLbkgj1YF3ZxYgkP5gwfMaxw1BwAqqShdQs16YQdxWcvKW/I
         8jFqzDhsL3n/b9DdZRkNn+79fBXYIL0oNFQVc7ePEaT42t/Nk03UCDAJ0yRhojGkYixY
         arodC2x/cYRuMsCwtOAu9NwyL9zbthIiK1eCO4zD/YZ02wYxKjD8mN9/k5pTVHvQBQC4
         C+m+GfVWUfRAOXFGjds1vb/gsAis1swsoaxf5RR6AspZMihw6gmEN3s0RR6oIg6pGEon
         WbN/XqUtIEkDo8/MLEQXZOBDLgJj8YGyaDl4U4QZ8YU7+GXwB2zdyWFYKsPmjytONoCF
         Ns9g==
X-Gm-Message-State: AOAM530Zz4UPC99cQPdfsdQ/YHiV5RxpBJiyI9yR/J5yn9nl5DnFAujf
        LarTb7gYuHOQ1ozOCoUebOKl7FghROKeGNk/W7M=
X-Google-Smtp-Source: ABdhPJyA+U3p7S4LVlULul/gukKq7Znt/rO8nSS8W9Q+ZKmQNUt7TfBo8nj6FSaaFwEpfk3AIvK5OwParuYnBvDJHiM=
X-Received: by 2002:a25:3208:: with SMTP id y8mr1760714yby.422.1614311929791;
 Thu, 25 Feb 2021 19:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20210225164513.3667778-1-arnd@kernel.org> <202102251203.03762F77@keescook>
 <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
 <202102251213.5815C9B33@keescook> <20210225201801.GA3119@MSI.localdomain>
In-Reply-To: <20210225201801.GA3119@MSI.localdomain>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Feb 2021 04:58:38 +0100
Message-ID: <CANiq72=5t1maOv1FerMLRVCRos_yv-iQGLzB21Z+aYxTXLy8gA@mail.gmail.com>
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 9:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Indeed. Any wins that we can get with compile time, we should take.
> Clang is being widely used in production systems now so I feel like with
> a trivial change plus user visible impact, it should be backported.
>
> Not to mention that the generated code in theory should be better
> because it is the compiler's builtin, rather than a hand rolled one, AND
> this is technically a regression, given that it worked before compiler.h
> was split.

Compilation speed shouldn't be an argument for a stable change unless
it is something egregious like a 50% that may affect users or tightly
timed CIs.

Fixing an important runtime regression is a stronger argument, but the
patch doesn't show what the effects are, so it isn't justified (yet).

Please note that this kind of change touches a lot of code all over
the place, which could always trigger other runtime regressions or
even bad codegen (yes, very unlikely, but it happens).

Cheers,
Miguel
