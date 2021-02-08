Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D388313366
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBHNfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBHNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:35:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58672C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:34:45 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l3so5623965oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+rh3VIoqOrGwusI9h0cuVUIU9NsYcE7oeMVzHyfRzoI=;
        b=hB1ukZ3hoMZGhAllFBErV7N1AFMTquB7yDzf6rqITLG3vEHpPskWBPsoGr/LJ4FDs2
         JBGrfhoJRkitAHftGJgKHMHyaoy/8UIAZVWPTbK9GwwWpbJAs8jOquMkV+6Iyt49/JK/
         dm60/8Qc15QlQaSmYBOCpojXt93LlqHmyj1K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+rh3VIoqOrGwusI9h0cuVUIU9NsYcE7oeMVzHyfRzoI=;
        b=XsTUKsUB7/BRFemewX0O5L0zWj1kpinZboUoLI42F62fdvjUc9Kmey/EUfJVy8m+fl
         Eah+d69eCjMsqZZIhmjl1MUaClv3/foiZfqbTrSX8C7gpbR0RevXEOrKuoe09k1+oZbm
         G68fao39uUx2UwJVnOwRrgFwyLVc566Hoie9YttWB10mDkFnXoAp24qpA/4PWEWfyUea
         G/HVC9K27aWPGbOyffHF/RYGVF5HNO7hZ/q/98Y41L1PwO3NFgJSFa2pehr/rhonp6gQ
         jd/qpBwh533RQCsIFeUmtfJOg/hF3mZAyrTOzI1ylUtVPA27oigAKEn+d/d2LglilcvC
         Yxig==
X-Gm-Message-State: AOAM5312CZdHugVg1DqELGJAYXzC9DF2x+P9wiQRX40Rgc5Hc7Z2aKud
        xCNX2dDLM0YtAKLLoaTQCT4Zo+TlRmWykTcZH23Eig==
X-Google-Smtp-Source: ABdhPJzcCBZ5ebH9ls50JbefCANUYJj+tEOE+UxhLQz0ddtWCRZfXoEeuq24S9E7Uz2YBp0mSSwxHV1MwcuEgMnzwdg=
X-Received: by 2002:a05:6808:294:: with SMTP id z20mr3250377oic.14.1612791284710;
 Mon, 08 Feb 2021 05:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20210205163752.11932-1-chris@chris-wilson.co.uk>
 <202102051030.1AF01772D@keescook> <CAKMK7uHnOA9CuRxcKkcqG8duOw_3dZobkThcV7Q_swMXVoLCkQ@mail.gmail.com>
 <5a940e13-8996-e9e5-251e-a9af294a39ff@daenzer.net>
In-Reply-To: <5a940e13-8996-e9e5-251e-a9af294a39ff@daenzer.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 8 Feb 2021 14:34:33 +0100
Message-ID: <CAKMK7uG_0AkZpwahb7gJppo15u1isACH=FB_oMAaw-3uJiwGKQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Expose SYS_kcmp by default
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:49 PM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2021-02-05 9:53 p.m., Daniel Vetter wrote:
> > On Fri, Feb 5, 2021 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Fri, Feb 05, 2021 at 04:37:52PM +0000, Chris Wilson wrote:
> >>> Userspace has discovered the functionality offered by SYS_kcmp and ha=
s
> >>> started to depend upon it. In particular, Mesa uses SYS_kcmp for
> >>> os_same_file_description() in order to identify when two fd (e.g. dev=
ice
> >>> or dmabuf) point to the same struct file. Since they depend on it for
> >>> core functionality, lift SYS_kcmp out of the non-default
> >>> CONFIG_CHECKPOINT_RESTORE into the selectable syscall category.
> >>>
> >>> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: Andy Lutomirski <luto@amacapital.net>
> >>> Cc: Will Drewry <wad@chromium.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Dave Airlie <airlied@gmail.com>
> >>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>> Cc: Lucas Stach <l.stach@pengutronix.de>
> >>> ---
> >>>   init/Kconfig                                  | 11 +++++++++++
> >>>   kernel/Makefile                               |  2 +-
> >>>   tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
> >>>   3 files changed, 13 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/init/Kconfig b/init/Kconfig
> >>> index b77c60f8b963..f62fca13ac5b 100644
> >>> --- a/init/Kconfig
> >>> +++ b/init/Kconfig
> >>> @@ -1194,6 +1194,7 @@ endif # NAMESPACES
> >>>   config CHECKPOINT_RESTORE
> >>>        bool "Checkpoint/restore support"
> >>>        select PROC_CHILDREN
> >>> +     select KCMP
> >>>        default n
> >>>        help
> >>>          Enables additional kernel features in a sake of checkpoint/r=
estore.
> >>> @@ -1737,6 +1738,16 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >>>   config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >>>        bool
> >>>
> >>> +config KCMP
> >>> +     bool "Enable kcmp() system call" if EXPERT
> >>> +     default y
> >>
> >> I would expect this to be not default-y, especially if
> >> CHECKPOINT_RESTORE does a "select" on it.
> >>
> >> This is a really powerful syscall, but it is bounded by ptrace access
> >> controls, and uses pointer address obfuscation, so it may be okay to
> >> expose this. As it is, at least Ubuntu already has
> >> CONFIG_CHECKPOINT_RESTORE, so really, there's probably not much
> >> difference on exposure.
> >>
> >> So, if you drop the "default y", I'm fine with this.
> >
> > It was maybe stupid, but our userspace started relying on fd
> > comaprison through sys_kcomp. So for better or worse, if you want to
> > run the mesa3d gl/vk stacks, you need this.
>
> That's overstating things somewhat. The vast majority of applications
> will work fine regardless (as they did before Mesa started using this
> functionality). Only some special ones will run into issues, because the
> user-space drivers incorrectly assume two file descriptors reference
> different descriptions.
>
>
> > Was maybe not the brighest ideas, but since enough distros had this
> > enabled by defaults,
>
> Right, that (and the above) is why I considered it fair game to use.
> What should I have done instead? (TBH I was surprised that this
> functionality isn't generally available)

Yeah that one is fine, but I thought we've discussed (irc or
something) more uses for de-duping dma-buf and stuff like that. But
quick grep says that hasn't landed yet, so I got a bit confused (or
just dreamt). Looking at this again I'm kinda surprised the drmfd
de-duping blows up on normal linux distros, but I guess it can all
happen.

> > it wasn't really discovered, and now we're
> > shipping this everywhere.
>
> You're making it sound like this snuck in secretly somehow, which is not
> true of course.
>
>
> > Ofc we can leave the default n, but the select if CONFIG_DRM is
> > unfortunately needed I think.
>
> Per above, not sure this is really true.

We seem to be going boom on linux distros now, maybe userspace got
more creative in abusing stuff? The entire thing is small enough that
imo we don't really have to care, e.g. we also unconditionally select
dma-buf, despite that on most systems there's only 1 gpu, and you're
never going to end up with a buffer sharing case that needs any of
that code (aside from the "here's an fd" part).

But I guess we can limit to just KCMP_FILE like you suggest in another
reply. Just feels a bit like overkill.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
