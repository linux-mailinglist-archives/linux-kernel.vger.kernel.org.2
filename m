Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A126E3B270C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhFXF6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFXF6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:58:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C299C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 22:56:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so4240292wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qv9qpreZYcIMl3HaN2mUlk2QXXvwXhDkchZSDNlFpQk=;
        b=rGgc8NfQ+i41/Rcwz4fakxy+SEa1YSJGBJEW/v18eTuHgv+f8u5lZDeGpwYuSlF5Xf
         M21tgvNwLEYxB6SsyYLNCP7IzucPwNGMN2dTpN0dt81KUSR2vY43bFMu0iXgeD8ZlZXT
         hRBRpRACenfI+Ut0wQpIFyP5jFm8CZiX3HPZU0WROcAQNaAppncQgPgZv8hpd/I14tga
         yEKbCmhN91cUwBOZdNfo9qvswoKcjUDYVLid51FCUadyd+gxPiatAIZG34Lmj7yeJkbT
         zc1b8j7uJVIaDigk6VFqZzgVH+sRofz40GSIeuSeOqzyJ6To4dRn6v2XJ+JzUc55iCuc
         ghPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qv9qpreZYcIMl3HaN2mUlk2QXXvwXhDkchZSDNlFpQk=;
        b=MDWEq13lhKS7bvc2Z4TZhkOMLy4kcgh1aOku1arpWNEcKIb3MQBh0+y3Vu54Lmseg2
         VjGmLj1bROl4+1cwoWbjyMw12KzoLeJWH+XOpYrXIrmTVkKLB5qR6lUTUQrsf8GQxS4D
         CG6jD2NklSn+W9gxAcPRkziE5wZJ0IIyPQjf7b6hK5ldu1JYN7mvMzlRwtDzuOjPnVGd
         mytbI59JnFPnWrVKwtQ5S2hLahj3meScOsA3IVpbnutH1ovsK5dEQBMGCwmE2IQTTd3T
         F1bYmWbdwOTdE4KZcAvtEZyz5YEDXq2uU5zgVXTubc1a+53k07Z3tVcPV0pXsm3QPeZa
         5/Ww==
X-Gm-Message-State: AOAM53156a3N1X+Ry9G78CfzsFaWjEsCjWwtunnQjbWEvys9EFYKeWYs
        4RoM5fTzlAsTWt0MWj96o3rHfSqgmrCiDqKEwDRFFw==
X-Google-Smtp-Source: ABdhPJwiIo/IYvBiU7seSCQMKKgoauubM/SbdHVF0R4G8Kts+IGTt1cLyOiBz9YAVLrvsXG4I7+3w8jBjhVoYUpHGAQ=
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr2183608wmi.58.1624514186644;
 Wed, 23 Jun 2021 22:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210616231829.3735671-1-joshuamart@google.com>
In-Reply-To: <20210616231829.3735671-1-joshuamart@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Jun 2021 22:56:15 -0700
Message-ID: <CAP-5=fVmCQHFEHVbzYp_CbO1phhzTB84=2dg-EM1VmDf8NNxWw@mail.gmail.com>
Subject: Re: [PATCH] perf top: Add cgroup support for perf top (-G)
To:     Joshua Martinez <joshuamart@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 4:18 PM Joshua Martinez <joshuamart@google.com> wrote:
>
> Added callback option (-G) to support cgroups for perf top.
> Added condition to make sure -cgroup and --all-cgroups aren't both enabled.
>
> Example:
> $perf top -e cycles -G system.slice/docker-6b95a5eb649c0d671eba3835f0d93973d05a088f3ae8602246bde37affb1ba3e.scope -a --stdio
>
>    PerfTop:    3330 irqs/sec  kernel:68.2%  exact:  0.0% lost: 0/0 drop: 0/11075 [4000Hz cpu-clock],  (all, 4 CPUs)
> ----------------------------------------------------------------------------------------------------------------------------------------------------------
>
>     27.32%  [unknown]         [.] 0x00007f8ab7b69352
>     11.44%  [kernel]          [k] 0xffffffff968cd657
>      3.12%  [kernel]          [k] 0xffffffff96160e96
>      2.63%  [kernel]          [k] 0xffffffff96160eb0
>      1.96%  [kernel]          [k] 0xffffffff9615fcf6
>      1.42%  [kernel]          [k] 0xffffffff964ddfc7
>      1.09%  [kernel]          [k] 0xffffffff96160e90
>      0.81%  [kernel]          [k] 0xffffffff96160eb3
>      0.67%  [kernel]          [k] 0xffffffff9615fec1
>      0.57%  [kernel]          [k] 0xffffffff961ee1d0
>      0.53%  [unknown]         [.] 0x00007f8ab7b6666c
>      0.53%  [kernel]          [k] 0xffffffff96160e64
>      0.52%  [kernel]          [k] 0xffffffff9616c303
>      0.51%  [kernel]          [k] 0xffffffffc08e7d50
>      ...
>
> Signed-off-by: Joshua Martinez <joshuamart@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/Documentation/perf-top.txt | 12 ++++++++++++
>  tools/perf/builtin-top.c              |  8 ++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index bba5ffb05463..9898a32b8d9c 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -277,6 +277,18 @@ Default is to monitor all CPUS.
>         Record events of type PERF_RECORD_NAMESPACES and display it with the
>         'cgroup_id' sort key.
>
> +-G name::
> +--cgroup name::
> +monitor only in the container (cgroup) called "name". This option is available only
> +in per-cpu mode. The cgroup filesystem must be mounted. All threads belonging to
> +container "name" are monitored when they run on the monitored CPUs. Multiple cgroups
> +can be provided. Each cgroup is applied to the corresponding event, i.e., first cgroup
> +to first event, second cgroup to second event and so on. It is possible to provide
> +an empty cgroup (monitor all the time) using, e.g., -G foo,,bar. Cgroups must have
> +corresponding events, i.e., they always refer to events defined earlier on the command
> +line. If the user wants to track multiple events for a specific cgroup, the user can
> +use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
> +
>  --all-cgroups::
>         Record events of type PERF_RECORD_CGROUP and display it with the
>         'cgroup' sort key.
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 69cb3635f5ef..2d570bfe7a56 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -22,6 +22,7 @@
>
>  #include "util/annotate.h"
>  #include "util/bpf-event.h"
> +#include "util/cgroup.h"
>  #include "util/config.h"
>  #include "util/color.h"
>  #include "util/dso.h"
> @@ -1558,6 +1559,8 @@ int cmd_top(int argc, const char **argv)
>         OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
>         OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
>                         "number of thread to run event synthesize"),
> +       OPT_CALLBACK('G', "cgroup", &top.evlist, "name",
> +                    "monitor event in cgroup name only", parse_cgroups),
>         OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>                     "Record namespaces events"),
>         OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
> @@ -1646,6 +1649,11 @@ int cmd_top(int argc, const char **argv)
>                 goto out_delete_evlist;
>         }
>
> +       if (nr_cgroups > 0 && opts->record_cgroup) {
> +               pr_err("--cgroup and --all-cgroups cannot be used together\n");
> +               goto out_delete_evlist;
> +       }
> +
>         if (opts->branch_stack && callchain_param.enabled)
>                 symbol_conf.show_branchflag_count = true;
>
> --
> 2.32.0.272.g935e593368-goog
>
