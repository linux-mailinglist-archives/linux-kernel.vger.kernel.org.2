Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A7399803
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCC1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:27:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820CC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 19:25:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u22so5126552ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inHvWEGMogZ/8sRg+Ef+tUIaOJMJH3aZNbH9N8ZkroE=;
        b=AcoEtgTQuP1fuJ9gu73cQz2gUbkFFu3In7Z7jXuz6jpAyc40gt3B3EcUw80e8gbFxE
         5WvZcugZC4Bk4+Oi5c/rWJqgftdzPJDHNmDlE7gTS4pPjeU7hnO8WQX/E/l+/IjyqFmR
         h3QZhMB8CMILEJ6kmTW08ESSCkxHmsXaS9I3E+IYGTHaxi+HksoeVL24FZYdU6m0jWF3
         xwauxyFJJivzLKIV59h9mdQP5lx5A+ixtYg59C0RC7PHuQrttQPppuLao2hXQ8z7XxCr
         vm2WhAtNoGjR15caA5kTevgaOFAcwdpHt+eVRqshJnbOZSBxy1bzm73Lrk8j40aAPOrb
         RMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inHvWEGMogZ/8sRg+Ef+tUIaOJMJH3aZNbH9N8ZkroE=;
        b=oSXw/CYwcpz5H3AaVN0E3yHzy4sFIL+z9QL1rQqLcauWsa/k9chOLe+YIEij2ox+6O
         nA2lQ4NkTjZKDCRQZiE4yJ4UEg0BGsDnC4Qi75NEvkSfqGWQ+XQFokiroCTg4DOx/xWq
         ygxweHSoMIJ5qZbpfsTYv67jVgQ3ogUxX+fGi/ShFtI+29bJu2pbrCcfJ1vYsp4SvayB
         lVSkaQKmjxa+qZtf9ZxGqi8Iap+j1W/AMXlGU7i2pbQ8NOcgHR6QYIW967heDHG5SBYy
         YfxsyQpvy+oan5UDA3QJVwepfsoBkCJ2cgNZANKUZ1slUiKyoXrjY0M7SWeebwde5l6i
         9Dyg==
X-Gm-Message-State: AOAM532QXtv+YVja+IiO8T9nkMvrvThhRXEa7vJ8tMrFv35CXrOvw7gK
        hyQ9jU148kXM4wGcdWflpsqOfLnU/bHhBEqBq0E=
X-Google-Smtp-Source: ABdhPJy4cs6+4hW0uWxhTigGCGKw6AnGmio5VTduXR1EBhnkUPptjWlzj2jrkW//087TyvG/tIgIp9+YmAPrh7GIVfo=
X-Received: by 2002:a2e:a169:: with SMTP id u9mr8776130ljl.52.1622687134648;
 Wed, 02 Jun 2021 19:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com> <YLeF/556Wbvx1Ssc@google.com>
In-Reply-To: <YLeF/556Wbvx1Ssc@google.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 3 Jun 2021 10:24:34 +0800
Message-ID: <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
To:     Quentin Perret <qperret@google.com>
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
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org,
        qais.yousef@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Qais


Hi Quentin

On Wed, Jun 2, 2021 at 9:22 PM Quentin Perret <qperret@google.com> wrote:
>
> +CC Patrick and Tejun
>
> On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > When setting cpu.uclamp.min/max in cgroup, there is no validating
> > like uclamp_validate() in __sched_setscheduler(). It may cause the
> > cpu.uclamp.min is bigger than cpu.uclamp.max.
>
> ISTR this was intentional. We also allow child groups to ask for
> whatever clamps they want, but that is always limited by the parent, and
> reflected in the 'effective' values, as per the cgroup delegation model.

It does not affect the 'effective' value. That because there is
protection in cpu_util_update_eff():
/* Ensure protection is always capped by limit */
eff[UCLAMP_MIN] =3D min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);

When users set the cpu.uclamp.min > cpu.uclamp.max:
cpu.uclamp.max =3D 50;
to set : cpu.uclamp.min =3D 60;
That would make the uclamp_req[UCLAMP_MIN].value =3D 1024* 60% =3D 614,
uclamp_req[UCLAMP_MAX].value =3D 1024* 50% =3D 512;
But finally, the  uclamp[UCLAMP_MIN].value =3D uclamp[UCLAMP_MAX].value
=3D 1024* 50% =3D 512;

Is it deliberately set not to validate because of the above?

>
> > Although there is protection in cpu_util_update_eff():
> > =E2=80=9Ceff[UCLAMP_MIN] =3D min(eff[UCLAMP_MIN], eff[UCLAMP_MAX])=E2=
=80=9D, it's better
> > not to let it happen.
> >
> > Judging the uclamp value before setting uclamp_min/max, avoid
> > the cpu.uclamp.min is bigger than cpu.uclamp.max.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/core.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5226cc26a095..520a2da40dc9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8867,6 +8867,30 @@ static ssize_t cpu_uclamp_write(struct kernfs_op=
en_file *of, char *buf,
> >       rcu_read_lock();
> >
> >       tg =3D css_tg(of_css(of));
> > +
> > +     switch (clamp_id) {
> > +     case UCLAMP_MIN: {
> > +             unsigned int uc_req_max =3D tg->uclamp_req[UCLAMP_MAX].va=
lue;
> > +
> > +             if (req.util > uc_req_max) {
> > +                     nbytes =3D -EINVAL;
> > +                     goto unlock;
> > +             }
> > +             break;
> > +     }
> > +     case UCLAMP_MAX: {
> > +             unsigned int uc_req_min =3D tg->uclamp_req[UCLAMP_MIN].va=
lue;
> > +
> > +             if (req.util < uc_req_min) {
> > +                     nbytes =3D -EINVAL;
> > +                     goto unlock;
> > +             }
> > +             break;
> > +     }
> > +     default:
> > +             nbytes =3D -EINVAL;
> > +             goto unlock;
> > +     }
> >       if (tg->uclamp_req[clamp_id].value !=3D req.util)
> >               uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false)=
;
> >
> > @@ -8878,7 +8902,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_ope=
n_file *of, char *buf,
> >
> >       /* Update effective clamps to track the most restrictive value */
> >       cpu_util_update_eff(of_css(of));
> > -
> > +unlock:
> >       rcu_read_unlock();
> >       mutex_unlock(&uclamp_mutex);
> >
> > --
> > 2.25.1
> >

When I change the code=EF=BC=8CI found the patch:

6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a5124c..f97eb73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1405,7 +1405,6 @@ uclamp_tg_restrict(struct task_struct *p, enum
uclamp_id clamp_id)
 {
  struct uclamp_se uc_req =3D p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
- struct uclamp_se uc_max;

  /*
  * Tasks in autogroups or root task group will be
@@ -1416,9 +1415,23 @@ uclamp_tg_restrict(struct task_struct *p, enum
uclamp_id clamp_id)
  if (task_group(p) =3D=3D &root_task_group)
  return uc_req;

- uc_max =3D task_group(p)->uclamp[clamp_id];
- if (uc_req.value > uc_max.value || !uc_req.user_defined)
- return uc_max;
+ switch (clamp_id) {
+ case UCLAMP_MIN: {
+ struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_id];
+ if (uc_req.value < uc_min.value)
+ return uc_min;
+ break;
+ }
+ case UCLAMP_MAX: {
+ struct uclamp_se uc_max =3D task_group(p)->uclamp[clamp_id];
+ if (uc_req.value > uc_max.value)
+ return uc_max;
+ break;
+ }
+ default:
+ WARN_ON_ONCE(1);
+ break;
+ }
 #endif

When the clamp_id =3D UCLAMP_MIN, why not judge the uc_req.value is
bigger than task_group(p)->uclamp[UCLAMP_MAX] ?
Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp[UCLAMP_=
MAX],
the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into [
task_group(p)->uclamp[UCLAMP_MAX], task_group(p)->uclamp[UCLAMP_MAX]
].

Thanks
