Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5C3CFBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhGTNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbhGTN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:29:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C16C0613DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:10:23 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so21646466otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42n8AUfejZCoSZP1zlU4yzWCvv9+BKRABgiQJHGXXN0=;
        b=jfU+UKYmz7ZvNk8E4yppuybYbg1dMiAKJnrVwSkdJoGooMtIiq5WpmdsljtbN8T2NC
         DTATs5lbdHXYKG9RmIMZciw98/eVxZGBop+B1OZBRnMHW1sEgzjNSlSE9RUodcaw9JBj
         EtEzlP3Fe6MB8j/a/skNf1lX8sFLDurmDhdIN2GV7+2qKMcIUX2TiUYbOEiNniV4k8dW
         nmNQol1INz0pAJ38195XkPMEoCnaYEG7aKowZX74nVEY5N9mFmKPOXqU8F9ULAtIrsqL
         bzVT90ZIJk/kJ9ifS2Zk9sok7jxa/Q70sxltg4KAWMiOJocYPQGLjyeEE76JmzIVp+qm
         AG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42n8AUfejZCoSZP1zlU4yzWCvv9+BKRABgiQJHGXXN0=;
        b=RUSIZpCPlSFZX/si8TpKN6Onhk6UbCJpmVuvtp8LsTDxPhW+QRD2qFGUZzT6qZpkGq
         IxPT8gAWQPUJ3MbF0XSVkHpdudWsnJ634mj2BTBHpgMhOjB7csRaaieauGrOGThJu/UX
         z2gvMrOt0IUmqZfEUobIwuK8w0UuoQJ5A23epiRNsC/lHdxnWmI88p4MkD2SnRTUE+yn
         ReBHovJigOSyGq487S4rgi3bzMcf2JxdJcrWB9cjgPjYHK+6Pp/BRVky6qTBH5aqpQik
         POMH4Syg9mOQxSK9/9SsLAcRCLFnReu93a2iVWesmLs235xSBv0/N2keBiHD5IGrRs3u
         tVMw==
X-Gm-Message-State: AOAM533YUzl1pXjge04td/49mHH9FjA53PPNj1e+j06qwegKWZC29Dkr
        HhvHv+M0dEsFQFQ20fbYdr6CUIdi8x1zau30IOyFHQ==
X-Google-Smtp-Source: ABdhPJyNj9vUKtohuCcMwspzMCx3K2PIYUsi1rCjUkfya4HiykM7YjQmiiwSaAA+f6FLwNsjOacWsh2pKIWR2E9tXUg=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr23481504oti.251.1626790222226;
 Tue, 20 Jul 2021 07:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000080403805c6ef586d@google.com> <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
 <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Tue, 20 Jul 2021 16:10:10 +0200
Message-ID: <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 at 15:18, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> Good catch!  And yes, this would be hard to reproduce.
>
> How about as shown below?

Acked-by: Marco Elver <elver@google.com>

I was merely a little surprised syzbot was able to exercise RCU in a
way that resulted in a data race your torture runs hadn't found yet
(or perhaps it did and missed?).

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 43e0f01f3b6f510dbe31d02a8f4c909c45deff04
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jul 20 06:16:27 2021 -0700
>
>     rcu: Mark accesses to rcu_state.n_force_qs
>
>     This commit marks accesses to the rcu_state.n_force_qs.  These data
>     races are hard to make happen, but syzkaller was equal to the task.
>
>     Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a7379c44a2366..245bca7cdf6ee 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1913,7 +1913,7 @@ static void rcu_gp_fqs(bool first_time)
>         struct rcu_node *rnp = rcu_get_root();
>
>         WRITE_ONCE(rcu_state.gp_activity, jiffies);
> -       rcu_state.n_force_qs++;
> +       WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
>         if (first_time) {
>                 /* Collect dyntick-idle snapshots. */
>                 force_qs_rnp(dyntick_save_progress_counter);
> @@ -2556,7 +2556,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>         /* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
>         if (count == 0 && rdp->qlen_last_fqs_check != 0) {
>                 rdp->qlen_last_fqs_check = 0;
> -               rdp->n_force_qs_snap = rcu_state.n_force_qs;
> +               rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
>         } else if (count < rdp->qlen_last_fqs_check - qhimark)
>                 rdp->qlen_last_fqs_check = count;
>
> @@ -2904,10 +2904,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
>                 } else {
>                         /* Give the grace period a kick. */
>                         rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
> -                       if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
> +                       if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
>                             rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
>                                 rcu_force_quiescent_state();
> -                       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> +                       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
>                         rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
>                 }
>         }
> @@ -4134,7 +4134,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
>         /* Set up local state, ensuring consistent view of global state. */
>         raw_spin_lock_irqsave_rcu_node(rnp, flags);
>         rdp->qlen_last_fqs_check = 0;
> -       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> +       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
>         rdp->blimit = blimit;
>         rdp->dynticks_nesting = 1;      /* CPU not up, no tearing. */
>         rcu_dynticks_eqs_online();
