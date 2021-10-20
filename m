Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514F434B40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJTMhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJTMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634733284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWo7Mu1LgbVcoVhIHgDtxt4QkLrq2mjDYhM5i0I36Fc=;
        b=e0gesUVfogu4tFKfpY/wY1LcTlGOOwj4MsrSrCtFZ27zwr2LY8Qe4pj59qHg5fg+CZ/PSd
        kFWjYPeOYqjZOLh1P6HXsBOwckk3yFYlN+itOi/Iar1RYaJ5KAJSH1e6jaCyUGOrH927gc
        XRZE8K1hBaDW8RHT9yYUTpSTxmsYaR4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-4oGB7FUkP9atzaJ-4UzPRA-1; Wed, 20 Oct 2021 08:34:42 -0400
X-MC-Unique: 4oGB7FUkP9atzaJ-4UzPRA-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50f185000000b003db0f796903so20843466edl.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWo7Mu1LgbVcoVhIHgDtxt4QkLrq2mjDYhM5i0I36Fc=;
        b=5+OEGlEq/q+8sCkjyo1fseZ45gdd2H527L2X8PjHOXbn/FJNk9fKawBycGGh3gHRzJ
         E83E2JDO2NbrgOirQrTU1p3BDSKDytVDUV6xkX346/ya8MDI77XhCyQLw73mj33tqqoH
         bxfGNi3h64ThCwRNC5iKEdpXwUSDhi/8XxIadvNclzf0w7HILsSMPZtodO0kTDNew2z4
         maFdfntozF7WuAWyE+9vdJQeSZwFUqYojn7HjDmbUFj7wmi8JwklxstuRf7d6ECveXRy
         PcO6rrKZxbycGojx8/Sq2PumgazFy7A3GpcOJLrOtzSMPFjOCx9aokDR1ZOGCzsr53er
         ozjw==
X-Gm-Message-State: AOAM533BReRuVCecdpogZgLdXqAHS8lL5RoWP0V0uCscNGebrIcd6fd/
        ZmL7Bp7Zsm52XEeXKfA0SHLoNd8OvNlYY3f6heoPbFa/2YPKKI7A5YbsQHHNxmsvt+E2BIsAyEx
        w3xbYxs2XTENqPeTXZhijCJ4P
X-Received: by 2002:a17:907:c22:: with SMTP id ga34mr43230108ejc.380.1634733281429;
        Wed, 20 Oct 2021 05:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpL7lpBsDFsNSZbROWL3gXO2SPB4mMKZakczxEZ7WBtzg0oR0ugQxn8GUdpy5+09Vh74R/Bg==
X-Received: by 2002:a17:907:c22:: with SMTP id ga34mr43230087ejc.380.1634733281247;
        Wed, 20 Oct 2021 05:34:41 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id e30sm987114ejl.117.2021.10.20.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:34:40 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:34:39 +0200
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
Subject: Re: [PATCH v2 06/22] perf test: Add helper functions for abstraction.
Message-ID: <YXAM31HKzS4/qJw/@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <20211013174604.747276-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013174604.747276-7-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:45:48AM -0700, Ian Rogers wrote:

SNIP

>  	else
>  		pr_debug("%s subtest %d:", t->desc, subtest + 1);
> @@ -218,11 +257,10 @@ static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
>  		pr_info(" Ok\n");
>  		break;
>  	case TEST_SKIP: {
> -		const char *skip_reason = NULL;
> -		if (t->subtest.skip_reason)
> -			skip_reason = t->subtest.skip_reason(subtest);
> -		if (skip_reason)
> -			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", skip_reason);
> +		const char *reason = skip_reason(t, subtest);
> +
> +		if (reason)
> +			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
>  		else
>  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
>  	}
> @@ -397,7 +435,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  	int width = shell_tests__max_desc_width();
>  
>  	for_each_test(j, k, t) {
> -		int len = strlen(t->desc);
> +		int len = strlen(test_description(t, -1));
>  
>  		if (width < len)
>  			width = len;
> @@ -407,17 +445,15 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  		int curr = i++, err;
>  		int subi;
>  
> -		if (!perf_test__matches(t->desc, curr, argc, argv)) {
> +		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
>  			bool skip = true;
>  			int subn;
>  
> -			if (!t->subtest.get_nr)
> -				continue;
> -
> -			subn = t->subtest.get_nr();
> +			subn = num_subtests(t);

should you call continue on !subn ?

jirka

>  
>  			for (subi = 0; subi < subn; subi++) {
> -				if (perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
> +				if (perf_test__matches(test_description(t, subi),
> +							curr, argc, argv))
>  					skip = false;
>  			}
>  
> @@ -425,22 +461,23 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  				continue;
>  		}
>  

SNIP

