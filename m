Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3946436728E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhDUSa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243935AbhDUSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVSeL/TNu9U2GTYfxMrpVmDvW1N0R1LdIvPSKj87/bM=;
        b=EQyXtF49U9jSffRD0RDYu/fUTKHoO8kHGLaJF9jD+A2Id4T7wkK/0CoD/drOfE/umVyJE/
        bQjadI1JdJTQ9sHw0/6bvPIdE+wdzeJs4Ix1cdihBJVbNNBopv3pitibDan2Ulb4KK/jHt
        fxqlWbc0d5A52+P3JBpp+zkRQqftmd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-LVQuQbpCP5aQYgrBBiAjQg-1; Wed, 21 Apr 2021 14:29:31 -0400
X-MC-Unique: LVQuQbpCP5aQYgrBBiAjQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0CA81744F;
        Wed, 21 Apr 2021 18:29:05 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3AD206085A;
        Wed, 21 Apr 2021 18:29:03 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 23/25] perf tests: Support 'Session topology' test for
 hybrid
Message-ID: <YIBu7gUSTqremQ2K@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-24-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-24-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:15PM +0800, Jin Yao wrote:
> Force to create one event "cpu_core/cycles/" by default,
> otherwise in evlist__valid_sample_type, the checking of
> 'if (evlist->core.nr_entries == 1)' would be failed.
> 
>   # ./perf test 41
>   41: Session topology                                                : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/tests/topology.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 050489807a47..30b4acb08d35 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -8,6 +8,7 @@
>  #include "session.h"
>  #include "evlist.h"
>  #include "debug.h"
> +#include "pmu.h"
>  #include <linux/err.h>
>  
>  #define TEMPL "/tmp/perf-test-XXXXXX"
> @@ -40,7 +41,14 @@ static int session_write_header(char *path)
>  	session = perf_session__new(&data, false, NULL);
>  	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
>  
> -	session->evlist = evlist__new_default();
> +	if (!perf_pmu__has_hybrid()) {
> +		session->evlist = evlist__new_default();
> +	} else {
> +		struct parse_events_error err;
> +
> +		session->evlist = evlist__new();

you should ASSERT session->evlist in here

jirka

> +		parse_events(session->evlist, "cpu_core/cycles/", &err);
> +	}
>  	TEST_ASSERT_VAL("can't get evlist", session->evlist);
>  
>  	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
> -- 
> 2.17.1
> 

