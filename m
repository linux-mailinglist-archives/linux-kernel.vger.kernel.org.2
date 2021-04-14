Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38FA35ECD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbhDNGBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:01:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:10337 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhDNGBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:01:13 -0400
IronPort-SDR: mR04dnqzzjFzPyZreN2FhTTafTTB+IZhNjMBS8yDd0xxeAVCFLNGlQtPDTrqaRFdqNnxIfxGGk
 +r6W6W9TO5zw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174679395"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="174679395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 23:00:50 -0700
IronPort-SDR: iAAaup/KkwHp+utw+AfOGHomK6q2f7xNUUET0OhPGe8sqRiCmIErCfAJ5Zv03BOy6mxEKMWMWQ
 NhsjrcscwEdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="452304710"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2021 23:00:43 -0700
Subject: Re: [PATCH 2/2] perf intel-pt: Use aux_watermark
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
 <20210408153159.81880-3-alexander.shishkin@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e8097eb7-66cb-432a-a799-2514b28ae48e@intel.com>
Date:   Wed, 14 Apr 2021 09:00:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408153159.81880-3-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/04/21 6:31 pm, Alexander Shishkin wrote:
> Turns out, the default setting of attr.aux_watermark to half of the total
> buffer size is not very useful, especially with smaller buffers. The
> problem is that, after half of the buffer is filled up, the kernel updates
> ->aux_head and sets up the next "transaction", while observing that
> ->aux_tail is still zero (as userspace haven't had the chance to update
> it), meaning that the trace will have to stop at the end of this second
> "transaction". This means, for example, that the second PERF_RECORD_AUX in
> every trace comes with TRUNCATED flag set.
> 
> Setting attr.aux_watermark to quarter of the buffer gives enough space for
> the ->aux_tail update to be observed and prevents the data loss.
> 
> The obligatory before/after showcase:
> 
>> # perf_before record -e intel_pt//u -m,8 uname
>> Linux
>> [ perf record: Woken up 6 times to write data ]
>> Warning:
>> AUX data lost 4 times out of 10!
>>
>> [ perf record: Captured and wrote 0.099 MB perf.data ]
>> # perf record -e intel_pt//u -m,8 uname
>> Linux
>> [ perf record: Woken up 4 times to write data ]
>> [ perf record: Captured and wrote 0.039 MB perf.data ]
> 
> The effect is still visible with large workloads and large buffers,
> although less pronounced.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index a6420c647959..d00707faf547 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -776,6 +776,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		}
>  	}
>  
> +	if (opts->full_auxtrace)
> +		intel_pt_evsel->core.attr.aux_watermark =
> +		       opts->auxtrace_mmap_pages / 4 * page_size;
> +

I would be explicit about the mode and put "/ 4" at the end
for the case auxtrace_mmap_pages is not a multiple of 4 (e.g. 2).
i.e.

	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;

		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
	}


>  	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
>  			     "tsc", &tsc_bit);
>  
> 

