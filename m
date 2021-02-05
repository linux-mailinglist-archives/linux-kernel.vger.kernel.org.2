Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7E3117D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhBFAcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:32:01 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45990 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhBELkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:40:47 -0500
Received: by mail-lf1-f50.google.com with SMTP id q12so9370043lfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es/CMOpBNmEyuPK38vfc/xXnUQ3gwpJqjdelmm/M8tM=;
        b=YHQYT+/fxl6XkYtWUsgOHoktJHQ3K5Z6ivixvoBdW39u2qVzZmX0WrvZuDsoULhZ8F
         etiQ7+VrTVJIQ3XCcapqZyXBOdtIMXKuuhpgOU75KWo7KxRMe4XKxaqiLPUxiGGdBT/I
         +cJ6w7TH5Y3fSVE9fXPnEKGnD9L7A7+ASLWbTABHoE56aWMzht20jTzP0et2s12n/JoS
         dZZcBefdLHiJ13UL6LeAOkbJ/htzGKdHN7ybvMo64G9/rGiPHlS1QEa4rWEg+bRaT8ny
         qfm/gHqieypgeVy2lgUX4CqxwUWNTaRxr4usQRUGynnCoaO7Gz6XVHkbVZTvWB0gjXGc
         V+hA==
X-Gm-Message-State: AOAM530tBoRzuN2lPNzX4/nwJAZfRe0dnlo6XCXdzHPDP23uBdBg0VO1
        whw8vUzow1lYKDoRiL2eF7XlzVSnWAlkBcIrwEM=
X-Google-Smtp-Source: ABdhPJwho135ZbzSUoJ+0l2SHrUaJmsgupXMcrnOmAQQ+jEJna1Tf7jwRwVQROtJ1u3oqfw7WHXIosYA9KzVjhlX6zY=
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr2333999lfu.509.1612525203821;
 Fri, 05 Feb 2021 03:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-6-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-6-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 20:39:52 +0900
Message-ID: <CAM9d7chWTLScBwLkAq_4Xm9dvLASCP3wp=P+dtsViodr=Jtr2A@mail.gmail.com>
Subject: Re: [PATCH 05/24] perf daemon: Add client socket support
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
> Adding support for client socket side that will be used
> to send commands to daemon server socket.
>
> This patch adds only the core support, all commands using
> this functionality are coming in following patches.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 105 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 756d60616d7d..eada3ceb9b0c 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -11,6 +11,7 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> +#include <sys/stat.h>
>  #include <poll.h>
>  #include "builtin.h"
>  #include "perf.h"
> @@ -42,6 +43,50 @@ static void sig_handler(int sig __maybe_unused)
>         done = true;
>  }
>
> +static int client_config(const char *var, const char *value, void *cb)
> +{
> +       struct daemon *daemon = cb;
> +
> +       if (!strcmp(var, "daemon.base") && !daemon->base_user) {
> +               daemon->base = strdup(value);
> +               if (!daemon->base)
> +                       return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int check_base(struct daemon *daemon)
> +{
> +       struct stat st;
> +
> +       if (!daemon->base) {
> +               pr_err("failed: base not defined\n");
> +               return -EINVAL;
> +       }
> +
> +       if (stat(daemon->base, &st)) {
> +               pr_err("failed: base '%s' does not exists\n", daemon->base);

Well, it could be a permission error or something..

> +               return -EINVAL;
> +       }

You may also check whether it's a directory.

> +
> +       return 0;
> +}
> +
> +static int setup_client_config(struct daemon *daemon)
> +{
> +       struct perf_config_set *set;
> +       int err = -ENOMEM;
> +
> +       set = perf_config_set__load_file(daemon->config_real);
> +       if (set) {
> +               err = perf_config_set(set, client_config, daemon);
> +               perf_config_set__delete(set);
> +       }
> +
> +       return err ?: check_base(daemon);
> +}
> +
>  static int setup_server_socket(struct daemon *daemon)
>  {
>         struct sockaddr_un addr;
> @@ -114,6 +159,32 @@ static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_f
>         return ret;
>  }
>
> +static int setup_client_socket(struct daemon *daemon)
> +{
> +       struct sockaddr_un addr;
> +       char path[100];
> +       int fd;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +       if (fd == -1) {
> +               perror("failed: socket");
> +               return -1;
> +       }
> +
> +       scnprintf(path, PATH_MAX, "%s/control", daemon->base);

Same as the previous patch.  The path is 100 bytes..

Thanks,
Namhyung

> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.sun_family = AF_UNIX;
> +       strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +
> +       if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
> +               perror("failed: connect");
> +               return -1;
> +       }
> +
> +       return fd;
> +}
