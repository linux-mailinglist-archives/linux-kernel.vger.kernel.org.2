Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE430C620
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhBBQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhBBQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:37:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F87C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:37:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y10so8521587plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/72mQgdgH81UuQ9TTi1aDnT/R7XmFqG2OTYnlG9Pnd8=;
        b=POMP6W3hBpsCuAvbe51MMqifOOfdLvYWHzFesBAm7vk2twL9wUX/fNNskzd4mGSKUm
         iywN49fuwavxDSvin4O8UumaNW8rxLYW+IdcSc1J9MWTg4z//n9YDjCFPWxviHzBykTF
         sIOIYQ8ICjL+4wlH7n9q+9mKC6lA/FuQWRFsDoXnYsOSStkhiRQbfRw/XuWCluvalOYz
         SVleP0eeHc5PXoy/ozeah7xUFzVevJ+uG5FJEIFIbHy2mIAOHj8T0lMobOXaqWhN+W/h
         e1dJUZWeYm69WOiylsjXvTumeMF3V6E8Ui4oJ7nlTOcUtKheC59RSK2rVp5nYxGv+gVf
         UHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/72mQgdgH81UuQ9TTi1aDnT/R7XmFqG2OTYnlG9Pnd8=;
        b=KZU9POzquBcUcwC7QZu9H+tiVGNqPtws/okH93dVw6LUBVT4uSyqrp7CdPWl/6YAkB
         o1lj3ub9Do5s62KxXuFLnAQcZsde7OHgQft2wxvMwrF+IUBJqWSetLqUQb7rWpKhUfTo
         UtHpnCvznSQxaSw1xK6buSVMzOyc5XnSEoxI3VLNkmd4vW/kUlPkfyFGcwBWhIRJZ1jj
         6cB/D3l8CFY/VWviiID74AQcjDGZbP0Lp0EhDb5keJXmj4GtaOVVeszi3ygR2gl3lclg
         KzL/D8ioXLoTUkGRchKfoLAlxYsL56g2CRVQQFHHCKUqK97FylLOvoZ+G9C7lIkXU9bJ
         vXeA==
X-Gm-Message-State: AOAM530GY/yJJl+Q7tWFQ/s4XN1xxAt4E8SmeRaxbfIu9qz1HdU+ZG6g
        6NOhuBvS/2QAQEgL/TWxnMu2ww==
X-Google-Smtp-Source: ABdhPJw0w/kB1Xl+9H8+7lFZirqhSkyu2NhGBQDAdv9ijp2pUmPX1yoVslkSm71paBXsA2I/oLUQKg==
X-Received: by 2002:a17:902:ecc9:b029:df:c993:5f12 with SMTP id a9-20020a170902ecc9b02900dfc9935f12mr22877154plh.82.1612283825317;
        Tue, 02 Feb 2021 08:37:05 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j123sm23727696pfg.36.2021.02.02.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:37:04 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:37:03 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/14] coresight: etm-perf: Allow an event to use
 different sinks
Message-ID: <20210202163703.GA1536093@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
 <20210201231720.GB1475392@xps15>
 <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:42:34AM +0000, Suzuki K Poulose wrote:
> On 2/1/21 11:17 PM, Mathieu Poirier wrote:
> > Hi Anshuman,
> > 
> > I have started reviewing this set.  As it is quite voluminous comments will
> > come over serveral days.  I will let you know when I am done.
> > 
> > On Wed, Jan 27, 2021 at 02:25:25PM +0530, Anshuman Khandual wrote:
> > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > When there are multiple sinks on the system, in the absence
> > > of a specified sink, it is quite possible that a default sink
> > > for an ETM could be different from that of another ETM. However
> > > we do not support having multiple sinks for an event yet. This
> > > patch allows the event to use the default sinks on the ETMs
> > > where they are scheduled as long as the sinks are of the same
> > > type.
> > > 
> > > e.g, if we have 1x1 topology with per-CPU ETRs, the event can
> > > use the per-CPU ETR for the session. However, if the sinks
> > > are of different type, e.g TMC-ETR on one and a custom sink
> > > on another, the event will only trace on the first detected
> > > sink.
> > > 
> > 
> > I found the above changelog very confusing - I read it several times and still
> > couldn't get all of it.  In the end this patch prevents sinks of different types
> > from being used for session, and this is what the text should reflect.
> 
> Sorry about that. Your inference is correct, but it is only a side effect
> of the primary motive. How about the following :
> 
> "When a sink is not specified by the user, the etm perf driver
> finds a suitable sink automatically based on the first ETM, where
> this event could be scheduled. Then we allocate the sink buffer based
> on the selected sink. This is fine for a CPU bound event as the "sink"
> is always guaranteed to be reachable from the ETM (as this is the only
> ETM where the event is going to be scheduled). However, if we have a task
> bound event, the event could be scheduled on any of the ETMs on the
> system. In this case, currently we automatically select a sink and exclude
> any ETMs that are not reachable from the selected sink. This is
> problematic for 1x1 configurations as we end up in tracing the event
> only on the "first" ETM, as the default sink is local to the first
> ETM and unreachable from the rest.
> However, we could allow the other ETMs to trace if they all have a
> sink that is compatible with the "selected" sink and can use the
> sink buffer. This can be easily done by verifying that they are
> all driven by the same driver and matches the same subtype."
>

Much better, thanks for the rework.
 
> 
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Tested-by: Linu Cherian <lcherian@marvell.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm-perf.c | 48 +++++++++++++++++++-----
> > >   1 file changed, 38 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > index bdc34ca..eb9e7e9 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > @@ -204,6 +204,13 @@ static void etm_free_aux(void *data)
> > >   	schedule_work(&event_data->work);
> > >   }
> > > +static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
> > > +{
> > > +	if (!a || !b)
> > > +		return false;
> > > +	return (sink_ops(a) == sink_ops(b));
> > 
> > Yes
> 
> I think we can tighten this by verifying the dev->sub_type matches too.
> 

We could do that but I'm not sure we need to.  I remember spending a few minutes
yesterday thinking about ways to make the test more stringent but in the end I
thought what you had was sufficient, at least for now.  I'll leave that one to
you - proceed as you see fit. 

> > 
> > > +}
> > > +
> > >   static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >   			   int nr_pages, bool overwrite)
> > >   {
> > > @@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >   	cpumask_t *mask;
> > >   	struct coresight_device *sink = NULL;
> > 
> >          struct coresight_device *user_sink = NULL;
> > 
> > >   	struct etm_event_data *event_data = NULL;
> > > +	bool sink_forced = false;
> > >   	event_data = alloc_event_data(cpu);
> > >   	if (!event_data)
> > > @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >   	if (event->attr.config2) {
> > >   		id = (u32)event->attr.config2;
> > >   		sink = coresight_get_sink_by_id(id);
> > 
> >                  user_sink = coresight_get_sink_by_id(id);
> > 
> > > +		sink_forced = true;
> > >   	}
> > >   	mask = &event_data->mask;
> > > @@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >   	 */
> > >   	for_each_cpu(cpu, mask) {
> > >   		struct list_head *path;
> > > -		struct coresight_device *csdev;
> > 
> >                  struct coresight_device *last_sink = NULL;
> > 
> > > +		struct coresight_device *csdev, *new_sink;
> > >   		csdev = per_cpu(csdev_src, cpu);
> > >   		/*
> > > @@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >   		}
> > >   		/*
> > > -		 * No sink provided - look for a default sink for one of the
> > > -		 * devices. At present we only support topology where all CPUs
> > > -		 * use the same sink [N:1], so only need to find one sink. The
> > > -		 * coresight_build_path later will remove any CPU that does not
> > > -		 * attach to the sink, or if we have not found a sink.
> > > +		 * No sink provided - look for a default sink for all the devices.
> > > +		 * We only support multiple sinks, only if all the default sinks
> > > +		 * are of the same type, so that the sink buffer can be shared
> > > +		 * as the event moves around. We don't trace on a CPU if it can't
> > 
> > s/can't/can't./
> > 
> > > +		 *
> > 
> > Extra line
> > 
> 
> OK
> 
> > >   		 */
> > > -		if (!sink)
> > > -			sink = coresight_find_default_sink(csdev);
> > > +		if (!sink_forced) {
> > > +			new_sink = coresight_find_default_sink(csdev);
> > > +			if (!new_sink) {
> > > +				cpumask_clear_cpu(cpu, mask);
> > > +				continue;
> > > +			}
> > > +			/* Skip checks for the first sink */
> > > +			if (!sink) {
> > > +			       sink = new_sink;
> > > +			} else if (!sinks_match(new_sink, sink)) {
> > > +				cpumask_clear_cpu(cpu, mask);
> > > +				continue;
> > > +			}
> > > +		} else {
> > > +			new_sink = sink;
> > > +		}
> > 
> >                  if (!user_sink) {
> >                          /* find default sink for this CPU */
> >                          sink = coresight_find_default_sink(csdev);
> >                          if (!sink) {
> >                                  cpumask_clear_cpu(cpu, mask);
> >                                  continue;
> >                          }
> > 
> >                          /* Chech new sink with last sink */
> >                          if (last_sink && !sink_match(last_sink, sink)) {
> >                                  cpumask_clear_cpu(cpu, mask);
> >                                  continue;
> >                          }
> > 
> >                          last_sink = sink;
> >                  } else {
> >                          sink = user_sink;
> >                  }
> > 
> 
> Agreed, it is much better readable.
> 
> Suzuki
