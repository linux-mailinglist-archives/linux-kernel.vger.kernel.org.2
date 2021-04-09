Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B635A042
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhDINsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDINs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0T7nOwo7A7O9dIajRRU8iqCCCr6EE8xHM+na2uWLfo=;
        b=euMm1vYzdIAC/MIVRUAvLT2eNKw97cE4k4iEUJZ/ljFHyJN9+WbmkveGJ5/UEtznj+RXeN
        WVeh27094NGB089mHC+El7UXUS6e2kIfOdwCv0EIpZArsmSa8obyEjAMm56ZHmpL9l0lgU
        +JxR7Hqx97lN4Z5Mh3J0qUO12R+nINQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-9TqmTMsyOKOiJtyAY5Za8w-1; Fri, 09 Apr 2021 09:48:10 -0400
X-MC-Unique: 9TqmTMsyOKOiJtyAY5Za8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9621D189C440;
        Fri,  9 Apr 2021 13:48:09 +0000 (UTC)
Received: from krava (unknown [10.40.195.216])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB1A85C3E0;
        Fri,  9 Apr 2021 13:48:05 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:48:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 09/27] perf parse-events: Create two hybrid cache
 events
Message-ID: <YHBa820crfHSIZuz@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-10-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329070046.8815-10-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:00:28PM +0800, Jin Yao wrote:

SNIP

> index 1bbd0ba92ba7..3692fa3c964a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -458,6 +458,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  	int cache_type = -1, cache_op = -1, cache_result = -1;
>  	char *op_result[2] = { op_result1, op_result2 };
>  	int i, n;
> +	bool hybrid;
>  
>  	/*
>  	 * No fallback - if we cannot get a clear cache type
> @@ -517,6 +518,13 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  		if (get_config_terms(head_config, &config_terms))
>  			return -ENOMEM;
>  	}
> +
> +	i = parse_events__add_cache_hybrid(list, idx, &attr,
> +					   config_name ? : name, &config_terms,
> +					   &hybrid);
> +	if (hybrid)
> +		return i;

please define 'ret' for the return value, i is confusing

thanks,
jirka

> +
>  	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
>  }
>  
> -- 
> 2.17.1
> 

