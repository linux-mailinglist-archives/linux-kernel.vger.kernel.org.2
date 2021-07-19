Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C63CEDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386292AbhGST2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385387AbhGSS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:58:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F576C0613E3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:30:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso273543pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJC6T1mr3FGK6VqXqqxg5TyKpiauehuu55lXlzMhFnA=;
        b=NNKlQu8JwjSEDoWa8NuqtgLa1KcftHc9HZPFjLFddHljAkmyao2v2BRSn7PUg2holy
         t6upJGhs7E8TUCsiwXfdEreLoml1zao10eTQ7lG7n383nurGN3bzlcwbmLdT5aEEBv6Z
         sCVn1EMKL9zEuESFYr7pF0kfijHTOmJHiqoFebNF30aLpa2iwFnDpVlEhQkCK5g1xm/T
         52TBbbxMdE7l/JUelVkS8I7a6uEF5dviruC9JjioqtOqjP05GEE08URhkXL4naCWNmMU
         pWy/WE/hiZ0YzoU3qs2lwLfB8WLFqHum1bwwGBYNaONDsTXqpXKCJij2wqKXfl7Iyebe
         wPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJC6T1mr3FGK6VqXqqxg5TyKpiauehuu55lXlzMhFnA=;
        b=oIC47+jPfqpdAreS42maLnzzKUhOh2QnvnoakhO/ry/So623LvKOcSImZQSgMvVVmg
         7id14NYYMlmyisOcpJJ2vsKeOaaPRI1wtCmNhVvPz/hId3xrDjny1qvWR5DNxMVJcF1a
         bk/F6AbiB4+rkld3pk0YoyOiMKWgV1YdpPhqI4KznZ9BQJuwjgctLqfN4cU76JrnGrs7
         JtofZ8xetlmwqT0aFQSyubKFe/V+65BiQTAGaU4w2+hhHZVicDZ8AjRLM6wfk+7LgM8d
         J2dNtBoQ8Qezpywm0c/TRUWLr/NdPUsaNTXsjYfzzqwqItbYi3VJLg1wFggJP20e+g4j
         K0OA==
X-Gm-Message-State: AOAM533s3LKzV+t2WyKUBuJdppPeIU15oDSJc5XG0oBJsyLQK1rcEDkV
        OvuoPiF4CIf2kncKA8D6eGOb5Q==
X-Google-Smtp-Source: ABdhPJx98p4kOlM/+xDrMCKSzmp8+10vnluYvU1C2qB2NSKZiPEOl5tpq7ByXoK7PtZyk/1K9Y0U2w==
X-Received: by 2002:a17:902:b210:b029:11a:bf7b:1a83 with SMTP id t16-20020a170902b210b029011abf7b1a83mr20462143plr.84.1626723475799;
        Mon, 19 Jul 2021 12:37:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g17sm7810842pgi.70.2021.07.19.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:37:55 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:37:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] perf cs-etm: Refactor initialisation of kernel start
 address
Message-ID: <20210719193752.GB2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:03PM +0100, James Clark wrote:
> The kernel start address is already cached in the machine struct once it
> is initialised, so storing it in the cs_etm struct is unnecessary.
> 
> It also depends on kernel maps being available to be initialised.
> Therefore cs_etm__setup_queues() isn't an appropriate place to call it
> because it could be called before processing starts. It would be better
> to initialise it at the point when it is needed, then we can be sure
> that all the necessary maps are available. Also by calling
> machine__kernel_start() multiple times it can be initialised at some
> point, even if it failed to initialise previously due to missing maps.
> 
> In a later commit cs_etm__setup_queues() will be moved which is the
> motivation for this change.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index bc1f64873c8f..4c69ef391f60 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -62,7 +62,6 @@ struct cs_etm_auxtrace {
>  	u64 instructions_sample_period;
>  	u64 instructions_id;
>  	u64 **metadata;
> -	u64 kernel_start;
>  	unsigned int pmu_type;
>  };
>  
> @@ -691,7 +690,7 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
>  
>  	machine = etmq->etm->machine;
>  
> -	if (address >= etmq->etm->kernel_start) {
> +	if (address >= machine__kernel_start(machine)) {
>  		if (machine__is_host(machine))
>  			return PERF_RECORD_MISC_KERNEL;
>  		else
> @@ -901,9 +900,6 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>  	unsigned int i;
>  	int ret;
>  
> -	if (!etm->kernel_start)
> -		etm->kernel_start = machine__kernel_start(etm->machine);
> -
>  	for (i = 0; i < etm->queues.nr_queues; i++) {
>  		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
>  		if (ret)
> -- 
> 2.28.0
> 
