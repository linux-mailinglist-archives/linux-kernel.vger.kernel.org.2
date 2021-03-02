Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B632A5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383935AbhCBM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbhCBMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:01:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AEEC0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 03:52:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so1829596pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 03:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jS/yNjTT+4Rh8VisNK8589KsF0b2cWlOgbxLl/gSO0o=;
        b=Nx5y6FYyh0EDQNw9fG02IqVUwHo0WCcb+XCH38lrSNtpBX8V5DWRqnSHWIcgfoFrYI
         GOku0UybiUhEbdwXGN1AlSxqbuAOhThk0aSHHErBfa4EaHnikFKf9NDgPTuFjtXeUQXa
         Be5zKtw0tbM+Z91F1HK00Tfry4CyuAtzEcjvoqsH1k9VVxdQ8vP6VaGa+uWDXi7GS9EU
         jxSkbnaX1gvSp2mPOpcqAmZT8Lv/jlYMwqqC1+jUxjAx0kUJa7I43QwTYfIA7OafpLMe
         yjcXgoF0VNqcnjaVobjRyKTvfL75NonsT7eVkoGOtTXgzxErNiBMqtH/J1pr2fsMQXpt
         4DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jS/yNjTT+4Rh8VisNK8589KsF0b2cWlOgbxLl/gSO0o=;
        b=saWQpwlQXCr1wUHboeadCDrXawk1w48CNbeqi+lk64G1cSBJpFFxO7X+mXgy/dx44F
         uZ8ixb2fFhmcU6+YO+y8hcRm7zMUbfE19uBEka018jQyfavF/w9J20oDtYTgMlV57MAh
         c1yhRfysJoB0xxBAZQc3T4shJDb9Lut+3o7/VbIW2VmGOA2pbfNT9gZeWC5XNUYhGlje
         dIGRk3z5lby4Hurg/M8hAX+UxVgXko+WmlFG0foDOfzLLK2xBne4IZYhxp1E6LWQEXwL
         DwuSnq97typ0NWLcKHIkKTEJzNcBxqIoSjkgbsL3uJuQs7+7rS9mh6jskQlUd1sL7Nyp
         xiyA==
X-Gm-Message-State: AOAM532sheeHKOx27zTyHP0qPMWvMInAW9EtZzCiCWS6/gEV7KX1hPIO
        g4brXx5X4+TwOmnrYGxt7frwVw==
X-Google-Smtp-Source: ABdhPJyHN0tjCHl3wShY/GHni4ZJ7o2Wdl40kGpW+Mu3HSqYhhbLu5mGQslgVRYuZXdHr7hcsezr7A==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr3941422pjh.29.1614685949958;
        Tue, 02 Mar 2021 03:52:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.153])
        by smtp.gmail.com with ESMTPSA id q23sm21062048pfn.213.2021.03.02.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 03:52:29 -0800 (PST)
Date:   Tue, 2 Mar 2021 19:52:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] perf cs-etm: Only search timestamp in current
 sample's queue.
Message-ID: <20210302115222.GA30731@leoy-ThinkPad-X240s>
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-3-james.clark@arm.com>
 <20210220115019.GB3824@leoy-ThinkPad-X240s>
 <d9c4c2a0-9137-5015-60f3-ca7b502baaf2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c4c2a0-9137-5015-60f3-ca7b502baaf2@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:28:57PM +0200, James Clark wrote:
> 
> 
> On 20/02/2021 13:50, Leo Yan wrote:
> > On Fri, Feb 12, 2021 at 04:45:08PM +0200, James Clark wrote:
> >> Change initial timestamp search to only operate on the queue
> >> related to the current event. In a later change the bounds
> >> of the aux record will also be used to reset the decoder and
> >> the record is only relevant to a single queue.
> > 
> > I roughly understand this patch tries to establish the mechanism for
> > timstamp search per CPU, but I am struggling to understand what's issue
> > you try to address.
> > 
> > So could you give more description for "what's current issue?" and
> > "why need to use this way to fix the issue?".  This would be very
> > appreciated.
> 
> Hi Leo,
> 
> The issue is that the aux records used to reset the decoder are associated
> with a specific CPU/aux queue. Currently when any new data is received, all
> queues are searched for a timestamp. We can't do it that way any more because
> the aux records aren't available yet.
> 
> The reason to fix it this way is because now we can only do decode when
> an aux record is received. This will happen multiple times, and will also
> be cpu/queue specific.

Okay, I think you are try to establish the logic as below:

- Step 1: Wait for PERF_RECORD_AUX event;
- Step 2: Receive PERF_RECORD_AUX event, knows the aux buffer
  offset and size;
- Step 3: Update the auxtrace queue based on the info from
  PERF_RECORD_AUX event;
- Step 4: Find the first trace for timestamp, drop any trace data
  prior to the timestamp;
- Step 5: Conintue to decode the trace data which is contained in the
  current PERF_RECORD_AUX event;
- Step 6: Finish the decoding and goto step1.

> > 
> >> This change makes some files that had coresight data
> >> but didn't syntesise any events start working and generating
> >> events. I'm not sure of the reason for that. I'd expect this
> >> change to only affect the ordering of events.
> > 
> > This seems to me that this patch introduces regression.
> 
> I'm wondering if it is a regression, or accidentally fixing a bug.
> It doesn't seem like it's possible to go from not generating any samples to
> generating lots without accidentally fixing an existing issue. If there is
> valid data there, what would be stopping it from generating any samples?

I think we need to clarify what's the current code logic:

- Step 1: at beginning, only prepare for auxtrace queues, for N:1
  model (all ETMs use the same sink), there have only one queue; for
  1:1 model (one ETM has its own sink), there have multiple queues.

  The function cs_etm__update_queues() is for this step, it doesn't
  generate any sample and only prepare for the first timestamp so
  later the sampels can be compared with each other for the trace data
  coming from multiple CPUs.

- Step 2: it starts to decode the trace data and synthesize samples,
  this is finished by function cs_etm__process_queues().

Seems to me, now we need to fix the issue in step2, in step2, it
decodes the whole AUX buffer, so the main target is to limit the
decoding length, which should base on the info provided by
PERF_RECORD_AUX event.

IIUC, now you are trying to fix issue in step 1, but step 1 is not the
root cause for the issue.

> I do need to look into this more closely though to find the real reason for
> it, which will probably shed more light on it.
> 
> > 
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/util/cs-etm.c | 30 ++++++++++++++----------------
> >>  1 file changed, 14 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> >> index 27894facae5e..8f8b448632fb 100644
> >> --- a/tools/perf/util/cs-etm.c
> >> +++ b/tools/perf/util/cs-etm.c
> >> @@ -97,7 +97,7 @@ struct cs_etm_queue {
> >>  /* RB tree for quick conversion between traceID and metadata pointers */
> >>  static struct intlist *traceid_list;
> >>  
> >> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
> >> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
> >>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
> >>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
> >>  					   pid_t tid);
> >> @@ -524,7 +524,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
> >>  static int cs_etm__flush_events(struct perf_session *session,
> >>  				struct perf_tool *tool)
> >>  {
> >> -	int ret;
> >>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> >>  						   struct cs_etm_auxtrace,
> >>  						   auxtrace);
> >> @@ -534,11 +533,6 @@ static int cs_etm__flush_events(struct perf_session *session,
> >>  	if (!tool->ordered_events)
> >>  		return -EINVAL;
> >>  
> >> -	ret = cs_etm__update_queues(etm);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> > 
> > When flush events, it means the trace data is discontinuous or at the
> > end of trace data.  If the trace data is discontinuous, we need to use
> > cs_etm__update_queues() to create new queues.  So if we remove the
> > calling cs_etm__update_queues(), I suspect it cannot handle the
> > discontinuous trace data anymore.
> 
> Do you know how to force perf to record data like this? From my experience
> etm->queues.new_data is only set once when the file is first opened.

Maybe can try the snapshot mode, which you can capture multiple times
for the snapshot trace data based on the signals.

Please check the test case [1] for how to use snapshot mode.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/tests/shell/test_arm_coresight.sh#n157

> > 
> >>  	if (etm->timeless_decoding)
> >>  		return cs_etm__process_timeless_queues(etm, -1);
> >>  
> >> @@ -851,10 +845,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> >>  	etmq->queue_nr = queue_nr;
> >>  	etmq->offset = 0;
> >>  
> >> -	if (etm->timeless_decoding)
> >> -		return 0;
> >> -	else
> >> -		return cs_etm__search_first_timestamp(etmq);
> >> +	return 0;
> >>  }
> >>  
> >>  static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
> >> @@ -874,14 +865,20 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
> >>  	return 0;
> >>  }
> >>  
> >> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
> >> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
> >>  {
> >> +	int ret;
> >>  	if (etm->queues.new_data) {
> >>  		etm->queues.new_data = false;
> >> -		return cs_etm__setup_queues(etm);
> >> +		ret = cs_etm__setup_queues(etm);
> > 
> > Just remind, the new parameter "cpu" is introduced in this function,
> > in theory, cs_etm__update_queues() should work for the specified CPU.
> > But it always setup queues for all CPUs with calling
> > cs_etm__setup_queues().
> > 
> >> +		if (ret)
> >> +			return ret;
> >>  	}
> >>  
> >> -	return 0;
> >> +	if (!etm->timeless_decoding)
> >> +		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
> >> +	else
> >> +		return 0;
> > 
> > In the original code of cs_etm__update_queues(), if there have no any
> > new data (or has already setup queues), then it does nothing and
> > directly bails out.
> > 
> > After applied the up change, it will always search the first timestamp
> > for the "cpu".
> > 
> 
> Maybe I need to pull my later change into here that makes it skip the search after
> the timestamp is found for the first time. What do you think?

The patches ordering is important for understanding the changes, but let's
firstly sync for the brief direction for the fixing.

> >>  }
> >>  
> >>  static inline
> >> @@ -2358,8 +2355,9 @@ static int cs_etm__process_event(struct perf_session *session,
> >>  	else
> >>  		timestamp = 0;
> >>  
> >> -	if (timestamp || etm->timeless_decoding) {
> >> -		err = cs_etm__update_queues(etm);
> >> +	if ((timestamp || etm->timeless_decoding)
> >> +			&& event->header.type == PERF_RECORD_AUX) {
> >> +		err = cs_etm__update_queues(etm, sample->cpu);
> > 
> > Here might cause potential issue.  Let's see an example:
> > 
> > If CoreSight uses N:1 model for tracers and sink (just like multiple
> > ETMs output trace to the same ETR), when "sample->cpu" is 0, it will
> > only initialize the timestamp for CPU 0.  In the same AUX trace data,
> > it can contains trace for CPU 1, 2, etc; for this case, the flow
> > doesn't prepare the timestamp for CPU1/2, so it will fail to generate
> > samples for CPU 1/2, right?
> 
> If there is only one sink then wouldn't there also only be only one aux queue
> and aux records generated for one CPU? I thought each channel in the data
> corresponded to a cs_etm_traceid_queue and that is how multiple tracers worked?

If has only one sink, multiple CPUs trace data will finally be
recorded into the single AUX buffer with only one queue.

> But the channel corresponds to a thread rather than a CPU because the struct
> looks like this:
> 
>     struct cs_etm_traceid_queue {
> 	    u8 trace_chan_id;
> 	    pid_t pid, tid;
>             ...

Please note, IIUC, struct cs_etm_traceid_queue is used to track specific info
for every CPU, when the decoder decodes the trace data, it can
generate the "trace_chan_id" rather than the CPU ID, it needs to find the
corresponding aux trace queue based on "trace_chan_id", so this is why it
records "trace_chan_id" in the structure cs_etm_traceid_queue.

@Mathiue, is best knowing for this, please corrent me if I make
any mistake at here.

> There is currently an issue with per-thread mode where AUX events don't have the
> CPU ID set and I've assumed CPU 0 which is incorrect. Maybe that is related to
> your potential issue as well.

please refer the function cs_etm__get_cpu(), it converts "trace_chan_id" to
the CPU number.

Thanks,
Leo
