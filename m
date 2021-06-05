Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7239C4FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFECPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:15:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F1C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 19:13:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m3so13906822lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNniSkgSAc5S7s5FLQAPPQEUdxZhABUBkTI5NiMDOWk=;
        b=jRrx7aGlQeP2pPya3RfBcXZJtRjTDPZPkXpwgLqjb0WFxZtdAgBtuzbueC8OJ+eYQO
         XQHO9JW9liS0K3aF6cEtphm3YGwNjSXesg+vIBV/UTYQFxSdLjwPleaAP4hzNbop+iMs
         7yK2jq95fRn6N9RZJWnecYlD4HrhHsTgxx+CqA4Jkc9xBB223/Ss6JOyJRsghj3uCtZ1
         ru3Ql2MfQq+egezgcdGiIfu38SGRHAFOfDYC8yIFPzRzUo+1dJ/Me2yNNSytTvYVeCeD
         Zl4tSHccvM3tTclcPfOd1tyssOQ4oaCvZlRXd8nVk7gizKi6hamY00CeAy5jZwEtKaPR
         aZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNniSkgSAc5S7s5FLQAPPQEUdxZhABUBkTI5NiMDOWk=;
        b=q4XQZ5m9JLuo6U54Nhia9/Qpgr8+gJr6x/gth/cAYAIrsIoZeHQIyZ1wDY13YWrMZi
         aPbz/2S615M1yIHZJVID9/szE5OIJXkBEiFTs31Idn2k8pnSKVHV3KyVAe2ahPfrPVj2
         ub5on9QBcjB9lDXZe6ijFud+TxDWR2EIyX3qtrD6J2Ni7d2k/6qtjBj8DwBqpEgoJEz+
         neqTUgjeI6kmFYbM8m8sTfH6MBqgnslvHZZm6KDJ/tSIePqRv/feoa5GWIsumjDjmRO7
         HdP+yhWjZW2g6L+aq3lTN/1aVb/UMaKbiyuFRmZWJHpVyjPXp2+op0Z6fYLPhvNQHXkF
         G7Ag==
X-Gm-Message-State: AOAM533o4XD4AYgjEkUHVN/Ntfgsn5FvhEIrKte4DFkdNfQ2sDDCkm0+
        T6w8T4NhU9GVjTsfkz3CYnNddenlXu+MN1XVU8o=
X-Google-Smtp-Source: ABdhPJzQAL70Mly6fL/m9Hhlf5q+cqNQPNifk2EBRlES54E+UaaCMO5oTiWbymT5UwEXh1A0rji9+ZA0eGEoLNc/Zro=
X-Received: by 2002:a2e:a717:: with SMTP id s23mr5561084lje.282.1622859210169;
 Fri, 04 Jun 2021 19:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com> <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
In-Reply-To: <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 5 Jun 2021 10:12:29 +0800
Message-ID: <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Sat, Jun 5, 2021 at 12:08 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/03/21 10:24, Xuewen Yan wrote:
> > +CC Qais
>
> Thanks for the CC :)
>
> >
> >
> > Hi Quentin
> >
> > On Wed, Jun 2, 2021 at 9:22 PM Quentin Perret <qperret@google.com> wrot=
e:
> > >
> > > +CC Patrick and Tejun
> > >
> > > On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
> > > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > > >
> > > > When setting cpu.uclamp.min/max in cgroup, there is no validating
> > > > like uclamp_validate() in __sched_setscheduler(). It may cause the
> > > > cpu.uclamp.min is bigger than cpu.uclamp.max.
> > >
> > > ISTR this was intentional. We also allow child groups to ask for
> > > whatever clamps they want, but that is always limited by the parent, =
and
> > > reflected in the 'effective' values, as per the cgroup delegation mod=
el.
>
> As Quentin said. This intentional to comply with cgroup model.
>
> See Limits and Protections sections in Documentation/admin-guide/cgroup-v=
2.rst
>
> Specifically
>
>         "all configuration combinations are valid"
>
> So user can set cpu.uclamp.min higher than cpu.uclamp.max. But when we ap=
ply
> the setting, cpu.uclamp.min will be capped by cpu.uclamp.max. I can see y=
ou
> found the cpu_util_update_eff() logic.
>

Thanks a lot for your patience to explain, sorry for my ignorance of
Documentation/admin-guide/cgroup-v2.rst.

> >
> > It does not affect the 'effective' value. That because there is
> > protection in cpu_util_update_eff():
> > /* Ensure protection is always capped by limit */
> > eff[UCLAMP_MIN] =3D min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
> >
> > When users set the cpu.uclamp.min > cpu.uclamp.max:
> > cpu.uclamp.max =3D 50;
> > to set : cpu.uclamp.min =3D 60;
> > That would make the uclamp_req[UCLAMP_MIN].value =3D 1024* 60% =3D 614,
> > uclamp_req[UCLAMP_MAX].value =3D 1024* 50% =3D 512;
> > But finally, the  uclamp[UCLAMP_MIN].value =3D uclamp[UCLAMP_MAX].value
> > =3D 1024* 50% =3D 512;
> >
> > Is it deliberately set not to validate because of the above?
>
> Sorry I'm not following you here. What code paths were you trying to expl=
ain
> here?
>
> Did you actually hit any problem here?

I just gave an example of the difference of uclamp_req and uclamp
without my patch, and can ignore it.

>
In addition=EF=BC=8CIn your patch:
6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com

+ switch (clamp_id) {
+ case UCLAMP_MIN: {
+ struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_id];
+ if (uc_req.value < uc_min.value)
+ return uc_min;
+ break;

When the clamp_id =3D UCLAMP_MIN, why not judge the uc_req.value is
bigger than task_group(p)->uclamp[UCLAMP_MAX] ?
Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp[UCLAMP_=
MAX],
the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into
[ task_group(p)->uclamp[UCLAMP_MAX],  task_group(p)->uclamp[UCLAMP_MAX] ].

Is it necessary to fix it here=EF=BC=9F

Thanks
xuewen
