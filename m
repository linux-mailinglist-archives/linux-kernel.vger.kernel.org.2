Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013831850B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKGCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:02:13 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43639 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBKGCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:02:05 -0500
Received: by mail-qk1-f175.google.com with SMTP id m144so4207908qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 22:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vzbRmZjGgrql1XHzPwT2L1PFTntGfeOkVZcxzUcGX0=;
        b=lH7epCf2sI+nIhpk7BXrnAvwR7op2uzfI6oqQnWL2s4ZXGYiMhnJlPgqa3vxiO6fby
         Tu+bO3qcwtiKwPMibJWMmm0e27Dk/Ep1QiWWr6LkUAoCZLQxDZx9z7uSEQp1tK8TZscP
         jB4iW8+77aVufrX7/TMQ0mj44Fgy6X+7kmoTN9ESFIFgDWAKRv8qgUXz9V6DCUanpyFy
         vMHu9uUZJal3NYNsOxjzymhKqT7rgPKitP0sIFXrz3KnRV5AT3oCmpCJe0HjaMkUbqMa
         qIp1ZeDxV+R1BlJvNoyxN/HhYPbg6JI/hHEONUUhToCWUbkFB0ZMZ4dT6uVOEvWWeOfS
         bgNQ==
X-Gm-Message-State: AOAM5310wqr+QsC0el3xC2KMJRiavAk3kT7ag6ZORVUPMP9RbFsxUfKf
        MNEjpNfcFY1OSdwyosdEdOshXhfYdTex4cn24fM=
X-Google-Smtp-Source: ABdhPJzuj4HYTd2YgLBLC1RcGIiSDGIBcjsINSIivpFBxlbqWSdYo4AbiMxKIVJ+6SuxcsvFcxcw/DDGm1Zr22pheTU=
X-Received: by 2002:a37:4b52:: with SMTP id y79mr7027844qka.132.1613023284612;
 Wed, 10 Feb 2021 22:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20210208200908.1019149-1-jolsa@kernel.org> <20210208200908.1019149-7-jolsa@kernel.org>
In-Reply-To: <20210208200908.1019149-7-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Feb 2021 15:01:12 +0900
Message-ID: <CAM9d7cgURTm6UVUkOo8Tfv_zRGWBAtHqdLKxdSXYmToajjgALg@mail.gmail.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Feb 9, 2021 at 5:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> +static int daemon__reconfig(struct daemon *daemon)
> +{
> +       struct daemon_session *session, *n;
> +
> +       list_for_each_entry_safe(session, n, &daemon->sessions, list) {
> +               /* No change. */
> +               if (session->state == OK)
> +                       continue;
> +
> +               /* Remove session. */
> +               if (session->state == KILL) {
> +                       if (session->pid > 0) {
> +                               daemon_session__kill(session);
> +                               pr_info("reconfig: session '%s' killed\n", session->name);
> +                       }
> +                       daemon_session__remove(session);
> +                       continue;
> +               }
> +
> +               /* Reconfig session. */
> +               if (session->pid > 0) {
> +                       daemon_session__kill(session);
> +                       pr_info("reconfig: session '%s' killed\n", session->name);
> +               }
> +               if (daemon_session__run(session, daemon))
> +                       return -1;

Shouldn't it be 'continue'?  If there's a problematic session
it'll prevent others from being processed.  And it seems this
code will try to run it again and again.  Maybe we can put it
in the KILL state (or a new FAILED state) IMHO.

Thanks,
Namhyung

> +
> +               session->state = OK;
> +       }
> +
> +       return 0;
> +}
> +
>  static int setup_config(struct daemon *daemon)
>  {
>         if (daemon->base_user) {
> @@ -278,6 +614,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>                 return -1;
>         }
>
> +       if (setup_server_config(daemon))
> +               return -1;
> +
>         debug_set_file(daemon->out);
>         debug_set_display_time(true);
>
> @@ -297,15 +636,23 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>         signal(SIGTERM, sig_handler);
>
>         while (!done && !err) {
> -               if (fdarray__poll(&fda, -1)) {
> +               err = daemon__reconfig(daemon);
> +
> +               if (!err && fdarray__poll(&fda, -1)) {
> +                       bool reconfig = false;
> +
>                         if (fda.entries[sock_pos].revents & POLLIN)
>                                 err = handle_server_socket(daemon, sock_fd);
> +
> +                       if (reconfig)
> +                               err = setup_server_config(daemon);
>                 }
>         }
>
>  out:
>         fdarray__exit(&fda);
>
> +       daemon__kill(daemon);
>         daemon__exit(daemon);
>
>         if (sock_fd != -1)
> --
> 2.29.2
>
