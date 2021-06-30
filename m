Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0B3B7D76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhF3GiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:38:00 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38678 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhF3Gh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:37:58 -0400
Received: by mail-lf1-f45.google.com with SMTP id w19so3055922lfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/tLGN3hRZj0zANfVL6Q277rdmp7F9TE5YlLbVXnOt4=;
        b=DPFPhVcoce7xQhvsFqUDq/krO2kPrlT1HogtgckyFvGEjx+NXa8KQCjnyycNLxgbvO
         MVKmr3nS/jPc6X6MUcDxY4wIgV0BM4zNfgcBPgMA3Z5fCSz7Lk9rJJkr4XbKmIneCVdL
         M1+FTBc039L5VjzkVVlrlmYSylDxFLzkDu/oVzQvO6NBt9yTGL5d+LBUf5oyJB9mKFc5
         7iAuYg9vRma+yWWDB0ngu4uuZ7FMQ316vMRZg8fVut5YME1idgmAes/oKR8urRYQjIzL
         LyRuajOzVwMKkfGDgkqtrzu5+M10hIN6/swK5MII86oA6s6klVVMWfEdHyXFRWOz8Rmp
         xRrA==
X-Gm-Message-State: AOAM533UBl5kNM82cEMFjxTJzQKgzTZBiGFHg4f4seHrHl0ttOcpZHz3
        Y4ZAR+M4TBN8m3UDbJoiXaLf35StsSSltvNz4LI=
X-Google-Smtp-Source: ABdhPJw3/8y5ByRxr2zDzj1BO0+/VKGk9doSoT+EA1HcHznuL9vKzdPVhzx5ogdAblvdfTyb435FARtrsF0VUtMWfbo=
X-Received: by 2002:a19:4916:: with SMTP id w22mr27126889lfa.374.1625034928338;
 Tue, 29 Jun 2021 23:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-3-namhyung@kernel.org>
 <CAP-5=fW-0OGDiDnij982xnpqWtimEEWo_qH10y74rTkVkT5p8A@mail.gmail.com>
In-Reply-To: <CAP-5=fW-0OGDiDnij982xnpqWtimEEWo_qH10y74rTkVkT5p8A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Jun 2021 23:35:17 -0700
Message-ID: <CAM9d7cj5EUoDuanLXo+PGqUyaHmvFsR-AgjbtGgaj0SiWzaWew@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf tools: Add cgroup_is_v2() helper
To:     Ian Rogers <irogers@google.com>
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

Hi Ian,

On Tue, Jun 29, 2021 at 8:51 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jun 25, 2021 at 12:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The cgroup_is_v2() is to check if the given subsystem is mounted on
> > cgroup v2 or not.  It'll be used by BPF cgroup code later.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/cgroup.c | 19 +++++++++++++++++++
> >  tools/perf/util/cgroup.h |  2 ++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index ef18c988c681..e819a4f30fc2 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/zalloc.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > +#include <sys/statfs.h>
> >  #include <fcntl.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -70,6 +71,24 @@ int read_cgroup_id(struct cgroup *cgrp)
> >  }
> >  #endif  /* HAVE_FILE_HANDLE */
> >
> > +#ifndef CGROUP2_SUPER_MAGIC
> > +#define CGROUP2_SUPER_MAGIC  0x63677270
> > +#endif
> > +
> > +int cgroup_is_v2(const char *subsys)
> > +{
> > +       char mnt[PATH_MAX + 1];
> > +       struct statfs stbuf;
> > +
> > +       if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, subsys))
> > +               return -1;
> > +
> > +       if (statfs(mnt, &stbuf) < 0)
> > +               return -1;
> > +
> > +       return (stbuf.f_type == CGROUP2_SUPER_MAGIC);
> > +}
> > +
> >  static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
> >  {
> >         struct evsel *counter;
> > diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> > index 707adbe25123..1549ec2fd348 100644
> > --- a/tools/perf/util/cgroup.h
> > +++ b/tools/perf/util/cgroup.h
> > @@ -47,4 +47,6 @@ int read_cgroup_id(struct cgroup *cgrp)
> >  }
> >  #endif  /* HAVE_FILE_HANDLE */
> >
> > +int cgroup_is_v2(const char *subsys);
> > +
>
> I think this is okay. It may make sense to have this in
> tools/lib/api/fs/fs.h, for example fs__valid_mount is already checking
> magic numbers. Perhaps we can avoid a statfs call, but it'd need some
> reorganization of the fs.h code.
>
> Acked-by: Ian Rogers <irogers@google.com>

Thanks for your review!

Actually I'm ok with moving it to tools/lib.  Will do it in the next spin,
if it needs one. :)

Thanks,
Namhyung
