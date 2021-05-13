Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126BB37FD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhEMSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:46:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:56429 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhEMSqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:46:40 -0400
IronPort-SDR: JqnDHtjF9iGfJ5magrdFK9mNlT689GM1kDQrkKpBodvqGRuBHTnNmmtj5lPsWUDsv8WdL/S7VX
 pUvZ5WmnsJ2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200074086"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200074086"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:45:28 -0700
IronPort-SDR: BXGgIV9FEJgGKg0+KJktBkMaR1Sz17bQQJLRnRSMiynZ+uZIeSfplsMtK2IF344ay8pzAMYskd
 QYhH0KxI3LPg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610474514"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.148.217])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:45:26 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
References: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
 <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
 <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com>
 <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
 <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com>
 <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <5366ec7a-8546-9a32-53f5-5f5a98117355@linux.intel.com>
Date:   Thu, 13 May 2021 11:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 6:59 AM, Qais Yousef wrote:
> On 05/11/21 10:25, Tim Chen wrote:
>>> update_next_balance() is only used in newidle_balance() so we could
>>> modify it to  have:
>>>
>>> next = max(jiffies+1, next = sd->last_balance + interval)
>>
>> Is the extra assignment "next = sd->last_balance + interval" needed?
>> This seems more straight forward:
>>
>> next = max(jiffies+1, sd->last_balance + interval)
> 
> I haven't been following the whole conversation closely, but it's always
> interesting when manipulating time in non time_*() functions.
> 
> Is this max() safe against wrapping?

Looking at the definition, seems like max doesn't take care of wrapping.
#define max(a, b) \
        ({ \
                typeof(a) __a = (a); \
                typeof(b) __b = (b); \
                MINMAX_ASSERT_COMPATIBLE(typeof(__a), typeof(__b)); \
                __a > __b ? __a : __b; \
        })


Probably need to do
next = time_after(jiffies+1, sd->last_balance + interval) ? jiffies+1 : sd->last_balance + interval;

Tim

