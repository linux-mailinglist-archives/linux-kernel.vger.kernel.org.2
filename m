Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4C30F352
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhBDMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:43:30 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45794 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:43:29 -0500
Received: by mail-lf1-f45.google.com with SMTP id q12so4228995lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sODDqAnRPzoRbI6urxCuqdKcXMisa+IJ5crknCSi0mE=;
        b=W/rmKlOwAeDt2u9B/UwWK2j9+NkLPZMFDHR6NpwUZ4+Se3Ic+TLrUxZN5JqXrCfXQj
         6UkA37sq1dCRCVU4+138d/KotmqOe2V7Nv5tRzamB3bnwze05mLWXNBqN4bN7TlxoIpa
         67ewh2I3c3dWjg/1sQboGTSAVb5L4rNA/jMa1GKSvam0ke9KConJKO+Mqp4qWNN/mi8f
         3JV0cYjvcv6/WNH4xBf3zvWqc4nlq08mKcq7oyLKjohiOqBr9Roq5kSaw3Z1KU47C7Se
         K03/8UZcj3QmYTzTL4a8m9s7jN0vWJXjooDqK8ulr1kXwTZS7RYOjuPJdpITGD3xVYWo
         Dzdw==
X-Gm-Message-State: AOAM5316dMUtyJVk4xDh317bqHkADmXUug9aDQ2xYrxXxqjqSbCLZnpk
        xRyl+nbG0Dwbfgafa6wFaVDPCIZoFMzPFj8Hx5s=
X-Google-Smtp-Source: ABdhPJwG1pSvfmp0hN8wnZ72/0tMitsATPtdBSmjdhHJstOXs7WMDTcDijtyu1coqAVlzHSPHP/aFqu150+NsSbLogc=
X-Received: by 2002:a19:5c6:: with SMTP id 189mr4443766lff.300.1612442567024;
 Thu, 04 Feb 2021 04:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-7-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Feb 2021 21:42:35 +0900
Message-ID: <CAM9d7cjuPHh6j2H5-M-5=4MSujoJH7rWUYwKbypOk7_Jt-6QTg@mail.gmail.com>
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
[SNIP]
> +#define SESSION_OUTPUT  "output"
> +
> +/*
> + * Session states:
> + *
> + *   OK       - session is up and running
> + *   RECONFIG - session is pending for reconfiguration,
> + *              new values are already loaded in session object
> + *   KILL     - session is pending to be killed
> + *
> + * Session object life and its state is maintained by
> + * following functions:
> + *
> + *  setup_server_config
> + *    - reads config file and setup session objects
> + *      with following states:
> + *
> + *      OK       - no change needed
> + *      RECONFIG - session needs to be changed
> + *                 (run variable changed)
> + *      KILL     - session needs to be killed
> + *                 (session is no longer in config file)
> + *
> + *  daemon__reconfig
> + *    - scans session objects and does following actions
> + *      for states:
> + *
> + *      OK       - skip
> + *      RECONFIG - session is killed and re-run with new config
> + *      KILL     - session is killed
> + *
> + *    - all sessions have OK state on the function exit
> + */
> +enum session_state {
> +       SESSION_STATE__OK,
> +       SESSION_STATE__RECONFIG,
> +       SESSION_STATE__KILL,
> +};
> +
> +struct session {
> +       char                    *base;
> +       char                    *name;
> +       char                    *run;
> +       int                      pid;
> +       struct list_head         list;
> +       enum session_state       state;
> +};

Although I think calling it 'session' is intuitive, it's also confusing
as we already have struct perf_session...

Thanks,
Namhyung
