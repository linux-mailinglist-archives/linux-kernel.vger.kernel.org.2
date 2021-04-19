Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5536497B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhDSSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:03:18 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38886 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbhDSSDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:15 -0400
Received: by mail-lf1-f54.google.com with SMTP id j18so57418182lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v3RL2HRRpJuCdaVRmmOMXcfyg41x+bcj/HgP2QerTA=;
        b=AX2WdtknQCXVfW/quk5lysafgeSPKsiswlA+i2qZpvZgQuurVxarzklCKoGK7XPCYo
         d0CgSkPO5ukwQrt6OZa0r5H/KY/o4Yw/02UGEKHcZe0VMpAdatMkaaL0A6dNVLFlFekJ
         yBhy7IQZkGfBOCiEKum0LCP7jBa7fDXY/HEN75/PkBOe3wx6+4/jeJPgMHLfimvkjSfz
         S63X35ilsvkrWyEEXaaVWJeVNUe3heE9SxKkwSAU0jQx1tRdz395IBozZiRQVMa2ypDn
         Bcff/7SU1Gms7UVDKL7E3omA2icHC/fsEvSEj7ZoLg6PdmdXmIzn7CnFshjOd9sjjr0n
         pyPA==
X-Gm-Message-State: AOAM532AQd66xltNUVNj868xJTqCnxjW90P6x/IiX2nNe/4sQZOFAa4N
        MLusuVhGnVkq7IW5LYOlWxybHEycxa36Qu1pMnI=
X-Google-Smtp-Source: ABdhPJz8Lf+FzKJ5QDuc0jajm26mBzNVLZRYJwERZKnSNXlXk+NVFDCvpOMzeqrqOXfIJ9DJilWXp20IX13nkWV86vE=
X-Received: by 2002:a05:6512:402:: with SMTP id u2mr9958798lfk.112.1618855364492;
 Mon, 19 Apr 2021 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210210083327.22726-1-namhyung@kernel.org> <20210210083327.22726-3-namhyung@kernel.org>
In-Reply-To: <20210210083327.22726-3-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Apr 2021 03:02:33 +0900
Message-ID: <CAM9d7cgWDNiKBj14TA0Yj_aOhAxzF-xGtstOVRJmQnM6RBDdYg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf tools: Add 'cgroup-switches' software event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Could you please pick this up?  The kernel part is landed in the
tip.git already.

Thanks,
Namhyung

On Wed, Feb 10, 2021 at 5:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It counts how often cgroups are changed actually during the context
> switches.
>
>   # perf stat -a -e context-switches,cgroup-switches -a sleep 1
>
>    Performance counter stats for 'system wide':
>
>               11,267      context-switches
>               10,950      cgroup-switches
>
>          1.015634369 seconds time elapsed
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/include/uapi/linux/perf_event.h | 1 +
>  tools/perf/util/parse-events.c        | 4 ++++
>  tools/perf/util/parse-events.l        | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index b15e3447cd9f..16b9538ad89b 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -112,6 +112,7 @@ enum perf_sw_ids {
>         PERF_COUNT_SW_EMULATION_FAULTS          = 8,
>         PERF_COUNT_SW_DUMMY                     = 9,
>         PERF_COUNT_SW_BPF_OUTPUT                = 10,
> +       PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
>
>         PERF_COUNT_SW_MAX,                      /* non-ABI */
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 42c84adeb2fb..09ff678519f3 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>                 .symbol = "bpf-output",
>                 .alias  = "",
>         },
> +       [PERF_COUNT_SW_CGROUP_SWITCHES] = {
> +               .symbol = "cgroup-switches",
> +               .alias  = "",
> +       },
>  };
>
>  #define __PERF_EVENT_FIELD(config, name) \
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 9db5097317f4..88f203bb6fab 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -347,6 +347,7 @@ emulation-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
>  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
>  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
>  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
> +cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
>
>         /*
>          * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
> --
> 2.30.0.478.g8a0d178c01-goog
>
