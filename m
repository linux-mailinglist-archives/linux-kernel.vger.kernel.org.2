Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D3324394
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhBXSK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhBXSKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:10:20 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0780C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:09:39 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id f17so3074737qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZy6N7GCZgUynsIdqwnAeC4Go7jwGa2J7ycwTmlSsCU=;
        b=MDfl56YmwjZfSTl9u6eM0IrenqYoRdsWbFtd2gmx5jDq0IvGCbPQZQcr35FlKSozlQ
         Cf4txMmDM2GI+aEj5CAQ3PIZGj9KjCns0lU70Hs506h4Or/eJZDaXxtx2m4yNvOl/RRQ
         7KdqQR5LFX2qKtaHAupwrH6ET9cduFMHecJCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZy6N7GCZgUynsIdqwnAeC4Go7jwGa2J7ycwTmlSsCU=;
        b=jWeouFbQOSx3tWVNR1iM3A2XD6gEI5K08J5T2CGH++xd3PMIauRSrD7DVGqfEAG+df
         ILS0EDQ95p1B8wE8I8DCHg6gtDWI/+R2c1tDh7mFOsyAlWdE4fVkpQ9+RxiQnDvOYYdL
         qD6NFpJfhIgMAiWTPwv4sUB96f+Rh0lj2SjvL7KtPAuBXApMeS2+ztujjb6pa6ZKdJg3
         x34hCgMXbVcw1z+dVy/9Gxp8rXtMg+OgqLrB645UzjLzCxhscIG3pbSlIcVmSb8FDrEz
         Y8KAmL7pEepqN5rARPP7BkrP4pbKFb18weaWP/NlLNAhqiqJNFLRPubnFScYwMLQ08eE
         jyeA==
X-Gm-Message-State: AOAM5318+8oUJ58nZOS243Uu7GIuiDZokGx6PVON5ldmUl0o76qm77PK
        mjCBFSDmHSL42MA97HI0oWZhx+3xx3PcBA==
X-Google-Smtp-Source: ABdhPJxxqW5tYUYxrV/LZUqpAWHWevODgUNhGVjFzNIAYrVofMvAUvXG5KGzJ70vCUHH7yM4FUVRvg==
X-Received: by 2002:a37:9e92:: with SMTP id h140mr1216973qke.299.1614190178373;
        Wed, 24 Feb 2021 10:09:38 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y1sm2019920qkf.55.2021.02.24.10.09.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 10:09:37 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id b10so2752835ybn.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:09:37 -0800 (PST)
X-Received: by 2002:a25:b74d:: with SMTP id e13mr49407214ybm.405.1614190176767;
 Wed, 24 Feb 2021 10:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20210224081652.587785-1-sumit.garg@linaro.org>
In-Reply-To: <20210224081652.587785-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Feb 2021 10:09:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
Message-ID: <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi,

On Wed, Feb 24, 2021 at 12:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently breakpoints in kernel .init.text section are not handled
> correctly while allowing to remove them even after corresponding pages
> have been freed.
>
> Fix it via killing .init.text section breakpoints just prior to initmem
> pages being freed.

It might be worth it to mention that HW breakpoints aren't handled by
this patch but it's probably not such a big deal.


> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/linux/kgdb.h      |  2 ++
>  init/main.c               |  1 +
>  kernel/debug/debug_core.c | 11 +++++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 57b8885708e5..3aa503ef06fc 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -361,9 +361,11 @@ extern atomic_t                    kgdb_active;
>  extern bool dbg_is_early;
>  extern void __init dbg_late_init(void);
>  extern void kgdb_panic(const char *msg);
> +extern void kgdb_free_init_mem(void);
>  #else /* ! CONFIG_KGDB */
>  #define in_dbg_master() (0)
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
> +static inline void kgdb_free_init_mem(void) { }
>  #endif /* ! CONFIG_KGDB */
>  #endif /* _KGDB_H_ */
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..a446ca3d334e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1417,6 +1417,7 @@ static int __ref kernel_init(void *unused)
>         async_synchronize_full();
>         kprobe_free_init_mem();
>         ftrace_free_init_mem();
> +       kgdb_free_init_mem();
>         free_initmem();
>         mark_readonly();
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 229dd119f430..319381e95d1d 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -465,6 +465,17 @@ int dbg_remove_all_break(void)
>         return 0;
>  }
>
> +void kgdb_free_init_mem(void)
> +{
> +       int i;
> +
> +       /* Clear init memory breakpoints. */
> +       for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> +               if (init_section_contains((void *)kgdb_break[i].bpt_addr, 0))

A nit, but instead of 0 should this be passing "BREAK_INSTR_SIZE" ?

Also: even if memory is about to get freed it still seems like it'd be
wise to call this:

  kgdb_arch_remove_breakpoint(&kgdb_break[i]);

It looks like it shouldn't matter today but just in case an
architecture decides to do something fancy in the future it might not
hurt to tell it that the breakpoint is going away.


Everything here is pretty nitty, though.  This looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
