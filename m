Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FA311318
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhBEVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhBETMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:12:07 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098EC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:53:52 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id e5so1361505otb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PRi5FG8/+JWu+jWzUkXoHnN4JWoS4p+oSPjz4dHX4E=;
        b=OASnDCXTrffqrxPZSX+X2BoOBJSJeWYxtAIhsNCtVNhz5gMXxmVx/jYGnsUN9nnJuN
         vhfjMJNVrRb2wgVEK4+xSY1vgWYsPum4Jw0tHUrjZI6XNfx7htArAF/NC/hE/qfZg0zE
         Q6EogytHRY9X2yLHj2BIhrsaED0mM8FE6XIoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PRi5FG8/+JWu+jWzUkXoHnN4JWoS4p+oSPjz4dHX4E=;
        b=NUTp1xyrUFNMlokGmgiW3YThJzHESoMXgD4ug6wUZPyK9FB/wk47XxDar55UtBKZ5C
         Hv92PCRNfBtT219UXIToEdafpDsvuCSvYz8BNLfZAfRzOd31j5YZ8rseDRQfghFWg394
         Up66mppNywWGcMeMUbkUZ4RHOHu0CpM2sb2zz2GGsW8y25xNVoD5uPZXIj/YGBUm3LiA
         ybdfyYGVMHDbcgtykDaKA3Wk2J1L8n0Y3bvI6+0LdTctDnCAjiWMq0rBCwFfUkHBnNde
         69jzcdxWIOtW+pywNbBfq5JTym11qKqhY2Qi7vnfDMCN7IMq9gGfGtxvPKhu5Upxbv44
         oBeg==
X-Gm-Message-State: AOAM5304EkssIKZ3mmx/5zOPXOQMCUpmKWDhVq8hUylxsDjtY+Te++bM
        lwGizLH8OzICXaZkcYj2z2lf7JENDxwxQqL9BTuJtQ==
X-Google-Smtp-Source: ABdhPJzg/0sRpmAYdxePGbdJtZika7yemD79/03eRrmz2fmH3+4sjo2UBY/XCbjTjR0SqL2Ey0KOyRS9uFFIs7Vpmkg=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr4848871oth.281.1612558431545;
 Fri, 05 Feb 2021 12:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20210205163752.11932-1-chris@chris-wilson.co.uk> <202102051030.1AF01772D@keescook>
In-Reply-To: <202102051030.1AF01772D@keescook>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Feb 2021 21:53:40 +0100
Message-ID: <CAKMK7uHnOA9CuRxcKkcqG8duOw_3dZobkThcV7Q_swMXVoLCkQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Expose SYS_kcmp by default
To:     Kees Cook <keescook@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Feb 05, 2021 at 04:37:52PM +0000, Chris Wilson wrote:
> > Userspace has discovered the functionality offered by SYS_kcmp and has
> > started to depend upon it. In particular, Mesa uses SYS_kcmp for
> > os_same_file_description() in order to identify when two fd (e.g. device
> > or dmabuf) point to the same struct file. Since they depend on it for
> > core functionality, lift SYS_kcmp out of the non-default
> > CONFIG_CHECKPOINT_RESTORE into the selectable syscall category.
> >
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  init/Kconfig                                  | 11 +++++++++++
> >  kernel/Makefile                               |  2 +-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index b77c60f8b963..f62fca13ac5b 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1194,6 +1194,7 @@ endif # NAMESPACES
> >  config CHECKPOINT_RESTORE
> >       bool "Checkpoint/restore support"
> >       select PROC_CHILDREN
> > +     select KCMP
> >       default n
> >       help
> >         Enables additional kernel features in a sake of checkpoint/restore.
> > @@ -1737,6 +1738,16 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config KCMP
> > +     bool "Enable kcmp() system call" if EXPERT
> > +     default y
>
> I would expect this to be not default-y, especially if
> CHECKPOINT_RESTORE does a "select" on it.
>
> This is a really powerful syscall, but it is bounded by ptrace access
> controls, and uses pointer address obfuscation, so it may be okay to
> expose this. As it is, at least Ubuntu already has
> CONFIG_CHECKPOINT_RESTORE, so really, there's probably not much
> difference on exposure.
>
> So, if you drop the "default y", I'm fine with this.

It was maybe stupid, but our userspace started relying on fd
comaprison through sys_kcomp. So for better or worse, if you want to
run the mesa3d gl/vk stacks, you need this. Was maybe not the brighest
ideas, but since enough distros had this enabled by defaults, it
wasn't really discovered, and now we're shipping this everywhere.

Ofc we can leave the default n, but the select if CONFIG_DRM is
unfortunately needed I think. For that part:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also adding Dave Airlie for his take.
-Daniel

>
> -Kees
>
> > +     help
> > +       Enable the file descriptor comparison system call. It provides
> > +       user-space with the ability to compare two fd to see if they
> > +       point to the same file, and check other attributes.
> > +
> > +       If unsure, say Y.
> > +
> >  config RSEQ
> >       bool "Enable rseq() system call" if EXPERT
> >       default y
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index aa7368c7eabf..320f1f3941b7 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -51,7 +51,7 @@ obj-y += livepatch/
> >  obj-y += dma/
> >  obj-y += entry/
> >
> > -obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
> > +obj-$(CONFIG_KCMP) += kcmp.o
> >  obj-$(CONFIG_FREEZER) += freezer.o
> >  obj-$(CONFIG_PROFILING) += profile.o
> >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index 26c72f2b61b1..1b6c7d33c4ff 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -315,7 +315,7 @@ TEST(kcmp)
> >       ret = __filecmp(getpid(), getpid(), 1, 1);
> >       EXPECT_EQ(ret, 0);
> >       if (ret != 0 && errno == ENOSYS)
> > -             SKIP(return, "Kernel does not support kcmp() (missing CONFIG_CHECKPOINT_RESTORE?)");
> > +             SKIP(return, "Kernel does not support kcmp() (missing CONFIG_KCMP?)");
> >  }
> >
> >  TEST(mode_strict_support)
> > --
> > 2.20.1
> >
>
> --
> Kees Cook



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
