Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FA36D404
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhD1IdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbhD1Ic7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:32:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4704C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:32:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so5212321edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OpS26+rIWsvKvlcNvrtF9Fam5LIDf0slh+zm+iPFbAo=;
        b=hUd0Gc8e7zxXydgUujYAYWkhWSajJcbgWY5JbrtcWZ2gO/z5uqB4aI5vy54oV4AP/f
         +fsF03GeaXinN8GJy0cNhvEhdvdrK+dldZ5F61fNU36NJknA2+LJtkWJQiWLgu90mogG
         879KxR4Resfx0jRhuRusrBLYX80iVnx5fgm4+ROnKvQ6zSczzuTSOsFpoF6uJ8j9GyRn
         RuJu8oqOO+t1IWzpYkuBdxq5F1pFxHmwZfgTYG0AstxHYQkjZ1UUljCmBghJEw9OiF5M
         TfwBglP4M1ZLn9kccgdeUFQLSs4hdtqMz8/eS7/ejAzDWa3NrnsqW9hSbhgRVlFpn9z0
         oSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OpS26+rIWsvKvlcNvrtF9Fam5LIDf0slh+zm+iPFbAo=;
        b=KpxXzXB44Rzlpr6iL52AT0VA/FxURb8s5ug3Zq5ZjV92tL9ztJ5wiKEE2L3dexVO9w
         QzrJ2eJIY+NRlZfSgazfksw0W0INUlInEfbegfX2RfZBtiO78X+e9ms3uvK0SBrS6xA1
         hFch32+3S5ichQdw6UBxDzvdDe2q4zR/Pc2nRDFJbw2q8PG8UC8Mm0eytmFjwe2e1ejg
         cwpIYjkh3K1U9jFQDJTcVe/tgrzHKPw4jwK5drfndj8y5ED3mL7/8+vGXHRLKSsX8zrf
         tVu+KwdHd1OALe8khTu06oiN0wAqHDltWP5o6dA2Dd6p4lFJ3EH4uUfp3300C4EQSa1x
         ffYQ==
X-Gm-Message-State: AOAM532Ad7JBds94rnmGFEqZGsvdJhacn8p9mKSBQIvFS+girTE6QaLs
        e2GRL39wWPTjDOFkN4sB/uhMqtZPWRhdhgr5UvzJlS4nwi9qNw==
X-Google-Smtp-Source: ABdhPJy6ZMkZyqcGq+tqe6oZ6D24Yj9qh5Usb6d/CqyQTQGPj6mneDpHWMJJ88DgDaK4upMB5tO5mjoIErHmWGTC+c0=
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr9652021edq.219.1619598733619;
 Wed, 28 Apr 2021 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210412113315.91700-1-gi-oh.kim@ionos.com> <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
 <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com>
 <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com> <650dc1b8-d801-2263-2e5c-eb833f2c4534@rasmusvillemoes.dk>
In-Reply-To: <650dc1b8-d801-2263-2e5c-eb833f2c4534@rasmusvillemoes.dk>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 28 Apr 2021 10:31:37 +0200
Message-ID: <CAJX1YtaRAgg3oZ6X2cDtj0yASQ27XujDys97vbB0MWnN9vXakQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 9:47 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 28/04/2021 09.31, Gioh Kim wrote:
> > On Wed, Apr 28, 2021 at 8:42 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >>
>
> >>
> >> Are you sure it=E2=80=99s good change? Sysfs is used for an ABI and yo=
u are opening a can of worms. From me NAK to this change without a very goo=
d background description that tells why it is safe to do.
> >
> > https://www.spinics.net/lists/kernel/msg3898123.html
> > My initial idea was making a new function: sysfs_streqcase.
> > Andrew and Greg suggested making sysfs_streq to be case-insensitive.
> > I would like to have a discussion about it.
>
> 1. That information should be in the commit log, not some random
> babbling about case sensitivity of file systems.

I don't think it is a good idea to write who suggested the concept of the p=
atch.

>
> 2. So as Andy says, this is changing ABI for a whole lot of users in one
> go. While it's _probably_ true that nobody would care (because it just
> ends up accepting more strings, not fewer), your motivation seems to be
> to replace uses of strncasecmp() to prevent "disableGARBAGE@#$@#@" to be
> accepted as equivalent to "disable". I.e., those potential new users of
> sysfs_streq() would have their ABI changed towards being less
> permissive. That's a bigger change, with a higher chance of breaking
> something. Do you even know if the maintainers of those drivers would
> accept a switch to a case-insensitive sysfs_streq()?

I don't know what all maintainers would think about the patch.
I thought sending a patch to the mailing list is asking for it, isn't it?
I am asking with this email.

And Andrew and Greg are maintainers.
I am sending this patch because I accepted their feedback.
I don't know other maintainers personally,
so I cannot contact them to ask what they think about my idea before
sending this email.


>
> Sorry, I really think you need a lot stronger motivation for introducing
> either this change or a sysfs_strcaseeq().

I found out a problem of sysfs_streq when I tried to use it for
modules I am working on (RTRS/RNBD).
Then I thought it would be better if there is something like sysfs_streqcas=
e.
That's why I sent the path.
If nobody needs the change, it is ok for me to ignore the patch.

Maybe I misunderstand when I can send a patch to Linux kernel community.
But the only motivation of me is sharing my idea just in case there is
someone who also needs it.
I am sorry if I misunderstand how Linux kernel community works
but I thought I could suggest something good to me.

>
> Rasmus
