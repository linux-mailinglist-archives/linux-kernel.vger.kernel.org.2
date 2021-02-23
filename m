Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59E322A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhBWMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232856AbhBWMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614081703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYiJ0mpq+DNmuke6gplH0L/qFhGMbAEVJh8dW/65qpQ=;
        b=grRN88ZrldPptBQW8p/kxVlyKxm4e6sOmxg8bBqQEspIc5cnbkPUUya/Wzt7c6mQTm+kgc
        z8jBqwH2VDAOmh3IHgjrDZuPZ1NgwbyPK8HNNbUAMUbk+6SOMkEXoEW4xdSsXaAYPyFxCa
        HHAjs8jPN74kZAs6F3Y7DB6GFtyDvjI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-yrvFbVIzNGCUSti0yn-IsQ-1; Tue, 23 Feb 2021 07:01:42 -0500
X-MC-Unique: yrvFbVIzNGCUSti0yn-IsQ-1
Received: by mail-il1-f200.google.com with SMTP id i16so10058328ila.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYiJ0mpq+DNmuke6gplH0L/qFhGMbAEVJh8dW/65qpQ=;
        b=PXMUZOOby3Bo6otyWS1ayvdzN7sRshdJycSd+xOpehsRhZNJ8+l+TMyyifDvN1irMB
         lj5FrNrp1AK60PiieDaVRZayXEqW/GI2fCfmmCKnHym32QYW1ZZVkfIoJc0gY5quNsnD
         6kRr+x9SruZXol/4GIS//QrSiZLkbClgPqc4B3SEjzWOxZ+VBZNTy/Ew+TdJlBxVRAas
         f369Xh6e1NYiz/XGr8Lh//Tixp93MMqap+U/PdvAkuGVw2XrEZbubTgFKc3b1NgdKfwF
         i8Rh5/boyeySzBaS3zk3Ec8F5WYv8Ixu1DPBvlGjfeunN2GxmOQIjxjj30XgR8NjKmzv
         m2jA==
X-Gm-Message-State: AOAM530d0Hiw0Z4hMJ4UXtFnOGgIXe6TFRg0XmwazEAjiTnMwaVnr8TD
        FHtxUNKA0B3KV6mjBPkrTg3AThm55RvYVlcWP974GuUuRC0xDySuOQ82YDF7frvGwkXUHCkSjUt
        ZHYQF9ik/1w7lJfOkUNR84LQ7Dl1i3wpBpKwBQ6yg
X-Received: by 2002:a5d:9d58:: with SMTP id k24mr19798877iok.125.1614081700146;
        Tue, 23 Feb 2021 04:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNLvAXSafwGqdZZFaTas0FLihFOGhvMjRK0amYkWnxpwHA1TTYtvZMCONGJXqw7T0ab8jEDMBQlOBa/v0ffw4=
X-Received: by 2002:a5d:9d58:: with SMTP id k24mr19798848iok.125.1614081699952;
 Tue, 23 Feb 2021 04:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com> <20210218020203.GC2871@MiWiFi-R3L-srv>
In-Reply-To: <20210218020203.GC2871@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 23 Feb 2021 20:01:28 +0800
Message-ID: <CACPcB9d7-kJR7OG2OrLcAhFhiMO26PB82Uv9bK9FkCfH__zWZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore creation
To:     Baoquan He <bhe@redhat.com>
Cc:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        linux-doc@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:03 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
> > This adds crashkernel=auto feature to configure reserved memory for
> > vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
> > different kernel distributions and different archs based on their
> > needs.
> >
> > Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> > Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> > Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> > ---
> >  Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
> >  .../admin-guide/kernel-parameters.txt         |  6 +++++
> >  arch/Kconfig                                  | 24 +++++++++++++++++++
> >  kernel/crash_core.c                           |  7 ++++++
> >  4 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> > index 2da65fef2a1c..e55cdc404c6b 100644
> > --- a/Documentation/admin-guide/kdump/kdump.rst
> > +++ b/Documentation/admin-guide/kdump/kdump.rst
> > @@ -285,7 +285,8 @@ This would mean:
> >      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> >      3) if the RAM size is larger than 2G, then reserve 128M
> >
> > -
> > +Or you can use crashkernel=auto to choose the crash kernel memory size
> > +based on the recommended configuration set for each arch.
> >
> >  Boot into System Kernel
> >  =======================
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7d4e523646c3..aa2099465458 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -736,6 +736,12 @@
> >                       a memory unit (amount[KMG]). See also
> >                       Documentation/admin-guide/kdump/kdump.rst for an example.
> >
> > +     crashkernel=auto
> > +                     [KNL] This parameter will set the reserved memory for
> > +                     the crash kernel based on the value of the CRASH_AUTO_STR
> > +                     that is the best effort estimation for each arch. See also
> > +                     arch/Kconfig for further details.
> > +
> >       crashkernel=size[KMG],high
> >                       [KNL, X86-64] range could be above 4G. Allow kernel
> >                       to allocate physical memory region from top, so could
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index af14a567b493..f87c88ffa2f8 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
> >  config CRASH_CORE
> >       bool
> >
> > +if CRASH_CORE
> > +
> > +config CRASH_AUTO_STR
> > +     string "Memory reserved for crash kernel"
> > +     depends on CRASH_CORE
> > +     default "1G-64G:128M,64G-1T:256M,1T-:512M"
> > +     help
> > +       This configures the reserved memory dependent
> > +       on the value of System RAM. The syntax is:
> > +       crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > +                   range=start-[end]
> > +
> > +       For example:
> > +           crashkernel=512M-2G:64M,2G-:128M
> > +
> > +       This would mean:
> > +
> > +           1) if the RAM is smaller than 512M, then don't reserve anything
> > +              (this is the "rescue" case)
> > +           2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> > +           3) if the RAM size is larger than 2G, then reserve 128M
> > +
> > +endif # CRASH_CORE
>
> Wondering if this CRASH_CORE ifdeffery is a little redundent here
> since CRASH_CORE dependency has been added. Except of this, I like this
> patch. As we discussed in private threads, we can try to push it into
> mainline and continue improving later.
>

I believe "if CRASH_CORE" is not needed as it already "depends on
CRASH_CORE", tested with CRASH_CORE=y or 'not set', it just works.

> > +
> >  config KEXEC_CORE
> >       select CRASH_CORE
> >       bool
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 106e4500fd53..ab0a2b4b1ffa 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/crash_core.h>
> >  #include <linux/utsname.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/kexec.h>
> >
> >  #include <asm/page.h>
> >  #include <asm/sections.h>
> > @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
> >       if (suffix)
> >               return parse_crashkernel_suffix(ck_cmdline, crash_size,
> >                               suffix);
> > +#ifdef CONFIG_CRASH_AUTO_STR
> > +     if (strncmp(ck_cmdline, "auto", 4) == 0) {
> > +             ck_cmdline = CONFIG_CRASH_AUTO_STR;
> > +             pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> > +     }
> > +#endif
> >       /*
> >        * if the commandline contains a ':', then that's the extended
> >        * syntax -- if not, it must be the classic syntax
> > --
> > 2.27.0
> >
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


-- 
Best Regards,
Kairui Song

