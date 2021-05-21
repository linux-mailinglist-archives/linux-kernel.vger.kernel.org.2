Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303D38BBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhEUBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:39:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:60472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237098AbhEUBj3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:39:29 -0400
IronPort-SDR: DqB8A4w6ydflCEAYtSko6yqnTQNIAsT4S/va9yoe52hO0Yxw3eBn2w0HNj9iAJDI89nYxRmb8a
 mXuxOqDdWgyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="198295733"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198295733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:38:07 -0700
IronPort-SDR: cDcfd48o/4ngTHkg9MiVmcgTpFtIR9YpQOgTuWe1w1FuLP0np5v+fVN8qhZuESovED0F6y13by
 YywqZl78vHUg==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440836159"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:38:04 -0700
Subject: Re: [PATCH 2/4] perf vendor events: Add uncore event list for Icelake
 Server
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
References: <20210510012438.6293-1-yao.jin@linux.intel.com>
 <20210510012438.6293-3-yao.jin@linux.intel.com>
 <CAP-5=fVEM+xiPEoak4RxuEr1n3fg2ptpNczbvBrVH20U4yQRTw@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4f15e9d9-7771-8c4e-00e0-4c08410a93fa@linux.intel.com>
Date:   Fri, 21 May 2021 09:38:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVEM+xiPEoak4RxuEr1n3fg2ptpNczbvBrVH20U4yQRTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 5/21/2021 12:13 AM, Ian Rogers wrote:
> On Sun, May 9, 2021 at 6:28 PM Jin Yao<yao.jin@linux.intel.com>  wrote:
>> Add JSON uncore events for Icelake Server to perf.
>>
>> Based on JSON list v1.04
>> https://download.01.org/perfmon/ICX/
> Acked-by: Ian Rogers<irogers@google.com>
> 
> Could perf-uncore-events-icx.csv be added to:
> https://github.com/intel/event-converter-for-linux-perf
> 
> Thanks,
> Ian
> 

Sure, I will push it to the repo 'event-converter-for-linux-perf'.

Thanks
Jin Yao
