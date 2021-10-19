Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBD433F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhJSUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhJSUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:02:50 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CEFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:00:37 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k3so19671005ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9NU9PI5h+XIjdFaV8cJFhnAUvW54J00YhhaMQMKLO8o=;
        b=JqOvObYObmHnMw/K5VX2OvTdj7KV86fkY/1/00npJRjr4O56ZHVu9hpu31vU+2esAw
         upoaZHzqKeITLw+FmxVqOTnhdxJlV5hD/GcE9HKPB716Fby5Q1sfqTvA2S5um/SYCPVl
         aLoVSxXZkrlPCsNLgKv+fw1iOMqO7nAkpgD5ETA9d2ionMfzs+vItT/+TyD8L8TszHc+
         tW3eoeWdwzbg5ompA1VYx3Eq1t82BjpbcL3TI21Evry4qKiZS8TbgYW06UO5ZMrdE0zv
         X6/vaJjlLo5jQqGpMZK/PokiXpCZx9g08UXmzEUbz0Y9ZE1nPxp2WOoOClPNyhF6gpQD
         6NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NU9PI5h+XIjdFaV8cJFhnAUvW54J00YhhaMQMKLO8o=;
        b=0eNT9ByinWp2zsB6vuP1y6KfoMr1oG/yr4f2141JdKwYfoZck3gxv+FX8F7JGq+wZP
         lAK/R82hBUmHUO7DPEtgdD0mfnKmqbRLKK4vwRKYesj+uVfNjCcjt5B++3Hltbcvfvyu
         OUWgo146SJHC8kQXF+K6KNWMyNDlhoNOqfEOtXiULQRPMcZ87AUHPXnDu+rfKfY+C7IH
         MoXUNxfX1OJjnPJjcMj5bfbxHU32S6YYUGbOMxt/78ZGJqzzqgc28AdU8MszJAz1dn+T
         2N2PfQ3Hki/u9BuqIAblOv5PRy1AXs9UJyEaGYPxLOY1dqXbXfztBgZ0Q80gJINjiSNR
         GgPw==
X-Gm-Message-State: AOAM532bWpQZIqmVu+8d4sEqOAex4a/xehsTb78Jkv0uDPCsxB3owPo6
        46Tu7YG8e4QX6+w2kXVlwaL+Z1ctZzOqRPwib1YHEg==
X-Google-Smtp-Source: ABdhPJyqOJ7lv0Mj1nbom5b8As8VQx02ZXfyxIgGChPV+oeW9WuS3DO8uf2HdmxZxxCCGUaiXCAjk15iIYUFpnNcwyE=
X-Received: by 2002:a05:6e02:1ca8:: with SMTP id x8mr20827199ill.150.1634673636531;
 Tue, 19 Oct 2021 13:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com> <20211015172132.1162559-22-irogers@google.com>
 <YW7e6OvE/juYY8it@kernel.org> <YW7gsEDXBw1jk65o@kernel.org>
 <YW7hdvJ8eHS/jlgx@kernel.org> <YW7htMxwcNjZOtJH@kernel.org>
In-Reply-To: <YW7htMxwcNjZOtJH@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Oct 2021 13:00:23 -0700
Message-ID: <CAP-5=fV85eOA5_vpaNSx5M8thSVvoiF+tzDmYe83TPF7Hk+0vA@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] perf metric: Allow modifiers on metrics.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 8:18 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 19, 2021 at 12:17:10PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Oct 19, 2021 at 12:13:52PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Tue, Oct 19, 2021 at 12:06:17PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Fri, Oct 15, 2021 at 10:21:32AM -0700, Ian Rogers escreveu:
> > > > > By allowing modifiers on metrics we can, for example, gather the
> > > > > same metric for kernel and user mode. On a SkylakeX with
> > > > > TopDownL1 this gives:
> > > > >
> > > > > $ perf stat -M TopDownL1:u,TopDownL1:k -a sleep 2
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > >
> > > > Hi Ian, can you please take a look on this? this is on my perf/core
> > > > branch.
> > >
> > > I processed the first version of this series, reviewed by Andi, can y=
ou
> > > please submit the diff from one to the other?
> >
> > The interdiff from the 21st patch on the first batch versus on the v2
> > batch is below, but it doesn't apply to my current perf/core branch,
> > lemme push it to tmp.perf/core...
>
> It was there already, what I have locally is what is in tmp.perf/core.

Hi Arnaldo,

The last change I see in tmp.perf/core is:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
tmp.perf/core&id=3D5f43061b84d815c0f6477c1a8836bf0c6fec15a2

The difference between v2 and v1 which fixes this bug is:

+@@ -1500,7 +1568,10 @@ int metricgroup__copy_metric_events(struct
evlist *evlist, struct cgroup *cgrp,
+                               return -ENOMEM;
+
+                       new_expr->metric_expr =3D old_expr->metric_expr;
+-                      new_expr->metric_name =3D old_expr->metric_name;
++                      new_expr->metric_name =3D strdup(old_expr->metric_n=
ame);
++                      if (!new_expr->metric_name)
++                              return -ENOMEM;
++
+                       new_expr->metric_unit =3D old_expr->metric_unit;
+                       new_expr->runtime =3D old_expr->runtime;
+

I also cleaned up some checkpatch line length warnings in v2, which I
think is the reason for the other changes. Ideally I'd prefer the v2
patch set over the v1, but they are largely identical. Both were based
on acme/perf/core. Let me know how I can help.

Thanks,
Ian

> > - Arnaldo
> >
> > =E2=AC=A2[acme@toolbox perf]$ interdiff ~/wb/old.patch ~/wb/new.patch
> > diff -u b/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > --- b/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1308,8 +1308,7 @@
> >       int ret;
> >
> >       *out_evlist =3D NULL;
> > -     ret =3D metricgroup__build_event_string(&events, ids, modifier,
> > -                                           has_constraint);
> > +     ret =3D metricgroup__build_event_string(&events, ids, has_constra=
int);
> >       if (ret)
> >               return ret;
> >
> > @@ -1324,7 +1323,8 @@
> >
> >               ids__insert(ids->ids, tmp);
> >       }
> > -     ret =3D metricgroup__build_event_string(&events, ids, has_constra=
int);
> > +     ret =3D metricgroup__build_event_string(&events, ids, modifier,
> > +                                           has_constraint);
> >       if (ret)
> >               return ret;
> >
> > @@ -1568,7 +1568,10 @@
> >                               return -ENOMEM;
> >
> >                       new_expr->metric_expr =3D old_expr->metric_expr;
> > -                     new_expr->metric_name =3D old_expr->metric_name;
> > +                     new_expr->metric_name =3D strdup(old_expr->metric=
_name);
> > +                     if (!new_expr->metric_name)
> > +                             return -ENOMEM;
> > +
> >                       new_expr->metric_unit =3D old_expr->metric_unit;
> >                       new_expr->runtime =3D old_expr->runtime;
> >
> > =E2=AC=A2[acme@toolbox perf]$
>
> --
>
> - Arnaldo
