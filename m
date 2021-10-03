Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5B14201C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhJCNoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:44:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51404 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhJCNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:44:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UqNYrt8_1633268530;
Received: from 192.168.31.237(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UqNYrt8_1633268530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 03 Oct 2021 21:42:11 +0800
Message-ID: <0b783c9e-c129-6907-0637-5c7638158a65@linux.alibaba.com>
Date:   Sun, 3 Oct 2021 21:42:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-2-yinan@linux.alibaba.com>
 <20210911095937.5a298619@rorschach.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20210911095937.5a298619@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/9/11 下午9:59, Steven Rostedt 写道:
> On Sat, 11 Sep 2021 21:50:42 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
>
>> When ftrace is enabled, ftrace_init will consume a period of
>> time, usually around 15~20 ms. Approximately 40% of the time is
>> consumed by sort-processing. Moving the sort-processing to the
>> compile time can speed up the kernel boot process.
>>
> Nice. I like the idea of sorting at compile time.
Thanks !
>> performance test:
>>          env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
>>          method: before and after patching, compare the
>>                  total time of ftrace_init(), and verify
>>                  the functionality of ftrace.
>>
>>          avg_time of ftrace_init:
>>                  with patch: 8.352 ms
>>                  without patch: 15.763 ms
>>
>> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
>> ---
>>   kernel/trace/ftrace.c   |   5 ++-
>>   scripts/link-vmlinux.sh |   6 +--
>>   scripts/sorttable.c     |   2 +
>>   scripts/sorttable.h     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 115 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 7efbc8aaf7f6..c236da868990 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6189,8 +6189,9 @@ static int ftrace_process_locs(struct module *mod,
>>   	if (!count)
>>   		return 0;
>>   
>> -	sort(start, count, sizeof(*start),
>> -	     ftrace_cmp_ips, NULL);
>> +	if (mod)
> Why can't we enforce modules to be sorted too?

hi，

Sorry for my slow progress . I have encountered some problems with the 
sorting
of the module's mcount in compile time. The .ko file will be relocated 
after insmod
or modprobe, most of the mcount relocation is based on .text section, 
but there are
also a small part of mcount relocation based on .init.text section such 
as module_init().
The loading position of .init.text and .text does not seem to be in a 
definite order.

For example, when I insmod ip_tables.ko twice, the front and back 
positions of init.text
and .text are different, so we cannot sort the mcounts in the two 
sections, which makes
the mcount sorting in the module meaningless.

What is your opinion on this?

>> +		sort(start, count, sizeof(*start),
>> +		     ftrace_cmp_ips, NULL);

> Best regards! 
> ---Yinan liu 
