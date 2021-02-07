Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBE3120B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 02:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBGBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 20:37:42 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:32925 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGBhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:37:37 -0500
Received: by mail-lj1-f182.google.com with SMTP id a25so12435424ljn.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 17:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxipTUAce9qB/6VR3y/HbUzBfM0MwI5RwtE1w0thUzg=;
        b=OrXoydRgATFh7b6xm9TVT+P7PMCGIuRnG580PBwBdQCW4o+b+QOlyhzNZ4kAbYng2m
         3N0hEKSObtIH5axbmfFqqYHEg/MRVEVK1k4Q8+NhT5Ox08Tpf9G2qoAk0QquFwMUyuCi
         pMzB9htPb85rNzYvr5I4VdgMU/q6dak3b9MQAxmSkCC1jCtsQFauKHAW3kJwsYV4VWMB
         LS0mQ7K7gf00iBJhSkvs3zjF8YdMjEcnxGSsoOFaZI9rPFj/ZFHgt4PuQE8bNPx5oye6
         d0Crd+QtJxguCmgcHZar1X5pQzTR1jLHCsNICLAtNLg+uzkqyN6El9pkHmTADIq1cD9a
         K/Lg==
X-Gm-Message-State: AOAM531ycyMUujt9LBZIq1dgu60CS3bFpvuB4MA5Xny0J6w0ru5kEVUS
        BuGCbN+HJH2k7LC8s66RzaG9fJyH7Vf5wZ5B/+I=
X-Google-Smtp-Source: ABdhPJyXSELtb4z++1XV+Ti+6zcaIBHytxZSXjFpD2JW8LWeTvZaQ++2wuTKSb2c8WPCfMCtmI74K6Dnqu4keVLoL/8=
X-Received: by 2002:a2e:9007:: with SMTP id h7mr1780560ljg.26.1612661814510;
 Sat, 06 Feb 2021 17:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org> <CAM9d7ciwL-Kez-dgX=R154b10+APKNR+poo2Tq93JYF5rxV_GA@mail.gmail.com>
 <YB7oMB4m1Re9u1VY@krava>
In-Reply-To: <YB7oMB4m1Re9u1VY@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 7 Feb 2021 10:36:43 +0900
Message-ID: <CAM9d7ciKh4jQV4AW5OSkwK9ySofKoZ8OVbt8_-fnJ5cWXZsqFg@mail.gmail.com>
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 4:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Feb 05, 2021 at 08:30:10PM +0900, Namhyung Kim wrote:
> > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Add support to create server socket that listens for client
> > > commands and process them.
> > >
> > > This patch adds only the core support, all commands using
> > > this functionality are coming in following patches.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 100 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > > index 8d0ac44ec808..756d60616d7d 100644
> > > --- a/tools/perf/builtin-daemon.c
> > > +++ b/tools/perf/builtin-daemon.c
> > > @@ -1,5 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <subcmd/parse-options.h>
> > > +#include <api/fd/array.h>
> > >  #include <linux/limits.h>
> > >  #include <string.h>
> > >  #include <signal.h>
> > > @@ -7,6 +8,10 @@
> > >  #include <stdio.h>
> > >  #include <unistd.h>
> > >  #include <errno.h>
> > > +#include <sys/types.h>
> > > +#include <sys/socket.h>
> > > +#include <sys/un.h>
> > > +#include <poll.h>
> > >  #include "builtin.h"
> > >  #include "perf.h"
> > >  #include "debug.h"
> > > @@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
> > >         done = true;
> > >  }
> > >
> > > +static int setup_server_socket(struct daemon *daemon)
> > > +{
> > > +       struct sockaddr_un addr;
> > > +       char path[100];
> > > +       int fd;
> > > +
> > > +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> > > +       if (fd < 0) {
> > > +               fprintf(stderr, "socket: %s\n", strerror(errno));
> > > +               return -1;
> > > +       }
> > > +
> > > +       fcntl(fd, F_SETFD, FD_CLOEXEC);
> > > +
> > > +       scnprintf(path, PATH_MAX, "%s/control", daemon->base);
> >
> > I couldn't find where the default value of daemon->base is set.
> > Also 100 bytes seem not enough for the path name.
>
> 108 bytes is the limit of the unix socket path,
> I'm adding more checks on the provided base,
> so we display some reasonable error

Sgtm.

Thanks,
Namhyung
