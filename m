Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1FC3738E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhEEK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhEEK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:59:51 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A16C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 03:58:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a18so762036qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrom9vRUXBJjuxhKwDUnpLt/PNj1iXaoMzDYSk2N5D0=;
        b=HoZQX0c7ochhqbP4ixSXYz8dC1He830VWqqM7JmjyqDAwaIXXnBGM9E9Uba77/KWMO
         FH/csfAd8+jlUNu/kBxUMS4f4+oS5UJysKBUGNLoFM2oebojWijSnb9+CMinZxs5C/Oa
         AKtJas0xIzMVmfdv3syGWqXy99uRqUJ9UvUgAXV3Brd46mQS+HSpCGkxhDsQOFwk8kcb
         D7s/IFnzMPv/RVnjNYaEQ2DwayBlh8YmpVC1F35h46UzMmEccfASQatlJ9zmaL4o2+Kk
         nraFZlsMozzZykxb/G8ZGV/K5ZZQTrf8K53o0l2+q/VWDZcB1qLmJObRVcJG9lCfJZ5O
         J4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrom9vRUXBJjuxhKwDUnpLt/PNj1iXaoMzDYSk2N5D0=;
        b=szoiGzOvuInwSUjO1uu6UdZiXAuCzVNtdbZEXTvupzzgAk8kcVWJrkGINwmid+hZDl
         B10JGkgEL2K10L1dQJM8OjjvvlQxlthwoIM1ooclqLB28SngkG4X+YtMrPoCY4tS5hj6
         EoabgpaRVwhShMXARYUT1MxgM43covZXlhCIaWYdx195E/EF3HId5uKMJ1zniDD2LpfT
         xxLftwu7xEVj7fti0dgak3ae4YriNGIgoKTQqSfCL3wrB5YF+e4kz21tBhCL9kASZJ1V
         gU9NlmJu581oWQAQ4g1wWcxEHmsyTC+z+LPfimNBCxPpMsl+1+Glr+FIGLoCZbvLn4rK
         XK3Q==
X-Gm-Message-State: AOAM530guy11vuMC2mUTUM5Eloht/ti4PBRUQFsD3Zan8cvf8RAuxIfu
        00NP/V6iJQ6zhfbkRQztfdJBQLUkh3f+kRXzsXI2D0hXdlQ=
X-Google-Smtp-Source: ABdhPJxfR4HlXNMigyHobII96a5deYLzzP+uC3TUgaUbHXVX0CwRELTrrC6D4+uXlIvlwdcJnrWVbfoIUFl65YFJqSI=
X-Received: by 2002:ac8:7284:: with SMTP id v4mr891755qto.180.1620212334342;
 Wed, 05 May 2021 03:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210505092218.2422386-1-glider@google.com> <CANpmjNPr8HmQieNrKpcBAvnKdUGatTHuN-vjWhO2CfKAmvtoHA@mail.gmail.com>
In-Reply-To: <CANpmjNPr8HmQieNrKpcBAvnKdUGatTHuN-vjWhO2CfKAmvtoHA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 5 May 2021 12:58:17 +0200
Message-ID: <CAG_fn=UTGBzwNWG92yUk4v-2=kFayYuUO+XfaJ5J4RnOESx-NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] printk: introduce dump_stack_lvl()
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, he@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 12:37 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 5 May 2021 at 11:22, Alexander Potapenko <glider@google.com> wrote:
> > dump_stack() is used for many different cases, which may require a log
> > level consistent with other kernel messages surrounding the dump_stack()
> > call.
> > Without that, certain systems that are configured to ignore the default
> > level messages will miss stack traces in critical error reports.
> >
> > This patch introduces dump_stack_lvl() that behaves similarly to
> > dump_stack(), but accepts a custom log level.
> > The old dump_stack() becomes equal to dump_stack_lvl(KERN_DEFAULT).
> >
> > A somewhat similar patch has been proposed in 2012:
> > https://lore.kernel.org/lkml/1332493269.2359.9.camel@hebo/
> > , but wasn't merged.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: he, bo <bo.he@intel.com>
> > Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> > Cc: Prasad Sodagudi <psodagud@quicinc.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  include/linux/printk.h |  1 +
> >  lib/dump_stack.c       | 19 ++++++++++++-------
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index fe7eb2351610..abe274305d79 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -206,6 +206,7 @@ void __init setup_log_buf(int early);
> >  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
> >  void dump_stack_print_info(const char *log_lvl);
> >  void show_regs_print_info(const char *log_lvl);
> > +extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
> >  extern asmlinkage void dump_stack(void) __cold;
> >  extern void printk_safe_flush(void);
> >  extern void printk_safe_flush_on_panic(void);
> > diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> > index f5a33b6f773f..3d2c324a4929 100644
> > --- a/lib/dump_stack.c
> > +++ b/lib/dump_stack.c
> > @@ -73,10 +73,10 @@ void show_regs_print_info(const char *log_lvl)
> >         dump_stack_print_info(log_lvl);
> >  }
> >
> > -static void __dump_stack(void)
> > +static void __dump_stack(const char *log_lvl)
> >  {
> > -       dump_stack_print_info(KERN_DEFAULT);
> > -       show_stack(NULL, NULL, KERN_DEFAULT);
> > +       dump_stack_print_info(log_lvl);
> > +       show_stack(NULL, NULL, log_lvl);
> >  }
> >
> >  /**
> > @@ -87,7 +87,7 @@ static void __dump_stack(void)
> >  #ifdef CONFIG_SMP
> >  static atomic_t dump_lock = ATOMIC_INIT(-1);
> >
> > -asmlinkage __visible void dump_stack(void)
> > +asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
> >  {
> >         unsigned long flags;
> >         int was_locked;
> > @@ -117,7 +117,7 @@ asmlinkage __visible void dump_stack(void)
> >                 goto retry;
> >         }
> >
> > -       __dump_stack();
> > +       __dump_stack(log_lvl);
> >
> >         if (!was_locked)
> >                 atomic_set(&dump_lock, -1);
> > @@ -125,9 +125,14 @@ asmlinkage __visible void dump_stack(void)
> >         local_irq_restore(flags);
> >  }
> >  #else
> > -asmlinkage __visible void dump_stack(void)
> > +asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
> >  {
> > -       __dump_stack();
> > +       __dump_stack(log_lvl);
> >  }
> >  #endif
>
> +EXPORT_SYMBOL(dump_stack_lvl);
>
> is missing here?

You are right, will fix in v2.
