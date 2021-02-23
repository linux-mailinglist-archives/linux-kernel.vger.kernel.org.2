Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73DD322776
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhBWJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhBWJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:04:45 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76869C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:04:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h26so10129550lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHTmR3tSf8v8P4uL8P5xVqexmawMTZdSHdkZEaf+zfs=;
        b=jsB6t0kC9UJaX6coJ3UvErpPglnTzmghnYZYkACFa0Z9ZPM+4EZzzU5NUGCMEi6S/B
         yhbUsJtjWJIRh+R2K/MzkmhabH5etvWeSH75ix+3K8vPgcQyc2o03EwMTAzWTx9TPuRK
         x4KnhGWljimP1OWRnFWRU48pbP7YUYkUJc2v2wGUDtutzAwC4VC0Zp/FPEuzyL/dLhmj
         M2QnLcGSP2bJnEEoj9PaSYaazqiAzadstityGpxVKC3/2sRW/NjJwM5hMjZn9qY4Ap/h
         fRAXKpXdahXWn74+hCYH/km8/X6d+eCWAsmMn5f0jiJQdh9/6NpE0BJra+odewnvY9ZE
         3+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHTmR3tSf8v8P4uL8P5xVqexmawMTZdSHdkZEaf+zfs=;
        b=q96OMlmANUz+Gbiw53GcNpvR1w6Kp4U1ySlvPcuNjJsCp+d+mPNywf7nyLhpR59C7J
         zJj/pep3LB/0bUOuRFmk8ISARuDf+hef+VThbufMxSxCu7SR+1LNKCwlU9+Owrt9Ybjo
         d5obFBheRKtEi9VRI1PNlf4x2z0x663RbW1e/sh7aTaaJh1d34ZF1dBwVeUiZT/7J5/A
         EU5hq+L2H1krELBgLrESGzuqAKb96/xHCklCj9KBeO4bPLmKgMnACZucsqyUR9s9BfRN
         EwCkD3L8dYmPZm06snKbWds8aCToEpaPjIguL5inwdfxwAOCPFegz5wYfy41cloaBW8I
         QK0Q==
X-Gm-Message-State: AOAM5336zA3yOWT8TI98YLePx673pNQhZEyjrRKwJqJjR0N78E3QJlXi
        3sbxCsaBTRZRfrqcziB/kIcV4LZzkCMRVqLvhNI+kg==
X-Google-Smtp-Source: ABdhPJySu6oBR88IcQr86tp9TZacyz+Ppy0CtsDn0Q+ApynryzIzNziyhc+dLPVxmSIjX2H9qpoEwWox9LyktihTHUI=
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr8268727lfi.194.1614071041954;
 Tue, 23 Feb 2021 01:04:01 -0800 (PST)
MIME-Version: 1.0
References: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org> <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
In-Reply-To: <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Feb 2021 14:33:50 +0530
Message-ID: <CAFA6WYO0PkbpXUJp9jayb71LsydpnHfLFyc21bHotC1dLJ7Dhg@mail.gmail.com>
Subject: Re: [PATCH] kernel: debug: Handle breakpoints in kernel .init.text section
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Doug for your comments.

On Tue, 23 Feb 2021 at 05:28, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Feb 19, 2021 at 12:03 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Currently breakpoints in kernel .init.text section are not handled
> > correctly while allowing to remove them even after corresponding pages
> > have been freed.
> >
> > In order to keep track of .init.text section breakpoints, add another
> > breakpoint state as BP_ACTIVE_INIT and don't try to free these
> > breakpoints once the system is in running state.
> >
> > To be clear there is still a very small window between call to
> > free_initmem() and system_state = SYSTEM_RUNNING which can lead to
> > removal of freed .init.text section breakpoints but I think we can live
> > with that.
>
> I know kdb / kgdb tries to keep out of the way of the rest of the
> system and so there's a bias to just try to infer the state of the
> rest of the system, but this feels like a halfway solution when really
> a cleaner solution really wouldn't intrude much on the main kernel.
> It seems like it's at least worth asking if we can just add a call
> like kgdb_drop_init_breakpoints() into main.c.  Then we don't have to
> try to guess the state...
>

Sounds reasonable, will post RFC for this. I think we should call such
function as kgdb_free_init_mem() in similar way as:
- kprobe_free_init_mem()
- ftrace_free_init_mem()

>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  include/linux/kgdb.h      |  3 ++-
> >  kernel/debug/debug_core.c | 17 +++++++++++++----
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 0d6cf64..57b8885 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -71,7 +71,8 @@ enum kgdb_bpstate {
> >         BP_UNDEFINED = 0,
> >         BP_REMOVED,
> >         BP_SET,
> > -       BP_ACTIVE
> > +       BP_ACTIVE_INIT,
> > +       BP_ACTIVE,
> >  };
> >
> >  struct kgdb_bkpt {
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index af6e8b4f..229dd11 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -324,7 +324,11 @@ int dbg_activate_sw_breakpoints(void)
> >                 }
> >
> >                 kgdb_flush_swbreak_addr(kgdb_break[i].bpt_addr);
> > -               kgdb_break[i].state = BP_ACTIVE;
> > +               if (system_state >= SYSTEM_RUNNING ||
> > +                   !init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
>
> I haven't searched through all the code, but is there any chance that
> this could trigger incorrectly?  After we free the init memory could
> it be re-allocated to something that would contain code that would
> execute in kernel context and now we'd be unable to set breakpoints in
> that area?
>

"BP_ACTIVE_INIT" state is added specifically to handle this scenario
as to keep track of breakpoints that actually belong to the .init.text
section. And we should be able to again set breakpoints after free
since below change in this patch would mark them as "BP_UNDEFINED":

@@ -378,8 +382,13 @@ int dbg_deactivate_sw_breakpoints(void)
        int i;

        for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
-               if (kgdb_break[i].state != BP_ACTIVE)
+               if (kgdb_break[i].state < BP_ACTIVE_INIT)
+                       continue;
+               if (system_state >= SYSTEM_RUNNING &&
+                   kgdb_break[i].state == BP_ACTIVE_INIT) {
+                       kgdb_break[i].state = BP_UNDEFINED;
                        continue;
+               }
                error = kgdb_arch_remove_breakpoint(&kgdb_break[i]);
                if (error) {
                        pr_info("BP remove failed: %lx\n",

>
> > +                       kgdb_break[i].state = BP_ACTIVE;
> > +               else
> > +                       kgdb_break[i].state = BP_ACTIVE_INIT;
>
> I don't really see what the "BP_ACTIVE_INIT" state gets you.  Why not
> just leave it as "BP_ACTIVE" and put all the logic fully in
> dbg_deactivate_sw_breakpoints()?

Please see my response above.

>
> ...or, if we can inject a call in main.c we can do a one time delete
> of all "init" breakpoints and get rid of all this logic? Heck, even
> if we can't get called by "main.c", we still only need to do a
> one-time drop of all init breakpoints the first time we drop into the
> debugger after they are freed, right?

Yes and this is what we are trying to achieve via changes to
dbg_deactivate_sw_breakpoints() that will drop all the init
breakpoints the first time we drop into the debugger after they are
freed.

>
> Oh shoot.  I just realized another problem.  What about hardware
> breakpoints?  You still need to call "remove" on them once after init
> memory is freed, right?

Since the hw breakpoints are implemented in an arch specific manner,
so I would expect following arch specific callbacks to correctly
handle .init.text section hw breakpoints:
- arch_kgdb_ops.disable_hw_break()
- arch_kgdb_ops.correct_hw_break()

in a similar manner as this patch does for sw breakpoints. And since
they are only implemented for x86 currently for which I don't have a
development machine, so I will leave that for others to fix.

-Sumit

>
> -Doug
