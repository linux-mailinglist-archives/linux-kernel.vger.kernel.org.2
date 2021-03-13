Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75747339B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 04:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCMDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 22:07:06 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46369 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 22:07:05 -0500
Received: by mail-lf1-f50.google.com with SMTP id r3so40262755lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 19:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4swKLmHfF1Jt439uwQDvPovUVKN9h5VdXHM779dm5dQ=;
        b=oQECvwNBS/i3D/dgZcVWExZBxrn6qr8RQMgV09xZK+3C02N7m1Yf7HnJsDvnuliNMJ
         Cl+pQi+QAgHjlp0kee5DzS3bjcTLdZcbhvZEf6CncfGaQfbfHh3q5kHcj5xz0Mk67Vhv
         I40tKjYfjboRojnYwnogAznv9MrQFT0Nc0/tc1GOsLBNUcoWK7u6Y9AgcbtImA/1mcEq
         1SdQOHr3aTeWJMwHi4R8A2q4T0PrQXwY/L/QdIcl9qEm56IO01+XlUKo4hCs9CiqiRin
         qyjR9uW5LYxp4O+QYQMv6CXB/plMTVloknvJmCp81TvcvYZJaLwTPZGYnP2CTEkkPVun
         XVQA==
X-Gm-Message-State: AOAM531ghLiqNWqHVS6Tl23CPwdgleqiKm/JYcvHzOzQG4+NTakVaSF4
        oeuu5jx8UciloIRI+3mrh7XT9avz2qUZpaHimQQ=
X-Google-Smtp-Source: ABdhPJyEjcvDBrhfp1jkfnPw1U/nrmbuOmo2tAqUZyeCjGdZL2/yVIR9H00vC4AVNfBhFg9+wZ9GJo5fWGJLyXbqz00=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr1359334lfu.112.1615604824654;
 Fri, 12 Mar 2021 19:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20210313021540.219748-1-yangjihong1@huawei.com>
In-Reply-To: <20210313021540.219748-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 13 Mar 2021 12:06:53 +0900
Message-ID: <CAM9d7chGtOjUyD0S-BNtnDbL2A5CW=evhHa4cTg+ApBQOJAQ-w@mail.gmail.com>
Subject: Re: [PATCH v4] perf annotate: Fix sample events lost in stdio mode
To:     Yang Jihong <yangjihong1@huawei.com>,
        Yao Jin <yao.jin@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
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

Looks good.  But I'm not sure about the branch stack mode.
I suspect we can use the same sort key there.

Jin Yao, what do you think?

Thanks,
Namhyung

> ---
>  tools/perf/builtin-annotate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..ad169e3e2e8f 100644
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
> @@ -624,6 +617,12 @@ int cmd_annotate(int argc, const char **argv)
>                 if (setup_sorting(annotate.session->evlist) < 0)
>                         usage_with_options(annotate_usage, options);
>         } else {
> +               /*
> +                * Events of different processes may correspond to the same
> +                * symbol, we do not care about the processes in annotate,
> +                * set sort order to avoid repeated output.
> +                */
> +               sort_order = "dso,symbol";
>                 if (setup_sorting(NULL) < 0)
>                         usage_with_options(annotate_usage, options);
>         }
> --
> 2.30.GIT
>
