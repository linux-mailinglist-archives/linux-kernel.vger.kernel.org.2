Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4D428967
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhJKJLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:11:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:59970 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhJKJLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:11:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226790399"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="226790399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 02:09:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="490393044"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.229.105]) ([10.249.229.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 02:09:09 -0700
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
 <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
 <YWBX+p1vtLXXbpkF@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <5e5ecfcd-57f1-1a06-4ed6-6a1e6983d1f8@linux.intel.com>
Date:   Mon, 11 Oct 2021 12:08:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWBX+p1vtLXXbpkF@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.10.2021 17:38, Jiri Olsa wrote:
> On Fri, Oct 08, 2021 at 11:42:18AM +0300, Bayduraev, Alexey V wrote:
>>
>>
>> On 08.10.2021 10:33, Jiri Olsa wrote:
>>> On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:
>>>
>>> SNIP
>>>
>>>>  static int
>>>> -reader__process_events(struct reader *rd, struct perf_session *session,
>>>> -		       struct ui_progress *prog)
>>>> +reader__read_event(struct reader *rd, struct perf_session *session,
>>>> +		   struct ui_progress *prog)

SNIP

>>>
>>> active_decomp should be set/unset within reader__process_events,
>>> not just for single event read, right?
>>
>> No, it should be set before perf_session__process_event/process_decomp_events
>> and unset after these calls. So active_decomp setting/unsetting is moved in
>> this patch to the reader__read_event function. This is necessary for multiple
>> trace reader because it could call reader__read_event in round-robin manner.
> 
> hum, is that code already in? I can't see this happening in current code

Probably I don't understand the question. In [PATCH v3 2/8] I introduced 
active_decomp pointer in perf_session. It is initialized by a pointer to the 
decompressor object in perf_session. In reader__process_events it is set to 
the reader decompressor object. And it is reset to the session decompressor 
object at exit. In this case we do not need to reset it after each 
perf_session__process_event because this code reads events in loop with 
constant reader object. Maybe setting of active_decomp should be at the 
entrance to the reader__process_events, not before reader__process_events, 
in [PATCH v3 2/8]. All this code is new.

In this patch I separates single event reading and moves setting/resetting
of active_decomp before/after perf_session__process_event because this is 
necessary for multiple trace reader. 

Regards,
Alexey

> 
> jirka
> 
>>
>> Regards,
>> Alexey
>>
>>>
>>> jirka
>>>
>>>>  	return err;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.19.0
>>>>
>>>
>>
> 
