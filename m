Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CD37A42C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEKKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhEKKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:02:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:01:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 10so15834988pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OuYRu+V175zxs5iTWZvMhKhfQ1M8ho0pJbV45NPTfWU=;
        b=qTaNv7GOMpBErj1a6vnoxAnG0D0NPHItziIICu3kYGpensopgMvELrKMwr7iqF6B+O
         5oWd9La949AlGjtvCHpvS20G6X3nTDzfv+jM+wysGSsyGHuPoOyh0a/QVpg4+Ja5PN4Y
         cgF+9OnILGEe5TfyaUU+i2BQssuVWOaZvwMsBJkuIT1UKt+EiKHRqV7AADG4zNuD3wxU
         pGGB5PT7Fb5pT+buqvXDiPjwnlax+FcNPP09dnIMurkdsikYBZlhRbu0u+v9FC7IRiCl
         QLqNq4Jg3W5zSaEmBL4HMZq12avQtlDa17QTP0JDwjHeulnAmOOlmPHBHszfpBlEMvtP
         w+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OuYRu+V175zxs5iTWZvMhKhfQ1M8ho0pJbV45NPTfWU=;
        b=AekSxrgTWNx12CEaukSCFHveH5xUGDDI6sXNWZxffbgXN69yUdjYioyzAGlAQjGEAl
         4+xAbquG6F29nuh+AyWBRo10DCZhkStGXtrpe4NbKEwzIrySPnTwGdSdmrbZxxFlph1m
         ubrCmTVeqkV7lez4jTmjL3AqqBksEQVCyhVlwMh5mhQMZlS42c091CGjoBf2FKZCWMjH
         z9kRwlYz+duZ0BS6FEnvZZsK9tpNe+7c8L6AIIuqcQSrssgtVcwdmUl+J2QQDCu68pl4
         Sv5aXzllGr/2X1hk/idHg9HHuvPsd8qa7wzmUSb5ydZNTen9F4iHZcn9vwGBoOzCqsI1
         uBow==
X-Gm-Message-State: AOAM530y053LB7k8JWEkmc+MFlmo0TwkCTTZo0hmdVLrqic/TyfENW4P
        Jqa9VWELdILJ77EN7a8ZwEXOqfLizDF5v8hMtyY=
X-Google-Smtp-Source: ABdhPJz0iB1LjicL3942LvFDus7Vb/RGn8jyaj6ZIR9/0LY0MFc7X2QuYNLv9tXS331Y3O1VniNvD97u+6HDWExid8A=
X-Received: by 2002:a63:eb12:: with SMTP id t18mr30379337pgh.349.1620727287901;
 Tue, 11 May 2021 03:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210511052626.19005-1-wuchi.zero@gmail.com> <20210511090632.GH24154@quack2.suse.cz>
In-Reply-To: <20210511090632.GH24154@quack2.suse.cz>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 11 May 2021 18:01:17 +0800
Message-ID: <CA+tQmHBiONP9HMRsRj78Q-pBN+-n6MhPTD1u94LxK-DQivwjLg@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Update the comment of Dirty position control
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, sedat.dilek@gmail.com,
        Jens Axboe <axboe@fb.com>,
        Howard Cochran <hcochran@kernelspring.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> =E4=BA=8E2021=E5=B9=B45=E6=9C=8811=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 11-05-21 13:26:26, Chi Wu wrote:
> > As the value of pos_ratio_polynom() clamp between 0 and
> > 2LL << RATELIMIT_CALC_SHIFT, the global control line should be
> > consistent with it.
> >
> > Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
> > ---
> >  mm/page-writeback.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 0062d5c57d41..e9a4f6cf12bb 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -845,7 +845,7 @@ static long long pos_ratio_polynom(unsigned long se=
tpoint,
> >   *     ^ pos_ratio
> >   *     |
> >   *     |            |<=3D=3D=3D=3D=3D global dirty control scope =3D=
=3D=3D=3D=3D=3D>|
> > - * 2.0 .............*
> > + * 2.0 * * * * * * *
> >   *     |            .*
> >   *     |            . *
> >   *     |            .   *
>
> Generally, pos_ratio is used only within [freerun, limit] range so its
> values outside of that range don't matter much. But you're right that

Thanks.
Yes, most time it is. As the follow code and in the
"dtc->wb_dirty < 8" rampup case, dirty pages may break the rules.

. . . .
    if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
            long long wb_pos_ratio;

            if (dtc->wb_dirty < 8) {
                   dtc->pos_ratio =3D min_t(long long, pos_ratio * 2,
                                      2 << RATELIMIT_CALC_SHIFT);
                    return;
            }

            if (dtc->wb_dirty >=3D wb_thresh)
                    return;
. . .


> pos_ratio_polynom() clamps the computed value as you describe and we can
> visualize that in the graph as well. Just please move the '*' line you ad=
d
> by one space to the right so that the curve really follows the cubic curv=
e
> upto 'freerun' mark (the vertical '.' line).

Thanks.I'll correct it later.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
