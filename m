Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136583717E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhECP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhECP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D879F61208;
        Mon,  3 May 2021 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620055526;
        bh=zCIrm6nO8yuNNKJziohZPZ1FG7y97trbGgxfNMA/Txs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmxTuwy6R9cYo2uCdEDi/sAuQ3YPToNzWZyvWKTTqC37G39+FN4+Aw2RZgF4MhPCB
         lVp+xi6gqHO5zKrWpPLGLDuBctjakJLkfe4Fi8hwSsLrk3q8wjfqtE2N8yixwjn/S0
         t8PY4uZZ7Dgng5OQKRVjSZCNhFDILSWJsOmIXwS2LaY1j7WvC6/ThfD8uqr6DV+PJt
         okKD5ZbwZfOq5DynjlhrWIos8aAuqTSiZWkytS/O1g1HCbszv9Fir5guRDksTU/0Uh
         hNaC3rNqEAAueSe1H2zwFE7tg57zjeBy0eDuLBA52t38pNEKgdjMbaU2leudtYUHG0
         fZgMFmXEC/1Og==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8DFF41084; Mon,  3 May 2021 12:25:22 -0300 (-03)
Date:   Mon, 3 May 2021 12:25:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Message-ID: <YJAV4vBUFr6sz5tM@kernel.org>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
 <YIcwRj4WtsZln4SR@krava>
 <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com>
 <YIgElir6KJCoygX5@krava>
 <5257A59A-CC47-4CA7-9C15-CD6E20DC4BD0@fb.com>
 <7DBDECAE-D100-44C0-B5D3-DE48631430B5@fb.com>
 <YJAEKfvUXFPCik5+@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJAEKfvUXFPCik5+@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 03, 2021 at 04:09:45PM +0200, Jiri Olsa escreveu:
> On Thu, Apr 29, 2021 at 10:40:01PM +0000, Song Liu wrote:
> 
> SNIP
> 
> > >>>>> #include "../perf.h"
> > >>>>> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
> > >>>>> 	if (affinity__setup(&affinity) < 0)
> > >>>>> 		return;

> > >>>>> +	evlist__for_each_entry(evlist, pos)
> > >>>>> +		bpf_counter__disable(pos);

> > >>>> I was wondering why you don't check evsel__is_bpf like
> > >>>> for the enable case.. and realized that we don't skip
> > >>>> bpf evsels in __evlist__enable and __evlist__disable
> > >>>> like we do in read_affinity_counters

> > >>>> so I guess there's extra affinity setup and bunch of
> > >>>> wrong ioctls being called?

> > >>> We actually didn't do wrong ioctls because the following check:

> > >>>      if (... || !pos->core.fd)
> > >>>               continue;

> > >>> in __evlist__enable and __evlist__disable. That we don't allocate 
> > >>> core.fd for is_bpf events. 

> > >>> It is probably good to be more safe with an extra check of 
> > >>> evsel__is_bpf(). But it is not required with current code. 

> > >> hum, but it will do all the affinity setup no? for no reason,
> > >> if there's no non-bpb event

> > > Yes, it will do the affinity setup. Let me see how to get something
> > > like all_counters_use_bpf here (or within builtin-stat.c).

> > Would something like the following work? It is not clean (skipping some 
> > useful logic in __evlist__[enable|disable]). But it seems to work in the
> > tests.

> sorry for late reply, but I can't no longer apply this:
 
> 	patching file tools/perf/builtin-stat.c
> 	Hunk #1 FAILED at 572.
> 	Hunk #2 FAILED at 581.
> 	2 out of 2 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
> 	patching file tools/perf/util/evlist.c
> 	Hunk #1 FAILED at 425.
> 	1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/evlist.c.rej
 
> ah, I see the patchset got already merged.. not sure why I'm doing review then ;-)

Hey, sometimes this can happen, sorry. Song, please submit on top of
what is upstream.

- Arnaldo
