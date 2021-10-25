Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A59439599
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJYMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231358AbhJYMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635163649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nl0w8I9AlZBKq0I9njUbXHd2O0PnIjEY3ACFyYyGydI=;
        b=cdp51ox0g9pQ6E1iP+iN0sW1zG7wfNpzehRKJj6Q91hZjS87nXhQOogQ07iQ8yRRZWZbxj
        YfsGIgMkvzAB5YCv0VIdC/ROLbVr0Le4WJtqaas/DhXqDXmqXodcnDcvU7X0tJMEyp2aoh
        m35EK7oeDhtgRZWGeqDJHcwR2bNRUcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-pIAc4QEfNS6FGsWu4SzsjA-1; Mon, 25 Oct 2021 08:07:28 -0400
X-MC-Unique: pIAc4QEfNS6FGsWu4SzsjA-1
Received: by mail-wm1-f72.google.com with SMTP id b81-20020a1c8054000000b0032c9d428b7fso3427999wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nl0w8I9AlZBKq0I9njUbXHd2O0PnIjEY3ACFyYyGydI=;
        b=D6AXEJt1hYeE4xNobeYEJQZh3zbo0rVfmEaU2yaFmwtU3VqEX4qbd6Mw2CGKSlJ2zT
         +mGpunovjN1KuOLsVo5m6FDSF38lHyhDHlEeh+pBYrHLluMUcawcdiA9S4fL+7eT9CbE
         NN20VTlaRytekTKmzDEMCw/5LMfCXl9Ky2cj2pRa9rorXS4eZhYqn7sTWx0t8WI7wnsQ
         FFGm4HQldbRg/r2fjGKrOwFBLi7K2/KmwaNKnlBkMjXla9rBwhqxtP70n0KVsIwx6NBH
         2crwhsrVHVT4LrKqoUXpahuBEmO7xjentc6IVSv+EAh8OuB2rO31jnuevCjlkZWfEczN
         gAPw==
X-Gm-Message-State: AOAM533uaZIHy8JbI9CjZX1xThMcOZtKZINOZKGMGWVR08IPvfwlxVv6
        +G+seT59XHjCseSdSqRobpGhHPRO1EjGi2lVzivAGsHGBUFoqIeoJl+8NMoe7V2PjQcyFHVamws
        mNwjy/Gr4yCYqfhb6Gc8eTIKn
X-Received: by 2002:a5d:6103:: with SMTP id v3mr20098357wrt.335.1635163646885;
        Mon, 25 Oct 2021 05:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFJ7TRl+UH7eiXkXjlODLxI1Td28WXGUVdiR877bkjXKnx4fNQ3RMylMxPs2901WbbeUgtaA==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr20098308wrt.335.1635163646504;
        Mon, 25 Oct 2021 05:07:26 -0700 (PDT)
Received: from krava (ip4-95-82-160-78.cust.nbox.cz. [95.82.160.78])
        by smtp.gmail.com with ESMTPSA id r4sm6945656wrp.26.2021.10.25.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:07:26 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:07:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     acme@kernel.org, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
Message-ID: <YXad+y2VCyC6y+CE@krava>
References: <20211016125059.691856-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016125059.691856-1-maddy@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan wrote:
> branch_stack struct has bit field definition which
> produces different bit ordering for big/little endian.
> Because of this, when branch_stack sample is collected
> in a BE system and viewed/reported in a LE system, bit
> fields of the branch stack are not presented properly.
> To address this issue, a evsel__bitfield_swap_branch_stack()
> is defined and introduced in evsel__parse_sample.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>

for both patches

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> Changelog v1:
> - Renamed function and macro
> - Added comments in code
> 
>  tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evsel.h | 13 ++++++++
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..746e642d4d32 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>  	data->weight = *array;
>  }
>  
> +u64 evsel__bitfield_swap_branch_flags(u64 value)
> +{
> +	u64 new_val = 0;
> +
> +	/*
> +	 * branch_flags
> +	 * union {
> +	 * 	u64 values;
> +	 * 	struct {
> +	 * 		mispred:1	//target mispredicted
> +	 * 		predicted:1	//target predicted
> +	 * 		in_tx:1		//in transaction
> +	 * 		abort:1		//transaction abort
> +	 * 		cycles:16	//cycle count to last branch
> +	 * 		type:4		//branch type
> +	 * 		reserved:40
> +	 * 	}
> +	 * }
> +	 *
> +	 * Avoid bswap64() the entire branch_flag.value,
> +	 * as it has variable bit-field sizes. Instead the
> +	 * macro takes the bit-field position/size,
> +	 * swaps it based on the host endianness.
> +	 */
> +	if (bigendian()) {
> +		new_val = bitfield_swap(value, 0, 1);
> +		new_val |= bitfield_swap(value, 1, 1);
> +		new_val |= bitfield_swap(value, 2, 1);
> +		new_val |= bitfield_swap(value, 3, 1);
> +		new_val |= bitfield_swap(value, 4, 16);
> +		new_val |= bitfield_swap(value, 20, 4);
> +		new_val |= bitfield_swap(value, 24, 40);
> +	} else {
> +		new_val = bitfield_swap(value, 63, 1);
> +		new_val |= bitfield_swap(value, 62, 1);
> +		new_val |= bitfield_swap(value, 61, 1);
> +		new_val |= bitfield_swap(value, 60, 1);
> +		new_val |= bitfield_swap(value, 44, 16);
> +		new_val |= bitfield_swap(value, 40, 4);
> +		new_val |= bitfield_swap(value, 0, 40);
> +	}
> +
> +	return new_val;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		const u64 max_branch_nr = UINT64_MAX /
>  					  sizeof(struct branch_entry);
> +		struct branch_entry *e;
> +		unsigned int i;
>  
>  		OVERFLOW_CHECK_u64(array);
>  		data->branch_stack = (struct branch_stack *)array++;
> @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			return -EFAULT;
>  
>  		sz = data->branch_stack->nr * sizeof(struct branch_entry);
> -		if (evsel__has_branch_hw_idx(evsel))
> +		if (evsel__has_branch_hw_idx(evsel)) {
>  			sz += sizeof(u64);
> -		else
> +			e = &data->branch_stack->entries[0];
> +		} else {
>  			data->no_hw_idx = true;
> +			/*
> +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
> +			 * only nr and entries[] will be output by kernel.
> +			 */
> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
> +		}
> +
> +		if (swapped) {
> +			/*
> +			 * struct branch_flag does not have endian
> +			 * specific bit field definition. And bswap
> +			 * will not resolve the issue, since these
> +			 * are bit fields.
> +			 *
> +			 * evsel__bitfield_swap_branch_flags() uses a
> +			 * bitfield_swap macro to swap the bit position
> +			 * based on the host endians.
> +			 */
> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
> +				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
> +		}
> +
>  		OVERFLOW_CHECK(array, sz, max_size);
>  		array = (void *)array + sz;
>  	}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..2e82cdbe2c08 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> +
> +/*
> + * Macro to swap the bit-field postition and size.
> + * Used when,
> + * - dont need to swap the entire u64 &&
> + * - when u64 has variable bit-field sizes &&
> + * - when presented in a host endian which is different
> + *   than the source endian of the perf.data file
> + */
> +#define bitfield_swap(src, pos, size)	\
> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
> +
> +u64 evsel__bitfield_swap_branch_flags(u64 value);
>  #endif /* __PERF_EVSEL_H */
> -- 
> 2.31.1
> 

