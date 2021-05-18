Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9338765B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348435AbhERKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348441AbhERKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:23:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2821C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:22:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m190so6696121pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OaZ/AXfdj4wkfCT7kt8wvVEVj+XAikiQ+bE1w+vFf7A=;
        b=eoeu+yUpiXi25oa8c+Dg4t/srI2DQ8JpxDQjNefkPtK3S4jKTrgXiPkyIqCIKxFsmU
         TGpB9qm89A26r3R1Wuiyv6GBpuK2Sb2e3NT+XZsb4yvGdD0pbKPCIrtf4qaCzBoUJkib
         LR02VPm9mjW144P/mRzsqxap5tOqDoCQDapawwSKtJSa+wCP+ZLNMYw89lagD3UOR5In
         7nRN+0RHEz7IICUHtuBJarCGzoMICwc3B51xntczEy/ua/du9lICb1uPMr3Krc+kcGmh
         KQScZ6FGZG3CZbXsHMHOONF+z7kkFs3d52o22WfEYrBPzV3LIkcsfDUK/KpKVeMZymsz
         G2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OaZ/AXfdj4wkfCT7kt8wvVEVj+XAikiQ+bE1w+vFf7A=;
        b=bJ7pnWnQhf0yJR/ORILM+tZCQFuJpsgYvzI6S7GKeCYKtIiic8wcgbnfWbx2a8fqNW
         EVcqqZoA0MdFTfcp/Gkm9Dz1fJpmWumO3GpeA3kGqi36m1a0Hv5rJ8YOHeGRX5Sz7qIA
         nMur7fMcYjHCqoDvBA5zaGMVuUYtkic+tFk7CuYhptiKhY32nO49yykEH+TDz40qczWP
         2HBGwb28Ahc7k6fyayaWUnYGJ0X4EayN4k1gmZGOSV4p970XWxLz+/nsqUZRbMWdSqtp
         wsUwznyjnL15QbXY9zHnkqNYmt4NxFlvu223eTw2fI9WOAz7SdUYS0GU4C3KyB6UevdY
         aEhQ==
X-Gm-Message-State: AOAM532r6MYh87vuZMdb21gfa1sJzYAt02OiezzpfDhO1IVZ4TVU3JQK
        7Ex1OFyhAavZiOQXozS4jKdkpKYlEwx/zmTQD5s=
X-Google-Smtp-Source: ABdhPJyXMtPt8Av4mscYIqaij9JdGuId+FPo6GhejpbQd9eQZxrDRAoKueOmIpbDO7MTbtt+Ba6WOG1BGQ9sTlMxOTA=
X-Received: by 2002:a63:130f:: with SMTP id i15mr4299604pgl.151.1621333336492;
 Tue, 18 May 2021 03:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155306.11113-1-wuchi.zero@gmail.com> <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
 <20210518085955.GB28667@quack2.suse.cz>
In-Reply-To: <20210518085955.GB28667@quack2.suse.cz>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 18 May 2021 18:22:05 +0800
Message-ID: <CA+tQmHBEvZTe9-7tReRHBw1tkTW7uGS5FhPZ41eZFOqtoyqkHQ@mail.gmail.com>
Subject: Re: [PATCH] lib/flex_proportions.c: Use abs() when percpu_counter is negative.
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tan.hu@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> =E4=BA=8E2021=E5=B9=B45=E6=9C=8818=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 18-05-21 11:42:53, chi wu wrote:
> > Chi Wu <wuchi.zero@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:53=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The value of percpu_counter_read() may become negative after
> > > running percpu_counter_sum() in fprop_reflect_period_percpu().
> > > The value of variable 'num' will be zero in fprop_fraction_percpu()
> > > when using percpu_counter_read_positive(), but if using the abs of
> > > percpu_counter_read() will be close to the correct value.
> > >
> >
> > I realized that I was wrong as follow:
> > (a) the decay rule is broken, the negative means the difference in
> > decay here.
> > (b) as the target event increasing, proportion of the event will
> > decrease to 0 firstly and then it will increase. The logic is bad.
> > 1. abs(-50) / abs(100) =3D 50%       //+50 to 2
> > 2. abs(0) / abs(150) =3D 0 %           //+50 to 3
> > 3. abs(50)/abs(200) =3D 25%
> >
> > Anyway, the percpu_counter_sum() had cost a lost performance,
> > may be we could get a little benefits from that. So could we add a
> > variable to stroe the decay value, we will get the value when
> > percpu_counter_read() is negative?
>
> The result of percpu_counter_read() is inherently inexact (but fast! ;). =
It
> can be upto number_of_cpus * counter_batch away from the real counter
> value. But do you observe any practical problems with this inaccuracy on
> your system? Sure, cache memory won't be split among devices exactly
> according to writeout proportion but that usually does not matter.
>
>                                                                 Honza
>

Thanks, Got it.
Just try to optimize the fuse (with strictlimit feature)performance
issue: The writing thread will be paused and runs slowly, when the
proportion of fuse-bdi is 0.
The issue is normal,and one of reasons is the characteristics of
percpu_counter batch. Even the pages are writeout, we may be could not
get the real proportion value due to side effects of counter
performance. It's just a slight disappointment.

> > > ---
> > >  lib/flex_proportions.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> > > index 451543937524..3ac79ca2c441 100644
> > > --- a/lib/flex_proportions.c
> > > +++ b/lib/flex_proportions.c
> > > @@ -147,7 +147,7 @@ void fprop_fraction_single(struct fprop_global *p=
,
> > >                 seq =3D read_seqcount_begin(&p->sequence);
> > >                 fprop_reflect_period_single(p, pl);
> > >                 num =3D pl->events;
> > > -               den =3D percpu_counter_read_positive(&p->events);
> > > +               den =3D abs(percpu_counter_read(&p->events));
> > >         } while (read_seqcount_retry(&p->sequence, seq));
> > >
> > >         /*
> > > @@ -209,7 +209,7 @@ static void fprop_reflect_period_percpu(struct fp=
rop_global *p,
> > >                         val =3D percpu_counter_sum(&pl->events);
> > >
> > >                 percpu_counter_add_batch(&pl->events,
> > > -                       -val + (val >> (period-pl->period)), PROP_BAT=
CH);
> > > +                       -val + (val >> (period - pl->period)), PROP_B=
ATCH);
> > >         } else
> > >                 percpu_counter_set(&pl->events, 0);
> > >         pl->period =3D period;
> > > @@ -234,8 +234,8 @@ void fprop_fraction_percpu(struct fprop_global *p=
,
> > >         do {
> > >                 seq =3D read_seqcount_begin(&p->sequence);
> > >                 fprop_reflect_period_percpu(p, pl);
> > > -               num =3D percpu_counter_read_positive(&pl->events);
> > > -               den =3D percpu_counter_read_positive(&p->events);
> > > +               num =3D abs(percpu_counter_read(&pl->events));
> > > +               den =3D abs(percpu_counter_read(&p->events));
> > >         } while (read_seqcount_retry(&p->sequence, seq));
> > >
> > >         /*
> > > --
> > > 2.17.1
> > >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
