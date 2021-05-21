Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36338CA73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhEUP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:56:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:29803 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhEUP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:56:08 -0400
IronPort-SDR: yuuAQPl1fgxmrPCwFWxeStgzSx4W7mmY2R6Q2soZoUS7OiSrNdCbfvEyz/G7sT/cTNC1LSVrUR
 RORWByGBo0sw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188639634"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188639634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 08:54:44 -0700
IronPort-SDR: Tl1QmfpD5rLVgLLuXdQ2brLMG5moLpC+ucnofQk/BW9q7H9we8CdajNA2E0nS5mqpXtui+qrOJ
 NIHpbgogvzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544131523"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 08:54:43 -0700
Received: from [10.209.68.82] (kliang2-MOBL.ccr.corp.intel.com [10.209.68.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 45CDB580887;
        Fri, 21 May 2021 08:54:40 -0700 (PDT)
Subject: Re: [PATCH V4 1/6] perf: Save PMU specific data in task_struct
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        vitaly.slobodskoy@intel.com, namhyung@kernel.org,
        ak@linux.intel.com
References: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
 <YKdgLP0l7+7LVhSs@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6acc7ffe-926a-86a7-edde-3833fb2ca53f@linux.intel.com>
Date:   Fri, 21 May 2021 11:54:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKdgLP0l7+7LVhSs@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2021 3:24 AM, Peter Zijlstra wrote:
> I'm replying to the whole thing squashed, because I couldn't make sense
> of the individual patches much.

Thanks for the detailed comments. The optimization suggestions would 
make the codes much simpler and more efficient.
I will modify the codes based on your suggestions and do more tests.

Thanks,
Kan
