Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2C327F99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhCANf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:35:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:52702 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhCANe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:34:58 -0500
IronPort-SDR: 3mwROtW2oImpT2UeKA3yI9prNDEVyCDfls2QBB2PkWG+ahiknVtVYrSZgAfRqwkIygf2/280If
 zh82HDL2NJcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165693921"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="165693921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 05:33:07 -0800
IronPort-SDR: GGaEyhRd3vcdCX0Nvx+OskmMNaHiwSC+BZukEPScoH2fv6AcMlt4W+2WVDfeq7s8mF8yWwefqZ
 HKqLDAhzM4/Q==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="406226018"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.70]) ([10.249.226.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 05:33:04 -0800
Subject: Re: [PATCH v3 07/12] perf record: init data file at mmap buffer
 object
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com>
 <20201120104942.GF94830@google.com>
 <64b0859f-aad3-43fa-4e4c-81614d0c75e4@linux.intel.com>
 <CAM9d7chw-i7Vx+eOPDAdyh2MPQpW=t9ueGFqUH=UcyfsNi7dUg@mail.gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <a0e7af89-416f-1aab-32e5-70adeb80a721@linux.intel.com>
Date:   Mon, 1 Mar 2021 16:33:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7chw-i7Vx+eOPDAdyh2MPQpW=t9ueGFqUH=UcyfsNi7dUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2021 14:44, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Mar 1, 2021 at 8:16 PM Bayduraev, Alexey V
> <alexey.v.bayduraev@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 20.11.2020 13:49, Namhyung Kim wrote:
>>> On Mon, Nov 16, 2020 at 03:19:41PM +0300, Alexey Budankov wrote:
>>
>> <SNIP>
>>
>>>>
>>>> @@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>>>>      /*
>>>>       * Mark the round finished in case we wrote
>>>>       * at least one event.
>>>> +     *
>>>> +     * No need for round events in directory mode,
>>>> +     * because per-cpu maps and files have data
>>>> +     * sorted by kernel.
>>>
>>> But it's not just for single cpu since task can migrate so we need to
>>> look at other cpu's data too.  Thus we use the ordered events queue
>>> and round events help to determine when to flush the data.  Without
>>> the round events, it'd consume huge amount of memory during report.
>>>
>>> If we separate tracking records and process them first, we should be
>>> able to process samples immediately without sorting them in the
>>> ordered event queue.  This will save both cpu cycles and memory
>>> footprint significantly IMHO.
>>>
>>> Thanks,
>>> Namhyung
>>>
>>
>> As far as I understand, to split tracing records (FORK/MMAP/COMM) into
>> a separate file, we need to implement a runtime trace decoder on the
>> perf-record side to recognize such tracing records coming from the kernel.
>> Is that what you mean?
> 
> No, I meant separating the mmap buffers so that the record process
> can save the data without decoding.
> 

Thanks,

Do you think this can be implemented only on the user side by creating a dummy
event and manipulating by mmap/comm/task flags of struct perf_event_attr?
Or some changes on the kernel side are necessary?

Regards,
Alexey

>>
>> IMHO this can be tricky to implement and adds some overhead that can lead
>> to possible data loss. Do you have any other ideas how to optimize memory
>> consumption on perf-report side without a runtime trace decoder?
>> Maybe "round events" would somehow help in directory mode?
>>
>> BTW In our tool we use another approach: two-pass trace file loading.
>> The first loads tracing records, the second loads samples.
> 
> Yeah, something like that.  With the separated data, we can do it
> more efficiently IMHO.
> 
> Thanks,
> Namhyung
> 
