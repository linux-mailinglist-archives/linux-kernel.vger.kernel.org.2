Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65D42661F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhJHIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:44:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:29466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhJHIok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:44:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226416478"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226416478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:42:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="489376509"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.14]) ([10.249.227.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:42:41 -0700
Subject: Re: [PATCH v3 6/8] perf session: Move event read code to separate
 function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <YV/0ZZBu01V87A8e@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
Date:   Fri, 8 Oct 2021 11:42:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV/0ZZBu01V87A8e@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.10.2021 10:33, Jiri Olsa wrote:
> On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:
> 
> SNIP
> 
>>  static int
>> -reader__process_events(struct reader *rd, struct perf_session *session,
>> -		       struct ui_progress *prog)
>> +reader__read_event(struct reader *rd, struct perf_session *session,
>> +		   struct ui_progress *prog)
>>  {
>>  	u64 size;
>>  	int err = 0;
>>  	union perf_event *event;
>>  	s64 skip;
>>  
>> -	err = reader__init(rd, &session->one_mmap);
>> -	if (err)
>> -		goto out;
>> -
>> -remap:
>> -	err = reader__mmap(rd, session);
>> -	if (err)
>> -		goto out;
>> -
>> -more:
>>  	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
>>  				   session->header.needs_swap);
>>  	if (IS_ERR(event))
>>  		return PTR_ERR(event);
>>  
>>  	if (!event)
>> -		goto remap;
>> +		return 1;
>>  
>>  	session->active_decomp = &rd->decomp_data;
>>  	size = event->header.size;
>> @@ -2311,6 +2301,33 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>  
>>  	ui_progress__update(prog, size);
>>  
>> +out:
>> +	session->active_decomp = &session->decomp_data;
>> +	return err;
>> +}
>> +
>> +static int
>> +reader__process_events(struct reader *rd, struct perf_session *session,
>> +		       struct ui_progress *prog)
>> +{
>> +	int err;
>> +
>> +	err = reader__init(rd, &session->one_mmap);
>> +	if (err)
>> +		goto out;
>> +
>> +remap:
>> +	err = reader__mmap(rd, session);
>> +	if (err)
>> +		goto out;
>> +
>> +more:
>> +	err = reader__read_event(rd, session, prog);
>> +	if (err < 0)
>> +		goto out;
>> +	else if (err == 1)
>> +		goto remap;
>> +
>>  	if (session_done())
>>  		goto out;
>>  
>> @@ -2318,7 +2335,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>  		goto more;
>>  
>>  out:
>> -	session->active_decomp = &session->decomp_data;
> 
> active_decomp should be set/unset within reader__process_events,
> not just for single event read, right?

No, it should be set before perf_session__process_event/process_decomp_events
and unset after these calls. So active_decomp setting/unsetting is moved in
this patch to the reader__read_event function. This is necessary for multiple
trace reader because it could call reader__read_event in round-robin manner.

Regards,
Alexey

> 
> jirka
> 
>>  	return err;
>>  }
>>  
>> -- 
>> 2.19.0
>>
> 
