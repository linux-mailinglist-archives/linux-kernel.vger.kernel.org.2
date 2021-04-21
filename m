Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F8366907
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhDUKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234947AbhDUKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619000311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9vYDchYhebFU76wqYouyAVgYBvDfRNiPS9Y9xYWp/k=;
        b=RR67y3BPg00isJshV2mVFu1p1Ho4FVHcDAJho3su6l3pABb/QrIskARzHJHK6Ih4cgCFT4
        9qM6Y4/mKjXhZ88LlRedJ36nVmsfyBmQH520lwlZhvF0+finiV43H5SSyXne4zWT459Q1n
        in72XMnFxnjAFPHdAYikEI3kcr9BnJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-RZ1mMx62MQuCqPtaFOhj5g-1; Wed, 21 Apr 2021 06:18:27 -0400
X-MC-Unique: RZ1mMx62MQuCqPtaFOhj5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898D718397A7;
        Wed, 21 Apr 2021 10:18:26 +0000 (UTC)
Received: from krava (unknown [10.40.193.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF2E919D9B;
        Wed, 21 Apr 2021 10:18:24 +0000 (UTC)
Date:   Wed, 21 Apr 2021 12:18:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YH/773ecFa3iESlH@krava>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org>
 <YH8P5ol5JRr5JO5v@krava>
 <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:21:32PM +0000, Song Liu wrote:
> 
> 
> > On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
> > 
> > SNIP
> > 
> >> 	if (stat_config.initial_delay < 0) {
> >> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >> 	if (affinity__setup(&affinity) < 0)
> >> 		return -1;
> >> 
> >> -	if (target__has_bpf(&target)) {
> >> -		evlist__for_each_entry(evsel_list, counter) {
> >> -			if (bpf_counter__load(counter, &target))
> >> -				return -1;
> >> -		}
> >> +	evlist__for_each_entry(evsel_list, counter) {
> >> +		if (bpf_counter__load(counter, &target))
> >> +			return -1;
> >> +		if (!evsel__is_bpf(counter))
> >> +			all_counters_use_bpf = false;
> > 
> > could be done in bpf_counter__load, check below:
> > 
> >> 	}
> >> 
> >> 	evlist__for_each_cpu (evsel_list, i, cpu) {
> >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >> index 5de991ab46af9..33b1888103dfa 100644
> >> --- a/tools/perf/util/bpf_counter.c
> >> +++ b/tools/perf/util/bpf_counter.c
> >> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
> >> {
> >> 	if (target->bpf_str)
> >> 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> >> -	else if (target->use_bpf)
> >> +	else if (target->use_bpf ||
> >> +		 evsel__match_bpf_counter_events(evsel->name))
> >> 		evsel->bpf_counter_ops = &bperf_ops;
> > 
> > with:
> > 	else
> > 		all_counters_use_bpf = false;
> > 
> > I was also thinking of oving it to evlist, but it's sat specific,
> > so I think it's good as static.. thanks for changing the implementation
> 
> Hmm... then we need to somehow make all_counters_use_bpf visible in
> bpf_counter.c, which won't be very clean. Also, since this is stat 
> specific, I guess it is better to keep it inside builtin-stat.c?
> The runtime overhead should be minimal. 

ah it's different file :) then it's better as it is, sorry

jirka

> 
> Thanks,
> Song
> 

