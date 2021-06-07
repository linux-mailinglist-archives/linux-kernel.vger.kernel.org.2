Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394839D24E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 02:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFGACa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 20:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhFGAC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 20:02:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C58C7613D4;
        Mon,  7 Jun 2021 00:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623024039;
        bh=sFcDsk43bRWCiNNJpt4dGwebNIZ85xx7EVOTgRarU7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cf0nyE1aHhCBkeTzYSLkiTG5ftNOpwKmQ5oRRw0CLI6es4TUyFd1Xkl6ZdQSA87zR
         wSE2okOUNMfJii2GwCE83Yn+j2J3/JtIJXBQ8spoSUOgVgFB7rozMuF1mymkhCQP4l
         hj8RdcSCT9IH/7q/4LuESpxe9TnN1ViyDkjnxCE3TWz82eRqpy5VlNNpjjvfCzfO0r
         MXn2PNWp1CNuw8pkiikI3q+ef7Wl7jjXxkHpN0eEZXiHx6wogjwTiiiMDXonV5TeMu
         qgE3JCfw+FB9/Xt3do9GQeDg8WKj0nFsr23DWikKiU1mRfjhmHXzW5L4OkDp1LzoLQ
         BAbI0zAKiFmeg==
Date:   Mon, 7 Jun 2021 09:00:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf/probe: Report possible permission error for
 map__load failure
Message-Id: <20210607090034.0f94d85fd8c517e5ae0e868c@kernel.org>
In-Reply-To: <CAM9d7chiBzLNpNphN+P=Zq+oyU-pw2Et7VWT6vxVYF_zVLsXyg@mail.gmail.com>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
        <162282065877.448336.10047912688119745151.stgit@devnote2>
        <YLp8lxoSPmUtQUra@kernel.org>
        <CAM9d7chiBzLNpNphN+P=Zq+oyU-pw2Et7VWT6vxVYF_zVLsXyg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 00:11:31 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Arnaldo and Masami,
> 
> On Fri, Jun 4, 2021 at 12:18 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sat, Jun 05, 2021 at 12:30:58AM +0900, Masami Hiramatsu escreveu:
> > > Report possible permission error including kptr_restrict setting
> > > for map__load() failure. This can happen when non-superuser runs
> > > perf probe.
> > >
> > > With this patch, perf probe shows the following message.
> > >
> > >  $ perf probe vfs_read
> > >  Failed to load symbols from /proc/kallsyms
> > >  Please ensure you can read the /proc/kallsyms symbol addresses.
> > >  If the /proc/sys/kernel/kptr_restrict is '2', you can not read
> > >  kernel symbol address even if you are a superuser. Please change
> > >  it to '1'. If kptr_restrict is '1', the superuser can read the
> > >  symbol addresses.
> > >  In that case, please run this command again with sudo.
> > >    Error: Failed to add events.
> 
> Maybe we can read the kptr_restrict file and (e)uid to suggest
> the specific message for the situation only.

Agreed, and that should be done in map__load(), since it returns -1
for any error. Caller needs to estimate the reason.

If each caller does it, those have to repeat same estimation and
similar messages in different place. Maybe we need to have a global
error and hint object so that caller can show it when it detects
an error.

Thank you,


> Thanks,
> Namhyung
> 
> >
> >
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > index 3a7649835ec9..8fe179d671c3 100644
> > > --- a/tools/perf/util/probe-event.c
> > > +++ b/tools/perf/util/probe-event.c
> > > @@ -2936,7 +2936,7 @@ static int find_probe_functions(struct map *map, char *name,
> > >       bool cut_version = true;
> > >
> > >       if (map__load(map) < 0)
> > > -             return 0;
> > > +             return -EACCES; /* Possible permission error to load symbols */
> > >
> > >       /* If user gives a version, don't cut off the version from symbols */
> > >       if (strchr(name, '@'))
> > > @@ -2975,6 +2975,17 @@ void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> > >                               struct map *map __maybe_unused,
> > >                               struct symbol *sym __maybe_unused) { }
> > >
> > > +
> > > +static void pr_kallsyms_access_error(void)
> > > +{
> > > +     pr_err("Please ensure you can read the /proc/kallsyms symbol addresses.\n"
> > > +            "If the /proc/sys/kernel/kptr_restrict is '2', you can not read\n"
> > > +            "kernel symbol address even if you are a superuser. Please change\n"
> > > +            "it to '1'. If kptr_restrict is '1', the superuser can read the\n"
> > > +            "symbol addresses.\n"
> > > +            "In that case, please run this command again with sudo.\n");
> > > +}
> > > +
> > >  /*
> > >   * Find probe function addresses from map.
> > >   * Return an error or the number of found probe_trace_event
> > > @@ -3011,8 +3022,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
> > >        */
> > >       num_matched_functions = find_probe_functions(map, pp->function, syms);
> > >       if (num_matched_functions <= 0) {
> > > -             pr_err("Failed to find symbol %s in %s\n", pp->function,
> > > -                     pev->target ? : "kernel");
> > > +             if (num_matched_functions == -EACCES) {
> > > +                     pr_err("Failed to load symbols from %s\n",
> > > +                            pev->target ?: "/proc/kallsyms");
> > > +                     if (pev->target)
> > > +                             pr_err("Please ensure the file is not stripped.\n");
> > > +                     else
> > > +                             pr_kallsyms_access_error();
> > > +             } else
> > > +                     pr_err("Failed to find symbol %s in %s\n", pp->function,
> > > +                             pev->target ? : "kernel");
> > >               ret = -ENOENT;
> > >               goto out;
> > >       } else if (num_matched_functions > probe_conf.max_probes) {
> > >
> >
> > --
> >
> > - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
