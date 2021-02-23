Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AB322BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBWN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231984AbhBWN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614088581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOo1vUxJ9YG42QlygaavCVxD9K0kv9RH3YQXV8ODgCI=;
        b=hOiUIdFM/MzGw1fWLflGUkjIXfWLdOdruFtDs4tIGwDWVdR1xJtVqMBmAd4vUheZXLbQrJ
        QkSZPpZSc62CWh5M6Y4Txrt6q6v27npJ23d+rPZfXvIHObXW11rkH/uCY6BpeepsQZQGpl
        38yLQH+44XUvAjq4cCFxGsNGnxiJMDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-gclij8pZMj6Y9GQVdCSEcw-1; Tue, 23 Feb 2021 08:56:16 -0500
X-MC-Unique: gclij8pZMj6Y9GQVdCSEcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2A9801978;
        Tue, 23 Feb 2021 13:56:12 +0000 (UTC)
Received: from localhost (ovpn-12-213.pek2.redhat.com [10.72.12.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0296360CFB;
        Tue, 23 Feb 2021 13:56:07 +0000 (UTC)
Date:   Tue, 23 Feb 2021 21:56:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Kairui Song <kasong@redhat.com>
Cc:     linux-doc@vger.kernel.org,
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
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210223135605.GA3553@MiWiFi-R3L-srv>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <20210218020203.GC2871@MiWiFi-R3L-srv>
 <CACPcB9d7-kJR7OG2OrLcAhFhiMO26PB82Uv9bK9FkCfH__zWZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9d7-kJR7OG2OrLcAhFhiMO26PB82Uv9bK9FkCfH__zWZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/21 at 08:01pm, Kairui Song wrote:
> On Thu, Feb 18, 2021 at 10:03 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
...
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index af14a567b493..f87c88ffa2f8 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
> > >  config CRASH_CORE
> > >       bool
> > >
> > > +if CRASH_CORE
> > > +
> > > +config CRASH_AUTO_STR
> > > +     string "Memory reserved for crash kernel"
> > > +     depends on CRASH_CORE
> > > +     default "1G-64G:128M,64G-1T:256M,1T-:512M"
> > > +     help
> > > +       This configures the reserved memory dependent
> > > +       on the value of System RAM. The syntax is:
> > > +       crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > > +                   range=start-[end]
> > > +
> > > +       For example:
> > > +           crashkernel=512M-2G:64M,2G-:128M
> > > +
> > > +       This would mean:
> > > +
> > > +           1) if the RAM is smaller than 512M, then don't reserve anything
> > > +              (this is the "rescue" case)
> > > +           2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> > > +           3) if the RAM size is larger than 2G, then reserve 128M
> > > +
> > > +endif # CRASH_CORE
> >
> > Wondering if this CRASH_CORE ifdeffery is a little redundent here
> > since CRASH_CORE dependency has been added. Except of this, I like this
> > patch. As we discussed in private threads, we can try to push it into
> > mainline and continue improving later.
> >
> 
> I believe "if CRASH_CORE" is not needed as it already "depends on
> CRASH_CORE", tested with CRASH_CORE=y or 'not set', it just works.

Thanks for testing and confirmation, Kairui.

Saeed, can you post a v4 with CRASH_CORE ifdeffery removed? Maybe this
week?

Thanks
Baoquan

> 
> > > +
> > >  config KEXEC_CORE
> > >       select CRASH_CORE
> > >       bool
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 106e4500fd53..ab0a2b4b1ffa 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/crash_core.h>
> > >  #include <linux/utsname.h>
> > >  #include <linux/vmalloc.h>
> > > +#include <linux/kexec.h>
> > >
> > >  #include <asm/page.h>
> > >  #include <asm/sections.h>
> > > @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
> > >       if (suffix)
> > >               return parse_crashkernel_suffix(ck_cmdline, crash_size,
> > >                               suffix);
> > > +#ifdef CONFIG_CRASH_AUTO_STR
> > > +     if (strncmp(ck_cmdline, "auto", 4) == 0) {
> > > +             ck_cmdline = CONFIG_CRASH_AUTO_STR;
> > > +             pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> > > +     }
> > > +#endif
> > >       /*
> > >        * if the commandline contains a ':', then that's the extended
> > >        * syntax -- if not, it must be the classic syntax
> > > --
> > > 2.27.0
> > >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 
> 
> -- 
> Best Regards,
> Kairui Song
> 

