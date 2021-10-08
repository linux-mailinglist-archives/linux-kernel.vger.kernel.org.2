Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4054B426548
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJHHf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhJHHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633678441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O515ri/uV19LTvFhGL3lF3UGBzNdh3Gbb9rWE3lfUS8=;
        b=iZJYDZZuD49woXTFR+3zpJkaoehW8IezzfiyLLN17s3NgJBPRMfLXpxZSbbvd1jVry/jit
        OTvb7ZUPXJA8X7a6CMAP8VcQn8CP5QI5LRru5SkkxpKcvlx1tDJSajPTqrtFGqFE+5YEq1
        czYipy2HNF1c1QDaYM87EnRnUdLdeLs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-4v3EZKSiPFOR3m3cuvSSrQ-1; Fri, 08 Oct 2021 03:34:00 -0400
X-MC-Unique: 4v3EZKSiPFOR3m3cuvSSrQ-1
Received: by mail-wr1-f71.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so794769wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O515ri/uV19LTvFhGL3lF3UGBzNdh3Gbb9rWE3lfUS8=;
        b=pnWfijAmNjATC0+Rli9mSucUEkpxyvaHnn46pf8NHZ69r3cA6vxqDUKdya0bJ2LIIZ
         Fhp9SB6l3b48WeTVlDhxv3XKGBur+DPlfX8bw0bIEW/OTTgW/zBdLsChqOe24zdcgVjO
         eKElxQov5AfzZgaHBt/KbrC5a8ZfUS4JokE3VDPWCJV5ybkFw5nV+m7lumbuph6U864u
         lqyPxiG/Gu7L+lAtXOVWrQFyuqOuAgu4oFm7TO8+LeKoU/eE7rM/vsD+by4K/IfwExyZ
         9Nv/Dxfj/GE65r6dSknyh58JiOSddYwl3XrVA933g4gzD6EcdUi11M+NyQqCd8Q1V3j9
         GOow==
X-Gm-Message-State: AOAM53139LPhFX6jLo0Bc36c51oAW7hFGilOeJx9EjbqJCoBctkPymUG
        halaZjmlconDrZJ5ZpEh3BQx/f+923a65ib2PlfQ7f4bHphygN45J4NyVLkgov9KAK3kOni3knE
        9MS2KudfnjlOojO9LPDCwCEUL
X-Received: by 2002:adf:c048:: with SMTP id c8mr2048955wrf.96.1633678439765;
        Fri, 08 Oct 2021 00:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7U1izPQVu/A0/f53HEblQkyGjgb74D8ZHssRdR6e+S/1INH0MgqUh8JmXwtSZt7MuqxX/tw==
X-Received: by 2002:adf:c048:: with SMTP id c8mr2048932wrf.96.1633678439567;
        Fri, 08 Oct 2021 00:33:59 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c9sm11021297wmb.41.2021.10.08.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:33:59 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:33:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v3 6/8] perf session: Move event read code to separate
 function
Message-ID: <YV/0ZZBu01V87A8e@krava>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:

SNIP

>  static int
> -reader__process_events(struct reader *rd, struct perf_session *session,
> -		       struct ui_progress *prog)
> +reader__read_event(struct reader *rd, struct perf_session *session,
> +		   struct ui_progress *prog)
>  {
>  	u64 size;
>  	int err = 0;
>  	union perf_event *event;
>  	s64 skip;
>  
> -	err = reader__init(rd, &session->one_mmap);
> -	if (err)
> -		goto out;
> -
> -remap:
> -	err = reader__mmap(rd, session);
> -	if (err)
> -		goto out;
> -
> -more:
>  	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
>  				   session->header.needs_swap);
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
>  	if (!event)
> -		goto remap;
> +		return 1;
>  
>  	session->active_decomp = &rd->decomp_data;
>  	size = event->header.size;
> @@ -2311,6 +2301,33 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>  	ui_progress__update(prog, size);
>  
> +out:
> +	session->active_decomp = &session->decomp_data;
> +	return err;
> +}
> +
> +static int
> +reader__process_events(struct reader *rd, struct perf_session *session,
> +		       struct ui_progress *prog)
> +{
> +	int err;
> +
> +	err = reader__init(rd, &session->one_mmap);
> +	if (err)
> +		goto out;
> +
> +remap:
> +	err = reader__mmap(rd, session);
> +	if (err)
> +		goto out;
> +
> +more:
> +	err = reader__read_event(rd, session, prog);
> +	if (err < 0)
> +		goto out;
> +	else if (err == 1)
> +		goto remap;
> +
>  	if (session_done())
>  		goto out;
>  
> @@ -2318,7 +2335,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto more;
>  
>  out:
> -	session->active_decomp = &session->decomp_data;

active_decomp should be set/unset within reader__process_events,
not just for single event read, right?

jirka

>  	return err;
>  }
>  
> -- 
> 2.19.0
> 

