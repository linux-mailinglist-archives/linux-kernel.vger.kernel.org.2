Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33138FBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEYH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:28:25 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35622 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhEYH2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:28:24 -0400
Received: by mail-ua1-f44.google.com with SMTP id n61so10191754uan.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXZkjhCQ7sxUkuHaaJvM/JXZLOVoSU0Wou+b5VUjoGs=;
        b=eSmwPT0xJPsHwzMb1IDcs7I0S8ymGB8F/bpdJyAYyYVGzNqskHA8POm/Urbiif9PqD
         Q9+yOhJQNQjy/OKG7Gmsp48TUM2/X0Tl1Zrqngn5eFiv31Xqp+i1s6zLmQ+NPgvw8kfO
         7fswkN2/5lBZZh2FKJLM7gd0E8AjvU8yNzfVS9hE5mDsPcS9k6NF8G7qBMVUdOXuN5ny
         mZe0DR0CZPsnnhZySGYQQL78m0Z8Qv1z3wjl7tpcKJDKG7xEoY3++lqzT28I8zmI3ebS
         iQkNWHmo/PJ6kA1CxirRjwlZNPcncawZ7IKygzqYvuE9GahWgVkc4sKVUCY1x2UZyetc
         CUfw==
X-Gm-Message-State: AOAM532qQmV3TlqLSGMqYcpqu1qTJU8spnNYhw+ifYVCLfgxjsnBtI/e
        BV6pX0DOZic78C38FPBbIpWSXY+uy+JC389NaxahBHjhi/0=
X-Google-Smtp-Source: ABdhPJypqab8D8E09U3fDEzhIHo58PbEOJoqq65UAWKSKeC+uoekGSEbAE0TjyUTI8g2r43fRa1xBP3CbtUVZEjJQLo=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr26006350uar.4.1621927614112;
 Tue, 25 May 2021 00:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
 <YKt0v2etlFzpvE9r@kroah.com> <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
 <YKt9Z82KbBQZIWVl@kroah.com> <CAMuHMdXbSyresZNUqq-g4=HNFXqtj2QkPpN1s0LRjmOnNPxn8w@mail.gmail.com>
 <YKuedipmEjIW91Jr@kroah.com>
In-Reply-To: <YKuedipmEjIW91Jr@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 May 2021 09:26:42 +0200
Message-ID: <CAMuHMdUhSKFrcaiB0KHsgg1=4_RX3XjUpzMV=Y=RxErRmsn=sA@mail.gmail.com>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, May 24, 2021 at 2:39 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 24, 2021 at 01:44:38PM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 24, 2021 at 12:18 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, May 24, 2021 at 11:51:42AM +0200, Geert Uytterhoeven wrote:
> > > > On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > > > > > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > No one checks the return value of debugfs_create_bool(), as it's not
> > > > > > > needed, so make the return value void, so that no one tries to do so in
> > > > > >
> > > > > > Please explain in the patch description why it is not needed.
> > > > >
> > > > > Because you just do not need it, like almost all other debugfs calls
> > > > > now.
> > > >
> > > > Why do I just not need it?
> > >
> > > Let me flip it around, why do you need it?  There are no in-kernel users
> > > of the return value anymore so what code requires this pointer now?
> >
> > There still are a few users of other members in the family, and some
> > of them are meant to be removed without removing the full parent
> > directory.  Having all debugfs_create_*() functions behave the same
> > is a bonus.
>
> I agree, and we are almost there, all that is left is:
>         debugfs_create_blob()
>         debugfs_create_file()
>         debugfs_create_file_unsafe()
> for creating debugfs files.
>
> There is still:
>         debugfs_create_dir()
>         debugfs_create_symlink()
>         debugfs_create_automount()
> for non-file creations that do not return void.
>
> The majority of the debugfs_create_* functions now do not return
> anything.
>
> > But if other people are fine with having to call
> > debugfs_remove(debugfs_lookup(...)), well, let it be like that...
>
> It saves at least a static variable, so what's not to like?  :)

Which is more than offset by the cost of the new debugfs_lookup() call...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
