Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DF36728F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbhDUSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245224AbhDUSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGLzMl0fykunwKZ1kAMfezQb67emosrEkINQH4syKwA=;
        b=D0Y5PpY49cNall5aUf05p6/vPy9U6OCc1yQSCTL/Sq8QmTfoFa9jxH0vcvBEW/F/5BJaBn
        D9K6nzS35djdrldH0wlPEpB4oa4mSZcGiJfDmfycE0jlQDjIrXfmUiJoiUcTJ+eRj2O/9t
        CCwG7SB4UHVI3sAiRl28oplTLY1DQNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-zMgbP7PAM6CIjV3v_P55UA-1; Wed, 21 Apr 2021 14:29:41 -0400
X-MC-Unique: zMgbP7PAM6CIjV3v_P55UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276B364168;
        Wed, 21 Apr 2021 18:28:58 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0439C5D736;
        Wed, 21 Apr 2021 18:28:55 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:28:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 21/25] perf tests: Support 'Track with sched_switch'
 test for hybrid
Message-ID: <YIBu52/0p8r+JZO0@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-22-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-22-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:13PM +0800, Jin Yao wrote:
> Since for "cycles:u' on hybrid platform, it creates two "cycles".
> So the number of events in evlist is not expected in next test
> steps. Now we just use one event "cpu_core/cycles:u/" for hybrid.
> 
>   # ./perf test 35
>   35: Track with sched_switch                                         : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/tests/switch-tracking.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 3ebaa758df77..3a12176f8c46 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -18,6 +18,7 @@
>  #include "record.h"
>  #include "tests.h"
>  #include "util/mmap.h"
> +#include "pmu.h"
>  
>  static int spin_sleep(void)
>  {
> @@ -340,6 +341,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  	struct evsel *switch_evsel, *tracking_evsel;
>  	const char *comm;
>  	int err = -1;
> +	bool hybrid = false;
> +
> +	if (perf_pmu__has_hybrid())
> +		hybrid = true;
>  
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	if (!threads) {
> @@ -371,7 +376,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  	cpu_clocks_evsel = evlist__last(evlist);
>  
>  	/* Second event */
> -	err = parse_events(evlist, "cycles:u", NULL);
> +	if (!hybrid)

why the variable? some leftover? could be directly
'if (perf_pmu__has_hybrid())' no?

thanks,
jirka

> +		err = parse_events(evlist, "cycles:u", NULL);
> +	else
> +		err = parse_events(evlist, "cpu_core/cycles/u", NULL);
>  	if (err) {
>  		pr_debug("Failed to parse event cycles:u\n");
>  		goto out_err;
> -- 
> 2.17.1
> 

