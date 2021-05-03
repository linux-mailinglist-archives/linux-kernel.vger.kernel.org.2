Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD342371782
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhECPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:07:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:6839 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhECPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:07:13 -0400
IronPort-SDR: kWmLQ+c+KEZZkPzEo2nddoIb3MuZwiT4sj9qhsMt7Mv0SHHfZsTbdPt6TzAypebvXcceVE/o2O
 oq0QhvojdIYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="195704633"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="195704633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 08:06:18 -0700
IronPort-SDR: GzTOb0mUd+p6Ew2KRAhXLthHMuyCbSrrt9bABwEZzM2zHoz7tG97Dj/vW9sdXEwsM+KQL8mFcj
 UeTNFL4r1mYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="468095843"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2021 08:06:16 -0700
Subject: Re: [PATCH] perf record: Set timestamp boundary for AUX area events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210503064222.5319-1-adrian.hunter@intel.com>
 <20210503145637.GN4032392@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fecadda6-b708-f7c8-ca9a-3521f168727e@intel.com>
Date:   Mon, 3 May 2021 18:06:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503145637.GN4032392@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/05/21 5:56 pm, Andi Kleen wrote:
> On Mon, May 03, 2021 at 09:42:22AM +0300, Adrian Hunter wrote:
>> AUX area data is not processed by 'perf record' and consequently the
>>  --timestamp-boundary option may result in no values for "time of first
>> sample" and "time of last sample". However there are non-sample events
>> that can be used instead, namely 'itrace_start' and 'aux'.

"instead" -> "as well"

>> 'itrace_start' is issued before tracing starts, and 'aux' is issued
>> every time data is ready.
> 
> Hmm, what happens when some other non PT events are in the same perf record?

The sample timestamps are still processed, so the lowest sample timestamp or
'itrace_start' timestamp or 'aux' timestamp is the start.  Similarly for the end.

> And those maybe run at different times than PT (e.g. due to some PT specific
> filter).  Does this all work correctly then?

The broadest range is used
