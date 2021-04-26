Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A303A36ACE4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhDZH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:26:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:25261 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhDZH0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:26:47 -0400
IronPort-SDR: gxop8TGgNsZBzSUyIEHKG60blvYdE1kVvTaIsUptrvpskGbcIkoHkinkHQfROZcAfm+OOh4lyN
 Pf8emI307zNA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="281623900"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="281623900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 00:26:06 -0700
IronPort-SDR: guWK1l9xohQg5grOmtX40cv6gXlDJ/Gde3dIba2L1dFru6Pi/NSsMeJ6s8aGE8QykZGa45FjDm
 yJXa75+6RrhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422545639"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2021 00:26:00 -0700
Subject: Re: [PATCH v1 2/3] perf session: Add swap operation for event
 TIME_CONV
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210412083459.462817-1-leo.yan@linaro.org>
 <20210412083459.462817-3-leo.yan@linaro.org>
 <1b4fa7c3-79cd-6f73-873e-4792b8a1b732@intel.com>
 <20210426064421.GA327854@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7f21edac-1bd9-ab98-aeca-2109e5edf5c3@intel.com>
Date:   Mon, 26 Apr 2021 10:26:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210426064421.GA327854@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/21 9:44 am, Leo Yan wrote:
> Hi Adrian,
> 
> On Mon, Apr 26, 2021 at 08:40:00AM +0300, Adrian Hunter wrote:
> 
> [...]
> 
>>> +static void perf_event__time_conv_swap(union perf_event *event,
>>> +				       bool sample_id_all __maybe_unused)
>>> +{
>>> +	size_t time_zero_size;
>>> +
>>> +	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
>>> +	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
>>> +	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
>>> +
>>> +	time_zero_size = (void *)&event->time_conv.time_cycles - (void *)event;
>>> +	if (event->header.size > time_zero_size) {
>>
>> I wonder if we could have a helper for this e.g. (untested)
>>
>> #define event_contains(obj, mem) (obj.header.size > offsetof(typeof(obj), mem))
>>
>> 	if (event_contains(event->time_conv, time_cycles)) {
> 
> Yeah, this is a better implementation.  Will refine patch for this.
> 
>>> +		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
>>> +		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
>>> +		event->time_conv.cap_user_time_zero =
>>> +			bswap_32(event->time_conv.cap_user_time_zero);
>>> +		event->time_conv.cap_user_time_short =
>>> +			bswap_32(event->time_conv.cap_user_time_short);
>>
>> 'struct perf_record_time_conv' contains bool, the sizeof which, AFAIK, is not defined.
>> Is it really 4 bytes on your implementation?  It is only 1 byte with gcc on x86.
> 
> On Arm64, bool is also 1 byte with GCC.
> 
> When working on this patch, I checked the size for structure
> perf_record_time_conv, it gave out the structure size is 56; I wrongly
> thought the bool size is 4 bytes and there have no padding.  In fact,
> bool size is 1 byte and GCC pads 6 bytes at the end of structure.
> 
>> Either way, you should change 'struct perf_record_time_conv' so it uses a type of known size.
>> Since you are the only one using it, it should match your implementation.
> 
> Will change to "unsigned int" value.

If it is 1 byte, I'd have thought __u8 i.e.

struct perf_record_time_conv {
	struct perf_event_header header;
	__u64			 time_shift;
	__u64			 time_mult;
	__u64			 time_zero;
	__u64			 time_cycles;
	__u64			 time_mask;
	__u8			 cap_user_time_zero;
	__u8			 cap_user_time_short;
	__u8			 unused[6];
};

