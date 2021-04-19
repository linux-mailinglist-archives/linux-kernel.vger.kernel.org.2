Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1517836396A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhDSCfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhDSCff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:35:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6ACC06174A;
        Sun, 18 Apr 2021 19:35:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m7so26764005ljp.10;
        Sun, 18 Apr 2021 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TffcU7lYyg8IkgSpttLQB1q4lz0f/EHk5Dwj6/ZuyBQ=;
        b=VJ3zCupy+zbnCzFn7yTb6Ht9u6BBJxWosmf8PdP1hHhl+K+8IMuRCCzYOvpjVqz3e2
         kAvAh5WD2rzpkIA2qWGxEzF2lnkNtw4HYD+oUMLPIzQHn4YqrD4zz2P+yO9yxnMoqdSy
         sgdi6klWg5rULNWFrsK2zO1v0yWDN5jR/l2GTuaricB7Z5XARDRj3fjWRle8tXGedhix
         A9NFc2bEMghW67w8iRRaAvvUMAfgHfOrlRV6cIftQqrOL+GtOe7fpud7/D32DKi1qz70
         FdVRKIkDGjfLma3E0yuT9uq3tq/AOlVojhWzPulOcbWMqfJ+NL+RFqw2QBv9+pvl1kCA
         xBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TffcU7lYyg8IkgSpttLQB1q4lz0f/EHk5Dwj6/ZuyBQ=;
        b=Hq9YCuUMpOe+Xb11s+SN2o8AYAblQon8KkuTvKCOp6ZXCEYwIU4IdDfvSpVJ3xO5YQ
         UvD3dAoY8/svX3bfnUHhOa9+IFhltGuUk0t8bB/pYU15ioWmbEptoI7sbKIedWuAfKiZ
         pbWPpwsDKF0X0dGqsx3hkDkPM0sqPuxTaRd34JD/O4sVMPcfvOBvMCV54XzV7mbXTaVJ
         ve/ymdXLTD2dxGGsazydqeCejmIJdRNfbB39FsBukqaD37UDT7MvioJNslP5/pDuTBe6
         7DHqm+R8KafiiEkFNo96bSC1LqQwvUtKcWYAatETQq/Kda5ONqBqkTBBhZuCs+ZReHQq
         Rt+A==
X-Gm-Message-State: AOAM533wzELqe7aotSCndPdXCzpowNwD9lLdHAiB6OY659hrgZNsMqbD
        99zNt1gW5yGyp5Pks7wU9zr399n/URoy72lsDdM=
X-Google-Smtp-Source: ABdhPJxIrTYCbftjU2oRa0zYTFqNKD6CalXZZkAitvkpxVJUpODmWAwlWSCxqZSxDaOdYm9aZKO0diC5x8kzvuyklpI=
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr9714166ljp.323.1618799705338;
 Sun, 18 Apr 2021 19:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316054727.25655-1-foxhlchen@gmail.com> <20210316054727.25655-13-foxhlchen@gmail.com>
 <87mttv11bd.fsf@notabene.neil.brown.name>
In-Reply-To: <87mttv11bd.fsf@notabene.neil.brown.name>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 10:34:54 +0800
Message-ID: <CAC2o3DJ6o6w9WO=QwsZjTG7TU+Jvr_My9Mxp+WR5y3EeTLmdDQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] docs: path-lookup: update symlink description
To:     NeilBrown <neilb@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, vegard.nossum@oracle.com,
        Al Viro <viro@zeniv.linux.org.uk>, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 9:59 AM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, Mar 16 2021, Fox Chen wrote:
>
> > instead of lookup_real()/vfs_create(), i_op->lookup() and
> > i_op->create() will be called directly.
> >
> > update vfs_open() logic
> >
> > should_follow_link is merged into lookup_last() or open_last_lookup()
> > which returns symlink name instead of an integer.
> >
> > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > ---
> >  Documentation/filesystems/path-lookup.rst | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
> > index eef6e9f68fba..adbc714740c2 100644
> > --- a/Documentation/filesystems/path-lookup.rst
> > +++ b/Documentation/filesystems/path-lookup.rst
> > @@ -1202,16 +1202,15 @@ the code.
> >     it.  If the file was found in the dcache, then ``vfs_open()`` is used for
> >     this.  If not, then ``lookup_open()`` will either call ``atomic_open()`` (if
> >     the filesystem provides it) to combine the final lookup with the open, or
> > -   will perform the separate ``lookup_real()`` and ``vfs_create()`` steps
> > +   will perform the separate ``i_op->lookup()`` and ``i_op->create()`` steps
> >     directly.  In the later case the actual "open" of this newly found or
> >     created file will be performed by ``vfs_open()``, just as if the name
> >     were found in the dcache.
> >
> >  2. ``vfs_open()`` can fail with ``-EOPENSTALE`` if the cached information
> > -   wasn't quite current enough.  Rather than restarting the lookup from
> > -   the top with ``LOOKUP_REVAL`` set, ``lookup_open()`` is called instead,
> > -   giving the filesystem a chance to resolve small inconsistencies.
> > -   If that doesn't work, only then is the lookup restarted from the top.
> > +   wasn't quite current enough.  If it's in RCU-walk -ECHILD will be returned
> > +   otherwise will return -ESTALE.  When -ESTALE is returned, the caller may
>
> "otherwise -ESTALE is returned".
> If you don't like repeating "is returned", then maybe:
>   "... -ECHILD will be returned, otherwise the result is -ESTALE".
>
>
> > +   retry with LOOKUP_REVAL flag set.
> >
> >  3. An open with O_CREAT **does** follow a symlink in the final component,
> >     unlike other creation system calls (like ``mkdir``).  So the sequence::
> > @@ -1221,8 +1220,8 @@ the code.
> >
> >     will create a file called ``/tmp/bar``.  This is not permitted if
> >     ``O_EXCL`` is set but otherwise is handled for an O_CREAT open much
> > -   like for a non-creating open: ``should_follow_link()`` returns ``1``, and
> > -   so does ``do_last()`` so that ``trailing_symlink()`` gets called and the
> > +   like for a non-creating open: ``lookup_last()`` or ``open_last_lookup()``
> > +   returns a non ``Null`` value, and ``link_path_walk()`` gets called and the
>
> "NULL", not "Null".
>
> This those changes,
>  Reviewed-by: NeilBrown <neilb@suse.de>
>
> Thanks for a lot of all these improvements!! and apologies for the delay
> in the review.

Thanks for the review, I will fix them and send the next version back.


> Thanks,
> NeilBrown
>
>
> >     open process continues on the symlink that was found.
> >
> >  Updating the access time
> > --
> > 2.30.2


thanks,
fox
