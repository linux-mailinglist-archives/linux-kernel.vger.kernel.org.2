Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9966407307
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhIJVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233480AbhIJVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631310154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cC740csvlGjtqhaqxin64uQXO9H37qgkcdgIxvFS3OE=;
        b=fLKYKgFaRVfkPejh2RDvp0GP/lcIvmUUPb755TqO4hF1UYifAHzzvJ7TpytMiTL8Vibbt/
        cqoEE2z1lkuT5de49cigxjDjsdJ83r/kKGvVQLBYGvVJrSPIwCtzjrx7U7Mzkr1Q/YOlkm
        oyFjH4zFOkivoXO180vaUlO9JzpG/gw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-Rjp4jAi8MTOApWaXosFDYw-1; Fri, 10 Sep 2021 17:42:33 -0400
X-MC-Unique: Rjp4jAi8MTOApWaXosFDYw-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so1669137edy.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cC740csvlGjtqhaqxin64uQXO9H37qgkcdgIxvFS3OE=;
        b=8R5T6QYXe7go/g9cokctL0trdSCyQn/yA6suTVAqUHstLDqfaw4RwG4+nzgx6D9xLx
         C/gm1M+GF8SBn3n2fTEUoiMQ0nB47Tz1eCFm1PaVYpaP+ZbQgPohrV9WOOizTNedMPLw
         Zgh30W0AZ4+BWvjeUoWT/yxjKxYsrb15LOpVw/fGXQexKVHd3uDDrnrh/8Wi1JiGvN93
         hrm3ZZEjNE8iwdP3+HtKCcKSoA/9G93NJMIj1RGOgA9tEVXUYfKS9AZSAgdiYTbJ2xhH
         IYy2N5WcvFMbqHDpn7G8OYPpam9e0qO0xZImCkx9H/DglWvkqhPrZoHmo1SvEYzN9uoz
         NRzw==
X-Gm-Message-State: AOAM530D60Uci5x7qzKVOke0v7VRr1lyfiprLgeqkS/WXt4sUyA3frWP
        pOysQuwIGmzevixY9ToyAk1DFFSzNMvne3vC31sgjPaDC6or+qPV6sKqbygm6qwFEzEDdOVq5v6
        +D7c51iWwLJ9Q8IMz4a6sAxqJ
X-Received: by 2002:aa7:cf15:: with SMTP id a21mr11145462edy.152.1631310152194;
        Fri, 10 Sep 2021 14:42:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeQ/9fS+z1sPydtTGhSQCQ+RpLkBvddJ6V8uHpRjw6HShMGW5925LRt0ZDA0DZrHwL5IT3nw==
X-Received: by 2002:aa7:cf15:: with SMTP id a21mr11145443edy.152.1631310151940;
        Fri, 10 Sep 2021 14:42:31 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id o3sm3008267eju.123.2021.09.10.14.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 14:42:31 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:42:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf/core: Add a new read format to get a number of
 lost samples
Message-ID: <YTvRNj09IwVfyZr1@krava>
References: <20210908172420.879240-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908172420.879240-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 10:24:20AM -0700, Namhyung Kim wrote:
> Sometimes we want to know an accurate number of samples even if it's
> lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> might be shared with other events.  So it's hard to know per-event
> lost count.
> 
> Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
> userspace.

hi,
looks good.. will there be some tools/perf change using this?

thanks,
jirka

> 
> Original-patch-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h      |  2 ++
>  include/uapi/linux/perf_event.h |  5 ++++-
>  kernel/events/core.c            | 22 +++++++++++++++++++---
>  kernel/events/ring_buffer.c     |  5 ++++-
>  4 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f5a6a2f069ed..189a471fba42 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -756,6 +756,8 @@ struct perf_event {
>  	struct pid_namespace		*ns;
>  	u64				id;
>  
> +	atomic64_t			lost_samples;
> +
>  	u64				(*clock)(void);
>  	perf_overflow_handler_t		overflow_handler;
>  	void				*overflow_handler_context;
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bf8143505c49..f72008949ff0 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -299,6 +299,7 @@ enum {
>   *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
>   *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
>   *	  { u64		id;           } && PERF_FORMAT_ID
> + *	  { u64		lost;         } && PERF_FORMAT_LOST
>   *	} && !PERF_FORMAT_GROUP
>   *
>   *	{ u64		nr;
> @@ -306,6 +307,7 @@ enum {
>   *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
>   *	  { u64		value;
>   *	    { u64	id;           } && PERF_FORMAT_ID
> + *	    { u64	lost;         } && PERF_FORMAT_LOST
>   *	  }		cntr[nr];
>   *	} && PERF_FORMAT_GROUP
>   * };
> @@ -315,8 +317,9 @@ enum perf_event_read_format {
>  	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
>  	PERF_FORMAT_ID				= 1U << 2,
>  	PERF_FORMAT_GROUP			= 1U << 3,
> +	PERF_FORMAT_LOST			= 1U << 4,
>  
> -	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
> +	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
>  };
>  
>  #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0e125ae2fa92..8708325ee4a2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1841,6 +1841,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
>  	if (event->attr.read_format & PERF_FORMAT_ID)
>  		entry += sizeof(u64);
>  
> +	if (event->attr.read_format & PERF_FORMAT_LOST)
> +		entry += sizeof(u64);
> +
>  	if (event->attr.read_format & PERF_FORMAT_GROUP) {
>  		nr += nr_siblings;
>  		size += sizeof(u64);
> @@ -5255,11 +5258,15 @@ static int __perf_read_group_add(struct perf_event *leader,
>  	values[n++] += perf_event_count(leader);
>  	if (read_format & PERF_FORMAT_ID)
>  		values[n++] = primary_event_id(leader);
> +	if (read_format & PERF_FORMAT_ID)
> +		values[n++] = atomic64_read(&leader->lost_samples);
>  
>  	for_each_sibling_event(sub, leader) {
>  		values[n++] += perf_event_count(sub);
>  		if (read_format & PERF_FORMAT_ID)
>  			values[n++] = primary_event_id(sub);
> +		if (read_format & PERF_FORMAT_ID)
> +			values[n++] = atomic64_read(&sub->lost_samples);
>  	}
>  
>  	raw_spin_unlock_irqrestore(&ctx->lock, flags);
> @@ -5316,7 +5323,7 @@ static int perf_read_one(struct perf_event *event,
>  				 u64 read_format, char __user *buf)
>  {
>  	u64 enabled, running;
> -	u64 values[4];
> +	u64 values[5];
>  	int n = 0;
>  
>  	values[n++] = __perf_event_read_value(event, &enabled, &running);
> @@ -5326,6 +5333,8 @@ static int perf_read_one(struct perf_event *event,
>  		values[n++] = running;
>  	if (read_format & PERF_FORMAT_ID)
>  		values[n++] = primary_event_id(event);
> +	if (read_format & PERF_FORMAT_LOST)
> +		values[n++] = atomic64_read(&event->lost_samples);
>  
>  	if (copy_to_user(buf, values, n * sizeof(u64)))
>  		return -EFAULT;
> @@ -5664,6 +5673,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -6835,7 +6845,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
>  				 u64 enabled, u64 running)
>  {
>  	u64 read_format = event->attr.read_format;
> -	u64 values[4];
> +	u64 values[5];
>  	int n = 0;
>  
>  	values[n++] = perf_event_count(event);
> @@ -6849,6 +6859,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
>  	}
>  	if (read_format & PERF_FORMAT_ID)
>  		values[n++] = primary_event_id(event);
> +	if (read_format & PERF_FORMAT_LOST)
> +		values[n++] = atomic64_read(&event->lost_samples);
>  
>  	__output_copy(handle, values, n * sizeof(u64));
>  }
> @@ -6859,7 +6871,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  {
>  	struct perf_event *leader = event->group_leader, *sub;
>  	u64 read_format = event->attr.read_format;
> -	u64 values[5];
> +	u64 values[6];
>  	int n = 0;
>  
>  	values[n++] = 1 + leader->nr_siblings;
> @@ -6877,6 +6889,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	values[n++] = perf_event_count(leader);
>  	if (read_format & PERF_FORMAT_ID)
>  		values[n++] = primary_event_id(leader);
> +	if (read_format & PERF_FORMAT_LOST)
> +		values[n++] = atomic64_read(&leader->lost_samples);
>  
>  	__output_copy(handle, values, n * sizeof(u64));
>  
> @@ -6890,6 +6904,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  		values[n++] = perf_event_count(sub);
>  		if (read_format & PERF_FORMAT_ID)
>  			values[n++] = primary_event_id(sub);
> +		if (read_format & PERF_FORMAT_LOST)
> +			values[n++] = atomic64_read(&sub->lost_samples);
>  
>  		__output_copy(handle, values, n * sizeof(u64));
>  	}
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 52868716ec35..727ca8f4caad 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
>  		goto out;
>  
>  	if (unlikely(rb->paused)) {
> -		if (rb->nr_pages)
> +		if (rb->nr_pages) {
>  			local_inc(&rb->lost);
> +			atomic64_inc(&event->lost_samples);
> +		}
>  		goto out;
>  	}
>  
> @@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
>  
>  fail:
>  	local_inc(&rb->lost);
> +	atomic64_inc(&event->lost_samples);
>  	perf_output_put_handle(handle);
>  out:
>  	rcu_read_unlock();
> -- 
> 2.33.0.309.g3052b89438-goog
> 

