Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB34289CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhJKJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:41:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48186 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235500AbhJKJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:41:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UrPazJ3_1633945172;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UrPazJ3_1633945172)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 17:39:33 +0800
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
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <87aeef5b-c457-d4df-8abf-f9f035d73dbc@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 17:39:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWP6W7Be0Yp6egsn@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/11 下午4:48, Peter Zijlstra wrote:
> On Mon, Oct 11, 2021 at 10:32:46AM +0200, Peter Zijlstra wrote:
>> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
>> index a9f9c5714e65..ca12e2d8e060 100644
>> --- a/include/linux/trace_recursion.h
>> +++ b/include/linux/trace_recursion.h
>> @@ -214,7 +214,14 @@ static __always_inline void trace_clear_recursion(int bit)
>>  static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
>>  							 unsigned long parent_ip)
>>  {
>> -	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
>> +	bool ret;
>> +
>> +	preempt_disable_notrace();
>> +	ret = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
>> +	if (!ret)
>> +		preempt_enable_notrace();
>> +
>> +	return ret;
>>  }
>>  
>>  /**
> 
> Oh, I might've gotten that wrong, I assumed regular trylock semantics,
> but it doesn't look like that's right.

I will use bit instead ret and give some testing :-)

BTW, would you prefer to merge these changes into this patch or maybe send
another patch with your suggested-by?

Regards,
Michael Wang

> 
