Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6B3390D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCLPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:09:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:22264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhCLPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:09:34 -0500
IronPort-SDR: Ugc0D/jpEyCdLH0SNzjbwKmE/zGBJoCVNyYNxwZN8gpMJyf6INQyWFZFVsbyIJIVNhux7WCmUJ
 R1E6ZavPjffw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168758279"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="168758279"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:09:34 -0800
IronPort-SDR: lTby2jTgpVlL6h7WA/5C/RF/rZaMGkanAH6q6nnlYdgYqT6pVCydQioMJ6RuyBT8NQAvWq1+jd
 8SltHgf3aj8g==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="448644680"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:09:34 -0800
Date:   Fri, 12 Mar 2021 07:09:33 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/3] perf tools: Minor improvements in event synthesis
Message-ID: <20210312150933.GN203350@tassilo.jf.intel.com>
References: <20201221070029.1451176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221070029.1451176-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 04:00:26PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This is to optimize the event synthesis during perf record.
> 
> The first patch is to reduce memory usage when many threads are used.
> The second is to avoid unncessary syscalls for kernel threads.  And
> the last one is to reduce the number of threads to iterate when new
> threads are being created at the same time.
> 
> Unfortunately there's no dramatic improvement here but I can see ~5%
> gain in the 'perf bench internals synthesize' on a big machine.
> (The numbers are not stable though)

Looks all good to me. The VmPeak assumption might be slightly
fragile, but I guess there's nothing better currently.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
