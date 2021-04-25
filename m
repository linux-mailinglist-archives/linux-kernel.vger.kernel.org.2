Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF08536A7D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhDYOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 10:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhDYOjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 10:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99DC461153;
        Sun, 25 Apr 2021 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619361525;
        bh=GMPOZDqHnLjKWBasZvrjvGDu00VMeOq3W3hlYB1Odcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc+TWyJFIsjOImgKaw2/Kv4fm2wVeE86oyH7W/N0IxjsY7HB9QRBd7rYNxm7yIhcM
         Zb/wPZRfIUJNhV8+/gpCYc+UEtFpeFRP0h/oniE7C4/MjH0OTs28sJLrcMlRIfa7VZ
         C5YBN/ktG2DBYc+ZxAeuYySPB67aiqXfHgI5ijax9QvpV75yfPLkRLs8QYJD49gmBa
         lh7CPLbE/dazgpLW6aDncnGx8ZMjmdhH8zwCE+SuKY1/rLMMsw3/VulMFj31JCo3zy
         K9ByXmO07R+ui/j/XKlTyEEXharXQs+mcbYjgt2jZPv1TN6vXyUnNQTpaWq7ulACyE
         NTwGNZmsk/ttA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3257240647; Sun, 25 Apr 2021 11:38:43 -0300 (-03)
Date:   Sun, 25 Apr 2021 11:38:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YIV+8zIj6YrzNXoL@kernel.org>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org>
 <YH8P5ol5JRr5JO5v@krava>
 <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com>
 <YH/773ecFa3iESlH@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/773ecFa3iESlH@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 21, 2021 at 12:18:23PM +0200, Jiri Olsa escreveu:
> On Tue, Apr 20, 2021 at 09:21:32PM +0000, Song Liu wrote:
> > 
> > 
> > > On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > 
> > > On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
> > > 
> > > SNIP
> > > 
> > >> 	if (stat_config.initial_delay < 0) {
> > >> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >> 	if (affinity__setup(&affinity) < 0)
> > >> 		return -1;
> > >> 
> > >> -	if (target__has_bpf(&target)) {
> > >> -		evlist__for_each_entry(evsel_list, counter) {
> > >> -			if (bpf_counter__load(counter, &target))
> > >> -				return -1;
> > >> -		}
> > >> +	evlist__for_each_entry(evsel_list, counter) {
> > >> +		if (bpf_counter__load(counter, &target))
> > >> +			return -1;
> > >> +		if (!evsel__is_bpf(counter))
> > >> +			all_counters_use_bpf = false;
> > > 
> > > could be done in bpf_counter__load, check below:
> > > 
> > >> 	}
> > >> 
> > >> 	evlist__for_each_cpu (evsel_list, i, cpu) {
> > >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > >> index 5de991ab46af9..33b1888103dfa 100644
> > >> --- a/tools/perf/util/bpf_counter.c
> > >> +++ b/tools/perf/util/bpf_counter.c
> > >> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
> > >> {
> > >> 	if (target->bpf_str)
> > >> 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> > >> -	else if (target->use_bpf)
> > >> +	else if (target->use_bpf ||
> > >> +		 evsel__match_bpf_counter_events(evsel->name))
> > >> 		evsel->bpf_counter_ops = &bperf_ops;
> > > 
> > > with:
> > > 	else
> > > 		all_counters_use_bpf = false;
> > > 
> > > I was also thinking of oving it to evlist, but it's sat specific,
> > > so I think it's good as static.. thanks for changing the implementation
> > 
> > Hmm... then we need to somehow make all_counters_use_bpf visible in
> > bpf_counter.c, which won't be very clean. Also, since this is stat 
> > specific, I guess it is better to keep it inside builtin-stat.c?
> > The runtime overhead should be minimal. 
> 
> ah it's different file :) then it's better as it is, sorry

Is this a Reviewed-by?

- Arnaldo
 
> jirka
> 
> > 
> > Thanks,
> > Song
> > 
> 

-- 

- Arnaldo
