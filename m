Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5B3B75E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhF2Pxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhF2Pxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:53:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72206C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:51:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so2150731wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTv8Tc7EKr0PzcUpaPHiI9onaP3uWQq/Vd6rHddjRjA=;
        b=RpQi7APS9B63UyQUVEGrgotj4uE3OjXtjczk1Upg5oxT7JKfJMno+mHnV+MalqI3Qo
         GYXTFCyoIrrMFemKL9Of3cMnUD7vSoS/jOxxzgrzHUZ9wNRvC2KpPk8r8LUJHNyXiXJ2
         S3uws8//rDJ37Pq84hbZUQGdJyBuTZ0SPU/z4lyzyhsYk3Sb7JWQH0+uhFxoBLNkbbTf
         NqDfBYnDxCNQGLJ8BqcY77lEzJesKtF5Pkxb4ZlqgABxuv++R0KEDgAz5/4wplsAS8Yr
         AvDzpqUs+L/XdEDHDWnCJvp13ygyv3+czc6Vn4T7r1ogehNgQJDBSY1grOFw5aaT3BpW
         H/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTv8Tc7EKr0PzcUpaPHiI9onaP3uWQq/Vd6rHddjRjA=;
        b=e5dRkODjnvPZVQxj0Y6KnRhFsSB1vw4lSf6UyqX/7b2avKxCHERircJ2vChjQwjxzs
         7F8LHFRF67s2OX0NkdanZRf27f5HDHt2cIgTAVdYb2x0KH4GgbDKn0WQleYNSF/mkzoR
         QLhedm4D6Isih/RQqsxel060x66fe4NAwwRhf/AsRMLDaTOghztqs8CktuvcRULnufw7
         4iXhBblNicwGvUwe1L9y0WjKEHpm0EKieVA+LDDeRLZwxlsXRYA+gCd+x9YLkHnR4o41
         9Gzmr/QzluHYT6qAyQHsDjgzchcJJlBwXFXV0Md2MfAPqo7v+TP6EsYWQbuCxCh7Orda
         CrwA==
X-Gm-Message-State: AOAM5336hnrbzEuvUiw0+XjJ8iq5tzr2uBoo+rtWnE9c0TDfdFZ/hyfB
        ENHct+xuYSVplABbM6s52TehRTYvdxmlIHq4OUTecw==
X-Google-Smtp-Source: ABdhPJw8XUZzoWPvrqaUFAXIvzoEdZQ2ZXFbuXzyHrBdIsWVcJzLAxRh2/KSxO31vl7wC9wtAPJ+xkBsZZU06Qmeww4=
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr33659683wmp.77.1624981877946;
 Tue, 29 Jun 2021 08:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-3-namhyung@kernel.org>
In-Reply-To: <20210625071826.608504-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Jun 2021 08:51:05 -0700
Message-ID: <CAP-5=fW-0OGDiDnij982xnpqWtimEEWo_qH10y74rTkVkT5p8A@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf tools: Add cgroup_is_v2() helper
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The cgroup_is_v2() is to check if the given subsystem is mounted on
> cgroup v2 or not.  It'll be used by BPF cgroup code later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/cgroup.c | 19 +++++++++++++++++++
>  tools/perf/util/cgroup.h |  2 ++
>  2 files changed, 21 insertions(+)
>
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index ef18c988c681..e819a4f30fc2 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -9,6 +9,7 @@
>  #include <linux/zalloc.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/statfs.h>
>  #include <fcntl.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -70,6 +71,24 @@ int read_cgroup_id(struct cgroup *cgrp)
>  }
>  #endif  /* HAVE_FILE_HANDLE */
>
> +#ifndef CGROUP2_SUPER_MAGIC
> +#define CGROUP2_SUPER_MAGIC  0x63677270
> +#endif
> +
> +int cgroup_is_v2(const char *subsys)
> +{
> +       char mnt[PATH_MAX + 1];
> +       struct statfs stbuf;
> +
> +       if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, subsys))
> +               return -1;
> +
> +       if (statfs(mnt, &stbuf) < 0)
> +               return -1;
> +
> +       return (stbuf.f_type == CGROUP2_SUPER_MAGIC);
> +}
> +
>  static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
>  {
>         struct evsel *counter;
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index 707adbe25123..1549ec2fd348 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -47,4 +47,6 @@ int read_cgroup_id(struct cgroup *cgrp)
>  }
>  #endif  /* HAVE_FILE_HANDLE */
>
> +int cgroup_is_v2(const char *subsys);
> +

I think this is okay. It may make sense to have this in
tools/lib/api/fs/fs.h, for example fs__valid_mount is already checking
magic numbers. Perhaps we can avoid a statfs call, but it'd need some
reorganization of the fs.h code.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  #endif /* __CGROUP_H__ */
> --
> 2.32.0.93.g670b81a890-goog
>
