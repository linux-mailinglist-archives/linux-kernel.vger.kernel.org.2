Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC932402C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhBXOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:41:26 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23954 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhBXNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614173524; x=1645709524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=XgvjsOMBy0W2i8h9nrIbreu3UIpB0UjjUMV8skAtoL0=;
  b=udqcbbUYxbyau3hJAdgoCmvFBAwbVD2mX1s8jzEPGg1/01bS+IUztZSt
   3OCzRlW421Sa3gUPQRXaay2mkSRrBKmQjfGff3zmJ5kcYdhoGbVbKRa2K
   SsO2Dy3CErN4C7LW3ovCDNoGX+Tqyy/xiptI6VdnFAPUfMB2/Ksw/V1VM
   Y=;
X-IronPort-AV: E=Sophos;i="5.81,203,1610409600"; 
   d="scan'208";a="91700011"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Feb 2021 13:30:46 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 5DD37A1900;
        Wed, 24 Feb 2021 13:30:43 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.207) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Feb 2021 13:30:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v24 00/14] Subject: Introduce Data Access MONitor (DAMON)
Date:   Wed, 24 Feb 2021 14:30:05 +0100
Message-ID: <20210224133005.9265-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204153150.15948-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.207]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 16:31:36 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
[...]
> 
> Introduction
> ============
> 
> DAMON is a data access monitoring framework for the Linux kernel.  The core
> mechanisms of DAMON called 'region based sampling' and 'adaptive regions
> adjustment' (refer to 'mechanisms.rst' in the 11th patch of this patchset for
> the detail) make it
> 
>  - accurate (The monitored information is useful for DRAM level memory
>    management. It might not appropriate for Cache-level accuracy, though.),
>  - light-weight (The monitoring overhead is low enough to be applied online
>    while making no impact on the performance of the target workloads.), and
>  - scalable (the upper-bound of the instrumentation overhead is controllable
>    regardless of the size of target workloads.).
> 
> Using this framework, therefore, several memory management mechanisms such as
> reclamation and THP can be optimized to aware real data access patterns.
> Experimental access pattern aware memory management optimization works that
> incurring high instrumentation overhead will be able to have another try.
> 
> Though DAMON is for kernel subsystems, it can be easily exposed to the user
> space by writing a DAMON-wrapper kernel subsystem.  Then, user space users who
> have some special workloads will be able to write personalized tools or
> applications for deeper understanding and specialized optimizations of their
> systems.
> 

I realized I didn't introduce a good, intuitive example use case of DAMON for
profiling so far, though DAMON is not for only profiling.  One straightforward
and realistic usage of DAMON as a profiling tool would be recording the
monitoring results with callstack and visualize those by timeline together.

For example, below link shows that visualization for a realistic workload,
namely 'fft' in SPLASH-2X benchmark suite.  From that, you can know there are
three memory access bursting phases in the workload and
'FFT1DOnce.cons::prop.2()' looks responsible for the first and second hot
phase, while 'Transpose()' is responsible for the last one.  Now the programmer
can take a deep look in the functions and optimize the code (e.g., adding
madvise() or mlock() calls).

    https://damonitor.github.io/temporal/damon_callstack.png

We used the approach for 'mlock()'-based optimization of a range of other
realistic benchmark workloads.  The optimized versions achieved up to about
2.5x performance improvement under memory pressure[1].

Note: I made the uppermost two figures in above 'fft' visualization (working
set size and access frequency of each memory region by time) via the DAMON user
space tool[2], while the lowermost one (callstack by time) is made using perf
and speedscope[3].  We have no descent and totally automated tool for that yet
(will be implemented soon, maybe under perf as a perf-script[4]), but you could
reproduce that with below commands.

    $ # run the workload
    $ sudo damo record $(pidof <your_workload>) &
    $ sudo perf record -g $(pidof <your_workload>)
    $ # after your workload finished (you should also finish perf on your own)
    $ damo report wss --sortby time --plot wss.pdf
    $ damo report heats --heatmap freq.pdf
    $ sudo perf script | speedscope -
    $ # open wss.pdf and freq.pdf with our favorite pdf viewer

[1] https://linuxplumbersconf.org/event/4/contributions/548/attachments/311/590/damon_ksummit19.pdf
[2] https://lore.kernel.org/linux-mm/20201215115448.25633-8-sjpark@amazon.com/
[3] https://www.speedscope.app/
[4] https://lore.kernel.org/linux-mm/20210107120729.22328-1-sjpark@amazon.com/
