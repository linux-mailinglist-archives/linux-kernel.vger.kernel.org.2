Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F1341334
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhCSCsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:48:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:8831 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhCSCsm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:48:42 -0400
IronPort-SDR: 9bxn5N2bizQM9kMGNPUH7M8G91aEkPqOduuiQRq9uxiOW5lXzMxg3w+7zMYoLrLcYLvFs1ZxUq
 PWw0ZIRppjSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189191512"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189191512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 19:48:32 -0700
IronPort-SDR: 0egM2ZIpY/Clb562h/dSheMwRjoccsD20Ck2Ebt0xPuvtClzzmatJ0XcgRJwReY5gxXlU1qsxa
 PM+G06UaJv0Q==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="512343375"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 19:48:32 -0700
Date:   Thu, 18 Mar 2021 19:48:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <20210319024830.GC1369306@tassilo.jf.intel.com>
References: <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
 <YFIHVQPG3TEeiOpP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIHVQPG3TEeiOpP@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While we're discussing, do we really want to use the "core" and "atom"
> terms here? I thought cpu/cycles/ would be ok for the main (Big) CPU and

Yes absolutely.

> that we should come up with some short name for the "litle" CPUs.

There actually isn't a main CPU. 

There's nothing "better" about the big cores vs the Atoms 
anyways. They're all important CPUs.

And the system might have no "big" CPUs, but we won't know
until we finished onlining all CPUs. 

Or on Lakefield there are four Atoms and only a single big core.
So with a non hybrid aware profiler tool you would miss most of the
system if we used cpu// for the big core.

Also I think renaming is a good idea because it forces the software
or configuration to handle hybrid. Otherwise you just get subtle breakage
all the time with some CPUs not getting profiled.

It's a similar strategy as we do in the source code when semantics
change.

ARM did this right.

-Andi

