Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B7416A75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbhIXDi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:38:29 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39977 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243927AbhIXDi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:38:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UpOFzWH_1632454613;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UpOFzWH_1632454613)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Sep 2021 11:36:54 +0800
Subject: Re: [RFC PATCH] trace: prevent preemption in
 perf_ftrace_function_call()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
 <20210923093359.30da8ba6@gandalf.local.home>
 <7f4dfb4a-d271-b3c5-f603-06cc789ba9e9@linux.alibaba.com>
 <20210923232619.50103473@oasis.local.home>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <d82068a0-8bb0-b824-49f4-c7f55525ac95@linux.alibaba.com>
Date:   Fri, 24 Sep 2021 11:36:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923232619.50103473@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/24 上午11:26, Steven Rostedt wrote:
> On Fri, 24 Sep 2021 10:08:10 +0800
> 王贇 <yun.wang@linux.alibaba.com> wrote:
> 
>> I found the rcu tree implementation of rcu_is_watching() will check
>> this_cpu_ptr(&rcu_data.dynticks), and after that enable the preemption.
>>
>> If preemption happened after that and before we disable here, there are
>> still possibility that the CPU changed and make the dynticks checking
>> invalid, isn't it?
> 
> If it can be scheduled, then RCU is definitely watching ;-)
> 
> The rcu_is_watching() is a safe guard for places that are in between
> context switches. Not task context switches, but transitioning between
> kernel and user space, or going into or out of idle, or transitioning
> in and out of an interrupt.  There are small critical sections that RCU
> is not watching, and we are actually working on making those locations
> disable instrumentation (like tracing), where rcu_is_watching() will no
> longer be needed.

Thanks for the explain :-)

Context available for scheduling should not in these situations, will
move down the 'disable' in v2.

Regards,
Michael Wang

> 
> -- Steve
> 
