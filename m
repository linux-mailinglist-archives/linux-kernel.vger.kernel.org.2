Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69D33BEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbhCOOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235598AbhCOOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615817351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Te+QGOtDllA6aRUur/Up9OX9aNQu8FVkEbmnZfm+sCQ=;
        b=PZJWfDe7cMhsPZ9wjo3DJNK7ydfv2x6x6g1qC4v2IVo18noWqROPyJ3UUTYCQsJxvXwiOt
        2oR3gqkl18NCW6WpZj9c2/IpyWDEeZXpEnWtTbKCOi7nF1JMBKO4Bj9e3zH42Mt/IxGlUP
        zBW9gaQLHqWdYbKAuif2j1xcRJ6zcnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-AYDJXehbOXuyYv0MRHwvCw-1; Mon, 15 Mar 2021 10:09:07 -0400
X-MC-Unique: AYDJXehbOXuyYv0MRHwvCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B302D83DD22;
        Mon, 15 Mar 2021 14:09:05 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 244721B5C3;
        Mon, 15 Mar 2021 14:09:03 +0000 (UTC)
Date:   Mon, 15 Mar 2021 15:09:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YE9qf8vcS8svnFG7@krava>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YE6Sq78CRmr/JsHl@krava>
 <95CDB411-4F73-4C56-8CA5-48C002F03ACF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95CDB411-4F73-4C56-8CA5-48C002F03ACF@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:51:11AM +0000, Song Liu wrote:

SNIP

> >> Known limitations:
> >> 1. Do not support per cgroup events;
> > 
> > isn't that another filter via bpf_get_current_cgroup_id ?
> 
> This is tricky with nested cgroups. We also have bpf_get_current_ancestor_cgroup_id,
> but that's not the exact same we need either. We may need a new helper. 
> 
> Also, we are limited by 38 follower programs for the leader program, which 
> might be too few for Namhyung's use case. We can use some logic in the 
> follower program to count events for many cgroups in one fexit program. 

ok, I see

> 
> > 
> >> 2. Do not support monitoring of BPF program (perf-stat -b);
> > 
> > we'd need to call the leadr on fentry/fexit of the monitored bpf
> > program, right?
> 
> My current plan is to let perf-stat -b share the same perf_event map with
> bperf, but not the leader program. 

ok

> 
> > 
> >> 3. Do not support event groups.
> > 
> > I guess for group support you'll need to load 'leaders' for each group member
> 
> I am not sure how this would work. Say the user started the following in 
> parallel:
> 
>     #1  perf stat --bpf-counters -e cycles -a &
>     #2  perf stat --bpf-counters -e instructions -C 1,2,3 &
>     #3  perf stat --bpf-counters -e {cycles,instructions} -p 123 
> 
> Event "cycles" is loaded by #1; while event "instruction" is loaded by #2.
> If #3 reuses these events, it is tricky (or impossible?) to make sure the
> event group works as expected, right?

the reason for group is to force kernel to all events if possible
or none..  so with your change I don't see a problem, you just
provide values for those counters.. but let's see when you get
there ;-)

> 
> > 
> >> 
> >> The following commands have been tested:
> >> 
> >>   perf stat --use-bpf -e cycles -a
> >>   perf stat --use-bpf -e cycles -C 1,3,4
> >>   perf stat --use-bpf -e cycles -p 123
> >>   perf stat --use-bpf -e cycles -t 100,101
> > 
> > works good with that file you sent.. I'll check/test more,
> > so far some quick comments below
> > 
> > thanks,
> > jirka
> > 
> > 
> > 
> > SNIP
> > 
> >> @@ -1146,6 +1156,10 @@ static struct option stat_options[] = {
> >> #ifdef HAVE_BPF_SKEL
> >> 	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
> >> 		   "stat events on existing bpf program id"),
> >> +	OPT_BOOLEAN(0, "use-bpf", &target.use_bpf,
> >> +		    "use bpf program to count events"),
> >> +	OPT_STRING(0, "attr-map", &target.attr_map, "attr-map-path",
> >> +		   "path to perf_event_attr map"),
> > 
> > what's the point of allowing another name? just debug purpose?
> 
> It is mostly to cover corner cases, like something else used the same 
> name. 

about that.. we just take the object fd assuming it's map,
should we test it somehow?

  map_fd = bpf_obj_get(path);

if it's not the map we expect, I think we should generate
another name without forcing user to run again with --attr-map

but still warn, so other perf session can use the new name

SNIP

> >> +static int bperf_sync_counters(struct evsel *evsel)
> >> +{
> >> +	struct perf_cpu_map *all_cpus = perf_cpu_map__new(NULL);
> >> +	int num_cpu, i, cpu;
> >> +
> >> +	if (!all_cpus)
> >> +		return -1;
> >> +
> >> +	num_cpu = all_cpus->nr;
> >> +	for (i = 0; i < num_cpu; i++) {
> >> +		cpu = all_cpus->map[i];
> >> +		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static int bperf__enable(struct evsel *evsel)
> >> +{
> >> +	struct bperf_follower_bpf *skel = evsel->follower_skel;
> >> +	__u32 num_cpu_bpf = libbpf_num_possible_cpus();
> > 
> > we have cpu__max_cpu for that
> 
> libbpf calls for percpu array use libbpf_num_possible_cpus. So I guess it 
> is better to use the same here. The two are identical at the moment though.

then in the bperf__read you take that array and update
perf_counts, which is based on perf's cpus, so they mix
anyway

I'd like to keep perf code using perf's cpus api.. could
we just check at the begining that libbpf_num_possible_cpus
returns same number as cpu__max_cpu (if not, we have a
problem anyway) and use perf's cpu api

thanks,
jirka

