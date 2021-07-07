Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD763BEE73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhGGSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232280AbhGGSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K07StvhPjMjrF6tq3BHilkcqj14o30L2eXhfZJ/lga8=;
        b=en5+16jtVbe+wlikFIoe/We6qL9lUCjcSENxbJKGW+3/eKQzexwuHMjjH09LPxPegBitkm
        8x48u64dlAdOcI8pFmXqpursD2prEj4xAeZix5JG/IFHGwIPj0zamwJ8EYc+sgNwlYT0Ho
        rgKQXQuknD98IVqSlgV/K2Jc1SUyknY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-7MMd6a7NPLmP8_wV-WIGLg-1; Wed, 07 Jul 2021 14:17:33 -0400
X-MC-Unique: 7MMd6a7NPLmP8_wV-WIGLg-1
Received: by mail-wr1-f72.google.com with SMTP id l12-20020a5d410c0000b029012b4f055c9bso1071404wrp.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K07StvhPjMjrF6tq3BHilkcqj14o30L2eXhfZJ/lga8=;
        b=BokSKnRWfGC0egUgiAF4Iy5pU++B1vxk5uokp6qlGAjs7xJlhmTOh4JVCQE3HIqW4s
         ma0/NpvAfnYgfk0ilqvK+2NIK1SBrRoU4qoZ3H7x0v3b/OIiitiAuSa3ndq0V350+trX
         V1rQpTx+bZjs6gGd24pfr4xKgdHgKrVSXmtzdY2/lqXz8kRo+j0b8RYDBf2eEfAw+mpy
         Jr04/+AfriSla2zQ8bOv45xkKG0Fn7V3TB6Lk5L7L6CX/wRydwJ0uoJO0AV16Hgym5w7
         +3fMUlnoIxGyo61P/FSG5/oWX7lg1SoPlZnMvf5QXszG9eKOIUA7GLGjZHSVuhlq0IlC
         sovg==
X-Gm-Message-State: AOAM532Uo88v1ryi6c4sBumEG56Imab9EfMksSb7NO5PEvw80qJ5dX1j
        M5hhs4IjzLEEJ12N/OBZeZSY2zKshYQwB/Mt5iJmJv0md4uJ6OAHCGMChYVAYknTUUKKpnq6Imj
        lAFm3/EJZyN8w1PfTJxJknv1+
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr378935wmq.61.1625681852375;
        Wed, 07 Jul 2021 11:17:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXktKMdwGkyALNP+XEtWN1XFXoZVRUNLy7lj0drkF0b2e2ggsV+32bJMo8bS3PGqcu4+7BOQ==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr378918wmq.61.1625681852262;
        Wed, 07 Jul 2021 11:17:32 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id h15sm20463100wrq.88.2021.07.07.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:17:31 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:17:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOXvt/8qrKXyomQU@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
 <YOW+3yhgNgMOrE99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW+3yhgNgMOrE99@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 11:49:03AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> > Moving evsel::idx to perf_evsel::idx, so we can move
> > the group interface to libperf.
> 
> I fixed up this, that appearead on my tree after you cooked up this
> patch:

great, thanks

jirka

> 
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 21261f1a05011d62..89aa5e71db1a9a23 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -124,7 +124,7 @@ static int bperf_load_program(struct evlist *evlist)
>  			map_fd = bpf_map__fd(skel->maps.events);
>  			for (cpu = 0; cpu < nr_cpus; cpu++) {
>  				int fd = FD(evsel, cpu);
> -				__u32 idx = evsel->idx * total_cpus +
> +				__u32 idx = evsel->core.idx * total_cpus +
>  					evlist->core.all_cpus->map[cpu];
>  
>  				err = bpf_map_update_elem(map_fd, &idx, &fd,
> @@ -221,7 +221,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
>  
>  static int bperf_cgrp__enable(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -232,7 +232,7 @@ static int bperf_cgrp__enable(struct evsel *evsel)
>  
>  static int bperf_cgrp__disable(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -251,7 +251,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  	int reading_map_fd, err = 0;
>  	__u32 idx;
>  
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -263,7 +263,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		idx = evsel->idx;
> +		idx = evsel->core.idx;
>  		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>  		if (err) {
>  			pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
> @@ -288,7 +288,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  
>  static int bperf_cgrp__destroy(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgroup_bpf__destroy(skel);
> 

