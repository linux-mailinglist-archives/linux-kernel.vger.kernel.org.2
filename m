Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F35445C93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKDXO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhKDXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:14:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0887DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 16:11:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a129so18242607yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g19hlzy3e51X6mPFNJPWOmQXYP5dhih+AFlkBwtTImc=;
        b=CuGQaWrZavDDw7sctGWpKCo8ZuHfSRqwzKJ4ukNd/rjOm2nCnv+Z7L3EfmHY7gPz7T
         ilxuDtQTagaUhkwOiBlF9qDn49+8XAHAe1kRrDPPU14LuNo0KEWWYDAO5Xuxd72kzoIf
         /Qc2laVEoYiWY/u7N1yHJbNHqql44ilGgD0579ZqpicC2L4M1DBJ0TbnktqrccM42HeT
         Q/o2N8Q13x2kQmc9U90SC9g6Tfw8M3VGSswmDMJ+XPL3O/mc4qu8PlPOtjroHhazCgE/
         uOSXGJ5xD/rLbfus9RiYhI3YbuXcMcjeLgY68O5w3Tioqv1m6c9DzspGWdHDTetzQ2Y4
         bu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g19hlzy3e51X6mPFNJPWOmQXYP5dhih+AFlkBwtTImc=;
        b=2iy8bWS9a/MwPc2sdTf5OseTD0zTOZbnG8SRlbq79YzUdukixnagmlQwOflau50cTl
         VJw23TrDyBiixeQsYmZV/NlTNNGb9sgNSZ2YcnhW6ev8TmcDECkIqo6a5qwcGHqr2Zk3
         ulicgdHRvSNFNoNM3/wonjOwsOXyTvvO3p9B8hSUXnlfKMiSV8mD2keM1vtkwwtFHGcw
         IVUtxw73vUDevCp6DCJH61L2y6lw1xtoJb7MCGfm4RT3U1pbW7umEgsxK9hlzJm4D/so
         EAQdHorp1e0V2L53q8Qq/1LQx8i9f6D1TGy+GAxlz42xiDfoEBOzW+Ih0utzL43VMJOQ
         6qeA==
X-Gm-Message-State: AOAM531HW8AN1n/wXQqyPS/3ws70gczOdUC/g0d/iLNaa15xU/p3riI3
        q+plBFlKOwmj+u7l2R713iIe9ZxIdhaPZhpvHhvYMPRzyxc=
X-Google-Smtp-Source: ABdhPJxv5Vw8TgM9KWXlFFUwyBwkDeDiij5qKhoKZvFvrnq69k6FEW4DdsxPnCbXldjQO596+H2yRZznhoisslb18p8=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr52379246ybv.487.1636067508008;
 Thu, 04 Nov 2021 16:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44@epcas5p2.samsung.com>
 <1631523095-8672-1-git-send-email-ravi.singh1@samsung.com> <YYQQdI8rjvN4ZEOd@cmpxchg.org>
In-Reply-To: <YYQQdI8rjvN4ZEOd@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Nov 2021 16:11:37 -0700
Message-ID: <CAJuCfpFUSBJ6fRf5vRwycdXx5vHdM9vj36+iqh8jN2wVvDtuCw@mail.gmail.com>
Subject: Re: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ravi Singh <ravi.singh1@samsung.com>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        vishal.goel@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 9:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> CC Suren

Thanks!

>
> Sorry, this fell through the cracks.
>
> On Mon, Sep 13, 2021 at 02:21:35PM +0530, Ravi Singh wrote:
> > psi accepts window sizes upto WINDOW_MAX_US(10000000). In the case
> > where window_us is larger than 4294967, the result of an
> > multiplication overflows an unsigned int/long(4 bytes on 32 bit
> > system).
> >
> > For example, this can happen when the window_us is 5000000 so 5000000
> > * 1000 (NSEC_PER_USEC) will result in 5000000000 which is greater than
> > UINT_MAX(4294967295). Due to this overflow, 705032704 is stored in
> > t->win.size instead of 5000000000. Now psi will be monitoring the
> > window size of 705 msecs instead of 5 secs as expected by user.
> >
> > Fix this by type casting the first term of the mutiply to a u64.

Looks reasonable to me.

> >
> > Issue doesnot occur on 64 bit systems because NSEC_PER_USEC is of type
> > long which is 8 bytes on 64 bit systems.
> >
> > Signed-off-by: Ravi Singh <ravi.singh1@samsung.com>
>
> Fixes: 0e94682b73bf psi: introduce psi monitor
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Peter would you mind taking this through -tip?
>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 1652f2bb5..a2cc33dc2 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1145,7 +1145,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >       t->group = group;
> >       t->state = state;
> >       t->threshold = threshold_us * NSEC_PER_USEC;
> > -     t->win.size = window_us * NSEC_PER_USEC;
> > +     t->win.size = (u64)window_us * NSEC_PER_USEC;
> >       window_reset(&t->win, 0, 0, 0);
> >
> >       t->event = 0;
> > --
> > 2.17.1
