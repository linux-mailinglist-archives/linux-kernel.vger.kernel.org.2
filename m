Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9A37542D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEFMzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:55:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:58162 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhEFMzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:55:08 -0400
IronPort-SDR: Mdol3zQXvqj/6JZgP2blUB83pwlKihDjuVY8jz79eNdXhKk1TwKHYLRoLHjkVOkzurspzV1wW3
 5myiGso0yswQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="283904167"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="283904167"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:54:08 -0700
IronPort-SDR: FeRQh2OsmYOUcKOhZDmRgF8y0Ydytfdb0EWGbxxLKjqdy0rQT9JnZYMhKouTlMiXzMgcJwMqt3
 BGkjup2pxlKQ==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="434336194"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.254.214.82]) ([10.254.214.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:54:05 -0700
Subject: Re: [PATCH 00/19] sched: Core Scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20210422120459.447350175@infradead.org>
 <a49ea23a-998e-2282-4c93-5c6c94f2c28d@linux.intel.com>
 <YJPFA/s44ChuGV9+@hirez.programming.kicks-ass.net>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <d9f72764-2766-d663-4343-a7d5d0a9145f@linux.intel.com>
Date:   Thu, 6 May 2021 20:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <YJPFA/s44ChuGV9+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/6 18:29, Peter Zijlstra wrote:
> On Fri, Apr 30, 2021 at 02:47:00PM +0800, Ning, Hongyu wrote:
>> Adding sysbench/uperf/wis performance results for reference:
>>
>> - kernel under test:
>> 	-- above patchset of core-scheduling + local fix for softlockup issue: https://lore.kernel.org/lkml/5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com/
>> 	-- coresched_v10 kernel source: https://github.com/digitalocean/linux-coresched/commits/coresched/v10-v5.10.y
> 
> Shall I summarize all this as:
> 
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> 
> ?
> 

Yes, that would be great.

Regards,
Hongyu
