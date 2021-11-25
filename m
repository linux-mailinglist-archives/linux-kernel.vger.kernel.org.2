Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076045DA28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352756AbhKYMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbhKYMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:37:36 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B2C06175D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:31:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b68so5773184pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxxRmY1avsvh6dVkHZJ0dbIbMG7eaT3D29WZ6XTQGMs=;
        b=JPWtHFwlPnlpUr3V/uXoLYvEvb1FSiBRFURrSZ6rQTizm+1BC+SRUOhK+I46O9QwLo
         M5gV5xZoZnA+4ROQZAa91s0taIZDwrMrPgi5XSDVc8BkfBFa/cLRBkj3F5tsuqY4mnT2
         aVYvggaaRT4cNJfuQ1lrshfhq/COInHmAWQrpqgsQYPtbtsKXWeMj2O6SDfAywoqT4P2
         wqURwsrukniCuS5RP9Hq+7Ycb9RIPUZYhIlS7AXQlk2zKfl/dgf0WUmSEK4HYuPAdMMN
         AT3mKc5n+wzoPzvpCewKtuNqYpGIExJD4Nu1jUahx5ThOQxWbe3RX4VbnoPFjLPNg6S8
         qV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxxRmY1avsvh6dVkHZJ0dbIbMG7eaT3D29WZ6XTQGMs=;
        b=jAJygi2EOIqyWhsVwcX8nVernUtlPC0rdJmYJ0WmdNLnqo+mtz/UqHIFfEfA7Ez8v0
         hwQlSvq+xbuTfBqqiRZ2NQNivqY9YtIcO16ckU3O7yLbua+aJBkQm5zzqsLYxVEtlaoe
         T5n+tqVrUJ9fsHWSpYGTlt1ZaErdZJOGSZO+aA8ar/eubYzIO0evNbT/Uvlx60a1UhI2
         FyYFeLobJYUESxy3e7aB7RykLV7dWn2YqI5Tru/8rqD+UYBGsf6uKwaQyMJ0GICsdUs1
         nEyN+2lJRClO9OfGEZZP6V+AAZW3olST9Yimtva0iRJvcIxrh3l278mek5F24mItYYSw
         p6mQ==
X-Gm-Message-State: AOAM533tMASI9Iw6byR4XljL2JteTq5+aHzaggL/wcplXgI25Cv53DFW
        ErYd4BBGdlM1DegpXefgrT6sCA==
X-Google-Smtp-Source: ABdhPJwQ4psZYW/HCtjGYY7kSbXNJVPF5eF6TJ9jiqCaiirse0B+1fNkkGePy0pzM01h5vKljnBYJg==
X-Received: by 2002:a63:e04f:: with SMTP id n15mr16336706pgj.31.1637843465170;
        Thu, 25 Nov 2021 04:31:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.248])
        by smtp.gmail.com with ESMTPSA id g7sm3395196pfv.159.2021.11.25.04.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:31:00 -0800 (PST)
Date:   Thu, 25 Nov 2021 20:30:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 1/1] perf arm-spe: report all SPE records as "all"
 events
Message-ID: <20211125123053.GB1599216@leoy-ThinkPad-X240s>
References: <20211117142833.226629-1-german.gomez@arm.com>
 <20211125075358.GA1599216@leoy-ThinkPad-X240s>
 <12d44d96-1fcd-1fdd-64ea-beef40a27d1d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d44d96-1fcd-1fdd-64ea-beef40a27d1d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:21:48AM +0000, James Clark wrote:
> On 25/11/2021 07:53, Leo Yan wrote:

[...]

> >> +static int arm_spe__synth_other_sample(struct arm_spe_queue *speq,
> >> +				       u64 spe_events_id)
> >> +{
> >> +	struct arm_spe *spe = speq->spe;
> >> +	struct arm_spe_record *record = &speq->decoder->record;
> >> +	union perf_event *event = speq->event_buf;
> >> +	struct perf_sample sample = { .ip = 0, };
> >> +
> >> +	arm_spe_prep_sample(spe, speq, event, &sample);
> >> +
> >> +	sample.id = spe_events_id;
> >> +	sample.stream_id = spe_events_id;
> >> +	sample.addr = record->to_ip;
> > 
> > After checked the event types, I think "other" samples would include
> > below raw event types:
> 
> Maybe we should rename some of the functions and variables if there is
> confusion, but I think this new group is "all" rather than "other" because
> it also includes all the events that would be put in other groups.
> 
> > 
> >   EV_EXCEPTION_GEN
> >   EV_RETIRED
> >   EV_NOT_TAKEN
> >   EV_ALIGNMENT
> >   EV_PARTIAL_PREDICATE
> >   EV_EMPTY_PREDICATE
> > 
> > I am just wander if we can use sample.transaction to store these event
> > types, otherwise, we cannot distinguish the event type for the samples.
> 
> If we can use the transaction field to distinguish sample types, I'm
> wondering why we need the separate groups at all. If this new group
> includes all sample types, and they're all labelled, do we need to
> continue with the other groups like "tlb-access" and "branch-miss"?

I admit the samples for "tlb-access" and "branch-miss" might not a
good practice.  At the time when I was upstreaming the Arm SPE patches
(mainly based Hisilicon patches), the main idea for use some events to
output samples, this is why "tlb-access" and "branch-miss" events were
introduced.

But when worked on Arm SPE for enabling "perf mem" and "perf c2c", I
recognized that _consuming_ hardware trace data is much more important
than merely outputting samples.  A better way for _consuming_ the Arm SPE
trace data is to synthesize samples with a prominent type and use an
extra field in sample for the associated attribution.  E.g. we can
synthesize memory samples and uses field "sample.data_src" to
distinguish different memory attributions, thus the events
"tlb-access" and "branch-miss" are not useful.  This approach can be
applied to instruction event and branch event, and both of them use
field "sample.flags" to indicate what's the type of instruction or
branch.

If we follow up this approach, below records can be considered to
synthesize instruction or branch samples:

  EV_EXCEPTION_GEN
  EV_RETIRED
  EV_NOT_TAKEN

Below records can be considered to generate memory samples:

  EV_ALIGNMENT
  EV_PARTIAL_PREDICATE
  EV_EMPTY_PREDICATE

We can consider to extend sample's three fields:
sample::flags for instruction/branch samples
sample::data_srouce for memory samples
sample::transaction for memory transactions (see macros with
prefix PERF_TXN_).

> Or does the perf GUI not allow filtering by transaction type?

To be honest, when introduced the events "tlb-access" and
"branch-miss", I didn't consider transaction type at all.

Thanks,
Leo
