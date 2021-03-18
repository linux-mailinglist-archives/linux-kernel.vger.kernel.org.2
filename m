Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC81133FF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCRGOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:14:00 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:33520 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCRGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:13:50 -0400
Received: by mail-lf1-f42.google.com with SMTP id m17so2710061lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRpkqVfWMOikxM6ZwfLrrgVLEZOXSDhaDwqwMwZfRaI=;
        b=bjzAYG0MtGPAjDOkV633E+Wo1a7S3YNWKHcycui1rqDDQH1blq8lQcOXFbYYWH5QUs
         0I/d+uWSEZrW4izcjnS3qDI/bBKsWttdpfywQEQLwB2bzMbKfn9segiL9CL/d0vcGDf7
         2UA0xLkz1wyCA1+V2EPC80aEv7BQqnMjqC52LSXbGxzCEG8xS2kHu5YD1ccomHkHiSMx
         vE/+TOEKYlK0tWJUlQBzIETay1jIx6v+gXn0CdKtdtxDM/JkcMk0KSlGMpWSD7T6bLAM
         uP7s13GczWjZCb3lUG0l9m0yfrGPprk8lDthWVPsr4J9YhqIkI8LWLFa1dT5Jm3YnxTN
         LE8g==
X-Gm-Message-State: AOAM530gUxq0YZ3omP+ZxAzvcYSqk6QNCUFVAHzBXxNBWS+pzyxiE0up
        gOADh6uHjkBCS95UbZ3es0210AHNQ1VgPQ4xkGs=
X-Google-Smtp-Source: ABdhPJylTJXZTj28IjLv96vmBT+dRYSmTgG+SZpd+VQZt8zyi3SSeainiino8vFtIyFkNLmfTzhafTUx1i14Q1AQiQQ=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr1145697lfk.509.1616048028865;
 Wed, 17 Mar 2021 23:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210317094409.94293-1-yangjihong1@huawei.com>
In-Reply-To: <20210317094409.94293-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Mar 2021 15:13:37 +0900
Message-ID: <CAM9d7cjg059U8rn+BDfFrPAQ8xBUaMRJWsdbpm8f2bMcvx7OiQ@mail.gmail.com>
Subject: Re: [PATCH v6] perf annotate: Fix sample events lost in stdio mode
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 17, 2021 at 6:44 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> In hist__find_annotations function, since different hist_entry may point to same
> symbol, we free notes->src to signal already processed this symbol in stdio mode;
> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
>
> However, there is a problem, for example, run the following command:
>
>  # perf record -e branch-misses -e branch-instructions -a sleep 1
>
> perf.data file contains different types of sample event.
>
> If the same IP sample event exists in branch-misses and branch-instructions,
> this event uses the same symbol. When annotate branch-misses events, notes->src
> corresponding to this event is set to null, as a result, when annotate
> branch-instructions events, this event is skipped and no annotate is output.
>
> Solution of this patch is to remove zfree in hists__find_annotations and
> change sort order to "dso,symbol" to avoid duplicate output when different
> processes correspond to the same symbol.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>
> Changes since v5:
>   - Add Signed-off-by tag.
>
> Changes since v4:
>   - Use the same sort key "dso,symbol" in branch stack mode.
>
> Changes since v3:
>   - Modify the first line of comments.
>
> Changes since v2:
>   - Remove zfree in hists__find_annotations.
>   - Change sort order to avoid duplicate output.
>
> Changes since v1:
>   - Change processed flag variable from u8 to bool.
>
>  tools/perf/builtin-annotate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..92c55f292c11 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>                 } else {
>                         hist_entry__tty_annotate(he, evsel, ann);
>                         nd = rb_next(nd);
> -                       /*
> -                        * Since we have a hist_entry per IP for the same
> -                        * symbol, free he->ms.sym->src to signal we already
> -                        * processed this symbol.
> -                        */
> -                       zfree(&notes->src->cycles_hist);
> -                       zfree(&notes->src);
>                 }
>         }
>  }
> @@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)
>
>         setup_browser(true);
>
> +       /*
> +        * Events of different processes may correspond to the same
> +        * symbol, we do not care about the processes in annotate,
> +        * set sort order to avoid repeated output.
> +        */
> +       sort_order = "dso,symbol";

At this point, I think there's not much value having separate
setup_sorting() for branch mode.

Thanks,
Namhyung


>         if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
>                 sort__mode = SORT_MODE__BRANCH;
>                 if (setup_sorting(annotate.session->evlist) < 0)
> --
> 2.30.GIT
>
