Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D941D382CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhEQNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhEQNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:11:56 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0653C06138B
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:10:30 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so1450888ooa.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAwEga9MsVbe/5u0H4dGqnZ+LwHKVSj8ppgsSx/dwXA=;
        b=OqI9STlkR7u8mi0tTXuV5SyeZialb8aH253QDX1o+zeoCJ+S5gkI85n74dHCZFGZBj
         ciyUa3BieaaWvJ/XofZxNU4eItL61acH6SFLNcUyfjmgkFxOv0X3HqAsEYSRKc8UaEPb
         CR56j6NK/wn5NCcRHFQktnOm55tx52mvWG/RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAwEga9MsVbe/5u0H4dGqnZ+LwHKVSj8ppgsSx/dwXA=;
        b=NiGvuH+I9pHb2VmAA4OaLcMsjWZtR4Dxe2Wgd8Q4DgJnVgdlS8MS2f2BldjHglF9BC
         gbsR/w9SDrUX7SJy4D5cIIX9wrRJ38MApJxOgUPb3yIRg33MIq7UcXCaKV7SWm921Kcb
         7Le+gjVSF5drIkBJXQWVFfynDFod11f/SxzZNdOFupphU4+WLElC3ajFTXnP+U88Qq2z
         Nd9X89FKnv1bZNwzhoOMc4e3yxog6Thnbz4eOGYHYe/jh1K8WmGbcJfmW63mbbcjG+Op
         c3ceRnrrkYm6mFiLf/FZtic4flidcTPZOzeodFl2zFkjCgQaN5/fWsnEK71XxhHMsY3P
         IckQ==
X-Gm-Message-State: AOAM532Gmu2DNJHToOibNa+XoUwcUtFS4dD1FcoME8LpUkiQnraGqUCY
        tsNKbaVscPV/I7jiSwVXa0AnfFszCCuo97aXzVxMcA==
X-Google-Smtp-Source: ABdhPJzFaSHRb7QuxFF/A3nf7goNfiB9Dxae23DnvcuYbdfw7QRmTBAoqHPvKmf8Utr2ioPitAchQ4NTWof0wYag0JU=
X-Received: by 2002:a4a:8e04:: with SMTP id q4mr1459797ook.28.1621257030052;
 Mon, 17 May 2021 06:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
 <CAKMK7uGLP2zn7LX4ATExA4DLo16shVivSd_W58X-rBZNPSb3_w@mail.gmail.com>
In-Reply-To: <CAKMK7uGLP2zn7LX4ATExA4DLo16shVivSd_W58X-rBZNPSb3_w@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 May 2021 15:10:19 +0200
Message-ID: <CAKMK7uFfuV1GH7rvTwLCovnWvd0hYXPGbAyYELoX9PqZn3u2gQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 3:07 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, May 14, 2021 at 10:33 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, May 14, 2021 at 1:25 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > >
> > >  Overall I think it does make sense to resize the text console at any
> > > time, even if the visible console (VT) chosen is in the graphics mode,
> >
> > It might make sense, but only if we call the function to update the
> > low-level data.
> >
> > Not calling it, and then starting to randomly use the (wrong)
> > geometry, and just limiting it so that it's all within the buffer -
> > THAT does not make sense.
> >
> > So I think your patch is fundamentally wrong. It basically says "let's
> > use random stale incorrect data, but just make sure that the end
> > result is still within the allocated buffer".
> >
> > My patch is at least conceptually sane.
> >
> > An alternative would be to just remove the "vcmode != KD_GRAPHICS"
> > check entirely, and always call con_resize() to update the low-level
> > data, but honestly, that seems very likelty to break something very
> > fundamentally, since it's not how any of fbcon has ever been tested,
>
> Just an aside: I think with fbdev drivers this would go boom, because
> you'd have fbcon interferring with a direct /dev/fb/* user.

Boom here means a bit of screen corruption, because fbcon overdraws
your X sessions. Fixed by the next redraw of X.

> But if your fbdev driver is actually a drm modeset driver, then we
> have additional limitations: If the userspace accesses the display
> through /dev/dri/card0, then the kernel blocks all access through
> /dev/fb/* (including fbcon) to the actual display (it only goes into
> the buffer used for fbdev emulation). And everything would be fine.
>
> Also generally you'd get away with this even in problematic cases,
> since usually you resize your console when looking at it, not when X
> or something else is using your fbdev direct access.
>
> The one thing that's left out here a bit in the cold is userspace
> modeset drivers in X. Those would get hosed. But also, we stopped
> supporting those in at least i915/amd/radeon/nouveau drivers,
> automatically falling back to the fbdev stuff in most cases (with or
> without the drm drivers underneath that), and no one screamed. So
> probably not many users left.

This one could lead to incosistent hw state, which would be worse.

> So I /think/ we could wager this, if it's the least intrusive fix from
> the kernel pov. But it has some risks that we need to revert again if
> we break some of the really old use-cases here.

Cheers, Daniel

> > Another alternative would be to just delay the resize to when vcmode
> > is put back to text mode again. That sounds somewhat reasonable to me,
> > but it's a pretty big thing.
> >
> > But no, your patch to just "knowingly use entirely wrong values, then
> > add a limit check because we know the values are possibly garbage and
> > not consistent with reality" is simply not acceptable.
> >
> >               Linus
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
