Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4130531136D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhBEVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhBEVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:21:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D6C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:20:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 8so4199513plc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZYhyH/UoKAZ0pUR5GxFLgA12f7+59pz9aTtQWcg/Skw=;
        b=R02SrSjetAsxFVmsYiUkEaJlwQ55nZeZL2cuCV8kSBOiUaZp+orsa3k1DkBH8r1o+O
         K8nZlJWEmJYwLWIcMeuHoNjCU7WwUO05WaeDd2OSjhi3CUfrp7ekX8vcjLmxTBoLdCm/
         F1sJLEErN2lZYfcW48Wiw43kdbDCng5x9MENg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYhyH/UoKAZ0pUR5GxFLgA12f7+59pz9aTtQWcg/Skw=;
        b=dCOzeZvIXQAYNpX9R07efVYYcPvCsA+WN0ObIN+ly0UCdGCuRZKn4Xlgn/EIH/FmvY
         d/7LRUJ5VIvs3HIrTOOj8KEXP3BJdQStfBi0eH/VMae2UCzNWpLskZom8NHBitAaoBe+
         WKrTx06nQkmXHF8McZAdGkong2wz5F0oXhA/Uqx2wOqaN9DmDPatSAyDXXsTnKv6fwDb
         xsl69NDhg70jWL87RUn07zZvA/4k62qgHdBbfBHBBFFArC8L8P+3zA9XbOGPQRnvqtAj
         CcggXbWF4WN2ttqfd8qvwxWtqIehiXIdShCwoZW0uuiJqvNNqxdqML6vlxJbxxCKpBo3
         MyJA==
X-Gm-Message-State: AOAM530z1q6CcPpsL5AivgDmobc4Xo1G8GlTkAX/XAjGvlSXFyRjtQ7w
        nWjPCgZB/SOi2CE6Q+MO0MzgNw==
X-Google-Smtp-Source: ABdhPJwu85fzWnYg65UdufVcnja7D169FBdJJ4/E0S/U4P8nrMrT7ItVPkNRWfYlV2eGz5u6W5tkgA==
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr5843284pjb.196.1612560035614;
        Fri, 05 Feb 2021 13:20:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 12sm9167516pjm.28.2021.02.05.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:20:34 -0800 (PST)
Date:   Fri, 5 Feb 2021 13:20:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2] kernel: Expose SYS_kcmp by default
Message-ID: <202102051319.E5D8B4528D@keescook>
References: <20210205163752.11932-1-chris@chris-wilson.co.uk>
 <20210205210610.29837-1-chris@chris-wilson.co.uk>
 <161255976138.12021.9385501710085642237@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161255976138.12021.9385501710085642237@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 09:16:01PM +0000, Chris Wilson wrote:
> The subject should of course be changed, as it is no longer being
> enabled by default.

"default n" is redundant. I thought Daniel said CONFIG_DRM needed to
"select" it too, though? Otherwise, yeah, this looks good. Was the
export due to the 0-day bot failure reports?

-Kees

> 
> Something like
> 
> kcmp: Support selection of SYS_kcmp without CHECKPOINT_RESTORE
> 
> Quoting Chris Wilson (2021-02-05 21:06:10)
> > Userspace has discovered the functionality offered by SYS_kcmp and has
> > started to depend upon it. In particular, Mesa uses SYS_kcmp for
> > os_same_file_description() in order to identify when two fd (e.g. device
> > or dmabuf) point to the same struct file. Since they depend on it for
> > core functionality, lift SYS_kcmp out of the non-default
> > CONFIG_CHECKPOINT_RESTORE into the selectable syscall category.
> > 
> > Note that some distributions such as Ubuntu are already enabling
> > CHECKPOINT_RESTORE in their configs and so, by extension, SYS_kcmp.
> > 
> > References: https://gitlab.freedesktop.org/drm/intel/-/issues/3046
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> # DRM depends on SYS_kcmp
> > 
> > ---
> > v2:
> >   - Default n.
> >   - Borrrow help message from man kcmp.
> >   - Export get_epoll_tfile_raw_ptr() for CONFIG_KCMP
> > ---
> >  fs/eventpoll.c                                |  4 ++--
> >  include/linux/eventpoll.h                     |  2 +-
> >  init/Kconfig                                  | 12 ++++++++++++
> >  kernel/Makefile                               |  2 +-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
> >  5 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index a829af074eb5..3196474cbe24 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -979,7 +979,7 @@ static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
> >         return epir;
> >  }
> >  
> > -#ifdef CONFIG_CHECKPOINT_RESTORE
> > +#ifdef CONFIG_KCMP
> >  static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long toff)
> >  {
> >         struct rb_node *rbp;
> > @@ -1021,7 +1021,7 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
> >  
> >         return file_raw;
> >  }
> > -#endif /* CONFIG_CHECKPOINT_RESTORE */
> > +#endif /* CONFIG_KCMP */
> >  
> >  /**
> >   * Adds a new entry to the tail of the list in a lockless way, i.e.
> > diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> > index 0350393465d4..593322c946e6 100644
> > --- a/include/linux/eventpoll.h
> > +++ b/include/linux/eventpoll.h
> > @@ -18,7 +18,7 @@ struct file;
> >  
> >  #ifdef CONFIG_EPOLL
> >  
> > -#ifdef CONFIG_CHECKPOINT_RESTORE
> > +#ifdef CONFIG_KCMP
> >  struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long toff);
> >  #endif
> >  
> > diff --git a/init/Kconfig b/init/Kconfig
> > index b77c60f8b963..1b75141bc18b 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1194,6 +1194,7 @@ endif # NAMESPACES
> >  config CHECKPOINT_RESTORE
> >         bool "Checkpoint/restore support"
> >         select PROC_CHILDREN
> > +       select KCMP
> >         default n
> >         help
> >           Enables additional kernel features in a sake of checkpoint/restore.
> > @@ -1737,6 +1738,17 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >         bool
> >  
> > +config KCMP
> > +       bool "Enable kcmp() system call" if EXPERT
> > +       default n
> > +       help
> > +         Enable the kernel resource comparison system call. It provides
> > +         user-space with the ability to compare two processes to see if they
> > +         share a common resource, such as a file descriptor or even virtual
> > +         memory space.
> > +
> > +         If unsure, say N.
> > +
> >  config RSEQ
> >         bool "Enable rseq() system call" if EXPERT
> >         default y
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
> >         ret = __filecmp(getpid(), getpid(), 1, 1);
> >         EXPECT_EQ(ret, 0);
> >         if (ret != 0 && errno == ENOSYS)
> > -               SKIP(return, "Kernel does not support kcmp() (missing CONFIG_CHECKPOINT_RESTORE?)");
> > +               SKIP(return, "Kernel does not support kcmp() (missing CONFIG_KCMP?)");
> >  }
> >  
> >  TEST(mode_strict_support)
> > -- 
> > 2.20.1
> >

-- 
Kees Cook
