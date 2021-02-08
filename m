Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCA313170
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBHLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:54:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:17790 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233379AbhBHLcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:32:51 -0500
IronPort-SDR: L9Pt/0YL0s4BWtTwzZe6DsrXRR6+pWHp/9Mzh+toIeX8ad6z8Ak5fscpiVCppC1S2V/xuL86xm
 cY8LorCmUEhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="266529388"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="266529388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:31:06 -0800
IronPort-SDR: wKC0xb71HFAS2oNzCVfz/ORnkv6TRYolKG6RZoIR6+w81WOg+MSC41NPQTPWv+wiBrX0RDQiha
 1Ysr64QsUqsA==
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="395350823"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.226.173]) ([10.249.226.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:31:03 -0800
Subject: Re: [PATCH v4 1/5] perf stat: Add AGGR_PCIE_PORT mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-2-alexander.antonov@linux.intel.com>
 <CAM9d7ciCGd+mkLOyJciB4Oe6XEoFyKx_=zhnK1SDnDM3=0M5NQ@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <b3cb656f-a57b-544a-67eb-3d25e85dc6b0@linux.intel.com>
Date:   Mon, 8 Feb 2021 14:30:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciCGd+mkLOyJciB4Oe6XEoFyKx_=zhnK1SDnDM3=0M5NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2021 3:07 PM, Namhyung Kim wrote:
> Hello,
>
> On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Adding AGGR_PCIE_PORT mode to be able to distinguish aggr_mode
>> for root ports in following patches.
> I'm not sure adding the AGGR_PCIE_PORT is the right way.
> In my understanding, the aggr mode is to specify how we aggregate
> counter values of a single event from different cpus.  But this seems
> to aggregate counter values from different events.  Also the new
> mode is basically the same as AGGR_GLOBAL.
>
> As you will add stat_config.iostat_run to distinguish the iostat
> command, probably we just want to use the global aggr mode
> (and it's the default!) and get rid of the AGGR_PCIE_PORT.
>
> Thoughts?
>
> Thanks,
> Namhyung
Hello Namhyung,

Actually, you are right. We aggregate counter values from different 
events of a
single IIO stack (PCIe root port) to calculate metrics for this IO stack.
But the reason is to prevent using of '-e' and '-M' options in 'iostat' mode
because it can be a reason for the mess in the output that can confuse 
users.

There is an idea to use your suggestion for this part:

status = iostat_prepare(...);
if (status < 0)
         goto out;
if (status == IOSTAT_LIST)
         iostat_list(...);
else
         ...

So, we can check if evlist is empty inside iostat_prepare(). If not, print
a warning, for example, "The -e and -M options are not supported. All chosen
events/metrics will be dropped". Then we can free of evlist by using
evlist__delete(), create new one by using evlist__new() and fill the evlist.

In this case the body of iostat_prepare() function would be:

iostat_prepare()
{
     If (!is_evlist_empty) {
         pr_warning();
         evlist__delete();
         evlist__new()
     }

     iostat_event_group();
}

It will allow to get rid of the AGGR_PCIE_PORT.
What do you think?

Thank you,
Alexander
