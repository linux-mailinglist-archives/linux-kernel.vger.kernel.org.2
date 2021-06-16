Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DF3A8F22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFPDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhFPDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:09:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B03C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:07:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n17so1639115ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zoOFlLVFQQByosxYI7h0EETc3Zj0+fu9XZpA18x98hE=;
        b=OicjcHjCFIYt7fQ9yiNXmgPMoTVp33JCI3yZGWVHtRPXXLdsUBXshbAbNm/3elvx1g
         IqNrFCIF8mMhDF5YEcmhU0vBa6ZUAyYMcWaiaggbostJNZlx02eLyFwzm2YHSXVIALLO
         SmvFTJhjBk0VHt9MCppuxV91lf24rydEhZXt/CppI8Z7j7rL+UHcWH7b9bv5eiRb80KJ
         3PhjGesy3b6F7EtzB1TCFoZvqBLgCew8tj0u0ZJGgk9n2LUPiBlTargFpUJiHrCmwidX
         TskEsBrTqv37Qf9O7R4A0grFOs+UXh7NFxOFmViw5CpzFc+FdN+P2wWjbWVM5MwTicaq
         g4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zoOFlLVFQQByosxYI7h0EETc3Zj0+fu9XZpA18x98hE=;
        b=icA1zI3ADQP4qYLpd8yJ/aLHD+/xluL0KPo1ITB8W7U9eZKUNHlBJiFSO9EfRwtjZ7
         6fB/BwXVY+rhsrvqE9uIHHzSg1uBqYMYNztJPfUlrMBH8RfQ2f5M96MxmxdMbCqtqrlS
         WMPm7TJWOu70s8B4k0WxXLMgddE4Hgsc57Z4PCmLQIAEjRtqfqsRpSq9B3ORs/h3y26B
         W6v4fJ+0Xw8CoLpbGqx4y0WR7Tdpqhksof9J31HlbC5v6EDQiCNdGRIBQVhkASjwlLMx
         y54ddeqHVYaVDqW3RxDIv6iuJqXeko3T+TjbvK26TcDZu7V/yPRSFDZlrQ3TNyTOB9h0
         Fj/w==
X-Gm-Message-State: AOAM5327OE06WdwUxS5lHsNqp9xSV0AoR0KuQJJLG+yCh8FOVhPmhQH6
        QJlWJIR8HkDC71e5A09QnTsWTmwEtN4/PdxUt/c=
X-Google-Smtp-Source: ABdhPJz7OKRhjMIX6a04NuNEv/r76Q50HeItuRWvJMn8zKeJYzQTYcdiaDSuGX5v+2qPxdKHGZ7uWzIPkjYWlv6aEMw=
X-Received: by 2002:a2e:a7c4:: with SMTP id x4mr2387469ljp.420.1623812831925;
 Tue, 15 Jun 2021 20:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210611122246.3475897-1-qais.yousef@arm.com>
In-Reply-To: <20210611122246.3475897-1-qais.yousef@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 16 Jun 2021 11:06:04 +0800
Message-ID: <CAB8ipk8bCYdb5d28sVrFfJSKpGB4EW+Fv0sekj7PGamKM_pngw@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Fix uclamp_tg_restrict()
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais

Sorry for the late reply.

I tested the patch on the "UNISOC T610" platform, and it looks fine.

According to the two cases:
case1:
without patch:
set task's clamp_min=3D614(60%), clamp_max=3D819(80%), the result as:
[  215.780435]c6  uclamp_test :
pid=3D138,req_min=3D614,req_max=3D819,eff_min=3D614,eff_max=3D819

after set tg's cpu.uclamp.max =3D 50%=EF=BC=8Cthe result:
[  420.580443]c6  uclamp_test :
pid=3D138,req_min=3D614,req_max=3D819,eff_min=3D614,eff_max=3D512

with patch:
set task's clamp_min=3D614(60%), clamp_max=3D819(80%), the result as:
[  333.533878]c7  uclamp_test :
pid=3D138,req_min=3D614,req_max=3D819,eff_min=3D614,eff_max=3D819

after set tg's cpu.uclamp.max =3D 50%=EF=BC=8Cthe result:
[  430.813789]c6  uclamp_test :
pid=3D138,req_min=3D614,req_max=3D819,eff_min=3D512,eff_max=3D512

case2:
without patch:
set task's clamp_min=3D614(60%), clamp_max=3D819(80%), the result as:
[  169.700544]c0  uclamp_test :
pid=3D137,req_min=3D0,req_max=3D209,eff_min=3D0,eff_max=3D209

after set tg's cpu.uclamp.min =3D 30%, tg's cpu.uclamp.max =3D 50%=EF=BC=8C=
the result:
[  246.500634]c7  uclamp_test :
pid=3D137,req_min=3D0,req_max=3D209,eff_min=3D307,eff_max=3D209

with patch:
set task's clamp_min=3D0(0%), clamp_max=3D209(20%), the result as:
[  169.700544]c0  uclamp_test :
pid=3D137,req_min=3D0,req_max=3D209,eff_min=3D0,eff_max=3D209

after set tg's cpu.uclamp.min =3D 30%, tg's cpu.uclamp.max =3D 50%=EF=BC=8C=
the result:
[  179.933868]c6  uclamp_test :
pid=3D137,req_min=3D0,req_max=3D209,eff_min=3D307,eff_max=3D307

---
Cheers

xuewen

On Fri, Jun 11, 2021 at 8:23 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Now cpu.uclamp.min acts as a protection, we need to make sure that the
> uclamp request of the task is within the allowed range of the cgroup,
> that is it is clamp()'ed correctly by tg->uclamp[UCLAMP_MIN] and
> tg->uclamp[UCLAMP_MAX].
>
> As reported by Xuewen [1] we can have some corner cases where there's
> inverstion between uclamp requested by task (p) and the uclamp values of
> the taskgroup it's attached to (tg). Following table demonstrates
> 2 corner cases:
>
>                    |  p  |  tg  |  effective
>         -----------+-----+------+-----------
>         CASE 1
>         -----------+-----+------+-----------
>         uclamp_min | 60% | 0%   |  60%
>         -----------+-----+------+-----------
>         uclamp_max | 80% | 50%  |  50%
>         -----------+-----+------+-----------
>         CASE 2
>         -----------+-----+------+-----------
>         uclamp_min | 0%  | 30%  |  30%
>         -----------+-----+------+-----------
>         uclamp_max | 20% | 50%  |  20%
>         -----------+-----+------+-----------
>
> With this fix we get:
>
>                    |  p  |  tg  |  effective
>         -----------+-----+------+-----------
>         CASE 1
>         -----------+-----+------+-----------
>         uclamp_min | 60% | 0%   |  50%
>         -----------+-----+------+-----------
>         uclamp_max | 80% | 50%  |  50%
>         -----------+-----+------+-----------
>         CASE 2
>         -----------+-----+------+-----------
>         uclamp_min | 0%  | 30%  |  30%
>         -----------+-----+------+-----------
>         uclamp_max | 20% | 50%  |  30%
>         -----------+-----+------+-----------
>
> Additionally uclamp_update_active_tasks() must now unconditionally
> update both UCLAMP_MIN/MAX because changing the tg's UCLAMP_MAX for
> instance could have an impact on the effective UCLAMP_MIN of the tasks.
>
>                    |  p  |  tg  |  effective
>         -----------+-----+------+-----------
>         old
>         -----------+-----+------+-----------
>         uclamp_min | 60% | 0%   |  50%
>         -----------+-----+------+-----------
>         uclamp_max | 80% | 50%  |  50%
>         -----------+-----+------+-----------
>         *new*
>         -----------+-----+------+-----------
>         uclamp_min | 60% | 0%   | *60%*
>         -----------+-----+------+-----------
>         uclamp_max | 80% |*70%* | *70%*
>         -----------+-----+------+-----------
>
> [1] https://lore.kernel.org/lkml/CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_Y=
NzQhqV_o8Zw@mail.gmail.com/
>
> Reported-by: Xuewen Yan <xuewen.yan94@gmail.com>
> Fixes: 0c18f2ecfcc2 ("sched/uclamp: Fix wrong implementation of cpu.uclam=
p.min")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>
> Xuewen, Yun, Wei
>
> If you can give this a spin and provide Tested-by that would be much
> appreciated.
>
> Thanks!
>
>
>  kernel/sched/core.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e9a5be35cde..0318b00baa97 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1403,38 +1403,28 @@ static void uclamp_sync_util_min_rt_default(void)
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -       struct uclamp_se uc_req =3D p->uclamp_req[clamp_id];
> +       /* Copy by value as we could modify it */
> +       struct uclamp_se uc_eff =3D p->uclamp_req[clamp_id];
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +       unsigned int tg_min, tg_max, value;
>
>         /*
>          * Tasks in autogroups or root task group will be
>          * restricted by system defaults.
>          */
>         if (task_group_is_autogroup(task_group(p)))
> -               return uc_req;
> +               return uc_eff;
>         if (task_group(p) =3D=3D &root_task_group)
> -               return uc_req;
> +               return uc_eff;
>
> -       switch (clamp_id) {
> -       case UCLAMP_MIN: {
> -               struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_i=
d];
> -               if (uc_req.value < uc_min.value)
> -                       return uc_min;
> -               break;
> -       }
> -       case UCLAMP_MAX: {
> -               struct uclamp_se uc_max =3D task_group(p)->uclamp[clamp_i=
d];
> -               if (uc_req.value > uc_max.value)
> -                       return uc_max;
> -               break;
> -       }
> -       default:
> -               WARN_ON_ONCE(1);
> -               break;
> -       }
> +       tg_min =3D task_group(p)->uclamp[UCLAMP_MIN].value;
> +       tg_max =3D task_group(p)->uclamp[UCLAMP_MAX].value;
> +       value =3D uc_eff.value;
> +       value =3D clamp(value, tg_min, tg_max);
> +       uclamp_se_set(&uc_eff, value, false);
>  #endif
>
> -       return uc_req;
> +       return uc_eff;
>  }
>
>  /*
> @@ -1661,8 +1651,7 @@ uclamp_update_active(struct task_struct *p, enum uc=
lamp_id clamp_id)
>
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>  static inline void
> -uclamp_update_active_tasks(struct cgroup_subsys_state *css,
> -                          unsigned int clamps)
> +uclamp_update_active_tasks(struct cgroup_subsys_state *css)
>  {
>         enum uclamp_id clamp_id;
>         struct css_task_iter it;
> @@ -1670,10 +1659,8 @@ uclamp_update_active_tasks(struct cgroup_subsys_st=
ate *css,
>
>         css_task_iter_start(css, 0, &it);
>         while ((p =3D css_task_iter_next(&it))) {
> -               for_each_clamp_id(clamp_id) {
> -                       if ((0x1 << clamp_id) & clamps)
> -                               uclamp_update_active(p, clamp_id);
> -               }
> +               for_each_clamp_id(clamp_id)
> +                       uclamp_update_active(p, clamp_id);
>         }
>         css_task_iter_end(&it);
>  }
> @@ -9626,7 +9613,7 @@ static void cpu_util_update_eff(struct cgroup_subsy=
s_state *css)
>                 }
>
>                 /* Immediately update descendants RUNNABLE tasks */
> -               uclamp_update_active_tasks(css, clamps);
> +               uclamp_update_active_tasks(css);
>         }
>  }
>
> --
> 2.25.1
>
