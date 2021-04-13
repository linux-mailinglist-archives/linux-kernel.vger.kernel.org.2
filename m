Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E406E35D49E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhDMBCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:02:44 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36823 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhDMBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:02:44 -0400
Received: by mail-lj1-f172.google.com with SMTP id o16so17530684ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4dp7xOMc4c2heF4t/jIIUIdGVbACrCiWh88O24hLWE=;
        b=VsTlQU/Rymt3m11uFj5iwuyt0/qtQVvLKwvrXVzOLEpHW8wcoQevS1eCqo4EOL/IQa
         k4vh2ljusRB15ckr6eUs9725mZvsqf8AY2uNzqP83AL0S7YafSCb5AQAbbrcgvaR6wKp
         CGrtPUslCqJH+HPvT3cpR1TVnAY7CQ3crGqb5iEGcbATAoMqcc3Xd8LoSu2tBJ6SQwka
         dQ5qpmsdeCRGgw9bnbV4TrmQWntr03tPawLEE4klbn3t8DMWdBt8aEUOKc3U1Zo5n29N
         rKmepp0wdY8gIBTvqR7ZeHB5c7P2gT+G9bdyr2dIvOxIWJbcczrIKbwzf//4eCF+tzIY
         7wAw==
X-Gm-Message-State: AOAM531doZQMV7X1A9DrJGHG/18/EtHMKK9EMzGoowckUGhlq3rNivjW
        KuQxzMKaAbyRYVJO5YVCRpqUOKUMWgK8ZeaQJRk=
X-Google-Smtp-Source: ABdhPJw5cM4+2rH+cERUmqi8u65g+YLqMA3XU8S1UmONjjTAu6XnqgIkbXm9BWznC+6xtK/guEUQEeaa7lcPeUjmVJI=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr18847727ljk.233.1618275743085;
 Mon, 12 Apr 2021 18:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com> <ad2c112c-d6ae-c7cf-4fa7-a07279df4388@linux.intel.com>
In-Reply-To: <ad2c112c-d6ae-c7cf-4fa7-a07279df4388@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Apr 2021 10:02:11 +0900
Message-ID: <CAM9d7chAgocCfA-m8YzeYtb31N53OPiqvzTU9kstts=c2EDCBg@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] perf record: introduce --threads=<spec> command
 line option
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 6, 2021 at 5:49 PM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
>
> Provide --threads option in perf record command line interface.
> The option can have a value in the form of masks that specify
> cpus to be monitored with data streaming threads and its layout
> in system topology. The masks can be filtered using cpu mask
> provided via -C option.
>
> The specification value can be user defined list of masks. Masks
> separated by colon define cpus to be monitored by one thread and
> affinity mask of that thread is separated by slash. For example:
> <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads
> with corresponding assigned cpus to be monitored.
>
> The specification value can be a string e.g. "cpu", "core" or
> "socket" meaning creation of data streaming thread for every
> cpu or core or socket to monitor distinct cpus or cpus grouped
> by core or socket.
>
> The option provided with no or empty value defaults to per-cpu
> parallel threads layout creating data streaming thread for every
> cpu being monitored.
>
> Feature design and implementation are based on prototypes [1], [2].
>
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
[SNIP]
> +static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
> +                                         char **maps_spec, char **affinity_spec, u32 nr_spec)
> +{
> +       u32 s;
> +       int ret, nr_threads = 0;
> +       struct mmap_cpu_mask cpus_mask;
> +       struct thread_mask thread_mask, full_mask;
> +
> +       ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
> +       if (ret)
> +               return ret;
> +       record__mmap_cpu_mask_init(&cpus_mask, cpus);
> +       ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +       if (ret)
> +               goto out_free_cpu_mask;
> +       ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
> +       if (ret)
> +               goto out_free_thread_mask;
> +       record__thread_mask_clear(&full_mask);
> +
> +       for (s = 0; s < nr_spec; s++) {
> +               record__thread_mask_clear(&thread_mask);
> +
> +               record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
> +               record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
> +
> +               if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
> +                               cpus_mask.bits, thread_mask.maps.nbits) ||
> +                   !bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
> +                               cpus_mask.bits, thread_mask.affinity.nbits))
> +                       continue;
> +
> +               ret = record__thread_mask_intersects(&thread_mask, &full_mask);
> +               if (ret)
> +                       return ret;

I think you should free other masks.

> +               record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
> +
> +               rec->thread_masks = realloc(rec->thread_masks,
> +                                           (nr_threads + 1) * sizeof(struct thread_mask));
> +               if (!rec->thread_masks) {
> +                       pr_err("Failed to allocate thread masks\n");
> +                       ret = -ENOMEM;
> +                       goto out_free_full_mask;

But this will leak rec->thread_masks as it's overwritten.


> +               }
> +               rec->thread_masks[nr_threads] = thread_mask;
> +               pr_debug("thread_masks[%d]: addr=", nr_threads);
> +               mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].maps, "maps");
> +               pr_debug("thread_masks[%d]: addr=", nr_threads);
> +               mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].affinity, "affinity");
> +               nr_threads++;
> +               ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +               if (ret)
> +                       return ret;

Ditto, use goto.

> +       }
> +
> +       rec->nr_threads = nr_threads;
> +       pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
> +
> +out_free_full_mask:
> +       record__thread_mask_free(&full_mask);
> +out_free_thread_mask:
> +       record__thread_mask_free(&thread_mask);
> +out_free_cpu_mask:
> +       record__mmap_cpu_mask_free(&cpus_mask);
> +
> +       return 0;
> +}

[SNIP]
> +
> +static int record__init_thread_user_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +       int t, ret;
> +       u32 s, nr_spec = 0;
> +       char **maps_spec = NULL, **affinity_spec = NULL;
> +       char *spec, *spec_ptr, *user_spec, *mask, *mask_ptr;
> +
> +       for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ; t++, user_spec = NULL) {
> +               spec = strtok_r(user_spec, ":", &spec_ptr);
> +               if (spec == NULL)
> +                       break;
> +               pr_debug(" spec[%d]: %s\n", t, spec);
> +               mask = strtok_r(spec, "/", &mask_ptr);
> +               if (mask == NULL)
> +                       break;
> +               pr_debug("  maps mask: %s\n", mask);
> +               maps_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char *));
> +               if (!maps_spec) {
> +                       pr_err("Failed to realloc maps_spec\n");
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;

It'd crash as maps_spec is NULL now.

> +               }
> +               maps_spec[nr_spec] = strdup(mask);

You'd better check the return value.

> +               mask = strtok_r(NULL, "/", &mask_ptr);
> +               if (mask == NULL)
> +                       break;
> +               pr_debug("  affinity mask: %s\n", mask);
> +               affinity_spec = realloc(affinity_spec, (nr_spec + 1) * sizeof(char *));
> +               if (!maps_spec) {

s/maps/affinity/ and it has the same problem.

> +                       pr_err("Failed to realloc affinity_spec\n");
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;
> +               }
> +               affinity_spec[nr_spec] = strdup(mask);

Check the return value.

Thanks,
Namhyung

> +               nr_spec++;
> +       }
> +
> +       ret = record__init_thread_masks_spec(rec, cpus, maps_spec, affinity_spec, nr_spec);
> +
> +out_free_all_specs:
> +       for (s = 0; s < nr_spec; s++) {
> +               free(maps_spec[s]);
> +               free(affinity_spec[s]);
> +       }
> +       free(affinity_spec);
> +       free(maps_spec);
> +
> +       return ret;
> +}
> +
