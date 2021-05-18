Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE57387052
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 05:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbhERDo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 23:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbhERDoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 23:44:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F367DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:43:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s19so4161599pfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oyrSDnYQQKifS149R+OMO4QjNVTTu7WnPskAINWHJCg=;
        b=mcAgZhoQM6+/P+HoPyZ1Vysugw+UzuyFqkhZUkEw2jN6AkMvxzB5jrP50LYnhwsgYd
         apk+/FRwlBW5go143HpagMt5wdNrH7UfYxQ2NeneKYLZilhMbWywPrNg1B/QGMYI/ysW
         mMomHjoMBtsW+P0foihilDnnNG8wbs5iBqKdFadBUfGnUJDfBiXEwwkehhwMss2vpGxD
         6hthQyt11DrnRoIdbsLUtM9NRVKBLgZuNnkRl31JivxdWI+I3Hry1ScTriRLpUb5+U0E
         EOsE1I9geRz5LHSS09f0/NdUDUfq2/AxDVFHSPA5KOzMjpnH+UEVUwW2bCkgtjWU86BO
         l/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oyrSDnYQQKifS149R+OMO4QjNVTTu7WnPskAINWHJCg=;
        b=MFtxppRL5/9w9CU0Y5nKaqu20na5HC8UJHlTr99aQIPc+wN3jkiR/r14H9l21miqsr
         p/2oNREh9bs7Og+ygtokAyUCDSpPhNML7CeO3hr1Oas9haTRMFOJ9z1ff4KGkTwdNEFf
         YkBEPXOIh/kUx8ntevSwNonK91kFdiuUU+xN87nzuVYwCrAlqb3gXPRoxLD7vMo7ZL8a
         rKN59Pv2oiGgE6jNXCcnV1ZwOmJCoBPN9JLyG+GCG+sRfxag0y/5RHJAIZ4UkZrjLRwb
         PfLAdMfEBmxoNZGOt3yhkFqMxB2yp1cee+MSXDLJrAcpuQIywt2sposx6gtqlJqCA5Qe
         QN9g==
X-Gm-Message-State: AOAM530GePc5gmEv475VxCCaG57HzgL9SHDsYc46tCl6Ks1p+7Vwu2+2
        UgOSdD50ym/DkNkkjd2nq+6vwA2ka64cne4VEwJ0gks87Qaj7rKQ
X-Google-Smtp-Source: ABdhPJzH1fPqGI8ta62pDbgQXHtzwpTcMHsGW/Y9VY6ay/kODfq3aG0wqoNeS4xdYtpYIUKDtZKRcfbU7Uof3ZD4Y6o=
X-Received: by 2002:a63:581c:: with SMTP id m28mr2846827pgb.353.1621309384516;
 Mon, 17 May 2021 20:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155306.11113-1-wuchi.zero@gmail.com>
In-Reply-To: <20210517155306.11113-1-wuchi.zero@gmail.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 18 May 2021 11:42:53 +0800
Message-ID: <CA+tQmHAE6vK17Xghi9YT7+7r4oFJuQ86cU8m5MzMs6-D0G=DBQ@mail.gmail.com>
Subject: Re: [PATCH] lib/flex_proportions.c: Use abs() when percpu_counter is negative.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        tan.hu@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chi Wu <wuchi.zero@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:53=E5=86=99=E9=81=93=EF=BC=9A
>
> The value of percpu_counter_read() may become negative after
> running percpu_counter_sum() in fprop_reflect_period_percpu().
> The value of variable 'num' will be zero in fprop_fraction_percpu()
> when using percpu_counter_read_positive(), but if using the abs of
> percpu_counter_read() will be close to the correct value.
>

I realized that I was wrong as follow:
(a) the decay rule is broken, the negative means the difference in
decay here.
(b) as the target event increasing, proportion of the event will
decrease to 0 firstly and then it will increase. The logic is bad.
1. abs(-50) / abs(100) =3D 50%       //+50 to 2
2. abs(0) / abs(150) =3D 0 %           //+50 to 3
3. abs(50)/abs(200) =3D 25%

Anyway, the percpu_counter_sum() had cost a lost performance,
may be we could get a little benefits from that. So could we add a
variable to stroe the decay value, we will get the value when
percpu_counter_read() is negative?

Thanks.

> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
> ---
>  lib/flex_proportions.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 451543937524..3ac79ca2c441 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -147,7 +147,7 @@ void fprop_fraction_single(struct fprop_global *p,
>                 seq =3D read_seqcount_begin(&p->sequence);
>                 fprop_reflect_period_single(p, pl);
>                 num =3D pl->events;
> -               den =3D percpu_counter_read_positive(&p->events);
> +               den =3D abs(percpu_counter_read(&p->events));
>         } while (read_seqcount_retry(&p->sequence, seq));
>
>         /*
> @@ -209,7 +209,7 @@ static void fprop_reflect_period_percpu(struct fprop_=
global *p,
>                         val =3D percpu_counter_sum(&pl->events);
>
>                 percpu_counter_add_batch(&pl->events,
> -                       -val + (val >> (period-pl->period)), PROP_BATCH);
> +                       -val + (val >> (period - pl->period)), PROP_BATCH=
);
>         } else
>                 percpu_counter_set(&pl->events, 0);
>         pl->period =3D period;
> @@ -234,8 +234,8 @@ void fprop_fraction_percpu(struct fprop_global *p,
>         do {
>                 seq =3D read_seqcount_begin(&p->sequence);
>                 fprop_reflect_period_percpu(p, pl);
> -               num =3D percpu_counter_read_positive(&pl->events);
> -               den =3D percpu_counter_read_positive(&p->events);
> +               num =3D abs(percpu_counter_read(&pl->events));
> +               den =3D abs(percpu_counter_read(&p->events));
>         } while (read_seqcount_retry(&p->sequence, seq));
>
>         /*
> --
> 2.17.1
>
