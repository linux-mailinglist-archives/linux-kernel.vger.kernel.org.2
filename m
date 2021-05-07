Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A779375E71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhEGBhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:37:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 18:36:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so3982862lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 18:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgUUF1dPw1aLbBWuebs4sGoP0208+Vgd+XREFKVcaIk=;
        b=ojDzMJ2AtSKKU/TFMMS0wsiIKX2Cl20/FuyUTzaEVKI3DitulaJWYY7RNn5HOwv32C
         ueRo2c1g2YDcDFl11d2FwgL5YZbkqxJcjU03JX9fGwdj+UJ67Cgj8SRS8OflXtif/C/5
         LPWdLrXPxmw38mQCNScRLPKp/0q/xip40HuLqrlhU38LArwaYm2LFos5x2Os6MXcCFQD
         M9uDjuFgZV7hnnhDGzgP+pwxbBqxkvhDYMkat6yKNK28pTIa3ZfwCpUY5kWhjeXIe1y8
         BM4KB5A48o9DyDn1E9k7i1bAA8McbWUzRIcCncdwupjjR5+QcWj8rGOnF5J5ZTu7ikWZ
         bB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgUUF1dPw1aLbBWuebs4sGoP0208+Vgd+XREFKVcaIk=;
        b=GkgdoFsmkCGhM1OtDCoJzaYeAbPxRgeLxLsgnmA95HCt+QL5vHFt+HjoOLiyXjGMb9
         cef1kXz59EntnhgeQ89W0wK3ShcpLy6KrXnuEB7FG5owOZ22+NorgyM/LX3I7JXm4WP3
         VNXjpfHjQ1zFpo7yic8bdTfffY+hcsUtTuzeaSJcjXVl3kIaImVcakMyzkzqHozrDgWj
         bZHWicJ45Hx8fmu1hCOQ8pIJwc/Y/4kz9AT7L/Z3ln3ZwFlRmauXbB3zsFoj9F/jLuZp
         2gQJp/1Yaas+fG8mAxIv106vaTD84KHRy12IrUY8kPGYVwTdl4PHNYbXdK5LgSpGrLiG
         eemg==
X-Gm-Message-State: AOAM530aDtjpC+ac+gPA8VOPQKEomqaeSs3AMBwq8HTAcI2M31Pp0fi6
        OA8ZAqVzJ6WbVowQYyLlEVKoUi9M4bKPXU27sR4=
X-Google-Smtp-Source: ABdhPJymG/BYw7rN0vzdOKM4+rn4BHcHOCn1b6GBxOZ0zYPlsfh8330EDKBngy34deFwTv3c3YP5/6Z9fWc4Dd9EbT4=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr4699414lfg.437.1620351373370;
 Thu, 06 May 2021 18:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210506110936.8797-1-xuewen.yan94@gmail.com> <20210506122823.GA8671@ubiquitous>
 <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com> <20210506162600.GA11916@ubiquitous>
In-Reply-To: <20210506162600.GA11916@ubiquitous>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 7 May 2021 09:34:38 +0800
Message-ID: <CAB8ipk8MK-j_oigJQoKutRxr22iKvWfDx1MgcSsy4s2=90QaFQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for last_enqueued_diff
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

On Fri, May 7, 2021 at 12:26 AM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Thu, May 06, 2021 at 08:46:08PM +0800, Xuewen Yan wrote:
> > Hi
> > On Thu, May 6, 2021 at 8:28 PM Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> > >
> > > On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> > > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > > >
> > > > The UTIL_AVG_UNCHANGED flag had been cleared when the task util cha=
nged.
> > > > And the enqueued is equal to task_util with the flag, so it is bett=
er
> > > > to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.
>
> Could we change the description here a bit? I don't think this is accurat=
ely
> explaning the issue. Would probably be interesting to mention that by not
> setting the flag, which is the LSB, we add +1 to the diff. This is theref=
ore
> reducing slightly UTIL_EST_MARGIN.

ok, If you agree with this patch, I'll change it in V2.
>
> > > >
> > > > Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> > > >
> > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index e5e457fa9dc8..94d77b4fa601 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs=
_rq *cfs_rq,
> > > >       if (ue.enqueued & UTIL_AVG_UNCHANGED)
> > > >               return;
> > > >
> > > > -     last_enqueued_diff =3D ue.enqueued;
> > > > +     last_enqueued_diff =3D (ue.enqueued | UTIL_AVG_UNCHANGED);
> > > >
> > > >       /*
> > > >        * Reset EWMA on utilization increases, the moving average is=
 used only
> > > > --
> > > > 2.29.0
> > > >
> > >
> > > Hi,
> > >
> > > We do indeed for the diff use the flag for the value updated and no f=
lag for the
> > > value before the update. However, last_enqueued_diff is only used for=
 the margin
> > > check which is an heuristic and is not an accurate value (~1%) and as=
 we know
> > The last_enqueued_diff is compared with the UTIL_EST_MARGIN which is
> > "1024/100 =3D 10",
> > and The LSB may cause ~10% error.
>
> I meant ~1% being the original margin. With the bit set, we would use 0.8=
7% instead
> of 0.97%.

Because the within_margin() does not contain =E2=80=9C=3D=E2=80=9D=EF=BC=8C=
 if the enqueued
without the flag, the margin may be 0.97%(10/1024),
with the flag, be 1.07%(11/1024) instead of 0.87% I think.
>
> > > we already loose the LSB in util_est, I'm not sure this is really nec=
essary.
> > I'm also not very sure, maybe the calculation will be more rigorous
> > with the flag?
> > >
> > > --
> > > Vincent
> > >
