Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB839E087
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFGPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhFGPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:33:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF14C061766;
        Mon,  7 Jun 2021 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HXKPhHJ/OxcNx9Z7QBJwmF3Ys6qbT/gmbqDsN+FHdL0=; b=PWUaxdXqF9W2sqmRqmXdbAOiyz
        f2FeLrrcJA2U6wMm9DcLBtgv9A0itFecu6kt9RMkG4Z9cphEg2+6Upg1FZuTR8cWCufXrwBUC+95E
        ThXhaiHfbHs3hWzTZ1vN5WtpDlQAsX5feUkX4KSTPscMEWUd3w+6SWaF8jIetdO6FBDPAjexBm8E1
        jBLrT/Pz2koWc3IkOyjmIp1D02K82SSWEA5LJgBkxivWq4qfzmcR5/efX3FDmzR5CZC9/blVQWT/t
        4XEO5RSCiRjFNtNolxG+cMm/puaYP6UsAqfmd43avZY2r9Zu53PyGmrSLA5t7D+1Ytsm7SOd8MhZj
        zc4S1Ryg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqHDS-00Fwhs-0b; Mon, 07 Jun 2021 15:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F88630018A;
        Mon,  7 Jun 2021 17:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9012F2D6A7343; Mon,  7 Jun 2021 17:31:01 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:31:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] perf auxtrace: Use WRITE_ONCE() for updating
 aux_tail
Message-ID: <YL47tdD0ygaErZu+@hirez.programming.kicks-ass.net>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-8-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602103007.184993-8-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 06:30:06PM +0800, Leo Yan wrote:
> Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
> behaviour.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/perf/util/auxtrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index e625bc76cdde..abc4282f5272 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -458,7 +458,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  
>  	/* Ensure all reads are done before we write the tail out */
>  	smp_mb();
> -	pc->aux_tail = tail;
> +	WRITE_ONCE(pc->aux_tail, tail);
>  }
>  
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> -- 
> 2.25.1
> 
