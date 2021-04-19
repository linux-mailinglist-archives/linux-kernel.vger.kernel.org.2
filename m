Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CF36460E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbhDSO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239296AbhDSO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618842402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxAG4kbNBg9X46ZjvrZeyxdy/hfYbf4rBJQlMhrU+Ow=;
        b=SGnM2MCjKjGY/zbxDVgwLFFGNDpAIjYgpGxWtlvYhb4fushvU4M1D99QxiuAQLBbN1Pvzq
        ljxrFyztltgcQu4QSwn05KUTNprxIjDlZ8ecfiuvvNTcvmfzxcbkeuBIN8gpa3E9+AiaV0
        D/YK7G/M1WBozKaBM7lPHoG10TgnDzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-tZCMx9clOY2_lcqiovsQLw-1; Mon, 19 Apr 2021 10:26:41 -0400
X-MC-Unique: tZCMx9clOY2_lcqiovsQLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E3587A826;
        Mon, 19 Apr 2021 14:26:39 +0000 (UTC)
Received: from krava (unknown [10.40.195.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id D723A5D742;
        Mon, 19 Apr 2021 14:26:37 +0000 (UTC)
Date:   Mon, 19 Apr 2021 16:26:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YH2THG9zES3rjvEs@krava>
References: <20210416221325.2373497-1-song@kernel.org>
 <20210416221325.2373497-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416221325.2373497-4-song@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:13:24PM -0700, Song Liu wrote:

SNIP

> +/*
> + * Returns:
> + *     0   if all events use BPF;
> + *     1   if some events do NOT use BPF;
> + *     < 0 on errors;
> + */
>  static int read_bpf_map_counters(void)
>  {
> +	bool has_none_bpf_events = false;
>  	struct evsel *counter;
>  	int err;
>  
>  	evlist__for_each_entry(evsel_list, counter) {
> +		if (!evsel__is_bpf(counter)) {
> +			has_none_bpf_events = true;
> +			continue;
> +		}
>  		err = bpf_counter__read(counter);
>  		if (err)
>  			return err;
>  	}
> -	return 0;
> +	return has_none_bpf_events ? 1 : 0;
>  }
>  
>  static void read_counters(struct timespec *rs)
> @@ -442,9 +455,10 @@ static void read_counters(struct timespec *rs)
>  	int err;
>  
>  	if (!stat_config.stop_read_counter) {
> -		if (target__has_bpf(&target))
> -			err = read_bpf_map_counters();
> -		else
> +		err = read_bpf_map_counters();
> +		if (err < 0)
> +			return;
> +		if (err)
>  			err = read_affinity_counters(rs);

this part is confusing for me.. I understand we don't want to enter
read_affinity_counters when there's no bpf counter, so we don't set
affinities in vain.. but there must be better way ;-)

> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 5de991ab46af9..3189b63714371 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -792,6 +792,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
>  		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
>  	else if (target->use_bpf)
>  		evsel->bpf_counter_ops = &bperf_ops;
> +	else if (evsel__match_bpf_counter_events(evsel->name))
> +		evsel->bpf_counter_ops = &bperf_ops;

please put this with the target->use_bpf check,
it seems like it's another thing

thanks,
jirka

