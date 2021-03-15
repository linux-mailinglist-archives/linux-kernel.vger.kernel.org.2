Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE933C9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhCOXGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233319AbhCOXFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615849551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2bzaAWjRYifKWBRlhiz7hQCoQqPTPx8RQ01jVwnjto=;
        b=iyt1vsv4TSjgzdgFZgGmjVJorus8KN6+j3TJy4bqwSuP2AWWrKVwVQ2A62SWfOB3XUhUKF
        UPZQUD/lu8i8a1N9hfT0nIB7X+3xPVYuMvP3NIPtoPHYLCcB6bRa/KKSLfvP9M6+T2hUYq
        /5Dpu5Sg07Bzq5O7nL4LhPsSxuCkgYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-kvstmTMaNDaLkPrKSopAIg-1; Mon, 15 Mar 2021 19:05:46 -0400
X-MC-Unique: kvstmTMaNDaLkPrKSopAIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 011871934101;
        Mon, 15 Mar 2021 23:05:45 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id F04FB5D9DC;
        Mon, 15 Mar 2021 23:05:42 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:05:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 10/27] perf parse-events: Create two hybrid cache
 events
Message-ID: <YE/n85ULSpgh6DRf@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-11-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-11-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:25PM +0800, Jin Yao wrote:

SNIP

> +						config_terms, pmu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int parse_events_add_cache(struct list_head *list, int *idx,
>  			   char *type, char *op_result1, char *op_result2,
>  			   struct parse_events_error *err,
> @@ -474,7 +516,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  	char name[MAX_NAME_LEN], *config_name;
>  	int cache_type = -1, cache_op = -1, cache_result = -1;
>  	char *op_result[2] = { op_result1, op_result2 };
> -	int i, n;
> +	int i, n, ret;
> +	bool hybrid;
>  
>  	/*
>  	 * No fallback - if we cannot get a clear cache type
> @@ -534,6 +577,15 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  		if (get_config_terms(head_config, &config_terms))
>  			return -ENOMEM;
>  	}
> +
> +	if (!perf_pmu__hybrid_exist())
> +		perf_pmu__scan(NULL);

actualy how about construct like:

	perf_pmu_is_hybrid()
		return hybrid_add_event_cache(...)

	return add_event(...)


with:
	perf_pmu_is_hybrid()
	{
		static bool initialized;

		if (!initialized) {
			initialized = true;
			perf_pmu__scan(NULL)
		}

		return ...
	}

jirka

> +
> +	ret = add_hybrid_cache(list, idx, &attr, config_name ? : name,
> +			       &config_terms, &hybrid);
> +	if (hybrid)
> +		return ret;
> +
>  	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
>  }
>  
> -- 
> 2.17.1
> 

