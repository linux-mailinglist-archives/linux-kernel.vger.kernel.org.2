Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178523C5A14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbhGLJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387051AbhGLJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:25:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3AC0613BA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:22:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 141so6556434ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdCMjlTcF6q8FHXqqR5CiNahO//ITPUe6gTB47ibCWA=;
        b=DsAAg+jCAjWAvEhGNy0CU8HO4iKUo6Iuvt0v/FGWYq7JG9KQVbVuNKVo/wZB4pguhb
         /jrGLDguS7oSPzDmDV+oF9xV/oz6+//mCymKwSCDxHKgq0RCGQdJjF4AtlNPdY4/J2em
         jpTE17S+lurHZrTw3plR2LeRsavlDs4/FsTg6FKjApA7mu/U1yLbPsteAou/p3H3gf5E
         c24nDEjv2lswR7dMIZN94WPIAacqx8BFBi9r75I9xGSDgxKZrmIT2733fiJLug0WTmXN
         /+8dm2EHD5LO5i8PVfgBPykNfrjHURWLCsjldoM65Ev7ZF9FFCckyY3PQugJsej8d1gm
         97iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdCMjlTcF6q8FHXqqR5CiNahO//ITPUe6gTB47ibCWA=;
        b=UblzGKUhOYrd04/tcbH9sD7mZ8yGUVD1HoIaqiagDahwPPbgRh9UBsnR7l8OdoNxDc
         ruisCeM6NfLPHe2k6xgkJ2nlXHOKOzHPoQtnH3MsKinfiE0v7V8qkOSIBrASDLsOjBQi
         U66wusnGlyFRB5ddOgFAmW4inyjOov7IXkvaC51lUVXHdSplmV5ZgKbpa/CSTwxj0y9U
         sso1ARHE1xZ2nsLgY4sIrN/a3y11u4ttLcDaUbrCfezbm8j3/OJ9oLf2U9wXp1YFN3rX
         1NaZ/EwuPPp6orYP+FLXI6HaCn6J2OzvMtfNjlmwQrDunv60TOVQTuAu351Be17zeLcn
         MBbQ==
X-Gm-Message-State: AOAM533/jzyc8Po6PAqR8Z4gsvNaOSdDkIiL868wIrmSHGEdwvphl3Ih
        u0aVyCnhcLgN0TW0YSdZp9CcN3TVxZR5xdiDqXM=
X-Google-Smtp-Source: ABdhPJxbnV+Zc182rRk45/f2/1dsbvebgJb1To8gzd8Pge0K2BZ1E9EI+mr+y7JdVaoZ2Of+Cm0dpsVBErQJnBzecVo=
X-Received: by 2002:a2e:8247:: with SMTP id j7mr5162627ljh.495.1626081729208;
 Mon, 12 Jul 2021 02:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141430.896595-1-sxwjean@me.com> <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
 <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com> <YOwCZEdRdS8MPFvY@boqun-archlinux>
In-Reply-To: <YOwCZEdRdS8MPFvY@boqun-archlinux>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 12 Jul 2021 17:21:43 +0800
Message-ID: <CAEVVKH8B0mgqMra_3G9A9jv+WUyewpxmFC7GHP_uHUU81y5mmg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of check_wait_context()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 4:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, Jul 12, 2021 at 04:18:36PM +0800, Xiongwei Song wrote:
> > On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> wrote:
> > >
> > > On 7/11/21 10:14 AM, Xiongwei Song wrote:
> > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > >
> > > > We now always get a "Invalid wait context" warning with
> > > > CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
> > > >
> > > >       [    0.705900] =============================
> > > >       [    0.706002] [ BUG: Invalid wait context ]
> > > >       [    0.706180] 5.13.0+ #4 Not tainted
> > > >       [    0.706349] -----------------------------
> > >
> > > I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
> > > and it is turned off by default. Turning it on can cause problem as
> > > shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat
> > > its purpose to find potential spinlock nesting problem in non-PREEMPT_RT
> > > kernel.
> > As far as I know, a spinlock can nest another spinlock. In
> > non-PREEMPT_RT kernel
> > spin_lock and raw_spin_lock are same , so here acquiring a spin_lock in hardirq
> > context is acceptable, the warning is not needed. My knowledge on this
> > is not enough,
> > Will dig into this.
> >
>
> You may find this useful: https://lwn.net/Articles/146861/ ;-)
>
> The thing is that most of the irq handlers will run in process contexts
> in PREEMPT_RT kernel (threaded irq), while the rest continues to run in
> hardirq contexts. spinlock_t is allowed int threaded irqs but not in
> hardirq contexts for PREEMPT_RT, because spinlock_t will become
> sleeplable locks.
Exactly. I think I have known why the fix is incorrect.

Regards,
Xiongwei
>
> Regards,
> Boqun
>
> > > The point is to fix the issue found,
> > Agree. I thought there was a spinlock usage issue, but by checking
> > deactivate_slab context,
> > looks like the spinlock usage is well. Maybe I'm missing something?
> >
> > > not hiding it from appearing.
> > I'm not trying to hiding it, according to the code context, the fix is
> > reasonable from my point of
> > view. Let me check again.
> >
> > Thank  you for the comments.
> >
> > Regards,
> > Xiongwei
> > >
> > > Cheers,
> > > Longman
> > >
