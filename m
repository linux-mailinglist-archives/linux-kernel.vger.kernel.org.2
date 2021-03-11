Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4632F3375F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhCKOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:42:38 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42598 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhCKOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:42:35 -0500
Received: by mail-lj1-f170.google.com with SMTP id 184so2452717ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u1IosHfp6p5JH/cqt4eU5jrC6zgKtgcNu389nFIb0U=;
        b=Xoe82wCooWo81At2PHMxL8mlz9W+jVqaGh173A0cV/BXD+1YIKMokwVe77Q8xIPOxu
         GZ62Zs6daQTVmvqKlh7Vxfv011Ha8ZUHA7/xQpe9hGYlnrd2HiVQ40IuCu6d8CHLCfig
         eeYPPR4src5vQXCsVDSuWrUydn8M/GsuPyIJwHoRoLpa7oNJQWYw+LXCo3UxzyJ+JRgO
         IWsNWrM23k76WY/shPLoM9UELa9lhY9wxDUZ4g1kdjYLn8zgryTmNSBzOwY1iKcsNSdj
         XM3AEBlqQb0z2IxVXC7fJ/9WZkkE6yMEz0EwNFKu1rKjSCxiw4hwLRGansmZ0phqxlDJ
         P9Ww==
X-Gm-Message-State: AOAM533eZgrEoREwIvEfKX8aI78cvdoSAi9uesqzvt9zccfVNCULSIhd
        dzVfVFdaXM3NXNoglrxh/QiR/8p54K90nHnny8U=
X-Google-Smtp-Source: ABdhPJxcnMrRuA1+2fRiF/Rz6xgMy46OzROxip3Bo/pFkqrQmUbEZtJ+XiLadI3U4pvhDAzE0T97VIDzGI7OzKMtXAM=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr4885788ljj.26.1615473751579;
 Thu, 11 Mar 2021 06:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20210306082859.179541-1-yangjihong1@huawei.com> <53ff575f-1fcf-6650-76ad-a0304f6bdf15@huawei.com>
In-Reply-To: <53ff575f-1fcf-6650-76ad-a0304f6bdf15@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Mar 2021 23:42:20 +0900
Message-ID: <CAM9d7chRZq743y1Qb24eLZ5ScXeZs0b_0dyffRcOAwuLdVag7g@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix sample events lost in stdio mode
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 5:48 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2021/3/6 16:28, Yang Jihong wrote:
> > In hist__find_annotations function, since have a hist_entry per IP for the same
> > symbol, we free notes->src to signal already processed this symbol in stdio mode;
> > when annotate, entry will skipped if notes->src is NULL to avoid repeated output.

I'm not sure it's still true that we have a hist_entry per IP.
Afaik the default sort key is comm,dso,sym which means it should have a single
hist_entry for each symbol.  It seems like an old comment..

> >
> > However, there is a problem, for example, run the following command:
> >
> >   # perf record -e branch-misses -e branch-instructions -a sleep 1
> >
> > perf.data file contains different types of sample event.
> >
> > If the same IP sample event exists in branch-misses and branch-instructions,
> > this event uses the same symbol. When annotate branch-misses events, notes->src
> > corresponding to this event is set to null, as a result, when annotate
> > branch-instructions events, this event is skipped and no annotate is output.
> >
> > Solution of this patch is to add a u8 member to struct sym_hist and use a bit to
> > indicate whether the symbol has been processed.
> > Because different types of event correspond to different sym_hist, no conflict
> > occurs.
> > ---
> >   tools/perf/builtin-annotate.c | 22 ++++++++++++++--------
> >   tools/perf/util/annotate.h    |  4 ++++
> >   2 files changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index a23ba6bb99b6..c8c67892ae82 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -372,15 +372,21 @@ static void hists__find_annotations(struct hists *hists,
> >                       if (next != NULL)
> >                               nd = next;
> >               } else {
> > -                     hist_entry__tty_annotate(he, evsel, ann);
> > +                     struct sym_hist *h = annotated_source__histogram(notes->src,
> > +                                                                      evsel->idx);
> > +
> > +                     if (h->processed == 0) {
> > +                             hist_entry__tty_annotate(he, evsel, ann);
> > +
> > +                             /*
> > +                              * Since we have a hist_entry per IP for the same
> > +                              * symbol, set processed flag of evsel in sym_hist
> > +                              * to signal we already processed this symbol.
> > +                              */
> > +                             h->processed = 1;
> > +                     }
> > +
> >                       nd = rb_next(nd);
> > -                     /*
> > -                      * Since we have a hist_entry per IP for the same
> > -                      * symbol, free he->ms.sym->src to signal we already
> > -                      * processed this symbol.
> > -                      */
> > -                     zfree(&notes->src->cycles_hist);
> > -                     zfree(&notes->src);
> >               }
> >       }
> >   }
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index 096cdaf21b01..89872bfdc958 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -228,6 +228,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
> >   struct sym_hist {
> >       u64                   nr_samples;
> >       u64                   period;
> > +
> > +     u8                    processed  : 1, /* whether symbol has been processed, used for annotate */
> > +                           __reserved : 7;

I think just a bool member is fine.

> > +
> >       struct sym_hist_entry addr[];
> >   };
> >
> >
> Please check whether this solution is feasible, look forward to your review.

What about this?  (not tested)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a23ba6bb99b6..a91fe45bd69f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
                } else {
                        hist_entry__tty_annotate(he, evsel, ann);
                        nd = rb_next(nd);
-                       /*
-                        * Since we have a hist_entry per IP for the same
-                        * symbol, free he->ms.sym->src to signal we already
-                        * processed this symbol.
-                        */
-                       zfree(&notes->src->cycles_hist);
-                       zfree(&notes->src);
                }
        }
 }

Thanks,
Namhyung
