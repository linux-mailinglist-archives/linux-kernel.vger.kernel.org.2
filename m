Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE03E9434
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhHKPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232226AbhHKPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628694285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXlWIK7tP6GW7Nz9BVvMv26u0G/+ywPhUc5vj0Y0Kic=;
        b=Bw1M5PRr9eTqaa/q0Y7V7x7wWTK5ATSuaAWbfRN6ZgJ4R8f2wI9SxLHhiBVvkX1i2qMd1U
        olVilD9+gr39EL7qR1AS18TPpSc425Q7WlEeVpbZKdvwUcT8cjZIvefO+m2Z8p5BEJ0BCT
        9Z5ZS4HXz6PxBLiOw5g1Ph6OYUyTJjE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-GT3ru3X3ODOQX_r1KMiwfQ-1; Wed, 11 Aug 2021 11:04:44 -0400
X-MC-Unique: GT3ru3X3ODOQX_r1KMiwfQ-1
Received: by mail-ej1-f69.google.com with SMTP id zp23-20020a17090684f7b02905a13980d522so812602ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXlWIK7tP6GW7Nz9BVvMv26u0G/+ywPhUc5vj0Y0Kic=;
        b=Ih7gDPKf5VMVMjU0bBDvOvWB41QheY4HCp1baSoTsDvACdiISoF87ICDTT7aIGeCDx
         Wn1Sy5aMEU6kkYTmL1cLR2D9KHnNnTFgL1ub4ZHCuubsYzm4YUWkAOwPcRMwPfm22JdL
         cc5Te068mPgm++4rSHECYY9K6j4dsjoesPsu/hHK0mX4WUJ+1rLxgqJ80zN3u41z9cUc
         rJQOSjlvzKc8LSOZhyjcxyzjlT4LtEdqI0XtOm6hc8R7H0ChNjp9jN5q1dLkExNqYAE+
         Ds/k9jUsdOhPKl4g7lzZumAhkdGt7a2NxAU7OcJACny7Mp+ii3NfeZinI1GnqyrO/F6W
         CEgQ==
X-Gm-Message-State: AOAM533PHDtCdMA89DrhMivejTn3iovUWbzIOcwoUQi/eUNYlKVZGlvt
        xJsJhrXxSBMeg78JBXbAp2qqJGz9ht3Fh3JKyK5BhuWcI+k2YYjQQDFoiYeHZMCioGrz5VA79/S
        mZeB5ome31ESr3rBAb5BnfJIB
X-Received: by 2002:a17:906:3ce2:: with SMTP id d2mr4137994ejh.410.1628694283080;
        Wed, 11 Aug 2021 08:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfk0sDjUAWwO91H1b7W7tEIDVPdxP+yjS4UE4uIamE/tcg4MPnblMYVlTQIyMP0Wc9a0U6dQ==
X-Received: by 2002:a17:906:3ce2:: with SMTP id d2mr4137960ejh.410.1628694282724;
        Wed, 11 Aug 2021 08:04:42 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id dv8sm3479959ejb.93.2021.08.11.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:04:42 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:04:40 +0200
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
        Ian Rogers <irogers@google.com>, gmx@google.com
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
Message-ID: <YRPnCLyn9oE540gM@krava>
References: <20210811062135.1332927-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811062135.1332927-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:21:35PM -0700, Namhyung Kim wrote:
> Sometimes we want to know an accurate number of samples even if it's
> lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> might be shared with other events.  So it's hard to know per-event
> lost count.
> 
> Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
> retrieve it from userspace.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h      | 2 ++
>  include/uapi/linux/perf_event.h | 1 +
>  kernel/events/core.c            | 9 +++++++++
>  kernel/events/ring_buffer.c     | 5 ++++-
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f5a6a2f069ed..44d72079c77a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -756,6 +756,8 @@ struct perf_event {
>  	struct pid_namespace		*ns;
>  	u64				id;
>  
> +	atomic_t			lost_samples;
> +
>  	u64				(*clock)(void);
>  	perf_overflow_handler_t		overflow_handler;
>  	void				*overflow_handler_context;
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bf8143505c49..24397799127d 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -505,6 +505,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_LOST_SAMPLES		_IOR('$', 12, __u64 *)

would it be better to use the read syscall for that?
  https://lore.kernel.org/lkml/20210622153918.688500-5-jolsa@kernel.org/

that patchset ended up on me not having a way to reproduce the
issue you guys wanted the fix for ;-) the lost count is there
as well

jirka

>  
>  enum perf_event_ioc_flags {
>  	PERF_IOC_FLAG_GROUP		= 1U << 0,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0e125ae2fa92..a4d6736b6594 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5664,6 +5664,15 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
> +
> +	case PERF_EVENT_IOC_LOST_SAMPLES: {
> +		u64 lost = atomic_read(&event->lost_samples);
> +
> +		if (copy_to_user((void __user *)arg, &lost, sizeof(lost)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 52868716ec35..06d7dacb05da 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
>  		goto out;
>  
>  	if (unlikely(rb->paused)) {
> -		if (rb->nr_pages)
> +		if (rb->nr_pages) {
>  			local_inc(&rb->lost);
> +			atomic_inc(&event->lost_samples);
> +		}
>  		goto out;
>  	}
>  
> @@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
>  
>  fail:
>  	local_inc(&rb->lost);
> +	atomic_inc(&event->lost_samples);
>  	perf_output_put_handle(handle);
>  out:
>  	rcu_read_unlock();
> -- 
> 2.32.0.605.g8dce9f2422-goog
> 

