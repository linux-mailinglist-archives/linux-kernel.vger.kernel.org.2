Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B730A0EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBAEoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:44:32 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:34001 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhBAEmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:42:07 -0500
Received: by mail-qk1-f169.google.com with SMTP id t63so15115381qkc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+YEN93+8zwInaaUPVKtqI7KfgGxkBg1CPzl5suJ2EA=;
        b=amUNfVO54NcWasbQ39dd9bZiRG6EGyaIrreNufmrA2nPJUawScoP8mXn953lfahtqf
         yzA38WjqzB4dMXrekFDIvKWTHKwCPQqXWJBv1PKGFjaw5swp4c9WB3zvirThW7EdYNez
         1WIiA5EikgyTU7Ixyx/AFgBeY6ww6hw2AhlNnmm0dGsy68TIel4I7WVqPS8kmPG9+UqF
         NQW4TAkuvsBZhmBLwdh7ojcllqOXDpvfXecsYjyZZgtsAkIXJ1A7PcBWMqHQiAiDhdDt
         60tE7W+Tja1/9o/vkiH2Tp5V4DmCDNU7jy5e5SiFIBjVBiLrPWLdyjUr7OHHMsbEldg3
         OASA==
X-Gm-Message-State: AOAM531eIpPmfBpqsQPzcRZAjVijHO8B5S7ltOboNnkY2fuSOwseqe36
        EXQbNjCqhSArC6fXBE8tnbX/xmExRJSGBgXqgFw=
X-Google-Smtp-Source: ABdhPJyAhqS4FUekL2IQcofHQFBKjd8/3N4aUIzGeNpPBSgkYGUMttGdy2s0J9cA1m1oMsmYZvcWtRmSUsVYqRYAOsU=
X-Received: by 2002:a37:648e:: with SMTP id y136mr14571461qkb.148.1612154484239;
 Sun, 31 Jan 2021 20:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20210129054901.1705483-1-namhyung@kernel.org> <20210129054901.1705483-2-namhyung@kernel.org>
 <YBc2jfTDcBjcL5kN@krava>
In-Reply-To: <YBc2jfTDcBjcL5kN@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Feb 2021 13:41:13 +0900
Message-ID: <CAM9d7ch2JpG+yOTYXDyKpHLeJVWOVwOKdsZEiJ+YMjGbTqi7VA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Feb 1, 2021 at 8:00 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:48:59PM +0900, Namhyung Kim wrote:
> > To save memory usage, it needs to reduce number of entries in the proc
> > filesystem.  It's using /proc/<PID>/task directory to traverse threads
> > in the process and then kernel creates /proc/<PID>/task/<TID> entries.
> >
> > After that it checks the thread info using the /proc/<TID>/status file
> > rather than /proc/<PID>/task/<TID>/status.  As far as I can see, they
> > are the same and contain all the info we need.
> >
> > Using the latter eliminates the unnecessary /proc/<TID> entry.  This
> > can be useful especially a large number of threads are used in the
> > system.  In my experiment around 1KB of memory on average was saved
> > for each thread (which is not a thread group leader).
> >
> > To do this, pass both pid and tid to perf_event_prepare_comm() if it
> > knows them.  In case it doesn't know, passing 0 as pid will do the old
> > way.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 3a898520f05c..800522591dde 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -69,7 +69,7 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
> >   * Assumes that the first 4095 bytes of /proc/pid/stat contains
> >   * the comm, tgid and ppid.
> >   */
> > -static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> > +static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
> >                                   pid_t *tgid, pid_t *ppid)
> >  {
> >       char bf[4096];
> > @@ -81,7 +81,10 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> >       *tgid = -1;
> >       *ppid = -1;
> >
> > -     snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
> > +     if (pid)
> > +             snprintf(bf, sizeof(bf), "/proc/%d/task/%d/status", pid, tid);
> > +     else
> > +             snprintf(bf, sizeof(bf), "/proc/%d/status", tid);
> >
> >       fd = open(bf, O_RDONLY);
> >       if (fd < 0) {
> > @@ -93,7 +96,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> >       close(fd);
> >       if (n <= 0) {
> >               pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
> > -                        pid);
> > +                        tid);
> >               return -1;
> >       }
> >       bf[n] = '\0';
> > @@ -116,27 +119,32 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
> >               memcpy(comm, name, size);
> >               comm[size] = '\0';
> >       } else {
> > -             pr_debug("Name: string not found for pid %d\n", pid);
> > +             pr_debug("Name: string not found for pid %d\n", tid);
> >       }
> >
> >       if (tgids) {
> >               tgids += 5;  /* strlen("Tgid:") */
> >               *tgid = atoi(tgids);
> > +
> > +             if (pid && pid != *tgid) {
> > +                     pr_debug("Tgid: not match to given pid: %d vs %d\n",
> > +                              pid, *tgid);
>
> hm, could this actually happen in our case?

Probably not.  I'll remove it in the next version if you want.

Thanks,
Namhyung
