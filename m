Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A33222E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhBVX7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhBVX65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:58:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:58:17 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id v3so10683772qtw.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqB6zjqAy2RrQCNQKVBo9coXh/LjEZ0bIel8hnnVASw=;
        b=J8IAiCXlzUD6MCNysWcSKYY4NZhG0kPUOcT0WqfNU16JuDf0Mrz6FEvHY9EFTqWokR
         n6oMLkXl9nxRDWrTiW+SpQhgNDkRz8TkFzTfWSFpQHz+uhvS7UHRhlj9vTijY/yjlGqg
         snxVQGV883FWcIPB+dQb35ccrkxZWi1MeYqdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqB6zjqAy2RrQCNQKVBo9coXh/LjEZ0bIel8hnnVASw=;
        b=fR81lVryz2V2H88xASkNRzkuGOuuhHSGAqk2dGMedP1Lh+qvs1pnrn0RDqNPaS82/O
         BagKMEvfEZueiyjRjlhoMghwSbJg5lP/Vsvgbv8ckZZzXwHFLkEqiNqu3pASr8NDkHOJ
         SFBLswGSw30PZnyEXb+BNZ6GW86IrFVKw5I+n53TjFL1NzdQ8TBytMuuL157X/GQ24sY
         22fb+DuScU+hM2VymLelM3cndAZBPCJNe2c7q+QNn1RFibONuyjA3qU/gmHdEaOuwnTR
         LZgvTWFBsfw3dXuSaYhIsmFLLFZSxHrf3uFxWYOKTkkTQnnpePvPuef1LBaQ7RkrKzzW
         U30A==
X-Gm-Message-State: AOAM533iq72C3K7bAP0coU9pESnh/182BnqzapSK+aFCyrIEhD8mpnlm
        hD455v6Uf5X07m5/jVDNcI37SgcG7APjpQ==
X-Google-Smtp-Source: ABdhPJzhsg9lZSv1wrKTzj0EVLj0Bm/lNKrcTkxn6hO51YuN8mSQUm7vpWzRo9I9Q21EiPiQVUxydQ==
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr22906588qtx.270.1614038296233;
        Mon, 22 Feb 2021 15:58:16 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id r55sm353755qtj.34.2021.02.22.15.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 15:58:15 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id c131so14706082ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:58:15 -0800 (PST)
X-Received: by 2002:a25:d3c5:: with SMTP id e188mr37775337ybf.345.1614038295152;
 Mon, 22 Feb 2021 15:58:15 -0800 (PST)
MIME-Version: 1.0
References: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Feb 2021 15:58:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
Message-ID: <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
Subject: Re: [PATCH] kernel: debug: Handle breakpoints in kernel .init.text section
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 12:03 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently breakpoints in kernel .init.text section are not handled
> correctly while allowing to remove them even after corresponding pages
> have been freed.
>
> In order to keep track of .init.text section breakpoints, add another
> breakpoint state as BP_ACTIVE_INIT and don't try to free these
> breakpoints once the system is in running state.
>
> To be clear there is still a very small window between call to
> free_initmem() and system_state = SYSTEM_RUNNING which can lead to
> removal of freed .init.text section breakpoints but I think we can live
> with that.

I know kdb / kgdb tries to keep out of the way of the rest of the
system and so there's a bias to just try to infer the state of the
rest of the system, but this feels like a halfway solution when really
a cleaner solution really wouldn't intrude much on the main kernel.
It seems like it's at least worth asking if we can just add a call
like kgdb_drop_init_breakpoints() into main.c.  Then we don't have to
try to guess the state...


> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/linux/kgdb.h      |  3 ++-
>  kernel/debug/debug_core.c | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 0d6cf64..57b8885 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -71,7 +71,8 @@ enum kgdb_bpstate {
>         BP_UNDEFINED = 0,
>         BP_REMOVED,
>         BP_SET,
> -       BP_ACTIVE
> +       BP_ACTIVE_INIT,
> +       BP_ACTIVE,
>  };
>
>  struct kgdb_bkpt {
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index af6e8b4f..229dd11 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -324,7 +324,11 @@ int dbg_activate_sw_breakpoints(void)
>                 }
>
>                 kgdb_flush_swbreak_addr(kgdb_break[i].bpt_addr);
> -               kgdb_break[i].state = BP_ACTIVE;
> +               if (system_state >= SYSTEM_RUNNING ||
> +                   !init_section_contains((void *)kgdb_break[i].bpt_addr, 0))

I haven't searched through all the code, but is there any chance that
this could trigger incorrectly?  After we free the init memory could
it be re-allocated to something that would contain code that would
execute in kernel context and now we'd be unable to set breakpoints in
that area?


> +                       kgdb_break[i].state = BP_ACTIVE;
> +               else
> +                       kgdb_break[i].state = BP_ACTIVE_INIT;

I don't really see what the "BP_ACTIVE_INIT" state gets you.  Why not
just leave it as "BP_ACTIVE" and put all the logic fully in
dbg_deactivate_sw_breakpoints()?

...or, if we can inject a call in main.c we can do a one time delete
of all "init" breakpoints and get rid of all this logic?  Heck, even
if we can't get called by "main.c", we still only need to do a
one-time drop of all init breakpoints the first time we drop into the
debugger after they are freed, right?

Oh shoot.  I just realized another problem.  What about hardware
breakpoints?  You still need to call "remove" on them once after init
memory is freed, right?

-Doug
