Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE95C429D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhJLFxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:53:19 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55965 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbhJLFxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:53:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UrXy.sr_1634017873;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UrXy.sr_1634017873)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 13:51:14 +0800
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
 <20211008200328.5b88422d@oasis.local.home>
 <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
 <YWP2rtX9Ol9dZc/l@hirez.programming.kicks-ass.net>
 <YWP6W7Be0Yp6egsn@hirez.programming.kicks-ass.net>
 <87aeef5b-c457-d4df-8abf-f9f035d73dbc@linux.alibaba.com>
 <20211011144510.GE174703@worktop.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <d544af7d-60c2-bc3e-c7e4-eb26d5d7a836@linux.alibaba.com>
Date:   Tue, 12 Oct 2021 13:51:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011144510.GE174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/11 下午10:45, Peter Zijlstra wrote:
[snip]
>>>
>>> Oh, I might've gotten that wrong, I assumed regular trylock semantics,
>>> but it doesn't look like that's right.
>>
>> I will use bit instead ret and give some testing :-)
>>
>> BTW, would you prefer to merge these changes into this patch or maybe send
>> another patch with your suggested-by?
> 
> Yeah, please send another patch; once you've confirmed it actually works
> etc.. I did this before waking (as evidence per the above), who knows
> what else I did wrong :-)

I've send the:
  [PATCH 0/2] ftrace: make sure preemption disabled on recursion testing

should have taking care all the places, but only testing with x86 since I
got no machine for other arch... just by logically it should be fine.

Regards,
Michael Wang

> 
