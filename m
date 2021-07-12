Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7193F3C59A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356917AbhGLJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358999AbhGLI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:26:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F528C00666B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:19:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e20so22793865ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Vqms0vy9lHt4dorTNB1riLmavTf8tDwGAT9NwU4T/8=;
        b=PtrvR9Kd0oTwy1FIWXsIc9PflVmbJ33VfTS6zTYe8usXpRn2Oz6qIfuiLoFkhlU3yN
         LGekOUjbPkeZ1EBicgj3xxbRuzaXwKPnQj+hvYd4ouV7COrE68LoWNxb3+MnqY2ne/UZ
         a+cmirTHV5hmfTmTy3jcSn+azCOGBiNVLcOsub2VH5im/uKMQMP7ngGProM6mt0m9/IU
         K/jawWf2oSsqcxlxyHkmtO5GPgoUPSXwmZHnegYVSHXZ9jKh4ZOA9xqDBdPAq02QfrI9
         fSV5NOZfD9krCwPQDkhw8jj4O7y3ZVcOHhCd6L8W+cb4nLeSGjs65cspOaHnNXFBx/0G
         qqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Vqms0vy9lHt4dorTNB1riLmavTf8tDwGAT9NwU4T/8=;
        b=awyqJMv/iKNrNAuWeq37RGAclt06LOHrMDpqKBmSAeWirzANwHDb9Vj7RNAJd8iObg
         EaeFDeqF3058hI0iaBacc/Vxbdc3vd89MIsKT3ggTj1bD7YuNKsYTeaRnjghjlbSSEH3
         VHR1X/yTUIrjnKlyREF1gRE8/zoStMRpZSKOvXBbSUNq+etLoSQlw1RnnG1cfgASWPmJ
         bbFjmBuPvjEz5vy4V+9wCvcR+YP43zXp7aRlUFVpBxU9twCXAdfYrdiHTRl5yAziwyAb
         EQD8WnYLXNKy6I6123IqkvtSUwEr3nxTb5apWWxbD24c0eBBy2UlsS3D2n0IjZ0jAjGD
         nQ7A==
X-Gm-Message-State: AOAM5312SCOpm+T6Kg8kOxrEU7lJvp25issC44bx5X0HUNeiLaeR5La8
        PDFvyTIshoD3e3ufAiK9IJBecNBOAmpy9qAK4k4=
X-Google-Smtp-Source: ABdhPJwk70WeOuOVOSkWg66e6yGCjIhizpb8YpQ5Eb535M2yh/P4Fcz8HMfkRmQ3zH/i8I9zraQqNmi5l8EOx1x6O9U=
X-Received: by 2002:a2e:a596:: with SMTP id m22mr12809050ljp.86.1626077942658;
 Mon, 12 Jul 2021 01:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141430.896595-1-sxwjean@me.com> <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
In-Reply-To: <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 12 Jul 2021 16:18:36 +0800
Message-ID: <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of check_wait_context()
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> wrote:
>
> On 7/11/21 10:14 AM, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > We now always get a "Invalid wait context" warning with
> > CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
> >
> >       [    0.705900] =============================
> >       [    0.706002] [ BUG: Invalid wait context ]
> >       [    0.706180] 5.13.0+ #4 Not tainted
> >       [    0.706349] -----------------------------
>
> I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
> and it is turned off by default. Turning it on can cause problem as
> shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat
> its purpose to find potential spinlock nesting problem in non-PREEMPT_RT
> kernel.
As far as I know, a spinlock can nest another spinlock. In
non-PREEMPT_RT kernel
spin_lock and raw_spin_lock are same , so here acquiring a spin_lock in hardirq
context is acceptable, the warning is not needed. My knowledge on this
is not enough,
Will dig into this.

> The point is to fix the issue found,
Agree. I thought there was a spinlock usage issue, but by checking
deactivate_slab context,
looks like the spinlock usage is well. Maybe I'm missing something?

> not hiding it from appearing.
I'm not trying to hiding it, according to the code context, the fix is
reasonable from my point of
view. Let me check again.

Thank  you for the comments.

Regards,
Xiongwei
>
> Cheers,
> Longman
>
