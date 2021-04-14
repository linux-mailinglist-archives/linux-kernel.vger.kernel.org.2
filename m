Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7855D35F86C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352413AbhDNPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:53:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:57417 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352431AbhDNPvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:51:10 -0400
IronPort-SDR: wsKNU2pZUHE6XHGSr2aqnXbf4tQ7ZGn9xNRe/tUaPy2rIsAsyS+pc/T2E7WfnOz+qJ3aEWER+H
 E9vW7RgxNV6w==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="255987397"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="255987397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:50:46 -0700
IronPort-SDR: sGar3ZOMlBav4B9kq51Bfw5J0U8JPuqB8kFSdU8f74X7CDePN8jUeLeHUzLU5NIXuPAlnWH1bn
 dAbXS77+5xOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382400250"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 08:50:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/2] perf intel-pt: Use aux_watermark
In-Reply-To: <e8097eb7-66cb-432a-a799-2514b28ae48e@intel.com>
References: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
 <20210408153159.81880-3-alexander.shishkin@linux.intel.com>
 <e8097eb7-66cb-432a-a799-2514b28ae48e@intel.com>
Date:   Wed, 14 Apr 2021 18:50:42 +0300
Message-ID: <87wnt4g90t.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Hunter <adrian.hunter@intel.com> writes:

> On 8/04/21 6:31 pm, Alexander Shishkin wrote:
>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
>> index a6420c647959..d00707faf547 100644
>> --- a/tools/perf/arch/x86/util/intel-pt.c
>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>> @@ -776,6 +776,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>>  		}
>>  	}
>>  
>> +	if (opts->full_auxtrace)
>> +		intel_pt_evsel->core.attr.aux_watermark =
>> +		       opts->auxtrace_mmap_pages / 4 * page_size;
>> +
>
> I would be explicit about the mode and put "/ 4" at the end
> for the case auxtrace_mmap_pages is not a multiple of 4 (e.g. 2).
> i.e.
>
> 	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
> 		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
>
> 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
> 	}

Thank you! I'll do exactly that.

Regards,
--
Alex
