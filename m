Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C1358B33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhDHRTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231954AbhDHRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10CE0610CC;
        Thu,  8 Apr 2021 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617902353;
        bh=jcoRLST2y1NNwVKvgKUD566PzN4T/RBHYS0NIBD9fvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uu5l3yTDoHC0eyk5yRITr2M72p5957mkwPn/+isK9s+uMQ5luFwDPYR+/JAdcbf4a
         c1dUYoL74UtAxWossA8L8mXrAM23gFw5pMRLhIyOWRl2tOMuyMV9FSNilOoQbbd4N/
         jJYKdPl4sTeCwXNRMAiNH5HW+/Pt5B2636vYcO103zn/EDSR44mGT5Xk59eDfINIqy
         H5DgL3Ri0zA40CZKUYH79Locpzebfd6YAkmmlm0Wi7p9EOhGQCl6bIovdjSTcn+FEY
         /plfpyzDt3foiRrHJT36hnkJEIxlHMyzW3IYObsb+el/NJOGoufA26LXCD2n7imF4s
         RMRcb1AUKHH8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9C8140647; Thu,  8 Apr 2021 14:19:09 -0300 (-03)
Date:   Thu, 8 Apr 2021 14:19:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YG87DRfcyMTz/VwL@kernel.org>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org>
 <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu escreveu:
> > On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
> >> Currently, to use BPF to aggregate perf event counters, the user uses
> >> --bpf-counters option. Enable "use bpf by default" events with a config
> >> option, stat.bpf-counter-events. This is limited to hardware events in
> >> evsel__hw_names.
> >> 
> >> This also enables mixed BPF event and regular event in the same sesssion.
> >> For example:
> >> 
> >>   perf config stat.bpf-counter-events=instructions
> >>   perf stat -e instructions,cs
> >> 
> > 
> > so if we are mixing events now, how about uing modifier for bpf counters,
> > instead of configuring .perfconfig list we could use:
> > 
> >  perf stat -e instructions:b,cs
> > 
> > thoughts?
> > 
> > the change below adds 'b' modifier and sets 'evsel::bpf_counter',
> > feel free to use it
> 
> I think we will need both 'b' modifier and .perfconfig configuration. 

Agreed, maximum flexibility.

> For systems with BPF-managed perf events running in the background, 
> .perfconfig makes sure perf-stat sessions will share PMCs with these 
> background monitoring tools. 'b' modifier, on the other hand, is useful
> when the user knows there is opportunity to share the PMCs. 
> 
> Does this make sense? 

I think so.

- Arnaldo
 
> Thanks,
> Song
> 
> > 
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index ca52581f1b17..c55e4e58d1dc 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -82,6 +82,7 @@ struct evsel {
> > 		bool			auto_merge_stats;
> > 		bool			collect_stat;
> > 		bool			weak_group;
> > +		bool			bpf_counter;
> > 		int			bpf_fd;
> > 		struct bpf_object	*bpf_obj;
> > 	};
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 9ecb45bea948..b5850f1ea90b 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1801,6 +1801,7 @@ struct event_modifier {
> > 	int pinned;
> > 	int weak;
> > 	int exclusive;
> > +	int bpf_counter;
> > };
> > 
> > static int get_event_modifier(struct event_modifier *mod, char *str,
> > @@ -1821,6 +1822,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
> > 	int exclude = eu | ek | eh;
> > 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
> > 	int weak = 0;
> > +	int bpf_counter = 0;
> > 
> > 	memset(mod, 0, sizeof(*mod));
> > 
> > @@ -1864,6 +1866,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
> > 			exclusive = 1;
> > 		} else if (*str == 'W') {
> > 			weak = 1;
> > +		} else if (*str == 'b') {
> > +			bpf_counter = 1;
> > 		} else
> > 			break;
> > 
> > @@ -1895,6 +1899,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
> > 	mod->sample_read = sample_read;
> > 	mod->pinned = pinned;
> > 	mod->weak = weak;
> > +	mod->bpf_counter = bpf_counter;
> > 	mod->exclusive = exclusive;
> > 
> > 	return 0;
> > @@ -1909,7 +1914,7 @@ static int check_modifier(char *str)
> > 	char *p = str;
> > 
> > 	/* The sizeof includes 0 byte as well. */
> > -	if (strlen(str) > (sizeof("ukhGHpppPSDIWe") - 1))
> > +	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
> > 		return -1;
> > 
> > 	while (*p) {
> > @@ -1950,6 +1955,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
> > 		evsel->sample_read         = mod.sample_read;
> > 		evsel->precise_max         = mod.precise_max;
> > 		evsel->weak_group	   = mod.weak;
> > +		evsel->bpf_counter         = mod.bpf_counter;
> > 
> > 		if (evsel__is_group_leader(evsel)) {
> > 			evsel->core.attr.pinned = mod.pinned;
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 0b36285a9435..fb8646cc3e83 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
> > name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> > drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> > /* If you add a modifier you need to update check_modifier() */
> > -modifier_event	[ukhpPGHSDIWe]+
> > +modifier_event	[ukhpPGHSDIWeb]+
> > modifier_bp	[rwx]{1,3}
> > 
> > %%
> > 
> 

-- 

- Arnaldo
