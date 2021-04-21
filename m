Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C367293
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhDUSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245223AbhDUSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ie00xtRRe7vs3qQ104WeS4uEr31icUNKfxaXc3VESzc=;
        b=MydJkLrbDOwmC0iFC03X6JJeFx4RsDNiIoxuZPvUacie615+KSBPIlpBPZk4wAMNt69SZ3
        VNuTvKvaxLp6lCVPhRoE16ZSUX4o5FGYo12iiLtyJh4q1CXezvAWNsmSQi1X9bRvKuCPRr
        dqbVeHA9s3J/mSwNd63VQ/V9TtqcKjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-c7N_dCjoNYiJGAy7jEiu3A-1; Wed, 21 Apr 2021 14:29:44 -0400
X-MC-Unique: c7N_dCjoNYiJGAy7jEiu3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 471036C056;
        Wed, 21 Apr 2021 18:29:38 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 410A45B69B;
        Wed, 21 Apr 2021 18:29:35 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 22/25] perf tests: Support 'Parse and process metrics'
 test for hybrid
Message-ID: <YIBvD16uYZspDVDa@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-23-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-23-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:14PM +0800, Jin Yao wrote:
> Some events are not supported. Only pick up some cases for hybrid.
> 
>   # ./perf test 67
>   67: Parse and process metrics                                       : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/tests/parse-metric.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 4968c4106254..24e5ddff515e 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -11,6 +11,7 @@
>  #include "debug.h"
>  #include "expr.h"
>  #include "stat.h"
> +#include "pmu.h"
>  
>  static struct pmu_event pme_test[] = {
>  {
> @@ -370,12 +371,17 @@ static int test_metric_group(void)
>  
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
> +	perf_pmu__scan(NULL);

perf_pmu__has_hybrid calls perf_pmu__scan no?

jirka

> +
>  	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>  	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> -	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>  	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>  	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
> -	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
>  	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
> +
> +	if (!perf_pmu__has_hybrid()) {
> +		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> +		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
> +	}
>  	return 0;
>  }
> -- 
> 2.17.1
> 

