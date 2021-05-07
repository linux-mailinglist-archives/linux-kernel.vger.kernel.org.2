Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963163760B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhEGGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhEGGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:54:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E1C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:53:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u25so10217545ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xD6sT+JoVSfHAJgyHKvC2drKSKBvndrhIf3suCNO9U0=;
        b=Ur4W10ESfKgAsSrMSfPBFPUOmYjGYZdTxDdFX5nEtQUE1Hgiz7XNRiNtVeS/IuppA+
         yXaXQLGW1r3RsDp5UOGvdW69ziAlq83u4opBBm+u5ppSN/fyJ3mjhsNLQ3GazbMFdqzd
         Gv47C1At9vf6mPt2NQEpHoY2GS5aXLMA7KqgV5t1LL/3B62N8qONOGIlA+U3ca2lszkV
         1dxdIvsJ/n0oyABRLZJgcdpfdYMTQT4JNoSm72+2xRBh3dOo1mDyOIpKFhlIhquynvFh
         lpdiyORMJ24LUfAkzLW/U1PGgW+OnSpPhArNKfRGKnBFiwK4wieHYexmUv77zPvfyDnW
         MrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xD6sT+JoVSfHAJgyHKvC2drKSKBvndrhIf3suCNO9U0=;
        b=YkoEGsKN+i07O4nU81L5HI7uoIfNfWChFw0FiMN9VsFTNxghlxDWYzifgOQKzm4uiJ
         PSaaZHpDvxVu/WQkrElu4BmHQAGkvwH6E3VeWoPNlVNHudSn6ZiFHQ/aBEBrVAAouhFq
         aLxqiBPYmEco25OnamZYGL1jQoVnnMRi6t6FcqEgqcAPx+Kw5zPirYZ/B1rQsKfDVksw
         GJZFmU8GWexzIE4Alb9E/NI2M1MJKBX5koT+3iO1EeWqPGkcr8Ge/GtYDWJ1ChUkqSPj
         xRjoIJwXAalPKbyjLsLM9IMuDYgU5elLrTGMA5Q52LjtbWMPmbrYvYrpzizZWFVksUv7
         +Ndg==
X-Gm-Message-State: AOAM531dfF/WsSVYEMlDfJcrwWtIup6+Z7ei4Si1wEIppBiiDXZV4xLn
        kGZmDzxhWoXPmavuwOclTib3p4pH/FA9GLUFh61nsQ==
X-Google-Smtp-Source: ABdhPJy7WgIvZKSzC0a4yMw9D+ZV4r8X/MS85vT3kBT61bVu3xHBKsPg4BC50LXkkiUty0rnn6OywjkMRhQktmm4F94=
X-Received: by 2002:a2e:8557:: with SMTP id u23mr6438212ljj.221.1620370399951;
 Thu, 06 May 2021 23:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210506110936.8797-1-xuewen.yan94@gmail.com> <20210506122823.GA8671@ubiquitous>
 <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com>
 <20210506162600.GA11916@ubiquitous> <CAB8ipk8MK-j_oigJQoKutRxr22iKvWfDx1MgcSsy4s2=90QaFQ@mail.gmail.com>
In-Reply-To: <CAB8ipk8MK-j_oigJQoKutRxr22iKvWfDx1MgcSsy4s2=90QaFQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 May 2021 08:53:08 +0200
Message-ID: <CAKfTPtDUEwvLXOVcGztGALrUx0dqi=KtT2vAcxK15yQJswyHfA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for last_enqueued_diff
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 at 03:36, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> On Fri, May 7, 2021 at 12:26 AM Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > On Thu, May 06, 2021 at 08:46:08PM +0800, Xuewen Yan wrote:
> > > Hi
> > > On Thu, May 6, 2021 at 8:28 PM Vincent Donnefort
> > > <vincent.donnefort@arm.com> wrote:
> > > >
> > > > On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> > > > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > >
> > > > > The UTIL_AVG_UNCHANGED flag had been cleared when the task util c=
hanged.
> > > > > And the enqueued is equal to task_util with the flag, so it is be=
tter
> > > > > to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.
> >
> > Could we change the description here a bit? I don't think this is accur=
ately
> > explaning the issue. Would probably be interesting to mention that by n=
ot
> > setting the flag, which is the LSB, we add +1 to the diff. This is ther=
efore
> > reducing slightly UTIL_EST_MARGIN.
>
> ok, If you agree with this patch, I'll change it in V2.

Although the impact is not significant , it's worth having an accurate
computation. So the patch makes sense to me. Please submit a v2

> >
> > > > >
> > > > > Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filteri=
ng
> > > > >
> > > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > > ---
> > > > >  kernel/sched/fair.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index e5e457fa9dc8..94d77b4fa601 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct c=
fs_rq *cfs_rq,
> > > > >       if (ue.enqueued & UTIL_AVG_UNCHANGED)
> > > > >               return;
> > > > >
> > > > > -     last_enqueued_diff =3D ue.enqueued;
> > > > > +     last_enqueued_diff =3D (ue.enqueued | UTIL_AVG_UNCHANGED);
> > > > >
> > > > >       /*
> > > > >        * Reset EWMA on utilization increases, the moving average =
is used only
> > > > > --
> > > > > 2.29.0
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > We do indeed for the diff use the flag for the value updated and no=
 flag for the
> > > > value before the update. However, last_enqueued_diff is only used f=
or the margin
> > > > check which is an heuristic and is not an accurate value (~1%) and =
as we know
> > > The last_enqueued_diff is compared with the UTIL_EST_MARGIN which is
> > > "1024/100 =3D 10",
> > > and The LSB may cause ~10% error.
> >
> > I meant ~1% being the original margin. With the bit set, we would use 0=
.87% instead
> > of 0.97%.
>
> Because the within_margin() does not contain =E2=80=9C=3D=E2=80=9D=EF=BC=
=8C if the enqueued
> without the flag, the margin may be 0.97%(10/1024),
> with the flag, be 1.07%(11/1024) instead of 0.87% I think.
> >
> > > > we already loose the LSB in util_est, I'm not sure this is really n=
ecessary.
> > > I'm also not very sure, maybe the calculation will be more rigorous
> > > with the flag?
> > > >
> > > > --
> > > > Vincent
> > > >
