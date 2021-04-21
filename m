Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3498736728C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbhDUSaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243990AbhDUSaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619029775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0cBo14mgny3Xi9o+v7dupqnQehUF+MvtBLiXMCPNcE=;
        b=CjvxaJ2CbzFdu1o0dfjuxDjUiYuZxBmbkMjhuiCkW781Tk9+ofT8YnIbYgukuWwwTr7eZQ
        y7N3/O4VdVG4qKGioG+USc/c/paBkUn5wX6w/f7J+0n5IibSyd0v8AzS91be03kz1rKZje
        2pm0IrEMzYnEjdeyDqmDCQJ9C+VVPIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-ScRGpHuWP0qcGEVVXYWAlA-1; Wed, 21 Apr 2021 14:29:31 -0400
X-MC-Unique: ScRGpHuWP0qcGEVVXYWAlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1689817476;
        Wed, 21 Apr 2021 18:29:11 +0000 (UTC)
Received: from krava (unknown [10.40.195.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id F05365D747;
        Wed, 21 Apr 2021 18:29:09 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:29:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 20/25] perf tests: Skip 'Setup struct perf_event_attr'
 test for hybrid
Message-ID: <YIBu9czPTYWePyak@krava>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-21-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140517.18206-21-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:05:12PM +0800, Jin Yao wrote:
> For hybrid, the attr.type consists of pmu type id + original type.
> There will be much changes for this test. Now we temporarily
> skip this test case and TODO in future.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/tests/attr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index dd39ce9b0277..b37c35fb5a46 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -34,6 +34,7 @@
>  #include "event.h"
>  #include "util.h"
>  #include "tests.h"
> +#include "pmu.h"
>  
>  #define ENV "PERF_TEST_ATTR"
>  
> @@ -184,6 +185,9 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
>  	char path_dir[PATH_MAX];
>  	char *exec_path;
>  
> +	if (perf_pmu__has_hybrid())
> +		return 0;

should return TEST_SKIP

jirka

> +
>  	/* First try development tree tests. */
>  	if (!lstat("./tests", &st))
>  		return run_dir("./tests", "./perf");
> -- 
> 2.17.1
> 

