Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85112338589
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCLFuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:50:18 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37601 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCLFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:50:06 -0500
Received: by mail-lj1-f170.google.com with SMTP id r20so5251921ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IV3NZiNFAS5A7cXUH7NmxZleLFBO2FBJW3ale1hwyBw=;
        b=K7NL0KTCAHoJw3fV3hCjlvF1CZsk1id3oL2s4dLE0oqhaVeEM6PCKWDeL0bkNsn6Lh
         oGJHak8C96g/Q9jy7WO6M7DbkiEomj2SKKo8bP0GRFQZQ6PMEe49CuERpxkAjCH1FLYn
         CtQYE8ORx3fcVkzbkJJJ4uOlmMr+UXz5QCuqhQST822L4W3lQfMU6txoodf/Xp5NKHxg
         1ZffufcOwmX1Lk8dhowTWZhS9tjjw1hazSAjnej7+23pY/a3cYx7cqBa5sytKGlKLv3+
         gIiva10FZ7+Pp6F3Isj5wOd7ijJm1cXCUH3E98aADxns6TdR8f+QbPMqvM4HWl3m+f0w
         Q7zQ==
X-Gm-Message-State: AOAM5334usjV4edrytAklaRH5FvMJ7fFalrQqBt4lZrnTleakgJFKkYl
        asxyVDQ6u5QUietlZDeFuRwcy0DwP+/GpfcHO+w=
X-Google-Smtp-Source: ABdhPJxbx2LNprMkkadSCsSsO270Jky4ySuY4TrRGMxhyTUFeKgOLxSdOGwJjPCWZTHiVNmSoLKirAoJ0WpEqWf2pRk=
X-Received: by 2002:a2e:5057:: with SMTP id v23mr1313695ljd.393.1615528204881;
 Thu, 11 Mar 2021 21:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20210306082859.179541-1-yangjihong1@huawei.com>
 <53ff575f-1fcf-6650-76ad-a0304f6bdf15@huawei.com> <CAM9d7chRZq743y1Qb24eLZ5ScXeZs0b_0dyffRcOAwuLdVag7g@mail.gmail.com>
 <02146240-e532-1c52-0589-bfff3fbe5166@huawei.com>
In-Reply-To: <02146240-e532-1c52-0589-bfff3fbe5166@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 12 Mar 2021 14:49:53 +0900
Message-ID: <CAM9d7cjHAEhc-g4Fs3muwQrMV=Os5cn6NgOkf4vBeE+QK-Wu=w@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 12:24 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello, Namhyung
>
> On 2021/3/11 22:42, Namhyung Kim wrote:
> > Hi,
> >
> > On Thu, Mar 11, 2021 at 5:48 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >>
> >> Hello,
> >>
> >> On 2021/3/6 16:28, Yang Jihong wrote:
> >>> In hist__find_annotations function, since have a hist_entry per IP for the same
> >>> symbol, we free notes->src to signal already processed this symbol in stdio mode;
> >>> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
> >
> > I'm not sure it's still true that we have a hist_entry per IP.
> > Afaik the default sort key is comm,dso,sym which means it should have a single
> > hist_entry for each symbol.  It seems like an old comment..
> >
> Emm, yes, we have a hist_entry for per IP.
> a member named "sym" in struct "hist_entry" points to symbol,
> different IP may point to the same symbol.

Are you sure about this?  It seems like a bug then.

>
> The hist_entry struct is as follows:
> struct hist_entry {
>      ...
>      struct map_symbol ms;
>      ...
> };
> struct map_symbol {
>      struct maps *maps;
>      struct map *map;
>      struct symbol *sym;
> };
>
> >>>
> >>> However, there is a problem, for example, run the following command:
> >>>
> >>>    # perf record -e branch-misses -e branch-instructions -a sleep 1
> >>>
> >>> perf.data file contains different types of sample event.
> >>>
> >>> If the same IP sample event exists in branch-misses and branch-instructions,
> >>> this event uses the same symbol. When annotate branch-misses events, notes->src
> >>> corresponding to this event is set to null, as a result, when annotate
> >>> branch-instructions events, this event is skipped and no annotate is output.
> >>>
> >>> Solution of this patch is to add a u8 member to struct sym_hist and use a bit to
> >>> indicate whether the symbol has been processed.
> >>> Because different types of event correspond to different sym_hist, no conflict
> >>> occurs.
> >>> ---
> >>>    tools/perf/builtin-annotate.c | 22 ++++++++++++++--------
> >>>    tools/perf/util/annotate.h    |  4 ++++
> >>>    2 files changed, 18 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> >>> index a23ba6bb99b6..c8c67892ae82 100644
> >>> --- a/tools/perf/builtin-annotate.c
> >>> +++ b/tools/perf/builtin-annotate.c
> >>> @@ -372,15 +372,21 @@ static void hists__find_annotations(struct hists *hists,
> >>>                        if (next != NULL)
> >>>                                nd = next;
> >>>                } else {
> >>> -                     hist_entry__tty_annotate(he, evsel, ann);
> >>> +                     struct sym_hist *h = annotated_source__histogram(notes->src,
> >>> +                                                                      evsel->idx);
> >>> +
> >>> +                     if (h->processed == 0) {
> >>> +                             hist_entry__tty_annotate(he, evsel, ann);
> >>> +
> >>> +                             /*
> >>> +                              * Since we have a hist_entry per IP for the same
> >>> +                              * symbol, set processed flag of evsel in sym_hist
> >>> +                              * to signal we already processed this symbol.
> >>> +                              */
> >>> +                             h->processed = 1;
> >>> +                     }
> >>> +
> >>>                        nd = rb_next(nd);
> >>> -                     /*
> >>> -                      * Since we have a hist_entry per IP for the same
> >>> -                      * symbol, free he->ms.sym->src to signal we already
> >>> -                      * processed this symbol.
> >>> -                      */
> >>> -                     zfree(&notes->src->cycles_hist);
> >>> -                     zfree(&notes->src);
> >>>                }
> >>>        }
> >>>    }
> >>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> >>> index 096cdaf21b01..89872bfdc958 100644
> >>> --- a/tools/perf/util/annotate.h
> >>> +++ b/tools/perf/util/annotate.h
> >>> @@ -228,6 +228,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
> >>>    struct sym_hist {
> >>>        u64                   nr_samples;
> >>>        u64                   period;
> >>> +
> >>> +     u8                    processed  : 1, /* whether symbol has been processed, used for annotate */
> >>> +                           __reserved : 7;
> >
> > I think just a bool member is fine.
> >
> OK, I have submitted the v2 patch and changed to bool member, new patch
> is as follows, look forward to your review:
> https://lore.kernel.org/patchwork/patch/1393901/
>
> >>> +
> >>>        struct sym_hist_entry addr[];
> >>>    };
> >>>
> >>>
> >> Please check whether this solution is feasible, look forward to your review.
> >
> > What about this?  (not tested)
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index a23ba6bb99b6..a91fe45bd69f 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
> >                  } else {
> >                          hist_entry__tty_annotate(he, evsel, ann);
> >                          nd = rb_next(nd);
> > -                       /*
> > -                        * Since we have a hist_entry per IP for the same
> > -                        * symbol, free he->ms.sym->src to signal we already
> > -                        * processed this symbol.
> > -                        */
> > -                       zfree(&notes->src->cycles_hist);
> > -                       zfree(&notes->src);
> >                  }
> >          }
> >   }
> >
> This solution may have the following problem:
> For example, if two sample events are in two different processes but in
> the same symbol, repeated output may occur.
> Therefore, a flag is required to indicate whether the symbol has been
> processed to avoid repeated output.

Hmm.. ok.  Yeah we don't care about the processes here.
Then we should remove it from the sort key like below:

@@ -624,6 +617,7 @@ int cmd_annotate(int argc, const char **argv)
                if (setup_sorting(annotate.session->evlist) < 0)
                        usage_with_options(annotate_usage, options);
        } else {
+               sort_order = "dso,symbol";
                if (setup_sorting(NULL) < 0)
                        usage_with_options(annotate_usage, options);
        }


Thanks,
Namhyung
