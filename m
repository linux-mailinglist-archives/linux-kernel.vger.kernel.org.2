Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4675740790E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhIKP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 11:29:49 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34018 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbhIKP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 11:29:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uo.7xZj_1631374113;
Received: from 30.30.120.103(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uo.7xZj_1631374113)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Sep 2021 23:28:33 +0800
Message-ID: <de1bbbc9-3d66-a3dd-550f-509032be20ba@linux.alibaba.com>
Date:   Sat, 11 Sep 2021 23:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-3-yinan@linux.alibaba.com>
 <20210911101247.4a37ec51@rorschach.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20210911101247.4a37ec51@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my GCC version: GCC version 4.8.5 20150623 (red hat 4.8.5-44) 
(GCC) .

In fact, I see the make_nop processing in recordmcount. I'm still 
confused why this part can be directly replaced?


在 2021/9/11 下午10:12, Steven Rostedt 写道:
> On Sat, 11 Sep 2021 21:50:43 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
>
>> When ftrace is enabled, ftrace_init will consume a period of
>> time, usually around 15~20ms. Approximately 60% of the time is
>> consumed by nop-processing. Moving the nop-processing to the
>> compile time can speed up the kernel boot process.
>>
>> performance test:
>>          env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
>>          method: before and after patching, compare the
>>                  total time of ftrace_init(), and verify
>>                  the functionality of ftrace.
>>
>>          avg_time of ftrace_init:
>>                  with patch: 7.114ms
>>                  without patch: 15.763ms
> What compiler are you using? Because by default, gcc should already do
> this for you. In fact, recordmcount isn't even called with the latest
> gcc, as gcc creates mcount_loc and inserts nops.
>
> This was implemented before, but because we use to have "ideal nops"
> that was determined at run time, because the different CPUs had
> different efficiency on what nop was used, we had to do it at run time.
> But that is no longer the case today, so we can revisit this.
>
>> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
>> ---
>>   kernel/trace/ftrace.c  |  4 ++++
>>   scripts/recordmcount.h | 14 ++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index c236da868990..ae3fba331179 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6261,6 +6261,10 @@ static int ftrace_process_locs(struct module *mod,
>>   	 * until we are finished with it, and there's no
>>   	 * reason to cause large interrupt latencies while we do it.
>>   	 */
>> +#if defined CONFIG_X86 || defined CONFIG_X86_64 || defined CONFIG_ARM || defined CONFIG_ARM64
> We don't list archs in generic files. The above needs to be something like:
>
> #ifdef ARCH_HAS_MCOUNT_NOP
>
> or some name like that, and then that macro gets defined by the arch
> header (include/asm/ftrace.h)
>
>
>
>> +	ret = 0;
>> +	goto out;
>> +#endif
> space should be here.
>
>>   	if (!mod)
>>   		local_irq_save(flags);
>>   	ftrace_update_code(mod, start_pg);
> -- Steve
