Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD5311F8D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 20:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBFTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 14:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhBFTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 14:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612638263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tftcB8zgf2/xmjfJ1CJFmiWfYkDrWtD8sD2otzgv8BI=;
        b=Cwu5DlxmtcEo/g8EGYcUdMmreO/7fB8BCB+MtBMkeK5cQqmtnuZpfGfwj9g0H0hk/cWKRD
        QFrNxJ6kR1Xr8fR+1TS3UzJ5Gib+vRK+wcMNcRI6xCnOv9j5YD+wLePflaPz+UPddfazAI
        64iXcJsizrxu0YXB2eYpYWUCDwT0QlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-KIo5FMsUNYKqAEyupMsCQA-1; Sat, 06 Feb 2021 14:04:21 -0500
X-MC-Unique: KIo5FMsUNYKqAEyupMsCQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5DF280196C;
        Sat,  6 Feb 2021 19:04:19 +0000 (UTC)
Received: from krava (unknown [10.40.192.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D49A6F7EA;
        Sat,  6 Feb 2021 19:04:16 +0000 (UTC)
Date:   Sat, 6 Feb 2021 20:04:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
Message-ID: <YB7oMB4m1Re9u1VY@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org>
 <CAM9d7ciwL-Kez-dgX=R154b10+APKNR+poo2Tq93JYF5rxV_GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciwL-Kez-dgX=R154b10+APKNR+poo2Tq93JYF5rxV_GA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:30:10PM +0900, Namhyung Kim wrote:
> On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add support to create server socket that listens for client
> > commands and process them.
> >
> > This patch adds only the core support, all commands using
> > this functionality are coming in following patches.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 8d0ac44ec808..756d60616d7d 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <subcmd/parse-options.h>
> > +#include <api/fd/array.h>
> >  #include <linux/limits.h>
> >  #include <string.h>
> >  #include <signal.h>
> > @@ -7,6 +8,10 @@
> >  #include <stdio.h>
> >  #include <unistd.h>
> >  #include <errno.h>
> > +#include <sys/types.h>
> > +#include <sys/socket.h>
> > +#include <sys/un.h>
> > +#include <poll.h>
> >  #include "builtin.h"
> >  #include "perf.h"
> >  #include "debug.h"
> > @@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
> >         done = true;
> >  }
> >
> > +static int setup_server_socket(struct daemon *daemon)
> > +{
> > +       struct sockaddr_un addr;
> > +       char path[100];
> > +       int fd;
> > +
> > +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> > +       if (fd < 0) {
> > +               fprintf(stderr, "socket: %s\n", strerror(errno));
> > +               return -1;
> > +       }
> > +
> > +       fcntl(fd, F_SETFD, FD_CLOEXEC);
> > +
> > +       scnprintf(path, PATH_MAX, "%s/control", daemon->base);
> 
> I couldn't find where the default value of daemon->base is set.
> Also 100 bytes seem not enough for the path name.

108 bytes is the limit of the unix socket path,
I'm adding more checks on the provided base,
so we display some reasonable error 

thanks,
jirka

