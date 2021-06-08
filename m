Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6839F67D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhFHM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhFHM0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 730F861182;
        Tue,  8 Jun 2021 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623155089;
        bh=7nsjiRJwLMZC2+SvPIFklEBYqjD2SpcmdnVIUAYmMng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7jNlkdLOO4pMghpgo5Sti5IshApCt2W86MMfAJC6DAJi4cqekKVd3s8e0l3DbtXJ
         3e9+QcE0zCEq8zuN91LJAsqWi+kU/NiCG5/pWEZ5Gnd7Z9UZZymwQ8ydql8KX5d33d
         I3xY7cTuKgegsuDxBd0hfODRisfDgeXQ//+yC55Wcg5UdJpAz6+/qBXbRJsLipymsP
         FYzo0vRYoPAg1441MKj1X/FTPfKmDg5Mmh0SzjOAgP/Toygdy7kYMyr2VTVEA+lBkD
         /tiKg5kY0Z9EZUWY5Mn3uz18GwmFN5PNyCYd9bY9InPcHDdWq8eXKJynk6Rrj7k+Ub
         X1+3kk+C2d6Bw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4073740B1A; Tue,  8 Jun 2021 09:24:46 -0300 (-03)
Date:   Tue, 8 Jun 2021 09:24:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf/probe: Report possible permission error for
 map__load failure
Message-ID: <YL9hjtbZJRmlno6R@kernel.org>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
 <162282065877.448336.10047912688119745151.stgit@devnote2>
 <YLp8lxoSPmUtQUra@kernel.org>
 <CAM9d7chiBzLNpNphN+P=Zq+oyU-pw2Et7VWT6vxVYF_zVLsXyg@mail.gmail.com>
 <20210607090034.0f94d85fd8c517e5ae0e868c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607090034.0f94d85fd8c517e5ae0e868c@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 07, 2021 at 09:00:34AM +0900, Masami Hiramatsu escreveu:
> On Sun, 6 Jun 2021 00:11:31 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Arnaldo and Masami,
> > 
> > On Fri, Jun 4, 2021 at 12:18 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Sat, Jun 05, 2021 at 12:30:58AM +0900, Masami Hiramatsu escreveu:
> > > > Report possible permission error including kptr_restrict setting
> > > > for map__load() failure. This can happen when non-superuser runs
> > > > perf probe.
> > > >
> > > > With this patch, perf probe shows the following message.
> > > >
> > > >  $ perf probe vfs_read
> > > >  Failed to load symbols from /proc/kallsyms
> > > >  Please ensure you can read the /proc/kallsyms symbol addresses.
> > > >  If the /proc/sys/kernel/kptr_restrict is '2', you can not read
> > > >  kernel symbol address even if you are a superuser. Please change
> > > >  it to '1'. If kptr_restrict is '1', the superuser can read the
> > > >  symbol addresses.
> > > >  In that case, please run this command again with sudo.
> > > >    Error: Failed to add events.
> > 
> > Maybe we can read the kptr_restrict file and (e)uid to suggest
> > the specific message for the situation only.
> 
> Agreed, and that should be done in map__load(), since it returns -1
> for any error. Caller needs to estimate the reason.

Then we need to change it to return a errno so that the caller can react
accordingly.

- Arnaldo
 
> If each caller does it, those have to repeat same estimation and
> similar messages in different place. Maybe we need to have a global
> error and hint object so that caller can show it when it detects
> an error.
> 
> Thank you,
> 
> 
> > Thanks,
> > Namhyung
> > 
> > >
> > >
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > ---
> > > >  tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
> > > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > > index 3a7649835ec9..8fe179d671c3 100644
> > > > --- a/tools/perf/util/probe-event.c
> > > > +++ b/tools/perf/util/probe-event.c
> > > > @@ -2936,7 +2936,7 @@ static int find_probe_functions(struct map *map, char *name,
> > > >       bool cut_version = true;
> > > >
> > > >       if (map__load(map) < 0)
> > > > -             return 0;
> > > > +             return -EACCES; /* Possible permission error to load symbols */
> > > >
> > > >       /* If user gives a version, don't cut off the version from symbols */
> > > >       if (strchr(name, '@'))
> > > > @@ -2975,6 +2975,17 @@ void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> > > >                               struct map *map __maybe_unused,
> > > >                               struct symbol *sym __maybe_unused) { }
> > > >
> > > > +
> > > > +static void pr_kallsyms_access_error(void)
> > > > +{
> > > > +     pr_err("Please ensure you can read the /proc/kallsyms symbol addresses.\n"
> > > > +            "If the /proc/sys/kernel/kptr_restrict is '2', you can not read\n"
> > > > +            "kernel symbol address even if you are a superuser. Please change\n"
> > > > +            "it to '1'. If kptr_restrict is '1', the superuser can read the\n"
> > > > +            "symbol addresses.\n"
> > > > +            "In that case, please run this command again with sudo.\n");
> > > > +}
> > > > +
> > > >  /*
> > > >   * Find probe function addresses from map.
> > > >   * Return an error or the number of found probe_trace_event
> > > > @@ -3011,8 +3022,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
> > > >        */
> > > >       num_matched_functions = find_probe_functions(map, pp->function, syms);
> > > >       if (num_matched_functions <= 0) {
> > > > -             pr_err("Failed to find symbol %s in %s\n", pp->function,
> > > > -                     pev->target ? : "kernel");
> > > > +             if (num_matched_functions == -EACCES) {
> > > > +                     pr_err("Failed to load symbols from %s\n",
> > > > +                            pev->target ?: "/proc/kallsyms");
> > > > +                     if (pev->target)
> > > > +                             pr_err("Please ensure the file is not stripped.\n");
> > > > +                     else
> > > > +                             pr_kallsyms_access_error();
> > > > +             } else
> > > > +                     pr_err("Failed to find symbol %s in %s\n", pp->function,
> > > > +                             pev->target ? : "kernel");
> > > >               ret = -ENOENT;
> > > >               goto out;
> > > >       } else if (num_matched_functions > probe_conf.max_probes) {
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
