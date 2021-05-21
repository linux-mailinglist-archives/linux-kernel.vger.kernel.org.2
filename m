Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD638BC32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhEUCC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:02:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:26311 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236669AbhEUCCz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:02:55 -0400
IronPort-SDR: m1ezLXxe1MFeWAYjHVwnvCRE0LR3BVbPeRkvuhoT9hwzJKQN/1sKBQH0HXpcw2g92WFpxIwVkv
 s/lfJ+VlCKsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201420721"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201420721"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:01:32 -0700
IronPort-SDR: rigVA7Q/aPSiE264jR7xaZrh6RqH4tRt56/1o/KI1Zh2TuttrCfjt/wZL/76TujDv7XWRp82zK
 ge1yWtu8s5dg==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440848069"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:01:29 -0700
Subject: Re: [PATCH 3/4] perf vendor events: Add metrics for Icelake Server
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
 <20210510012438.6293-4-yao.jin@linux.intel.com>
 <CAP-5=fUWh4_vzd5QxvLvJD=R-_VFfzjs556VBtd1ZZHEnpmOxw@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cdaaf99f-d1d5-af69-9256-cd5ce0cc8034@linux.intel.com>
Date:   Fri, 21 May 2021 10:01:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUWh4_vzd5QxvLvJD=R-_VFfzjs556VBtd1ZZHEnpmOxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 5/21/2021 12:40 AM, Ian Rogers wrote:
> On Sun, May 9, 2021 at 6:26 PM Jin Yao<yao.jin@linux.intel.com>  wrote:
>> Add JSON metrics for Icelake Server to perf.
>>
>> Based on TMA metrics 4.21 at 01.org.
>> https://download.01.org/perfmon/
> Acked-by: Ian Rogers<irogers@google.com>
> 
> Could you update ratio_column here:
> https://github.com/intel/event-converter-for-linux-perf/blob/master/extract-tmam-metrics.py#L81
> as currently this can't be generated.
> 
> Thanks,
> Ian
> 

Sure, also updated for ICL. I will push the updates to the repo.

Thanks
Jin Yao
