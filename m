Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DC434BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhJTNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJTNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634735193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2gH7rb7/m5w1MSubEzeVAyg/+4ulkXtrUYC/5EhnAA=;
        b=MyXwqgQa3CD2zxVdu4cHzUDJ77BohQ3gV6vplYH19C3/AjZKyaN7c8BdMSYqBX/XwAVxYc
        8mlDQXE7vr2tbYAn75OFhaWOQlk0lDaVxyimeb11qhcNSJr7MkXqNZVVLYJYLv9JFMUiq8
        ux/Ub7KtDLGeY4tSNxKr5JiCa/7sM08=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Az6YpRUfPJmQ21k2ZMfYuA-1; Wed, 20 Oct 2021 09:06:32 -0400
X-MC-Unique: Az6YpRUfPJmQ21k2ZMfYuA-1
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50f185000000b003db0f796903so20930878edl.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2gH7rb7/m5w1MSubEzeVAyg/+4ulkXtrUYC/5EhnAA=;
        b=Hka4D+rUdmFeYu6aa3CCpqEZxDZl8mespLOhaVVsfCuRaJLgwpCTtmCWaSNPTCBLMB
         v7cmZwxTzIVS+jlZIPmadTazXzua79E0HytGCZaDeh4gN5+EuZM9vK4cmr3S4rxeFTs9
         xc6Iiqi0/iZk0RBMbjI4aFYHRMeKojywGAAw/j2CFC0uzHJzpHSuNwHBh0XSnI6d0uSu
         paMJHpW4/MMTKosctv3Tt41mZwEbFKCd0TWds4yFzM44M3JB66eSfSk0zTaVf236YGhy
         WlVZ6KHzur+Dp/cgIm2AQ8Ue6ok19qJvUAQbCzRn3VGkOrUMeWbq7KGEIU8iLe0Ea6kv
         Nr9g==
X-Gm-Message-State: AOAM533gZp8+XhXur+dXMktwe7ueP436NcJC5Tof4CPoMw3cMZ0CJuFe
        xne//VEDYUkRTbuOfPG0ANtSTDbyYdKNo11zxKU/ciRyANnKdY9Rywv2m/Kjc+HeLFp1VYlSR5S
        F2W3EDxuSphnMEm6NCXeK/+Tu
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr62789701edd.354.1634735191135;
        Wed, 20 Oct 2021 06:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzew6vEv7MbBQdtbRq7+Y/PNegbNzQ9IdbBjC4Yk1ALEtf96492aeUApmo/qQzoSbe9tY969A==
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr62789681edd.354.1634735190914;
        Wed, 20 Oct 2021 06:06:30 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id b26sm1047355ejl.82.2021.10.20.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:06:30 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:06:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [PATCH v2 21/22] perf test: Remove is_supported function
Message-ID: <YXAUVJgFqcxYoiaa@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-22-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-22-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:46:03AM -0700, Ian Rogers wrote:
> All tests now return TEST_SKIP if not supported. Removing this function
> brings perf's test_suite struct more inline with kunit.

ah ok, forget my previous comment then ;-)

jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 14 +-------------
>  tools/perf/tests/tests.h        |  1 -
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 966948cacba3..086641f60015 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -150,11 +150,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
>  	return t->desc;
>  }
>  
> -static bool is_supported(const struct test_suite *t)
> -{
> -	return !t->is_supported || t->is_supported();
> -}
> -
>  static test_fnptr test_function(const struct test_suite *t, int subtest)
>  {
>  	if (subtest <= 0)
> @@ -480,12 +475,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  				continue;
>  		}
>  
> -		if (!is_supported(t)) {
> -			pr_debug("%2d: %-*s: Disabled\n", i, width,
> -				 test_description(t, -1));
> -			continue;
> -		}
> -
>  		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
>  
>  		if (intlist__find(skiplist, i)) {
> @@ -583,8 +572,7 @@ static int perf_test__list(int argc, const char **argv)
>  	for_each_test(j, k, t) {
>  		int curr = i++;
>  
> -		if (!perf_test__matches(test_description(t, -1), curr, argc, argv) ||
> -		    !is_supported(t))
> +		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
>  			continue;
>  
>  		pr_info("%2d: %s\n", i, test_description(t, -1));
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 958f94dcc94c..15051801c790 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -44,7 +44,6 @@ struct test_suite {
>  		bool skip_if_fail;
>  	} subtest;
>  	struct test_case *test_cases;
> -	bool (*is_supported)(void);
>  	void *priv;
>  };
>  
> -- 
> 2.33.0.882.g93a45727a2-goog
> 

