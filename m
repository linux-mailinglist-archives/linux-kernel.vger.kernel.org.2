Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077F134A039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCZD0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:26:13 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:33640 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCZDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:25:50 -0400
Received: by mail-qv1-f42.google.com with SMTP id o19so2340845qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPE1ecbfkcXjFJYDlygjKFefo8ys29WSSPKKPZLyfC4=;
        b=kLczpMhfRMmPsPicijvqzYrOXdLk2Jh5zuqNZ1yrs7TkxEGasVu0PZOrYeR6ghAnYB
         nr+tN0zm8FdQJmpwcNQ+0nsDWv/9o5kwU0utURX0KPTtDrM0iuWr2NSznpSHp9p18W/t
         cCmoxCXqRpErrOGcflsg51WBeLbZbYyv7jsR/6hiNbm+5fak2yjbbK3mrpFSigJG3PqX
         j5EspMuDw3p1coCrygiZKnXC3RPZ7Bui1sH3qqGB1ALj+IGuFiw6BV1M7U/RZTD4HetZ
         tGe1+b9/n0AnF9iLkMNISr6zFyduNvHQk6HB2bLpIxd90syUE5XaQcI4V+5oZ6W/oszQ
         30BA==
X-Gm-Message-State: AOAM533RWxHnNd6FhWMiZlqO4vMxxSB6BLoa1lQZVWxErM+CtCqeNXtM
        E6UWRwj5HIM2VoY4Tjs6X/xxy8i2BtWwD0YHVPY=
X-Google-Smtp-Source: ABdhPJyIn0REySIL1Guwzuw26P1EMlI2HzeW5KxAup9EadqVl2DJiA1TAA8arCVBcPOjMwNOdLqU4tFQvBXxrYDJcLU=
X-Received: by 2002:ad4:4bc7:: with SMTP id l7mr11411582qvw.36.1616729149391;
 Thu, 25 Mar 2021 20:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210319123527.173883-1-yangjihong1@huawei.com> <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
In-Reply-To: <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Mar 2021 12:25:37 +0900
Message-ID: <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
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

Hello,

On Fri, Mar 26, 2021 at 11:24 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
> ping :)
>
> On 2021/3/19 20:35, Yang Jihong wrote:
> > In hist__find_annotations function, since different hist_entry may point to same
> > symbol, we free notes->src to signal already processed this symbol in stdio mode;
> > when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
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
> > Solution of this patch is to remove zfree in hists__find_annotations and
> > change sort order to "dso,symbol" to avoid duplicate output when different
> > processes correspond to the same symbol.
> >
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> > ---
> >
> > Changes since v6:
> >    - Remove separate setup_sorting() for branch mode.
> >
> > Changes since v5:
> >    - Add Signed-off-by tag.
> >
> > Changes since v4:
> >    - Use the same sort key "dso,symbol" in branch stack mode.
> >
> > Changes since v3:
> >    - Modify the first line of comments.
> >
> > Changes since v2:
> >    - Remove zfree in hists__find_annotations.
> >    - Change sort order to avoid duplicate output.
> >
> > Changes since v1:
> >    - Change processed flag variable from u8 to bool.
> >
> >   tools/perf/builtin-annotate.c | 29 +++++++++++++++--------------
> >   1 file changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index a23ba6bb99b6..795c2ac7fcd1 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
> >               } else {
> >                       hist_entry__tty_annotate(he, evsel, ann);
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
> > @@ -619,14 +612,22 @@ int cmd_annotate(int argc, const char **argv)
> >
> >       setup_browser(true);
> >
> > -     if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
> > +     /*
> > +      * Events of different processes may correspond to the same
> > +      * symbol, we do not care about the processes in annotate,
> > +      * set sort order to avoid repeated output.
> > +      */
> > +     sort_order = "dso,symbol";
> > +
> > +     /*
> > +      * Set SORT_MODE__BRANCH so that annotate display IPC/Cycle
> > +      * if branch info is in perf data in TUI mode.
> > +      */
> > +     if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack)
> >               sort__mode = SORT_MODE__BRANCH;
> > -             if (setup_sorting(annotate.session->evlist) < 0)
> > -                     usage_with_options(annotate_usage, options);
> > -     } else {
> > -             if (setup_sorting(NULL) < 0)
> > -                     usage_with_options(annotate_usage, options);
> > -     }
> > +
> > +     if (setup_sorting(NULL) < 0)
> > +             usage_with_options(annotate_usage, options);
> >
> >       ret = __cmd_annotate(&annotate);
> >
> >
