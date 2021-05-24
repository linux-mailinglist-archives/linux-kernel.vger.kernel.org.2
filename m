Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC838E38B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhEXJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:53:24 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:39667 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:53:23 -0400
Received: by mail-vk1-f180.google.com with SMTP id k22so3778885vko.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdID2BEuxoRnqjJsnNdl4my42gI0MVgfVoHurnKijwA=;
        b=ObcK2NKVFxl9rZpDd4SSJPNWAi446ulP0aCnFXgX9vc+gHo8u8vEhjF4dlt4KAsRSq
         56O30fzxaQX1i2Zu6wcL/vw9NkKGmGLh3EoUgJ4vKYrqttv/e8yQpyWekqWo8O8qHAkF
         7aQJGW7lEPuzGelHJujrt1kTE1cL9Jx7RRmQ8uwh9DQ5y26O39bJslGyBUAp45UTDH/h
         gWw/0KVQ7J+6kVLyMovDAQ63k5/tsgH33c8UBbuLEBNOddDkO5ZxPrtkB3/d+cZv0MIb
         wBUDXyFdeat0D84b/I5yBQchouW2TqHlhr1I7nCGQi3Z5FmX4BmhWTv47VKnN1GDKMRK
         xSfA==
X-Gm-Message-State: AOAM531s2Alte8v4KGhYqhdAVoOT2JbjRjoiAXx6GX3uT+DkzraFpISu
        0HoJ1fpTVqjSJfP4oBV3Ym43ZufUIURHZnIIUmkOnJj57ak=
X-Google-Smtp-Source: ABdhPJx4qhnfAbDvoVSQLLCsHe5xfGZBGFsXjTmrXn3OCkdcTtO5MMqbiWgwqk8gZ3uFbM45PN1NVOETyngX3sti6gI=
X-Received: by 2002:a1f:2504:: with SMTP id l4mr20263616vkl.5.1621849914064;
 Mon, 24 May 2021 02:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com> <YKt0v2etlFzpvE9r@kroah.com>
In-Reply-To: <YKt0v2etlFzpvE9r@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 May 2021 11:51:42 +0200
Message-ID: <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > No one checks the return value of debugfs_create_bool(), as it's not
> > > needed, so make the return value void, so that no one tries to do so in
> >
> > Please explain in the patch description why it is not needed.
>
> Because you just do not need it, like almost all other debugfs calls
> now.

Why do I just not need it?

> > > the future.
> > >
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -836,20 +836,11 @@ static const struct file_operations fops_bool_wo = {
> > >   * This function creates a file in debugfs with the given name that
> > >   * contains the value of the variable @value.  If the @mode variable is so
> > >   * set, it can be read from, and written to.
> > > - *
> > > - * This function will return a pointer to a dentry if it succeeds.  This
> > > - * pointer must be passed to the debugfs_remove() function when the file is
> > > - * to be removed (no automatic cleanup happens if your module is unloaded,
> >
> > Why isn't the above no longer true?
>
> Because there is no return value.

Why is there no longer a return value?
Please stop giving circular answers as justifications.

> > Are we no longer allowed to remove individual debugfs entries?
>
> It's not something that is almost ever needed.

Why not?

> > Do we always have to remove the whole parent directory and all its
> > contents together?
>
> For 99% of all debugfs usages, yes, that is true.

So 1% of the users still need it...

> If you really do need the file dentry, there is still a call to create
> it, and you can always query debugfs for the dentry after it is created

... and will have to duplicate debugfs_create_bool() and friends, but
with a return value.  This may introduce bugs, and will complicate
maintenance, as any change to debugfs_create_bool() means all those
copies need to be found and updated, too.

> if you need it later on.

Which involves looking up something again...

Seriously, what's the added value of removing the return value from
debugfs_create_bool() and friends?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
