Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A61420650
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhJDHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:03:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:36898 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232983AbhJDHCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:02:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="205446684"
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="205446684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 00:00:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="621727121"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.230.47]) ([10.249.230.47])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 00:00:55 -0700
Subject: Re: [PATCH] perf report: Output non-zero offset for decompressed
 records
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
References: <20210929091445.18274-1-alexey.v.bayduraev@linux.intel.com>
 <YVqiS0lzxuVlblrN@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <6ab9dd72-ccac-4ce1-6456-ef7786911639@linux.intel.com>
Date:   Mon, 4 Oct 2021 10:00:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVqiS0lzxuVlblrN@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.10.2021 9:42, Jiri Olsa wrote:
> On Wed, Sep 29, 2021 at 12:14:45PM +0300, Alexey Bayduraev wrote:
>> Print offset of PERF_RECORD_COMPRESSED record instead of zero for
>> decompressed records in raw trace dump (-D option of perf-report):
>>
>> 0x17cf08 [0x28]: event: 9
>>
>> instead of:
>>
>> 0 [0x28]: event: 9
>>
>> The fix is not critical, because currently file_pos for compressed
>> events is used in perf_session__process_event only to show offsets
>> in the raw dump.
> 
> hi,
> I don't mind the change just curious, because I see also:
> 
>   perf_session__process_event
>     perf_session__process_user_event
>       lseek(fd, file_offset, ...
> 
> which is not raw dump as the comment suggests

Hi,

Yes, but this "lseek" only works for user events, whereas the 
PERF_RECORD_COMPRESSED record shouln't contain such events.
Currently, the PERF_RECORD_COMPRESSED container can only pack
kernel events. 

Regards,
Alexey

> 
> thanks,
> jirka
> 
>>
>> This patch was separated from patchset:
>> https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
>> and was already rewieved.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Acked-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
>> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>> ---
>>  tools/perf/util/session.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 069c2cfdd3be..352f16076e01 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -2116,7 +2116,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
>>  static int __perf_session__process_decomp_events(struct perf_session *session)
>>  {
>>  	s64 skip;
>> -	u64 size, file_pos = 0;
>> +	u64 size;
>>  	struct decomp *decomp = session->decomp_last;
>>  
>>  	if (!decomp)
>> @@ -2132,7 +2132,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>>  		size = event->header.size;
>>  
>>  		if (size < sizeof(struct perf_event_header) ||
>> -		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
>> +		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
>>  			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>>  				decomp->file_pos + decomp->head, event->header.size, event->header.type);
>>  			return -EINVAL;
>> -- 
>> 2.19.0
>>
> 
