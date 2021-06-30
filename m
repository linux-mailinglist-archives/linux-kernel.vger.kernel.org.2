Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921483B88AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhF3Sqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232881AbhF3Sqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B9B61420;
        Wed, 30 Jun 2021 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078640;
        bh=uhn0pTph7tTzanA0zcqDt9FF7/bIWTMzvTZLuD+tYBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ta2Mi13y4LJfWZIOSCCx1YwJFczlL7SbRl0AlrXar+2yNlLKNPY0ftsikUNdNiKrj
         IzwybM0G25WYmhFUQDkk348O78W1cbjeV4U5Yodhxscz5kWNCO3EbR+JrW2DKEYqk9
         0S8p0ADJvlAzt4H0tSvvRFLdr2fuE/rm/9IAbXPxKeW8lvq2ZcvS2BZFNotvfTTQuE
         tBOU/doOMe7KuctjfnLRdOuQTxt2FWh2D9stH/9wfUW0vT0t5CM2OjcRoy2KUj/v6r
         OeQd2+B1UMc0qtLWRHZx3dyW+G/Gfhvi5W85WJlMfOl2+wgx32D+8orqmKkA3lKYuX
         K8ERqD5OHvN8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2496640B1A; Wed, 30 Jun 2021 15:43:58 -0300 (-03)
Date:   Wed, 30 Jun 2021 15:43:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 2/4] perf tools: Add cgroup_is_v2() helper
Message-ID: <YNy7bjYMOZlvGWT4@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-3-namhyung@kernel.org>
 <CAP-5=fW-0OGDiDnij982xnpqWtimEEWo_qH10y74rTkVkT5p8A@mail.gmail.com>
 <CAM9d7cj5EUoDuanLXo+PGqUyaHmvFsR-AgjbtGgaj0SiWzaWew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj5EUoDuanLXo+PGqUyaHmvFsR-AgjbtGgaj0SiWzaWew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 29, 2021 at 11:35:17PM -0700, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Tue, Jun 29, 2021 at 8:51 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Jun 25, 2021 at 12:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The cgroup_is_v2() is to check if the given subsystem is mounted on
> > > cgroup v2 or not.  It'll be used by BPF cgroup code later.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/cgroup.c | 19 +++++++++++++++++++
> > >  tools/perf/util/cgroup.h |  2 ++
> > >  2 files changed, 21 insertions(+)
> > >
> > > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > > index ef18c988c681..e819a4f30fc2 100644
> > > --- a/tools/perf/util/cgroup.c
> > > +++ b/tools/perf/util/cgroup.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/zalloc.h>
> > >  #include <sys/types.h>
> > >  #include <sys/stat.h>
> > > +#include <sys/statfs.h>
> > >  #include <fcntl.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > > @@ -70,6 +71,24 @@ int read_cgroup_id(struct cgroup *cgrp)
> > >  }
> > >  #endif  /* HAVE_FILE_HANDLE */
> > >
> > > +#ifndef CGROUP2_SUPER_MAGIC
> > > +#define CGROUP2_SUPER_MAGIC  0x63677270
> > > +#endif
> > > +
> > > +int cgroup_is_v2(const char *subsys)
> > > +{
> > > +       char mnt[PATH_MAX + 1];
> > > +       struct statfs stbuf;
> > > +
> > > +       if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, subsys))
> > > +               return -1;
> > > +
> > > +       if (statfs(mnt, &stbuf) < 0)
> > > +               return -1;
> > > +
> > > +       return (stbuf.f_type == CGROUP2_SUPER_MAGIC);
> > > +}
> > > +
> > >  static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
> > >  {
> > >         struct evsel *counter;
> > > diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> > > index 707adbe25123..1549ec2fd348 100644
> > > --- a/tools/perf/util/cgroup.h
> > > +++ b/tools/perf/util/cgroup.h
> > > @@ -47,4 +47,6 @@ int read_cgroup_id(struct cgroup *cgrp)
> > >  }
> > >  #endif  /* HAVE_FILE_HANDLE */
> > >
> > > +int cgroup_is_v2(const char *subsys);
> > > +
> >
> > I think this is okay. It may make sense to have this in
> > tools/lib/api/fs/fs.h, for example fs__valid_mount is already checking
> > magic numbers. Perhaps we can avoid a statfs call, but it'd need some
> > reorganization of the fs.h code.
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks for your review!
> 
> Actually I'm ok with moving it to tools/lib.  Will do it in the next spin,
> if it needs one. :)

O think I'll take v4, we can improve this in followup work.

- Arnaldo
