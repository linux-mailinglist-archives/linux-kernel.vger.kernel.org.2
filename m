Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BFE3B98A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 00:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGAWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 18:48:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:29780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232637AbhGAWs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 18:48:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="189020229"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="189020229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 15:46:25 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="457876454"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.231.202]) ([10.249.231.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 15:46:22 -0700
Subject: Re: [PATCH v8 12/22] perf report: Output data file name in raw trace
 dump
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <783fdabdb6bd62114a658eb360d2772f9662a55d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNy5xERHrtldjIM8@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <00079cfd-9524-9427-9817-4f1c2eacf89f@linux.intel.com>
Date:   Fri, 2 Jul 2021 01:46:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNy5xERHrtldjIM8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.06.2021 21:36, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 30, 2021 at 06:54:51PM +0300, Alexey Bayduraev escreveu:
<SNIP>
>> @@ -2116,9 +2127,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>>  			break;
>>  
>>  		size = event->header.size;
>> -
>> -		if (size < sizeof(struct perf_event_header) ||
>> -		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
> 
> 
> The call to perf_session__process_event() will not be made if
> 
>   (size < sizeof(struct perf_event_header)
> 
> evaluates to true, with your change it is being made unconditionally,
> also before it was using that file_pos variable, set to zero and
> possibly modified by the logic in this function.
> 
> And I read just "perf report: Output data file name in raw trace", so
> when I saw this separate change to pass 'decomp->file_pos' and remove
> that 'file_pos = 0' part I scratched my head, then I read again the
> commit log messsage and there it says it also does this separate change.
> 
> Please make it separate patch where you explain why this has to be done
> this way and what previous cset this fixes, so that the
> stable@kernel.org guys pick it as it sounds like a fix.

As I understand it, file_pos is mostly used to show file offset
in dump_event(), like:

_0x17cf08_ [0x28]: event: 9

In current implementation file_pos is always 0 for _uncompressed_ events:

0 [0x28]: event: 9

Also file_pos is used to do lseek() for some user events:
PERF_RECORD_HEADER_TRACING_DATA, PERF_RECORD_AUXTRACE. etc.

As long as the compressed event container does not contain user events,
everything is fine. Currently only CPU events are compressed.

We can only fix zero offset for uncompressed events in dump_event(),
unfortunately we cannot show the original file offset because we
uncompress the entire compressed container and do not know compressed
size of each event in the container.

Thus we have 3 options:

1. Show for each uncompressed event decomp->file_pos: offset to 
   compressed container event:

    We will see a series of CPU events with the same file offset.
    This is done by this patch.

2. Show decomp->file_pos + offset in uncompressed buffer.

    We will see a series of CPU events with overlapping file offsets.
    Better is to show something like file_pos:uncompressed_pos,
    but this would require changing all calls to dump_event(). 

3. Keep 0

What in your opinion is more preferable?

> 
>> +		skip = perf_session__process_event(session, event, decomp->file_pos,
>> +						   decomp->file_path);
>> +		if (size < sizeof(struct perf_event_header) || skip < 0) {
>>  			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>>  				decomp->file_pos + decomp->head, event->header.size, event->header.type);
>>  			return -EINVAL;

Also checking of

  (size < sizeof(struct perf_event_header))

after perf_session__process_event() is incorrect.

Thanks,
Alexey

>> @@ -2149,10 +2160,12 @@ struct reader;
<SNIP>
