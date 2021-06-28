Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443203B5A48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhF1IOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:14:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:60152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhF1IOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:14:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207851469"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="207851469"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 01:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="456227756"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.26]) ([10.249.227.26])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 01:11:28 -0700
Subject: Re: [PATCH v7 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7ciOMPTbwTzHwDp2sjn59KButCQpPOpQsqttopodGC7_kg@mail.gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <8b738198-c77e-e35e-2bc8-f709d8ec937f@linux.intel.com>
Date:   Mon, 28 Jun 2021 11:11:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciOMPTbwTzHwDp2sjn59KButCQpPOpQsqttopodGC7_kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 27.06.2021 3:46, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 22, 2021 at 1:42 AM Alexey Bayduraev
> <alexey.v.bayduraev@linux.intel.com> wrote:
>>
>> Changes in v7:
>> - fixed possible crash after out_free_threads label
>> - added missing pthread_attr_destroy() call
>> - added check of correctness of user masks
>> - fixed zsts_data finalization
>>
[SNIP]
> Thanks for your work, mostly looks good now.
> 
> I have a question, where are the synthesized records saved?
> Is it the data.0 file?

Thanks for the review.

As I understand the synthesized records (as well as other user-space
records) are saved to perf.data/data, kernel records are saved to
perf.data/data.<CPU>

Regards,
Alexey

> 
> Thanks,
> Namhyung
> 
> 
>>
>>  tools/include/linux/bitmap.h             |   11 +
>>  tools/lib/api/fd/array.c                 |   17 +
>>  tools/lib/api/fd/array.h                 |    1 +
>>  tools/lib/bitmap.c                       |   14 +
>>  tools/perf/Documentation/perf-record.txt |   30 +
>>  tools/perf/builtin-inject.c              |    3 +-
>>  tools/perf/builtin-record.c              | 1094 ++++++++++++++++++++--
>>  tools/perf/util/evlist.c                 |   16 +
>>  tools/perf/util/evlist.h                 |    1 +
>>  tools/perf/util/mmap.c                   |    6 +
>>  tools/perf/util/mmap.h                   |    6 +
>>  tools/perf/util/ordered-events.h         |    1 +
>>  tools/perf/util/record.h                 |    2 +
>>  tools/perf/util/session.c                |  500 +++++++---
>>  tools/perf/util/session.h                |    5 +
>>  tools/perf/util/tool.h                   |    3 +-
>>  16 files changed, 1508 insertions(+), 202 deletions(-)
>>
>> --
>> 2.19.0
>>
