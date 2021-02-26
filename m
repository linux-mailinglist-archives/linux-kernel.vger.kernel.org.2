Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC1325DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:57:00 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:56:19 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q14so9447033ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrADPMnBZ4yoBkU/YnqPcC29N2iUEXdcqQ2toRM2mXU=;
        b=eFepvFj5vxgAV9mdLShk1pEQuEq/ti8+znapTe0TXp2bOu/L9MPqW+rUfHW7z5MEL8
         91jeUc/yr02bscPCU9WoWz0sIvRVDfY0qzs06fNPag5poabIBqOi21vl4mGUetX5XZUJ
         LwKYTFfW0epb11REZuq5RfzaoGCisr3e16Bz4kJNIJ5ioGH+o4lb71Edu61YLmCAMvm2
         m8IwQT2QsFsJ7oKVrz8rBLMkeOtbmfQmxf9sgg3a1x0PeiCzD2I+IlriQzTzfkQ4zkGz
         boH5TckQAM9zJ+YxSmxM9AUCx1NV9Lt4FNaZ/Otj/enH617IvcOWJG9Ghxr0grMEfcdp
         lSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrADPMnBZ4yoBkU/YnqPcC29N2iUEXdcqQ2toRM2mXU=;
        b=h4oWEzW0NMgJEWHP/kfGUQW0MgucjZcXLR6Ln5naffXU4dZzaY66COK/J636MSln9y
         WHrKZsq1kCuNuoraFV6DtteMiZOu+6X1IMBDekS8/Wy6lbmXHaj1NMLagTMg62J/QTeG
         Nxgl9giwn53m2L2CsG/VjZjLl06XIV6pAxB4k8aC5g3BFHV9HqGq2s/I6NaHp5ZZhtjB
         eIQL9MtZAq7nOh+SGkVj+rTQPLoHnjTnr/Z486KGcWXnaTJJmyXKhP4dqXpltwlBV/cD
         na/JEQsCCHgDyDRmAjXTRqC5kV3oJ5s2NiF6nREuEUU5Z2TirDjGHjcL6AfiOagEZjxb
         UjZg==
X-Gm-Message-State: AOAM533upAeNgc1TprhUNn3paYacoJGqzDzakCPE/opS/QcinzHwK/fN
        8I2Bov4XGq+p6nqcMsBT49Ct/so82X5Q7LL/3YM7yQ==
X-Google-Smtp-Source: ABdhPJxwPpU76NmvTXgY0+vpZCEUd69qX7ujB5TalBs1OGjExSoBkWKC4nlZRGhTWTAkbMG0DD7c0nv+VBR+OhScRJw=
X-Received: by 2002:a2e:9e05:: with SMTP id e5mr840848ljk.152.1614322578322;
 Thu, 25 Feb 2021 22:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20210224081652.587785-1-sumit.garg@linaro.org> <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
In-Reply-To: <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Feb 2021 12:26:07 +0530
Message-ID: <CAFA6WYMsphYjjwU0WBtOzo5FXC8OtcHv+3bM48iWjGu_3HkMRQ@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 at 23:39, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Feb 24, 2021 at 12:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Currently breakpoints in kernel .init.text section are not handled
> > correctly while allowing to remove them even after corresponding pages
> > have been freed.
> >
> > Fix it via killing .init.text section breakpoints just prior to initmem
> > pages being freed.
>
> It might be worth it to mention that HW breakpoints aren't handled by
> this patch but it's probably not such a big deal.
>
>
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  include/linux/kgdb.h      |  2 ++
> >  init/main.c               |  1 +
> >  kernel/debug/debug_core.c | 11 +++++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 57b8885708e5..3aa503ef06fc 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -361,9 +361,11 @@ extern atomic_t                    kgdb_active;
> >  extern bool dbg_is_early;
> >  extern void __init dbg_late_init(void);
> >  extern void kgdb_panic(const char *msg);
> > +extern void kgdb_free_init_mem(void);
> >  #else /* ! CONFIG_KGDB */
> >  #define in_dbg_master() (0)
> >  #define dbg_late_init()
> >  static inline void kgdb_panic(const char *msg) {}
> > +static inline void kgdb_free_init_mem(void) { }
> >  #endif /* ! CONFIG_KGDB */
> >  #endif /* _KGDB_H_ */
> > diff --git a/init/main.c b/init/main.c
> > index c68d784376ca..a446ca3d334e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1417,6 +1417,7 @@ static int __ref kernel_init(void *unused)
> >         async_synchronize_full();
> >         kprobe_free_init_mem();
> >         ftrace_free_init_mem();
> > +       kgdb_free_init_mem();
> >         free_initmem();
> >         mark_readonly();
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 229dd119f430..319381e95d1d 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -465,6 +465,17 @@ int dbg_remove_all_break(void)
> >         return 0;
> >  }
> >
> > +void kgdb_free_init_mem(void)
> > +{
> > +       int i;
> > +
> > +       /* Clear init memory breakpoints. */
> > +       for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > +               if (init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
>
> A nit, but instead of 0 should this be passing "BREAK_INSTR_SIZE" ?
>
> Also: even if memory is about to get freed it still seems like it'd be
> wise to call this:
>
>   kgdb_arch_remove_breakpoint(&kgdb_break[i]);
>
> It looks like it shouldn't matter today but just in case an
> architecture decides to do something fancy in the future it might not
> hurt to tell it that the breakpoint is going away.
>
>
> Everything here is pretty nitty, though.  This looks good to me now.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks Doug for your review.

-Sumit
