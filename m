Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97C39CDD7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhFFHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:13:33 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36446 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhFFHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:13:32 -0400
Received: by mail-lj1-f174.google.com with SMTP id 131so17577071ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 00:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J14ZWOUPSUsubIodrsw7gm9oqAohzY5mAGClxdW9xwk=;
        b=FpLwI8t9xWEkUkHRFTWd5UAFyVzD0DVlaS1bJSFsyM4PZD0CemHEyHJxUthVdhARnH
         7LzupBNQbQAHGT1JdezcIbZdh5CfM5BfJxX5RiL1Y9kMX5UvStCaSMqJpy/GlewxOuD+
         fI7ppEO+KpZVS0MtmM49ap/kLUb+eJjIK8VV7BuaIH6LCUI8MJIuSOWv/De/lvjHvJrk
         XtpR6FWoU1CpMI7A4ooD/G8WJ9z6WrDHoMXlyS3abV4uJ8044d6JWgDoPozMb2K3uI5N
         gFtCPqPuWMt6IN6jxv0oK2u1aqCT+qnMkdJjr2qUi3CHAB2GCWfr4hOsOItY5QF1zlg2
         Iisw==
X-Gm-Message-State: AOAM531DfAP49CzkoL5Dfv8twm+j1YQq2k9saFA8iP0qzXmaMGr7i0q7
        Vn22UMLOzDxL745axea8JbXpRtMovLDrVHaW2U4=
X-Google-Smtp-Source: ABdhPJzF2tLis9On6TkgwYxXrzp19kAAHTdraO1K0ybZOtpxey1qpP1WZuC5z1ctcxIN8IOBbpQnF4xsfV2pIQRIA+8=
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr3572662ljb.233.1622963501986;
 Sun, 06 Jun 2021 00:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
 <162282065877.448336.10047912688119745151.stgit@devnote2> <YLp8lxoSPmUtQUra@kernel.org>
In-Reply-To: <YLp8lxoSPmUtQUra@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 6 Jun 2021 00:11:31 -0700
Message-ID: <CAM9d7chiBzLNpNphN+P=Zq+oyU-pw2Et7VWT6vxVYF_zVLsXyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/probe: Report possible permission error for
 map__load failure
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo and Masami,

On Fri, Jun 4, 2021 at 12:18 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Jun 05, 2021 at 12:30:58AM +0900, Masami Hiramatsu escreveu:
> > Report possible permission error including kptr_restrict setting
> > for map__load() failure. This can happen when non-superuser runs
> > perf probe.
> >
> > With this patch, perf probe shows the following message.
> >
> >  $ perf probe vfs_read
> >  Failed to load symbols from /proc/kallsyms
> >  Please ensure you can read the /proc/kallsyms symbol addresses.
> >  If the /proc/sys/kernel/kptr_restrict is '2', you can not read
> >  kernel symbol address even if you are a superuser. Please change
> >  it to '1'. If kptr_restrict is '1', the superuser can read the
> >  symbol addresses.
> >  In that case, please run this command again with sudo.
> >    Error: Failed to add events.

Maybe we can read the kptr_restrict file and (e)uid to suggest
the specific message for the situation only.

Thanks,
Namhyung

>
>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 3a7649835ec9..8fe179d671c3 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2936,7 +2936,7 @@ static int find_probe_functions(struct map *map, char *name,
> >       bool cut_version = true;
> >
> >       if (map__load(map) < 0)
> > -             return 0;
> > +             return -EACCES; /* Possible permission error to load symbols */
> >
> >       /* If user gives a version, don't cut off the version from symbols */
> >       if (strchr(name, '@'))
> > @@ -2975,6 +2975,17 @@ void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> >                               struct map *map __maybe_unused,
> >                               struct symbol *sym __maybe_unused) { }
> >
> > +
> > +static void pr_kallsyms_access_error(void)
> > +{
> > +     pr_err("Please ensure you can read the /proc/kallsyms symbol addresses.\n"
> > +            "If the /proc/sys/kernel/kptr_restrict is '2', you can not read\n"
> > +            "kernel symbol address even if you are a superuser. Please change\n"
> > +            "it to '1'. If kptr_restrict is '1', the superuser can read the\n"
> > +            "symbol addresses.\n"
> > +            "In that case, please run this command again with sudo.\n");
> > +}
> > +
> >  /*
> >   * Find probe function addresses from map.
> >   * Return an error or the number of found probe_trace_event
> > @@ -3011,8 +3022,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
> >        */
> >       num_matched_functions = find_probe_functions(map, pp->function, syms);
> >       if (num_matched_functions <= 0) {
> > -             pr_err("Failed to find symbol %s in %s\n", pp->function,
> > -                     pev->target ? : "kernel");
> > +             if (num_matched_functions == -EACCES) {
> > +                     pr_err("Failed to load symbols from %s\n",
> > +                            pev->target ?: "/proc/kallsyms");
> > +                     if (pev->target)
> > +                             pr_err("Please ensure the file is not stripped.\n");
> > +                     else
> > +                             pr_kallsyms_access_error();
> > +             } else
> > +                     pr_err("Failed to find symbol %s in %s\n", pp->function,
> > +                             pev->target ? : "kernel");
> >               ret = -ENOENT;
> >               goto out;
> >       } else if (num_matched_functions > probe_conf.max_probes) {
> >
>
> --
>
> - Arnaldo
