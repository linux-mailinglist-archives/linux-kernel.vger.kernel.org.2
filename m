Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47229310A52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBELeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:34:13 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:35186 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhBELbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:31:04 -0500
Received: by mail-lj1-f174.google.com with SMTP id a17so7347296ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ublMmZblhO/5gA9bZNTFro6gynn7H+4IfrYhBFsMl88=;
        b=rSZg5vbws5WtyxfyvZw7wX8lFVW7k0Zymd7HlXurltfVPnFIBREXHk58HUqB9mKScq
         5wYW3j+IPCf2n8S+FVtKNrisCn6GHfzNkdGiWk5tXKUwp0Zz+uHKCNtkRPhvLSuq0eV7
         1RYY5ledNhH+tDHZQiMKO+RRZZ17cvUPf3/ro3j4zUe9SJOcS8FzZhyQEpl0Fd0SU3Ce
         xQ5vq2fJVM2L+4aqOiOCR7+PsHz9o4nl6rP+/mmXUAGYPbusEwhiYkudKbz9KuSl5Efg
         nfsWbkFNkOjXqQFGsOgccGNLZWmD5QJnZbVtinibVMrmdsI7a+1Zwgdd4BcJlgPd7Iep
         7OIQ==
X-Gm-Message-State: AOAM532agMJ+x/HcntnITJx94EMYUByPmdEevp3+J/U+qkeB0x+iBhGY
        A4uw5zuRqrJuyEErJG4QtpeV8axqlZlKFB5AftA=
X-Google-Smtp-Source: ABdhPJwnRBtcggTqph0RePSra2sGcOnJL9P2f9UYpxpR4fzn16OJzvR6e/TNrknR1Wr4rMhypZTP8HdNd6Uznn0Sv/U=
X-Received: by 2002:a2e:9949:: with SMTP id r9mr2264737ljj.393.1612524621893;
 Fri, 05 Feb 2021 03:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-5-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 20:30:10 +0900
Message-ID: <CAM9d7ciwL-Kez-dgX=R154b10+APKNR+poo2Tq93JYF5rxV_GA@mail.gmail.com>
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add support to create server socket that listens for client
> commands and process them.
>
> This patch adds only the core support, all commands using
> this functionality are coming in following patches.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 8d0ac44ec808..756d60616d7d 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <subcmd/parse-options.h>
> +#include <api/fd/array.h>
>  #include <linux/limits.h>
>  #include <string.h>
>  #include <signal.h>
> @@ -7,6 +8,10 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <poll.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> @@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
>         done = true;
>  }
>
> +static int setup_server_socket(struct daemon *daemon)
> +{
> +       struct sockaddr_un addr;
> +       char path[100];
> +       int fd;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +       if (fd < 0) {
> +               fprintf(stderr, "socket: %s\n", strerror(errno));
> +               return -1;
> +       }
> +
> +       fcntl(fd, F_SETFD, FD_CLOEXEC);
> +
> +       scnprintf(path, PATH_MAX, "%s/control", daemon->base);

I couldn't find where the default value of daemon->base is set.
Also 100 bytes seem not enough for the path name.

Thanks,
Namhyung

> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.sun_family = AF_UNIX;
> +
> +       strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +       unlink(path);
> +
> +       if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
> +               perror("failed: bind");
> +               return -1;
> +       }
> +
> +       if (listen(fd, 1) == -1) {
> +               perror("failed: listen");
> +               return -1;
> +       }
> +
> +       return fd;
> +}
