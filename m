Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795D32E771
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCELwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCELv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:51:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 03:51:28 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o10so1203564pgg.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NnCGMYkLHHhLzlha7wIoj+XRbzjVqrdLciTxm17dSR0=;
        b=xw/B0M8/nF/p2drnRDH6KBVl5mOKJeX+aaBaRAYg+cUninCl1/9UT2yQ9zahq+v2s2
         EjBjWeatB4wsl/Defd2CJdAwnyCO5P9dcd2JhkC4S3X0RvHt9NljjiRR58+VY/NU/nPS
         Bg0UQD9wT9KGd5tgTK40QLtEuSyBJ5rfMahIUef7gNC2qFRXQMlopTRQGLP94exZY4gf
         qj59JJsqjl/J4szSRU5pvo5SMuR9nX9v/Gq+xEyo5LjS1OWjWstFp/z/8tjvIRQ2n6f7
         bS3Kec/ozQl+B6Gbv/Hpv4Q+S1QIBKb/zJqLnL/fRpUuK4VFajkoiMqSg/kLR6FCXmnR
         0/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NnCGMYkLHHhLzlha7wIoj+XRbzjVqrdLciTxm17dSR0=;
        b=jgcjVNPOhxoWRiUJ8n5hVhEh+yJwEt1RoKWuyb4xxg7j3nLzNyzKl9stHg9LydUqAA
         r84JFCxrau3eOny7RErDvdwHmvNSy6MU6nqxSeFafaNO9lMDXXruKqTWHq+P8Jz4Kads
         XzDUjbmMaiVVc9wvLldkhDb7ok+9AMr9pUdt2QGJv/lF/tzuIoIYMCaV7yeu9bFicjOq
         d/5cqKt66o7a9LMP7SaVdVvabTIyzZ9scRTGE8KNKFGbYVG9b9tqsbbWFhXa95YD68bs
         RjBOtCCsX+6CCSm4oyt8O5hhBWIV8Nviiaoh0B07H7b7KeqFA+dFWqAzShLZgGlPsggw
         U9Ow==
X-Gm-Message-State: AOAM530uc44djGEzdu8iWb6BXO+210DFmf+qnqLmLbddoMkbcWA4YdhB
        PaFZrkYim/BeqgK9yFnqQ5j8aw==
X-Google-Smtp-Source: ABdhPJzWYQ9hY6hwI1KR7IjfqM4m48t7udGV7npDdPdORAFZg8Zmvwi6DFjGg8C7r7xn6zZSPYBRgA==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr7996516pgq.7.1614945087509;
        Fri, 05 Mar 2021 03:51:27 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.136.125.226])
        by smtp.gmail.com with ESMTPSA id q14sm2048018pfh.172.2021.03.05.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 03:51:27 -0800 (PST)
Date:   Fri, 5 Mar 2021 19:51:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Alexandre Truong <alexandre.truong@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: Re: [PATCH RESEND WITH CCs v3 3/4] perf tools: enable
 dwarf_callchain_users on aarch64
Message-ID: <20210305115120.GA5478@leoy-ThinkPad-X240s>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
 <20210304163255.10363-3-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304163255.10363-3-alexandre.truong@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Mar 04, 2021 at 04:32:54PM +0000, Alexandre Truong wrote:
> On arm64, enable dwarf_callchain_users which will be needed
> to do a dwarf unwind in order to get the caller of the leaf frame.
> 
> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Kemeng Shi <shikemeng@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
> ---
>  tools/perf/builtin-report.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..93661a3eaeb1 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report *rep)
>  
>  	callchain_param_setup(sample_type);
>  
> +	if (callchain_param.record_mode == CALLCHAIN_FP &&
> +			strncmp(rep->session->header.env.arch, "aarch64", 7) == 0)
> +		dwarf_callchain_users = true;
> +

I don't have knowledge for dwarf or FP.

This patch is suspicious for me that since it only fixes the issue for
"perf report" command, but it cannot support "perf script".

I did a quick testing for "perf script" command with the test code from
patch 04, seems to me it cannot fix the fp omitting issue for
"perf script" command:

  arm64_fp_test 11211  2282.355095:     176307 cycles: 
              aaaac2e40740 f2+0x10 (/root/arm64_fp_test)
              aaaac2e4061c main+0xc (/root/arm64_fp_test)
              ffff961fbd24 __libc_start_main+0xe4 (/usr/lib/aarch64-linux-gnu/libc-2.28.so)
              aaaac2e4065c _start+0x34 (/root/arm64_fp_test)

Could you check for this?  Thanks!

Leo

>  	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
>  		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
>  			    "Please apply --call-graph lbr when recording.\n");
> -- 
> 2.23.0
> 
