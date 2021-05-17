Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CD382773
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhEQItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhEQItK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:49:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7468B611B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621241274;
        bh=wKFUx+C5ERFfmqlY7hiYgJ1TrE1UyI5kqLoJWdG3xVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hc3+4EinzN05fdWiu+7AnEnVl73CJ/Y7EcVk7kGGObC7DXnDjwBA5RhAFBVGZpUBd
         9lvv2fvfsxiBv7PNrHa1P0IpSZBAksOGwMldDoT+YWdIcvR7ip9IIVfVK/at/GoVIx
         QQm+dbiWjtGzDnMItKCG7x8xnG7ju/5rr2j5c32OYsQmvIS5CgQLXTKqq7bzpUxsVA
         ijXvZWnCaV5KNW3yqT26wtjJnEvxuMOjSGn/a6OdEg4iciiACIPzo5Jr1pqiMszFeY
         yM1e8XDlepaWy4agbVmlnafaAOXR3viDltifY3NkJPCSojJuzgrqXqkbXIBlDFJ25b
         Od+hB7G1b+AmQ==
Received: by mail-wr1-f45.google.com with SMTP id v12so5476700wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:47:54 -0700 (PDT)
X-Gm-Message-State: AOAM532LtzkXXIANcgM+9x1/nN8cdIyEkzpCbkqkYj5dOw3LfhGz7eSu
        UqkrFLFJ6NTUlB5GDZEKGajZgeaD+bR5xaaSCNM=
X-Google-Smtp-Source: ABdhPJx0vQssUkIXj2GNS4c8nCXiUWUdcDv60W6ZOqvdHUXSt87zzWrW7L939iBp8jMYgz/WyhCjBnRhsEC1tDzQ3MU=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr75233556wrz.105.1621241273114;
 Mon, 17 May 2021 01:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210514213456.745039-1-arnd@kernel.org> <5459852d-6c0b-2b8b-a05b-868f046b6233@rasmusvillemoes.dk>
In-Reply-To: <5459852d-6c0b-2b8b-a05b-868f046b6233@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 10:46:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fSB6sB4fhnR=q17QT8mZnSeOj2Gxgm8CH9LO8ocQL_Q@mail.gmail.com>
Message-ID: <CAK8P3a2fSB6sB4fhnR=q17QT8mZnSeOj2Gxgm8CH9LO8ocQL_Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] printf: fix errname.c list
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:07 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 14/05/2021 23.34, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> >
> > diff --git a/lib/errname.c b/lib/errname.c
> > index 05cbf731545f..6c5c0aa4de75 100644
> > --- a/lib/errname.c
> > +++ b/lib/errname.c
> > @@ -21,6 +21,7 @@ static const char *names_0[] = {
> >       E(EADDRNOTAVAIL),
> >       E(EADV),
> >       E(EAFNOSUPPORT),
> > +     E(EAGAIN), /* EWOULDBLOCK */
> >       E(EALREADY),
> >       E(EBADE),
> >       E(EBADF),
> > @@ -38,8 +39,12 @@ static const char *names_0[] = {
>
> somewhere between EBADF and ECHRNG I'd expect a hunk dealing with the
> ECANCELED stuff
>
> > -     E(ECANCELED), /* ECANCELLED */
>
> but I only see this removal?
>
> Otherwise looks good.

Fixed now, v3 coming. Thanks!

        Arnd
