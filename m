Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256403C1EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhGIFlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 01:41:14 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40843 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhGIFlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:41:13 -0400
Received: by mail-lf1-f46.google.com with SMTP id q18so20950862lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 22:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCSMbHmqdsIO0bSM7bjrOKO1HQ1oVbqYGlUHkRMGhls=;
        b=Ig43qfGjviDSz7t+sKumpTsg6ST+Tu3H/lhAydhX1rPS2BFiPKXLPFYzxF7yEK7g7b
         GWxzYvxCcv0SEVa/ivhbH0HeCMVr99ucz9L0pwzUJ7mJQF+Zr9Jwt2DSRyeEu83oPPjS
         C0QsE1eMynomQfuEA5haEnttfoMlAZHLBawotbX1Y68grRTSXS2ZT9hJh04GLwOny2qh
         VKDYitnMQFMDtuiulZ/g0w4jfOeueVSchBBCnyuQpMtTnbuHYPJEUHXO1jZQVeNzXaW+
         gdU0Tb5yOrLDgRFQMjmTgPCzSvB6y79DWG9UmOcfR8k8T1sADx9xo/L8uFq7tDrslnw1
         N1YQ==
X-Gm-Message-State: AOAM531MYAiSMig8Qg4A9P291WbNCd+TeS02DlShVWX0IlG+uaGDll04
        dDZmiPScJ6alD5sVUfQoR+GbMMbuYZlchVKGHMU=
X-Google-Smtp-Source: ABdhPJwfxbIwlYzln0u9631C5/t6AL5QYvmecljK84V8bYKBljM7gU50GF/zhQsGDFieQafRGkDM2+sJkHXSC4ldFCw=
X-Received: by 2002:a05:6512:3744:: with SMTP id a4mr26681125lfs.112.1625809108602;
 Thu, 08 Jul 2021 22:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com> <e30f91a95e332f5dfc9ae87c5617b6102da6a3d9.1625227739.git.alexey.v.bayduraev@linux.intel.com>
In-Reply-To: <e30f91a95e332f5dfc9ae87c5617b6102da6a3d9.1625227739.git.alexey.v.bayduraev@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jul 2021 22:38:17 -0700
Message-ID: <CAM9d7cg2Rd_8PUwreNa=1SiOWewCpZVz9kZ7tvKDWCSaLtorpg@mail.gmail.com>
Subject: Re: [PATCH v9 09/24] perf record: Introduce bytes written stats to
 support --max-size option
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 2, 2021 at 5:33 AM Alexey Bayduraev
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Adding a function to calculate the total amount of data written
> and using it to support the --max-size option.
>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c | 30 +++++++++++++++++++++++++++---
>  tools/perf/util/mmap.h      |  1 +
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ac9bc1bbdff4..6419b7974435 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -186,10 +186,28 @@ static bool switch_output_time(struct record *rec)
>                trigger_is_ready(&switch_output_trigger);
>  }
>
> +static u64 record__bytes_written(struct record *rec)
> +{
> +       int t, tm;
> +       struct record_thread *thread_data = rec->thread_data;
> +       u64 bytes_written = rec->bytes_written;
> +
> +       for (t = 0; t < rec->nr_threads; t++) {
> +               for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
> +                       if (thread_data[t].maps)
> +                               bytes_written += thread_data[t].maps[tm]->bytes_written;
> +                       if (thread_data[t].overwrite_maps)
> +                               bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
> +               }
> +       }
> +
> +       return bytes_written;
> +}
> +
>  static bool record__output_max_size_exceeded(struct record *rec)
>  {
>         return rec->output_max_size &&
> -              (rec->bytes_written >= rec->output_max_size);
> +              (record__bytes_written(rec) >= rec->output_max_size);
>  }
>
>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> @@ -205,15 +223,21 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>                 return -1;
>         }
>
> -       rec->bytes_written += size;
> +       if (map && map->file)
> +               map->bytes_written += size;
> +       else
> +               rec->bytes_written += size;
>
>         if (record__output_max_size_exceeded(rec) && !done) {
>                 fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>                                 " stopping session ]\n",
> -                               rec->bytes_written >> 10);
> +                               record__bytes_written(rec) >> 10);
>                 done = 1;
>         }
>
> +       if (map && map->file)
> +               return 0;
> +
>         if (switch_output_size(rec))
>                 trigger_hit(&switch_output_trigger);
>
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index c4aed6e89549..67d41003d82e 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -46,6 +46,7 @@ struct mmap {
>         int             comp_level;
>         struct perf_data_file *file;
>         struct zstd_data      zstd_data;
> +       u64                   bytes_written;
>  };
>
>  struct mmap_params {
> --
> 2.19.0
>
