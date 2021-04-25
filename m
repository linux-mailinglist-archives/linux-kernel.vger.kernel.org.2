Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0936A7EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhDYPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 11:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhDYPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 11:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619363824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wAfhZaCKz6YZT3Q4dYOhAfFj0Cy36LcHLI3F5nnuEYQ=;
        b=Z+GyfkEP47S6wckv2C28KcCpcMEbmIHHscQPt98BteDLnwEsj88ZbGIWJmA8DzeqRIkuPl
        55cjjYniB5x26XXnYvhQEeOF/8yIem18bxYWtLf96mNEOVF5ARX3GB0OYCronm4P3cLrjQ
        WOi5mB3yoccr0fBZSDOiYbca/g5gIHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-Ef3NCVHFOCmv_hEjmEsgcA-1; Sun, 25 Apr 2021 11:17:02 -0400
X-MC-Unique: Ef3NCVHFOCmv_hEjmEsgcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 645198030B5;
        Sun, 25 Apr 2021 15:17:01 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D14E5C1CF;
        Sun, 25 Apr 2021 15:16:59 +0000 (UTC)
Date:   Sun, 25 Apr 2021 17:16:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YIWH6mKgIvPSfXRP@krava>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org>
 <YH8P5ol5JRr5JO5v@krava>
 <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com>
 <YH/773ecFa3iESlH@krava>
 <YIV+8zIj6YrzNXoL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIV+8zIj6YrzNXoL@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 11:38:43AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 21, 2021 at 12:18:23PM +0200, Jiri Olsa escreveu:
> > On Tue, Apr 20, 2021 at 09:21:32PM +0000, Song Liu wrote:
> > > 
> > > 
> > > > On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > 
> > > > On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
> > > > 
> > > > SNIP
> > > > 
> > > >> 	if (stat_config.initial_delay < 0) {
> > > >> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > > >> 	if (affinity__setup(&affinity) < 0)
> > > >> 		return -1;
> > > >> 
> > > >> -	if (target__has_bpf(&target)) {
> > > >> -		evlist__for_each_entry(evsel_list, counter) {
> > > >> -			if (bpf_counter__load(counter, &target))
> > > >> -				return -1;
> > > >> -		}
> > > >> +	evlist__for_each_entry(evsel_list, counter) {
> > > >> +		if (bpf_counter__load(counter, &target))
> > > >> +			return -1;
> > > >> +		if (!evsel__is_bpf(counter))
> > > >> +			all_counters_use_bpf = false;
> > > > 
> > > > could be done in bpf_counter__load, check below:
> > > > 
> > > >> 	}
> > > >> 
> > > >> 	evlist__for_each_cpu (evsel_list, i, cpu) {
> > > >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > > >> index 5de991ab46af9..33b1888103dfa 100644
> > > >> --- a/tools/perf/util/bpf_counter.c
> > > >> +++ b/tools/perf/util/bpf_counter.c
> > > >> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
> > > >> {
> > > >> 	if (target->bpf_str)
> > > >> 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> > > >> -	else if (target->use_bpf)
> > > >> +	else if (target->use_bpf ||
> > > >> +		 evsel__match_bpf_counter_events(evsel->name))
> > > >> 		evsel->bpf_counter_ops = &bperf_ops;
> > > > 
> > > > with:
> > > > 	else
> > > > 		all_counters_use_bpf = false;
> > > > 
> > > > I was also thinking of oving it to evlist, but it's sat specific,
> > > > so I think it's good as static.. thanks for changing the implementation
> > > 
> > > Hmm... then we need to somehow make all_counters_use_bpf visible in
> > > bpf_counter.c, which won't be very clean. Also, since this is stat 
> > > specific, I guess it is better to keep it inside builtin-stat.c?
> > > The runtime overhead should be minimal. 
> > 
> > ah it's different file :) then it's better as it is, sorry
> 
> Is this a Reviewed-by?

there's still the matter of disable callback:
  https://lore.kernel.org/lkml/YH8Pw4m0w6DuuEXo@krava/

it looks like now it could wrong value if we don't disable it

jirka

