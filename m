Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6439D93B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFGKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:04:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:26021 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhFGKE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:04:29 -0400
IronPort-SDR: ch1mCQEfkdM6tF38UHTmJPf/otKWQ9lS+MjYVqS5EmddZxjXci8b9uD/IHt9LCbFzFd0U1xRjI
 K7en59z6EY6g==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="191702807"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="191702807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 03:02:37 -0700
IronPort-SDR: n/77u5nQ23NkboK2RAmtfAn0Ro78k9O/tBE31r6buWmyj1Zh4y4nqUH4tyaCC8JRH3VvcYUnlh
 9RwcHSPmZaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="484722858"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2021 03:02:32 -0700
Subject: Re: [PATCH v2 5/8] perf auxtrace: Change to use SMP memory barriers
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-6-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f3215353-0b01-368d-56ab-00d1335639b5@intel.com>
Date:   Mon, 7 Jun 2021 13:02:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602103007.184993-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/06/21 1:30 pm, Leo Yan wrote:
> The kernel and the userspace tool can access the AUX ring buffer head
> and tail from different CPUs, thus SMP class of barriers are required
> on SMP system.
> 
> This patch changes to use SMP barriers to replace mb() and rmb()
> barriers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index a4fbb33b7245..42b7ef811bde 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -444,7 +444,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>  	u64 head = READ_ONCE(pc->aux_head);
>  
>  	/* Ensure all reads are done after we read the head */
> -	rmb();
> +	smp_rmb();
>  	return head;
>  }
>  
> @@ -458,7 +458,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  #endif
>  
>  	/* Ensure all reads are done after we read the head */
> -	rmb();
> +	smp_rmb();
>  	return head;
>  }
>  
> @@ -470,7 +470,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  #endif
>  
>  	/* Ensure all reads are done before we write the tail out */
> -	mb();
> +	smp_mb();
>  #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>  	pc->aux_tail = tail;
>  #else
> 

