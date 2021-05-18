Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A85387826
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbhERL4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbhERL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:56:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:55:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so1405509pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5VCBuWSs1txjae+kRHfQDLH1nWBEwnS0myzOsDirlD0=;
        b=tem/B1XmXabqMr0kMhnjJlecucMrzogQ3R5lsMyeOcdqxveptMAfrSW2ZCgd/uxkyR
         G+JlPP3nNiUYhRZBUnoimnEesrMZTHPdTGiGZkY7vp5ebbn+Nghz3Lumc+dgtd6aln1l
         SE3r+JHo5lINBI4UtR/GVkhYuU4A6ERWQFsO9j1VP27V4Aq8ed2/8Nq4P96R8YJS30TR
         Dz5t8FNke8jS34/1moByLlMCyq8NBs6b32vsv0Iul+hz5y8zXzhuBA0ATPvi/jktI38B
         9yuwNdTGqVXamidXtpvyoTs7TqiHaOCW5kVqA5xtNrJYXGtaRnlhyJVh2CI+s3EI07LA
         +vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5VCBuWSs1txjae+kRHfQDLH1nWBEwnS0myzOsDirlD0=;
        b=uK93b4mrsxek7FHxVlCuvsuXCGWA+w38t1BydGv2FA9t+elieXSsVOpWJpXizdfQ7j
         6bAWl9tiUI9FJ7LmuMll6xf8kIPnJ8bK9FrD19MIxav5BEGjmEUpCFz5H75Qt77nAO6e
         OpSZA+ZpFJPvH8D/9sxwkfv9tai24yI82zvyNQWHlHePN7M7u8zaW8jUnoO/yaGDKuQi
         vWBCbn1kup+/NGXWqN3S7OsmtRaw367pTM9vfv8D8O57Y3sddWBFGpj+k/Kzqs6E5NMX
         MxVdu/+DnaCYxn3Ay/Rh965KBRIeYGYulPGHc3Lk+YrQz8Pdeb5lsZMA7gz7/Xm7V0lG
         1StQ==
X-Gm-Message-State: AOAM532nnuxEBuKTvf7qqZ17yyfKDTm01aXwUBPhWt/dubbwQDzk0RSm
        JD68OkV3QrDkaZUL8w8lXeHsRUu8a8ci0Xm1Nlo=
X-Google-Smtp-Source: ABdhPJyLTIbqZGmalOKB/nTgjTRyPg8tqHHRXNcBBaSCCXf7yfX5tFGps+O8zsSi+wT28z6Y1iJWa0XLPytXohEJRHE=
X-Received: by 2002:a17:902:c784:b029:ef:b14e:2b0b with SMTP id
 w4-20020a170902c784b02900efb14e2b0bmr4255508pla.64.1621338925678; Tue, 18 May
 2021 04:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155306.11113-1-wuchi.zero@gmail.com> <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
 <20210518085955.GB28667@quack2.suse.cz> <CA+tQmHBEvZTe9-7tReRHBw1tkTW7uGS5FhPZ41eZFOqtoyqkHQ@mail.gmail.com>
 <20210518103928.GC28667@quack2.suse.cz>
In-Reply-To: <20210518103928.GC28667@quack2.suse.cz>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 18 May 2021 19:55:13 +0800
Message-ID: <CA+tQmHD2NSTG6m=RHdHQNDofn92Vm=QEP5GNmXhRzWoPJEjLmA@mail.gmail.com>
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
=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 18-05-21 18:22:05, chi wu wrote:
> > Jan Kara <jack@suse.cz> =E4=BA=8E2021=E5=B9=B45=E6=9C=8818=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:59=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue 18-05-21 11:42:53, chi wu wrote:
> > > > Chi Wu <wuchi.zero@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:53=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > The value of percpu_counter_read() may become negative after
> > > > > running percpu_counter_sum() in fprop_reflect_period_percpu().
> > > > > The value of variable 'num' will be zero in fprop_fraction_percpu=
()
> > > > > when using percpu_counter_read_positive(), but if using the abs o=
f
> > > > > percpu_counter_read() will be close to the correct value.
> > > > >
> > > >
> > > > I realized that I was wrong as follow:
> > > > (a) the decay rule is broken, the negative means the difference in
> > > > decay here.
> > > > (b) as the target event increasing, proportion of the event will
> > > > decrease to 0 firstly and then it will increase. The logic is bad.
> > > > 1. abs(-50) / abs(100) =3D 50%       //+50 to 2
> > > > 2. abs(0) / abs(150) =3D 0 %           //+50 to 3
> > > > 3. abs(50)/abs(200) =3D 25%
> > > >
> > > > Anyway, the percpu_counter_sum() had cost a lost performance,
> > > > may be we could get a little benefits from that. So could we add a
> > > > variable to stroe the decay value, we will get the value when
> > > > percpu_counter_read() is negative?
> > >
> > > The result of percpu_counter_read() is inherently inexact (but fast! =
;). It
> > > can be upto number_of_cpus * counter_batch away from the real counter
> > > value. But do you observe any practical problems with this inaccuracy=
 on
> > > your system? Sure, cache memory won't be split among devices exactly
> > > according to writeout proportion but that usually does not matter.
> > >
> > >                                                                 Honza
> > >
> >
> > Thanks, Got it.
> > Just try to optimize the fuse (with strictlimit feature)performance
> > issue: The writing thread will be paused and runs slowly, when the
> > proportion of fuse-bdi is 0.
> > The issue is normal,and one of reasons is the characteristics of
> > percpu_counter batch. Even the pages are writeout, we may be could not
> > get the real proportion value due to side effects of counter
> > performance. It's just a slight disappointment.
>
> Well, you can tune 'min_ratio' of the fuse-bdi to avoid problems with the=
se
> near-zero states... To always give the bdi some breathing room for rampin=
g
> up.
>

Thanks, it is useful to me.

>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
