Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C472537CD13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbhELQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhELPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:51:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F181C0610F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:23:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j12so12366020pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WmCdrS1TMn2hGqp3nbYKTeNACXqD6MvKMsrI4Gekn0=;
        b=ByPtxvKS8saS9qVWc0y5uY71My/u0HVJpMZCgL608n9bGPKRUYdqAbwEkPBzAc7uwM
         fBi0WhHoWYUwqA/au/wpGSRUtAhP1jQtA8bu8YFZg5D/OUWsbZQtYZ/uvmpSIut+WDLb
         bv1/OWBmIlGFZAFLXnxwkdLQ+uxtVnSGBvaF4x5UwgIbL7npedNrw39k+qTJxPXu0I5J
         gvS+f3WD2j3/ko6dWje+/9NNLpWRWrRnaKiCVip0yXo6f3l4dVoptqbOlzxRcZH6OK0J
         S5T8nNXXKurgnm38yzt6GCCs6gMGFkFuxsx9j5r+A06BjrCgPjRubBUU+SlJhSincUMu
         vozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WmCdrS1TMn2hGqp3nbYKTeNACXqD6MvKMsrI4Gekn0=;
        b=VNakyhrkmeeyoG7zhVRfQYSBHVqAqb2aSQv0sg2alvDxo5Rx/hX2bG2QCeqIRy5SJ0
         RmN9YIPF/nrssAgzkhTQh9zlucEdjBZZ5hEKra6/QjYCSgp0dp8k5G8Flb8v6ruRzOos
         qRLj/SVonWSJd17hGwfQbqR/UeJw3C2yKXdGgpPeA9ABau+2sLqwx7UE73yyyHIHw7cG
         U4KTNy6lagX3fT+kn8WiPWZLE3O1d8Brg0yNf3gOtOtnSEeDHf/z2JUFg/RRK77yQbVz
         Zp7lUhEgSFVf9nD9AdUp0aZePZ+avx+tZlGWgPT35uctGhfuECzVN2duR66u/doKSUOB
         qs/Q==
X-Gm-Message-State: AOAM5308VpKnxlDmIw+66Kpd0ZL7vt5m/2NlKW7SK8Uzn4SD8nln4ORw
        eWqIK6dlVRk6LMo+JwBO0d4G/Q==
X-Google-Smtp-Source: ABdhPJwLY9XaqFKgJYjrtqEiHAdJ+BCmFC6M2x0Zd5NgpwhcCAVsHQlmHoBmG8QVDwp0HmaHYuKyyA==
X-Received: by 2002:a63:8f15:: with SMTP id n21mr35823079pgd.366.1620833017838;
        Wed, 12 May 2021 08:23:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1207-178.members.linode.com. [45.79.108.178])
        by smtp.gmail.com with ESMTPSA id u15sm4893693pju.44.2021.05.12.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:23:37 -0700 (PDT)
Date:   Wed, 12 May 2021 23:23:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210512152330.GA121227@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 05:39:56PM +0300, James Clark wrote:
> 
> 
> On 29/04/2021 18:00, Leo Yan wrote:
> > The dummy event is mainly used for mmap, the TIME sample is only needed
> > for per-cpu case so that the perf tool can rely on the correct timing
> > for parsing symbols.  And the CPU sample is useless for mmap.
> > 
> > This patch enables TIME sample for per-cpu mmap and doesn't enable CPU
> > sample.  For later extension (e.g. support multiple AUX events), it sets
> > the dummy event when the condition "opts->full_auxtrace" is true.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/arm64/util/arm-spe.c | 30 ++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index 902e73a64184..f6eec0900604 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -70,7 +70,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  	struct evsel *evsel, *arm_spe_evsel = NULL;
> >  	struct perf_cpu_map *cpus = evlist->core.cpus;
> >  	bool privileged = perf_event_paranoid_check(-1);
> > -	struct evsel *tracking_evsel;
> >  	int err;
> >  
> >  	sper->evlist = evlist;
> > @@ -126,18 +125,23 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  		evsel__set_sample_bit(arm_spe_evsel, CPU);
> >  
> >  	/* Add dummy event to keep tracking */
> > -	err = parse_events(evlist, "dummy:u", NULL);
> > -	if (err)
> > -		return err;
> > -
> > -	tracking_evsel = evlist__last(evlist);
> > -	evlist__set_tracking_event(evlist, tracking_evsel);
> > -
> > -	tracking_evsel->core.attr.freq = 0;
> > -	tracking_evsel->core.attr.sample_period = 1;
> > -	evsel__set_sample_bit(tracking_evsel, TIME);
> > -	evsel__set_sample_bit(tracking_evsel, CPU);
> > -	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
> > +	if (opts->full_auxtrace) {
> > +		struct evsel *tracking_evsel;
> 
> Hi Leo,
> 
> I know the "if (opts->full_auxtrace)" pattern is copied from other auxtrace
> files, but I don't think it does anything because there is this at the top
> of the function:
> 
>    	if (!opts->full_auxtrace)
> 		return 0;
> 
> The same applies for other usages of "full_auxtrace" in the same function.
> They are all always true. I'm also not sure if it's ever defined what
> full_auxtrace means.

Good pointing.  TBH, I also stuggled for handling "opts->full_auxtrace"
when wrote the patch; IIUC, "opts->full_auxtrace" is also used in
builtin-record.c to indicate if the recording contains AUX tracing.

Will follow your suggestion to respin the patch (and refine the code)
to remove the redundant condition checking for "opts->full_auxtrace".

Thanks,
Leo
