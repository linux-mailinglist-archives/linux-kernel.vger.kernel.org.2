Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD839C8CC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFEN1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:27:34 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39911 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFEN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:27:33 -0400
Received: by mail-lj1-f181.google.com with SMTP id c11so15265122ljd.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N469RuGi6ZWsLDBCwz00gLBrvi6ge2dfVgCQbJm7kQI=;
        b=QeVXB5G72+p8Ez+eWs3VGCoNT6f0okqt+wdsyPMVs4cct3iCMig/5caHd25NIO8haT
         0vOqterek8vS5p2EvnxzRGGjzF81aEFxUnTDLWrJDKv+mYIskLPsyGyCfnsmg3STyOmC
         3SoayK7otMW8ptlVU4w8k0Bpa5Xbo7Nu6VPNohcjGgekIAyQjQ+FDR3wKO5qwisR7Gio
         6+NmwUamJGNklxzX4Pgp2MBw74h7b45B5JxxkCzlnkgGWpP1oEcfqEpSWE+wZA5iiF+n
         8yOTKCOnCkEsVE911pND8S1up6XUdE85AZA9Aw+WnL4dH+dEt6DwsbFd/FoPeDr1yy0+
         IvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N469RuGi6ZWsLDBCwz00gLBrvi6ge2dfVgCQbJm7kQI=;
        b=J5n4zvNHjNetYPSYk1FhHRsjfJPfBSL4PntAoZAipEqQk28JZu6uWIn9+a0nq3CECi
         SHrjsN0ahxLWl7Z2ASoZUkCPQZc4WrCHThCokfMIgDpziGv51/5NlxvYMR2RG86KDupS
         4S6ETQmCps1ozsffj73HRI9DW+Lc0ebrBXIODDxSbPI8OXC2JSetPcAvIOcYTlp9JYfN
         lsZsY/AYhGab4vJaAaQSSHldcPke0in7sHRQr7PUpV8edNPm2nG+LP3Vzd6XzBJ+g9tM
         7TZCSX2ofxPGYRLF8p0EHow4A4a5sVDYP1mjDqiocjlba5eKbIuZASi11x5yFMRxEcrd
         73PA==
X-Gm-Message-State: AOAM530DEHxmrm6IXEHDhMtMG/OpdquIvGCfuqIX1e1zp1i4+eRhjGrr
        ATuq6XHHVYe4W3O2MnN3PvTKG4+n3aMZ6Pxx2Iw=
X-Google-Smtp-Source: ABdhPJwx/oSgh8MNmB5+I1jhSpMD8SpycR6ExuGselAMxyEacCE9Dx+3ae7dcqYSj023tXwb2i53mDId+mgZIt8Qz5s=
X-Received: by 2002:a2e:a544:: with SMTP id e4mr7471846ljn.265.1622899471105;
 Sat, 05 Jun 2021 06:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com> <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com> <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
In-Reply-To: <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 5 Jun 2021 21:24:20 +0800
Message-ID: <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com>
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

Hi Qais

On Sat, Jun 5, 2021 at 7:49 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > In addition=EF=BC=8CIn your patch:
> > 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.mi=
n")
> > https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
> >
> > + switch (clamp_id) {
> > + case UCLAMP_MIN: {
> > + struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_id];
> > + if (uc_req.value < uc_min.value)
> > + return uc_min;
> > + break;
> >
> > When the clamp_id =3D UCLAMP_MIN, why not judge the uc_req.value is
> > bigger than task_group(p)->uclamp[UCLAMP_MAX] ?
>
> Because of the requirement I pointed you to in cgroup-v2.rst. We must all=
ow any
> value to be requested.
>
> Ultimately if we had
>
>         cpu.uclamp.min =3D 80
>         cpu.uclamp.max =3D 50
>
> then we want to remember the original request but make sure the effective=
 value
> is capped.
>
> For the user in the future modifies the values such that
>
>         cpu.uclamp.max =3D max
>
> Then we want to remember cpu.uclamp.min =3D 80 and apply it since now the
> cpu.uclamp.max was relaxed to allow the boost value.
>
> > Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp[UCL=
AMP_MAX],
> > the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into
> > [ task_group(p)->uclamp[UCLAMP_MAX],  task_group(p)->uclamp[UCLAMP_MAX]=
 ].
> >
> > Is it necessary to fix it here=EF=BC=9F
>
> Nope. We must allow any combination values to be accepted and remember th=
em so
> if one changes we ensure the new effective value is updated accordingly.
> This is how cgroups API works.

Sorry. I may not have expressed it clearly. In your patch (which has
not yet merged into the mainline):

6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
 https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com

This patch will not affect p->uclamp_req, but consider the following situat=
ion:

tg->cpu.uclamp.min =3D 0
tg->cpu.uclamp.max =3D 50%

p->uclamp_req[UCLAMP_MIN] =3D 60%
p->uclamp_req[UCLAMP_MIN] =3D 80%

The function call process is as follows=EF=BC=9A
uclamp_eff_value() -> uclamp_eff_get() ->uclamp_tg_restrict()

with your patch, the result is:

p->effective_uclamp_min =3D 60%
p->effective_uclamp_max =3D 50%

It would not affect the uclamp_task_util(p), but affect the rq:
when p enqueued:
rq->uclamp[UCLAMP_MIN] =3D 60%
rq->uclamp[UCLAMP_MIN] =3D 50%

futher more,  in uclamp_rq_util_with() {
...

min_util =3D READ_ONCE(rq->uclamp[UCLAMP_MIN].value); //60%
max_util =3D READ_ONCE(rq->uclamp[UCLAMP_MAX].value);//50%
...
if (unlikely(min_util >=3D max_util))
return min_util;

return clamp(util, min_util, max_util);
...
}
as a result, it would return 60%.

Thanks!
xuewen
