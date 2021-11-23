Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B64459A34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhKWC4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:56:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:64043 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhKWC4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:56:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234885099"
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="234885099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 18:53:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="509227794"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 18:53:14 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <shy828301@gmail.com>,
        <zhongjiang-ali@linux.alibaba.com>, <xlpang@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH] mm: Promote slow memory in advance to improve
 performance
References: <fc80ea7998a98274447cb3be84d5ef705438a3dc.1637571100.git.baolin.wang@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 10:53:12 +0800
In-Reply-To: <fc80ea7998a98274447cb3be84d5ef705438a3dc.1637571100.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Mon, 22 Nov 2021 18:22:17 +0800")
Message-ID: <87ilwjbn1j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Some workloads access a set of data entities will follow the data locality,
> also known as locality of reference, which means the probability of accessing
> some data soon after some nearby data has been accessed.
>
> On some systems with different memory types, which will rely on the numa
> balancing to promote slow hot memory to fast memory to improve performance.
> So we can promote several sequential pages on slow memory at one time
> according to the data locality for some workloads to improve the performance.
>
> Testing with mysql can show about 5% performance improved as below.
>
> Machine: 16 CPUs, 64G DRAM, 256G AEP
>
> sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua
> --mysql-user=root --mysql-password=root --oltp-test-mode=complex
> --oltp-tables-count=65 --oltp-table-size=5000000 --threads=20 --time=600
> --report-interval=10
>
> No proactive promotion:
> transactions
> 2259245 (3765.37 per sec.)
> 2312605 (3854.31 per sec.)
> 2325907 (3876.47 per sec.)
>
> Proactive promotion bytes=16384:
> transactions
> 2419023 (4031.66 per sec.)
> 2451903 (4086.47 per sec.)
> 2441941 (4068.68 per sec.)

This is kind of readahead to promote the page before we know it's hot.
It can definitely benefit the performance if we predict correctly, but
may hurt if we predict wrongly.

Is it possible for us to add some self-adaptive algorithm like that in
readahead to determine whether to adjust the fault around window
dynamically?  A system level knob may be not sufficient to fit all
workloads run in system?

Best Regards,
Huang, Ying

> Suggested-by: Xunlei Pang <xlpang@linux.alibaba.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Note: This patch is based on "NUMA balancing: optimize memory placement
> for memory tiering system" [1] from Huang Ying.
>
> [1] https://lore.kernel.org/lkml/87bl2gsnrd.fsf@yhuang6-desk2.ccr.corp.intel.com/T/

[snip]
