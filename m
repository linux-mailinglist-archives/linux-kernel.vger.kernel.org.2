Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407F359C57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhDIKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:51:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:54902 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIKvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:51:46 -0400
IronPort-SDR: 6eyYdeaDwIhqj7qqA3lxn18XHED/ouar6lKjTJkDRwYCLq4ybDAkQlgtGD+UZSALz3T+2hr1X6
 JqYVj50Okrdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="255069950"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="255069950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:51:33 -0700
IronPort-SDR: BBtZdL5qqfnogUc9Dx77+46WVpawwncotU06mOGr4qI2Rz4kd7m6T2IkRJcSkh8SwTeJz+Gl4I
 dROXbvfXpI0Q==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416214731"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.225.14]) ([10.249.225.14])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:51:30 -0700
Subject: Re: [PATCH v4 00/12] Introduce threaded trace streaming for basic
 perf record operation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <YG97FgUuqp/fCH0a@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <eea4170f-a9d1-61c3-90af-bca27bbf6bdc@linux.intel.com>
Date:   Fri, 9 Apr 2021 13:51:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG97FgUuqp/fCH0a@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.04.2021 0:52, Jiri Olsa wrote:
> On Tue, Apr 06, 2021 at 11:37:26AM +0300, Bayduraev, Alexey V wrote:
>>
>> Changes in v4:
>> - renamed 'comm' structure to 'pipes'
>> - moved thread fd/maps messages to verbose=2
>> - fixed leaks during allocation of thread_data structures
>> - fixed leaks during allocation of thread masks
>> - fixed possible fails when releasing thread masks
>>
>> v3: https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/
> 
> hi,
> I recall there was some issue wrt threading and intel_pt,
> which we either need to fixed or we need to disable threads
> for it
> 
> 	[root@krava perf]# ./perf record -e intel_pt// --threads=cpu
> 	^C[ perf record: Woken up 121 times to write data ]
> 	Warning:
> 	AUX data lost 95 times out of 206!
> 
> 	[ perf record: Captured and wrote 211.364 MB perf.data ]
> 
> 	[root@krava perf]# ./perf script
> 	Segmentation fault (core dumped)
> 
> the fix should already be in the perf/record_threads branch,

Thanks,

As I can see, the fix from perf/record_threads is partially here,
except changes in util/auxtrace.c and setting one_mmap_addr/offset.
I will fix this.

I also try to refactor patches 11 and 12.

Regards,
Alexey

> 
> jirka
> 
