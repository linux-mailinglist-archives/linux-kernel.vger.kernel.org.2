Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531F53C1EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGIFfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jul 2021 01:35:09 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34483 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:35:08 -0400
Received: by mail-lf1-f49.google.com with SMTP id f30so20934361lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 22:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=of4Uv1oDCY66895me70gs3mz9ALtLfQtgbhRU7pneuU=;
        b=A5RscwD2jgf9D+Bho6Z7oIUBfO0JDnJV3ooGOSBicVFQFiwdhdK0fA4niRgi+QqNII
         v2bs//VzNQWixaGbJo3eq6Yn3V2y1n3qBOk6/IBUN51VlAKix85+jcwCwuzJvyhPtdzP
         VBOiYq/ZuOvBWDwPaa3dK2iPM2x8kvMu63e4WWJOtcMoDjHB/Rg1FqlEL+HdDcoVsjem
         g+H/QKvq8LIB7FJuwT1u48Sm+5pULc7Iy4t3eGtqwW+arh91aeXE3cyT3Or8UYs2pKrr
         QTq4G+BnMYeYwplPPPkPkWfucKbll1QhbwELhJmBA4VGXo0l9heTZlPPE6CdE2UNBOpB
         26yw==
X-Gm-Message-State: AOAM530S8raU92RPBLjdZggvjXz/WwFejx/zkyv2IvMCylvjqkaoe/hD
        HqmdPPfd4chYWalenhN8wQv0ms8FFEwGH/e+T/o=
X-Google-Smtp-Source: ABdhPJyqG3llfna9oWWsRtMUIToCplg1ItpPbhFsoPGyeUdqvJYaDX+YydRa9EUWioFjm+bXiU33YDeQ9pKx4affQc0=
X-Received: by 2002:a05:6512:3125:: with SMTP id p5mr7054396lfd.635.1625808744642;
 Thu, 08 Jul 2021 22:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <1625760212-18441-1-git-send-email-kan.liang@intel.com>
In-Reply-To: <1625760212-18441-1-git-send-email-kan.liang@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jul 2021 22:32:13 -0700
Message-ID: <CAM9d7cgGmAsa1wCQJM_FfhiG9+ULqAdCTyqw4wSqbnNSzvrdWQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Add a dummy event for a hybrid system
To:     "Liang, Kan" <kan.liang@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 9:05 AM <kan.liang@intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Some symbols may not be resolved if a user only monitor one type of PMU.
>
>  $ sudo perf record -e cpu_atom/branch-instructions/ ./big_small_workload
>  $ sudo perf report –stdio
>  # Overhead  Command    Shared Object      Symbol
>  # ........  .........  .................
>  # ......................................
>  #
>     28.02%  perf-exec  [unknown]          [.] 0x0000000000401cf6
>     11.32%  perf-exec  [unknown]          [.] 0x0000000000401d04
>     10.90%  perf-exec  [unknown]          [.] 0x0000000000401d11
>     10.61%  perf-exec  [unknown]          [.] 0x0000000000401cfc
>
> To parse symbols, the side-band events, e.g., COMM, which are generated
> by the kernel are required. To decide whether to generate the side-band
> event, the kernel relies on the event_filter_match() to filter the
> unrelated events. On a hybrid system, the event_filter_match() further
> checks the CPU mask of the current enabled PMU. If an event is collected
> on the CPU which doesn't have an enabled PMU, it's treated as an
> unrelated event.
>
> The "big_small_workload" is created in a big core, but runs on a small
> core. The side-band events are filtered, because the user only monitors
> the PMU of the small core. The big core PMU is not enabled.
>
> For a hybrid system, a dummy event is required to generate the complete
> side-band events.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 3337b5f..99607b9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -891,11 +891,12 @@ static int record__open(struct record *rec)
>         int rc = 0;
>
>         /*
> -        * For initial_delay or system wide, we need to add a dummy event so
> -        * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> -        * event synthesis.
> +        * For initial_delay or system wide or a hybrid system, we need to
> +        * add a dummy event so that we can track PERF_RECORD_MMAP to cover
> +        * the delay of waiting or event synthesis.
>          */
> -       if (opts->initial_delay || target__has_cpu(&opts->target)) {
> +       if (opts->initial_delay || target__has_cpu(&opts->target) ||
> +           perf_pmu__has_hybrid()) {
>                 pos = evlist__get_tracking_event(evlist);
>                 if (!evsel__is_dummy_event(pos)) {
>                         /* Set up dummy event. */
> --
> 2.7.4
>
