Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A8359604
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhDIHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:07:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:37614 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhDIHHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:07:04 -0400
IronPort-SDR: aKuhKsJkTC99Er7tBaxMDf3GnbJQKQndtk4UTrkbRlWc9td0RHMGqWQqmFK+ucE8l6IWtankzV
 2fLeh/f7Pyeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="181240341"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="181240341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 00:06:19 -0700
IronPort-SDR: gelocAWnYzeP0oV+0Ov+jSP8EkwL8iCqvaNE7BRUWoJp06FHQFJMUuxgqF9T32mBK1J5geZYCT
 tdBR58jtrPsA==
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="422604780"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.225.14]) ([10.249.225.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 00:06:12 -0700
Subject: Re: [PATCH v4 02/12] perf record: introduce thread specific data
 array
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <aff91ec1-10d8-0e18-caf4-69e82179240a@linux.intel.com>
 <20210408141617.GD3762101@tassilo.jf.intel.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <be1a7df0-866d-352f-846a-e5a73500b172@linux.intel.com>
Date:   Fri, 9 Apr 2021 10:06:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408141617.GD3762101@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.04.2021 17:16, Andi Kleen wrote:
>> +		} else {
>> +			thread_data[t].tid = syscall(SYS_gettid);
> 
> That always fills in the tid of the setup thread instead of the target
> threads?
> 

Here we set the tid for 0-thread (for cpu 0), other threads we setup
later in record__thread(), see [PATCH v4 05/12].

Regards,
Alexey
