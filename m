Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567EA354B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 05:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhDFDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 23:20:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:52945 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhDFDU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 23:20:58 -0400
IronPort-SDR: ge9IpEWk4My/BhHWvCzxs1CeK25yxkq8DIJaI3rNLxi0Ts18GVK8BPu5K8HzH9XxQYw+2Xb1UX
 FJp8BNVhWm5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193011711"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="193011711"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 20:20:51 -0700
IronPort-SDR: tqd49xEk1OsNWBfQEaejPDdRwlwAgPqRCsjmpoccixY5JszEFP1Iids7nHVPS6BZVXkrvjNgWh
 XmcszShwvjIA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421006149"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 20:20:30 -0700
Subject: Re: [PATCH v5 0/5] perf/x86: Some minor changes to support guest Arch
 LBR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     pbonzini@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, wei.w.wang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>
References: <20210326011918.183685-1-like.xu@linux.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <91102eac-a315-3165-1670-8313176657f1@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:20:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326011918.183685-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, do we have any comments on this patch set?

On 2021/3/26 9:19, Like Xu wrote:
> Hi Peter,
> 
> Please help review these minor perf/x86 changes in this patch set,
> and we need some of them to support Guest Architectural LBR in KVM.
> 
> This version keeps reserve_lbr_buffers() as is because the LBR xsave
> buffer is a per-CPU buffer, not a per-event buffer. We only need to
> allocate the buffer once when initializing the first event.
> 
> If you are interested in the KVM emulation, please check
> https://lore.kernel.org/kvm/20210314155225.206661-1-like.xu@linux.intel.com/
> 
> Please check more details in each commit and feel free to comment.
> 
> Previous:
> https://lore.kernel.org/lkml/20210322060635.821531-1-like.xu@linux.intel.com/
> 
> v4->v5 Changelog:
> - Add "Tested-by: Kan Liang"
> - Make the commit message simpler
> - Make check_msr() to ignore msr==0
> - Use kmem_cache_alloc_node() [Namhyung]
> 
> Like Xu (5):
>    perf/x86/intel: Fix the comment about guest LBR support on KVM
>    perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers
>    perf/x86: Skip checking MSR for MSR 0x000
>    perf/x86/lbr: Move cpuc->lbr_xsave allocation out of sleeping region
>    perf/x86: Move ARCH_LBR_CTL_MASK definition to include/asm/msr-index.h
> 
>   arch/x86/events/core.c           |  8 +++++---
>   arch/x86/events/intel/bts.c      |  2 +-
>   arch/x86/events/intel/core.c     |  7 +++----
>   arch/x86/events/intel/lbr.c      | 29 ++++++++++++++++++-----------
>   arch/x86/events/perf_event.h     |  8 +++++++-
>   arch/x86/include/asm/msr-index.h |  1 +
>   6 files changed, 35 insertions(+), 20 deletions(-)
> 

