Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6CC367291
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbhDUSaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245235AbhDUSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hNEefMfv/ahxepXi2aTMF2L00dMYf1nPr0a9/ATtblE=;
        b=LwGiFAGjqh3TsWhL5g1M6m3GTD4qpAIpfFKSPKR73lBVvVkVhByFvYzacH8+0c944Thm5V
        cfM1bs86a2K30hCC8ZLo5yk2RBhCK6ID9aQln1AEgyxI0WHAH/XiGvoNjt2fU+OdhhJhdT
        SS0BJmW0qAfQu254nhHPikPN+XdkHYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-sCZInFeWPPSB6EU2JD8cSA-1; Wed, 21 Apr 2021 14:29:51 -0400
X-MC-Unique: sCZInFeWPPSB6EU2JD8cSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9709018982A3;
        Wed, 21 Apr 2021 18:29:19 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 939DE60871;
        Wed, 21 Apr 2021 18:29:17 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 24/25] perf tests: Support 'Convert perf time to TSC'
 test for hybrid
Message-ID: <YIBu/DyPmMf1Mta4@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-25-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-25-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:16PM +0800, Jin Yao wrote:
> Since for "cycles:u' on hybrid platform, it creates two "cycles".
> So the second evsel in evlist also needs initialization.
> 
> With this patch,
> 
>   # ./perf test 71
>   71: Convert perf time to TSC                                        : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/tests/perf-time-to-tsc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index 680c3cffb128..72f268c6cc5d 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -20,6 +20,7 @@
>  #include "tsc.h"
>  #include "mmap.h"
>  #include "tests.h"
> +#include "pmu.h"
>  
>  #define CHECK__(x) {				\
>  	while ((x) < 0) {			\
> @@ -66,6 +67,10 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  	u64 test_tsc, comm1_tsc, comm2_tsc;
>  	u64 test_time, comm1_time = 0, comm2_time = 0;
>  	struct mmap *md;
> +	bool hybrid = false;
> +
> +	if (perf_pmu__has_hybrid())
> +		hybrid = true;
>  
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
> @@ -88,6 +93,17 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  	evsel->core.attr.disabled = 1;
>  	evsel->core.attr.enable_on_exec = 0;
>  
> +	/*
> +	 * For hybrid "cycles:u", it creates two events.
> +	 * Init the second evsel here.
> +	 */
> +	if (hybrid) {

same, don't see the reason for 'hybrid' variable

jirka

> +		evsel = evsel__next(evsel);
> +		evsel->core.attr.comm = 1;
> +		evsel->core.attr.disabled = 1;
> +		evsel->core.attr.enable_on_exec = 0;
> +	}
> +
>  	CHECK__(evlist__open(evlist));
>  
>  	CHECK__(evlist__mmap(evlist, UINT_MAX));
> -- 
> 2.17.1
> 

