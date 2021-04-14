Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC7535F922
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352783AbhDNQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:42:11 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35656 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhDNQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:42:08 -0400
Received: by mail-lj1-f180.google.com with SMTP id a1so24013951ljp.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzKRJH6t8hqM0DdakAY6Aw7V8M89CnstZWV3CfDX2rY=;
        b=Il/5ovbn/ZQ6tM0lOQzPLZcVho8J1nMWHrCmBcR01ZcqKS3miDR7LBFObfi38y11DN
         beJiKVM01MOawGUu9XbJY3U7xB2NwqcBhlDXhS2OhmdKVXucGQo02x7A7n7dBq15M5jS
         NAvEQoOWH7np6XDegoIGCnYGKlDxkruCVUMln7ZtqQjBn55XbGMm7t4f+G/0CuVpVL7K
         F/QkZ4Qm+hjExBdUZaAjhVOekOySRJfmKTVhSJAgvJ8yARZXp7SKxSBIoQ+C5T2ro0ql
         wQm/yye1IA868zoS30H3jSjPRc6om5C2y3Mv3gED/OslGNRW5Vru3WQQH5+p3nLJOYoz
         jopg==
X-Gm-Message-State: AOAM5327UDVzFFDh0zdb5rAq00XnAfYPD1O0FHaC4d7ga1Z9jr4BrZW5
        /rY3JMZPIT37zith8fHo0Uwy0pMPk9flGoux8w9ft/EbaPM=
X-Google-Smtp-Source: ABdhPJxnMhjijjS4CU7p9zdnA1c5U9tshmTlvTHsXNDvwIrVIm+vXRg9oKRD4+UYD/3ZbEkoEXHDnVbpmpbnqYve4Sk=
X-Received: by 2002:a05:651c:312:: with SMTP id a18mr13788028ljp.52.1618418506247;
 Wed, 14 Apr 2021 09:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155412.3697605-1-robh@kernel.org> <20210414155412.3697605-2-robh@kernel.org>
In-Reply-To: <20210414155412.3697605-2-robh@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Apr 2021 01:41:35 +0900
Message-ID: <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> +{
> +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> +               return NULL;

I think you should check the cpu and the thread is in
a valid range.  Currently xyarray__entry() simply accesses
the content without checking the boundaries.

Thanks,
Namhyung


> +
> +       return MMAP(evsel, cpu, thread)->base;
> +}
> +
>  int perf_evsel__read_size(struct perf_evsel *evsel)
>  {
>         u64 read_format = evsel->attr.read_format;
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 1ffd083b235e..1c067d088bc6 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -41,6 +41,7 @@ struct perf_evsel {
>         struct perf_cpu_map     *own_cpus;
>         struct perf_thread_map  *threads;
>         struct xyarray          *fd;
> +       struct xyarray          *mmap;
>         struct xyarray          *sample_id;
>         u64                     *id;
>         u32                      ids;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index c82ec39a4ad0..60eae25076d3 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -27,6 +27,9 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
>                                  struct perf_thread_map *threads);
>  LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
>  LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> +LIBPERF_API void perf_evsel__munmap(struct perf_evsel *evsel);
> +LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
>  LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                                  struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 7be1af8a546c..c0c7ceb11060 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -23,6 +23,9 @@ LIBPERF_0.0.1 {
>                 perf_evsel__disable;
>                 perf_evsel__open;
>                 perf_evsel__close;
> +               perf_evsel__mmap;
> +               perf_evsel__munmap;
> +               perf_evsel__mmap_base;
>                 perf_evsel__read;
>                 perf_evsel__cpus;
>                 perf_evsel__threads;
> --
> 2.27.0
